{
 Mark-V
 Copyright © 2022 m.matsubara

 Released under the MIT license.
 see https://opensource.org/licenses/MIT

 The inherits function is:
 ISC license | https://github.com/isaacs/inherits/blob/master/LICENSE
}

unit ufmMarkV;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.OleCtrls, SHDocVw, Vcl.Buttons,
  Vcl.ExtCtrls, Winapi.WebView2, Winapi.ActiveX, Vcl.Edge, Vcl.ExtDlgs;

type
  TfrmMarkV = class(TForm)
    Panel1: TPanel;
    btReload: TSpeedButton;
    btPriv: TSpeedButton;
    btNext: TSpeedButton;
    btPrint: TSpeedButton;
    btnOpenDocument: TSpeedButton;
    OpenDialog: TOpenTextFileDialog;
    timerReload: TTimer;
    WebBrowser: TEdgeBrowser;
    btChangeCSS: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btReloadClick(Sender: TObject);
    procedure btPrivClick(Sender: TObject);
    procedure btNextClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btPrintClick(Sender: TObject);
    procedure btnOpenDocumentClick(Sender: TObject);
    procedure timerReloadTimer(Sender: TObject);
    procedure WebBrowserNewWindowRequested(Sender: TCustomEdgeBrowser;
      Args: TNewWindowRequestedEventArgs);
    procedure btChangeCSSClick(Sender: TObject);
  private
    { Private 宣言 }
    m_sTempDir: String;
    m_sxFiles: TArray<String>;
    m_nFileIdx: Integer;
    m_dtFileAge: TDateTime;
    m_bDarkMode: Boolean;

    procedure DropFiles(var Msg:TWMDropFiles); message WM_DROPFILES;
  public
    { Public 宣言 }

    procedure LoadFile(sFileName: String);
    procedure ChangeView(nShift: Integer);
    procedure UpdateEnableControls;
  end;

var
  frmMarkV: TfrmMarkV;

// Microsoft Edge WebView2Runtime がインストールされているか確認する
function CheckWebView2Runtime: Boolean;
// Microsoft Edge WebView2Runtime をインストールする
procedure InstallWebView2Runtime;

implementation

{$R *.dfm}

uses
  System.IOUtils
  , System.StrUtils
  , Winapi.ShellAPI
  , System.Win.Registry
  ;

resourcestring
  r_sConfirmWebView2RuntimeInstall = 'This application requires Microsoft Edge WebView2 Runtime. Are you sure you want to install it?';
//*  r_sConfirmWebView2RuntimeInstall = 'このアプリケーションには、Microsoft Edge WebView2 Runtime が必要です。インストールしてよろしいですか？。';
  r_sRerunMessage = 'Re-run after installing Microsoft Edge Webview2 Runtime.';
//*  r_sRerunMessage = 'Microsoft Edge Webview2 Runtime インストール後に再実行してください。';

//  テンポラリパスの取得
function GetTempDir: String;
var
  nLength: Integer;
  sDir: String;
begin
  //文字列を格納するのに必要なサイズを取得
  nLength := GetTempPath(0, nil);
  if nLength > 0 then
  begin
    SetLength(sDir, nLength);
    nLength := GetTempPath(nLength, PChar(sDir));
    SetLength(sDir, nLength);
    Result := sDir;
  end
  else
    raise Exception.Create('Filure get temporary directory.');
end;

// Microsoft Edge WebView2Runtime がインストールされているか確認する
function CheckWebView2Runtime: Boolean;
begin
  var Registry := TRegistry.Create;
  Registry.RootKey := HKEY_LOCAL_MACHINE;
{$ifdef WIN64}
  // X86-64
  var sKeyName := 'SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate\Clients\{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}';
{$else}
  // X86 … 2022/03/27 時点では提供されない。
  var sKeyName := 'SOFTWARE\Microsoft\EdgeUpdate\Clients\{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}';
{$endif}
  Result := Registry.KeyExists(sKeyName);
end;

// Microsoft Edge WebView2Runtime をインストールする
procedure InstallWebView2Runtime;
begin
  if (MessageDlg(r_sConfirmWebView2RuntimeInstall, mtConfirmation, [mbOK, mbCancel], 0) = mrOk) then
  begin
    MessageDlg(r_sRerunMessage, TMsgDlgType.mtInformation, [mbOK], 0);
    ShellExecute(0, PWideChar('open'), PWideChar('install_webview2.bat'), nil, nil, SW_MINIMIZE);
  end;
end;

