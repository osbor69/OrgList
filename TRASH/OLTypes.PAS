unit OLTypes;

interface

{$I ORGTEST}
uses Classes,
  MyTypes,My_pr,MulQry,CodeGets,RecDB,BrQuery,Inter,DB,FFldEdit,GGMReg,
  SftpDir,ProgType;

const
  tACC   ='ACC'   ; fACC='ACID';
  tCDR   ='CDR'   ; fCDR='TN';
  tCNG   ='CNG'   ;
  tCNGV  ='CNGV'  ; fCNGV='KC';
  tDOC   ='DOC'   ; fDOC='KD';
  tDRV   ='DRV'   ; fDRV='ND';
  tFLT   ='FLT'   ; fFltGK='GK';
  tFTPSRV='FTPSRV'; fFTPSRV='SRVID';
  tLIST  ='LIST'  ;
  tMDF   ='MDF'   ; fMdPATH='PATH'; fMdFILE='FILE';
  tMDG   ='MDG'   ; fMDG='GVERS';
  tMDP   ='MDP'   ; fMDP='PROGID';
  tMDT   ='MDT'   ;
  tMDV   ='MDV'   ; fMDV='VERS';
  tMSG   ='MSG'   ; fMsgTNFROM='TNFROM'; fMsgTNTO='TNTO';
  tOFIS  ='OFIS'  ;
  tORG   ='ORG'   ; fORG='KO';
  tPROG  ='PROG'  ; fProgKP='KP'; fProgCP='CP'; fProgNP='NP';
  tRGN   ='RGN'   ; fRGN='KR';
  tTERR  ='TERR'  ; fTERR='KT';
  tVAN   ='VAN'   ;
  tZAJ   ='ZAJ'   ;

  fTD='TD';

  ofxKOD      = 1;
  ofxCP       = 2;
  ofxNp       = 3;
  ofxKP       = 4;
  ofxTN       = 5;
  ofxKD       = 6;
  ofxDIR      = 7;
  ofxSTATUS   = 8;
  ofxRGN      = 9;
  ofxTerr     = 10;
  ofxAcc      = 11;
  ofxKolvo    = 12;
  ofxMsgPtrn  = 13;
  ofxAccAct   = 14;
  ofxFbVers   = 15;
  ofxAccInout = 16;
  ofxAccOnsrv = 17;
  ofxDLast    = 18;

  ofxCnt      = 18;

  ofzTD       = 1;
  ofzNZ       = 2;
  ofzDACT     = 3;
  ofzTXT      = 4;
  ofzTN       = 5;
  ofzTISPD    = 6;
  ofzISPV     = 7;
  ofzISPTN    = 8;
  ofzTWD      = 9;
  ofzWTN      = 10;
  ofzTWTN     = 11;
  ofzSELISPSH = 12;
  ofzTSELISP  = 13;
  ofzSELISP   = 14;
  ofzBALL0    = 15;
  ofzSET      = 16;
  ofzBALL1    = 17;
  ofzBALL2    = 18;
  ofzREVALUE  = 19;
  ofzCNTISP   = 20;
  ofzISPCALC  = 21;
  ofzTSELISPE = 22;
  ofzMOV      = 23;

  ofzCnt      = 23;

  dlmMemF = #31;

  DGSPFB = ',';

  DLastFormat = 'dd/mm/yyddd hh:nn';

  logvExec     = -1;
  logvCopy     = -2;
  logvMove     = -3;
  logvDel      = -4;
  logvMoveZaj  = -5;
  logvStruct   = -6;
  logvPack     = -7;
  logvChk      = -8;
  logvDelRegs  = -9;
  logvSendMsg  = -10;
  logvSendFile = -11;
  logvCngExt   = -12;
  logvProvData = -13;
  logvBuhLoad  = -14;
  logvCurTn    = -15;
  logvSetGGW   = -16;

  logvOLCnt    = -16;

  logkCp    = -1;
  logkNp    = -2;

  logkOLCnt = -2;

  afOrd: TArrBoolStr = ('ORG','FLT');
  MSG_DONE = 'D';
  SRVPORTDELIM = '/';

  HelpFileOrglist = 'ORGLIST';

  SFTPSBCOL_ID         = 0;
  SFTPSBCOL_NAME       = 1;
  SFTPSBCOL_SRV        = 4;
  SFTPSBCOL_ACT        = 7;
  SFTPSBCOL_VER        = 8;
  SFTPSBCOL_PATH       = 9;
  SFTPSBCOL_COMP       = 10;
  SFTPSBCOL_CHANGENAME = 11;

  SFTPSBCOL_BOX: TArrBoolBoolByte = ((2,5),(3,6));

  LOGFILE_CHANGENAME = 'changename.txt';

  fltgkLow  = 1000;

  fltgkProg = 1000;
  fltgkZaj  = 1001;

  fltgkHigh = 1001;

