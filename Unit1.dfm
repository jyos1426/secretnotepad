object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Form1'
  ClientHeight = 262
  ClientWidth = 348
  Color = clBtnFace
  TransparentColor = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnMouseDown = MemoMouseDown
  OnMouseEnter = FormMouseEnter
  OnMouseMove = MemoMouseMove
  OnMouseWheelDown = FormMouseWheelDown
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Memo: TMemo
    Left = 0
    Top = 0
    Width = 348
    Height = 246
    Cursor = crIBeam
    Align = alClient
    BevelInner = bvNone
    BorderStyle = bsNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clDefault
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    PopupMenu = PopupMenu1
    ScrollBars = ssVertical
    TabOrder = 0
    OnChange = MemoChange
    OnMouseDown = MemoMouseDown
    OnMouseEnter = FormMouseEnter
    OnMouseMove = MemoMouseMove
  end
  object Panel1: TPanel
    Left = 0
    Top = 246
    Width = 348
    Height = 16
    Align = alBottom
    BevelOuter = bvNone
    Color = clBackground
    ParentBackground = False
    TabOrder = 1
    object Panel2: TPanel
      Left = 320
      Top = 0
      Width = 28
      Height = 16
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      OnMouseDown = Panel2MouseDown
      OnMouseEnter = Panel2MouseEnter
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 112
    Top = 32
    object N5: TMenuItem
      Action = actOpen
    end
    object N2: TMenuItem
      Action = actSave
    end
    object N1: TMenuItem
      Action = actNewSave
    end
    object N7: TMenuItem
      Caption = '-'
    end
    object g1: TMenuItem
      Caption = #54637#49345' '#50948#47196
      OnClick = g1Click
    end
    object N3: TMenuItem
      Caption = #53804#47749#46020' '#48320#44221
      object trans_100: TMenuItem
        Caption = '100%'
        OnClick = FormChangeTrans
      end
      object trans_80: TMenuItem
        Caption = '80%'
        OnClick = FormChangeTrans
      end
      object trans_50: TMenuItem
        Caption = '50%'
        OnClick = FormChangeTrans
      end
      object trans_20: TMenuItem
        Caption = '20%'
        OnClick = FormChangeTrans
      end
      object trans_1: TMenuItem
        Caption = '0%'
        OnClick = FormChangeTrans
      end
      object t1: TMenuItem
        Caption = #49444#51221'..'
        Enabled = False
      end
    end
    object N6: TMenuItem
      Caption = #48176#44221#49353' '#48148#44984#44592
      object clBlack: TMenuItem
        Caption = #44160#51221#49353
        OnClick = FormChangeColor
      end
      object clGray: TMenuItem
        Caption = #54924#49353
        OnClick = FormChangeColor
      end
      object clWhite: TMenuItem
        Caption = #55152#49353
        OnClick = FormChangeColor
      end
    end
    object N8: TMenuItem
      Caption = '-'
    end
    object N4: TMenuItem
      Action = actExit
    end
  end
  object ActionList1: TActionList
    Left = 88
    Top = 64
    object actSave: TAction
      Caption = #51200#51109
      ShortCut = 16467
      OnExecute = actSaveExecute
    end
    object actNewSave: TAction
      Caption = #45796#47480#51060#47492#51004#47196' '#51200#51109
      ShortCut = 49235
      OnExecute = actNewSaveExecute
    end
    object actExit: TAction
      Caption = #51333#47308
      ShortCut = 49242
      OnExecute = actExitExecute
    end
    object actOpen: TAction
      Caption = #50676#44592
      ShortCut = 16463
      OnExecute = actOpenExecute
    end
  end
  object SaveDialog: TSaveDialog
    Left = 64
    Top = 16
  end
  object OpenDialog1: TOpenDialog
    Left = 32
    Top = 48
  end
end
