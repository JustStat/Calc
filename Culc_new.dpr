program Culc_new;

uses
  Vcl.Forms,
  New_CULC in 'New_CULC.pas' {MainF};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainF, MainF);
  Application.Run;
end.