// マークダウンファイルを開く
// ← → ボタンで別のマークダウンファイルを開けるように同じフォルダにあるマークダウンファイルの一覧も生成する
procedure TfrmMarkV.LoadFile(sFileName: String);
begin
  // 同じフォルダにある他のマークダウンファイルを列挙する
  var sFilePath := ExtractFilePath(sFileName);
  m_sxFiles := TDirectory.GetFiles(sFilePath, '*.md', TSearchOption.soTopDirectoryOnly);
  // 指定されたファイルが、配列中で何番目かを判定する

  // 完全一致で配列中からファイル名を検索する
  m_nFileIdx := -1;
  for var nIdx := 0 to Length(m_sxFiles) - 1 do
  begin
    var sFile := m_sxFiles[nIdx];
    if (sFile = sFileName) then
    begin
      m_nFileIdx := nIdx;
      break;
    end;
  end;
  // 完全一致で配列中からファイル名が見つからない場合、大文字小文字無視で配列中から検索する
  if (m_nFileIdx = -1) then
  begin
    for var nIdx := 0 to Length(m_sxFiles) - 1 do
    begin
      var sFile := m_sxFiles[nIdx];
      if (CompareText(sFile, sFileName) = 0) then
      begin
        m_nFileIdx := nIdx;
        break;
      end;
    end;
  end;
  if (m_nFileIdx >= 0) then
    ChangeView(0);
end;

// m_sxFiles 配列中のマークダウンファイルを読み込む
//  nShift: 配列インデックスの移動量
procedure TfrmMarkV.ChangeView(nShift: Integer);
begin
  if (m_nFileIdx < 0) then
    exit; // TODO エラー処理
  Inc(m_nFileIdx, nShift);

  // 実行ファイルのパス（jsやcssを読み込む起点）
  var sExePath := ExtractFilePath(Application.ExeName);
  // マークダウンファイル
  var sFileName := m_sxFiles[m_nFileIdx];
  // マークダウンファイルの内容
  var ssMdContents: TStrings := nil;
  // HTMLファイルの内容(marked を使ってマークダウンファイルを表示するための一時HTMLファイル)
  var ssHtmlContents: TStrings := nil;
  try
    // CSS ファイル名（フォルダ名含まず）
    var sCssFileName: String;
    if (m_bDarkMode) then
      sCssFileName := 'github-markdown-dark.css'
    else
      sCssFileName := 'github-markdown-light.css';

    // marked を使ってマークダウンを HTML に変換して表示するための一時HTMLファイルを生成する。
    ssMdContents := TStringList.Create;
    ssHtmlContents := TStringList.Create;
    ssMdContents.LoadFromFile(sFileName, TEncoding.UTF8);
    m_dtFileAge := TFile.GetLastWriteTime(sFileName);
    ssHtmlContents.Add(
//      '<!-- saved from url=(0021)https://a5m2.mmatsubara.com -->'#10  // この行があると、ローカルで開く前提のファイルとなり、IEを開く際のスクリプトの確認（警告）表示が出なくなる。
      '<!doctype html> '#10
      + '<html> '#10
      + '<head> '#10
      + '  <meta charset="utf-8"/> '#10
      + '  <title>Mark-V Markdown Viewer</title> '#10
      + '  <base href="' + sFileName + '">'
      + '  <script src="' + sExePath + 'js/marked.min.js"></script> '#10
      + '  <link href="' + sExePath + 'css/' + sCssFileName + '" rel="stylesheet"></link> '#10
      + '</head> '#10
      + '<body> '#10
      + '<div id="content" style="margin:0px 30px"> '#10
    );
    ssHtmlContents.AddStrings(ssMdContents);
    ssHtmlContents.Add(
      '</div> '#10
      + '<script>document.getElementById("content").innerHTML = marked(document.getElementById("content").innerHTML);</script> '#10
      + '</body> '#10
      + '</html> '
    );
    var sHtmlFileName := m_sTempDir + '\Mark-V.html';
    ssHtmlContents.SaveToFile(sHtmlFileName, TEncoding.UTF8);

    WebBrowser.Navigate(sHtmlFilename);
    Self.Caption := 'Mark-V - ' + sFileName;
  finally
    FreeAndNil(ssMdContents);
    FreeAndNil(ssHtmlContents);
    UpdateEnableControls;
  end;
end;

// 押下可能なボタンの制御
procedure TfrmMarkV.UpdateEnableControls;
begin
  btReload.Enabled := m_nFileIdx <> -1;
  btPriv.Enabled := m_nFileIdx > 0;
  btNext.Enabled := m_nFileIdx < Length(m_sxFiles) - 1;
end;

// WebBrowser コンポーネントにマークダウンファイルをドラッグ＆ドロップされたときにファイルを読み込む
procedure TfrmMarkV.WebBrowserNewWindowRequested(Sender: TCustomEdgeBrowser;
  Args: TNewWindowRequestedEventArgs);
var
  pcxUri: PWideChar;
