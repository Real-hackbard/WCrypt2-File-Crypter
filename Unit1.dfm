object Form1: TForm1
  Left = 452
  Top = 171
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'WCrypt File Hash'
  ClientHeight = 264
  ClientWidth = 382
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 13
  object Bevel1: TBevel
    Left = 32
    Top = 115
    Width = 321
    Height = 2
  end
  object Label1: TLabel
    Left = 118
    Top = 141
    Width = 39
    Height = 13
    Caption = 'Lenght :'
  end
  object Label2: TLabel
    Left = 254
    Top = 141
    Width = 33
    Height = 13
    Caption = 'Chars :'
  end
  object Label3: TLabel
    Left = 16
    Top = 45
    Width = 22
    Height = 13
    Caption = 'File :'
  end
  object Label4: TLabel
    Left = 16
    Top = 77
    Width = 22
    Height = 13
    Caption = 'File :'
  end
  object Button1: TButton
    Left = 64
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Crypt File'
    TabOrder = 0
    TabStop = False
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 278
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Decrypt File'
    TabOrder = 1
    TabStop = False
    OnClick = Button2Click
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 245
    Width = 382
    Height = 19
    Panels = <>
    SimplePanel = True
    SimpleText = 'Load File..'
    ExplicitTop = 230
    ExplicitWidth = 388
  end
  object Edit1: TEdit
    Left = 64
    Top = 40
    Width = 289
    Height = 21
    TabStop = False
    ReadOnly = True
    TabOrder = 3
  end
  object Edit2: TEdit
    Left = 64
    Top = 72
    Width = 289
    Height = 21
    TabStop = False
    ReadOnly = True
    TabOrder = 4
  end
  object Edit3: TEdit
    Left = 16
    Top = 168
    Width = 369
    Height = 21
    TabStop = False
    ReadOnly = True
    TabOrder = 5
  end
  object Button3: TButton
    Left = 16
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Generate'
    TabOrder = 6
    TabStop = False
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 16
    Top = 200
    Width = 75
    Height = 25
    Caption = 'Crypt'
    Enabled = False
    TabOrder = 7
    TabStop = False
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 104
    Top = 200
    Width = 75
    Height = 25
    Caption = 'Decrypt'
    Enabled = False
    TabOrder = 8
    TabStop = False
    OnClick = Button5Click
  end
  object SpinEdit1: TSpinEdit
    Left = 160
    Top = 136
    Width = 65
    Height = 22
    TabStop = False
    MaxValue = 0
    MinValue = 0
    TabOrder = 9
    Value = 20
  end
  object SpinEdit2: TSpinEdit
    Left = 288
    Top = 136
    Width = 65
    Height = 22
    TabStop = False
    MaxValue = 0
    MinValue = 0
    TabOrder = 10
    Value = 20
  end
  object OpenDialog1: TOpenDialog
    Left = 256
    Top = 192
  end
  object SaveDialog1: TSaveDialog
    Left = 288
    Top = 192
  end
end
