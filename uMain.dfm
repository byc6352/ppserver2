object fMain: TfMain
  Left = 0
  Top = 0
  Caption = 'fMain'
  ClientHeight = 828
  ClientWidth = 1049
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1049
    Height = 41
    Align = alTop
    TabOrder = 0
    object btnStart: TButton
      Left = 7
      Top = 10
      Width = 75
      Height = 25
      Caption = #24320#22987
      TabOrder = 0
      OnClick = btnStartClick
    end
  end
  object Page1: TPageControl
    Left = 0
    Top = 41
    Width = 1049
    Height = 768
    ActivePage = tsInfo
    Align = alClient
    TabOrder = 1
    object tsInfo: TTabSheet
      Caption = #20449#24687
      object memoInfo: TMemo
        Left = 0
        Top = 0
        Width = 1041
        Height = 740
        Align = alClient
        ScrollBars = ssBoth
        TabOrder = 0
      end
    end
    object tsData: TTabSheet
      Caption = #25968#25454
      ImageIndex = 1
      object MemoData: TMemo
        Left = 0
        Top = 81
        Width = 1041
        Height = 659
        Align = alClient
        ScrollBars = ssBoth
        TabOrder = 0
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 1041
        Height = 81
        Align = alTop
        TabOrder = 1
        object btnDecrpt: TButton
          Left = 3
          Top = 41
          Width = 75
          Height = 25
          Caption = #35299#23494
          TabOrder = 0
          OnClick = btnDecrptClick
        end
        object edtInput: TEdit
          Left = 1
          Top = 1
          Width = 1039
          Height = 21
          Align = alTop
          TabOrder = 1
          Text = 
            '0qnJRBqeONau180MKbthehAfjaPQFMFEMEHS8e1rHAeWe770xUY6LISmF3WBhlOa' +
            'gxVG3JcWNgGpOicvCDAGnpmA4xBFRybg1h8Kg9zVn6vjLg0W/wmrFhuyZSvbB/AZ' +
            'wL50vkclkyuGLYpYihZ2g+8BW68nIDbRIRDMxtjpxCdZvM3nccE4AOdw6sUpohmT' +
            'bn52fXgAqjx/+C4PWltzsH3YbcroBX0d1z4O62ZC3FH9haoBJngRxQ=='
        end
        object btnTest: TButton
          Left = 412
          Top = 42
          Width = 75
          Height = 25
          Caption = 'test'
          TabOrder = 2
        end
        object btnDecryptTime: TButton
          Left = 83
          Top = 41
          Width = 75
          Height = 25
          Caption = #35299#23494#26102#38388#21253
          TabOrder = 3
          OnClick = btnDecryptTimeClick
        end
        object btnSetSysTime: TButton
          Left = 824
          Top = 42
          Width = 100
          Height = 25
          Caption = #35774#32622#31995#32479#26102#38388
          TabOrder = 4
          OnClick = btnSetSysTimeClick
        end
        object btnRestoreSysTime: TButton
          Left = 930
          Top = 42
          Width = 100
          Height = 25
          Caption = #24674#22797' '#31995#32479#26102#38388
          TabOrder = 5
          OnClick = btnRestoreSysTimeClick
        end
        object btnCrypt: TButton
          Left = 164
          Top = 41
          Width = 75
          Height = 25
          Caption = #35299#23494
          TabOrder = 6
          OnClick = btnCryptClick
        end
        object btnCryptTime: TButton
          Left = 252
          Top = 42
          Width = 75
          Height = 25
          Caption = #21152#23494#26102#38388#21253
          TabOrder = 7
          OnClick = btnCryptTimeClick
        end
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 809
    Width = 1049
    Height = 19
    Panels = <
      item
        Width = 360
      end
      item
        Width = 50
      end>
  end
end
