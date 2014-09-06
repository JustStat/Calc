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
    MFile: TMenuItem;
    MHistory: TMenuItem;
    MExit: TMenuItem;
    MHelp: TMenuItem;
    EditResult: TEdit;
    OPERATIONEdit: TEdit;
    procedure ButtonNumClick(Sender: TObject);
    procedure ButtonCEClick(Sender: TObject);
    procedure EditResultKeyPress(Sender: TObject; var Key: Char);
    procedure FormClick(Sender: TObject);
    procedure MExitClick(Sender: TObject);
    procedure ButtonActionClick(Sender: TObject);
    procedure ButtonSQRTClick(Sender: TObject);
    procedure ButtonEQUALClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonCClick(Sender: TObject);
    procedure ButtonOPOSEClick(Sender: TObject);
    procedure ButtonDROBClick(Sender: TObject);
    procedure ButtonDOTClick(Sender: TObject);
    procedure ButtonREMOVEClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CurrentCalcAction: TCalcAction;
    A, B: TCalcResultType;
    i, ErrorType: integer;
    procedure SetEditFocus;
    function DoCalc(CalcAction: TCalcAction): TCalcResultType;
    function DoButtonPress(ButtonAction: TCalcAction): TCalcResultType;
    procedure Error;
  end;

var
  MainF: TMainF;

implementation

{$R *.dfm}

procedure TMainF.ButtonNumClick(Sender: TObject);
begin
  if EditResult.Text = '0' then
    EditResult.Clear;
  EditResult.Text := EditResult.Text + (Sender as TButton).Caption;
  SetEditFocus;
end;

procedure TMainF.ButtonOPOSEClick(Sender: TObject);
begin
  try
    EditResult.Text := floattostr(-strtofloat(EditResult.Text));
  except
    Error;

  end;
end;

procedure TMainF.ButtonREMOVEClick(Sender: TObject);
begin

EditResult.text:=Copy(EditResult.text, 1, length(EditResult.text)-1);
end;

procedure TMainF.ButtonSQRTClick(Sender: TObject);
begin
  try
    EditResult.Text := floattostr(DoCalc(caSQRT));
  except
    Error;
  end;
end;

procedure TMainF.ButtonActionClick(Sender: TObject);
var
  s: string;
begin
  DoButtonPress(TCalcAction((Sender as TButton).Tag));
  if (OPERATIONEdit.Text[Length(OPERATIONEdit.Text)] in ['+', '-', '*', '/'])
  then
  begin
    s := OPERATIONEdit.Text;
    Delete(s, Length(s), 1);
    OPERATIONEdit.Text := s;
  end;
  case (Sender as TButton).Tag of
    1:
      OPERATIONEdit.Text := OPERATIONEdit.Text + '+';
    2:
      OPERATIONEdit.Text := OPERATIONEdit.Text + '-';
    3:
      OPERATIONEdit.Text := OPERATIONEdit.Text + '*';
    4:
      OPERATIONEdit.Text := OPERATIONEdit.Text + '/';
  end;
  SetEditFocus;
end;

procedure TMainF.ButtonCEClick(Sender: TObject);
begin
  EditResult.Clear;
  SetEditFocus;
end;

procedure TMainF.ButtonDOTClick(Sender: TObject);
var
  k, b: integer;
begin
  if (EditResult.Text <> '') then
    k := Pos(',', EditResult.Text);
    if k = 0 then
begin
      EditResult.Text :=  EditResult.Text + (Sender as TButton).Caption;
      end;
end;

procedure TMainF.ButtonDROBClick(Sender: TObject);
begin
  if (EditResult.Text <> '') and (EditResult.Text <> '0') then
    EditResult.Text := floattostr(1 / strtofloat(EditResult.Text))
  else
    Error;
end;

procedure TMainF.ButtonCClick(Sender: TObject);
var
  f: integer;
