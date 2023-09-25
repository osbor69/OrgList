inherited DrvLs: TDrvLs
  Caption = ''
  PixelsPerInch = 120
  TextHeight = 17
  inherited RbPanel1: TRbPanel
    inherited RbPanel2: TRbPanel
      inherited Browl1: TBrowl
        NmProc.Strings = (
          'F3#'#1057#1084#1077#1085#1080#1090#1100'#'#1057#1084#1077#1085#1080#1090#1100' '#1085#1086#1084#1077#1088'#LIST##'
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
      #1053#1086#1084#1077#1088'#Drv#ND#TSimpleGet###0#1#T#F#T#F#F####0#0#F#F#F#F'
      
        #1057#1077#1090#1077#1074#1086#1077' '#1080#1084#1103'#Drv#NAME#TComboGet#DrvName#@L~0#0#1#T#F#T#F#F####0#0' +
        '#F#F'
      
        #1048#1084#1103' '#1076#1083#1103' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103'#Drv#KD#TComboGet#DrvKd#@L~1#0#1#T#F#T#F#F###' +
        '#0#0#F#F'
      #1051#1086#1082#1072#1083#1100#1085#1099#1081' '#1076#1080#1089#1082'#Drv#LOCAL#TSimpleGet###0#2#T#F#T#T#F####0#0#F#F'
      #1055#1072#1087#1082#1072'#Drv#DIR#TSimpleGet###0#1#T#F#T#T#F####-2#0#F#F'
      
        'IP-'#1072#1076#1088#1077#1089'#Drv#IP#TSimpleGet##999.999.999.999#0#1#T#F#T#T#F####0#0' +
        '#F#F'
      #1058#1077#1083#1077#1092#1086#1085'#Drv#PHONE#TSimpleGet###0#1#T#F#T#T#F####0#0#F#F'
      #1057#1077#1088#1074#1077#1088' FB#Drv#MULTIGET#TMultiGet##2#0#1#T#F#T#T#F####0#0#F#F#F#F'
      
        '#Drv#FBVERS#TMenuGet#FbVersWithEmpty##0#1#T#F#T#T#F###Drv.MULTIG' +
        'ET#0#0#F#F#F#F'
      
        '#Drv#FBPORT#TSpinGet##1,65535#0#1#T#F#T#T#F###Drv.MULTIGET#0#0#F' +
        '#F#F#F'
      
        '#Drv#FBVERS2#TMenuGet#FbVersWithEmpty##0#1#T#F#T#T#T###Drv.MULTI' +
        'GET#0#0#F#F#F#F'
      
        '#Drv#FBPORT2#TSpinGet##1,65535#0#1#T#F#T#T#F###Drv.MULTIGET#0#0#' +
        'F#F#F#F'
      
        '#Drv#FBVERS3#TMenuGet#FbVersWithEmpty##0#1#T#F#T#T#T###Drv.MULTI' +
        'GET#0#0#F#F#F#F'
      
        '#Drv#FBPORT3#TSpinGet##1,65535#0#1#T#F#T#T#F###Drv.MULTIGET#0#0#' +
        'F#F#F#F'
      
        '#Drv#FBVERS4#TMenuGet#FbVersWithEmpty##0#1#T#F#T#T#T###Drv.MULTI' +
        'GET#0#0#F#F#F#F'
      
        '#Drv#FBPORT4#TSpinGet##1,65535#0#1#T#F#T#T#F###Drv.MULTIGET#0#0#' +
        'F#F#F#F'
      
        '#Drv#FBVERS5#TMenuGet#FbVersWithEmpty##0#1#T#F#T#T#T###Drv.MULTI' +
        'GET#0#0#F#F#F#F'
      
        '#Drv#FBPORT5#TSpinGet##1,65535#0#1#T#F#T#T#F###Drv.MULTIGET#0#0#' +
        'F#F#F#F')
    HelpContext = 0
    NameWnd = 'Drv'
    PnlAskByCancel = False
    PnlSortMode = smColumns
    OnFldCheck = deFldCheck
    OnFldChange = deFldChange
    OnFldExit = deFldExit
    OnFrmShow = deFrmShow
    Left = 192
  end
  object KdGet: TComboGet
    VName = 'DrvKd'
    Duplicates = dupIgnore
    ItemHeight = 0
    Sorted = True
    LenName = 1
    Left = 224
  end
  object NameGet: TComboGet
    VName = 'DrvName'
    Duplicates = dupIgnore
    ItemHeight = 0
    Sorted = True
    OnDrawItem = NameGetDrawItem
    LenName = 0
    Left = 256
  end
  object MgFbVersWithEmpty: TMenuGet
    VName = 'FbVersWithEmpty'
    UserItems = False
    LenCode = 0
    LenName = 0
    Left = 288
  end
end
