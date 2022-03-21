{
 Mark-V
 Copyright © 2022 m.matsubara

 Released under the MIT license.
 see https://opensource.org/licenses/MIT

 The inherits function is:
 ISC license | https://github.com/isaacs/inherits/blob/master/LICENSE
}

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
