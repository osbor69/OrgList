object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 400
  Top = 170
  Height = 721
  Width = 586
  object ListGet: TCodeGet
    VName = 'List'
    FieldsName = 'UPNAME'
    OrderCode = 1
    OrderName = 2
    Part = 'select_worder'
    MulPar.Strings = (
      'globkey="%"'
      'cod_c="%"'
      'table=LIST')
    TrimLeft = False
    ListFindEqual = False
    OnStrDop = ListGetStrDop
    LenCode = 0
    LenName = 30
    Left = 96
    Top = 472
  end
  object SimpleGet1: TSimpleGet
    Left = 24
    Top = 24
  end
  object RCdr: TRecDB
    NameRec = 'Cdr'
    OnCalculate = RUpNameCalculate
    DateWithTime = False
    MsgCheck = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100' '#1089' '#1090#1072#1082#1080#1084' '#1085#1086#1084#1077#1088#1086#1084' '#1091#1078#1077' '#1077#1089#1090#1100
    NameDB = 'CDR'
    Prim = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080
    Left = 216
    Top = 24
  end
  object ROrg: TRecDB
    NameRec = 'Org'
    DateWithTime = False
    NameDB = 'ORG'
    Prim = #1059#1085#1080#1082#1072#1083#1100#1085#1099#1077' '#1085#1086#1084#1077#1088#1072' '#1082#1083#1080#1077#1085#1090#1086#1074
    Left = 216
    Top = 80
  end
  object RList: TRecDBDef
    NameRec = 'dop_'
    DateWithTime = False
    NameDB = 'LIST'
    Prim = #1050#1083#1080#1077#1085#1090#1099
    DDatIsCod = False
    DDatMaxLenCod = 0
    DWName = #1044#1072#1085#1085#1099#1077' '#1087#1086' '#1082#1083#1080#1077#1085#1090#1091
    DWPrefix = #1044#1055
    DynamicVid = 0
    OnDWFldSeek = RListDWFldSeek
    OnDWTrans = RListDWTrans
    Left = 272
    Top = 80
  end
  object RVan: TRecDB
    NameRec = 'Van'
    DateWithTime = False
    NameDB = 'VAN'
    Prim = #1042#1080#1076#1099' '#1072#1085#1072#1083#1080#1090#1080#1095#1077#1089#1082#1086#1075#1086' '#1091#1095#1077#1090#1072
    Left = 272
    Top = 24
  end
  object BoolMultiGet1: TBoolMultiGet
    RVid = #1054#1090#1084#1077#1090#1082#1072' '#1079#1085#1072#1095#1077#1085#1080#1081
    Left = 24
    Top = 80
  end
  object DirGet1: TDirGet
    RVid = #1042#1074#1086#1076' '#1087#1072#1087#1082#1080
    VName = 'Dir'
    Options = [dgCreatePrompt]
    Left = 24
    Top = 128
  end
  object DrvGet: TCodeGet
    RVid = #1057#1077#1090#1077#1074#1086#1081' '#1076#1080#1089#1082
    VName = 'Drv'
    FieldsCode = 'ND'
    FieldsName = 'UPNAME'
    OrderCode = 1
    OrderName = 2
    Part = 'select_worder'
    MulPar.Strings = (
      'globkey="%"'
      'cod_c="%"'
      'table=DRV'
      'c_list=*'
      'where=ND like {cod_c}')
    TrimLeft = False
    ListFindEqual = False
    OnStrDop = DrvGetStrDop
    LenCode = 0
    LenName = 0
    Left = 96
    Top = 80
  end
  object RDrv: TRecDB
    NameRec = 'Drv'
    OnCalculate = RUpNameCalculate
    DateWithTime = False
    MsgCheck = #1044#1080#1089#1082' '#1089' '#1090#1072#1082#1080#1084' '#1085#1086#1084#1077#1088#1086#1084' '#1091#1078#1077' '#1077#1089#1090#1100'.'
    NameDB = 'DRV'
    Prim = #1057#1077#1090#1077#1074#1099#1077' '#1076#1080#1089#1082#1080
    OnNewRec = RDrvNewRec
    Left = 216
    Top = 184
  end
  object RProg: TRecDBDef
    NameRec = 'Prog'
    OnCalculate = RProgCalculate
    DateWithTime = False
    MsgCheck = 
      #1055#1088#1086#1075#1088#1072#1084#1084#1072' '#1089' '#1090#1072#1082#1080#1084' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1086#1085#1085#1099#1084' '#1085#1086#1084#1077#1088#1086#1084' '#1091#1078#1077' '#1077#1089#1090#1100' '#1091' '#1076#1072#1085#1085#1086#1075#1086' '#1082#1083#1080 +
      #1077#1085#1090#1072'.'
    NameDB = 'PROG'
    Prim = #1055#1088#1086#1075#1088#1072#1084#1084#1099
    DDatIsCod = False
    DDatMaxLenCod = 0
    DWName = #1044#1072#1085#1085#1099#1077' '#1087#1086' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
    DWPrefix = #1055#1056#1043
    DynamicVid = 0
    OnDWCanDel = RProgDWCanDel
    OnDWCngName = RProgDWCngName
    OnDWFldSeek = RProgDWFldSeek
    OnDWRdbSeek = RProgDWRdbSeek
    OnDWTrans = RProgDWTrans
    OnDWVarValid = RProgDWVarValid
    Left = 216
    Top = 136
  end
  object DateGet1: TDateGet
    Left = 24
    Top = 176
  end
  object NumGet1: TNumGet
    Left = 24
    Top = 232
  end
  object RadioGet1: TRadioGet
    RVid = #1042#1099#1073#1086#1088' '#1079#1085#1072#1095#1077#1085#1080#1081
    VName = 'Customize'
    Left = 24
    Top = 280
  end
  object TblChkGet1: TTblChkGet
    Left = 24
    Top = 328
  end
  object schBold: TSchem
    Caption = #1042#1099#1076#1077#1083#1077#1085#1085#1099#1077' '#1076#1072#1085#1085#1099#1077' '#1087#1086' '#1082#1083#1080#1077#1085#1090#1091
    CaptSmall = 'OrgBold'
    DefColor1 = clBtnFace
    DefColor2 = clBtnFace
    DefColorW = clBtnFace
    DefFont0800.Font1.Charset = RUSSIAN_CHARSET
    DefFont0800.Font1.Color = clRed
    DefFont0800.Font1.Height = -12
    DefFont0800.Font1.Name = 'Courier New'
    DefFont0800.Font1.Style = [fsBold]
    DefFont0800.Font2.Charset = RUSSIAN_CHARSET
    DefFont0800.Font2.Color = clBlack
    DefFont0800.Font2.Height = -12
    DefFont0800.Font2.Name = 'Courier New'
    DefFont0800.Font2.Style = [fsBold]
    DefFont0800.FontW.Charset = RUSSIAN_CHARSET
    DefFont0800.FontW.Color = clBlack
    DefFont0800.FontW.Height = -12
    DefFont0800.FontW.Name = 'Courier New'
    DefFont0800.FontW.Style = [fsBold]
    DefFont1024.Font1.Charset = RUSSIAN_CHARSET
    DefFont1024.Font1.Color = clRed
    DefFont1024.Font1.Height = -15
    DefFont1024.Font1.Name = 'Courier New'
    DefFont1024.Font1.Style = [fsBold]
    DefFont1024.Font2.Charset = RUSSIAN_CHARSET
    DefFont1024.Font2.Color = clBlack
    DefFont1024.Font2.Height = -15
    DefFont1024.Font2.Name = 'Courier New'
    DefFont1024.Font2.Style = [fsBold]
    DefFont1024.FontW.Charset = RUSSIAN_CHARSET
    DefFont1024.FontW.Color = clBlack
    DefFont1024.FontW.Height = -15
    DefFont1024.FontW.Name = 'Courier New'
    DefFont1024.FontW.Style = [fsBold]
    NameColor2 = #1094#1074#1077#1090' '#1092#1086#1085#1072' '#1087#1086#1083#1103
    NameFont1 = #1087#1086#1083#1077' '#1076#1083#1103' '#1087#1088#1086#1089#1084#1086#1090#1088#1072
    NameFont2 = #1087#1086#1076#1089#1082#1072#1079#1082#1072
    Options = [schColor2, schFont1, schFont2]
    OnSample = schBoldSample
    Left = 338
    Top = 24
  end
  object MenuGet1: TMenuGet
    RVid = #1042#1099#1073#1086#1088' '#1079#1085#1072#1095#1077#1085#1080#1081
    RVName = #1089' '#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077#1084' '#1082#1086#1076#1086#1074' '#1079#1085#1072#1095#1077#1085#1080#1081
    VName = 'Customize'
    UserItems = True
    LenCode = 0
    LenName = 0
    Left = 24
    Top = 376
  end
  object ProgGet: TMenuGet
    VName = 'Prog'
    UserItems = False
    LenCode = 2
    LenName = 0
    Left = 96
    Top = 320
  end
  object RZaj: TRecDB
    NameRec = 'Zaj'
    OnCalculate = RZajCalculate
    DateWithTime = True
    NameDB = 'ZAJ'
    Prim = #1047#1072#1103#1074#1082#1080
    OnNewRec = RZajNewRec
    Left = 216
    Top = 232
  end
  object RMsg: TRecDB
    NameRec = 'Msg'
    OnCalculate = RMsgCalculate
    DateWithTime = True
    NameDB = 'MSG'
    Prim = #1057#1086#1086#1073#1097#1077#1085#1080#1103
    OnNewRec = RMsgNewRec
    Left = 216
    Top = 280
  end
  object BtMskGet1: TBtMskGet
    Left = 24
    Top = 424
  end
  object StatusGet: TRadioGet
    VName = 'Status'
    Left = 152
    Top = 80
  end
  object RDoc: TRecDB
    NameRec = 'DOC'
    DateWithTime = False
    MsgCheck = #1044#1086#1082#1091#1084#1077#1085#1090' '#1089' '#1090#1072#1082#1080#1084' '#1085#1086#1084#1077#1088#1086#1084' '#1091#1078#1077' '#1077#1089#1090#1100
    NameDB = 'DOC'
    Prim = #1044#1086#1082#1091#1084#1077#1085#1090#1099
    OnNewRec = RDocNewRec
    Left = 216
    Top = 328
  end
  object ProgCpGet: TCodeGet
    VName = 'Prog'
    FieldsCode = 'CP'
    OrderCode = 1
    OrderName = 2
    Part = 'select_worder'
    MulPar.Strings = (
      'globkey="%"'
      'cod_c="%"'
      'table=PROG'
      'c_list=*'
      'ko=0'
      'cp=CP<>""'
      'where=KO={ko} and {cp} and CP like {cod_c}')
    TrimLeft = False
    ListFindEqual = False
    OnStrName = ProgCpGetStrName
    LenCode = 0
    LenName = 0
    Left = 96
    Top = 136
  end
  object ROfis: TRecDB
    NameRec = 'Ofis'
    DateWithTime = False
    NameDB = 'OFIS'
    Prim = #1054#1092#1080#1089
    Left = 216
    Top = 376
  end
  object RCngv: TRecDB
    NameRec = 'Cngv'
    DateWithTime = False
    MsgCheck = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1089' '#1090#1072#1082#1080#1084' '#1085#1086#1084#1077#1088#1086#1084' '#1091#1078#1077' '#1077#1089#1090#1100
    NameDB = 'CNGV'
    Prim = #1048#1079#1084#1077#1085#1077#1085#1080#1103
    OnNewRec = RCngvNewRec
    Left = 216
    Top = 424
  end
  object RgnGet: TCodeGet
    VName = 'Rgn'
    FieldsCode = 'KR'
    FieldsName = 'UPNAME'
    OrderCode = 1
    OrderName = 2
    Part = 'select_worder'
    MulPar.Strings = (
      'globkey="%"'
      'cod_c="%"'
      'table=RGN'
      'c_list=*'
      'where=KR like {cod_c}')
    TrimLeft = False
    ListFindEqual = False
    LenCode = 0
    LenName = 0
    Left = 96
    Top = 232
  end
  object RRgn: TRecDB
    NameRec = 'Rgn'
    OnCalculate = RUpNameCalculate
    DateWithTime = False
    MsgCheck = #1056#1077#1075#1080#1086#1085' '#1089' '#1090#1072#1082#1080#1084' '#1085#1086#1084#1077#1088#1086#1084' '#1091#1078#1077' '#1077#1089#1090#1100
    NameDB = 'RGN'
    Prim = #1056#1077#1075#1080#1086#1085#1099
    OnNewRec = RRgnNewRec
    Left = 216
    Top = 472
  end
  object ProgNpGet: TCodeGet
    VName = 'ProgNp'
    FieldsCode = 'NP'
    OrderCode = 1
    OrderName = 2
    Part = 'select_worder'
    MulPar.Strings = (
      'globkey="%"'
      'cod_c="%"'
      'table=PROG'
      'c_list=*'
      'ko=0'
      'where=KO={ko} and NP like {cod_c}')
    TrimLeft = False
    ListFindEqual = False
    OnStrName = ProgCpGetStrName
    LenCode = 0
    LenName = 0
    Left = 96
    Top = 184
  end
  object RProgCalc: TRecDBDef
    NameRec = 'ProgCalc'
    OnCalculate = RProgCalculate
    DateWithTime = False
    MsgCheck = 
      #1055#1088#1086#1075#1088#1072#1084#1084#1072' '#1089' '#1090#1072#1082#1080#1084' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1086#1085#1085#1099#1084' '#1085#1086#1084#1077#1088#1086#1084' '#1091#1078#1077' '#1077#1089#1090#1100' '#1091' '#1076#1072#1085#1085#1086#1075#1086' '#1082#1083#1080 +
      #1077#1085#1090#1072'.'
    NameDB = 'PROG'
    DDatIsCod = False
    DDatMaxLenCod = 0
    DWName = #1044#1072#1085#1085#1099#1077' '#1087#1086' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
    DWPrefix = #1055#1056#1043
    DynamicVid = 0
    OnDWCanDel = RProgDWCanDel
    OnDWCngName = RProgDWCngName
    OnDWFldSeek = RProgDWFldSeek
    OnDWRdbSeek = RProgDWRdbSeek
    OnDWTrans = RProgDWTrans
    OnDWVarValid = RProgDWVarValid
    Left = 272
    Top = 136
  end
  object TerrGet: TCodeGet
    VName = 'Terr'
    FieldsCode = 'KT'
    FieldsName = 'UPNAME'
    OrderCode = 1
    OrderName = 2
    Part = 'select_worder'
    MulPar.Strings = (
      'globkey="%"'
      'cod_c="%"'
      'table=TERR'
      'c_list=*'
      'where=KT like {cod_c}')
    TrimLeft = False
    ListFindEqual = False
    LenCode = 0
    LenName = 0
    Left = 96
    Top = 280
  end
  object RTerr: TRecDB
    NameRec = 'Terr'
    OnCalculate = RUpNameCalculate
    DateWithTime = False
    MsgCheck = #1058#1077#1088#1088#1080#1090#1086#1088#1080#1103' '#1089' '#1090#1072#1082#1080#1084' '#1085#1086#1084#1077#1088#1086#1084' '#1091#1078#1077' '#1077#1089#1090#1100
    NameDB = 'TERR'
    Prim = #1058#1077#1088#1088#1080#1090#1086#1088#1080#1080
    OnNewRec = RTerrNewRec
    Left = 216
    Top = 520
  end
  object RAcc: TRecDB
    NameRec = 'ACC'
    OnCalculate = RUpNameCalculate
    DateWithTime = False
    MsgCheck = #1059#1095#1105#1090#1085#1072#1103' '#1079#1072#1087#1080#1089#1100' '#1089' '#1090#1072#1082#1080#1084' '#1085#1086#1084#1077#1088#1086#1084' '#1091#1078#1077' '#1077#1089#1090#1100
    NameDB = 'ACC'
    Prim = #1059#1095#1105#1090#1085#1099#1077' '#1079#1072#1087#1080#1089#1080
    Left = 272
    Top = 184
  end
  object AccGet: TCodeGet
    VName = 'Acc'
    FieldsCode = 'ACID'
    FieldsName = 'UPNAME'
    OrderCode = 1
    OrderName = 2
    Part = 'select_worder'
    MulPar.Strings = (
      'globkey="%"'
      'cod_c="%"'
      'table=ACC'
      'c_list=*'
      'where=ACID like {cod_c}')
    TrimLeft = False
    ListFindEqual = False
    OnStrDop = AccGetStrDop
    LenCode = 0
    LenName = 0
    Left = 96
    Top = 368
  end
  object SrvGet: TCodeGet
    VName = 'VnFtpSrv'
    FieldsCode = 'SRVID'
    FieldsName = 'SRVADDR'
    OrderCode = 1
    OrderName = 2
    Part = 'select_worder'
    MulPar.Strings = (
      'globkey="%"'
      'cod_c="%"'
      'table=FTPSRV'
      'c_list=*'
      'where=SRVID like {cod_c}')
    TrimLeft = False
    ListFindEqual = False
    OnStrDop = SrvGetStrDop
    OnStrName = SrvGetStrName
    LenCode = 2
    LenName = 40
    Left = 96
    Top = 416
  end
  object RSrv: TRecDB
    NameRec = 'FTPSRV'
    DateWithTime = False
    MsgCheck = #1057#1077#1088#1074#1077#1088' '#1089' '#1090#1072#1082#1080#1084' '#1085#1086#1084#1077#1088#1086#1084' '#1091#1078#1077' '#1077#1089#1090#1100
    NameDB = 'FTPSRV'
    Prim = #1057#1077#1088#1074#1077#1088#1099
    OnNewRec = RSrvNewRec
    Left = 272
    Top = 232
  end
  object deAcc: TDefEdit
    DcmBased = False
    DcmDef = 
      'UA'#1050'CBAe'#1046'QIECBAe'#1046'QIECBAe'#1046'QIECBAe'#1046'QIECBAe'#1046'QIECBAe'#1046'QIECBAe'#1046'QIEAAAAA' +
      'AAAAAAMAAAAAAAABBe'#1046'QQEABAeAQAAAA'#1054'AI'#1046'AI'#1078'CAeUAAA'#1078'CBeA'#1062'AMADA'#1066'eAAAwB' +
      'AAB'#1098'AABs25b'#1096'X'#1069#1079#1091'Qb'#1043#1097'H'#1065'f'#1100'AeBQA'#1058'AAAQ'#1095'1'#1057'nw'#1087#1071'IJ'#1088#1057#1078'UAAA'#1043#1080'1h'#1075#1082#1103'9'#1043#1081#1081#1053'YA' +
      'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAEAA' +
      'AAAAIAAAABAQAEAAHeAAAAAAAAAAAD'#1060'AAAAAAAABAA'#1046'AIAAAAAAQAAA'#1089'SeAA'
    FrmBorderIcons = [biSystemMenu, biMinimize, biMaximize]
    FrmBorderStyle = bsSizeable
    Fields.Strings = (
      #1053#1086#1084#1077#1088'#Acc#ACID#TSimpleGet###0#1#T#F#T#F#F####0#0#F#F'
      #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077'#Acc#NAME#TSimpleGet###0#1#T#F#T#F#F####0#0#F#F'
      #1055#1072#1088#1086#1083#1100'(ftp)#Acc#ACPASS#TSimpleGet###0#1#T#F#T#F#F####0#0#F#F#F'
      #1055#1072#1088#1086#1083#1100'('#1096#1080#1092#1088'.)#Acc#ACKEY#TSimpleGet###0#1#T#F#T#F#F####0#0#F#F#F'
      'EMail#Acc#ACADDR#TSimpleGet###0#1#T#F#T#F#F####0#0#F#F'
      #1055#1072#1087#1082#1072' ftp#ACC#ACDIR#TSimpleGet###0#1#T#F#T#F#F####0#0#F#F'
      #1057#1077#1088#1074#1077#1088'#ACC#SRVID#TCodeGet#VnFtpSrv##0#1#T#F#T#F#F####0#0#F#F'
      
        '#ACC#PENDSET#TBoolGet##'#1054#1090#1083#1086#1078#1077#1085#1085#1099#1077' '#1085#1072#1089#1090#1088#1086#1081#1082#1080'#0#1#T#F#T#F#F####0#0' +
        '#F#F#F'
      
        #1042#1089#1090#1091#1087#1083#1077#1085#1080#1077' '#1074' '#1089#1080#1083#1091'#ACC#DATE2#TDateGet##DD.MM.YYYY#0#1#T#F#T#T#F##' +
        '##0#0#F#F#F'
      #1055#1072#1088#1086#1083#1100'(ftp)#Acc#ACPASS2#TSimpleGet###0#1#T#F#T#T#F####0#0#F#F#F'
      #1055#1072#1088#1086#1083#1100'('#1096#1080#1092#1088'.)#Acc#ACKEY2#TSimpleGet###0#1#T#F#T#T#F####0#0#F#F#F'
      #1055#1072#1087#1082#1072' ftp#ACC#ACDIR2#TSimpleGet###0#1#T#F#T#T#F####0#0#F#F#F'
      #1057#1077#1088#1074#1077#1088'#ACC#SRVID2#TCodeGet#VnFtpSrv##0#1#T#F#T#T#F####0#0#F#F#F')
    HelpContext = 0
    NameWnd = 'Acc'
    PnlAskByCancel = False
    PnlSortMode = smColumns
    OnFldCheck = deAccFldCheck
    OnFldChange = deAccFldChange
    OnFldEnter = deAccFldEnter
    OnFldExit = deAccFldExit
    Left = 408
    Top = 24
  end
  object MgFbVers: TMenuGet
    VName = 'FbVers'
    UserItems = False
    LenCode = 0
    LenName = 0
    Left = 152
    Top = 136
  end
  object RFlt: TRecDB
    NameRec = 'FLT'
    DateWithTime = False
    NameDB = 'FLT'
    Prim = #1064#1072#1073#1083#1086#1085#1099
    OnNewRec = RFltNewRec
    Left = 272
    Top = 280
  end
  object FltGet: TButFormGet
    EditType = edtpInter
    VName = 'Flt'
    Left = 24
    Top = 472
  end
  object Rec: TRecVal
    NameRec = 'Main'
    Fields.Strings = (
      'OrgDat=M'
      'CopyDir=M'
      'CopyProg=L'
      'CopyStatus=N'
      'OtdDir=M'
      'FLTLS=L'
      'Val1=L'
      'Val2=L'
      'Val3=L'
      'Val4=L'
      'Val5=L'
      'Val6=L'
      'Val7=L'
      'Val8=L'
      'Val9=L'
      'Val10=L'
      'DATE=D'
      'DATE1=D'
      'DATE2=D'
      'DATE3=D'
      'DATE5=D'
      'DATE6=D'
      'DATE7=D'
      'TIME=S5'
      'TIME1=S5'
      'TIME2=S5'
      'TIME3=S5'
      'TIME4=S5'
      'TIME5=S5'
      'TIME6=S5'
      'TIME7=S5'
      'CNGD=M'
      'CNGF=M'
      'TNMSG=M'
      'ZajMov=L'
      'MsgTxt=M'
      'FLTINMSG=S3'
      'SI_KP=S2'
      'SI_OBJ=S1'
      'SI_MSG=M'
      'SI_FILE=M'
      'SI_DPPATH=M'
      'SI_DPFILES=M'
      'SI_BG=L'
      'SI_ONSEL=L'
      'SI_MULTI=L'
      'SI_MSGPTRN=M'
      'SI_ZAJ_TXT=M'
      'SI_ZAJ_TN=S6'
      'SI_ZAJ_DATE=D'
      'SI_ZAJ_TIME=S5'
      'SI_ZAJ_ISPV=N'
      'SI_ZAJ_ISPTN=S6'
      'SI_ZAJ_DATE1=D'
      'SI_ZAJ_TIME1=S5'
      'SI_ZAJ_TIME2=S5'
      'BALL=S14@H'#1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1073#1072#1083#1083#1086#1074'@'
      'SELISPSH=M@H'#1042#1099#1073#1086#1088' '#1080#1089#1087#1086#1083#1085#1080#1090#1077#1083#1103'@'
      'ORD=M@H'#1055#1086#1088#1103#1076#1086#1082' '#1074#1099#1074#1086#1076#1072' '#1076#1072#1085#1085#1099#1093'@'
      'PSWD=S10@H'#1055#1072#1088#1086#1083#1100'@')
    Left = 152
    Top = 24
  end
  object deMsg: TDefEdit
    DcmBased = False
    FrmBorderIcons = [biSystemMenu, biMinimize, biMaximize]
    FrmBorderStyle = bsSizeable
    Fields.Strings = (
      #1055#1086#1083#1091#1095#1072#1090#1077#1083#1100'#Msg#TNTO#TCodeGet#Cdr#@N@C#0#1#T#F#T#F#F####0#0#F#F'
      #1058#1077#1082#1089#1090'#Main#MSGTXT#TSpGet###0#1#F#F#T#F#F####-2#-1#F#F#F#F'
      
        #1054#1090#1087#1088#1072#1074#1080#1090#1077#1083#1100'#Msg#TNFROM#TCodeGet#Cdr#@N@C#0#1#T#F#T#F#F####0#0#F#' +
        'F'
      #1044#1072#1090#1072'#Main#VAL1#TMultiGet##2#0#1#T#F#T#F#F####0#0#F#F'
      '#Main#DATE#TDateGet##@WEEK#0#1#T#F#T#F#F###Main.VAL1#0#0#F#F'
      '#Main#TIME####0#1#T#F#T#F#F###Main.VAL1#0#0#F#F'
      #1044#1072#1090#1072'~'#1087#1086#1083#1091#1095#1077#1085#1080#1103'#Main#VAL2#TMultiGet##2#0#1#T#F#T#F#F####0#0#F#F'
      '#Main#DATE1#TDateGet##@WEEK#0#1#T#F#T#F#F###Main.VAL2#0#0#F#F'
      '#Main#TIME1####0#1#T#F#T#F#F###Main.VAL2#0#0#F#F'
      #1050#1083#1080#1077#1085#1090'#Main#KOD#TCodeGet#List#@N@C@0#0#1#T#F#T#F#F####0#0#F#F'
      #1055#1088#1086#1075#1088#1072#1084#1084#1072'#Msg#NP#TCodeGet#ProgNp#@0#0#1#T#F#T#T#F####-2#0#F#F')
    HelpContext = 0
    NameWnd = 'Msg'
    PnlAskByCancel = False
    PnlSortMode = smColumns
    OnFldChange = deMsgFldChange
    OnFrmShow = deMsgFrmShow
    OnPnlUpdateRec = deMsgPnlUpdateRec
    Left = 408
    Top = 72
  end
  object deProgStat: TDefEdit
    DcmBased = False
    FrmBorderIcons = [biSystemMenu, biMinimize, biMaximize]
    FrmBorderStyle = bsSizeable
    FrmCaption = #1057#1084#1077#1085#1080#1090#1100' '#1089#1090#1072#1090#1091#1089' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
    Fields.Strings = (
      
        #1053#1086#1074#1099#1081' '#1089#1090#1072#1090#1091#1089'#Prog#STATUS#TRadioGet#Status#@NB0#0#1#T#F#T#F#F####' +
        '0#0#F#F'
      
        '#Main#ZAJMOV#TBoolGet##'#1055#1077#1088#1077#1085#1077#1089#1090#1080' '#1074#1089#1077' '#1079#1072#1103#1074#1082#1080' '#1085#1072' '#1076#1088#1091#1075#1091#1102' '#1087#1088#1086#1075#1088#1072#1084#1084#1091'#' +
        '0#1#T#F#T#F#T####0#0#F#F'
      '#Main#ZAJMOVCP#TCodeGet#Prog##0#1#T#F#T#T#F####-1#0#F#F')
    HelpContext = 0
    NameWnd = 'ProgStatus'
    PnlAskByCancel = False
    PnlSortMode = smDefault
    OnFldChange = deProgStatFldChange
    OnFldExit = deProgStatFldExit
    OnPnlValid = deProgStatPnlValid
    Left = 408
    Top = 120
  end
  object DeProgUser: TDefEdit
    DcmBased = False
    FrmBorderIcons = [biSystemMenu, biMinimize, biMaximize]
    FrmBorderStyle = bsSizeable
    FrmCaption = #1059#1095'.'#1079#1072#1087#1080#1089#1100
    Fields.Strings = (
      
        #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100'#Prog#PUNAME#TSimpleGet###0#2#T#F#T#F#F####0#0#F#F#F' +
        '#F'
      #1055#1072#1088#1086#1083#1100'#Main#PUPASS#TSimpleGet###0#1#T#F#T#F#F####0#0#F#F#F#F'
      '#Prog#PUDEV#TBoolGet##'#1056#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082'#0#1#T#F#T#F#F####0#0#F#F#F#F')
    HelpContext = 0
    NmProc.Strings = (
      'F4#'#1048#1079#1074#1083#1077#1095#1100' '#1091#1095'.'#1079#1072#1087#1080#1089#1100'#'#1048#1079#1074#1083#1077#1095#1100' '#1091#1095'.'#1079#1072#1087#1080#1089#1100'#LIST'
      
        'F7#'#1044#1086#1073#1072#1074#1080#1090#1100' '#1091#1095'.'#1079#1072#1087#1080#1089#1100'#'#1044#1086#1073#1072#1074#1080#1090#1100' '#1091#1095'.'#1079#1072#1087#1080#1089#1100' '#1088#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082#1072' '#1080#1083#1080' '#1072#1076#1084#1080#1085#1080 +
        #1089#1090#1088#1072#1090#1086#1088#1072'#LIST')
    NameWnd = 'ProgUser'
    PnlAskByCancel = False
    PnlSortMode = smColumns
    OnFrmShow = DeProgUserFrmShow
    OnKpProcKey = DeProgUserKpProcKey
    OnPnlValid = DeProgUserPnlValid
    Left = 408
    Top = 168
  end
  object deProgCng: TDefEdit
    DcmBased = False
    FrmBorderIcons = [biSystemMenu, biMinimize, biMaximize]
    FrmBorderStyle = bsSizeable
    FrmCaption = #1057#1084#1077#1085#1080#1090#1100
    Fields.Strings = (
      #1053#1086#1074#1099#1081' '#1074#1080#1076'#Prog#KP#TMenuGet#Prog##0#1#T#F#T#F#F####0#0#F#F'
      
        #1053#1086#1074#1099#1081' '#1085#1086#1084#1077#1088' '#1082#1083#1080#1077#1085#1090#1072'#Main#KOD#TCodeGet#List#@N@C@0#0#1#T#F#T#F#F#' +
        '###0#0#F#F'
      #1053#1086#1074#1099#1081' '#1088#1077#1075'.N#Prog#CP#TSimpleGet###0#1#T#F#T#F#F####0#0#F#F')
    HelpContext = 0
    NameWnd = 'ProgCng'
    PnlAskByCancel = False
    PnlSortMode = smDefault
    OnFldCheck = deProgCngFldCheck
    OnFldExit = deProgCngFldExit
    OnPnlValid = deProgCngPnlValid
    Left = 408
    Top = 216
  end
  object btgCdr: TButTextGet
    TextReadOnly = False
    RVid = #1042#1099#1073#1086#1088#1082#1072' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081
    VName = 'Cdr'
    Left = 480
    Top = 32
  end
  object RMDV: TRecDB
    NameRec = 'MDV'
    DateWithTime = False
    NameDB = 'MDV'
    Prim = #1042#1077#1088#1089#1080#1080' '#1086#1089#1085#1086#1074
    Left = 272
    Top = 424
  end
  object RMDT: TRecDB
    NameRec = 'MDT'
    DateWithTime = False
    NameDB = 'MDT'
    Prim = #1058#1077#1084#1099' '#1086#1089#1085#1086#1074
    Left = 272
    Top = 472
  end
  object RMDP: TRecDB
    NameRec = 'MDP'
    DateWithTime = False
    NameDB = 'MDP'
    Prim = #1042#1080#1076#1099' '#1086#1089#1085#1086#1074
    Left = 272
    Top = 336
  end
  object RMDF: TRecDB
    NameRec = 'MDF'
    DateWithTime = False
    NameDB = 'MDF'
    Prim = #1060#1072#1081#1083#1099' '#1086#1089#1085#1086#1074
    Left = 272
    Top = 384
  end
  object MDPGet: TCodeGet
    VName = 'MDP'
    FieldsCode = 'PATH'
    OrderCode = 1
    OrderName = 0
    Part = 'select_worder'
    MulPar.Strings = (
      'globkey="%"'
      'cod_c="%"'
      'table=MDP'
      'c_list=*'
      'id=1'
      'where=PROGID={id} and PATH like {cod_c}')
    TrimLeft = False
    ListFindEqual = False
    OnStrName = MDPGetStrName
    OnTransSeek = NameGetTransSeek
    LenCode = 0
    LenName = 0
    Left = 96
    Top = 520
  end
  object MDFGet: TCodeGet
    VName = 'MDF'
    FieldsCode = 'FILE'
    OrderCode = 1
    OrderName = 0
    Part = 'select_worder'
    MulPar.Strings = (
      'globkey="%"'
      'cod_c="%"'
      'table=MDF'
      'c_list=*'
      'kc=1'
      'where=KC="{kc}" and PATH={globkey} and FILE like {cod_c}')
    TrimLeft = False
    ListFindEqual = False
    OnTransSeek = NameGetTransSeek
    LenCode = 0
    LenName = 0
    Left = 96
    Top = 568
  end
  object MDGVersGet: TMenuGet
    VName = 'MDGVers'
    UserItems = False
    LenCode = 0
    LenName = 0
    Left = 152
    Top = 184
  end
end
