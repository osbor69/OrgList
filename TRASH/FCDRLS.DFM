inherited CdrLs: TCdrLs
  Caption = ''
  PixelsPerInch = 96
  TextHeight = 15
  inherited RbPanel1: TRbPanel
    inherited RbPanel2: TRbPanel
      inherited Browl1: TBrowl
        NmProc.Strings = (
          'F2#'#1057#1090#1072#1090#1091#1089'#'#1057#1087#1080#1089#1086#1082' '#1080#1079#1084#1077#1085#1077#1085#1080#1081' '#1089#1090#1072#1090#1091#1089#1072'#LIST##'
          'F4#'#1057#1082#1086#1087#1080#1088#1086#1074#1072#1090#1100'##LIST##'
          'F5#'#1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100'##LIST##'
          'F7#'#1044#1086#1073#1072#1074#1080#1090#1100'##LIST##'
          'F8#'#1059#1076#1072#1083#1080#1090#1100'##LIST##'
          
            'Ctrl_F8#'#1053#1080#1082#1086#1075#1086' '#1085#1077#1090'#'#1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1089#1090#1072#1090#1091#1089' "'#1085#1077#1090'" '#1076#1083#1103' '#1074#1089#1077#1093' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077 +
            #1081'#LIST##'
          'Ctrl_P##'#1057#1084#1077#1085#1080#1090#1100' '#1087#1072#1088#1086#1083#1100'#LIST##')
        OnBrMouseDown = Browl1BrMouseDown
        OnBrowlKey = Browl1BrowlKey
        OnGrayCell = Browl1GrayCell
        Options = [dgTitles, dgColLines, dgRowLines, dgAlwaysShowSelection]
        OnDrawColumnCell = Browl1DrawColumnCell
        OnMouseMove = Browl1MouseMove
        OnMouseUp = Browl1MouseUp
      end
    end
  end
  object de: TDefEdit
    DcmBased = False
    FrmBorderIcons = [biSystemMenu, biMinimize, biMaximize]
    FrmBorderStyle = bsSizeable
    Fields.Strings = (
      #1053#1086#1084#1077#1088'#CDR#TN#TSimpleGet###0#1#T#F#T#F#F####0#0#F#F'
      
        #1060#1072#1084#1080#1083#1080#1103' '#1048#1084#1103' '#1054#1090#1095#1077#1089#1090#1074#1086'#CDR#NAME#TSimpleGet###0#1#T#F#T#F#F####0#0#' +
        'F#F'
      
        '#CDR#ADMZAJ#TBoolGet##'#1040#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088' '#1079#1072#1103#1074#1086#1082'#0#1#T#F#T#F#F####0#0#' +
        'F#F#F#F'
      '#CDR#OUT#TBoolGet##'#1042#1099#1073#1099#1074#1096#1080#1081'#0#1#T#F#T#F#F####0#0#F#F#F#F'
      
        '#CdrLs#TELON#TBoolGet##'#1042#1082#1083#1102#1095#1077#1085' '#1087#1088#1080#1105#1084' '#1089#1086#1086#1073#1097#1077#1085#1080#1081' '#1074' Telegram '#1086#1090' '#1076#1088#1091 +
        #1075#1080#1093' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081'#0#1#T#F#T#F#F####0#0#F#F#F#F'
      
        #1057#1090#1072#1090#1091#1089'#CDR#STATUS#TRadioGet#Customize##0#1#T#F#T#F#F####0#0#F#F#' +
        'F#F'
      #1058#1077#1083#1077#1092#1086#1085'#CDR#PHONE#TComboGet#Phone##0#1#T#F#T#T#F####0#0#F#F'
      #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077'#CDR#PRIM#TSimpleGet###0#1#T#F#T#F#F####0#0#F#F#F#F')
    HelpContext = 0
    NameWnd = 'Cdr'
    PnlAskByCancel = False
    PnlSortMode = smColumns
    OnFldCheck = deFldCheck
    OnFldChange = deFldChange
    OnFldExit = deFldExit
    OnFrmHide = deFrmHide
    OnFrmShow = deFrmShow
    OnPnlValid = dePnlValid
    Left = 120
  end
  object PhoneGet: TComboGet
    OnAfterList = PhoneGetAfterList
    OnListOwner = PhoneGetListOwner
    VName = 'Phone'
    Duplicates = dupIgnore
    ItemHeight = 0
    Sorted = False
    OnListResult = PhoneGetListResult
    LenName = 0
    Left = 120
    Top = 24
  end
  object Rec: TRecVal
    NameRec = 'CdrLs'
    Fields.Strings = (
      'PSWD=S10@H'#1055#1072#1088#1086#1083#1100'@'
      
        'TELON=L@H'#1042#1082#1083#1102#1095#1077#1085' '#1087#1088#1080#1105#1084' '#1089#1086#1086#1073#1097#1077#1085#1080#1081' '#1074' Telegram '#1086#1090' '#1076#1088#1091#1075#1080#1093' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077 +
        #1083#1077#1081'@')
    Left = 16
    Top = 1
  end
  object dmStatus: TDefMenu
    BevelInner = bvNone
    BevelOuter = bvLowered
    BevelWidth = 1
    BorderStyle = bsNone
    KeyBevel = 1
    KeySpot = 2
    KeyBetween = 2
    FrmBorderIcons = [biSystemMenu, biMinimize]
    FrmBorderStyle = bsToolWindow
    FrmCaption = #1057#1090#1072#1090#1091#1089
    Left = 200
  end
  object dmPhone: TDefMenu
    BevelInner = bvNone
    BevelOuter = bvLowered
    BevelWidth = 1
    BorderStyle = bsNone
    KeyBevel = 1
    KeySpot = 2
    KeyBetween = 2
    FrmBorderIcons = [biSystemMenu, biMinimize]
    FrmBorderStyle = bsToolWindow
    FrmCaption = #1058#1077#1083#1077#1092#1086#1085
    Left = 232
  end
  object dePswd: TDefEdit
    DcmBased = False
    FrmBorderIcons = [biSystemMenu, biMinimize, biMaximize]
    FrmBorderStyle = bsSizeable
    Fields.Strings = (
      '#CdrLs#PSWD#TPswdGet##++~TFF~^^#0#1#T#F#T#F#F####0#0#F#F#F#F')
    HelpContext = 0
    NameWnd = 'CdrPswd'
    PnlAskByCancel = False
    PnlSortMode = smDefault
    Left = 160
  end
end
