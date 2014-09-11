unit New_CULC;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus;

type
  TCalcAction = (caNone, caPLUS, caMINUS, caMUL, caDIV, caSQRT,
    caPERCENT, caRAVNO);

type
  TMemoryAction = (memClear, memRecal, memSave, memAdd, memAddOppose);

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
    MExit: TMenuItem;
    EditResult: TEdit;
    OPERATIONEdit: TEdit;
    ButtonMPlus: TButton;
    ButtonMMinus: TButton;
    ButtonMC: TButton;
    ButtonMR: TButton;
    ButtonMS: TButton;
    N1: TMenuItem;
    N2: TMenuItem;
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
    procedure ButtonPERSClick(Sender: TObject);
    procedure EditResultEnter(Sender: TObject);
    procedure ButtonMemoryClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CurrentCalcAction: TCalcAction;
    CurrentMemoryAction: TMemoryAction;
    A, B, MemorySymbol: TCalcResultType;
    flag: boolean;
    Ravno, ErrorType: integer;
    procedure SetEditFocus;
    function CalcActions(CalcAction: TCalcAction): TCalcResultType;
    function DoButtonPress(ButtonAction: TCalcAction): TCalcResultType;
    procedure CalcError;
  end;

var
  MainF: TMainF;

implementation

{$R *.dfm}

procedure TMainF.ButtonNumClick(Sender: TObject);
begin
  if (EditResult.Text = '0') or ((EditResult.Text = Floattostr(A)) and (flag))
  then
    EditResult.Clear;
  EditResult.Text := EditResult.Text + (Sender as TButton).Caption;
  SetEditFocus;
  flag := false;
end;

procedure TMainF.ButtonOPOSEClick(Sender: TObject);
begin
  try
    if EditResult.Text <> '' then
      EditResult.Text := Floattostr(-strtofloat(EditResult.Text));
    SetEditFocus;
  except
    CalcError;

  end;
end;

procedure TMainF.ButtonPERSClick(Sender: TObject);
begin
  try
    if EditResult.Text <> '' then
      EditResult.Text := Floattostr(A / 100 * strtofloat(EditResult.Text));
    SetEditFocus;
  except
    CalcError;
  end;
end;

procedure TMainF.ButtonREMOVEClick(Sender: TObject);
begin

  EditResult.Text := Copy(EditResult.Text, 1, length(EditResult.Text) - 1);
  SetEditFocus;
end;

procedure TMainF.ButtonSQRTClick(Sender: TObject);
begin
  try
    if EditResult.Text <> '' then
      EditResult.Text := Floattostr(CalcActions(caSQRT));
    SetEditFocus;
  except
    CalcError;
  end;
end;

procedure TMainF.ButtonMemoryClick(Sender: TObject);
begin
  CurrentMemoryAction := TMemoryAction((Sender as TButton).Tag);
  case CurrentMemoryAction of
    memClear:
      MemorySymbol := 0;
    memRecal:
      EditResult.Text := floattostr(MemorySymbol);
    memSave:
      MemorySymbol := strtofloat(EditResult.Text);
    memAdd:
      MemorySymbol := MemorySymbol + strtofloat(EditResult.Text);
    memAddOppose:
      MemorySymbol := MemorySymbol - strtofloat(EditResult.Text);
  end;
  SetEditFocus;
end;

procedure TMainF.ButtonActionClick(Sender: TObject);
var
  s: string;
begin
  DoButtonPress(TCalcAction((Sender as TButton).Tag));
  if (OPERATIONEdit.Text[length(OPERATIONEdit.Text)] in ['+', '-', '*', '/'])
  then
  begin
    s := OPERATIONEdit.Text;
    Delete(s, length(s), 1);
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
  k, B: integer;
begin
  if (EditResult.Text <> '') then
    k := Pos(',', EditResult.Text);
  if k = 0 then
  begin
    EditResult.Text := EditResult.Text + (Sender as TButton).Caption;
  end;
end;

procedure TMainF.ButtonDROBClick(Sender: TObject);
begin
  try
    if (EditResult.Text <> '') and (EditResult.Text <> '0') then
      EditResult.Text := Floattostr(1 / strtofloat(EditResult.Text));
    SetEditFocus;
  Except
    CalcError;

  end;
