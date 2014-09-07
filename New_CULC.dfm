object MainF: TMainF
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1050#1072#1083#1100#1082#1091#1083#1103#1090#1086#1088
  ClientHeight = 286
  ClientWidth = 213
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormClick
  OnClick = FormClick
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button7: TButton
    Left = 7
    Top = 198
    Width = 34
    Height = 38
    Caption = '7'
    TabOrder = 0
    OnClick = ButtonNumClick
  end
  object Button5: TButton
    Left = 47
    Top = 154
    Width = 34
    Height = 38
    Caption = '5'
    TabOrder = 1
    OnClick = ButtonNumClick
  end
  object Button0: TButton
    Left = 7
    Top = 242
    Width = 74
    Height = 38
    Caption = '0'
    TabOrder = 2
    OnClick = ButtonNumClick
  end
  object Button8: TButton
    Left = 47
    Top = 198
    Width = 34
    Height = 38
    Caption = '8'
    TabOrder = 3
    OnClick = ButtonNumClick
  end
  object ButtonDOT: TButton
    Left = 87
    Top = 242
    Width = 35
    Height = 38
    Caption = ','
    TabOrder = 4
    OnClick = ButtonDOTClick
  end
  object Button3: TButton
    Left = 87
    Top = 110
    Width = 35
    Height = 38
    Caption = '3'
    TabOrder = 5
    OnClick = ButtonNumClick
  end
  object ButtonOPOSE: TButton
    Left = 128
    Top = 66
    Width = 35
    Height = 38
    Caption = #177
    TabOrder = 6
    OnClick = ButtonOPOSEClick
  end
  object Button2: TButton
    Left = 47
    Top = 110
    Width = 34
    Height = 38
    Caption = '2'
    TabOrder = 7
    OnClick = ButtonNumClick
  end
  object Button1: TButton
    Left = 7
    Top = 110
    Width = 34
    Height = 38
    Caption = '1'
    TabOrder = 8
    OnClick = ButtonNumClick
  end
  object Button4: TButton
    Left = 7
    Top = 154
    Width = 34
    Height = 38
    Caption = '4'
    TabOrder = 9
    OnClick = ButtonNumClick
  end
  object Button9: TButton
    Left = 87
    Top = 198
    Width = 35
    Height = 38
    Caption = '9'
    TabOrder = 10
    OnClick = ButtonNumClick
  end
  object ButtonSQRT: TButton
    Left = 169
    Top = 66
    Width = 34
    Height = 38
    Caption = #8730
    TabOrder = 11
    OnClick = ButtonSQRTClick
  end
  object ButtonDIV: TButton
    Tag = 4
    Left = 128
    Top = 110
    Width = 35
    Height = 38
    Caption = '/'
    TabOrder = 12
    OnClick = ButtonActionClick
  end
  object ButtonMULT: TButton
    Tag = 3
    Left = 128
    Top = 154
    Width = 35
    Height = 38
    Caption = '*'
    TabOrder = 13
    OnClick = ButtonActionClick
  end
  object ButtonMINUS: TButton
    Tag = 2
    Left = 128
    Top = 198
    Width = 35
    Height = 38
    Caption = '-'
    TabOrder = 14
    OnClick = ButtonActionClick
  end
  object ButtonPERS: TButton
    Left = 169
    Top = 110
    Width = 34
    Height = 38
    Caption = '%'
    TabOrder = 15
  end
  object ButtonDROB: TButton
    Left = 169
    Top = 154
    Width = 34
    Height = 38
    Caption = '1/x'
    TabOrder = 16
    OnClick = ButtonDROBClick
  end
  object ButtonEQUAL: TButton
    Left = 169
    Top = 198
    Width = 34
    Height = 82
    Caption = '='
    TabOrder = 17
    OnClick = ButtonEQUALClick
  end
  object ButtonREMOVE: TButton
    Left = 7
    Top = 66
    Width = 34
    Height = 38
    Caption = '<--'
    TabOrder = 18
    OnClick = ButtonREMOVEClick
  end
  object ButtonCE: TButton
    Left = 47
    Top = 66
    Width = 34
    Height = 38
    Caption = 'CE'
    TabOrder = 19
    OnClick = ButtonCEClick
  end
  object ButtonPLUS: TButton
    Tag = 1
    Left = 128
    Top = 242
    Width = 34
    Height = 38
    Caption = '+'
    TabOrder = 20
    OnClick = ButtonActionClick
  end
  object ButtonC: TButton
    Left = 88
    Top = 66
    Width = 34
    Height = 38
    Caption = 'C'
    TabOrder = 21
    OnClick = ButtonCClick
  end
  object Button6: TButton
    Left = 88
    Top = 154
    Width = 34
    Height = 38
    Caption = '6'
    TabOrder = 22
    OnClick = ButtonNumClick
  end
  object EditResult: TEdit
    Left = 8
    Top = 40
    Width = 195
    Height = 21
    Alignment = taRightJustify
    TabOrder = 23
    Text = '0'
    OnKeyPress = EditResultKeyPress
  end
  object OPERATIONEdit: TEdit
    Left = 8
    Top = 8
    Width = 195
    Height = 21
    Alignment = taRightJustify
    ReadOnly = True
    TabOrder = 24
  end
  object MainMenu1: TMainMenu
    Left = 152
    Top = 11
    object MFile: TMenuItem
      Caption = #1060#1072#1081#1083
      object MExit: TMenuItem
        Caption = #1042#1099#1081#1090#1080
        OnClick = MExitClick
      end
    end
    object MHelp: TMenuItem
      Caption = #1057#1087#1088#1072#1074#1082#1072
      object MHistory: TMenuItem
        Caption = #1048#1089#1090#1086#1088#1080#1103
      end
    end
  end
end