type
  TOrdFixList = 1..ofxCnt;
  TOrdFixzList = 1..ofzCnt;

  TFltList = (fltOne,fltAny,fltAll);

  TIspVidList0 = (ivNone,ivCdrToOrg,ivOrgToCdr,ivPhone,ivUpdate,ivMove,ivCancel,ivError,ivIsOffice,ivIsOrg);
  TIspVidList = Succ(ivNone)..high(TIspVidList0);
  TIspVidArr = array[TIspVidList] of string;

  TProgStatList = (stpMain,stpTemp,stpArh,stpLast);
  TProgStatVidList = (stvName,stvLs,stvHead);

  TCdrStatList = (cstNone,cstFree,cstBusy,cstDinner,cstOrder,cstBreak,cstRemote);

  TAccInOut = record
    case boolean of
      false: (a: TArrBoolWord);
      true: (dw: longword);
  end;

  PDEFltOpt = ^TDEFltOpt; TDEFltOpt = set of (fltOnlyOrd,fltZaj,fltFlt);

  TZajEditOpt1 = (zpsVisible,zpsEnabled); TZajEditOpt = set of TZajEditOpt1;
  TZajVsblOpt = set of (zajVsblNZ,zajVsblWISP);

  TFieldInd = array of record
    f: TField;
    i: longint;
  end;

  PFltDef = ^TFltDef;
  TFltDef = array of record
    im,mim,flt,def,orWhere: string;
    anmf: TArrStr;
    g: TCustomGet;
    ln: longint;
  end;

  POrdRec = ^TOrdRec;
  TOrdRec = record
    f: TField;
    nmf: string;
  end;

  TOrgDatList = (orgdatNoOut,orgdatBold);
  TOrgDatStr = array[TOrgDatList] of string;

  TFltGk = fltgkLow..fltgkHigh;

  TProgIdList = 0..4;

  TTpView = (tpvWin,tpvDOS,tpvExec,tpvDoc,tpvModel);
  
