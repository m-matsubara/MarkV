program MarkV;

uses
  Vcl.Forms,
  ufmMarkV in 'ufmMarkV.pas' {frmMarkV};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMarkV, frmMarkV);
  Application.Run;
end.