begin
  Args.ArgsInterface.Get_uri(pcxUri);
  var sUri: String := pcxUri;
  if (sUri.StartsWith('file:///') and sUri.EndsWith('.md')) then
  begin
    sUri := Copy(sUri, 9, Length(sUri) - 1);
    sUri := ReplaceStr(sUri, '/', '\');

    LoadFile(sUri);
    Args.ArgsInterface.Set_Handled(1);
  end;
end;

// ツールバーなどにマークダウンファイルをドラッグ＆ドロップされたときにファイルを読み込む
procedure TfrmMarkV.DropFiles(var Msg: TWMDropFiles);
var
  cxFileName: array [0..255] of Char;
begin
  var nDropFileCount := DragQueryFile(Msg.Drop, Cardinal(-1), nil, 0);
  if (nDropFileCount > 0) then
  begin
    DragQueryFile(Msg.Drop, 0, cxFileName, SizeOf(cxFileName) - 1);
    LoadFile(cxFileName);
  end;
  DragFinish(Msg.Drop);
end;

procedure TfrmMarkV.FormCreate(Sender: TObject);
var
  sFileName: String;
begin
  WebBrowser.Align := alClient;

  // 変数初期化
  m_nFileIdx := -1;
  m_sTempDir := GetTempDir;

  // レジストリの設定値取得
  var Registry: TRegistry;
  try
    Registry := TRegistry.Create;
    Registry.RootKey := HKEY_CURRENT_USER;
    Registry.OpenKey('Software\mmatsubara\Mark-V', True);
    if (Registry.ValueExists('Darkmode')) then
    begin
      m_bDarkMode := Registry.ReadBool('Darkmode');
    end
    else
      m_bDarkMode := False; // TODO OSの状態から取得するようにする
  finally
    FreeAndNil(Registry);
  end;

  // テンポラリディレクトリを作成
  if (m_sTempDir[Length(m_sTempDir)] = '\') then
    m_sTempDir := Copy(m_sTempDir, 1, Length(m_sTempDir) - 1);
  m_sTempDir := m_sTempDir + '\Mark-V';
  if (DirectoryExists(m_sTempDir) = False) then
    MkDir(m_sTempDir);

  // 起動オプションとしてファイルが指定されていたら開く
  if (ParamCount >= 1) then
  begin
    sFileName := ParamStr(1);
  end;
  if (sFileName <> '') then
    LoadFile(sFileName);
  UpdateEnableControls;

  // ドラッグ＆ドロップの設定（ツールバーなど）
  DragAcceptFiles(Self.Handle, True);
end;


procedure TfrmMarkV.FormDestroy(Sender: TObject);
begin
  // レジストリの設定値取得
  var Registry: TRegistry;
  try
    Registry := TRegistry.Create;
    Registry.RootKey := HKEY_CURRENT_USER;
    Registry.OpenKey('Software\mmatsubara\Mark-V', True);
    Registry.WriteBool('Darkmode', m_bDarkMode);
  finally
    FreeAndNil(Registry);
  end;
end;

procedure TfrmMarkV.timerReloadTimer(Sender: TObject);
begin
  // 読み込んでいるファイルが変更されたら自動でリロードする
  // TODO リロードボタン要らない？
  if (m_nFileIdx >= 0) then
  begin
    try
      var dtFileAge := TFile.GetLastWriteTime(m_sxFiles[m_nFileIdx]);
      if (dtFileAge <> m_dtFileAge) then
        ChangeView(0);
    except
      // ファイルが存在しなかった時などにエラーが発生する
    end;
  end;
end;

procedure TfrmMarkV.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  // 左右ボタンの押下で同じフォルダにあるマークダウンファイルを移動する
  if (Key = VK_LEFT) then
  begin
    if (m_nFileIdx > 0) then
      ChangeView(-1);
  end
  else if (Key = VK_RIGHT) then
  begin
    if (m_nFileIdx < Length(m_sxFiles) - 1) then
      ChangeView(1);
  end;
end;

procedure TfrmMarkV.btChangeCSSClick(Sender: TObject);
begin
  m_bDarkMode := not m_bDarkMode;
  ChangeView(0);
end;

procedure TfrmMarkV.btNextClick(Sender: TObject);
begin
  ChangeView(1);
end;

procedure TfrmMarkV.btnOpenDocumentClick(Sender: TObject);
begin
  if (OpenDialog.Execute) then
  begin
    LoadFile(OpenDialog.FileName);
  end;
end;

procedure TfrmMarkV.btPrintClick(Sender: TObject);
//var
//  vaIn, vaOut: OleVariant;
begin
{
  WebBrowser.ControlInterface.ExecWB（
    OLECMDID_PRINT,OLECMDEXECOPT_DONTPROMPTUSER,vaIn,vaOut）;
}
end;

procedure TfrmMarkV.btPrivClick(Sender: TObject);
begin
  ChangeView(-1);
end;

procedure TfrmMarkV.btReloadClick(Sender: TObject);
begin
  ChangeView(0);
end;

end.