begin
  OPERATIONEdit.Clear;
  EditResult.Clear;
  A := 0;
  B := 0;
  i := 0;
  CurrentCalcAction := caNone;
  SetEditFocus;
  for f := 0 to self.ComponentCount - 1 do
    if (self.components[f] is TButton) then
      (self.components[f] as TButton).Enabled := true;
  EditResult.Enabled := true;
  OPERATIONEdit.Enabled := true;
  SetEditFocus;
end;

procedure TMainF.ButtonEQUALClick(Sender: TObject);
var
  f: integer;
begin
  try
    begin
      if (EditResult.Text <> '') then
      begin
        if (i < 1) then
        begin
          EditResult.Text := floattostr(DoButtonPress(CurrentCalcAction));
        end;
      end;
      if (i = 1) then
      begin
        A := strtofloat(EditResult.Text);
        EditResult.Text := floattostr(DoCalc(CurrentCalcAction));
      end;
      i := 1;
      OPERATIONEdit.Clear;
      SetEditFocus;
    end;
  except
    Error;
  end;
end;

procedure TMainF.SetEditFocus;
begin
  if EditResult.Enabled = true then
  begin
    EditResult.setfocus;
    EditResult.SelStart := Length(EditResult.Text);
    EditResult.SelLength := 0;
  end;
end;

function TMainF.DoButtonPress(ButtonAction: TCalcAction): TCalcResultType;
var
  f: integer;
begin
  try
    if (CurrentCalcAction = caNone) or (i > 0) then
    begin
      if (EditResult.Text <> '') then
      begin
        A := strtofloat(EditResult.Text);
        OPERATIONEdit.Text := floattostr(A);
      end
      else
      begin
        A := 0;
        OPERATIONEdit.Text := floattostr(A);
      end;
    end
    else
    begin
      if (EditResult.Text <> '') then
      begin
        B := strtofloat(EditResult.Text);
        OPERATIONEdit.Text := OPERATIONEdit.Text + floattostr(B);
        Result := DoCalc(CurrentCalcAction);
        A := Result;
        OPERATIONEdit.Text := floattostr(A);
      end;
    end;
    CurrentCalcAction := ButtonAction;
    EditResult.Clear;
    i := 0
  except
    Error;
  end;

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
      try
        exit(A / B);
      except
        begin
          exit(null);

        end;
      end;
    caSQRT:
      exit(sqrt(strtofloat(EditResult.Text)));
    caPERCENT:
      ;
  end;
  i := 0;
end;

procedure TMainF.FormClick(Sender: TObject);
begin
  SetEditFocus;
end;

procedure TMainF.FormCreate(Sender: TObject);
begin
  // EditResult.Text := '0';
  CurrentCalcAction := caNone;
  i := 0;
end;

procedure TMainF.MExitClick(Sender: TObject);
begin
  close;
end;

procedure TMainF.EditResultKeyPress(Sender: TObject; var Key: Char);
var
  k: integer;
begin
  if Key = #43 then
    ButtonPLUS.Click;
  if Key = #45 then
  begin
    ButtonMINUS.Click;
  end;
  if Key = #47 then
  begin
    ButtonDIV.Click;
  end;
  if Key = #42 then
  begin
    ButtonMULT.Click
  end;

  if Key = #13 then
    ButtonEQUALClick(nil);
  if not(Key in ['0' .. '9', #8, ',', '.']) then
    Key := #0;
  if Key in [',', '.'] then
    Key := ',';

  if Key = ',' then
  begin
    if EditResult.Text = '' then
      Key := #0;
    For k := 1 to Length(EditResult.Text) do
    begin
      if EditResult.Text[k] = ',' then
        Key := #0;
    end
  end;
end;

procedure TMainF.Error;
var
  f: integer;
begin
  EditResult.Text := 'Œ¯Ë·Í‡!';
  OPERATIONEdit.Clear; // Œ¯Ë·Í‡!
  for f := 0 to self.ComponentCount - 1 do
    if (self.components[f].Name <> 'ButtonC') and (self.components[f] is TButton)
    then
      (self.components[f] as TButton).Enabled := false;
  EditResult.Enabled := false;
  OPERATIONEdit.Enabled := false;
end;

end.