const
  nmfbKOD=sFix+BwOlAuKod;
  nmfbKO=sFix+BwOlAuKo;
  ISPVID_NAMES: TIspVidArr =
    ('����� �������������� � �������'
    ,'����� ������� � ����'
    ,'�� ��������'
    ,'����������'
    ,'������� �� ��������� ������'
    ,'������'
    ,'������� ��������'
    ,'������ � �����'
    ,'������ � �������'
  );

  ProgFld: array[TOrdFixList] of record
    ofvFld,ofvName,ofvCapt,ofvVid,ofvVName,ofvMask,ofvVar,ofvType,ofvCalc,ofvTbl: string;
    ofvWidth,ofvHeight,ofvLen: longint;
  end =
{ofxKOD     }((ofvFld:'KOD'    ;ofvName:'������'                                ;ofvVid:'TCodeGet'  ;ofvVName:'List'  ;ofvMask:cCdName+cCdCod+cCd0             ;ofvVar:'����_������'    ;ofvType:'C';ofvCalc:'CKOD'   ;ofvTbl:tORG)
{ofxCP      },(ofvFld:fProgCP  ;ofvName:'���.�'                                 ;ofvVid:'TSimpleGet'                                                           ;ofvVar:'����_�����'     ;ofvType:'C'                  ;ofvTbl:tPROG)
{ofxNp      },(ofvFld:fProgNP  ;ofvName:'� �/�'                                 ;ofvVid:'TSimpleGet'                                                           ;ofvVar:'����_�����'     ;ofvType:'C'                  ;ofvTbl:tPROG)
{ofxKP      },(ofvFld:fProgKP  ;ofvName:'���'                                   ;ofvVid:'TMenuGet'  ;ofvVName:'Prog'                                           ;ofvVar:'����_���'       ;ofvType:'C';ofvCalc:'CKP'    ;ofvTbl:tPROG)
{ofxTN      },(ofvFld:fCDR     ;ofvName:'�������������'                         ;ofvVid:'TCodeGet'  ;ofvVName:'Cdr'   ;ofvMask:cCdName+cCdCod                  ;ofvVar:'����_���'       ;ofvType:'C';ofvCalc:'CTN'    ;ofvTbl:tPROG)
{ofxKD      },(ofvFld:fDRV     ;ofvName:'������� ����'                          ;ofvVid:'TCodeGet'  ;ofvVName:'Drv'   ;ofvMask:cCdName+cCdCod                  ;ofvVar:'����_����'      ;ofvType:'C';ofvCalc:'CND'    ;ofvTbl:tPROG)
{ofxDIR     },(ofvFld:'DIR'    ;ofvName:'�����'                                 ;ofvVid:'TDirGet'   ;ofvVName:'Dir'                                            ;ofvVar:'����_�����'     ;ofvType:'C'                  ;ofvTbl:tPROG;ofvWidth:60)
{ofxSTATUS  },(ofvFld:'STATUS' ;ofvName:'������'                                ;ofvVid:'TRadioGet' ;ofvVName:'Status';ofvMask:cRdBeg+'0'                      ;ofvVar:'����_������'    ;ofvType:'I';ofvCalc:'CSTATUS';ofvTbl:tPROG)
{ofxRGN     },(ofvFld:fRGN     ;ofvName:'������'                                ;ofvVid:'TCodeGet'  ;ofvVName:'Rgn'   ;ofvMask:cCdName+cCdCod                  ;ofvVar:'����_�����'     ;ofvType:'I';ofvCalc:'CKR'    ;ofvTbl:tPROG)
{ofxTerr    },(ofvFld:fTERR    ;ofvName:'����������'                            ;ofvVid:'TCodeGet'  ;ofvVName:'Terr'  ;ofvMask:cCdName+cCdCod+cCd0             ;ofvVar:'����_����'      ;ofvType:'I';ofvCalc:'CKT'    ;ofvTbl:tPROG)
{ofxAcc     },(ofvFld:fACC     ;ofvName:'��.���.���.'                           ;ofvVid:'TCodeGet'  ;ofvVName:'Acc'   ;ofvMask:cCdName+cCdCod+cCd0             ;ofvVar:'����_�����'     ;ofvType:'I'                  ;ofvTbl:tPROG)
{ofxKolvo   },(ofvFld:'KOLVO'  ;ofvName:'����������'                            ;ofvVid:'TSpinGet'                                                             ;ofvVar:'����_�����'     ;ofvType:'I'                  ;ofvTbl:tPROG)
{ofxMsgPtrn },(ofvFld:'MSGPTRN';ofvName:'������ �������� ���������'; ofvCapt:' ';ofvVid:'TMemoGet'                    ;ofvMask:',,,4,������ �������� ���������';ofvVar:'����_��������'  ;ofvType:'C'                  ;ofvTbl:tPROG;ofvWidth:wallDefault)
{ofxAccAct  },(                 ofvName:'����������'                                                                                                           ;ofvVar:'����_����������';ofvType:'I';ofvCalc:'CACCACT')
{ofxFbVers  },(ofvFld:'FBVERS' ;ofvName:'������ FB'                             ;ofvVid:'TMenuGet'  ;ofvVName:'FbVers'                                         ;ofvVar:'����_������FB'  ;ofvType:'C';ofvCalc:'CFBVERS';ofvTbl:tPROG)
{ofxAccInout},(                 ofvName:'��./���.'                                                                                                                                                  ;ofvCalc:'CACCIO')
{ofxAccOnsrv},(                 ofvName:'�� �������'                                                                                                           ;ofvVar:'����_���������' ;ofvType:'I';ofvCalc:'CACCSRV')
{ofxDLast   },(ofvFld:'DLAST'  ;ofvName:'��������� ����'                                                                                                       ;ofvVar:'����_��������'  ;ofvType:'D';ofvCalc:'CDLAST' ;ofvTbl:tPROG)
    );

  aOrdFixz: array[TOrdFixzList] of record
    ofzvTbl,ofzvFld,ofzvName,ofzvSort,ofzvCalc: string;
    ofzvBeg: boolean;
    ofzvLen: byte;
  end =
{ofzTD      }((ofzvTbl:tZAJ;ofzvFld:fTD       ;ofzvName:'���������'                      ;ofzvSort:'TDISPD' ;ofzvCalc:'CTD')
{ofzNZ      },(ofzvTbl:tZAJ;ofzvFld:'NZ'      ;ofzvName:'�����')
{ofzDACT    },(ofzvTbl:tZAJ;ofzvFld:'DACT'    ;ofzvName:'�������� ��'                                       ;ofzvCalc:'CDACT')
{ofzTXT     },(ofzvTbl:tZAJ;ofzvFld:fTXT      ;ofzvName:'�����'                                             ;ofzvCalc:'CTXT'     ;ofzvBeg:true)
{ofzTN      },(ofzvTbl:tZAJ;ofzvFld:fCDR      ;ofzvName:'������'                                            ;ofzvCalc:'CTN')
{ofzTISPD   },(ofzvTbl:tZAJ;ofzvFld:'TISPD'   ;ofzvName:'���������'                                         ;ofzvCalc:'CTISPD')
{ofzISPV    },(ofzvTbl:tZAJ;ofzvFld:'ISPV'    ;ofzvName:'��� ����������'                                    ;ofzvCalc:'CISPV')
{ofzISPTN   },(ofzvTbl:tZAJ;ofzvFld:'ISPTN'   ;ofzvName:'�����������'                                       ;ofzvCalc:'CISPTN')
{ofzTWD     },(ofzvTbl:tZAJ;ofzvFld:'TWD'     ;ofzvName:'���������.����������'           ;ofzvSort:'TWDSORT';ofzvCalc:'CTWD')
{ofzWTN     },(ofzvTbl:tZAJ;ofzvFld:'WTN'     ;ofzvName:'���������.�����������'                             ;ofzvCalc:'CWTN')
{ofzTWTN    },(ofzvTbl:tZAJ;ofzvFld:'TWTN'    ;ofzvName:'���.���������.�����������'                         ;ofzvCalc:'CTWTN')
{ofzSELISPSH},(ofzvTbl:tZAJ;ofzvFld:'SELISPSH';ofzvName:'����� �����������'                                 ;ofzvCalc:'CSELISPSH')
{ofzTSELISP },(ofzvTbl:tZAJ;ofzvFld:'TSELISP' ;ofzvName:'���.������ �����������'                            ;ofzvCalc:'CTSELISP')
{ofzSELISP  },(ofzvTbl:tZAJ;ofzvFld:'SELISP'  ;ofzvName:'���������� � ������ �����������')
{ofzBALL0   },(ofzvTbl:tZAJ;ofzvFld:'BALL0'   ;ofzvName:'������ ��������.')
{ofzSET     },(ofzvTbl:tZAJ;ofzvFld:'LSET'    ;ofzvName:'���.')
{ofzBALL1   },(ofzvTbl:tZAJ;ofzvFld:'BALL1'   ;ofzvName:'������ �������.')
{ofzBALL2   },(ofzvTbl:tZAJ;ofzvFld:'BALL2'   ;ofzvName:'������ ���.')
{ofzREVALUE },(ofzvTbl:tZAJ;ofzvFld:'REVALUE' ;ofzvName:'������� ����������')
{ofzCNTISP  },(ofzvTbl:tZAJ;ofzvFld:'CNTISP'  ;ofzvName:'���-�� ������������')
{ofzISPCALC },(                                                                                              ofzvCalc:'CCALC')
{ofzTSELISPE},(ofzvTbl:tZAJ;ofzvFld:'TSELISPE';ofzvName:'�����.������ �����������'                          ;ofzvCalc:'CTSELISPE')
{ofzMOV     },(ofzvTbl:tZAJ;ofzvFld:'MOV'     ;ofzvName:'�������� ������'                                   ;ofzvCalc:'CMOV'     ;ofzvBeg:true)
  );

	aProgStat: array[TProgStatVidList,TProgStatList] of string =
  	( ('��������','���������','��������','��������')
  	, (''        ,'����.'    ,'�����'   ,'�����.')
  	, ('���.'    ,'����.'    ,'���.'    ,'���.')
    );

  aCdrStat: array[TCdrStatList] of string =
  	('�����������'
    ,'� �����'
    ,'�����'
    ,'�� �����'
    ,'��������'
    ,'�������'
    ,'�������� �������'
    );

  zpsDefault: TZajEditOpt = [low(TZajEditOpt1)..high(TZajEditOpt1)];

  aIspv: TIspVidArr =
  ('����� � �������'
  ,'����� �������'
  ,'�� ��������'
  ,'����������'
  ,'�������'
  ,'������'
  ,'����.��������'
  ,'������ � �����'
  ,'������ � �������'
  );

  OrgDatNmf: TOrgDatStr = ('ORGDAT','ORGDATBOLD');

  aFltGk: array[TFltGk] of string = ('������ ��� ������� �� ����������','������ ��� ������� �� �������');

  aProgId: array[TProgIdList] of longint = (PTIX_ZPW,PTIX_BW,PTIX_AP,PTIX_TEST,PTIX_DOC);

