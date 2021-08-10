object ms: Tms
  Left = 644
  Top = 214
  AlphaBlend = True
  BorderStyle = bsNone
  ClientHeight = 65
  ClientWidth = 294
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Shape1: TShape
    Left = 0
    Top = 0
    Width = 294
    Height = 65
    Align = alClient
    Pen.Mode = pmMask
  end
  object Label1: TLabel
    Left = 16
    Top = 24
    Width = 270
    Height = 12
    Caption = #24744#25152#35201#25773#25918#30340#25991#20214#19981#23384#22312#65292#35831#26816#26597#25991#20214#25152#22312#30340#30446#24405'!'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 1
    OnTimer = Timer1Timer
    Left = 184
    Top = 32
  end
end
