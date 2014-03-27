unit New_CULC;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus;

type
  TCalcAction = (caNone, caPLUS, caMINUS, caMUL, caDIV, caSQRT,
    caPERCENT, caRAVNO);

  TCalcResultType = Extended;

  TMainF = class(TForm)
    Button7: TButton;
    Button5: TButton;
    Button0: TButton;
    Button8: TButton;
    ButtonDOT: TButton;
    Button3: TButton;
    ButtonOPOSE: TButton;
    Button2: TButton;
    Button1: TButton;
    Button4: TButton;
    Button9: TButton;
    ButtonSQRT: TButton;
    ButtonDIV: TButton;
    ButtonMULT: TButton;
    ButtonMINUS: TButton;
    ButtonPERS: TButton;
    ButtonDROB: TButton;
    ButtonEQUAL: TButton;
    ButtonREMOVE: TButton;
    ButtonCE: TButton;
    ButtonPLUS: TButton;
    ButtonC: TButton;
    Button6: TButton;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    EditResult: TEdit;
    OPERATIONEdit: TEdit;
    procedure ButtonNumClick(Sender: TObject);
    procedure ButtonCEClick(Sender: TObject);
    procedure EditResultKeyPress(Sender: TObject; var Key: Char);
    procedure FormClick(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure ButtonActionClick(Sender: TObject);
    procedure ButtonSQRTClick(Sender: TObject);
    procedure ButtonEQUALClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonCClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CurrentCalcAction: TCalcAction;
    A, B: TCalcResultType;
    ravno: boolean;
    procedure SetEditFocus;
    function DoCalc(CalcAction: TCalcAction): TCalcResultType;
    function DoButtonPress(ButtonAction: TCalcAction): TCalcResultType;
  end;

var
  MainF: TMainF;

implementation

{$R *.dfm}

procedure TMainF.ButtonNumClick(Sender: TObject);
begin
  EditResult.Text := EditResult.Text + (Sender as TButton).Caption;
  SetEditFocus;
end;

procedure TMainF.ButtonSQRTClick(Sender: TObject);
begin
  DoButtonPress(caSQRT);
  EditResult.Text := '1';
  ButtonEQUALClick(nil);
end;

procedure TMainF.ButtonActionClick(Sender: TObject);
begin
  DoButtonPress(TCalcAction((Sender as TButton).Tag));
  if (Sender as TButton).Tag = 1 then
    OPERATIONEdit.Text := OPERATIONEdit.Text + '+';
  if (Sender as TButton).Tag = 2 then
    OPERATIONEdit.Text := OPERATIONEdit.Text + '-';
  if (Sender as TButton).Tag = 3 then
    OPERATIONEdit.Text := OPERATIONEdit.Text + '*';
  if (Sender as TButton).Tag = 4 then
    OPERATIONEdit.Text := OPERATIONEdit.Text + '/';
  SetEditFocus;
  ravno := false;
end;

procedure TMainF.ButtonCEClick(Sender: TObject);
begin
  EditResult.Clear;
end;

procedure TMainF.ButtonCClick(Sender: TObject);
begin
  OPERATIONEdit.Clear;
  EditResult.Clear;
  A := 0;
  B := 0;
  ravno := false;
  SetEditFocus;
end;

procedure TMainF.ButtonEQUALClick(Sender: TObject);
begin
  if (EditResult.Text <> '') and (EditResult.Text <> '0') then
  begin
    EditResult.Text := floattostr(DoButtonPress(CurrentCalcAction));
    OPERATIONEdit.Clear;
    SetEditFocus;
  end;
 { if CurrentCalcAction <> caNone then
  begin
    EditResult.Text := floattostr(A);
    OPERATIONEdit.Text := copy(OPERATIONEdit.Text, 1,
      length(OPERATIONEdit.Text) - 1);
    OPERATIONEdit.Text := OPERATIONEdit.Text + '=';
    EditResult.Text := floattostr(A);
  end;}
  ravno := true;

end;

procedure TMainF.SetEditFocus;
begin
  EditResult.setfocus;
  EditResult.SelStart := length(EditResult.Text);
  EditResult.SelLength := 0;
end;

function TMainF.DoButtonPress(ButtonAction: TCalcAction): TCalcResultType;
begin
  if ravno then
  begin
    A := strtofloat(EditResult.Text);
    OPERATIONEdit.Text := (floattostr(A));
    Result := DoCalc(CurrentCalcAction);
    A := Result;
  end
  else
  begin
    if CurrentCalcAction = caNone then
    begin
      if not ravno then
      begin
        A := strtofloat(EditResult.Text);
        OPERATIONEdit.Text := (floattostr(A));
      end;
    end
    else
    begin
      if EditResult.Text <> '' then
      begin
        B := strtofloat(EditResult.Text);
        OPERATIONEdit.Text := OPERATIONEdit.Text + floattostr(B);
        Result := DoCalc(CurrentCalcAction);
        A := Result;
      end;
    end;
  end;
CurrentCalcAction := ButtonAction;
EditResult.Clear;
ravno := false;
end;

function TMainF.DoCalc(CalcAction: TCalcAction): TCalcResultType;
begin
  case CalcAction of
    caNone:
      exit(0);
    caPLUS:
      exit(A + B);
    caMINUS:
      exit(A - B);
    caMUL:
      exit(A * B);
    caDIV:
      begin
        exit(A / B);
      end;
    caSQRT:
      exit(sqrt(A));
    caPERCENT:
      ;
  end;

end;

procedure TMainF.FormClick(Sender: TObject);
begin
  EditResult.setfocus;
end;

procedure TMainF.FormCreate(Sender: TObject);
begin
  EditResult.Text := '0';
  ravno := false;
end;

procedure TMainF.N3Click(Sender: TObject);
begin
  close;
end;

procedure TMainF.EditResultKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #43 then
  begin
    DoButtonPress(caPLUS);
    OPERATIONEdit.Text := OPERATIONEdit.Text + '+';
  end;
  if Key = #45 then
  begin
    DoButtonPress(caMINUS);
    OPERATIONEdit.Text := OPERATIONEdit.Text + '-';
  end;
  if Key = #47 then
  begin
    DoButtonPress(caDIV);
    OPERATIONEdit.Text := OPERATIONEdit.Text + '/';
  end;
  if Key = #42 then
  begin
    DoButtonPress(caMUL);
    OPERATIONEdit.Text := OPERATIONEdit.Text + '*';
  end;

  if Key = #13 then
    ButtonEQUALClick(nil);
  if not(Key in ['0' .. '9', #8, ',', '.']) then
    Key := #0;
  if Key in [',', '.'] then
    Key := ',';

end;
// test com.

end.
