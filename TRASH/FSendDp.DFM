inherited SendDp: TSendDp
  Left = 499
  Top = 305
  Caption = #1044#1086#1087'.'#1087#1088#1086#1075#1088#1072#1084#1084#1099
  Menu = KeyMenu1
  PixelsPerInch = 96
  TextHeight = 15
  inherited RbPanel1: TRbPanel
    inherited RbPanel2: TRbPanel
      BevelOuter = bvNone
      Place = rpTop
      object PanelEdit1: TPanelEdit
        Left = 8
        Top = 8
        Width = 406
        Height = 68
        MinSized = False
        ParentSchem = True
        Schem = 'Edit'
        CanSize = False
        CanMove = False
        MaxWidth = False
        ProcentWnd = 0
        SortMode = smColumns
        SortObj = True
        BevelOuter = bvLowered
        HMin = 0
        Place = rpNone
        SayRight = False
        TabOrder = 0
        WMin = 0
        MasterControl = SbFiles
        Options = [peCheckOnExit, peCloseOnEsc]
        object FeFrom: TFldEdit
          Left = 23
          Top = 8
          Width = 86
          Height = 25
          MinSized = False
          ParentSchem = True
          Schem = 'Edit'
          CharCase = ecNormal
          CharWidth = -1
          CharHeight = 0
          Mask = '#'
          MaxLength = 0
          NameRec = 'RvSendDp'
          NameRecFld = 'SENDDPFROM'
          Options = [ogAutoSelect, ogReadOnlyNoVsbl, ogAutoSize]
          Vid = 'TDirGet'
          VName = 'Dir'
          OnCheck = FeFromCheck
          OnChange = FeFromChange
          ParentShowHint = False
          ShowHint = True
          SayRight = False
          TabOrder = 0
          TabStop = True
        end
      end
      object RbPanel3: TRbPanel
        Left = 8
        Top = 83
        Width = 406
        Height = 226
        MinSized = False
        ParentSchem = True
        Schem = 'Edit'
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
        TabOrder = 1
        WMin = 0
        OnEnter = RbPanel3Enter
        OnExit = RbPanel3Exit
        object SbFiles: TStringBrowl
          Left = 8
          Top = 8
          Width = 300
          Height = 112
          ColCount = 1
          FixedCols = 0
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSizing, goColSizing, goRowSelect]
          TabOrder = 0
          OnDblClick = SbFilesDblClick
          KeyDblClick = 13
          TitleFont.Charset = RUSSIAN_CHARSET
          TitleFont.Color = clBlack
          TitleFont.Height = -13
          TitleFont.Name = 'Courier New'
          TitleFont.Style = []
          OnBeforeDrawCell = SbFilesBeforeDrawCell
          SelectedOnlyFocused = False
          ColWidths = (
            4)
          RowHeights = (
            20
            24
            24
            24
            24)
        end
      end
    end
  end
  object KeyMenu1: TKeyMenu
    AutoHotkeys = maManual
    OwnerDraw = True
    Left = 8
    Top = 8
  end
  object RvSendDp: TRecVal
    NameRec = 'RvSendDp'
    Fields.Strings = (
      'SENDDPFROM=M')
    Left = 56
    Top = 8
  end
end
