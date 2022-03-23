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
  private
    { Private 宣言 }
    m_sTempDir: String;
    m_sxFiles: TArray<String>;
    m_nFileIdx: Integer;
    m_nFileAge: Integer;

    procedure DropFiles(var Msg:TWMDropFiles); message WM_DROPFILES;
  public
    { Public 宣言 }

    procedure LoadFile(sFileName: String);
    procedure ChangeView(nShift: Integer);
    procedure UpdateEnableControls;
  end;

var
  frmMarkV: TfrmMarkV;

implementation

{$R *.dfm}

uses
  System.IOUtils
  , System.StrUtils
  , Winapi.ShellAPI
  ;

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

procedure TfrmMarkV.LoadFile(sFileName: String);
begin
  var sFilePath := ExtractFilePath(sFileName);
  m_sxFiles := TDirectory.GetFiles(sFilePath, '*.md', TSearchOption.soTopDirectoryOnly);
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

procedure TfrmMarkV.timerReloadTimer(Sender: TObject);
begin
  if (m_nFileIdx >= 0) then
  begin
    var nFileAge := FileAge(m_sxFiles[m_nFileIdx]);
    if (nFileAge <> m_nFileAge) then
      ChangeView(0);
  end;
end;

procedure TfrmMarkV.ChangeView(nShift: Integer);
begin
  if (m_nFileIdx < 0) then
    exit; // TODO エラー処理
  Inc(m_nFileIdx, nShift);

  var sExePath := ExtractFilePath(Application.ExeName);
  var sFileName := m_sxFiles[m_nFileIdx];
  var ssMdContents: TStrings;
  var ssHtmlContents: TStrings;
  try
    ssMdContents := TStringList.Create;
    ssHtmlContents := TStringList.Create;
    ssMdContents.LoadFromFile(sFileName, TEncoding.UTF8);
    m_nFileAge := FileAge(sFileName);
    ssHtmlContents.Add(
//      '<!-- saved from url=(0021)https://a5m2.mmatsubara.com -->'#10  // この行があると、ローカルで開く前提のファイルとなり、IEを開く際のスクリプトの確認（警告）表示が出なくなる。
      '<!doctype html> '#10
      + '<html> '#10
      + '<head> '#10
      + '  <meta charset="utf-8"/> '#10
      + '  <title>Mark-V Markdown Viewer</title> '#10
      + '  <base href="' + sFileName + '">'
      + '  <script src="' + sExePath + 'js/marked.min.js"></script> '#10
      + '  <link href="' + sExePath + 'css/markdown.css" rel="stylesheet"></link> '#10
//      + '  <link href="https://raw.githubusercontent.com/simonlc/Markdown-CSS/master/markdown.css" rel="stylesheet"></link> '#10
      + '</head> '#10
      + '<body> '#10
      + '<div id="content"> '#10
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

procedure TfrmMarkV.UpdateEnableControls;
begin
  btReload.Enabled := m_nFileIdx <> -1;
  btPriv.Enabled := m_nFileIdx > 0;
  btNext.Enabled := m_nFileIdx < Length(m_sxFiles) - 1;
end;

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

  m_nFileIdx := -1;
  m_sTempDir := GetTempDir;
  if (m_sTempDir[Length(m_sTempDir)] = '\') then
    m_sTempDir := Copy(m_sTempDir, 1, Length(m_sTempDir) - 1);
  m_sTempDir := m_sTempDir + '\Mark-V';

  if (DirectoryExists(m_sTempDir) = False) then
    MkDir(m_sTempDir);

  if (ParamCount >= 1) then
  begin
    sFileName := ParamStr(1);
  end;
  if (sFileName <> '') then
    LoadFile(sFileName);
  UpdateEnableControls;
  DragAcceptFiles(Self.Handle, True);
end;



procedure TfrmMarkV.FormDestroy(Sender: TObject);
begin
//
end;

procedure TfrmMarkV.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
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