end;

procedure TMainF.ButtonCClick(Sender: TObject);
var
  f: integer;
begin
  OPERATIONEdit.Clear;
  EditResult.Clear;
  A := 0;
  B := 0;
  Ravno := 0;
  CurrentCalcAction := caNone;
  SetEditFocus;
  for f := 0 to ComponentCount - 1 do
    if (Components[f] is TButton) then
      (Components[f] as TButton).Enabled := true;
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
        if (Ravno = 0) then
        begin
          EditResult.Text := Floattostr(DoButtonPress(CurrentCalcAction));
        end;
        if (Ravno = 1) then
        begin
          A := strtofloat(EditResult.Text);
          EditResult.Text := Floattostr(CalcActions(CurrentCalcAction));
        end;
        Ravno := 1;
        OPERATIONEdit.Clear;

      end;
    end;
  except
    CalcError;
  end;
  SetEditFocus;
  flag := true;
end;

procedure TMainF.SetEditFocus;
begin
  if EditResult.Enabled = true then
  begin
    EditResult.setfocus;
    EditResult.SelStart := length(EditResult.Text);
    EditResult.SelLength := 0;
  end;
end;

function TMainF.DoButtonPress(ButtonAction: TCalcAction): TCalcResultType;
var
  f: integer;
begin
  try
    if (CurrentCalcAction = caNone) or (Ravno > 0) then
    begin
      if (EditResult.Text <> '') then
      begin
        A := strtofloat(EditResult.Text);
        OPERATIONEdit.Text := Floattostr(A);
      end
      else
      begin
        A := 0;
        OPERATIONEdit.Text := Floattostr(A);
      end;
    end
    else
    begin
      if (EditResult.Text <> '') then
      begin
        B := strtofloat(EditResult.Text);
        OPERATIONEdit.Text := OPERATIONEdit.Text + Floattostr(B);
        Result := CalcActions(CurrentCalcAction);
        A := Result;
        OPERATIONEdit.Text := Floattostr(A);
      end;
    end;
    CurrentCalcAction := ButtonAction;
    // EditResult.Clear;
    flag := true;
    Ravno := 0
  except
    CalcError;
  end;

end;

function TMainF.CalcActions(CalcAction: TCalcAction): TCalcResultType;
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
  Ravno := 0;
end;

procedure TMainF.FormClick(Sender: TObject);
begin
  SetEditFocus;
end;

procedure TMainF.FormCreate(Sender: TObject);
begin
  // EditResult.Text := '0';
  CurrentCalcAction := caNone;
  Ravno := 0;
end;

procedure TMainF.MExitClick(Sender: TObject);
begin
  close;
end;

procedure TMainF.EditResultEnter(Sender: TObject);
begin
  if EditResult.Text = '' then
    EditResult.Text := '0'
end;

procedure TMainF.EditResultKeyPress(Sender: TObject; var Key: Char);
var
  k: integer;
begin
  if EditResult.Text = '0' then
    EditResult.Text := '';
  if EditResult.Text = Floattostr(A) then
    EditResult.Text := '';
  if Key = '+' then
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
    ButtonEQUALClick(ButtonEQUAL);
  if not(Key in ['0' .. '9', #8, ',', '.']) then
    Key := #0;
  if Key in [',', '.'] then
    Key := ',';

  if Key = ',' then
  begin
    if EditResult.Text = '' then
      Key := #0;
    For k := 1 to length(EditResult.Text) do
    begin
      if EditResult.Text[k] = ',' then
        Key := #0;
    end
  end;
end;

procedure TMainF.CalcError;
var
  f: integer;
begin
  EditResult.Text := 'Œ¯Ë·Í‡!';
  OPERATIONEdit.Clear; // Œ¯Ë·Í‡!
  for f := 0 to self.ComponentCount - 1 do
    if (self.Components[f].Name <> 'ButtonC') and (self.Components[f] is TButton)
    then
      (self.Components[f] as TButton).Enabled := false;
  EditResult.Enabled := false;
  OPERATIONEdit.Enabled := false;
end;

end.
