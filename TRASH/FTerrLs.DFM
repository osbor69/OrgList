inherited TerrLs: TTerrLs
  Caption = ''
  PixelsPerInch = 120
  TextHeight = 17
  inherited RbPanel1: TRbPanel
    inherited RbPanel2: TRbPanel
      inherited Browl1: TBrowl
        NmProc.Strings = (
          'F3#'#1057#1084#1077#1085#1080#1090#1100'#'#1057#1084#1077#1085#1080#1090#1100' '#1085#1086#1084#1077#1088' '#1090#1077#1088#1088#1080#1090#1086#1088#1080#1080'#LIST##'
          'F4#'#1057#1082#1086#1087#1080#1088#1086#1074#1072#1090#1100'##LIST##'
          'F5#'#1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100'##LIST##'
          'F7#'#1044#1086#1073#1072#1074#1080#1090#1100'##LIST##'
          'F8#'#1059#1076#1072#1083#1080#1090#1100'##LIST##')
        OnBrowlKey = Browl1BrowlKey
      end
    end
  end
  object de: TDefEdit
    DcmBased = False
    FrmBorderIcons = [biSystemMenu, biMinimize, biMaximize]
    FrmBorderStyle = bsSizeable
    Fields.Strings = (
      #1053#1086#1084#1077#1088'#Terr#KT#TSimpleGet###0#1#T#F#T#F#F####0#0#F#F'
      #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077'#Terr#NAME#TSimpleGet###0#1#T#F#T#F#F####0#0#F#F')
    HelpContext = 0
    NameWnd = 'Terr'
    PnlAskByCancel = False
    PnlSortMode = smDefault
    OnFldCheck = deFldCheck
    OnFldExit = deFldExit
    Left = 112
  end
end
