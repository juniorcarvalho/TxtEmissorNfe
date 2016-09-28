object frmDemo: TfrmDemo
  Left = 0
  Top = 0
  Caption = 'Importa TXT de Clientes e Produtos - Padr'#227'o emissor gratuito'
  ClientHeight = 413
  ClientWidth = 896
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 56
    Top = 40
    Width = 75
    Height = 25
    Caption = 'Cliente'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 216
    Top = 40
    Width = 75
    Height = 25
    Caption = 'Produto'
    TabOrder = 1
    OnClick = Button2Click
  end
  object mmResult: TMemo
    Left = 0
    Top = 88
    Width = 896
    Height = 325
    Align = alBottom
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object OpenDialog1: TOpenDialog
    Left = 448
    Top = 24
  end
end
