inherited SftpFiles: TSftpFiles
  Caption = 'SftpFiles'
  Menu = KeyMenu1
  PixelsPerInch = 120
  TextHeight = 17
  inherited RbPanel1: TRbPanel
    Top = 1
    inherited RbPanel2: TRbPanel
      Width = 680
      Height = 368
      BevelOuter = bvNone
      Place = rpLeft
      object RbPanel4: TRbPanel
        Left = 9
        Top = 9
        Width = 232
        Height = 318
        MinSized = False
        ParentSchem = False
        Schem = 'Edit'
        CanSize = False
        CanMove = False
        MaxWidth = False
        ProcentWnd = 0
        SortMode = smDefault
        SortObj = False
        BevelOuter = bvLowered
        HMin = 0
        Place = rpLeft
        SayRight = False
        TabOrder = 1
        WMin = 0
        object RbScrollBox1: TRbScrollBox
          Left = 9
          Top = 9
          Width = 176
          Height = 227
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          TabOrder = 0
          StopRebuild = False
          Options = []
          object rmFiles: TRbMenu
            Left = 9
            Top = 9
            Width = 168
            Height = 192
            MinSized = False
            ParentSchem = False
            Schem = 'Menu'
            KeyBevel = 1
            KeySpot = 2
            KeyBetween = 2
            KeyIndex = 0
            Options = [rmoMinSize]
            BevelOuter = bvNone
            TabOrder = 0
            TabStop = True
          end
        end
      end
      object RbPanel5: TRbPanel
        Left = 248
        Top = 9
        Width = 322
        Height = 318
        MinSized = False
        ParentSchem = False
        Schem = 'Browl'
        CanSize = False
        CanMove = False
        MaxWidth = False
        ProcentWnd = 100
        SortMode = smDefault
        SortObj = True
        BevelOuter = bvLowered
        HMin = 0
        Place = rpNone
        SayRight = False
        TabOrder = 0
        WMin = 0
        object sbFiles: TStringBrowl
          Left = 9
          Top = 9
          Width = 272
          Height = 119
          ColCount = 1
          FixedCols = 0
          RowCount = 2
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSizing, goColSizing, goRowSelect]
          TabOrder = 0
          KeyDblClick = 13
          TitleFont.Charset = RUSSIAN_CHARSET
          TitleFont.Color = clBlack
          TitleFont.Height = -15
          TitleFont.Name = 'Courier New'
          TitleFont.Style = []
          SelectedOnlyFocused = False
          ColWidths = (
            31)
          RowHeights = (
            21
            24)
        end
      end
    end
  end
  object KeyMenu1: TKeyMenu
    AutoHotkeys = maManual
    OwnerDraw = True
    Left = 16
    Top = 9
  end
  object DeSetupUtil: TDefEdit
    DcmBased = False
    FrmBorderIcons = [biSystemMenu, biMinimize, biMaximize]
    FrmBorderStyle = bsSizeable
    FrmCaption = #1059#1089#1090#1072#1085#1086#1074#1082#1072' '#1076#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1093' '#1087#1088#1086#1075#1088#1072#1084#1084
    Fields.Strings = (
      
        #1055#1072#1087#1082#1080' '#1076#1083#1103' '#1091#1089#1090#1072#1085#1086#1074#1082#1080'('#1095#1077#1088#1077#1079' ";")#SftpFiles#DESTDIR#TSimpleGet###0#' +
        '1#T#F#T#F#F####-1#0#F#F')
    HelpContext = 10050
    NameWnd = 'SetupUtil'
    PnlAskByCancel = False
    PnlSortMode = smDefault
    OnFldCheck = DeSetupUtilFldCheck
    Left = 360
    Top = 208
  end
  object RvSftpFiles: TRecVal
    NameRec = 'SftpFiles'
    Fields.Strings = (
      'DESTDIR=M')
    Left = 296
    Top = 208
  end
  object tmWatchFile: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = tmWatchFileTimer
    Left = 424
    Top = 209
  end
end
