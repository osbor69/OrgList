inherited Main: TMain
  Left = 234
  Top = 0
  Width = 942
  Height = 795
  Caption = #1059#1095#1105#1090' '#1082#1083#1080#1077#1085#1090#1086#1074
  WindowState = wsMaximized
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 15
  inherited RbPanel1: TRbPanel
    Width = 819
    Height = 600
    inherited KeyLb1: TKeyLb
      Left = 16
      Top = 544
      Font.Charset = RUSSIAN_CHARSET
      Font.Height = -12
      Font.Style = []
    end
    inherited PanelEdit1: TPanelEdit
      Left = 8
      Top = 23
      Width = 811
      Height = 508
      BevelOuter = bvNone
      Place = rpTop
      OnCngKey = PanelEdit1CngKey
      OnValid = PanelEdit1Valid
      object pnUser: TRbPanel
        Left = 8
        Top = 8
        Width = 735
        Height = 35
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
        Place = rpLeft
        SayRight = False
        TabOrder = 0
        WMin = 0
        object PnUser1: TRbPanel
          Left = 8
          Top = 8
          Width = 240
          Height = 30
          MinSized = False
          ParentSchem = True
          Schem = 'Edit'
          CanSize = False
          CanMove = False
          MaxWidth = False
          ProcentWnd = 100
          SortMode = smColumns
          SortObj = True
          BevelOuter = bvNone
          HMin = 0
          Place = rpNone
          SayRight = False
          TabOrder = 0
          WMin = 0
          object ETn: TFldEdit
            Tag = 1
            Left = 98
            Top = 0
            Width = 86
            Height = 26
            MinSized = False
            ParentSchem = True
            Schem = 'Edit'
            CharCase = ecNormal
            CharWidth = -2
            CharHeight = 0
            Mask = '@N@C'
            MaxLength = 0
            NameRec = 'Main'
            NameRecFld = 'TN'
            Vid = 'TCodeGet'
            VName = 'Cdr'
            ParentShowHint = False
            ShowHint = True
            SayCaption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
            SayRight = False
            TabOrder = 0
            TabStop = True
            OnExit = ETnExit
          end
        end
        object PnUser2: TRbPanel
          Left = 293
          Top = 8
          Width = 240
          Height = 30
          MinSized = False
          ParentSchem = True
          Schem = 'Edit'
          CanSize = False
          CanMove = False
          MaxWidth = False
          ProcentWnd = 100
          SortMode = smColumns
          SortObj = True
          BevelOuter = bvNone
          HMin = 0
          Place = rpNone
          SayRight = False
          TabOrder = 1
          WMin = 0
          object ETnStatus: TFldEdit
            Tag = 1
            Left = 98
            Top = 0
            Width = 82
            Height = 25
            MinSized = False
            ParentSchem = True
            Schem = 'Edit'
            CharCase = ecNormal
            CharWidth = 0
            CharHeight = 0
            MaxLength = 0
            NameRec = 'Main'
            NameRecFld = 'TNSTATUS'
            Options = [ogAutoSelect, ogReadOnly, ogAutoSize]
            Vid = 'TSimpleGet'
            ParentShowHint = False
            ShowHint = True
            Enabled = False
            SayCaption = #1057#1090#1072#1090#1091#1089
            SayRight = False
            TabOrder = 0
          end
        end
      end
      object pnPage: TRbPanel
        Left = 8
        Top = 50
        Width = 805
        Height = 459
        MinSized = False
        ParentSchem = False
        Schem = 'Menu'
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
        object RbPage1: TRbPage
          Left = 0
          Top = 0
          Width = 777
          Height = 453
          ActivePage = tsOrg
          MultiLine = True
          Style = tsButtons
          TabOrder = 0
          TabStop = False
          OnChange = RbPage1Change
          OnChanging = RbPage1Changing
          CngByCtrl = True
          object tsOrg: TTabSheet
            Caption = #1050#1083#1080#1077#1085#1090
            ImageIndex = 3
            object pnOrg: TRbPanel
              Left = 8
              Top = 14
              Width = 663
              Height = 361
              MinSized = False
              ParentSchem = False
              Schem = 'Edit'
              CanSize = False
              CanMove = False
              MaxWidth = False
              ProcentWnd = 100
              SortMode = smDefault
              SortObj = True
              HMin = 0
              Place = rpTop
              SayRight = False
              TabOrder = 0
              WMin = 0
              object pnOrg1: TRbPanel
                Left = 22
                Top = 8
                Width = 621
                Height = 43
                MinSized = False
                ParentSchem = False
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
                object EKod: TFldEdit
                  Left = 78
                  Top = 14
                  Width = 86
                  Height = 25
                  MinSized = False
                  ParentSchem = True
                  Schem = 'Edit'
                  CharCase = ecNormal
                  CharWidth = -1
                  CharHeight = 0
                  Mask = '@N@C@0'
                  MaxLength = 0
                  NameRec = 'Cdr'
                  NameRecFld = 'ORGKOD'
                  Value = ' '
                  Vid = 'TCodeGet'
                  VName = 'List'
                  OnChange = EKodChange
                  ParentShowHint = False
                  ShowHint = True
                  SayRight = False
                  TabOrder = 0
                  TabStop = True
                end
              end
              object pnOrg2: TRbPanel
                Left = 22
                Top = 64
                Width = 629
                Height = 283
                MinSized = False
                ParentSchem = True
                Schem = 'Edit'
                CanSize = False
                CanMove = False
                MaxWidth = False
                ProcentWnd = 100
                SortMode = smDefault
                SortObj = True
                BevelOuter = bvNone
                HMin = 0
                Place = rpTop
                SayRight = False
                TabOrder = 1
                WMin = 0
                object pnOrgDat: TRbPanel
                  Left = 14
                  Top = 22
                  Width = 609
                  Height = 121
                  MinSized = False
                  ParentSchem = True
                  Schem = 'Edit'
                  CanSize = False
                  CanMove = False
                  MaxWidth = False
                  ProcentWnd = 20
                  SortMode = smDefault
                  SortObj = True
                  BevelOuter = bvLowered
                  HMin = 0
                  Place = rpNone
                  SayRight = False
                  TabOrder = 0
                  WMin = 0
                end
                object pnOrgLs: TRbPanel
                  Left = 14
                  Top = 148
                  Width = 609
                  Height = 121
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
                  TabOrder = 1
                  WMin = 0
                  object EProg: TFldEdit
                    Left = 204
                    Top = 36
                    Width = 86
                    Height = 25
                    MinSized = False
                    ParentSchem = False
                    Schem = 'Browl'
                    CharCase = ecNormal
                    CharWidth = -1
                    CharHeight = -1
                    MaxLength = 0
                    Vid = 'TSimpleGet'
                    ParentShowHint = False
                    ShowHint = True
                    SayRight = False
                    TabOrder = 0
                    TabStop = True
                  end
                end
              end
            end
          end
          object tsFlt: TTabSheet
            Caption = #1055#1088#1086#1075#1088#1072#1084#1084#1099
            ImageIndex = 3
            OnEnter = tsFltEnter
            OnExit = tsFltExit
            object pnFltSt: TRbPanel
              Left = 14
              Top = 8
              Width = 707
              Height = 381
              MinSized = False
              ParentSchem = True
              Schem = 'Menu'
              CanSize = False
              CanMove = False
              MaxWidth = False
              ProcentWnd = 100
              SortMode = smDefault
              SortObj = True
              HMin = 0
              Place = rpBottom
              SayRight = False
              TabOrder = 0
              WMin = 0
              object stFlt: TRbStatus
                Tag = -1
                Left = 28
                Top = 324
                Width = 163
                Height = 37
                MinSized = False
                ParentSchem = False
                Schem = 'Status'
                SimpleLine = False
                SectLeft.Strings = (
                  '')
                Alignment = taLeftJustify
                BevelOuter = bvLowered
              end
              object pnFlt: TRbPanel
                Left = 8
                Top = 8
                Width = 600
                Height = 255
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
                TabOrder = 1
                WMin = 0
                object EFlt: TFldEdit
                  Left = 204
                  Top = 36
                  Width = 86
                  Height = 25
                  MinSized = False
                  ParentSchem = False
                  Schem = 'Browl'
                  CharCase = ecNormal
                  CharWidth = -1
                  CharHeight = -1
                  MaxLength = 0
                  Vid = 'TSimpleGet'
                  ParentShowHint = False
                  ShowHint = True
                  SayRight = False
                  TabOrder = 0
                  TabStop = True
                  OnEnter = EFltEnter
                  OnExit = EFltExit
                end
              end
            end
          end
          object tsZaj: TTabSheet
            Caption = #1047#1072#1103#1074#1082#1080
            ImageIndex = 4
            object pnZajSt: TRbPanel
              Left = 14
              Top = 22
              Width = 729
              Height = 353
              MinSized = False
              ParentSchem = True
              Schem = 'Menu'
              CanSize = False
              CanMove = False
              MaxWidth = False
              ProcentWnd = 100
              SortMode = smDefault
              SortObj = True
              HMin = 0
              Place = rpBottom
              SayRight = False
              TabOrder = 0
              WMin = 0
              object stZaj: TRbStatus
                Tag = -1
                Left = 50
                Top = 310
                Width = 163
                Height = 37
                MinSized = False
                ParentSchem = False
                Schem = 'Status'
                SimpleLine = False
                SectLeft.Strings = (
                  '')
                Alignment = taLeftJustify
                BevelOuter = bvLowered
              end
              object pnZaj: TRbPanel
                Left = 8
                Top = 0
                Width = 663
                Height = 291
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
                TabOrder = 1
                WMin = 0
                OnEnter = pnZajEnter
                OnExit = pnZajExit
                object brZaj: TBrowl
                  Left = 120
                  Top = 50
                  Width = 282
                  Height = 106
                  CloseOnSelect = False
                  KeyDblClick = 13
                  DataSource = dsZaj
                  Options = [dgTitles, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection]
                  ReadOnly = True
                  TabOrder = 0
                  TitleFont.Charset = DEFAULT_CHARSET
                  TitleFont.Color = clWindowText
                  TitleFont.Height = -12
                  TitleFont.Name = 'Courier New'
                  TitleFont.Style = []
                end
              end
            end
          end
          object tsMsgTo: TTabSheet
            Caption = #1057#1086#1086#1073#1097#1077#1085#1080#1103' '#1087#1086#1083#1091#1095#1077#1085#1085#1099#1077
            ImageIndex = 6
            object pnMsgTo: TRbPanel
              Left = 36
              Top = 36
              Width = 635
              Height = 332
              MinSized = False
              ParentSchem = False
              Schem = 'Browl'
              CanSize = False
              CanMove = False
              MaxWidth = False
              ProcentWnd = 100
              SortMode = smDefault
              SortObj = True
              BevelInner = bvLowered
              HMin = 0
              Place = rpNone
              SayRight = False
              TabOrder = 0
              WMin = 0
              OnEnter = pnMsgEnter
              OnExit = pnMsgExit
            end
          end
          object tsMsgFrom: TTabSheet
            Caption = #1057#1086#1086#1073#1097#1077#1085#1080#1103' '#1086#1090#1087#1088#1072#1074#1083#1077#1085#1085#1099#1077
            ImageIndex = 5
            object PnMsgFrom: TRbPanel
              Left = 36
              Top = 36
              Width = 635
              Height = 332
              MinSized = False
              ParentSchem = False
              Schem = 'Browl'
              CanSize = False
              CanMove = False
              MaxWidth = False
              ProcentWnd = 100
              SortMode = smDefault
              SortObj = True
              BevelInner = bvLowered
              HMin = 0
              Place = rpNone
              SayRight = False
              TabOrder = 0
              WMin = 0
              OnEnter = pnMsgEnter
              OnExit = pnMsgExit
            end
          end
          object tsDoc: TTabSheet
            Caption = #1044#1086#1082#1091#1084#1077#1085#1090#1099
            ImageIndex = 7
            object pnDoc: TRbPanel
              Left = 22
              Top = 22
              Width = 663
              Height = 311
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
              OnEnter = pnBrEnter
              OnExit = pnBrExit
              object brDoc: TBrowl
                Left = 170
                Top = 64
                Width = 282
                Height = 106
                CloseOnSelect = False
                KeyDblClick = 13
                NmProc.Strings = (
                  'Enter#'#1060#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077'##LIST##'
                  'F3#'#1057#1084#1077#1085#1080#1090#1100'#'#1057#1084#1077#1085#1080#1090#1100' '#1085#1086#1084#1077#1088'#LIST##'
                  'F4#'#1057#1082#1086#1087#1080#1088#1086#1074#1072#1090#1100'##LIST##'
                  'F5#'#1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100'##LIST##'
                  'F7#'#1044#1086#1073#1072#1074#1080#1090#1100'##LIST##'
                  'F8#'#1059#1076#1072#1083#1080#1090#1100'##LIST##'
                  'Ctrl_F5#'#1044#1086#1089#1090#1091#1087'#'#1054#1090#1082#1088#1099#1090#1100' '#1086#1073#1097#1080#1081' '#1076#1086#1089#1090#1091#1087' '#1082' '#1076#1086#1082#1091#1084#1077#1085#1090#1091'#LIST##')
                OnBrowlKey = brDocBrowlKey
                OnGrayCell = brDocGrayCell
                DataSource = dsDoc
                Options = [dgTitles, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection]
                ReadOnly = True
                TabOrder = 0
                TitleFont.Charset = DEFAULT_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -12
                TitleFont.Name = 'Courier New'
                TitleFont.Style = []
              end
            end
          end
          object tsOfis: TTabSheet
            Caption = #1054#1092#1080#1089
            ImageIndex = 8
            object pnOfis: TRbPanel
              Left = 22
              Top = 22
              Width = 699
              Height = 375
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
              OnEnter = pnOfisEnter
              OnExit = pnOfisExit
              object brOfis: TBrowl
                Left = 148
                Top = 64
                Width = 282
                Height = 106
                CloseOnSelect = False
                KeyDblClick = 13
                Options = [dgTitles, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection]
                ReadOnly = True
                TabOrder = 0
                TitleFont.Charset = DEFAULT_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -12
                TitleFont.Name = 'Courier New'
                TitleFont.Style = []
              end
            end
          end
          object tsCng: TTabSheet
            Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1103
            ImageIndex = 9
            object pnCng: TRbPanel
              Left = 22
              Top = 14
              Width = 706
              Height = 369
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
              OnEnter = pnCngEnter
              OnExit = pnCngExit
              object brCng: TBrowl
                Left = 84
                Top = 56
                Width = 284
                Height = 106
                CloseOnSelect = False
                KeyDblClick = 13
                NmProc.Strings = (
                  'Enter#'#1055#1088#1086#1089#1084#1086#1090#1088'#'#1055#1088#1086#1089#1084#1086#1090#1088' '#1087#1086#1089#1083#1077#1076#1085#1080#1093' '#1080#1079#1084#1077#1085#1077#1085#1080#1081'#LIST##'
                  'Ctrl_F5##'#1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1087#1086#1089#1083#1077#1076#1085#1080#1093' '#1080#1079#1084#1077#1085#1077#1085#1080#1081'#LIST##'
                  'F12#'#1042#1080#1076'#'#1057#1084#1077#1085#1080#1090#1100' '#1074#1080#1076'#LIST##')
                OnBrowlKey = brCngBrowlKey
                OnGrayCell = brCngGrayCell
                DataSource = dsCng
                Options = [dgTitles, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection]
                ReadOnly = True
                TabOrder = 0
                TitleFont.Charset = DEFAULT_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -12
                TitleFont.Name = 'Courier New'
                TitleFont.Style = []
                OnDrawColumnCell = brCngDrawColumnCell
              end
            end
          end
          object tsSftp: TTabSheet
            Caption = #1048#1085#1090#1077#1088#1085#1077#1090
            ImageIndex = 10
            OnShow = tsSftpShow
            object rpSftp: TRbPanel
              Left = 22
              Top = 14
              Width = 706
              Height = 369
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
              object sbSftp: TStringBrowl
                Left = 19
                Top = 11
                Width = 604
                Height = 106
                ColCount = 13
                FixedCols = 0
                Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
                ParentShowHint = False
                ShowHint = False
                TabOrder = 0
                OnEnter = sbSftpEnter
                OnExit = sbSftpExit
                OnMouseDown = sbSftpMouseDown
                OnMouseMove = sbSftpMouseMove
                OnMouseUp = sbSftpMouseUp
                KeyDblClick = 13
                TitleFont.Charset = RUSSIAN_CHARSET
                TitleFont.Color = clBlack
                TitleFont.Height = -14
                TitleFont.Name = 'Courier New'
                TitleFont.Style = []
                ColZn.Strings = (
                  #1059#1095'.'#1079#1072#1087#1080#1089#1100'##'
                  #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077'##L'
                  #1042#1093#1086#1076#1103#1097#1080#1077'##'
                  #1048#1089#1093#1086#1076#1103#1097#1080#1077'##'
                  #1053#1072' '#1089#1077#1088#1074#1077#1088#1077'##'
                  #1055#1086#1083#1091#1095#1077#1085#1085#1099#1077'##'
                  #1054#1090#1087#1088#1072#1074#1083#1077#1085#1085#1099#1077'##'
                  #1040#1082#1090#1080#1074#1085#1086#1089#1090#1100'##L'
                  #1042#1077#1088#1089#1080#1103'##L'
                  #1055#1091#1090#1100'##L'
                  #1050#1086#1084#1087#1100#1102#1090#1077#1088'##L'
                  #1057#1084#1077#1085#1072' '#1080#1084#1077#1085#1080'##'
                  '###-1')
                SelectedOnlyFocused = False
                ColWidths = (
                  76
                  100
                  68
                  76
                  84
                  84
                  100
                  84
                  52
                  36
                  76
                  92
                  -1)
                RowHeights = (
                  21
                  24
                  24
                  24
                  24)
              end
            end
          end
          object TsInstructions: TTabSheet
            Caption = #1048#1085#1089#1090#1088#1091#1082#1094#1080#1080
            ImageIndex = 11
            OnShow = TsInstructionsShow
            object TreeHelp: TTreeDir
              Left = 14
              Top = 22
              Width = 545
              Height = 297
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
              Place = rpBottom
              SayRight = False
              TabOrder = 0
              WMin = 0
              HideExt = True
              Options = []
              SectIni = 'DpHelp'
            end
          end
          object tsServ: TTabSheet
            Caption = '&'#1054#1073#1089#1083#1091#1078#1080#1074#1072#1085#1080#1077
            ImageIndex = 4
            object pnServ: TRbPanel
              Left = 28
              Top = 0
              Width = 707
              Height = 439
              MinSized = False
              ParentSchem = False
              Schem = 'Menu'
              CanSize = False
              CanMove = False
              MaxWidth = False
              ProcentWnd = 100
              SortMode = smDefault
              SortObj = True
              BevelOuter = bvNone
              HMin = 0
              Place = rpNone
              SayRight = False
              TabOrder = 0
              WMin = 0
              object scrServ: TRbScrollBox
                Left = 0
                Top = 8
                Width = 699
                Height = 423
                BevelEdges = []
                BorderStyle = bsNone
                TabOrder = 0
                StopRebuild = False
                Options = []
                object mnServ: TRbMenu
                  Left = 14
                  Top = 0
                  Width = 629
                  Height = 383
                  MinSized = False
                  ParentSchem = True
                  Schem = 'Menu'
                  KeyBevel = 1
                  KeySpot = 2
                  KeyBetween = 2
                  KeyIndex = 0
                  Keys.Strings = (
                    'Alt_0#'#1055#1088#1086#1074#1077#1088#1082#1072' '#1076#1072#1085#1085#1099#1093'##F#F###'
                    'Alt_1#'#1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1089#1080#1089#1090#1077#1084#1085#1099#1093' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074'##F#F###'
                    'Alt_2#'#1056#1072#1089#1095#1077#1090' '#1074#1099#1095#1080#1089#1083#1103#1077#1084#1099#1093' '#1076#1072#1085#1085#1099#1093'##F#F###'
                    'Alt_3#'#1055#1077#1088#1077#1079#1072#1075#1088#1091#1079#1082#1072' '#1087#1088#1086#1075#1088#1072#1084#1084#1099'##F#F###'
                    'Alt_4#'#1057#1086#1088#1090#1080#1088#1086#1074#1082#1072' '#1076#1072#1085#1085#1099#1093'##F#F###'
                    'Alt_5#'#1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080' '#1074' '#1089#1077#1090#1080'##F#F###'
                    'Alt_6#'#1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1088#1072#1073#1086#1095#1077#1075#1086' '#1084#1077#1089#1090#1072'##F#F###'
                    'Alt_7#'#1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1076#1086#1089#1090#1091#1087#1072' '#1082' '#1076#1072#1085#1085#1099#1084'##F#F###'
                    'Alt_8#'#1059#1087#1072#1082#1086#1074#1082#1072' '#1076#1072#1085#1085#1099#1093'##F#F###'
                    'Alt_9#'#1050#1086#1087#1080#1088#1086#1074#1072#1085#1080#1077' '#1076#1072#1085#1085#1099#1093' '#1085#1072' '#1088#1072#1073#1086#1095#1077#1077' '#1084#1077#1089#1090#1086'##F#F###'
                    'Alt_F2###F#F###'
                    'Alt_F3#'#1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1089#1087#1080#1089#1086#1082' '#1082#1083#1080#1077#1085#1090#1086#1074' '#1080#1079' "'#1041#1091#1093#1075#1072#1083#1090#1077#1088#1080#1080'"##F#F###'
                    'Alt_F5###F#F###'
                    'Alt_F6#'#1042#1099#1082#1083#1102#1095#1080#1090#1100' '#1074#1089#1077' '#1082#1086#1084#1087#1100#1102#1090#1077#1088#1099'##F#F###'
                    'Alt_F7#'#1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1087#1080#1089#1080' '#1074' '#1087#1088#1086#1090#1086#1082#1086#1083#1072#1093' '#1080' '#1078#1091#1088#1085#1072#1083#1072#1093'##F#F#F#F#'
                    'Alt_F8#'#1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1092#1086#1088#1084#1091#1083#1099'##F#F#F#F#'
                    'Alt_D#'#1055#1088#1086#1089#1084#1086#1090#1088' '#1087#1088#1086#1090#1086#1082#1086#1083#1072'##F#F#F##')
                  Options = [rmoFixHeightKeys, rmoMinSize, rmoSheetAlign]
                  OnProcKey = mnServProcKey
                  BevelOuter = bvNone
                  TabOrder = 0
                  TabStop = True
                end
              end
            end
          end
          object tsHelp: TTabSheet
            Caption = '&'#1055#1086#1084#1086#1097#1100
            ImageIndex = 6
            object pnHelp: TRbPanel
              Left = 28
              Top = 0
              Width = 707
              Height = 439
              MinSized = False
              ParentSchem = False
              Schem = 'Menu'
              CanSize = False
              CanMove = False
              MaxWidth = False
              ProcentWnd = 100
              SortMode = smDefault
              SortObj = True
              BevelOuter = bvNone
              HMin = 0
              Place = rpNone
              SayRight = False
              TabOrder = 0
              WMin = 0
              object scrHelp: TRbScrollBox
                Left = 8
                Top = 8
                Width = 691
                Height = 423
                BevelEdges = []
                BorderStyle = bsNone
                TabOrder = 0
                StopRebuild = False
                Options = []
                object mnHelp: TRbMenu
                  Left = 14
                  Top = 8
                  Width = 629
                  Height = 353
                  MinSized = False
                  ParentSchem = True
                  Schem = 'Menu'
                  KeyBevel = 1
                  KeySpot = 2
                  KeyBetween = 2
                  KeyIndex = 0
                  Keys.Strings = (
                    'Alt_F1#'#1057#1086#1076#1077#1088#1078#1072#1085#1080#1077'##F#F'
                    'Ctrl_J#'#1055#1086#1089#1083#1077#1076#1085#1080#1077' '#1080#1079#1084#1077#1085#1077#1085#1080#1103'##F#F'
                    'Ctrl_F2#'#1053#1072#1089#1090#1088#1086#1081#1082#1072'##F#F'
                    'Ctrl_H#'#1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077'##F#F'
                    'Ctrl_I#'#1054' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077'##F#F'
                    'F9#'#1050#1072#1083#1100#1082#1091#1083#1103#1090#1086#1088'##F#F')
                  Options = [rmoFixHeightKeys, rmoMinSize, rmoSheetAlign]
                  OnProcKey = mnHelpProcKey
                  BevelOuter = bvNone
                  TabOrder = 0
                  TabStop = True
                end
              end
            end
          end
        end
      end
    end
  end
  inherited KeyMenu1: TKeyMenu
    object Interbase1: TMenuItem
      Tag = 45
      Caption = 'Interbase'
    end
  end
  object deSys: TDefEdit
    DcmBased = False
    FrmBorderIcons = [biSystemMenu, biMinimize, biMaximize]
    FrmBorderStyle = bsSizeable
    FrmCaption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1089#1080#1089#1090#1077#1084#1085#1099#1093' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074
    Fields.Strings = (
      '#Glob#VIDNO#TCodeGet#Van##0#1#T#F#T#F#F####0#0#F#F#F#F'
      
        #1053#1086#1084#1077#1088' '#1086#1090#1076#1077#1083#1077#1085#1080#1103'#Glob#OTDNUM#TSpinGet##0,99#0#1#T#F#T#F#F####0#0#' +
        'F#F'
      #1056#1077#1079#1077#1088#1074#1085#1099#1077' '#1082#1086#1087#1080#1080':#Main#VAL1#TMultiGet###0#1#T#F#T#F#F####-1#0#F#F'
      
        #1084#1072#1082#1089#1080#1084#1072#1083#1100#1085#1086#1077' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086'#Glob#LASTCNT#TSpinGet##1,99999#0#1#T#F#T' +
        '#F#F###Main.VAL1#0#0#F#F'
      
        #1087#1077#1088#1080#1086#1076' '#1093#1088#1072#1085#1077#1085#1080#1103' ('#1076#1085#1080')#Glob#LASTDAY#TSpinGet##1,99999#0#1#T#F#T#F' +
        '#F###Main.VAL1#0#0#F#F'
      
        #1087#1072#1087#1082#1080' ('#1095#1077#1088#1077#1079' ";")#Glob#DIRLAST#TButTextGet#DirLast##0#1#T#F#T#F#' +
        'F###Main.VAL1#-2#0#F#F'
      
        #1055#1072#1087#1082#1072' '#1076#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1093' '#1087#1088#1086#1075#1088#1072#1084#1084'#Glob#MEM_DP#TDirGet#Dir#'#1055#1072#1087#1082#1072' '#1076#1086#1087#1086 +
        #1083#1085#1080#1090#1077#1083#1100#1085#1099#1093' '#1087#1088#1086#1075#1088#1072#1084#1084'~#0#1#T#F#T#F#F####-1#0#F#F#F#F'
      
        #1055#1072#1087#1082#1072' '#1089#1086#1086#1073#1097#1077#1085#1080#1081' Telegram#Glob#TELPATH#TDirGet#Dir#'#1055#1072#1087#1082#1072' '#1089#1086#1086#1073#1097#1077#1085#1080 +
        #1081' Telegram~#0#1#T#F#T#F#F####-1#0#F#F#F#F'
      '#Main#ORGDAT#TTblChkGet###0#1#T#F#T#F#F####0#-1#F#T'
      
        '#Glob#MEM_PROGD#TButGet#ProgDat#@H'#1076#1072#1085#1085#1099#1077'@#0#1#T#F#T#F#F####30#-1' +
        '#F#T'
      
        '#Glob#MEM_PROGW#TButGet#ProgWin#@H'#1086#1082#1085#1086' '#1074#1074#1086#1076#1072'@#0#1#T#F#T#F#T####-' +
        '1#-1#F#F'
      
        '#Glob#MEM_CALC#TButFormGet#Flt#@H'#1060#1086#1088#1084#1091#1083#1072' '#1074#1099#1095#1080#1089#1083#1077#1085#1080#1103' '#1076#1072#1085#1085#1099#1093' '#1087#1086' '#1087#1088 +
        #1086#1075#1088#1072#1084#1084#1077'@@,@#0#1#T#F#T#F#F####-1#-1#F#T')
    HelpContext = 0
    NameWnd = 'Sys'
    Pages.Strings = (
      #1054#1073#1097#1080#1077'#1'
      #1050#1083#1080#1077#1085#1090'#1#'
      #1055#1088#1086#1075#1088#1072#1084#1084#1072'#2#'
      #1060#1086#1088#1084#1091#1083#1072'#1')
    PnlAskByCancel = True
    PnlSortMode = smDefault
    OnFrmHide = deSysFrmHide
    OnPnlValid = deSysPnlValid
    Left = 872
    Top = 456
  end
  object ProgDGet: TButGet
    VName = 'ProgDat'
    OnClick = ProgDGetClick
    OnPaint = ProgDGetPaint
    Left = 872
    Top = 312
  end
  object ProgWGet: TButGet
    VName = 'ProgWin'
    OnClick = ProgWGetClick
    OnPaint = ProgWGetPaint
    Left = 872
    Top = 360
  end
  object deFlt: TDefEdit
    DcmBased = False
    FrmBorderIcons = [biSystemMenu, biMinimize, biMaximize]
    FrmBorderStyle = bsSizeable
    Fields.Strings = (
      '#Main#ORD####0#1#T#F#T#F#F####0#-1#F#F#F#F'
      '#Main#VAL1#TMultiGet###0#1#T#F#T#F#T####-1#0#F#F'
      
        #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100':#Cdr#FLTCDR####0#1#T#F#T#F#F###Main.VAL1#0#0#F#F#F#' +
        'F'
      
        '#Cdr#MEM_FLTCDR#TButTextGet#Cdr##0#1#T#F#T#T#T###Main.VAL1#-1#0#' +
        'F#F'
      '#Main#VAL2#TMultiGet###0#1#T#F#T#F#F####-1#0#F#F'
      #1050#1083#1080#1077#1085#1090':#Cdr#FLTORG####0#1#T#F#T#F#T###Main.VAL2#0#0#F#F#F#F'
      
        '#Cdr#MEM_FLTORG#TButTextGet#Org##0#1#T#F#T#T#T###Main.VAL2#-1#0#' +
        'F#F'
      '#Main#VAL3#TMultiGet###0#1#T#F#T#F#F####-1#0#F#F'
      
        #1057#1090#1072#1090#1091#1089':#Main#STATUS#TBoolMultiGet#NoEmpty##0#1#T#F#T#F#T###Main.' +
        'VAL3#0#0#F#F'
      #1055#1088#1086#1075#1088#1072#1084#1084#1072':#Cdr#FLTPRG####0#1#T#F#T#F#T###Main.VAL3#0#0#F#F#F#F'
      
        '#Cdr#MEM_FLTPRG#TButTextGet#Prog##0#1#T#F#T#T#T###Main.VAL3#-1#0' +
        '#F#F'
      #1047#1072#1103#1074#1082#1080':#Main#VAL5#TMultiGet##1#0#1#T#F#T#F#F####0#0#T#F'
      
        '#Cdr#FLTISPN#TRadioGet#Customize#'#1074#1089#1077'^'#1090#1086#1083#1100#1082#1086' '#1080#1089#1087#1086#1083#1085#1077#1085#1085#1099#1077'^'#1090#1086#1083#1100#1082#1086' '#1085 +
        #1077#1080#1089#1087#1086#1083#1085#1077#1085#1085#1099#1077'@NB0#0#1#T#F#T#F#F###Main.VAL5#0#0#T#F'
      
        '#Main#VAL6#TBoolGet##'#1087#1086#1089#1090#1091#1087#1080#1074#1096#1080#1077':@S#0#1#T#F#F#F#T###Main.VAL5#0#' +
        '0#T#F'
      #1089'#Cdr#FLTD1#TDateGet###0#1#T#F#T#F#T###Main.VAL5#0#0#T#F'
      #1087#1086'#Cdr#FLTD2#TDateGet###0#1#T#F#T#F#F###Main.VAL5#0#0#T#F'
      
        '#Main#VAL10#TBoolGet##'#1080#1089#1087#1086#1083#1085#1077#1085#1085#1099#1077':@S#0#1#T#F#F#F#T###Main.VAL5#0' +
        '#0#T#F'
      #1089'#Cdr#FLTISPD1#TDateGet###0#1#T#F#T#T#T###Main.VAL5#0#0#T#F'
      #1087#1086'#Cdr#FLTISPD2#TDateGet###0#1#T#F#T#T#F###Main.VAL5#0#0#T#F'
      '#Main#VAL7#TMultiGet###0#1#T#F#T#F#F####-1#0#T#F'
      #1055#1088#1080#1085#1103#1083':#Cdr#FLTTN####0#1#T#F#T#F#F###Main.VAL7#0#0#T#F#F#F'
      
        '#Cdr#MEM_FLTTN#TButTextGet#Cdr##0#1#T#F#T#T#T###Main.VAL7#-1#0#T' +
        '#F'
      '#Main#VAL8#TMultiGet###0#1#T#F#T#T#F####-1#0#T#F'
      #1048#1089#1087#1086#1083#1085#1080#1090#1077#1083#1100':#Cdr#FLTITN####0#1#T#F#T#T#F###Main.VAL8#0#0#T#F#F#F'
      
        '#Cdr#MEM_FLTITN#TButTextGet#Cdr##0#1#T#F#T#T#T###Main.VAL8#-1#0#' +
        'T#F'
      '#Main#VAL9#TMultiGet###0#1#T#F#T#T#F####-1#0#T#F'
      
        #1055#1088#1077#1076#1087#1086#1083#1072'-~'#1075#1072#1077#1084#1099#1081'~'#1080#1089#1087#1086#1083#1085#1080#1090#1077#1083#1100':#Cdr#FLTWTN####0#1#T#F#T#T#F###Main' +
        '.VAL9#0#0#T#F#F#F'
      
        '#Cdr#MEM_FLTWTN#TButTextGet#Cdr##0#1#T#F#T#T#T###Main.VAL9#-1#0#' +
        'T#F'
      '#Main#VAL4#TMultiGet##2#0#1#T#F#T#F#F####-1#0#F#F'
      
        '#Cdr#FLT#TBoolGet##'#1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1081' '#1092#1080#1083#1100#1090#1088'#0#1#T#F#T#F#F###Main.VA' +
        'L4#0#0#F#F'
      
        '#Main#FLTLS#TBtMskGet##@H'#1054#1089#1085#1086#1074#1099' '#1076#1083#1103' '#1092#1086#1088#1084#1091#1083#1099' '#1092#1080#1083#1100#1090#1088#1072'@FltLs()#0#1#' +
        'T#F#T#T#F###Main.VAL4#0#0#F#F'
      
        '#Cdr#MEM_FLT#TButFormGet#Flt#@H'#1060#1086#1088#1084#1091#1083#1072' '#1092#1080#1083#1100#1090#1088#1072'@@,@#0#1#T#F#T#T#F' +
        '####-1#-1#F#F')
    HelpContext = 0
    NmProc.Strings = (
      'Alt_F5##'#1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1080#1079' '#1086#1089#1085#1086#1074#1099'#EDIT##')
    NameWnd = 'OrgFlt'
    PnlAskByCancel = True
    PnlSortMode = smColumns
    OnFldChange = deFltFldChange
    OnFrmShow = deFltFrmShow
    OnKpProcKey = deFltKpProcKey
    OnPnlValid = deFltPnlValid
    Left = 224
    Top = 632
  end
  object btgOrg: TButTextGet
    TextReadOnly = False
    OnClick = btgOrgClick
    VName = 'Org'
    Left = 264
    Top = 584
  end
  object btgProg: TButGet
    OnDWFldValue = btgProgDWFldValue
    OnLogCompare = btgProgLogCompare
    VName = 'Prog'
    OnClick = btgProgClick
    Left = 304
    Top = 584
  end
  object deProgSel: TDefEdit
    DcmBased = False
    FrmBorderIcons = [biSystemMenu, biMinimize, biMaximize]
    FrmBorderStyle = bsSizeable
    FrmCaption = #1042#1099#1073#1086#1088' '#1087#1088#1086#1075#1088#1072#1084#1084
    Fields.Strings = (
      '#Main#PROG#TBoolMultiGet#NoEmpty##0#1#T#F#T#F#F####0#0#F#F')
    HelpContext = 0
    NameWnd = 'ProgSel'
    PnlAskByCancel = False
    PnlSortMode = smDefault
    Left = 304
    Top = 536
  end
  object dsZaj: TDataSource
    Left = 392
    Top = 536
  end
  object dsDoc: TDataSource
    Left = 568
    Top = 536
  end
  object deDoc: TDefEdit
    DcmBased = False
    FrmBorderIcons = [biSystemMenu, biMinimize, biMaximize]
    FrmBorderStyle = bsSizeable
    Fields.Strings = (
      #1053#1086#1084#1077#1088'#Doc#KD#TSimpleGet###0#1#T#F#T#F#F####0#0#F#F'
      #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077'#Doc#NAME#TSimpleGet###0#1#T#F#T#F#F####0#0#F#F')
    HelpContext = 0
    NameWnd = 'Doc'
    PnlAskByCancel = False
    PnlSortMode = smDefault
    OnFldCheck = deDocFldCheck
    OnFldExit = deDocFldExit
    Left = 568
    Top = 584
  end
  object deZajMov: TDefEdit
    DcmBased = False
    FrmBorderIcons = [biSystemMenu, biMinimize, biMaximize]
    FrmBorderStyle = bsSizeable
    FrmCaption = #1055#1077#1088#1077#1085#1086#1089' '#1079#1072#1103#1074#1082#1080' '#1085#1072' '#1076#1088#1091#1075#1091#1102' '#1087#1088#1086#1075#1088#1072#1084#1084#1091
    Fields.Strings = (
      #1050#1083#1080#1077#1085#1090'#Main#KOD#TCodeGet#List#@N@C#0#1#T#F#T#F#F####0#0#F#F'
      #1055#1088#1086#1075#1088#1072#1084#1084#1072'#Zaj#CP#TCodeGet#Prog##0#1#T#F#T#F#F####-1#0#F#F')
    HelpContext = 0
    NameWnd = 'ZajMov'
    PnlAskByCancel = False
    PnlSortMode = smDefault
    OnFldChange = deZajMovFldChange
    OnPnlValid = deZajMovPnlValid
    Left = 392
    Top = 584
  end
  object deOtd: TDefEdit
    DcmBased = False
    FrmBorderIcons = [biSystemMenu, biMinimize, biMaximize]
    FrmBorderStyle = bsSizeable
    Fields.Strings = (
      '#Main#OTDDIR#TDirGet#Dir##0#1#T#F#T#F#F####-1#0#F#F')
    HelpContext = 0
    NameWnd = 'Otd'
    PnlAskByCancel = False
    PnlSortMode = smDefault
    OnPnlValid = deOtdPnlValid
    Left = 872
    Top = 504
  end
  object dsOfis: TDataSource
    Left = 624
    Top = 536
  end
  object dsCng: TDataSource
    Left = 680
    Top = 536
  end
  object deCng: TDefEdit
    DcmBased = False
    FrmBorderIcons = [biSystemMenu, biMinimize, biMaximize]
    FrmBorderStyle = bsSizeable
    Fields.Strings = (
      #1053#1086#1084#1077#1088'#Cngv#KC#TSimpleGet###0#1#T#F#T#F#F####0#0#F#F'
      #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077'#Cngv#NAME#TSimpleGet###0#1#T#F#T#F#F####0#0#F#F'
      
        #1042#1080#1076' '#1087#1088#1086#1089#1084#1086#1090#1088#1072':#Cngv#TPVIEW#TRadioGet#Customize##0#1#T#F#T#F#T###' +
        '#0#0#F#F#F#F'
      
        '#Cngv#READONLY#TBoolGet##'#1058#1086#1083#1100#1082#1086' '#1076#1083#1103' '#1087#1088#1086#1089#1084#1086#1090#1088#1072'#0#1#T#F#T#T#F####0' +
        '#0#F#F#F#F'
      '#Main#VAL1#TMultiGet###0#1#T#F#T#T#F####-1#0#F#F#F#F'
      
        #1087#1072#1087#1086#1082'#Main#CNGD#TButTextGet#CngDir##0#1#T#F#T#T#F###Main.VAL1#-2' +
        '#0#F#F#F#F'
      
        #1092#1072#1081#1083#1086#1074'#Main#CNGF#TButTextGet#CngFile##0#1#T#F#T#T#F###Main.VAL1#' +
        '-2#0#F#F#F#F'
      
        #1060#1072#1081#1083' '#1076#1083#1103' '#1087#1088#1086#1089#1084#1086#1090#1088#1072' '#1080#1079#1084#1077#1085#1077#1085#1080#1081' ('#1087#1091#1089#1090#1086' - '#1080#1079#1084#1077#1085#1103#1077#1084#1099#1081' '#1092#1072#1081#1083')#Cngv#CMD#' +
        'TDirGet#FileAny##0#1#T#F#T#T#F####-1#0#F#F#F#F'
      
        #1057#1082#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1092#1072#1081#1083#1099' '#1087#1077#1088#1077#1076' '#1087#1088#1086#1089#1084#1086#1090#1088#1086#1084' '#1074#1086' '#1074#1088#1077#1084#1077#1085#1085#1091#1102' '#1087#1072#1087#1082#1091' ('#1089#1087#1080#1089#1086#1082' '#1095#1077 +
        #1088#1077#1079' ";")#Cngv#MEM_TMP#TButTextGet#CngFile##0#1#T#F#T#T#F####-1#0' +
        '#F#F#F#F'
      '#Cngv#COPYDIR#TDirGet#Dir##0#1#T#F#T#F#F####-1#0#F#F#F#F'
      
        '#Cngv#DIRCOPY#TBoolGet##'#1058#1086#1095#1085#1072#1103' '#1082#1086#1087#1080#1103'.~'#1042#1053#1048#1052#1040#1053#1048#1045'!!! '#1055#1077#1088#1077#1076' '#1082#1086#1087#1080#1088#1086#1074#1072 +
        #1085#1080#1077#1084' '#1080#1079' '#1074#1099#1096#1077#1091#1082#1072#1079#1072#1085#1085#1086#1081' '#1087#1072#1087#1082#1080' '#1091#1076#1072#1083#1103#1102#1090#1089#1103' '#1074#1089#1077' '#1092#1072#1081#1083#1099'.~'#1047#1072#1087#1088#1077#1097#1077#1085#1086' '#1091#1082#1072#1079#1099 +
        #1074#1072#1090#1100' '#1082#1086#1088#1085#1077#1074#1086#1081' '#1082#1072#1090#1072#1083#1086#1075' '#1080' '#1087#1072#1087#1082#1080' Windows.#0#1#T#F#T#T#F####-1#0#F#F' +
        '#F#F'
      
        #1042#1080#1076' '#1087#1088#1086#1075#1088#1072#1084#1084#1099'#Cngv#PROGID#TMenuGet#Customize##0#1#T#F#T#T#F####0' +
        '#0#F#F#F#F'
      
        #1054#1089#1085#1086#1074#1072' '#1086#1073#1097#1080#1093' '#1074#1077#1088#1089#1080#1081'#Cngv#LASTCNG#TDirGet#LastCng##0#1#T#F#T#T#F#' +
        '###0#0#F#F#F#T')
    HelpContext = 0
    NameWnd = 'Cng'
    PnlAskByCancel = False
    PnlSortMode = smDefault
    OnFldCheck = deCngFldCheck
    OnFldChange = deCngFldChange
    OnFldExit = deCngFldExit
    OnFrmShow = deCngFrmShow
    OnPnlValid = deCngPnlValid
    Left = 736
    Top = 536
  end
  object CngFileGet: TButTextGet
    Hint = #1044#1086#1073#1072#1074#1080#1090#1100
    Picture = 'Ourl_Plus'
    TextReadOnly = False
    OnClick = CngGetClick
    VName = 'CngFile'
    Left = 736
    Top = 584
  end
  object CngDirGet: TButTextGet
    Hint = #1044#1086#1073#1072#1074#1080#1090#1100
    Picture = 'Ourl_Plus'
    TextReadOnly = False
    OnClick = CngGetClick
    VName = 'CngDir'
    Left = 680
    Top = 584
  end
  object dlgCng: TOpenDialog
    Title = #1060#1072#1081#1083' '#1076#1083#1103' '#1087#1088#1086#1089#1084#1086#1090#1088#1072
    Left = 872
    Top = 264
  end
  object DirGet1: TDirGet
    VName = 'FileAny'
    OpenDialog = dlgCng
    Options = [dgNoCheckDir]
    Left = 872
    Top = 216
  end
  object DirLastGet: TButTextGet
    TextReadOnly = False
    OnClick = DirLastGetClick
    VName = 'DirLast'
    Left = 872
    Top = 408
  end
  object DeSendInt: TDefEdit
    DcmBased = False
    FrmBorderIcons = [biSystemMenu, biMinimize, biMaximize]
    FrmBorderStyle = bsSizeable
    FrmCaption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1087#1086' '#1080#1085#1090#1077#1088#1085#1077#1090#1091
    Fields.Strings = (
      #1042#1080#1076'#Main#SI_KP#TMenuGet#Prog##0#1#T#F#T#F#F####0#0#F#F#F#F'
      
        '#Main#SI_ONSEL#TBoolGet##'#1058#1086#1083#1100#1082#1086' '#1076#1083#1103' '#1090#1077#1082#1091#1097#1077#1081' '#1074#1099#1073#1086#1088#1082#1080' '#1087#1088#1086#1075#1088#1072#1084#1084'#0#1' +
        '#T#F#T#F#F####0#0#F#F#F#F'
      '#Main#SI_MULTI#TMultiGet##1#0#1#T#F#T#F#F####-1#0#F#F#F#F'
      
        '#Main#SI_OBJ#TRadioGet#SendInt##0#1#T#F#T#F#F###Main.SI_MULTI#0#' +
        '0#F#F#F#F'
      
        #1064#1072#1073#1083#1086#1085'#Main#SI_MSGPTRN#TSpGet###0#1#F#F#T#F#T###Main.SI_MULTI#-2' +
        '#-1#F#F#F#F'
      '#Main#SI_FILE#TDirGet#SendIntObn##0#1#T#F#T#F#F####-1#0#F#F#F#F'
      '#Main#SI_BG#TButGet#SendInt##0#1#T#F#T#F#F####-1#-1#F#F#F#F')
    HelpContext = 0
    NameWnd = 'SendInt'
    PnlAskByCancel = False
    PnlSortMode = smColumns
    OnFldCheck = DeSendIntFldCheck
    OnFldChange = DeSendIntFldChange
    OnPnlCngKey = DeSendIntPnlCngKey
    OnPnlValid = DeSendIntPnlValid
    Left = 592
    Top = 256
  end
  object RgSendInt: TRadioGet
    Items.Strings = (
      #1057#1086#1086#1073#1097#1077#1085#1080#1077
      #1054#1073#1085#1086#1074#1083#1077#1085#1080#1077
      #1044#1086#1087'.'#1087#1088#1086#1075#1088#1072#1084#1084#1099
      #1047#1072#1103#1074#1082#1072)
    VName = 'SendInt'
    Left = 592
    Top = 288
  end
  object DgSendIntObn: TDirGet
    VName = 'SendIntObn'
    OpenDialog = OdSendIntObn
    Options = []
    Left = 656
    Top = 288
  end
  object OdSendIntObn: TOpenDialog
    Options = [ofEnableSizing]
    Title = #1060#1072#1081#1083' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103
    Left = 688
    Top = 288
  end
  object BgSendInt: TButGet
    VName = 'SendInt'
    OnClick = BgSendIntClick
    Left = 624
    Top = 288
  end
  object DeZajIsp: TDefEdit
    DcmBased = False
    FrmBorderIcons = [biSystemMenu, biMinimize, biMaximize]
    FrmBorderStyle = bsSizeable
    FrmCaption = #1047#1072#1103#1074#1082#1072' '#1089' '#1080#1089#1087#1086#1083#1085#1077#1085#1080#1077#1084
    Fields.Strings = (
      #1058#1077#1082#1089#1090'#Main#SI_ZAJ_TXT#TSpGet###0#1#F#F#T#F#F####-2#-1#F#F#F#F'
      
        #1055#1088#1080#1085#1103#1083'#Main#SI_ZAJ_TN#TCodeGet#Cdr#@N@C@0#0#1#T#F#T#F#F####0#0#F' +
        '#F#F#F'
      #1055#1086#1089#1090#1091#1087#1080#1083#1072'#Main#VAL1#TMultiGet##2#0#1#T#F#T#F#F####0#0#F#F#F#F'
      
        '#Main#SI_ZAJ_DATE#TDateGet##@WEEK#0#1#T#F#T#F#F###Main.VAL1#0#0#' +
        'F#F#F#F'
      
        '#Main#SI_ZAJ_TIME#TTimeCurGet###0#1#T#F#T#F#F###Main.VAL1#0#0#F#' +
        'F#F#F'
      #1048#1089#1087#1086#1083#1085#1077#1085#1080#1077'#Main#VAL2#TMultiGet##1#0#1#T#F#T#F#F####0#0#F#F#F#F'
      
        '#Main#SI_ZAJ_ISPV#TRadioGet#Customize##0#1#T#F#T#F#F###Main.VAL2' +
        '#0#0#F#F#F#F'
      
        '#Main#SI_ZAJ_ISPTN#TCodeGet#Cdr#@N@C@0#0#1#T#F#T#F#F###Main.VAL2' +
        '#0#0#F#F#F#F'
      '#Main#VAL3#TMultiGet##2#0#1#T#F#T#F#F###Main.VAL2#0#0#F#F#F#F'
      
        '#Main#SI_ZAJ_DATE1#TDateGet##@WEEK#0#1#T#F#T#F#F###Main.VAL3#0#0' +
        '#F#F#F#F'
      
        '#Main#SI_ZAJ_TIME1#TTimeCurGet###0#1#T#F#T#F#F###Main.VAL3#0#0#F' +
        '#F#F#F'
      
        '-#Main#SI_ZAJ_TIME2#TTimeCurGet###0#1#T#F#T#F#F###Main.VAL3#0#0#' +
        'F#F#F#F')
    HelpContext = 0
    NameWnd = 'ZajIsp'
    PnlAskByCancel = False
    PnlSortMode = smColumns
    OnFldCheck = DeZajIspFldCheck
    Left = 720
    Top = 288
  end
  object deSelIsp: TDefEdit
    DcmBased = False
    FrmBorderIcons = [biSystemMenu, biMinimize, biMaximize]
    FrmBorderStyle = bsSizeable
    FrmCaption = #1042#1099#1073#1086#1088' '#1080#1089#1087#1086#1083#1085#1080#1090#1077#1083#1103
    Fields.Strings = (
      '#Main#SELISPSH#TSimpleGet###0#1#T#F#F#F#F####-1#0#F#F#F#F'
      #1050#1083#1080#1077#1085#1090'#Main#VAL1#TMultiGet##2#0#1#T#F#F#F#F####-2#0#F#F#F#F'
      
        '#Main#KOD#TCodeGet#List#@N@C#0#1#T#F#F#F#F###Main.VAL1#-1#0#F#F#' +
        'F#F'
      #1056#1077#1075'.'#8470'#Zaj#CP#TSimpleGet###0#1#T#F#F#F#F###Main.VAL1#0#0#F#F#F#F'
      
        #1050#1086#1083'-'#1074#1086' '#1080#1089#1087#1086#1083#1085#1080#1090#1077#1083#1077#1081'#Zaj#CNTISP#TSimpleGet###0#1#T#F#F#F#F####0#0' +
        '#F#F#F#F'
      #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100'#Cdr#TN#TCodeGet#Cdr##0#1#T#F#F#F#F####-2#0#F#F#F#F'
      
        #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1073#1072#1083#1083#1086#1074'#Main#BALL#TSimpleGet##99\'#39'999\'#39'999\'#39'999#0#1#T#' +
        'F#T#F#F####0#0#F#F#F#F')
    HelpContext = 0
    NameWnd = 'ZajSelIsp'
    PnlAskByCancel = False
    PnlSortMode = smColumns
    OnFldCheck = deSelIspFldCheck
    OnPnlValid = deSelIspPnlValid
    Left = 424
    Top = 632
  end
  object dePswd: TDefEdit
    DcmBased = False
    FrmBorderIcons = [biSystemMenu, biMinimize, biMaximize]
    FrmBorderStyle = bsSizeable
    FrmCaption = #1042#1074#1077#1076#1080#1090#1077' '#1087#1072#1088#1086#1083#1100
    Fields.Strings = (
      '#Main#PSWD#TPswdGet###0#1#T#F#T#F#F####0#0#F#F#F#F')
    HelpContext = 0
    NameWnd = 'ZajPswd'
    PnlAskByCancel = False
    PnlSortMode = smDefault
    OnPnlValid = dePswdPnlValid
    Left = 464
    Top = 633
  end
  object dmSftp: TDefMenu
    BevelInner = bvNone
    BevelOuter = bvLowered
    BevelWidth = 1
    BorderStyle = bsNone
    KeyBevel = 1
    KeySpot = 2
    KeyBetween = 2
    Keys.Strings = (
      '1###F#F#F#F#'
      '2###F#F#F#F#')
    FrmBorderIcons = []
    FrmBorderStyle = bsNone
    Left = 144
    Top = 8
  end
  object deDelDerLog: TDefEdit
    DcmBased = False
    FrmBorderIcons = [biSystemMenu, biMinimize, biMaximize]
    FrmBorderStyle = bsSizeable
    FrmCaption = #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1087#1080#1089#1080' '#1074' '#1087#1088#1086#1090#1086#1082#1086#1083#1072#1093' '#1080' '#1078#1091#1088#1085#1072#1083#1072#1093
    Fields.Strings = (
      
        #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1087#1080#1089#1080' '#1074' '#1087#1088#1086#1090#1086#1082#1086#1083#1072#1093' '#1076#1086'#GLOB#DDELDER#TDateGet###0#1#T#F#T' +
        '#F#F####0#0#F#F#F#F'
      
        #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1087#1080#1089#1080' '#1074' '#1078#1091#1088#1085#1072#1083#1072#1093' '#1076#1086'#GLOB#DDELLOG#TDateGet###0#1#T#F#T#F' +
        '#F####0#0#F#F#F#F')
    HelpContext = 0
    NameWnd = 'DelDerLog'
    PnlAskByCancel = False
    PnlSortMode = smColumns
    Left = 872
    Top = 544
  end
  object deMdFlt: TDefEdit
    DcmBased = False
    FrmBorderIcons = [biSystemMenu, biMinimize, biMaximize]
    FrmBorderStyle = bsSizeable
    FrmCaption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1076#1083#1103' '#1087#1088#1086#1089#1084#1086#1090#1088#1072' '#1086#1089#1085#1086#1074
    Fields.Strings = (
      #1060#1080#1083#1100#1090#1088'#Main#VAL3#TMultiGet##2#0#1#T#F#T#T#F####-1#-1#F#F#F#F'
      
        '#MDFLT#MDLD#TBoolGet##'#1055#1077#1088#1080#1086#1076'#0#1#T#F#T#F#F###Main.VAL3#0#0#F#F#F' +
        '#F'
      '#Main#VAL1#TMultiGet##2#0#1#T#F#T#T#F###Main.VAL3#0#0#F#F#F#F'
      
        #1089'#MDFLT#MDDB#TDateGet##@WEEK#0#1#T#F#T#T#F###Main.VAL1#0#0#F#F#F' +
        '#F'
      
        #1087#1086'#MDFLT#MDDE#TDateGet##@END@WEEK#0#1#T#F#T#T#F###Main.VAL1#0#0#' +
        'F#F#F#F'
      
        '#MDFLT#MDLGVERS#TBoolGet##'#1054#1073#1097#1072#1103' '#1074#1077#1088#1089#1080#1103'#0#1#T#F#T#F#T###Main.VAL3' +
        '#0#0#F#F#F#F'
      
        '#MDFLT#MDGVERS#TMenuGet#MDGVers#@C#0#1#T#F#T#T#F###Main.VAL3#0#0' +
        '#F#F#F#F'
      
        '#MDFLT#MDLFILE#TBoolGet##'#1054#1089#1085#1086#1074#1072'#0#1#T#F#T#F#T###Main.VAL3#0#0#F#' +
        'F#F#F'
      '#Main#VAL2#TMultiGet##2#0#1#T#F#T#T#F###Main.VAL3#-1#0#F#F#F#F'
      
        #1074#1080#1076'#MDFLT#MDPATH#TCodeGet#MDP##0#2#T#F#T#T#F###Main.VAL2#0#0#F#F' +
        '#F#T'
      
        '#MDFLT#MDFILE#TCodeGet#MDF#@0#0#2#T#F#T#T#F###Main.VAL2#-1#0#F#F' +
        '#F#T'
      
        '#MDFLT#MDLTHEMES#TBoolGet##'#1058#1077#1084#1099'#0#1#T#F#T#F#T###Main.VAL3#0#0#F#' +
        'F#F#F'
      
        '#MDFLT#MDTHEMES#TButGet#MDT##0#1#T#F#T#T#F###Main.VAL3#-1#-1#F#F' +
        '#F#F'
      
        '#MDFLT#MDDEL#TBoolMultiGet#NoEmpty##0#1#T#F#T#F#T###Main.VAL3#0#' +
        '0#F#F#F#F'
      '#Main#VAL4#TMultiGet##2#0#1#T#F#T#T#F####0#0#F#F#F#F')
    HelpContext = 0
    NameWnd = 'MdFlt'
    PnlAskByCancel = False
    PnlSortMode = smDefault
    OnFldCheck = deMdFltFldCheck
    OnFldChange = deMdFltFldChange
    OnFrmShow = deMdFltFrmShow
    OnPnlValid = deMdFltPnlValid
    Left = 592
    Top = 688
  end
  object LastCngGet: TDirGet
    VName = 'LastCng'
    OpenDialog = dlgLastCng
    Options = []
    Left = 768
    Top = 536
  end
  object dlgLastCng: TOpenDialog
    Title = #1054#1089#1085#1086#1074#1072' '#1086#1073#1097#1080#1093' '#1074#1077#1088#1089#1080#1081
    Left = 800
    Top = 536
  end
  object MDTGet: TButGet
    VName = 'MDT'
    Left = 632
    Top = 688
  end
  object rMDGVers: TRecVal
    NameRec = 'MDGVers'
    Fields.Strings = (
      'VERSCONF=N@H'#1042#1077#1088#1089#1080#1103'@'
      'VERSEXE=N@H'#1057#1073#1086#1088#1082#1072'@'
      'D=F@H'#1044#1072#1090#1072'@')
    Left = 672
    Top = 688
  end
  object rMDFirst: TRecVal
    NameRec = 'MDFirst'
    Fields.Strings = (
      'PATH=M@H'#1055#1072#1087#1082#1072' '#1089' '#1086#1089#1085#1086#1074#1072#1084#1080', '#1088#1072#1089#1087#1088#1077#1076#1077#1083#1105#1085#1085#1099#1084#1080' '#1087#1086' '#1086#1073#1097#1080#1084' '#1074#1077#1088#1089#1080#1103#1084'@')
    Left = 712
    Top = 688
  end
  object deMDFirst: TDefEdit
    DcmBased = False
    FrmBorderIcons = [biSystemMenu, biMinimize, biMaximize]
    FrmBorderStyle = bsSizeable
    FrmCaption = #1055#1077#1088#1074#1086#1085#1072#1095#1072#1083#1100#1085#1072#1103' '#1091#1089#1090#1072#1085#1086#1074#1082#1072' '#1086#1073#1097#1080#1093' '#1074#1077#1088#1089#1080#1081' '#1087#1086' '#1086#1089#1085#1086#1074#1072#1084
    Fields.Strings = (
      
        #1055#1072#1087#1082#1072' '#1089' '#1086#1089#1085#1086#1074#1072#1084#1080', '#1088#1072#1089#1087#1088#1077#1076#1077#1083#1105#1085#1085#1099#1084#1080' '#1087#1086' '#1086#1073#1097#1080#1084' '#1074#1077#1088#1089#1080#1103#1084'~'#1042' '#1085#1077#1081' '#1089#1086#1076#1077#1088#1078#1072 +
        #1090#1089#1103' '#1087#1072#1087#1082#1080' VVV\MODELS~VVV - '#1086#1073#1097#1072#1103' '#1074#1077#1088#1089#1080#1103'#MDFirst#PATH#TDirGet#Dir' +
        '#'#1055#1072#1087#1082#1072' '#1089' '#1086#1089#1085#1086#1074#1072#1084#1080', '#1088#1072#1089#1087#1088#1077#1076#1077#1083#1105#1085#1085#1099#1084#1080' '#1087#1086' '#1086#1073#1097#1080#1084' '#1074#1077#1088#1089#1080#1103#1084'~#0#1#T#F#T#F' +
        '#F####-1#0#F#F#F#T')
    HelpContext = 0
    NameWnd = 'DMFirst'
    PnlAskByCancel = False
    PnlSortMode = smDefault
    OnFldCheck = deMDFirstFldCheck
    Left = 744
    Top = 688
  end
  object rMdFlt: TRecVal
    NameRec = 'MDFLT'
    Fields.Strings = (
      'MDLD=L@H'#1054#1089#1085#1086#1074#1099': '#1092#1080#1083#1100#1090#1088' '#1087#1086' '#1087#1077#1088#1080#1086#1076#1091'@'
      'MDLGVERS=L@H'#1054#1089#1085#1086#1074#1099': '#1092#1080#1083#1100#1090#1088' '#1087#1086' '#1086#1073#1097#1077#1081' '#1074#1077#1088#1089#1080#1080'@'
      'MDLFILE=L@H'#1054#1089#1085#1086#1074#1099': '#1092#1080#1083#1100#1090#1088' '#1087#1086' '#1086#1089#1085#1086#1074#1077'@'
      'MDLTHEMES=L@H'#1054#1089#1085#1086#1074#1099': '#1092#1080#1083#1100#1090#1088' '#1087#1086' '#1090#1077#1084#1072#1084'@'
      'MDDB=D@H'#1054#1089#1085#1086#1074#1099': '#1085#1072#1095#1072#1083#1086' '#1087#1077#1088#1080#1086#1076#1072'@'
      'MDDE=D@H'#1054#1089#1085#1086#1074#1099': '#1082#1086#1085#1077#1094' '#1087#1077#1088#1080#1086#1076#1072'@'
      'MDGVERS=N@H'#1054#1089#1085#1086#1074#1099': '#1086#1073#1097#1072#1103' '#1074#1077#1088#1089#1080#1103'@'
      'MDPATH=S8@H'#1054#1089#1085#1086#1074#1099': '#1087#1072#1087#1082#1072'@'
      'MDFILE=S8@H'#1054#1089#1085#1086#1074#1099': '#1092#1072#1081#1083'@'
      'MDTHEMES=M@H'#1054#1089#1085#1086#1074#1099': '#1090#1077#1084#1099'@'
      'MDDEL=S2#++@H'#1054#1089#1085#1086#1074#1099': '#1085#1077' '#1091#1076#1072#1083#1077#1085#1086'/'#1091#1076#1072#1083#1077#1085#1086'@')
    Left = 552
    Top = 688
  end
end