var
  lTrash,CopyCommandToClipBoard,lListOpen,ZajLoaded,CanCngStatus: boolean;
  lCdrTN,lProgCP,lProgNP,lProgKP,lPhone,lStatus: byte;
  LenDispDate,rMsgToZaj,
    GlobOTDNUM,GlobLASTCNT,GlobLASTDAY: longint;
  iiCdr: longint = NegDef;
  dZajBeg: TDateTime;
  OldVers,
    GlobDIRLAST,GlobTELPATH,GlobTELPATHOUT,GlobTELCDR,GlobTELREAD,GlobVIDNO: string;
  deFltFld: string = 'FLT';
  Glob,Cdr,Org,Van,Drv,Zaj,Msg,Doc,Ofis,Cngv,Rgn,Terr,Acc,Srv,Flt,MDP,MDF,MDV,MDT: TRecDB;
  List,Prog: TRecDBDef;
  qList,qProg,qZaj: TMulQuery;
  qZajMain: TBrQuery;
  ProgFldDispWidth: array[TOrdFixList] of longint;
  aFixzLen: array[TOrdFixzList] of byte;
  GlobORGDAT: TOrgDatStr;
  afnmCdr: TArrStr;
  aFltCur: TArrBoolVar;
  CdrGet,FVanGet: TCodeGet;
  FDBBuh: TComponent;
  UnLockRead: TProcNone;
  MsgToZaj: TNotifyEvent;
  LockRead: TFuncBool;
  ZajEdProcKey: TKeyProc;
  c_ProgNext,c_ProgEnd: TProcNone;
  c_ProgEof: TFuncBool;
  c_ProgBeg: function: longint;
  ProgEdExec: function(Key: longint; lFlt: boolean): TObject;
  SftpFilesExec: procedure(const pathSftp,rzrvCopyDir,aCaption: string;
    rzrvCopyLastCnt,rzrvCopyLastDay: longint; SftpLogProc: TSftpLogProc = nil);
  ETnStatusUpdate: procedure(const aTn: string; aStatus: longint) of object;
  deFltExec: function(const Capt,nmf,fmem,nmWnd: string; Opt: TDEFltOpt): boolean of object;
  SetInterFlt: procedure(q: TMulQuery; lsRec: TIntegerList; const vflt,nmrProg,nmrZaj: string;
    Inter: TInter; lFiltered: boolean);
  ZajEdit: function(const Capt: string; fqRECNO: TField; stZaj,stIsp: TZajEditOpt; Opt: TZajVsblOpt): boolean;

implementation

end.
