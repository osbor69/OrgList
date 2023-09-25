unit FMain;

interface

{$I ORGTEST}
{ $DEFINE FLTPROG}
{ $DEFINE TEST}
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, Menus, ExtCtrls, StdCtrls, DB, ComCtrls, DBGrids, Math, Grids,
    ShellApi, RegStr, DBTables, StrUtils, FIBDatabase,
  MyTypes, My_pr, FRMEDT, KeyMenu, PnlEdit, Keylb, Fpanel, FFldedit, RecVal, Recdb, RbMenu, RbScroll,
    RbPage, Calc, DefEdit, Askp, MulQry, FDWPrm, ButGet, BtTxtGet, Browl, BrQuery, CCodeGet, Codegets,
    DirGet, Inter, ChkGets, StrBrowl, TreeDir, FCngNum, MemoGet, FrmPswd, FLastCng, FHelpLs, FrmBrIB,
  TsHelp,
  BuhTypes,
  OLTypes, OLGets, OLProc, FMsgLs, ModelGet, MenuGet;

type
  PMdInf = ^TMdInf;
  TMdInf = record
    p,f: TModelFile;
    v,gv: longint;
    del: boolean;
  end;

  THLList = (hlZaj,hlMsgTo,hlCng,hlSftp,hlTnStatus);

  TMain = class(TFormEdt)
    pnUser: TRbPanel;
    pnPage: TRbPanel;
    RbPage1: TRbPage;
    tsServ: TTabSheet;
    pnServ: TRbPanel;
    scrServ: TRbScrollBox;
    mnServ: TRbMenu;
    tsHelp: TTabSheet;
    pnHelp: TRbPanel;
    scrHelp: TRbScrollBox;
    mnHelp: TRbMenu;
    tsOrg: TTabSheet;
    deSys: TDefEdit;
    pnOrg: TRbPanel;
    pnOrg1: TRbPanel;
    EKod: TFldEdit;
    pnOrg2: TRbPanel;
    pnOrgDat: TRbPanel;
    pnOrgLs: TRbPanel;
    EProg: TFldEdit;
    ProgDGet: TButGet;
    ProgWGet: TButGet;
    tsFlt: TTabSheet;
    deFlt: TDefEdit;
    btgOrg: TButTextGet;
    btgProg: TButGet;
    deProgSel: TDefEdit;
    tsZaj: TTabSheet;
    dsZaj: TDataSource;
    tsMsgFrom: TTabSheet;
    tsMsgTo: TTabSheet;
    PnMsgFrom: TRbPanel;
    pnMsgTo: TRbPanel;
    pnZajSt: TRbPanel;
    stZaj: TRbStatus;
    pnZaj: TRbPanel;
    brZaj: TBrowl;
    tsDoc: TTabSheet;
    pnDoc: TRbPanel;
    dsDoc: TDataSource;
    brDoc: TBrowl;
    deDoc: TDefEdit;
    deZajMov: TDefEdit;
    deOtd: TDefEdit;
    tsOfis: TTabSheet;
    pnOfis: TRbPanel;
    dsOfis: TDataSource;
    brOfis: TBrowl;
    tsCng: TTabSheet;
    pnCng: TRbPanel;
    dsCng: TDataSource;
    brCng: TBrowl;
    deCng: TDefEdit;
    CngFileGet: TButTextGet;
    CngDirGet: TButTextGet;
    dlgCng: TOpenDialog;
    DirGet1: TDirGet;
    DirLastGet: TButTextGet;
    pnFltSt: TRbPanel;
    stFlt: TRbStatus;
    pnFlt: TRbPanel;
    EFlt: TFldEdit;
    tsSftp: TTabSheet;
    rpSftp: TRbPanel;
    sbSftp: TStringBrowl;
    TsInstructions: TTabSheet;
    TreeHelp: TTreeDir;
    Interbase1: TMenuItem;
    PnUser1: TRbPanel;
    ETn: TFldEdit;
    PnUser2: TRbPanel;
    ETnStatus: TFldEdit;
    DeSendInt: TDefEdit;
    RgSendInt: TRadioGet;
    DgSendIntObn: TDirGet;
    OdSendIntObn: TOpenDialog;
    BgSendInt: TButGet;
    DeZajIsp: TDefEdit;
    deSelIsp: TDefEdit;
    dePswd: TDefEdit;
    dmSftp: TDefMenu;
    deDelDerLog: TDefEdit;
    deMdFlt: TDefEdit;
    LastCngGet: TDirGet;
    dlgLastCng: TOpenDialog;
    MDTGet: TButGet;
    rMDGVers: TRecVal;
    rMDFirst: TRecVal;
    deMDFirst: TDefEdit;
    rMdFlt: TRecVal;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mnServProcKey(key: Integer; tw: TWinControl);
    function deSysPnlValid(Sender: TObject): Boolean;
    procedure mnHelpProcKey(key: Integer; tw: TWinControl);
    procedure mnExitProcKey(key: Integer; tw: TWinControl);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EKodChange(Sender: TObject; const OldVal: Variant;
      FromShow: Boolean);
    function PanelEdit1Valid(Sender: TObject): Boolean;
    procedure FormActivate(Sender: TObject);
    procedure EFldChange(Sender: TObject; const OldVal: Variant;
      FromShow: Boolean);
    function ProgDGetClick(Sender: TObject; lEval: Boolean): String;
    function ProgWGetClick(Sender: TObject; lEval: Boolean): String;
    class function ProgWinHelp(nf: TDWForm; Prm: pointer; var hf: THelpFile): boolean;
    procedure ETnExit(Sender: TObject);
    procedure EFltEnter(Sender: TObject);
    procedure EFltExit(Sender: TObject);
    procedure deFltFldChange(Sender: TObject; const OldVal: Variant;
      FromShow: Boolean);
    procedure btgOrgClick(Sender: TObject);
    function btgProgClick(Sender: TObject; lEval: Boolean): String;
    procedure deFltFrmShow(Sender: TObject);
    procedure tsFltEnter(Sender: TObject);
    procedure deSysFrmHide(Sender: TObject);
    procedure pnZajEnter(Sender: TObject);
    procedure pnZajExit(Sender: TObject);
    function deFltPnlValid(Sender: TObject): Boolean;
    procedure deZpnDirPnlSetKey(Sender: TObject; key: Integer; var txt,
      hnt: String; var Part: Integer);
    procedure pnMsgEnter(Sender: TObject);
    procedure brDocBrowlKey(key: Integer; tw: TWinControl);
    procedure deDocFldExit(Sender: TObject);
    function deDocFldCheck(Sender: TObject): Boolean;
    function brDocGrayCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState): Boolean;
    procedure deZajMovFldChange(Sender: TObject; const OldVal: Variant;
      FromShow: Boolean);
    function deZajMovPnlValid(Sender: TObject): Boolean;
    function deOtdPnlValid(Sender: TObject): Boolean;
    procedure pnOfisEnter(Sender: TObject);
    procedure pnOfisExit(Sender: TObject);
    procedure pnBrEnter(Sender: TObject);
    procedure pnBrExit(Sender: TObject);
    procedure pnCngEnter(Sender: TObject);
    procedure pnCngExit(Sender: TObject);
    procedure brCngBrowlKey(key: Integer; tw: TWinControl);
    procedure deCngFldExit(Sender: TObject);
    function deCngFldCheck(Sender: TObject): Boolean;
    procedure CngGetClick(Sender: TObject);
    procedure brCngDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    function brCngGrayCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState): Boolean;
    procedure deCngFrmShow(Sender: TObject);
    function deCngPnlValid(Sender: TObject): Boolean;
    procedure ProgDGetPaint(Sender: TObject; const ARect: TRect;
      const Text: String);
    procedure ProgWGetPaint(Sender: TObject; const ARect: TRect;
      const Text: String);
    procedure DirLastGetClick(Sender: TObject);
    procedure tsSftpShow(Sender: TObject);
    procedure sbSftpEnter(Sender: TObject);
    procedure sbSftpExit(Sender: TObject);
    procedure RbPage1Change(Sender: TObject);
    procedure RbPage1Changing(Sender: TObject; var AllowChange: Boolean);
    procedure TsInstructionsShow(Sender: TObject);
    procedure sbSftpMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure sbSftpMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure sbSftpMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DeSendIntFldChange(Sender: TObject; const OldVal: Variant; FromShow: Boolean);
    function DeSendIntFldCheck(Sender: TObject): Boolean;
    function BgSendIntClick(Sender: TObject; lEval: Boolean): String;
    function DeSendIntPnlValid(Sender: TObject): Boolean;
    function DeZajIspFldCheck(Sender: TObject): Boolean;
    procedure DeSendIntPnlCngKey(Sender: TObject; var tb: TKeyBut);
    procedure PanelEdit1CngKey(Sender: TObject; var tb: TKeyBut);
    procedure btgProgDWFldValue(Sender: TObject; r: TCustomRec;
      const Mask: String; var Value: Variant);
    procedure FormShow(Sender: TObject);
    procedure deCngFldChange(Sender: TObject; const OldVal: Variant;
      FromShow: Boolean);
    procedure btgProgLogCompare(tf: TFldEdit; var Prm: TLogTrnsValPrm);
    function deSelIspPnlValid(Sender: TObject): Boolean;
    function dePswdPnlValid(Sender: TObject): Boolean;
    procedure pnMsgExit(Sender: TObject);
    procedure deFltKpProcKey(key: Integer; tw: TWinControl);
    function deSelIspFldCheck(Sender: TObject): Boolean;
    procedure tsFltExit(Sender: TObject);
    procedure deMdFltFldChange(Sender: TObject; const OldVal: Variant;
      FromShow: Boolean);
    function deMdFltFldCheck(Sender: TObject): Boolean;
    function deMDFirstFldCheck(Sender: TObject): Boolean;
    function deMdFltPnlValid(Sender: TObject): Boolean;
    procedure deMdFltFrmShow(Sender: TObject);
  private
    { Private declarations }
    qDoc,qOfis,qCng: TBrQuery;
    brMsgTo,brMsgFrom: TMsgBrowl;
    qMsgCdr: TMulQuery;
    qDocTN,qDocNAME,qCngCDT,qCngNAME: TStringField;
    qDocRECNO,qCngDT,qCngRECNO: TIntegerField;
    qCngCNG: TBooleanField;
    qCngTPVIEW: TField;
    lSuper,{DcmModified,}zFiltered,lZajSelfNoisp,lZajIspCalc,lStatInv,FShowAllAcc,lCngEdit,lMdEdit: boolean;
    dw: TDWWin;
    ls: TStringList;
    lsf,lsz: TFldList;
    lsrz,lsCng,lsMd,lsgv: TIntegerList;
    adopz: TFldArrDop;
    afz: TFieldInd;
    iZaj: TInter;
    aHL: array[THLList] of record
      o: TWinControl;
      hl: boolean;
    end;
    qCngSEL: TField;
    FTsHiding: TTabSheet;
    FHelpCore: TTsHelpCore;
    FSftpSortCol,FSftpSortX,FSftpSortY,oMdIndex: longint;
    MDModified: boolean;
    aMd: array of TMdInf;
    afCdr: TArrFldVal;
    procedure CngPage(Sender: TObject);
    class procedure qProgFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure qZajFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure qZajMainAfterOpen(DataSet: TDataSet);
    procedure qZajMainFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure qMsgToBeforeOpen(DataSet: TDataSet);
    procedure qCngCalcFields(DataSet: TDataSet);
    procedure SetSuper;
    class procedure PrReindex(Sender: TAsk);
    procedure TnEnabled(Value: boolean = true);
    procedure ETnChange(Sender: TObject; const OldVal: Variant; FromShow: Boolean);
    procedure PageProcKey(Key: longint; tw: TWinControl);
    class function PrProv(Sender: TObject): boolean;
    class procedure MemoDelUnusedErr(const msg,tbl: string; Proc: TMemoDelUnusedProc; const v: variant; var Aborted: boolean);
    procedure TimerFind(Sender: TObject);
    class function PfFormFlt(Sender: TObject): boolean;
    procedure ZajProcKey(Key: longint; tw: TWinControl);
    procedure ZajSetFlt;
    procedure ZajIspCalc;
    procedure qZajBeforeOpen(DataSet: TDataSet);
    procedure GotoProgSetKey(const txt,hint: string);
    procedure GotoProgDelKey;
    procedure GotoProgProcKey(Key: longint; tw: TWinControl);
    procedure ZajIspSetKey;
    procedure ZajLsEd(Key: longint; tw: TWinControl; frProg: TField);
    procedure DocSetDcmModified(Sender: TObject);
    class procedure DocNewNum(const oldnum: string; Options: TCngNumOptions; var result: boolean);
    function CopyFromOtd(Sender: TObject): Boolean;
    procedure SetCngFlt;
    procedure qCngBeforeOpen(DataSet: TDataSet);
    procedure qCngAfterScroll(DataSet: TDataSet);
    class procedure CngNewNum(const oldnum: string; Options: TCngNumOptions; var result: boolean);
    class procedure PrEditIfError(Sender: TObject);
    procedure WMCalc(var msg: TWMCalc); message WM_CALC;
    procedure WMCngPriv(var Msg: TMessage); message WM_CNGPRIV;
    procedure WMGetUpd(var msg: TWMGetUpd); message WM_GETUPD;
		procedure WMRebuild(var Message: TWMRebuild); message WM_REBUILD;
    procedure RefreshSftpSb;
    procedure SftpKeyProc(key: longint; tw: TWinControl);
    procedure dmSftpExec(pShow: PDefMenuShow);
    procedure SetHL(i: THLList; Value: boolean);
    procedure ApplTitleBlink(ReDef: boolean = false);
    procedure SetSftpShowModeKey(bReDrw: boolean);
    procedure UpdateInstructionsSheetState;
    class function GetHelpDir(sDlgFilter: pstring=nil): string;
    procedure ZajFldGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure ExitETn;
    procedure SetETnStatus(aStatus: longint; noUpdateBlinkState: boolean=false);
    procedure ETnStatusUpdate(const aTn: string; aStatus: longint);
    procedure ZajEdProcKey(Key: longint; tw: TWinControl);
    function deFltExec(const Capt,nmf,fmem,nmWnd: string; Opt: TDEFltOpt): boolean;
    procedure MsgToZaj(Sender: TObject);
    procedure FltNewRec(Sender: TRecDB; lcopy: Boolean; const gKey: String);
    procedure MdExec(Sender: THelpLs; lLoad: boolean);
    procedure TimerMdExec(Sender: TObject);
    procedure MdShow(Sender: TObject);
    procedure MdHide(Sender: TObject);
    procedure MdProcKey(Key: longint; tw: TWinControl);
    function MDFltExec(Prepare: boolean): boolean;
    function MDFltPrepare: boolean;
    function MdGVersLoad(Oper: TLastCngMdLoadOper; const av: array of variant): variant;
    class function VanGetFormIBList(Sender: TFldEdit): TFormBrIB;
    class procedure VanGetAfterList(Sender: TObject);
    function GetMdIndex(Sender: THelpLs): longint;
    procedure SetMdIndex(Sender: THelpLs; Value: longint);
    property MdIndex[Sender: THelpLs]: longint read GetMdIndex write SetMdIndex;
  public
    { Public declarations }
    procedure IsMsgCdr;
    procedure DefOrgDat;
	  class function PrBuhLoad(Sender: TObject): boolean;
  end;

var
  Main: TMain;

implementation
{$R *.dfm}
{$B-}

uses
  PSort,FDWVid,FGFView,FFdp,FEdGenFr,FSumm,GenForm,BufFile,ER866,DateGet,SpGet,FldMask,Shifr,FStat,
    GGMReg,FSchemDM,ListF2,FDFrmLs,
  ProgType,FSGWMain,SggUtils,SftpDir,SftpUtils,
  FCopyLs,
  FDM,FProgEd,FDrvLs,FCdrLs,FOrgLs,FZajLs,{$IFDEF FLTPROG}FltGet,{$ENDIF}FAccLs,FSendDp,FProgLs,
    FFltLs,FMDPLs,FMDTLs,FVanLs;

type
  TSexList = (sexMan,sexWoman);
  TMsgsFldList = 0..3;
  TMdSort = (mdsrtNone,mdsrtD,mdsrtGVers,mdsrtPath,mdsrtFile,mdsrtTheme,mdsrtDel);

const
  NOTEMPTYSTR = 'NOTEMPTYSTR';

  aSex: array[TSexList,TFltList] of string =
    (('один','несколько','все')
    ,('одна','несколько','все')
    );
  aFlt: array[1..6] of record
    f: string;
    sex: TSexList;
  end =
    ((f:tCDR)
    ,(f:tORG)
    ,(f:'PRG'; sex:sexWoman)
    ,(f:fCDR)
    ,(f:'ITN')
    ,(f:'WTN')
    );

  KEYLBSFTP = 'keylbsftp';

  aMsgsFld: array[TMsgsFldList] of record
    nmf: string;
    NoDate: boolean;
  end =
    ((nmf:fMsgsDRFROM)
    ,(nmf:fREGS)
    ,(nmf:fMsgsDSEND)
    ,(nmf:'MSG'; NoDate:true)
    );

  aMdDel: TArrBoolStr = ('Не удалено','Удалено');

  cntMdSort = byte(high(TMdSort));

type
  TProcProv = procedure(var av: variant; var result: TModalResult);
  TProcProv1 = procedure(const av: array of variant);
  TSendIntSaveRec = record
    sisrKP,sisrFILE,sisrDPPATH: string;
    sisrOBJ: TSIObjList;
    sisrONSEL,sisrUpdZaj: boolean;
  end;

  TIspnList = (ispnAll,ispnIsp,ispnNoIsp);

  TProgLogCompare = class(TDlmLogCompare)
  public
    class procedure GetItem(var Prm: TLogTrnsValPrm; pv,lso,lsn: pointer; no,nn: longint; tp: TLogCompareItemList); override;
  end;

  TOrgDatLogCompare = class(TDlmLogCompare)
  public
    class procedure GetItem(var Prm: TLogTrnsValPrm; pv,lso,lsn: pointer; no,nn: longint; tp: TLogCompareItemList); override;
  end;

//sSeekKeys = 'KD,DIR';
var
  fListKO,fProgKO,fProgRECNO,fZajKO,fZajCP,fZajRECNO: TField;
  FltStat: TStat;
  cntErr,FltNum,FltCnt: longint;
  ProgIdName: array[TProgIdList] of string;
  //SGWInfo: TExeInfo;

procedure FdpUser(const Capt: string; const av: array of string; Proc: TProcValid = nil;
  SetDcmModified: TNotifyEvent = nil; Opt: TFdpOptions = [fdoSayStat]);
var unm: string;
begin
  AddStack('FMain.FdpUser');
  unm:=ProgPswd.UserName; ProgPswd.UserName:=DM.Rec[fCDR];
  Fdp(Capt,proc,av,fdpView,Opt,'',nil,TProgFldDef.BeforeForm,TProgFldDef.AfterForm,SetDcmModified);
  ProgPswd.UserName:=unm;
  DelStack;
end;

procedure PrSetFldCng(Sender: TFldEdit; const av: array of variant);
begin
  AddStack('FMain.PrSetFldCng');
  Sender.OnChange:=Main.EFldChange;
  if QuickFind(Sender.NameRecFld,ArrStrVar(av[0])^,av[1]) then Sender.Schem:=DM.schBold.CaptSmall;
  DelStack;
end;

function CdrUpd: longint;
begin
  AddStack('FMain.CdrUpd');
  Cdr.UpdateRec; result:=Cdr.RecNo;
  DelStack;
end;

function GetZajTxt(const v, ind: variant; lSave: boolean): variant;
begin
  AddStack('FMain.GetZajTxt');
  result:=i_const(aConcatTxt254(Zaj,false,ind),lSave);
  DelStack;
end;

function d_date(const v, ind: variant; lSave: boolean): variant;
begin
	AddStack('FMain.d_date');
  result:=StringToDate(d_Var(v,ind,lSave));
  DelStack;
end;

function d_orgkod(const v, ind: variant; lSave: boolean): variant;
begin
	AddStack('FMain.d_orgkod');
  result:=i_const(Padr(Cdr.ValueNum[ind],DM.ListGet.LenCode),lSave);
  DelStack;
end;

function d_progorg(const v, ind: variant; lSave: boolean): variant;
begin
	AddStack('FMain.d_progorg');
  result:=i_const(Padr(ListKod,DM.ListGet.LenCode),lSave);
  DelStack;
end;

{function d_progwin(const v, ind: variant; lSave: boolean): variant;
begin
	AddStack('FMain.d_progwin');
  result:=i_const(ProgInf.lWin,lSave);
  DelStack;
end;

function d_progzp(const v, ind: variant; lSave: boolean): variant;
begin
	AddStack('FMain.d_progzp');
  result:=i_const(ProgInf.lWin,lSave);
  DelStack;
end;}

function d_fltprogarr(const v, ind: variant; lSave: boolean): variant;
var a: TArrStr;
  l: longint;
begin
	AddStack('FMain.d_fltprogarr');
  ProgGet.OrderList(a,l); result:=i_const(ArrStrToVar(a,1,l),lSave);
  DelStack;
end;

// ПРОГ_ВЫВПОЛЯ
function d_fltprogfld(const v, ind: variant; lSave: boolean): variant;
var ls: TFldList;
  lsr: TStringList;
	i,j: longint;
  ao: TArrInt;
  sord: string;
begin
	AddStack('FMain.d_fltprogfld');
  ls:=TFldList.Create; lsr:=TStringList.Create;
  try
    with Prog do for i:=0 to FldDef.Count-1 do ls.Add(DWVarName(DWSToRec(i).Name));
    ls.Fill;
    for i:=0 to ls.Count-1 do ls[i]:=Prog.DWVarName(ls[i]);
    sord:=ProgGet.Mem2Ord(Cdr[sMemo+'ORD'+afOrd[true]],false);
    TTblChkOrdGet.GetOrd(ao,ofxCnt+ls.Count,1,sord);
    for i:=1 to Length(ao) do lsr.Add('');
    for i:=1 to ofxCnt do begin
    	j:=ao[i-1];
      if (GetByte(sord,j+1)) then lsr[j]:=ProgFld[i].ofvVar;
    end;
    for i:=0 to ls.Count-1 do begin
    	j:=ao[ofxCnt+i];
      if (GetByte(sord,j+1)) then lsr[j]:=ls[i];
    end;
    i:=0;
    while i<lsr.Count do
    	if lsr[i]='' then lsr.Delete(i) else Inc(i);
    result:=Ls2Var(lsr);
  finally
  	ls.Free; lsr.Free;
  end;
  DelStack;
end;

function d_accact(const v, ind: variant; lSave: boolean): variant;
begin
  AddStack('FMain.d_accact');
  result:=i_const(GetAccData(ADF_ACTIVITY,CustomRecVar(ind[0])[fACC]),lSave);
  DelStack;
end;

function d_accinout(const v, ind: variant; lSave: boolean): variant;
var io: TAccInOut;
begin
  AddStack('FMain.d_accinout');
  io.dw:=GetAccData(ADF_INOUT,CustomRecVar(ind[0])[fACC]);
  result:=i_const(io.a[boolean(ind[1])],lSave);
  DelStack;
end;

function d_acconsrv(const v, ind: variant; lSave: boolean): variant;
begin
  AddStack('FMain.d_acconsrv');
  result:=i_const(GetAccData(ADF_ONSRV,CustomRecVar(ind[0])[fACC]),lSave);
  DelStack;
end;

// ПЛЗ_ФИО(), ДИСК_НАИМ(), КЛНТ_НАИМ()
function c_Name(var av: array of variant): variant;
var v: variant;
    cg: TCodeGet;
    k: longint;
    mq: TMulQuery;
    isDrv: boolean;
    s,t: string;
    sav,sap: TArrStr;
begin
	AddStack('FMain.c_Name');
  v:=av[0];
  if IsNil(av[1]) then av[1]:=TInter.GetVarValue(v[1]);
  cg:=PointerVar(v[0]);
  isDrv:=(cg=DM.DrvGet);
  if (not isDrv) then begin
    if VarArrayHighBound(v,1) > 1 then SpaceStrSelf(av[1],v[2]);
  end;
  if empty(av[2]) then result:=cg.CodeName(av[1],[cdgBufAll])
  else begin
    if (MyVarType(av[2])=varInteger) then k:=av[2] else k:=0;
    case k of
      4: begin
        mq:=ProgPswd.GetQuery;
        try
          mq.PartSelect(tDRV,[fDRV]); mq.SaveTo(result);
        finally
          ProgPswd.FreeQuery;
        end;
      end;
      5: begin
        result:='';
        if (VarArrayHighBound(v,1)>1) then
          if TInter.GetVarValue(v[2],varString,v) then begin
            s:=cg.CodeDop(av[1],[cdgBufAll]);
            TokenStr(DlmCopy(s,4,1,UnDelim),DGSPFB,sav);
            TokenStr(DlmCopy(s,5,1,UnDelim),DGSPFB,sap);
            t:=GetFbPort(nil,sav,sap,v,[fbpNotShowMsg]);
            result:=DlmCopy(s,2,1,UnDelim)+IfThen(t<>'',SRVPORTDELIM)+t;
          end;
      end;
      else begin
        result:=DlmCopy(cg.CodeDop(av[1],[cdgBufAll]),av[2],1,UnDelim);
      end;
    end;
  end;
  DelStack;
end;

procedure GetProgs(const av: array of variant; const sr: TSearchRec; var lDone: boolean);
const PROGS: array[1..5] of longint = (PTIX_ZPN,PTIX_ZPW,PTIX_BW,PTIX_AP,PTIX_DOC);
var k: longint;
  fn: TFileName;
begin
  AddStack('FMain.GetProgs');
  fn:=AnsiUpperCase(sr.Name);
  for k:=low(PROGS) to high(PROGS) do if fn=AnsiUpperCase(ProgTypes[PROGS[k]].fdbf) then begin
    StringVar(av[0])^:=IntToStr(PROGS[k]); lDone:=false; break;
  end;
  DelStack;
end;

function c_DirInfo(var av: array of variant): variant;
  function Letters2Underlines(const s: string): string;
  var k: longint;
  begin
    result:=s;
    for k:=1 to length(result) do begin
      if (result[k] in ['a'..'z','A'..'Z','Ё','ё','А'..'я']) then result[k]:='_';
    end;
  end;
var s,t,u,v,x,z: string;
  cg: TCodeGet;
  k: longint;
  mq: TMulQuery;
  b: boolean;
  a: TArrBoolStr;
begin
  AddStack('FMain.c_DirInfo');
  InitArrLen(result,1,2,Null);
  if (MyVarType(av[1])=varString) then begin
    s:=CorrDir(av[1],crdrNoDlmEnd);
    if not MaskFilesProc(s+PathDelim+'*.'+PROG_FILEID_EXT,GetProgs,[longint(@z)]) then begin
      b:=false;
      x:='';
      cg:=DM.DrvGet;
      if not cg.BufLoaded then cg.BufCodLoadAll;
      u:=AnsiUpperCase(ExtractFileDrive(s));
      v:='';
      for k:=0 to cg.BufCod.Count-1 do begin
        a:=cg.GetNameDop(k); TrimRightSelf(a[false]);
        if IsNetDrive(u) then begin
          if not AnsiStartsText(a[false],s) then continue;
        end
        else begin
          if not IsSelfComp(a[false]) then continue;
          if AnsiUpperCase(DlmCopy(a[true],1,1,UnDelim))+':'<>u then continue;
        end;
        t:=cg.BufCod[k];
        v:=AnsiUpperCase(Copy(s,Length(u)+1,MaxInt));
        while (v<>'')and(v[1]=PathDelim) do Delete(v,1,1);
        break;
      end;
      if (v<>'') then begin
        mq:=ProgPswd.GetQuery;
        try
          mq.PartSelect(tPROG,[fProgCP,'DIR'],fDRV+'='+QQs(t)+sAND+'DIR'+sLIKE+QQs(Letters2Underlines(v)+'%'));
          while not mq.Eof do begin
            if (AnsiUpperCase(mq.Fields[1].AsString)=v) then begin
              b:=true;
              x:=mq.Fields[0].AsString;
              break;
            end;
            mq.Next;
          end;
        finally
          ProgPswd.FreeQuery;
        end;
      end;

      result[1]:=z;
      if (b) then result[2]:=x;

    end;
  end;
  DelStack;
end;

function c_PckInfo(var av: array of variant): variant;
const ArjFor: array[TArjForList] of byte = (3,4);
var s,t,sOrg,sReg,sNum: string;
  ai: TArjInf;
  mq: TMulQuery;
  aArjFor: TArjForList;
begin
  AddStack('FMain.c_PckInfo');
  InitArrLen(result,1,5,null);
  if (MyVarType(av[1])=varString) then begin
    s:=av[1];
    t:=ExtractFileName(s);
    if (MyVarType(av[2])=varBoolean)and(boolean(av[2])) then begin
      ParsePckFn(t,sOrg,sReg,sNum);
      mq:=ProgPswd.GetQuery;
      try
        mq.PartSelect(tPROG+' p join '+tORG+' o on p.'+fORG+'=o.'+fORG,
                     ['p.'+fProgCP],
                     Format('o.kod=%s%sp.'+fProgCP+'=%s',[Org2Sql(sOrg),sAND,Reg2Sql(sReg)]));
        if (mq.IsRecords) then begin
          result[1]:=mq.Fields[0].AsString;
        end;
      finally
        ProgPswd.FreeQuery;
      end;
    end
    else begin
      ai:=TSGWMain.ArjInf(ExtractFilePath(s),t,true);
      result[1]:=ai.Prim;
      result[2]:=ai.aiIsPassNeed;
      for aArjFor:=low(ArjFor) to high(aArjFor) do result[ArjFor[aArjFor]] := aArjFor in ai.aiArjFor;
      result[5]:=ai.IsPers;
    end;
  end;
  DelStack;
end;

function c_SysPrm(var av: array of variant): variant;
var mq: TMulQuery;
    k: longint;
begin
	AddStack('FMain.c_SysPrm');
  result:=Null;
  if (MyVarType(av[1])=varInteger) then begin
    case longint(av[1]) of
      0: result:=GlobDIRLAST;
      1: begin
        mq:=ProgPswd.GetQuery;
        try
          mq.PartSelect(tFTPSRV,['distinct srvdir']);
          k:=mq.RecordCount;
          if (k=0) then result:=false
          else begin
            result:=VarArrayCreate([1,k],varVariant);
            for k:=1 to k do begin
              result[k]:=CorrDir(mq.Fields[0].AsString,crdrNoDlmEnd);
              mq.Next;
            end;
          end;
        finally
          ProgPswd.FreeQuery;
        end;
      end;
    end;
  end;
  DelStack;
end;

// ПАПКА_SFTP()
function c_Sftp(const cod: variant): string; overload;
begin
  result:=GetFtpDir(IsNilc(cod,Prog[fACC]));
end;

function c_Sftp(var av: array of variant): variant; overload;
begin
  result:=c_Sftp(av[1]);
end;

// ПРОГ_ФАЙЛЫ()
procedure SfptCnt(const av: array of variant; const sr: TSearchRec; var lDone: boolean);
const lMsgAutoBeg = Length(MsgAutoBeg);
var fl: boolean;
  s: string;
  i: THandle;
label lend;
begin
  AddStack('FMain.SfptCnt');
  if not IsNil(av[3]) then begin
    fl:=false;
    if FileMaskEquate(sr.Name,
    ABR_MSG+StringOfChar('?',CODSZ_ORG)+'-'+StringOfChar('?',CODSZ_PRG)+'-'+StringOfChar('?',CODSZ_NPP)+FILE_MSG_EXT) then begin
      i:=FileBufOpen(av[1]+sr.Name,fmShareDenyNone or fmOpenRead);
      if longword(i)<>INVALID_HANDLE_VALUE then begin
        SetLength(s,lMsgAutoBeg);
        if FileRead(i,pointer(s)^,lMsgAutoBeg)=lMsgAutoBeg then fl := s=MsgAutoBeg;
        FileClose(i);
      end;
    end;
    if fl<>av[3] then goto lend;
  end;
  if not IsNil(av[4]) then
    if SmailFtpIsOther(sr.Name)<>av[4] then goto lend;
  IncD(VariantVar(av[0])^,1);
lend:
  DelStack;
end;

function c_SftpCnt(var av: array of variant): variant;
begin
  AddStack('FMain.c_SftpCnt');
  result:=0; av[0]:=longint(@result);
  av[1]:=CorrDir(c_Sftp(null))+SmailDirBox[boolean(IsNilc(av[1],false)),boolean(IsNilc(av[2],false))]+PathDelim;
  MaskFilesProc(av[1]+'*.*',SfptCnt,av);
  DelStack;
end;

function c_UniqueFn(var av: array of variant): variant;
var fn: TFileName;
begin
  AddStack('FMain.c_UniqueFn');
  GetUniqueFn(av[1],'','',c_Sftp(av[3]),av[2],fn); result:=fn;
  DelStack;
end;

// ПРОГ_НАИМ()
function c_Prog(var av: array of variant): variant;
var pi: TProgInf;
begin
  AddStack('FMain.c_Prog');
  if IsNil(av[1]) then av[1]:=Prog[fProgKP];
  pi:=GetProgInf(Int0(av[1]));
  result:=IfThen(IsNil(av[2],false),pi.Abr,pi.Name);
  DelStack;
end;

// СТАТУС_НАИМ()
function c_Status(var av: array of variant): variant;
var i: longint;
  stv: TProgStatVidList;
begin
	AddStack('FMain.c_Status');
  if IsNil(av[1]) then av[1]:=Prog['STATUS'];
  result:=''; i:=IsNilc(av[2],Succ(stvName))-1;
  if InRange(i,byte(low(aProgStat)),byte(high(aProgStat))) then begin
    stv:=TProgStatVidList(i); i:=Int0(av[1]);
	  if InRange(i,byte(low(aProgStat[stv])),byte(high(aProgStat[stv])))
    then result:=aProgStat[stv,TProgStatList(i)];
  end;
  DelStack;
end;

// СОХР_...
function c_Upd(var av:array of variant):variant;
var r: TRecDB;
begin
	AddStack('FMain.c_Upd');
  result:=null; r:=PointerVar(av[0]); DWRdbSeek(TCustomRec(r)); r.UpdateRec;
  DelStack;
end;

function DocName(lDtg: boolean = false; const kd: string = ''): string;
begin
  AddStack('FMain.DocName');
  result:=StrNum('DOC',IfThen(kd='',Doc[fDOC],kd),3)+'.'+IfThen(lDtg,'DTG','DCC');
  DelStack;
end;

function QryFind(q: TMulQuery; f: TField; const v: variant): boolean;
begin
	AddStack('FMain.QryFind');
  if f.Value>v then while not q.Bof and (f.Value>v) do q.Prior
  else if f.Value<v then while not q.Eof and (f.Value<v) do q.Next;
  result := f.Value=v;
  if result then begin
    while not q.Bof do
      if f.Value=v then q.Prior
      else begin
        q.Next; break;
      end;
  end;
  if q.Bof then q.First;
  DelStack;
end;

function InterEval(Inter: TInter; var v: variant): boolean;
var s: string;
begin
  AddStack('FMain.InterEval');
  result:=true;
  v:=Inter.Eval;
  if not(Inter.error in [E_NO,E_ABORT]) then begin
    s:='Формула фильтра: '+DlmBetween('Программа',ProgInf.Abr,' ')+' в папке '+
      Trim(DM.DrvGet.CodeName(Prog[fDRV],[cdgBufAll]))+PathDelim+Trim(Prog['DIR']);
    result:=(InterShowError(Inter,[ieEsc],nil,nil,s)=mrOk);
  end;
  DelStack;
end;

// ВЫБТЕКПРОГ, ВЫБТЕКЗАЯВ
function d_FltCur(const v, ind: variant; lSave: boolean): variant;
var fl: boolean;
begin
	AddStack('FMain.d_FltCur');
  fl:=ind; result:=aFltCur[fl];
  if lSave then aFltCur[fl]:=v;
  DelStack;
end;

procedure FDcmStatInit(q: TMulQuery);
var i: longint;
begin
  AddStack('FMain.FDcmStatInit');
  FltStat:=nil; FltNum:=0; FltCnt:=q.RecordCountFiltered;
  for i:=0 to Application.ComponentCount-1 do
    if IsClass(Application.Components[i],TStat,pointer(FltStat)) then
      if FltStat.Visible then break else FltStat:=nil;
  DelStack;
end;

function FDcmSayStat(const st: string): boolean;
begin
  AddStack('FMain.FDcmSayStat');
  result:=DcmSayStat('',st,FltNum/FltCnt,FltStat);
  DelStack;
end;

// ДЛЯ_КЛИЕНТОВ
procedure c_OrgBeg; overload;
begin
	AddStack('FMain.c_OrgBeg');
  if TMulQuery.CreateConnection(qList,Application.MainForm,nil)
  then qList.PartSelect(tLIST,[],'',nmfbKO,'',false);
  if LockBuhRead then begin
    try
      qList.Open; fListKO:=qList.FindField(nmfbKO);
      if lListOpen then FDcmStatInit(qList);
    finally
      UnlockMode('FBUH');
    end;
  end
  else qList.Close;
  DelStack;
end;

function c_OrgBeg(var av: array of variant): variant; overload;
begin
  result:=null; lListOpen:=true; c_OrgBeg;
end;

function c_OrgEof(var av: array of variant): variant;
begin
	AddStack('FMain.c_OrgEof');
  result:=true;
  if qList.Active then if not qList.Eof then begin
  	List.GetFromQuery(qList);
    if lListOpen then begin
      Inc(FltNum); result:=FDcmSayStat('Клиент: '+Trim(List[nmfbKOD])+'. '+Trim(List[fNAME]));
    end
    else result:=false;
  end;
  DelStack;
end;

function c_OrgNext(var av: array of variant): variant;
begin
	AddStack('FMain.c_OrgNext');
  result:=null;
  if qList.Active then qList.Next;
  DelStack;
end;

function c_OrgEnd(var av: array of variant): variant;
begin
	AddStack('FMain.c_OrgEnd');
  result:=null; qList.Close;
  DelStack;
end;

// ДЛЯ_ПРОГРАММ
procedure FProgBeg;
var where: string;
  i: longint;
  lFlt: boolean;
begin
	AddStack('FMain.FProgBeg');
  if not lListOpen then c_OrgBeg;
  if TMulQuery.CreateNoActive(qProg,Application.MainForm) then begin
    fProgRECNO:=nil;
    if MyVarType(aFltCur[false])=varBoolean then lFlt := aFltCur[false] and ProgGet.qFiltered else lFlt:=false;
    if lFlt then with ProgGet,Qry do begin
      BeforeOpen:=QryBeforeOpen; Open;
    end;
    qProg.OnFilterRecord:=TMain.qProgFilterRecord; qProg.Filtered:=lFlt;
    where:='';
    if MyVarType(aFltCur[false])=varString then where:=aFltCur[false]
    else if aFltCur[false] and not lListOpen then begin
      where:=ProgGet.Qry.Arg[sWHERE];
      if IsPos(i,'and',where) then Delete(where,1,i+3) else where:='';
    end;
    qProg.PartSelect(tPROG,[],where,fORG);
    fProgKO:=qProg.FindField(fORG);
  end;
  if lListOpen then begin
    if qList.Active then QryFind(qProg,fProgKO,fListKO.AsInteger);
  end
  else FDcmStatInit(qProg);
  DelStack;
end;

function c_ProgBeg(var av: array of variant): variant; overload;
begin
  FProgBeg; result:=null;
end;

function c_ProgBeg: longint; overload;
begin
  FProgBeg; result:=qProg.RecordCount;
end;

procedure qListGet;
var fl: boolean;
begin
  AddStack('FMain.qListGet');
  if qList.Active then fl:=QryFind(qList,fListKO,fProgKO.AsInteger) else fl:=false;
  if fl then List.GetFromQuery(qList) else List.NewRec;
  Inc(FltNum);
  DelStack;
end;

function c_ProgEof: boolean; overload;
begin
	AddStack('FMain.c_ProgEof');
  result:=qProg.Eof;
  if not result and lListOpen then
    if qList.Active then result := fProgKO.AsInteger<>fListKO.AsInteger else result:=true;
  if not(lListOpen or result) then begin
    Prog.GetFromQuery(qProg);
    if not lListOpen then qListGet;
    result:=FDcmSayStat('Программа: '
      +Trim(DM.DrvGet.CodeName(Prog[fDRV],[cdgBufAll]))+PathDelim+Trim(Prog['DIR']));
  end;
  DelStack;
end;

function c_ProgEof(var av: array of variant): variant; overload;
begin
  result:=c_ProgEof;
end;

procedure c_ProgNext; overload;
begin
	AddStack('FMain.c_ProgNext');
  qProg.Next;
  DelStack;
end;

function c_ProgNext(var av: array of variant): variant; overload;
begin
  c_ProgNext; result:=null;
end;

procedure c_ProgEnd; overload;
begin
	AddStack('FMain.c_ProgEnd');
  if not lListOpen then begin
  	qProg.Close; qList.Close;
  end;
  DelStack;
end;

function c_ProgEnd(var av: array of variant): variant; overload;
begin
	c_ProgEnd; result:=null;
end;

// ДЛЯ_ЗАЯВОК
function c_ZajBeg(var av: array of variant): variant;
var where: string;
  lFlt: boolean;
  oBeforeOpen: TDataSetNotifyEvent;
begin
	AddStack('FMain.c_ZajBeg');
  result:=null; fZajRECNO:=nil;
  if TMulQuery.CreateConnection(qZaj,Application.MainForm,nil) then qZaj.OnFilterRecord:=Main.qZajFilterRecord;
  if MyVarType(aFltCur[true])=varBoolean then lFlt := aFltCur[true] and Main.zFiltered else lFlt:=false;
  if lFlt then with qZajMain do begin
    oBeforeOpen:=BeforeOpen; BeforeOpen:=Main.qZajBeforeOpen; Open; BeforeOpen:=oBeforeOpen;
  end;
  qZaj.Filtered:=lFlt;
  if (qProg.ActiveNoNil) then begin
    if (not qZaj.Active) then begin
      qZaj.Arg[sTABLE]:=tZAJ; where:=qProg.Arg[sWHERE];
      if where='' then qZaj.Arg[sC_LIST]:='*'
      else begin
        qZaj.AddArgList(sTABLE,tPROG);
        Zaj.AddCList(qZaj,[],nil,[addclSet]);
        DlmBetwSelf(where,tZAJ+'.'+fORG+'='+tPROG+'.'+fORG+sAND+tZAJ+'.'+fProgCP+'='+tPROG+'.'+fProgCP,sAND);
      end;
      qZaj.PartSelect('','',where,qZaj.GetList([tZAJ+'.'+fORG,tZAJ+'.'+fProgCP]));
      fZajKO:=qZaj.FindField(fORG);
      fZajCP:=qZaj.FindField(fProgCP);
    end;
  end else begin
    lListOpen:=false; c_OrgBeg;
    where:=tZAJ+'.'+fORG+'='+tPROG+'.'+fORG+sAND+tZAJ+'.'+fProgCP+'='+tPROG+'.'+fProgCP;
    if (MyVarType(aFltCur[true])=varString) then DlmBetwSelf(where,BrackNoEmp(aFltCur[true]),sAND)
    else if aFltCur[true] then begin
      where:=qZajMain.Arg[sWHERE]; Delete(where,1,Pos(sAND,where)+lAND-1);
    end;
    qZaj.PartSelect(qZaj.GetList([tZAJ,tPROG]),[],where,tZAJ+'.'+fORG);
    fProgKO:=qZaj.FindField(fORG);
    FDcmStatInit(qZaj);
  end;
  DelStack;
end;

function c_ZajEof(var av: array of variant): variant;
const nKO = 10;
var s: string;
begin
	AddStack('FMain.c_ZajEof');
  result:=qZaj.Eof;
  if (not result) then
    if (qProg.ActiveNoNil) then begin
    	s:=SpaceStr(Prog[fORG],nKO)+Prog[fProgCP];
    	while not qZaj.Eof and (SpaceStr(fZajKO.AsInteger,nKO)+fZajCP.AsString < s) do qZaj.Next;
		  result := qZaj.Eof or (SpaceStr(fZajKO.AsInteger,nKO)+fZajCP.AsString > s);
      if (not result) then Zaj.GetFromQuery(qZaj);
    end
    else begin
      Zaj.GetFromQuery(qZaj);
      Prog.GetFromQuery(qZaj,true,qZaj.FldDuplicate(fRECNO));
      result:=FDcmSayStat('Программа: '
        +Trim(DM.DrvGet.CodeName(Prog[fDRV],[cdgBufAll]))+PathDelim+Trim(Prog['DIR']));
    end;
  DelStack;
end;

function c_ZajNext(var av: array of variant): variant;
begin
	AddStack('FMain.c_ZajNext');
  result:=null;
  qZaj.Next;
  DelStack;
end;

function c_ZajEnd(var av: array of variant): variant;
begin
	AddStack('FMain.c_ZajEnd');
  result:=null;
  if not qProg.ActiveNoNil then begin
	  qZaj.Close;
    qList.Close;
  end;
  DelStack;
end;

{ TMain }
procedure TMain.FormCreate(Sender: TObject);
const apg: TArrBoolStr = ('Org','Flt');
  curTN  = 'ПЛЗ_НОМ';
  curKOD = 'КЛНТ_НОМ';
  aio: TArrBoolNamePrimStr =
    (('ПРОГ_ВХОДЯЩИЕ' ,'Входящие')
    ,('ПРОГ_ИСХОДЯЩИЕ','Исходящие')
    );
  aTpView: array[TTpView] of string = ('Windows','DOS','Выполнить','Документ','Основы');
  aMdSort: array[TMdSort] of string = ('[нет]','Дата','Общая версия','Вид основ','Основа','Тема','Не удалено/удалено');
var i,ir,j: longint;
  fl: boolean;
  s,ms: string;
  f,fx: TField;
  pr: TVarEvent;
  brq: TBrQuery;
  av: TDEPrmVar;
  lsm: TMemGkList;
  pg: TProgGet;
  ap: array[TProgIdList] of TNamePrimStr;
  pi: TProgInfIx;
begin
	AddStack('TMain.FormCreate',Self);
  OLTypes.ETnStatusUpdate:=ETnStatusUpdate; OLTypes.ZajEdProcKey:=ZajEdProcKey;
  OLTypes.deFltExec:=deFltExec; OLTypes.MsgToZaj:=MsgToZaj;
  InterCurHelpFile:=HelpFileOrglist;
  RbPage1.SetActivePage(tsOrg);
  ApplTitle.Add(ApplTitleBlink);
  ZeroMemory(@aHL,SizeOf(aHL));
  aHL[hlZaj     ].o:=tsZaj;
  aHL[hlMsgTo   ].o:=tsMsgTo;
  aHL[hlCng     ].o:=tsCng;
  aHL[hlSftp    ].o:=tsSftp;
  aHL[hlTnStatus].o:=ETnStatus;
  j:=0;
  for i:=low(ProgInfs) to high(ProgInfs) do MaxSelf(j,ProgInfs[i].Abr);
  for i:=1 to ofxCnt do ProgFldDispWidth[i]:=30;
  ProgFldDispWidth[ofxKOD]:=DM.ListGet.LenCode+DM.ListGet.LenName+2;
  ProgFldDispWidth[ofxKP]:=j;
  ProgFldDispWidth[ofxNp]:=lProgNP;
  ProgFldDispWidth[ofxCP]:=lProgCP;
  ProgFldDispWidth[ofxKD]:=Length(Drv[fNAME]);
  ProgFldDispWidth[ofxSTATUS]:=MaxSelf(aProgStat[stvLs]);

  ProgFldDispWidth[ofxAcc]:=length(Acc[fACC]);
  ProgFldDispWidth[ofxAccAct]:=16;
  ProgFldDispWidth[ofxFbVers]:=3;
  ProgFldDispWidth[ofxAccInout]:=8;
  ProgFldDispWidth[ofxAccOnsrv]:=3;
  ProgFldDispWidth[ofxDLast]:=Length(OurFormatDateTime(DLastFormat,Now));

  qZajMain:=TBrQuery.CreateConnection(Self,nil,dsZaj);
  qZajMain.Init(DBMain,['TDISPD'],['TDISPD'],
    (* по ходу порядок таблиц важен, т.к. в тексте подразумевается, что
      qZajMain.FldDuplicate(fRECNO) это именно поле recno таблицы PROG *)
    qZajMain.GetList([tZAJ,tPROG,tORG]),
    [],
    ArrayAsList([tPROG+'.'+fORG+'='+tORG+'.'+fORG,tZAJ+'.'+fORG+'='+tPROG+'.'+fORG,
    tZAJ+'.'+fProgCP+'='+tPROG+'.'+fProgCP,Zaj.tRECNO+'=0'],sAND));
  qZajMain.AfterOpen:=qZajMainAfterOpen;
  qZajMain.OnFilterRecord:=qZajMainFilterRecord;
  brZaj.OnGrayCell:=TDM.brZajGrayCell; brZaj.OnDrawColumnCell:=TDM.brZajDrawColumnCell;

  brMsgFrom:=TMsgBrowl.CreatePrm(Self,pnMsgFrom,'MsgFrom','Получатель',
    fMsgTNFROM+'='+QQs(qGlobKey)+sAND+FldIsTrue('DELFROM',false),[]);
  brMsgTo:=TMsgBrowl.CreatePrm(Self,pnMsgTo,'MsgTo','Отправитель',
    fMsgTNTO+'='+QQs(qGlobKey)+sAND+FldIsTrue('DELTO',false)+sAND+'TD1<='+QQs('{now}'),['now'],qMsgToBeforeOpen);

  qDoc:=TBrQuery.CreateConnection(Self,nil,dsDoc);
  qDoc.GlobKey:='1';
  qDocRECNO:=qDoc.Init(DBMain,[fDOC],[fDOC],tDOC,[],fCDR+'='+QQs(qGlobKey)+sOR+fCDR+'='+QQs);
  brDoc.FieldSeek:=qDoc.CreateStringField(fDOC,'Номер',0,taRightJustify);
  qDocNAME:=qDoc.CreateStringField(fNAME,'Наименование');
  qDocTN:=qDoc.CreateStringField(fCDR);
  qDocTN.Visible:=false;

  qOfis:=TBrQuery.CreateConnection(Self,nil,dsOfis);
  
  qCng:=TBrQuery.CreateConnection(Self,nil,dsCng);
  qCngRECNO:=qCng.Init(DBMain,[fCNGV,'DT'],[fCNGV],tCNGV,[fCNGV,fNAME,fRECNO,'DT','TPVIEW'],'','',qCngCalcFields);
  qCngCNG:=qCng.CreateBooleanField('CNG','Изменено');
  qCngCDT:=qCng.CreateStringField('CDT','Дата',LenDispDate);
  brCng.FieldSeek:=qCng.CreateStringField(fCNGV,'Номер',0,taRightJustify);
  qCngNAME:=qCng.CreateStringField(fNAME,'Наименование');
  qCngDT:=qCng.CreateIntegerField('DT','Дата');
  qCngDT.Visible:=false;
  qCngTPVIEW:=qCng.CreateField('TPVIEW');

  TMulQuery.CreateConnection(qMsgCdr,Self,nil);

  for i:=1 to ofzCnt do aFixzLen[i]:=30;
  aFixzLen[ofzTD]:=LenDispDate;
  aFixzLen[ofzNZ]:=10;
  aFixzLen[ofzDACT]:=Length(StringToDispDate('20000101',3));
  aFixzLen[ofzTXT]:=40;
  aFixzLen[ofzTISPD]:=LenDispDate+6;
  aFixzLen[ofzISPV]:=MaxSelf(aIspv);
  aFixzLen[ofzTWTN]:=LenDispDate;
  aFixzLen[ofzTWD]:=LenDispDate+6;
  aFixzLen[ofzSELISPSH]:=40;
  aFixzLen[ofzTSELISP]:=LenDispDate;
  aFixzLen[ofzBALL0]:=10;
  aFixzLen[ofzSET]:=1;
  aFixzLen[ofzBALL1]:=10;
  aFixzLen[ofzBALL2]:=10;
  aFixzLen[ofzCNTISP]:=2;
  aFixzLen[ofzTSELISPE]:=LenDispDate;
  aFixzLen[ofzMOV]:=40;

  if not IsSQLBased then mnServ.DeleteKey(K_Alt_9);
  if PswdPrm.SuperUser then begin
  	SetSuper; mnServ.KeyVisible[K_Alt_2]:=not empty(Glob[sMemo+'CALC']);
    deOtd.FrmCaption:=IfThen(GlobOTDNUM=0,'Приём заявок из отделений',
    	'Передача заявок головной организации');
    deOtd.Param['OtdDir',deCaption]:=IfThen(GlobOTDNUM=0,'Папка с заявками отделений',
    	'Папка для копирования заявок');
    deOtd.Param['OtdDir',deMask]:=deOtd.Param['OtdDir',deCaption];
    mnServ.KeyCaption[K_Alt_F5]:=deOtd.FrmCaption;
  end
  else mnServ.DeleteKeys([K_Alt_0,K_Alt_1,K_Alt_2,K_Alt_7,K_Alt_8,K_Alt_9,K_Alt_F2,K_Alt_F3,K_Alt_F5]);
  dw:=TDWWin.Create(Self); ls:=TStringList.Create; lsf:=TFldList.Create; DefOrgDat;
  aProgFld[false]:=EProg; aProgFld[true]:=EFlt;
  for fl:=false to true do begin
    pg:=TProgGet.Create(Self); pg.VName:=apg[fl]; pg.lFlt:=fl; aProgFld[fl].AssignGet(pg);
  end;
  ProgGet.Status:=stFlt;
  TTImeGet.Create(Self);
  if (OldVers<>'') and (OldVers<'1.65') then with ProgPswd.GetQuery do begin
    for fl:=false to true do ProgGet(fl).fdef.OrdRead(nil,'');
    PartSelect(tCDR,[fRECNO,sMemo+'ORDORG',sMemo+'ORDFLT',sMemo+'ORDZAJ']);
    lsm:=TMemGkList.Create(Cdr);
    while not Eof do begin
      lsm.GetFromQuery;
      Cdr[sMemo+'ORDORG']:=ProgGet(false).Ord2Mem(Cdr[sMemo+'ORDORG'],false);
      Cdr[sMemo+'ORDFLT']:=ProgGet.Ord2Mem(Cdr[sMemo+'ORDFLT'],false);
      Cdr[sMemo+'ORDZAJ']:=ProgGet.Ord2Mem(Cdr[sMemo+'ORDZAJ'],true);
      Cdr.UpdateRec; Next;
    end;
    ProgPswd.FreeQuery;
  end;
  s:='';
  for i:=low(ProgInfs) to high(ProgInfs) do IncD(s,mniDlm+ProgInfs[i].Name);
  deProgSel.Param['PROG',deMask]:=Copy(s,lmniDlm1,MaxInt);
  deSelIsp.OnFldChange:=TDM.deSelIspFldChange;
  perform(WM_CNGPRIV,0,0);
  TnEnabled;
  inherited;
  TDWPrm.VarCreate(Prog);
  with TInter do begin
    SetVar('$curdat','Текущие данные');
    SetVar(curTN,'Номер текущего пользователя',d_Var,VarArrayOf([LongInt(Cdr),Cdr.NumFromName(fCDR)]),'C',true);
    SetVar(curKOD,'Номер текущего клиента',d_orgkod,Cdr.NumFromName('ORGKOD'),'C',true);
    SetVar('ПРОГ_ВЫВПОЛЯ','Список наименований полей, выводимых на странице "Программы"',d_fltprogfld,0,'A',true);
    SetVar('FltProgArr','',d_fltprogarr,0,'C',true);
    SetVar('$progdat','ПРОГ_','Сведения по программе'); ir:=LongInt(Prog);
    for i:=1 to ofxCnt do with ProgFld[i] do if ofvVar<>'' then begin
      case i of
        ofxKOD: pr:=d_progorg;
        ofxAccAct: pr:=d_accact;
        ofxAccOnsrv: pr:=d_acconsrv;
        else pr:=d_Var;
      end;
      SetVar(ofvVar,ofvName,pr,VarArrayOf([ir,ofvFld]),ofvType,true);
    end;

    for fl:=false to true do SetVar(aio[fl,1],aio[fl,2],d_accinout,VarArrayOf([ir,fl]),'I',true);

    {SetVar('ПРОГ_WIN','Программа для Windows',d_progwin,null,'L',true);
    SetVar('ПРОГ_ЗАРП','Программа типа "ЗАРПЛАТА"',d_progzp,null,'L',true);}
    SetVar('$flt','Выборки');
    SetVar('ВЫБТЕКПРОГ','Признак соответствия выборки по программам текущей выборке',d_FltCur,false,'LC');
    SetVar('ВЫБТЕКЗАЯВ','Признак соответствия выборки по заявкам текущей выборке',d_FltCur,true,'LC');
    SetVar('$orgdat','ОРГ_','Сведения по клиенту'); ir:=LongInt(List);
    SetVar('ОРГ_НОМ','Номер клиента',d_Var,VarArrayOf([ir,nmfbKOD]),'C',true);
    SetVar('ОРГ_НАИМ','Наименование клиента',d_Var,VarArrayOf([ir,fNAME]),'C',true);
    SetVar('$zajdat','ЗАЯВ_','Сведения по заявке'); ir:=LongInt(Zaj);
    SetVar('ЗАЯВ_ДАТА','Дата поступления заявки',d_date,VarArrayOf([ir,Zaj.NumFromName(fTD)]),'D',true);
    SetVar('ЗАЯВ_ИСПД1','Дата начала исполнения заявки',d_date,VarArrayOf([ir,Zaj.NumFromName('TISPD')]),'D',true);
    SetVar('ЗАЯВ_ИСПД2','Дата конца исполнения заявки',d_date,VarArrayOf([ir,Zaj.NumFromName('TISPD1')]),'D',true);
    SetVar('ЗАЯВ_ИСПНОМ','Номер исполнителя заявки',d_Var,VarArrayOf([ir,Zaj.NumFromName('ISPTN')]),'C',true);
    SetVar('ЗАЯВ_ИСПВИД','Вид исполнения заявки',d_Var,VarArrayOf([ir,Zaj.NumFromName('ISPV')]),'I',true);
    SetVar('ЗАЯВ_НОМ','Номер заявки',d_Var,VarArrayOf([ir,Zaj.NumFromName('NZ')]),'I',true);
    SetVar('ЗАЯВ_ОТЛОЖ','Заявка отложена до даты',d_Var,VarArrayOf([ir,Zaj.NumFromName('DACT')]),'D',true);
    SetVar('ЗАЯВ_ПРОЧИТ','Заявка прочитана',d_bool,VarArrayOf([ir,Zaj.NumFromName('SEL')]),'L',true);
    SetVar('ЗАЯВ_ПРИНЯЛ','Номер пользователя, принявщего заявку',d_Var,VarArrayOf([ir,Zaj.NumFromName(fCDR)]),'C',true);
    SetVar('ЗАЯВ_ТЕКСТ','Текст заявки',GetZajTxt,fTXT,'C',true);
    SetVar('ЗАЯВ_ДВИЖ','Движение заявки',GetZajTxt,'MOV','C',true);
    SetVar('ЗАЯВ_ПРИСПД1','Дата начала предполагаемого исполнения заявки',d_date,VarArrayOf([ir,Zaj.NumFromName('TWD')]),'D',true);
    SetVar('ЗАЯВ_ПРИСПД2','Дата конца предполагаемого исполнения заявки',d_date,VarArrayOf([ir,Zaj.NumFromName('TWD1')]),'D',true);
    SetVar('ЗАЯВ_ПРИСПНОМ','Номер предполагаемого исполнителя заявки',d_Var,VarArrayOf([ir,Zaj.NumFromName('WTN')]),'C',true);
    SetVar('ЗАЯВ_ПРИСПД','Дата установки предполагаемого исполнителя заявки',d_date,VarArrayOf([ir,Zaj.NumFromName('TWTN')]),'D',true);
    SetVar('ЗАЯВ_ВЫБИСП','Примечание к выбору исполнителя заявки',d_Var,VarArrayOf([ir,Zaj.NumFromName('SELISP')]),'C',true);
    SetVar('ЗАЯВ_ВЫБИСПД','Дата изменения выбора исполнения заявки',d_date,VarArrayOf([ir,Zaj.NumFromName('TSELISP')]),'D',true);
    SetVar('ЗАЯВ_ВЫБИСПКОН','Дата окончания выбора исполнения заявки',d_date,VarArrayOf([ir,Zaj.NumFromName('TSELISPE')]),'D',true);
    SetVar('ЗАЯВ_БАЛНАЧ','Количество баллов заявки первоначально',d_Var,VarArrayOf([ir,Zaj.NumFromName('BALL0')]),'I',true);
    SetVar('ЗАЯВ_БАЛКОН','Количество баллов заявки окончательно',d_Var,VarArrayOf([ir,Zaj.NumFromName('BALL1')]),'I',true);
    SetVar('ЗАЯВ_БАЛДОП','Количество баллов заявки дополнительно',d_Var,VarArrayOf([ir,Zaj.NumFromName('BALL2')]),'I',true);
    SetVar('ЗАЯВ_УТВЕРЖ','Заявка утверждена',d_bool,VarArrayOf([ir,Zaj.NumFromName('LSET')]),'L',true);
    SetVar('ЗАЯВ_ПЕРЕОЦЕН','Причина переоценки заявки',d_Var,VarArrayOf([ir,Zaj.NumFromName('REVALUE')]),'C',true);

    SetFunction('Общие',10100);
    SetFunction('ПЛЗ_ФИО','ФИО пользователя по номеру',['[Номер: целое|строка]'],['ICU'],c_Name,
      VarArrayOf([LongInt(CdrGet),curTN,lCdrTn]),10101,'C');
    SetFunction('ДИСК_НАИМ','Параметры сетевого диска по коду',['[Код: строка]','[Вид: целое]'],['CU','IU'],
      c_Name,VarArrayOf([LongInt(DM.DrvGet),ProgFld[ofxKD].ofvVar,ProgFld[ofxFbVers].ofvVar]),10102,'C');
    SetFunction('КЛНТ_НАИМ','Наименование клиента по номеру',['[Номер: целое|строка]'],['ICU'],c_Name,
      VarArrayOf([LongInt(DM.ListGet),curKOD,DM.ListGet.LenCode]),10103,'C');
    SetFunction('АРХИВ_ИНФО','Информация об архиве',['ИмяФайла: строка','[РегНом: логическое]'],
      ['C','LU'],c_PckInfo,null,10108,'A');
    SetFunction('СИСТ_ПРМ','Системные параметры',['Индекс: целое'],['I'],c_SysPrm,null,10107,'CA');
    SetFunction('ФАЙЛ_УНИК','Уникальное имя файла с учётом файлов интернета',
      ['Префикс: строка','Расширение: строка','[УчЗапИнт: целое|строка]'],['C','C','ICU'],
      c_UniqueFn,null,0,'C');

    SetFunction('Программы');
    SetFunction('ПРОГ_НАИМ','Наименование вида программы по номеру',
      ['[Номер: целое|строка]','[Сокр: логическое]'],['ICU','LU'],c_Prog,null,10104,'C');
    SetFunction('СТАТУС_НАИМ','Наименование статуса программы по номеру',
      ['[Номер: целое|строка]','[Вид: целое]'],['ICU','IU'],c_Status,null,10105,'C');
    SetFunction('ПАПКА_ИНФО','Информация о папке с программой',['Папка: строка'],['C'],
      c_DirInfo,null,10106,'A');
    SetFunction('ПАПКА_SFTP','Папка SFTP для программы',['[УчЗапИнт: целое|строка]'],['ICU'],
      c_Sftp,null,0,'C');
    SetFunction('ПРОГ_ФАЙЛЫ','Количество файлов в интернете для программы',
      ['[Выход: логическое = '+vFalse+']','[Архив: логическое = '+vFalse+']','[АС: логическое]','[Прочие: логическое]'],
      ['LU','LU','LU','LU'],c_SftpCnt,null,0,'I');

    SetFunction('Сохранение изменений');
    SetFunction('СОХР_ОРГ','Сохранить изменения в данных по клиенту',c_Upd,LongInt(List));
    SetFunction('СОХР_ПРОГ','Сохранить изменения в данных по программе',c_Upd,LongInt(Prog));
    SetFunction('OrgBeg',c_OrgBeg);
    SetFunction('OrgEof',c_OrgEof);
    SetFunction('OrgNext',c_OrgNext);
    SetFunction('OrgEnd',c_OrgEnd);
    SetFunction('ProgBeg',c_ProgBeg);
    SetFunction('ProgEof',c_ProgEof);
    SetFunction('ProgNext',c_ProgNext);
    SetFunction('ProgEnd',c_ProgEnd);
    SetFunction('ZajBeg',c_ZajBeg);
    SetFunction('ZajEof',c_ZajEof);
    SetFunction('ZajNext',c_ZajNext);
    SetFunction('ZajEnd',c_ZajEnd);
    SetOperator('ДЛЯ_КЛИЕНТОВ','Организует цикл по клиентам',
      'OrgBeg()'+CRLF+
      'ПОКА !OrgEof()',1,20001);
    SetOperator('КОНЕЦ_КЛИЕНТОВ','Закрывает цикл по клиентам',
        'OrgNext()'+CRLF+
      'КОНЕЦ_ПОКА'+CRLF+
      'OrgEnd()',2,20001);
    SetOperator('ДЛЯ_ПРОГРАММ','Организует цикл по программам',
      'ProgBeg()'+CRLF+
      'ПОКА !ProgEof()',1,20002);
    SetOperator('КОНЕЦ_ПРОГРАММ','Закрывает цикл по программам',
        'ProgNext()'+CRLF+
      'КОНЕЦ_ПОКА'+CRLF+
      'ProgEnd()',2,20002);
    SetOperator('ДЛЯ_ЗАЯВОК','Организует цикл по заявкам',
      'ZajBeg()'+CRLF+
      'ПОКА !ZajEof()',1,20003);
    SetOperator('КОНЕЦ_ЗАЯВОК','Закрывает цикл по заявкам',
        'ZajNext()'+CRLF+
      'КОНЕЦ_ПОКА'+CRLF+
      'ZajEnd()',2,20003);
  end;
  InitArr(av);
  av[deAutoSel]:=true;
  av[deNoReadOnly]:=true;
  with deFlt do begin
    AssignGet(0,TTblChkOrdGet.Create(Self));
{$IFDEF FLTPROG}
    TFltProgGet.Create(Self); TFltZajGet.Create(Self);
    while Fields.Count>1 do DestroyFld(1);
    av[deNameRec]:=Cdr.NameRec;
    av[deNameRecFld]:=sMemo+'FFLT';
    CreateFld(av);
{$ELSE}
    Param['STATUS',deMask]:=ArrayAsList(aProgStat[stvName],mniDlm);
    for i:=low(aFlt) to high(aFlt) do with aFlt[i] do begin
      AssignGet(deFltFld+f,DM.RadioGet1);
      Param[deFltFld+f,deMask]:=RadioMask(aSex[sex],0);
    end;
{$ENDIF}
  end;
  lsz:=TFldList.Create;
  lsrz:=TIntegerList.Create([ilsSorted]);
  iZaj:=TInter.Create('Формула фильтра (заявки)');
	iZaj.ShowError:=false;
  iZaj.value_types:='L';

  deZajIsp.Param['SI_ZAJ_TXT',deMask]:=TSpGkLs.GetPrm(tZAJ);
  deSendInt.Param['SI_MSGPTRN',deMask]:=TSpGkLs.GetPrm('simsg');
  CreateForm(TCdrLs,CdrLs);
  qOfis.Assign(CdrLs.BrQuery1);
  qOfis.FieldDefs.Update;
  for i:=0 to CdrLs.BrQuery1.FieldCount-1 do begin
    fx:=CdrLs.BrQuery1.Fields[i];
    if (fx.FieldKind=fkCalculated) then begin
      f:=TFieldClass(fx.ClassType).Create(qOfis.DataSet);
      f.FieldName:=fx.FieldName;
      f.Calculated:=true;
      f.DataSet:=qOfis.DataSet;
    end else begin
      f:=qOfis.FieldDefs.Find(fx.FieldName).CreateField(qOfis.DataSet);
    end;
    BrSetSize(f,fx.Size);
    f.DisplayLabel:=fx.DisplayLabel;
    f.Visible:=fx.Visible;
  end;
  brOfis.Assign(CdrLs.Browl1);
  brOfis.DataSource:=dsOfis;
  if (CdrLs.Browl1.FieldSeek<>nil) then begin
    brOfis.FieldSeek:=dsOfis.DataSet.FindField(CdrLs.Browl1.FieldSeek.FieldName);
  end;
  i:=CdrLs.de.Fields.Count; SetLength(afnmCdr,i);
  for i:=0 to i-1 do afnmCdr[i]:=CdrLs.de.GetArrParam(i)[deNameRecFld];
  deCng.Param['VAL1',deCaption]:='Следить за изменением (список через "'+DirAddDlm+'"):';
  deCng.Param['TPVIEW',deMask]:=RadioMask(aTpView,0);
  Finalize(ap); ZeroMemory(@ap,SizeOf(ap));
  for pi:=low(ProgInfs) to high(ProgInfs) do with ProgInfs[pi] do if ArrIntFind(id,aProgId,i) then if ap[i,1]='' then begin
    ap[i,1]:=IntToStr(id); ap[i,2]:=Name; ProgIdName[i]:=Name;
  end;
  deCng.Param[fMDP,deMask]:=MenuACN2Mask(ap);
  lsCng:=TIntegerList.Create([ilsSorted]);
  MDTGet.OnClick:=TMDTLs.Execute;
  deMdFlt.Param['MDDEL',deMask]:=ArrayAsList(aMdDel,mniDlm);
  av[deNameRec]:=rMdFlt.NameRec;
  av[deReadOnlyNoVsbl]:=true;
  av[deRelation]:=DM.Rec.NameRec+'.VAL4';
  ms:=MenuArr2Mask(aMdSort);
  for i:=1 to cntMdSort do begin
    s:=IntToStr(i);

    av[deCaption]:=s+'.';
    av[deNameRecFld]:='ST'+s;
    SchemDM.MenuGet1.AssignGet(av);
    av[deMask]:=ms;
    av[deTag]:=true;
    deMdFlt.CreateFld(av);
    rMdFlt.CreateFld(av[deNameRecFld],ftInteger,0,0,'Сортировка '+s+': тип');

    av[deCaption]:='';
    av[deNameRecFld]:='SG'+s;
    SchemDM.BoolGet1.AssignGet(av);
    av[deMask]:='';
    av[deTag]:=false;
    deMdFlt.CreateFld(av);
    rMdFlt.CreateFld(av[deNameRecFld],ftBoolean,0,false,'Сортировка '+s+': группировать');
  end;
  FHelpCore:=TTsHelpCore.Make(Self,TreeHelp,'OrgListHelp',nil,GetHelpDir,nil);
  UpdateInstructionsSheetState;
  DelStack;
end;

procedure TMain.FormDestroy(Sender: TObject);
var lGet: boolean;
begin
	AddStack('TMain.FormDestroy',Self);
  ApplTitle.Del(ApplTitleBlink);
  for lGet:=false to true do aProgFld[lGet].curget.Free;
  inherited;
  dw.Active:=false; TFldList.BrFree(qZajMain,adopz); lsf.Free; lsz.Free; ls.Free; iZaj.Free; lsrz.Free;
  lsCng.Free;
  DelStack;
end;

procedure TMain.FormActivate(Sender: TObject);
begin
	AddStack('TMain.FormActivate',Self);
  inherited;
  KeyLb1.SetKey(K_F10,'','Выход',mnExitProcKey,'exitF10',kmFile);
  DelStack;
end;

procedure TMain.FormShow(Sender: TObject);
begin
  AddStack('TMain.FormShow',Self);
  inherited;
  CngPage(nil);
  DelStack;
end;

procedure TMain.DefOrgDat;
var i,j: longint;
  ap: TDEPrmStr;
  lGet,lView: boolean;
  s: string;
  aod: array[TOrgDatList] of record
    a: TArrStr;
    l: longint;
  end;
  od: TOrgDatList;
  dwfi: ^TDWFldInfo;
  g: TCustomGet;
begin
  AddStack('TMain.DefOrgDat',Self);
  s:='';
  for od:=low(aod) to high(aod) do with aod[od] do l:=LsArrDynamic(GlobORGDAT[od],a,',',lsaSort);
  dw.dw.LoadFromStr(Van[VAN_WD]);
  ls.Text:=dw.dw.Fields;
  i:=0;
  lsf.Text:=ls.Text;
  j:=0;
  while i < ls.Count do begin
    ap:=DEGetArrParam(ls[i]);
    if NameGet(g,ap) then lGet:=not(g is TBtMskGet) else lGet:=false;
    with aod[orgdatNoOut] do lView:=not QuickFind(ap[deNameRecFld],a,l);
    if lGet and lView then begin
      ap[deNoReadOnly]:=bFalse;
      ls[i]:=DESetArrParam(ap);
      Inc(i);
    end
    else ls.Delete(i);
    if lGet then begin
      lsf[j]:=List.DWVarName(ap[deNameRecFld]);
      Inc(j);
      SetByte(s,1,j,lView);
      with aod[orgdatBold] do SetByte(s,2,j,QuickFind(ap[deNameRecFld],a,l));
    end
    else lsf.Delete(j);
  end;
  dw.dw.Fields:=ls.Text;
  dw.FldOnPanel(dw.dw.SaveToStr,'Org','Информация об организации',pnOrgDat);
  with aod[orgdatBold] do ChildFldAll(pnOrgDat,PrSetFldCng,[LongInt(@a),l]);
  dw.Active:=true;
  lsf.Fill(nil,[fldfWithoutRelation]);
  DM.Rec['OrgDat']:=s;
  ls.Clear;
  for i:=0 to lsf.Count-1 do begin
    dwfi:=@lsf.GetInf(i).DWFldInfo;
  	dwfi^.DisplayLabel:=lsFldLabel(lsf,i);
    ls.Add(StrTran(dwfi^.DisplayLabel,UnDelim,' '));
  end;
  deSys.Param['OrgDat',deMask]:=
    'ДАННЫЕ ПО КЛИЕНТУ'+UnDelim+'выводить'+mniDlm+'выделить'+UnDelim+StrTran(TrimRight(ls.Text),CRLF,mniDlm);
  TDWPrm.VarCreate(List);
  DelStack;
end;

function VanGet: TCodeGet;
begin
  AddStack('FMain.VanGet');
  if not Assigned(FVanGet) then begin
    FVanGet:=TCodeGet.Create(DM);
    with FVanGet do begin
      Connection:=DBBuh;
      VName:='Van'; FieldsCode:='VIDNO';
      with MulPar do begin
        Values[sCod_C]:=QQs('%'); Values[sTABLE]:=tVAN; Values[sC_LIST]:='*';
        Values[sWHERE]:='VIDNO'+qCod_C;
      end;
      Part:=sSELECT_WORDER; OnFormIBList:=TMain.VanGetFormIBList; OnAfterList:=TMain.VanGetAfterList;
    end;
  end;
  result:=FVanGet;
  DelStack;
end;

class function TMain.VanGetFormIBList;
begin
	AddStack('TMain.VanGetFormIBList');
  CreateForm(TVanLs,VanLs); result:=VanLs;
  DelStack;
end;

class procedure TMain.VanGetAfterList;
begin
	AddStack('TMain.VanGetAfterList');
  FormFree(VanLs);
  DelStack;
end;

class function TMain.PrBuhLoad;
	procedure OrgDel(q,q1: TMulQuery);
  var fl: boolean;
    s: string;
  begin
    AddStack('TMain.PrBuhLoad.OrgDel');
    fl:=Ask(['Внимание !','Клиент с номером '+TrimRight(q.Fields[0].AsString),'был удалён из "Бухгалтерии".',
	    'Удалить данного клиента ?']);
    if fl then begin
    	s:=fORG+'='+VTos(q.Fields[1]); q1.DeleteTable(tZAJ,s); q1.DeleteTable(tPROG,s);
      q1.UpdateTable(tMSG,[fORG,fProgNP],[0,QQs],s);
      q1.DeleteTable(tORG,RecnoWhere(q.Fields[2]));
    end;
    if Assigned(Sender)
    then Summ.SetS('3,'+TrimRight(q.Fields[0].AsString)+',','S',IfThen(fl,'удалён','отказ от удаления'));
    q.Next;
    DelStack;
  end;
var q: TMulQuery;
  s: string;
  fl: boolean;
  procedure CopyTbl(const tbl: string);
  var isTableChanged,b: boolean;
      mqflX,mqflY: TMQFieldList;
      fiX,fiY: PMQFieldInfo;
      k,j: longint;
      ms: string;
  begin
    AddStack('TMain.PrBuhLoad.CopyTbl');
    if result then begin
      mqflX:=GetFieldList(DBBuh,tbl);
      mqflY:=GetFieldList(tbl);
      isTableChanged := mqflX.Count<>mqflY.Count;
      if (not isTableChanged) then begin
        for k:=0 to mqflX.Count-1 do begin
          j:=mqflY.IndexOf(mqflX[k]);
          if (j<0) then begin
            isTableChanged:=true;
            break;
          end;
          fiX:=mqflX.Fields(k);
          fiY:=mqflY.Fields(j);
          if (fiX.DataType<>fiY.DataType)or
          ((not (fiX.DataType in [ftInteger,ftFloat,ftDate]))and(fiX.Size<>fiY.Size)) then begin
            (* см. TMQFieldList.IBDataType *)
            isTableChanged:=true;
            break;
          end;
        end;
      end;

      if (isTableChanged)and(not fl) then begin
        fl:=LockSuper; result:=fl;
      end;

      if result and (not isTableChanged)or(fl) then begin
        b:=true;
        if (isTableChanged) then begin
          if (not q.DropTable(tbl,@ms)) then begin
            b:=false;
            mess_ok(['Не могу удалить таблицу "'+tbl+'"',ms]);
          end else begin
            q.DBFlush;
          end;
        end else begin
        	q.Arg[sTABLE]:=tbl;
          q.ExecPart(sD_TABLE);
{if tbl=tLIST then begin
j:=1; msr;
end;}
        end;
        if b then CopyTable(DBBuh,DBMain,tbl,ttNone,IfThen(not isTableChanged,cptNoCreate),nil,s);
      end;
    end;
    DelStack;
  end;
type
  TVanMem = 0..1;
  TVanMemArr = array[TVanMem] of string;
  TGlobMem = 0..2;
  TGlobMemArr = array[TGlobMem] of string;
const
  a: TVanMemArr = (VAN_WD,VAN_DD);
  ag: TGlobMemArr = (sMemo+'PROGD',sMemo+'PROGW',sMemo+'CALC');
var lsm: TMemGkList;
  af,ares: TArrStr;
  av,av0: array[TVanMem] of variant;
  ost,i,k,ko,lr: longint;
  qb,qb1,q1: TMulQuery;
  db: TDatabase;
  asgk: TArrStr;
  agv: TArrVar;
  lMain: boolean;
  av1: TDEPrmVar;
  od: TOrgDatList;
begin
  ost:=AddStack('TMain.PrBuhLoad');
  SetLogVid(logvBuhLoad); result:=true;
  if Assigned(Sender) then begin
    result:=DcmGetWnd;
    if result then SummInit;
  end;
  if result then begin
    repeat
      result:=ProgPswd.DBConnect(DBBuh,'BUH','Ошибка подключения к данным "Бухгалтерии"');
      if not result then
        if not ProgPswd.PrmLocal([''],['']) then break;
    until result;
    if result then begin
      qb:=GetQuery(DBBuh);
      q:=GetQuery;
      lMain := not IsField(DBBuh,tGLOB,ag[0]);
      if not Assigned(Sender) then begin
        q.PartSelect(tGLOB,[fRECNO]);
        if q.Eof then Glob.AppRec(false,1) else Glob.GotoRec(q.Fields[0]);
        if empty(GlobVIDNO) then begin
          qb.PartSelect(tGLOB,['VIDNO']);
          if empty(qb.Fields[0].AsString) then with TDefEdit.Create(ProgPswd) do begin
            NameWnd:='GlobVidno'; InitArr(av1);
            av1[deNameRec]:=Glob.NameRec;
            av1[deNameRecFld]:='VIDNO';
            VanGet.AssignGet(av1);
            av1[deAutoSel]:=true;
            av1[deNoReadOnly]:=true;
            CreateFld(av1);
            result:=Execute('Вид аналитического учёта "Список клиентов"').Saved; Free;
          end
          else begin
          	Glob['VIDNO']:=qb.Fields[0].AsString; Glob.UpdateRec;
          end;
          GlobVIDNO:=Glob['VIDNO'];
        end;
      end;
      if result then begin
        s:='VIDNO='+QQs(GlobVIDNO);
        qb.PartSelect(tVAN,[fNAME],s);
        result:=TrimUpper(qb.Fields[0].AsString)='СПИСОК ПОКУПАТЕЛЕЙ';
        if (not result) then begin
          mess_ok(['Внимание!','Был изменён вид аналитического учёта для списка клиентов.',
            'Обратитесь к разработчикам.']);
        end else begin
          fl:=false; result:=LockBuhWrite;
          if result then try
            if Van.Active then begin
              Van.Seek(Van.TblFldName(s)); Van.VarBlankSelf(a); Van.UpdateRec;
            end;
            CopyTbl(tVAN);
            CopyTbl(tLIST);
          finally
            if fl then UnlockSuper;
            UnlockMode('FBUH');
          end;

          if result then begin
            for i:=low(a) to high(a) do begin
              av[i]:=a[i]; av0[i]:=0;
            end;
            q.PartSelect(tVAN,av);
            CopyFrom(af,a); lsm:=TMemGkList.Create(q,qb,@af); SetLength(ares,length(a));
            k:=0;
            for i:=low(a) to high(a) do begin
              ares[k]:=lsm.GetValue(q.Fields[i].AsInteger); inc(k);
            end;

            q.UpdateTable('',av,av0);
            Van.OpenRec;
            Van.Seek(Van.TblFldName(s));
            for i:=low(a) to high(a) do Van[a[i]]:=ares[i];
            Van.UpdateRec;
            // Синхронизация Org c List
            q1:=GetQuery;
            qb.PartSelect(tLIST,[nmfbKOD,nmfbKO,fRECNO,fNAME],'VIDNO='+QQs(GlobVIDNO),qb.GetList([nmfbKO,nmfbKOD]));
            q.PartSelect(tORG,['KOD',fORG,fRECNO],fORG+'<>0',fORG); qb1:=GetQuery(DBBuh);
            lr:=qb.RecordCount; k:=0;
            for i:=1 to lr do begin
              if DcmSayStat('','Программа: '+Trim(qb.Fields[0].AsString)+'. '+Trim(qb.Fields[3].AsString),i/lr) then break;
              ko:=qb.Fields[1].AsInteger;
              while not q.Eof and (q.Fields[1].AsInteger<ko) do OrgDel(q,q1);
              if not q.Eof and (q.Fields[1].AsInteger=ko) then begin
                if TrimRight(q.Fields[0].AsString)<>TrimRight(qb.Fields[0].AsString) then begin
                  q1.UpdateTable(tORG,['KOD'],[QQs(qb.Fields[0])],RecnoWhere(q.Fields[2]));
                  if Assigned(Sender) then begin
                    s:='2,'+TrimRight(q.Fields[0].AsString)+',';
                    Summ.SetS(s,'S',TrimRight(qb.Fields[3].AsString));
                    Summ.SetS(s,'S1',TrimRight(qb.Fields[0].AsString));
                  end;
                end;
                q.Next;
              end
              else begin
                Org.NewRec; Org['KOD']:=qb.Fields[0].AsString;
                if ko=k then Org.KodNextSelf(fORG) else Org[fORG]:=ko;
                Org.AppRec;
                if ko=k then begin
                  k:=Org[fORG]; s:=RecnoWhere(qb.Fields[2]);
                  q1.UpdateTable(tLIST,[nmfbKO],[k],s);
                  qb1.UpdateTable(tLIST,[nmfbKO],[k],s);
                end;
                if Assigned(Sender) then begin
                  s:='1,'+TrimRight(qb.Fields[0].AsString)+',';
                  Summ.SetS(s,'S',TrimRight(qb.Fields[3].AsString));
                end;
              end;
              k:=ko; qb.Next;
            end;
            while not q.Eof do OrgDel(q,q1);
            FreeQuery; FreeQuery; DcmSayStat('');
            if Assigned(Sender) then begin
              s:=EdGenFr.RDocpPrm['ПАПКА'];
              if not empty(s) then
                if DirectoryExists(s) then begin
                  db:=ProgPswd.DBDBF(s);
                  try
                    SetConnected(db,true);
                    CopyTable(DBMain,db,tGLOB,ttNone,[cptNoTxtTo]);
                    CopyTable(DBMain,db,tVAN,ttNone,[cptNoTxtTo]);
                    CopyTable(DBMain,db,tLIST,ttNone,[cptNoTxtTo]);
                    SetLength(asgk,Length(a)+Length(ag)); lr:=low(asgk);
                    for i:=low(a) to high(a) do begin
                      asgk[lr]:=Vtos(Van.MemGk[a[i]]); Inc(lr);
                    end;
                    for i:=low(ag) to high(ag) do begin
                      asgk[lr]:=Vtos(Glob.MemGk[ag[i]]); Inc(lr);
                    end;
                    CopyTable(DBMain,db,tMEMO,ttNone,[cptNoTxtTo],nil,FldInList(fMGK,asgk));
                  except
                    SetStack(ost);
                    mess_ok(['Ошибка записи в папку:',s],'Ошибка копирования данных в отделения');
                  end;
                  SetConnected(db,false);
                end
                else mess_ok(['Отсутствует папка:',s],'Ошибка копирования данных в отделения');
              DcmForm;
              for i:=1 to 3 do begin
                s:=IntToStr(i)+',';
                if Summ.IsName(s_line,s) then begin
                  DcmForm(i); AddColHead('PH'); AddColFoot('PF');
                  with EdGenFr.GF do VarCurGF(PageName[Leaf],vgfCurPageName);
                  result:=SDPart(s,null,null,'PH','',VarArrayOf(['DH','PH']),'');
                  if not result then break;
                end;
              end;
              if result then DcmClose;
              if lMain then ProgPswd.SendUpd('UBUHLOAD',true);
            end;
            if not lMain then 
              if LockSuper(Assigned(Sender),'Загрузку определения данных по программе'+CRLF
              +'может выполнить только администратор программы.') then begin
                try
                  SetLength(agv,Length(ag)+Length(OrgDatNmf)); lr:=low(agv);
                  for i:=low(ag) to high(ag) do begin
                    agv[lr]:=ag[i]; Inc(lr);
                  end;
                  for od:=low(OrgDatNmf) to high(OrgDatNmf) do begin
                    agv[lr]:=OrgDatNmf[od]; Inc(lr);
                  end;
                  qb.PartSelect(tGLOB,agv);
                  CopyFrom(af,ag); lsm:=TMemGkList.Create(qb,qb,@af); SetLength(ares,length(ag));
                  k:=0;
                  for i:=low(ag) to high(ag) do begin
                    ares[k]:=lsm.GetValue(qb.Fields[i].AsInteger); inc(k);
                  end;
                  for i:=low(ag) to high(ag) do Glob[ag[i]]:=ares[i];
                  for od:=low(OrgDatNmf) to high(OrgDatNmf) do Glob[OrgDatNmf[od]]:=qb.FieldZN(OrgDatNmf[od]);
                  Glob.UpdateRec; LogWrite;
                finally
                  if Assigned(Sender) then UnLockSuper;
                end;
                if Assigned(Sender) then fl:=true;
              end;
            if fl then
              if Ask(['Внимание!','Для корректной работы программы','необходим её перезапуск.','',
                'Произвести перезапуск программы сейчас ?']) then ProgPswd.ReStart([K_Alt_F3]);
          end;
        end;
      end;
      FreeQuery; FreeQuery; SetConnected(DBBuh,false);
    end;
  end;
  SetLogVid;
  DelStack;
end;

procedure TMain.SetSuper;
const a: TArrBoolStr = ('Установить','Сбросить');
begin
	AddStack('TMain.SetSuper',Self);
  mnServ.KeyCaption[K_Alt_F2]:=a[lSuper]+' режим "Администратор программы"';
  DelStack;
end;

procedure TMain.WMCalc;
begin
	AddStack('TMain.WMCalc',Self);
  case msg.Operation of
    clcBegin: mnHelp.Pressed:=true;
    clcEnd: mnHelp.Pressed:=false;
  end;
  DelStack;
end;

procedure TMain.WMCngPriv;
var fl: boolean;
begin
	AddStack('TMain.WMCngPriv',Self);
  fl:=CanPriv('LMONO');
	if IsSQLBased then mnServ.KeyVisible[K_Alt_9]:=fl;
  mnServ.KeyVisible[K_Alt_4]:=fl;
  DelStack;
end;

procedure TMain.WMGetUpd;
begin
  AddStack('TMain.WMGetUpd',Self);
  inherited;
  if msg.nmMsg^=updCodeGet then lsIpClear;
  DelStack;
end;

procedure TMain.WMRebuild;
begin
  AddStack('TMain.WMRebuild',Self);
  if Message.Oper=rbBefore then brZaj.ColWidths[0]:=bmCheckSize.cX+2;
  DelStack;
end;

procedure TMain.ETnChange;
var mq: TMulQuery;
    s: string;
begin
	AddStack('TMain.ETnChange',Self);
  EKod.SetReadOnly(SYSDBA);
  EFldChange(Sender,OldVal,FromShow);
  mq:=ProgPswd.GetQuery;
  try
    mq.PartSelect(tCDR,'STATUS',fCDR+'='+QQs(ETn.VarValue)); s:=mq.IsRecordsAsString;
  finally
    ProgPswd.FreeQuery;
  end;
  SetETnStatus(StrToIntDef(Trim(s),byte(low(aCdrStat))));
  DelStack;
end;

procedure TMain.ExitETn;
	procedure brSet(br: TBrowl);
  begin
    AddStack('TMain.ETnExit.brSet',Self);
    br.FormHide(Self); TBrQuery(br.Qry).GlobKey:=DM.Rec[fCDR];
    DelStack;
  end;
var fl: boolean;
  ac,av: TArrStr;
  otn,ntn: string;
begin
  AddStack('TMain.ExitETn',Self);
  otn:=Cdr[fCDR]; ntn:=DM.Rec[fCDR];
  if otn<>ntn then begin
    SetLogVid(logvCurTn);
    if Cdr.Seek(Cdr.TblFldName(fCDR)+'='+QQs(ntn)) then begin
      with ProgPswd.QryLog do begin
        GetListArg(sC_LIST,ac); GetListArg(sV_LIST,av);
        av[AnsiIndexText(fUSERNAME,ac)]:=QQs(ntn);
        SetArrayList(sV_LIST,ArrStrToArrVar(av));
        SetPart; Prepare;
      end;
      ProgPswd.UpdateTable(tREGS,[fCDR],[QQs(ntn)],fREGS+'='+ProgPswd.SDateReg);
      EKod.VarValue:=IfThen(not SYSDBA,string(Cdr['ORGKOD']));
      for fl:=false to true do ProgGet(fl).OrdRead(not fl);
      lZajSelfNoisp:=false; lZajIspCalc:=false; ZajSetFlt;
      brSet(brMsgFrom);
      brSet(brMsgTo);
      brSet(brDoc);
      mnServ.KeyVisible[K_Alt_F6]:=SYSDBA;
      mnServ.KeyNoEval[K_Alt_F6]:=not SYSDBA;
      mnServ.KeyVisible[K_Alt_F7]:=StrToBoolean(Cdr['ADMZAJ']);
      CdrAdmZajSet;
      if empty(otn) then otn:='' else otn:='"'+Trim(CdrGet.Codes(otn,[cdgBufAll]))+'"->';
      LogWrite('',otn+'"'+Trim(CdrGet.Codes(ntn,[cdgBufAll]))+'"');
    end;
    SetLogVid;
  end;
  DelStack;
end;

procedure TMain.ETnExit(Sender: TObject);
begin
  ExitETn;
end;

// Клиент
procedure TMain.EKodChange(Sender: TObject; const OldVal: Variant; FromShow: Boolean);
var fl: boolean;
	f: TField;
begin
	AddStack('TMain.EKodChange',Self);
  dZajBeg:=Now;
  if LockBuhRead then
    try
      fl:=List.Seek(List.TblFldName(nmfbKOD)+'='+QQs(Cdr['ORGKOD']));
    finally
      UnlockMode('FBUH');
    end
  else begin
    fl:=false; List.NewRec;
  end;
  if ProgGet(false).Qry.FindField('CTN',f) then f.Visible:=fl;
  ChildFldReadAll(pnOrgDat);
  if not empty(ProgGet(false).Qry.Text) then
  	for fl:=false to true do ProgGet(fl).BrUpdate(not fl);
  ZajSetFlt;
  EFldChange(Sender,OldVal,FromShow);
  DelStack;
end;

procedure TMain.EFldChange(Sender: TObject; const OldVal: Variant; FromShow: Boolean);
begin
	AddStack('TMain.EFldChange',Self);
  TFldEdit(Sender).Read([ferdSvOld]+IfThen(FromShow,ferdFromShow));
  DelStack;
end;

// Обслуживание
procedure StProgCalc(Sender: TStat; const Params: array of variant; var Aborted: boolean);
var qb: TMulQuery;
	f,fb: TField;
  i,lr: longint;
begin
  AddStack('FMain.StProgCalc');
  qb:=ProgPswd.GetQuery;
  if LockBuhRead then try
    qb.PartSelect(tLIST,[],'',nmfbKO);
  finally
    UnlockMode('FBUH');
  end
  else Aborted:=true;
  if not Aborted then begin
    ListSave;
    try
      fb:=qb.FindField(nmfbKO);
      with ProgPswd.GetQuery do begin
        PartSelect(tPROG,[],'',fORG);
        f:=FindField(fORG);
        lr:=RecordCount;
        for i:=1 to lr do begin
          if Sender.SayStat(i/lr) then break;
          while not qb.Eof and (fb.AsInteger < f.AsInteger) do qb.Next;
          Prog.GetFromQuery;
          List.GetFromQuery(qb);
          if not DM.ProgCalc(false) then begin
            Aborted:=true; break;
          end;
          Next;
        end;
      end;
      ProgPswd.FreeQuery;
    finally
      ListRest;
    end;
  end;
  ProgPswd.FreeQuery;
  DelStack;
end;

procedure TMain.mnServProcKey(key: Integer; tw: TWinControl);
const cko = 2085;
var fl: boolean;
  i: longint;
  a: TDEPrmStr;
  {db: TComponent;
  ls: TStringList;
  q: TMulQuery;}
begin
	AddStack('TMain.mnServProcKey',Self);
  if LockRead then try
    case Key of
      // Режим "Администратор"
      K_Alt_F2: if Ask([mnServ.KeyCaption[Key]+' ?']) then begin
        if lSuper then begin
          UnLockSuper; fl:=true;
        end
        else begin
          fl:=LockSuper;
          {if fl then begin
            ls:=TStringList.Create;
            db:=ProgPswd.CreateDatabase(dbtpDriver,drvINTRBASE,'ORGFROM');
            try
              ls.Values[ibpServerName]:='M:\T\ORGLIST.FDB';
              ls.Values[ibpUserName]:='SYSDBA';
              TFormPswd.SetDBPrm(db,dbtpDriver,'',drvINTRBASE,'masterkey','','','','',ls);
              SetConnected(db,true);
              q:=ProgPswd.GetQuery(db);
              q.PartSelect(tMSG,[fProgNP,fRECNO],fORG+'='+Vtos(cko));
              while not q.Eof do begin
                Msg.UpdateTable([fORG,fProgNP],[cko,QQs(q.Fields[0])],RecnoWhere(q.Fields[1]));
                q.Next;
              end;
              q:=ProgPswd.GetQuery(db);
              q.PartSelect(tZAJ,[],fORG+'='+Vtos(cko));
              while not q.Eof do begin
                Zaj.NewRec;
                for i:=0 to q.FieldCount-1 do if q.FieldName(i)<>'NZ' then Zaj[q.FieldName(i)]:=q.Fields[i].Value;
                Zaj.AppRec; q.Next;
              end;
            finally
              SetConnected(db,false); db.Free; ls.Free;
            end;
          end;}
        end;
        if fl then begin
          NotD(lSuper); SetSuper; MainRebuild;
        end;
      end;
      // Загрузка из "Бухгалтерии"
      K_Alt_F3: FdpUser('Загрузка списка клиентов из "Бухгалтерии"',['BUH'],PrBuhLoad);
      // Приём/передача заявок
      K_Alt_F5: if GlobOTDNUM=0
        then FdpUser(deOtd.FrmCaption,['OTD'],CopyFromOtd,nil,[])
        else deOtd.Execute;
      // Выключить все компьютеры
      K_Alt_F6: if Ask(['Выключить все компьютеры ?']) then ProgPswd.SendUpd('UOFF',true);
      K_Alt_F7: if deDelDerLog.Execute.Saved then with ProgPswd.GetQuery do begin
        DeleteTable(tDER,'TIMECNG<'+Vtos(Double(Glob['DDELDER'])));
        DeleteTable(tLOG,'D<'+Vtos(Double(Glob['DDELLOG'])));
        ProgPswd.FreeQuery;
      end;
      // Дополнительные формулы
      K_Alt_F8: CreateShow(TDFrmLs,DFrmLs);
      K_ALT_D: ProgPswd.ViewDerTbl;
      // Проверка данных
      K_Alt_0: FdpUser('Протокол проверки данных',['PROV'],PrProv);
      // Настройка системных параметров
      K_Alt_1: begin
        SetLogVid(logvEditRec);
        if LockSuper then try
          fl:=ProgPswd.DBConnect(DBBuh,'BUH','');
          deSys.GetArrParam('VIDNO',i,a);
          a[deCaption]:='Вид аналитического учёта "Список клиентов"'
            +IfThen(not fl,UnDelim+'(ошибка подключения к данным "Бухгалтерии")');
          if fl then VanGet.AssignGet(a) else TSimpleGet.AssignGetClass(a);
          a[deNoReadOnly]:=bStr[fl];
          deSys.SetArrParam(i,a); deSys.Execute;
          SetConnected(DBBuh,false);
        finally
          UnLockSuper;
        end;
        SetLogVid;
      end;
      // Расчёт вычисл.данных
      K_Alt_2: if Ask(['Выполнить расчёт вычисляемых данных ?'])
      then ShowStat('Расчёт вычисляемых данных',StProgCalc);
      // Перезагрузка программы
      K_Alt_3: if Ask(['Перезагрузить программу ?']) then ProgPswd.Restart([0]);
      // Сортировка
      K_Alt_4: if Ask(['Выполнить сортировку данных ?']) then
        if LockSuper('Сортировка данных') then try
          mess_wait([' '],PrReindex,false);
        finally
          UnLockSuper;
        end;
      // Пользователи в сети
      K_Alt_5: LockExec('Пользователи в сети',ProgPswd);
      // Параметры рабочего места
      K_Alt_6: begin
        if (ProgPswd.PrmLocal([''],[''])) then begin
          UpdateInstructionsSheetState;
        end;
      end;
      // Параметры доступа к данным
      K_Alt_7: ProgPswd.PrmServer;
      // Упаковка данных
      K_Alt_8: if Ask(['Упаковать данные ?']) then ProgPswd.Pack;
      // Копирование данных на рабочее место
      K_Alt_9: ProgPswd.CopyDatFromServer;
    end;
  finally
    UnLockRead;
  end;
  DelStack;
end;

// Проверка данных
procedure PrDel(Rec: TRecDB; q: TMulQuery = nil);
begin
  AddStack('FMain.PrDel');
  Rec.DelRec(q.QryCur.qRecno);
  DelStack;
end;

procedure PrProc(result: TModalResult; const amsg: array of string;
  const av: array of variant; Proc: TProcProv1);
begin
  AddStack('FMain.PrProc');
  if result=mrYes then
    if Assigned(Proc) then Proc(av) else PrDel(PointerVar(av[0]));
  if FmtPrm(1)<>'' then begin
    DcmPart('ZGL'); FmtPrm(1,'');
  end;
  Inc(cntErr); FmtPrm(2,IntToStr(cntErr));
  FmtPrm(3,ArrayAsList(amsg,CRLF));
  FmtPrm(4,IfThen(result=mrYes,'+')); DcmPart('DAT');
  DelStack;
end;

procedure PrAsk(var result: TModalResult; const amsg: array of string;
  const av: array of variant; Proc: TProcProv1 = nil);
begin
  AddStack('FMain.PrAsk');
  result:=mrYes;
  if EdGenFr.RDocPrm['СООБЩ'] then result:=AskCancel(amsg);
  PrProc(result,amsg,av,Proc);
  DelStack;
end;

procedure PrMsr(var result: TModalResult; const a: array of string;
  const av: array of variant; Proc: TProcProv1 = nil);
var amsg: TArrStr;
begin
  AddStack('FMain.PrMsr');
  result:=mrYes;
  if EdGenFr.RDocPrm['СООБЩ'] then begin
  	CopyFrom(amsg,a); AddFrom(amsg,['','Продолжить ?']);
  	if not Ask(amsg) then result:=mrCancel;
  end;
  PrProc(result,a,av,Proc);
  DelStack;
end;

function PrEmp(const d: variant; const v: string = ''): string;
begin
  AddStack('FMain.PrEmp');
  result:=Trim(iif(empty(d),'отсутствует',iif(v='',d,v)));
  DelStack;
end;

procedure PrUpname(r: TRecDB; const st: string; const nmup: string = fUPNAME);
var s: string;
    mq: TMulQuery;
begin
  AddStack('FMain.PrUpname');
  mq:=ProgPswd.CurQuery;
  s:=RSpTrimUpper(st);
  if TrimSpRight(mq.FieldZn(nmup))<>s then r.UpdateTable([nmup],[QQs(s)],mq.qRecno);
  DelStack;
end;

procedure PrEmpEqual(var av: variant; var result: TModalResult);
var s: string;
  procedure Ask1(n: longint);
  var sc,sn: string;
  	l: longint;
  begin
    AddStack('FMain.PrEmpEqual.Ask1');
    l:=VarArrayHighBound(av,1);
    if l > 3 then sc:=av[4] else sc:='Номер';
    if l > 4 then sn:=av[5] else sn:='Наименование';
    PrAsk(result,[av[n],sc+': '+PrEmp(s),
      sn+': '+PrEmp(ProgPswd.CurQuery.FieldZN(fNAME)),'Удалить ?'],[av[1]]);
    DelStack;
  end;
begin
  AddStack('FMain.PrEmpEqual');
  s:=TrimRight(ProgPswd.CurQuery.Fields[0].AsString);
  if Empty(s) then Ask1(2)
  else if s=av[0] then Ask1(3)
  else av[0]:=s;
  DelStack;
end;

procedure PrEmpEqualUp(var av: variant; var result: TModalResult);
var mq: TMulQuery;
begin
  AddStack('FMain.PrEmpEqualUp');
  PrEmpEqual(av,result);
  if result=mrNo then begin
    mq:=ProgPswd.CurQuery;
    PrUpname(PointerVar(av[1]),TrimRight(mq.Fields[1].AsString),mq.Fields[2].FieldName);
  end;
  DelStack;
end;

procedure PrQDel(const av: array of variant);
var q: TMulQuery;
  i: byte;
  w,s: string;
  f: TField;
begin
  AddStack('FMain.PrQDel');
  q:=ProgPswd.CurQuery; w:='';
  with ProgPswd.GetQuery do begin
    for i:=0 to q.FieldCount-1 do begin
      f:=q.Fields[i]; s:=VarTos(f,[vsQQ,vsDateWithTime]);
      if s=sNULL then s:=sISNULL else IncL(s,'=');
      IncAnd(w,f.FieldName+s);
    end;
    DeleteTable(q.Arg[sTABLE],Copy(w,lAND1,MaxInt));
  end;
  ProgPswd.FreeQuery;
  DelStack;
end;

function PrQryNotFind(const av: variant; const cod: string): boolean;
var s: string;
begin
  AddStack('FMain.PrQryNotFind');
  s:=TrimRight(cod);
  with MulQueryVar(av[0]) do begin
    while not Eof and (TrimRight(Fields[0].AsString)<s) do Next;
    result := Eof or (TrimRight(Fields[0].AsString)>s);
  end;
  DelStack;
end;

// Spdb
procedure PrSpdb(var av: variant; var result: TModalResult);
var s: string;
    mq: TMulQuery;
begin
  AddStack('FMain.PrSpdb');
  mq:=ProgPswd.CurQuery; s:=TrimRight(mq.Fields[0].AsString);
  if s=av[0] then PrDel(Spdb)
  else begin
    av[0]:=s; PrUpname(Spdb,TrimRight(mq.Fields[1].AsString),fUPNAME);
  end;
  DelStack;
end;

procedure PrAcc(var av: variant; var result: TModalResult);
var srv: string;
begin
  AddStack('FMain.PrAcc');
  PrEmpEqualUp(av,result);
  if result=mrNo then with ProgPswd.CurQuery do begin
    srv:=Fields[3].AsString;
    if not DM.SrvGet.IsCod(srv,[cdgBufAll,cdgNoTrans])
    then PrAsk(result,['Обнаружена учётная запись интернета с сервером,',
      'который отсутствует в списке серверов.',
      'Номер: '+PrEmp(Trim(Fields[0].AsString)),
      'Наименование: '+PrEmp(Trim(Fields[1].AsString)),
      'Сервер: '+PrEmp(srv),'Удалить ?'],[av[1]]);
  end;
  DelStack;
end;

// Cngv
procedure PrCngvProgId(const av: array of variant);
begin
	AddStack('FMain.PrCngvProgId');
  Cngv.UpdateTable([fMDP],[aProgId[0]],ProgPswd.CurQuery.qRecno);
  DelStack;
end;

procedure PrCngv(var av: variant; var result: TModalResult);
var id: longint;
begin
  AddStack('FMain.PrCngv');
  PrEmpEqual(av,result);
  if result=mrNo then with ProgPswd.CurQuery do if Fields[2].AsInteger=byte(tpvModel) then begin
    id:=Fields[3].AsInteger;
    if not ArrIntMatch(id,aProgId)
    then PrAsk(result,[BracketInt('Обнаружено изменение с некорректным видом программы',id),
      'Номер: '+PrEmp(Trim(Fields[0].AsString)),
      'Наименование: '+PrEmp(Trim(Fields[1].AsString)),
      'Установить вид по умолчанию ('+ProgIdName[0]+') ?'],[0],PrCngvProgId);
  end;
  DelStack;
end;

// Cng
procedure PrCng(var av: variant; var result: TModalResult);
var kc,tn: string;
	procedure Ask1(const amsg: array of string);
	var ams: TArrStr;
  begin
    AddStack('FMain.PrCng.Ask1');
		CopyFrom(ams,amsg);
    AddFrom(ams,['Номер изменения: '+PrEmp(kc),
      'Пользователь: '+PrEmp(tn,CdrGet.Codest(tn)),'Удалить ?']);
    PrAsk(result,ams,[kc,tn],PrQDel);
    DelStack;
  end;
begin
  AddStack('FMain.PrCng');
  with ProgPswd.CurQuery do begin
    kc:=Fields[0].AsString; tn:=Fields[1].AsString;
    if Empty(kc) or Empty(tn)
      then Ask1(['Обнаружено некорректное слежение за изменениями.'])
    else if PrQryNotFind(av,kc)
      then Ask1(['Обнаружено слежение за изменением,','которое отсутствует в списке изменений.'])
    else if not CdrGet.IsCod(tn,[cdgBufAll,cdgNoTrans])
      then Ask1(['Обнаружено слежение за изменениями по пользователю,','который отсутствует в списке пользователей.'])
  end;
  DelStack;
end;

// MDP
procedure PrMDP(var av: variant; var result: TModalResult);
var id: longint;
  sid,path: string;
  procedure Ask1(const msg: string);
  begin
    AddStack('FMain.PrMDP.Ask1');
    PrAsk(result,[msg,'Вид программы: '+sid,'Папка: '+PrEmp(path),
      'Сокращание: '+PrEmp(TrimRight(ProgPswd.CurQuery.Fields[2].AsString)),'Удалить ?'],
      [LongInt(MDP)]);
    DelStack;
  end;
var i: longint;
  lid: boolean;
begin
  AddStack('FMain.PrMDP');
  with ProgPswd.CurQuery do begin
    id:=Fields[0].AsInteger; path:=TrimRight(Fields[1].AsString); lid:=ArrIntFind(id,aProgId,i);
    if lid then sid:=ProgIdName[i] else sid:=IntToStr(id);
    if not lid or (path='')
      then Ask1('Обнаружено некорректный вид основ.')
    else if (id=av[0]) and (path=av[1])
      then Ask1('Обнаружено несколько совпадающих видов основ.')
    else begin
      av[0]:=id; av[1]:=path;
    end;
  end;
  DelStack;
end;

// MDF
procedure PrMDF(var av: variant; var result: TModalResult);
var kc,path,fn: string;
  procedure Ask1(const amsg: array of string);
	var ams: TArrStr;
  begin
    AddStack('FMain.PrMDF.Ask1');
		CopyFrom(ams,amsg);
    AddFrom(ams,['Номер изменения: '+PrEmp(kc),'Папка: '+PrEmp(path),'Файл: '+PrEmp(fn),'Удалить ?']);
    PrAsk(result,ams,[LongInt(MDF)]);
    DelStack;
  end;
begin
  AddStack('FMain.PrMDF');
  with ProgPswd.CurQuery do begin
    kc:=TrimRight(Fields[0].AsString); path:=TrimRight(Fields[1].AsString); fn:=TrimRight(Fields[2].AsString);
    if (kc='') or (path='') or (fn='')
      then Ask1(['Обнаружен некорректный файл основ.'])
    else if PrQryNotFind(av,kc)
      then Ask1(['Обнаружен файл основ по изменению,','которое отсутствует в списке изменений.'])
    else if (kc=av[1]) and (path=av[2]) and (fn=av[3])
      then Ask1(['Обнаружено несколько совпадающих файлов основ.'])
    else begin
      av[1]:=kc; av[2]:=path; av[3]:=fn;
    end;
  end;
  DelStack;
end;

// MDV
procedure PrMDV(var av: variant; var result: TModalResult);
var kc,path,fn: string;
  v: longint;
  procedure Ask1(const amsg: array of string);
	var ams: TArrStr;
  begin
    AddStack('FMain.PrMDV.Ask1');
		CopyFrom(ams,amsg);
    AddFrom(ams,['Номер изменения: '+PrEmp(kc),'Папка: '+PrEmp(path),'Файл: '+PrEmp(fn),StrNum('Версия: ',v),'Удалить ?']);
    PrAsk(result,ams,[LongInt(MDV)]);
    DelStack;
  end;
begin
  AddStack('FMain.PrMDV');
  with ProgPswd.CurQuery do begin
    kc:=TrimRight(Fields[1].AsString); path:=TrimRight(Fields[2].AsString); fn:=TrimRight(Fields[3].AsString);
    v:=Fields[4].AsInteger;
    if (kc='') or (path='') or (fn='')
      then Ask1(['Обнаружена некорректная версия основ.'])
    else if PrQryNotFind(av,Fields[0].AsString)
      then Ask1(['Обнаружена версия основ по файлу,','который отсутствует в списке файлов основ.'])
    else if (kc=av[1]) and (path=av[2]) and (fn=av[3]) and (v=av[4])
      then Ask1(['Обнаружено несколько совпадающих версий основ.'])
    else begin
      av[1]:=kc; av[2]:=path; av[3]:=fn; av[4]:=v;
    end;
  end;
  DelStack;
end;

// MDT
procedure PrMDT(var av: variant; var result: TModalResult);
var kc,path,fn,nm: string;
  v: longint;
  procedure Ask1(const amsg: array of string);
	var ams: TArrStr;
  begin
    AddStack('FMain.PrMDT.Ask1');
		CopyFrom(ams,amsg);
    AddFrom(ams,['Номер изменения: '+PrEmp(kc),'Папка: '+PrEmp(path),'Файл: '+PrEmp(fn),StrNum('Версия: ',v),
      'Тема: '+PrEmp(nm),'Удалить ?']);
    PrAsk(result,ams,[LongInt(MDT)]);
    DelStack;
  end;
begin
  AddStack('FMain.PrMDT');
  with ProgPswd.CurQuery do begin
    kc:=TrimRight(Fields[1].AsString); path:=TrimRight(Fields[2].AsString); fn:=TrimRight(Fields[3].AsString);
    v:=Fields[4].AsInteger; nm:=TrimRight(Fields[5].AsString);
    if (kc='') or (path='') or (fn='')
      then Ask1(['Обнаружена некорректная тема основ.'])
    else if PrQryNotFind(av,Fields[0].AsString)
      then Ask1(['Обнаружена тема основ по версии,','которая отсутствует в списке версий основ.'])
    else if (kc=av[1]) and (path=av[2]) and (fn=av[3]) and (v=av[4]) and (nm=av[5])
      then Ask1(['Обнаружено несколько совпадающих тем основ.'])
    else begin
      av[1]:=kc; av[2]:=path; av[3]:=fn; av[4]:=v; av[5]:=nm;
    end;
  end;
  DelStack;
end;

// Dcmbmp
procedure PrDcmbmp(var av: variant; var result: TModalResult);
var partini,cod: string;
  procedure Ask1(const msg: string);
  begin
    AddStack('FMain.PrDcmbmp.Ask1');
    PrAsk(result,[msg,'Имя файла документа: '+PrEmp(partini),'Код рисунка: '+PrEmp(cod),'Удалить ?'],
      [LongInt(DBBmp)]);
    DelStack;
  end;
begin
  AddStack('FMain.PrDcmbmp');
  with ProgPswd.CurQuery do begin
    partini:=TrimRight(Fields[0].AsString); cod:=TrimRight(Fields[1].AsString);
    if (partini='') or (cod='')
      then Ask1('Обнаружено некорректное переопределение рисунка.')
    else if (partini=av[0]) and (cod=av[1])
      then Ask1('Обнаружено несколько переопределений рисунков с совпадающим кодом.')
    else begin
      av[0]:=partini; av[1]:=cod;
    end;
  end;
  DelStack;
end;

// Doc
procedure PrDocTnEmp(const av: array of variant);
begin
	AddStack('FMain.PrDocTnEmp');
  Doc.UpdateTable([fCDR],[QQs],ProgPswd.CurQuery.qRecno);
  DelStack;
end;

procedure PrDoc(var av: variant; var result: TModalResult);
var mq: TMulQuery;
begin
	AddStack('FMain.PrDoc');
  PrEmpEqual(av,result); mq:=ProgPswd.CurQuery;
  if result=mrNo then if not empty(mq.Fields[2].AsString) then if not CdrGet.IsCod(mq.Fields[2].AsString,[cdgBufAll,cdgNoTrans])
    then PrAsk(result,['Обнаружен документ, созданный пользователем,',
      'который отсутствует в списке пользователей.',
      'Номер: '+PrEmp(Trim(mq.Fields[0].AsString)),
      'Наименование: '+PrEmp(Trim(mq.Fields[1].AsString)),
      'Номер пользователя: '+PrEmp(Trim(mq.Fields[2].AsString)),
      'Открыть доступ к документу всем пользователям ?'],[0],PrDocTnEmp);
  DelStack;
end;

// Docprm
procedure PrDocprm(var av: variant; var result: TModalResult);
var fdtg,username: string;
  procedure Ask1(const msg: array of string);
  var amsg: TArrStr;
    a: TArrFldVal;
  begin
    AddStack('FMain.PrDocprm.Ask1');
    CopyFrom(amsg,msg); AddFrom(amsg,'Тип: '+PrEmp(fdtg));
    if username<>'' then AddFrom(amsg,'Пользователь: '+username);
    AddFrom(amsg,'Удалить ?'); EdGenFr.RDocPrm.GetAFieldValue(a);
    PrAsk(result,amsg,[LongInt(EdGenFr.RDocPrm)]); EdGenFr.RDocPrm.SetAFieldValue(a);
    DelStack;
  end;
begin
  AddStack('FMain.PrDocprm');
  with ProgPswd.CurQuery do begin
    fdtg:=TrimRight(Fields[0].AsString); username:=TrimRight(Fields[1].AsString);
  end;
  if Empty(fdtg)
    then Ask1(['Обнаружены некорректные данные по документу.'])
  else if (fdtg=av[0]) and (username=av[1])
    then Ask1(['Обнаружено несколько данных по документу','с совпадающим типом документа.'])
  else if (username<>'') and not CdrGet.IsCod(username,[cdgBufAll,cdgNoTrans])
    then Ask1(['Обнаружены данные по документу для пользователя,','который отсутствует в списке пользователей'])
  else begin
    av[0]:=fdtg; av[1]:=username;
  end;
  DelStack;
end;

// Drv
procedure PrDrv(var av: variant; var result: TModalResult);
var mq: TMulQuery;
    s,t: string;
begin
  AddStack('FMain.PrDrv');
  PrEmpEqualUp(av,result);
  if (result=mrNo) then begin
    mq:=ProgPswd.CurQuery;
    s:=mq.Fields[0].AsString;
    t:=mq.Fields[1].AsString;
  	if (empty(t)) then begin
      PrAsk(result,['Обнаружен сетевой диск с пустым наименованием.','Имя диска: '+s,'Удалить ?'],[LongInt(Drv)]);
    end else begin
      if (IsNetDrive(t)) then begin
        if empty(mq.Fields[3].AsString) then begin
          PrAsk(result,['Обнаружен сетевой диск с пустым локальным именем.',
            'Имя диска: '+s,'Наименование: '+TrimRight(t),'Удалить ?'],[LongInt(Drv)])
        end else begin
          if (not CheckIP(mq.Fields[4].AsString)) then
            PrAsk(result,['Обнаружен сетевой диск с пустым IP-адресом.',
              'Имя диска: '+s,'Наименование: '+TrimRight(t),'Удалить ?'],[LongInt(Drv)]);
        end;
      end;
    end;
  end;
  DelStack;
end;

// Flt
procedure PrFlt(var av: variant; var result: TModalResult);
var gk,npp: longint;
begin
  AddStack('FMain.PrFlt');
  with ProgPswd.CurQuery do begin
    gk:=Fields[0].AsInteger;
    if not(InRange(gk,0,high(ProgInfs)) or InRange(gk,fltgkLow,fltgkHigh)) then begin
      PrAsk(result,['Обнаружен шаблон с некорректным видом.',StrNum('Вид: ',gk),
        'Наименование: '+PrEmp(Fields[2].AsString),'Удалить ?'],[LongInt(Flt)]);
    end
    else begin
      npp:=Fields[1].AsInteger;
      if gk<>av[0] then begin
        av[1]:=-MaxInt; av[2]:=-MaxInt;
      end;
      if (gk=av[0]) and (npp=av[1]) or (av[2]<>-MaxInt) then begin
        if av[2]=-MaxInt then av[2]:=npp;
        IncD(av,2,variant(1)); npp:=av[2];
        Flt.UpdateTable(['NPP'],[npp],qRecno);
      end;
      av[0]:=gk; av[1]:=npp;
    end;
  end;
  DelStack;
end;

// Msg
procedure PrMsg(var av: variant; var result: TModalResult);
var	d,tnFrom,tnTo: string;
	procedure Ask1(const amsg: array of string);
	var ams: TArrStr;
  begin
    AddStack('FMain.PrMsg.Ask1');
		CopyFrom(ams,amsg);
    AddFrom(ams,['Дата: '+PrEmp(d),
      'Отправитель: '+PrEmp(tnFrom,CdrGet.Codest(tnFrom)),
      'Получатель: '+PrEmp(tnTo,CdrGet.Codest(tnTo)),'Удалить ?']);
    PrAsk(result,ams,[LongInt(Msg)]);
    DelStack;
  end;
var mq: TMulQuery;
begin
	AddStack('FMain.PrMsg');
  mq:=ProgPswd.CurQuery;
  d:=StringToDispDate(mq.Fields[0].AsString);
  tnFrom:=mq.Fields[3].AsString;
  tnTo:=mq.Fields[4].AsString;
  if (StrToBoolean(mq.Fields[1]))and(StrToBoolean(mq.Fields[2])) then begin
    Ask1(['Обнаружено сообщение, удалённое отправителем и получателем.']);
  end else begin
    if (not CdrGet.IsCod(tnFrom,[cdgBufAll,cdgNoTrans])) then begin
      Ask1(['Обнаружено сообщение, отправленное пользователем,','который отсутствует в списке пользователей.']);
    end else begin
      if (not CdrGet.IsCod(tnTo,[cdgBufAll,cdgNoTrans])) then begin
        Ask1(['Обнаружено сообщение, полученное пользователем,','который отсутствует в списке пользователей.']);
      end;
    end;
  end;
  DelStack;
end;

procedure PrMsgs(var av: variant; var result: TModalResult);
var ams: array[1..Length(aMsgsFld)+2] of string;
  n: TMsgsFldList;
  d: TDateTime;
  f: TField;
  i: byte;
begin
  AddStack('FMain.PrMsgs');
  i:=0;
  Inc(i); ams[i]:='Обнаружено сообщение для несуществующей регистрации.';
  for n:=low(aMsgsFld) to high(aMsgsFld) do with aMsgsFld[n] do begin
    f:=ProgPswd.CurQuery.Fields[n];
    Inc(i); ams[i]:=FRup(GetPrimFld(tMSGS,nmf))+': ';
    if NoDate then IncD(ams[i],PrEmp(f.Value))
    else begin
      if DBDrvCan('DateTime') then
        if empty(f.Value) then d:=DateEmpty else d:=f.AsDateTime
      else d:=StrToDateTimeDef(f.AsString,DateEmpty);
      IncD(ams[i],PrEmp(d,OurFormatDateTime('dd/mm/yyyy (hh:nn:ss)',d)));
    end;
  end;
  Inc(i); ams[i]:='Удалить ?';
  PrAsk(result,ams,[tMSGS],PrQDel);
  DelStack;
end;

// Ofis
procedure PrOfis(var av: variant; var result: TModalResult);
var	d,tn: string;
	status: TCdrStatList;
	procedure Ask1(const amsg: array of string);
	var ams: TArrStr;
  begin
    AddStack('FMain.PrMsg.Ask1');
		CopyFrom(ams,amsg);
  	AddFrom(ams,['Пользователь: '+PrEmp(tn,CdrGet.Codest(tn)),'Дата: '+PrEmp(d),
     	'Статус: '+aCdrStat[status],'Удалить ?']);
    PrAsk(result,ams,[LongInt(Ofis)]);
    DelStack;
  end;
var mq: TMulQuery;
begin
	AddStack('FMain.PrOfis');
  mq:=ProgPswd.CurQuery;
  tn:=mq.Fields[0].AsString;
  d:=StringToDispDate(mq.Fields[1].AsString);
  status:=CdrStatList(mq.Fields[2].AsInteger);
  if (empty(tn))or(empty(d))
    then Ask1(['Обнаружено некорректное изменение статуса пользователя.'])
  else if not CdrGet.IsCod(tn,[cdgBufAll,cdgNoTrans])
    then Ask1(['Обнаружено изменение статуса пользователя,','который отсутствует в списке пользователей.']);
  DelStack;
end;

// UsPrm
procedure PrUsPrm(var av: variant; var result: TModalResult);
var us,nm: string;
  procedure Ask1(const msg: array of string);
  var amsg: TArrStr;
  begin
    AddStack('FMain.PrUsPrm.Ask1');
    CopyFrom(amsg,msg);
    AddFrom(amsg,['Пользователь: '+PrEmp(us),'Наименование: '+PrEmp(nm),'Удалить ?']);
    PrAsk(result,amsg,[Longint(ProgPswd.RUsPrm)]);
    DelStack;
  end;
begin
  AddStack('FMain.PrUsPrm');
  with ProgPswd.CurQuery do begin
    us:=TrimRight(Fields[0].AsString); nm:=TrimRight(Fields[1].AsString);
  end;
  if empty(us) or empty(nm)
    then Ask1(['Обнаружены некорректные параметры пользователей.'])
  else if not CdrGet.IsCod(us,[cdgBufAll,cdgNoTrans]) and PrQryNotFind(av,us)
    then Ask1(['Обнаружены параметры у пользователя,','который отсутствует в списке пользователей.'])
  else if (us=av[1]) and (nm=av[2])
    then Ask1(['Обнаружено несколько параметров пользователя с совпадающим наименованием.'])
  else begin
    av[1]:=us; av[2]:=nm;
  end;
  DelStack;
end;

// Prog
procedure ProgArr(var ams: TArrStr; const amsg: array of string; oProg: TObject;
	const tn,nd,dir,cp: string; ko: longint; stat: TProgStatList);
var kod: string;
begin
  AddStack('FMain.ProgArr');
  CopyFrom(ams,amsg); kod:=ListKod(ko);
  if not(empty(kod) or empty(ko))
  then AddFrom(ams,['Клиент: '+Trim(DM.ListGet.Codest(kod)),
  	'Рег.N: '+PrEmp(cp),
    'Статус: '+aProgStat[stvName,stat]]);
  AddFrom(ams,['Программа: '+PrEmp(ProgInf(oProg).Name),
    'Ответственный: '+PrEmp(tn,Trim(CdrGet.Codest(tn))),
    'Сетевой диск: '+PrEmp(nd,Trim(DM.DrvGet.CodeName(nd,[cdgBufAll]))),
    'Папка: '+PrEmp(dir)]);
  DelStack;
end;

procedure PrProgCp(const av: array of variant);
begin
  AddStack('FMain.PrProgCp');
  Prog.UpdateTable([fProgCP],[QQs(av[1])],ProgPswd.CurQuery.qRecno);
  DelStack;
end;

procedure PrProg(var av: variant; var result: TModalResult);
var ams: TArrStr;
    tn,nd,cp,cpNew: string;
    ko: longint;
    stat: TProgStatList;
  procedure Ask1(const amsg: array of string; const msgask: string = 'Удалить ?';
    Proc: TProcProv1 = nil; lProc: boolean = true);
  begin
    AddStack('FMain.PrProg.Ask1');
    ProgArr(ams,amsg,ProgPswd.CurQuery,tn,nd,TrimRight(ProgPswd.CurQuery.Fields[4].AsString),cp,ko,stat);
    AddFrom(ams,msgask);
    if lProc then PrAsk(result,ams,[LongInt(Prog),cpNew],Proc);
    DelStack;
  end;
var ams1: TArrStr;
    pa: PArrStr;
    prgnm,kod: string;
    kr,kt,acid: longint;
    mq: TMulQuery;
    pi: TProgInf;
    checkNd: boolean;
begin
  AddStack('FMain.PrProg');
  pa:=PointerVar(av[2]);
  mq:=ProgPswd.CurQuery;
  ko:=mq.Fields[0].AsInteger;
  pi:=ProgInf(mq);
  prgnm:=pi.Name;
  checkNd := not(PIFLAG_NOFILE in pi.piFlags);
  tn:=mq.Fields[2].AsString;
  nd:=mq.Fields[3].AsString;
  kod:=ListKod(ko);
  cp:=mq.Fields[5].AsString;
  stat:=ProgStatList(mq.Fields[6].AsInteger);
  kr:=mq.Fields[7].AsInteger;
  kt:=mq.Fields[8].AsInteger;
  acid:=mq.Fields[9].AsInteger;
  if (empty(prgnm))or(empty(tn))or(checkNd and empty(nd)) then begin
    CopyFrom(ams1,'Обнаружена некорректная программа.');
    if empty(ko) then AddFrom(ams1,'Клиент: '+PrEmp(ko));
    Ask1(ams1);
  end else
    if not empty(cp) and (stat=stpTemp) then begin
      cpNew:='';
      Ask1(['Обнаружена программа со статусом "временный"','с непустым регистрационным номером.'],
        'Обнулить регистрационный номер ?',PrProgCp);
    end else
      if empty(cp) and (stat<>stpTemp) then begin
        cpNew:=Prog.KodNext(fProgCP,fORG+'='+Vtos(ko));
        Ask1(['Обнаружена программа со статусом не равным "временный"','с пустым регистрационным номером.'],
          'Изменить регистрационный номер на '+Trim(cpNew)+' ?',PrProgCp);
      end else
        if empty(kod) and not empty(ko) then begin
          Org.Seek(Org.TblFldName(fORG)+'='+Vtos(ko));
          Ask1(['Обнаружена программа у клиента,','который отсутствует в списке клиентов.',
            'Номер клиента: '+PrEmp(Org['KOD'])]);
        end
        else if not CdrGet.IsCod(tn,[cdgBufAll,cdgNoTrans])
          then Ask1(['Обнаружена программа,','ответственный по которой отсутствует в списке пользователей.'])
        else if (checkNd)and(not DM.DrvGet.IsCod(nd,[cdgBufAll,cdgNoTrans]))
          then Ask1(['Обнаружена программа на сетевом диске,','который отсутствует в списке сетевых дисков.'])
        else if not DM.RgnGet.IsCod(IntToStr(kr),[cdgBufAll])
          then Ask1(['Обнаружена программа по региону,','который отсутствует в списке регионов.','Регион: '+PrEmp(IntToStr(kr))])
        else if not(empty(kt) or DM.TerrGet.IsCod(IntToStr(kt),[cdgBufAll]))
          then Ask1(['Обнаружена программа по территории,','которая отсутствует в списке территорий.','Территория: '+PrEmp(IntToStr(kt))])
        else if not(empty(acid) or DM.AccGet.IsCod(IntToStr(acid),[cdgBufAll]))
          then Ask1(['Обнаружена программа с учётной записью интернета,','которая отсутствует в списке учётных записей интернета.','Учётная запись интернета: '+PrEmp(IntToStr(acid))])
        else if (ko=av[0]) and (cp=av[1]) and (stat<>stpTemp) and not empty(cp) then begin
          if not Zaj.Seek(Zaj.TblFldName(fORG)+'='+Vtos(ko)
            +sAND+Zaj.TblFldName(fProgCP)+'='+QQs(cp)) then pa^:=nil;
          Ask1(['Обнаружено несколько программ с совпадающим номером у одного клиента.'],
            ArrayAsList(pa^,CRLF,NegDef,true)+'Удалить ?');
        end;
  if result=mrNo then begin
    Ask1(['','При удалении данной программы','заявки по ней будут отнесены к программе:',''],
      '',nil,false);
    if stat<>stpTemp then begin
      av[0]:=ko; av[1]:=cp; CopyFrom(pa^,ams);
    end;
  end;
  DelStack;
end;

// Zaj
procedure PrZajNZ(const av: array of variant);
begin
	AddStack('FMain.PrZajNZ');
  Zaj.UpdateTable(['NZ'],[av[1]],ProgPswd.CurQuery.qRecno);
  DelStack;
end;

procedure PrZaj(var av: variant; var result: TModalResult);
var nz,nznew,ko: longint;
	tn,isptn,wtn,cp,d,ispd,wd: string;
  procedure Ask1(const amsg: array of string; const send: string = ''; Proc: TProcProv1 = nil);
	var ams,ams1: TArrStr;
  	kod: string;
  begin
		AddStack('FMain.PrZaj.Ask1');
    CopyFrom(ams,amsg);
    AddFrom(ams,'Номер заявки: '+PrEmp(nz,IntToStr(nz)));
    if empty(d) and empty(ispd)
    then AddFrom(ams,['Дата поступления: '+PrEmp(d),'Дата исполнения: '+PrEmp(ispd)]);
  	if not empty(d) then AddFrom(ams,['Поступила: '+d,
    	'Принял: '+PrEmp(tn,Trim(CdrGet.Codest(tn)))]);
  	if not empty(wd) then AddFrom(ams,['Предполагаемое исполнение: '+wd,
    	'Предполагаемый исполнитель: '+PrEmp(wtn,Trim(CdrGet.Codest(wtn)))]);
  	if not empty(ispd) then AddFrom(ams,['Исполнена: '+ispd,
    	'Исполнитель: '+PrEmp(isptn,Trim(CdrGet.Codest(isptn)))]);
    if empty(ko) or empty(cp) then AddFrom(ams,'Программа: '+PrEmp(0))
    else if Prog.Seek(Prog.TblFldName(fORG)+'='+Vtos(ko)+sAND+Prog.TblFldName(fProgCP)+'='+QQs(cp)) then begin
      CopyFrom(ams1,ams);
      ProgArr(ams,ams1,Prog,Prog[fCDR],Prog[fDRV],Prog['DIR'],Prog[fProgCP],Prog[fORG],Prog['STATUS']);
    end
    else begin
      kod:=ListKod(ko);
      if not empty(kod) and not empty(ko)
		  then AddFrom(ams,'Клиент: '+Trim(DM.ListGet.Codest(kod)));
    	AddFrom(ams,'Программа: не найдена');
    end;
    AddFrom(ams,IfThen(send='','Удалить ?',send)); PrAsk(result,ams,[LongInt(Zaj),nznew],Proc);
    DelStack;
  end;
var pnz: longint;
    mq: TMulQuery;
begin
	AddStack('FMain.PrZaj');
  nznew:=0;
  mq:=ProgPswd.CurQuery;
  nz:=mq.Fields[0].AsInteger;
  ko:=mq.Fields[1].AsInteger;
  tn:=mq.Fields[2].AsString;
  ispd:=StringToDispDate(mq.Fields[3].AsString);
  isptn:=mq.Fields[4].AsString;
  d:=StringToDispDate(mq.Fields[5].AsString);
  wd:=StringToDispDate(mq.Fields[6].AsString);
  wtn:=mq.Fields[7].AsString;
  cp:=mq.Fields[8].AsString;
  if (av[0]) then begin
    mq:=PointerVar(av[1]);
    while not mq.Eof and (mq.Fields[0].AsInteger<ko) do mq.Next;
    while not mq.Eof and (mq.Fields[0].AsInteger=ko) and (mq.Fields[1].AsString<cp) do mq.Next;
    if (mq.Eof)or(mq.Fields[0].AsInteger<>ko)or(mq.Fields[1].AsString<>cp) then begin
      Ask1(['Обнаружена заявка по программе,','отсутствующей в списке программ.']);
    end;
  end else begin
    if empty(ko) or empty(cp) or (empty(d) and empty(ispd))
      then Ask1(['Обнаружена некорректная заявка.'])
    else if (nz=av[1]) or empty(nz) then begin
    	nznew:=Zaj.GetMaxFld('NZ','',@pnz);
      Ask1([IfThen(empty(nz),'Обнаружена заявка с пустым номером.',
        'Обнаружено несколько заявок с совпадающим номером.')],
        Format('Изменить номер на %d ?',[nznew]),PrZajNZ);
      if result<>mrYes then Zaj.GetMaxFld('NZ','',@pnz,true);
    end
    else if not empty(tn) and not CdrGet.IsCod(tn,[cdgBufAll,cdgNoTrans])
      then Ask1(['Обнаружена заявка, принятая пользователем,','отсутствующим в списке пользователей'])
    else if not empty(wtn) and not CdrGet.IsCod(wtn,[cdgBufAll,cdgNoTrans])
      then Ask1(['Обнаружена заявка с предполагаемым исполнителем,','отсутствующим в списке пользователей'])
    else if not empty(isptn) and not CdrGet.IsCod(isptn,[cdgBufAll,cdgNoTrans])
      then Ask1(['Обнаружена заявка, исполненная пользователем,','отсутствующим в списке пользователей']);
    if result=mrNo then av[1]:=nz;
  end;
  DelStack;
end;

procedure StProvRecno(Sender: TStat; const Params: array of variant; var Aborted: boolean);
var i,lr: longint;
begin
	AddStack('FMain.StProvRecno');
  lr:=Params[1];
  with ProgPswd.CurQuery do for i:=1 to lr do begin
    if Sender.SayStat(i/lr) then break;
    if Fields[1].AsInteger>1 then AddFrom(ArrStrVar(Params[0])^,Vtos(Fields[0]));
    Next;
  end;
  DelStack;
end;

procedure PrSetRecno(const av: array of variant);
var r,nfr,j,i: longint;
  q: TMulQuery;
  table: string;
  clist,vlist: PArrVar;
  ar: PArrInt;
begin
  AddStack('FMain.PrSetRecno');
  q:=PointerVar(av[0]); table:=av[1];
  clist:=PointerVar(av[2]); vlist:=PointerVar(av[3]); nfr:=av[5]; ar:=PointerVar(av[6]);
  with ProgPswd.CurQuery do begin
    GotoBookMark(PointerVar(av[4]));
    r:=Fields[nfr].AsInteger; q.DeleteTable(table,RecnoWhere(r)); i:=0;
    while not Eof and (Fields[nfr].AsInteger=r) do begin
      for j:=low(vlist^) to high(vlist^) do
        if j=nfr then vlist^[j]:=ar^[i] else vlist^[j]:=q.VarToS(Fields[j],vsQQ);
      q.InsertTable(table,clist^,vlist^); Next; Inc(i);
    end;
  end;
  DelStack;
end;

function CorrRecno(const where: string; q1: TMulQuery): boolean;
var j,nfr,r: longint;
  ar: TArrInt;
  table,olist: string;
  clist,vlist: TArrVar;
  mr: TModalResult;
  bm: TBookMark;
begin
  AddStack('FMain.CorrRecno');
  with ProgPswd.CurQuery do begin
    result:=false; table:=Arg[sTABLE]; PartSelect('',[],where,fRECNO);
    SetLength(clist,FieldCount); SetLength(vlist,FieldCount); nfr:=0;
    for j:=low(clist) to high(clist) do begin
      clist[j]:=Fields[j].FieldName;
      if AnsiUpperCase(clist[j])=fRECNO then nfr:=j;
    end;
    while not Eof do begin
      r:=Fields[nfr].AsInteger; olist:=''; j:=0; bm:=GetBookMark;
      try
        while not Eof and (Fields[nfr].AsInteger=r) do begin
          SetLength(ar,j+1);
          if j=0 then ar[j]:=r else ar[j]:=q1.GetMaxFld(fRECNO,table);
          olist:=StrNum(olist+',',ar[j]); Next; Inc(j);
        end;
        PrMsr(mr,['Таблица '+table+': совпадение номеров записей.',
          Format('Записям с номером %d присваиваются номера:',[r]),Copy(olist,2,MaxInt)+'.'],
          [LongInt(q1),table,LongInt(@clist),LongInt(@vlist),LongInt(bm),
          nfr,LongInt(@ar)],PrSetRecno);
      finally
        FreeBookMark(bm);
      end;
      if mr=mrCancel then begin
        result:=true; break;
      end;
    end;
  end;
  DelStack;
end;

procedure StCorrRecno(Sender: TStat; const Params: array of variant; var Aborted: boolean);
var j1,lr: longint;
  q1: TMulQuery;
  a1: PArrStr;
begin
	AddStack('FMain.StCorrRecno');
  q1:=PointerVar(Params[0]); a1:=PointerVar(Params[1]); lr:=Length(a1^);
  for j1:=1 to lr do begin
    if Sender.SayStat(j1/lr) then break;
    if CorrRecno(a1^[j1-1],q1) then begin
      Aborted:=true; break;
    end;
  end;
  DelStack;
end;

procedure StProv1(Sender: TStat; const Params: array of variant; var Aborted: boolean);
var p: TProcProv;
  i,lr: longint;
  mr: TModalResult;
  v: PVariant;
begin
  AddStack('FMain.StProv1');
  p:=PointerVar(Params[0]); v:=PointerVar(Params[1]); lr:=Params[2];
  for i:=1 to lr do begin
    if Sender.SayStat(i/lr) then break;
    mr:=mrNo; p(v^,mr);
    if mr=mrCancel then begin
      Aborted:=true; break;
    end;
    ProgPswd.CurQuery.Next;
  end;
  DelStack;
end;

procedure StProv(Sender: TStat; const Params: array of variant; var Aborted: boolean);
const lr = 25;  // Проверить количеством Prov1
var i: longint;
  qr: TMulQuery;
  function Prov1(const table: string; Proc: TProcProv; const cav: array of variant;
    const c_list: array of variant; const o_list: string = ''; const where: string = ''; const g_list: string = ''): boolean;
  var lRecno: boolean;
    clist: TArrVar;
    olist: string;
    a,a1: TArrStr;
    j1: longint;
    av: variant;
  begin
    AddStack('FMain.StProv.Prov1');
    result:=Sender.SayStat('',GetPrim(table),i/lr);
    if not result then with ProgPswd.CurQuery do begin
      FmtPrm(1,GetPrim(table)); lRecno:=MulQry.IsField(table,fRECNO);
      if lRecno then begin
        DeleteTable(table,QQHighLim(fRECNO,0));
        if PartSelect(table,fRECNO,'','',fRECNO,false,sCOUNTZV+'>1')='' then begin
          PartCount(table,[fRECNO]);
          if not Eof then begin
            a:=nil; j1:=RecordCount;
            result:=ShowStat('Проверка номеров записей',StProvRecno,
              [LongInt(@a),j1],j1,true,TKeyLb.GetKeySt(K_Tab),TDM.TabProc);
            if not result and (Length(a)>0) then begin
              MaxFldClear(table); FldInList(a1,fRECNO,a);
              for j1:=low(a1) to high(a1) do if CorrRecno(a1[j1],qr) then begin
                result:=true; break;
              end;
            end;
          end;
        end
        else begin
          Open;
          if IsRecords then begin
            MaxFldClear(table); qr.FldInSel(fRECNO,table,'','',[],@a1,'',ProgPswd.CurQuery);
            result:=ShowStat('Корректировка номеров записей',StCorrRecno,
              [LongInt(qr),LongInt(@a1)],Length(a1),true,TKeyLb.GetKeySt(K_Tab),TDM.TabProc);
          end;
        end;
      end;
      if not result and Assigned(Proc) then begin
        CopyFromVArr(clist,c_list);
        if lRecno then
          if clist[low(clist)]<>'*' then AddFromVArr(clist,[fRECNO]);
        olist:=o_list;
        if (olist<>'') and lRecno then olist:=GetList([olist,fRECNO]);
        PartSelect(table,clist,'',olist,g_list); j1:=RecordCount;
        av:=ArrVarToVar(cav,0);
        result:=ShowStat('Проверка данных',StProv1,[LongInt(@Proc),longint(@av),j1],j1,100,true,
          TKeyLb.GetKeySt(K_Tab),TDM.TabProc);
      end;
      if result then Aborted:=true else Inc(i);
    end;
    DelStack;
  end;
var q: TMulQuery;
  function qOpen(const table: string; const c_list: array of variant): longint;
  begin
    AddStack('FMain.StProv.qOpen');
    q.PartSelect(table,q.Concat(c_list),'',q.GetList(c_list)); result:=longint(q);
    DelStack;
  end;
var ii,j: longint;
  ams: TArrStr;
  a: TArrVar;
  s: string;
label lend;
begin
  AddStack('FMain.StProv');
  TCodeGet.ClearBufAll; SetInfo; ii:=CdrUpd;
  qr:=ProgPswd.GetQuery; q:=ProgPswd.GetQuery; i:=1;
  with ProgPswd.GetQuery do begin
    if Prov1(tSPDB,PrSpdb,[''],[Concat([fSpGK,fUPNAME]),fNAME,fUPNAME],
      GetList([fSpGK,fUPNAME])) then goto lend;
    if Prov1(tFTPSRV,PrEmpEqual,['',LongInt(Srv),'Обнаружен сервер с пустым номером.',
      'Обнаружено серверов с совпадающим номером.','Номер','Адрес'],
      [fFTPSRV,'SRVADDR'],fFTPSRV) then goto lend;
    if Prov1(tACC,PrAcc,['',LongInt(Acc),'Обнаружена учётная запись интернета с пустым номером.',
      'Обнаружено несколько учётных записей интернета с совпадающим номером.'],
      [fACC,fNAME,fUPNAME,fFTPSRV],fACC) then goto lend;
    if Prov1(tCDR,PrEmpEqualUp,['',LongInt(Cdr),'Обнаружен пользователь с пустым номером.',
      'Обнаружено несколько пользователей с совпадающим номером.','Номер','ФИО'],
      [fCDR,fNAME,fUPNAME],fCDR) then goto lend;
    if Prov1(tCNGV,PrCngv,['',LongInt(Cngv),'Обнаружено изменение с пустым номером.',
      'Обнаружено несколько изменений с совпадающим номером.'],
      [fCNGV,fNAME,'TPVIEW',fMDP],fCNGV) then goto lend;
    s:=GetList([fCNGV,fCDR]); 
    if Prov1(tCNG,PrCng,[qOpen(tCNGV,[fCNGV])],[fCNGV,fCDR],s,'',s) then goto lend;
    if Prov1(tMDP,PrMDP,[-1,''],[fMDP,fMdPATH,'ABR'],GetList([fMDP,fMdPATH])) then goto lend;
    q.First;
    if Prov1(tMDF,PrMDF,[longint(q),'','',''],[fCNGV,fMdPATH,fMdFILE],GetList([fCNGV,fMdPATH,fMdFILE])) then goto lend;
    if Prov1(tMDV,PrMDV,[qOpen(tMDF,[fCNGV,fMdPATH,fMdFILE]),'','','',-1],
      [Concat([fCNGV,fMdPATH,fMdFILE]),fCNGV,fMdPATH,fMdFILE,fMDV],
      GetList([fCNGV,fMdPATH,fMdFILE,fMDV])) then goto lend;
    if Prov1(tMDT,PrMDT,[qOpen(tMDV,[fCNGV,fMdPATH,fMdFILE,fMDV]),'','','',-1,''],
      [Concat([fCNGV,fMdPATH,fMdFILE,fMDV]),fCNGV,fMdPATH,fMdFILE,fMDV,fNAME],
      GetList([fCNGV,fMdPATH,fMdFILE,fMDV,fNAME])) then goto lend;
    if Prov1(tDCM,PrEmpEqual,['',LongInt(DBDcm),
      'Обнаружено некорректное описание формы документа.',
      'Обнаружено несколько описаний форм документов с совпадающим именем файла.','Имя файла'],
      [fDCM],fDCM) then goto lend;
    if Prov1(tDCMBMP,PrDcmbmp,['',''],[fDcmBmpPART,fDcmBmpCOD],GetList([fDcmBmpPART,fDcmBmpCOD])) then goto lend;
    if Prov1(tDOC,PrDoc,['',LongInt(Doc),'Обнаружен документ с пустым номером.',
      'Обнаружено несколько документов с совпадающим номером.'],
      [fDOC,fNAME,fCDR],fDOC) then goto lend;
    if Prov1(tDOCPRM,PrDocprm,['',''],[fFDTG,fUSERNAME],GetList([fFDTG,fUSERNAME])) then goto lend;
    if Prov1(tDRV,PrDrv,['',LongInt(Drv),'Обнаружен диск с пустым именем.',
      'Обнаружено несколько дисков с совпадающим именем.','Имя диска'],
      [fDRV,fNAME,fUPNAME,'LOCAL',fIP],fDRV) then goto lend;
    if Prov1(tFLT,PrFlt,[-1,0,0],[fFltGK,'NPP',fNAME]) then goto lend;
    if Prov1(tMSG,PrMsg,[0],[fTD,'DELFROM','DELTO',fMsgTNFROM,fMsgTNTO]) then goto lend;
    SetLength(a,Length(aMsgsFld));
    for j:=low(a) to high(a) do with aMsgsFld[j] do
      if NoDate then a[j]:=nmf else a[j]:=RegDt(nmf);
    if Prov1(tMSGS,PrMsgs,[],a,'',RegDt+'<>'+ProgPswd.SDateReg) then goto lend;
    if Prov1(tOFIS,PrOfis,[0],[fCDR,fTD,'STATUS']) then goto lend;
    if Prov1(tRGN,PrEmpEqualUp,['',LongInt(Rgn),'Обнаружен регион с пустым номером.',
      'Обнаружено несколько регионов с совпадающим номером.'],
      [fRGN,fNAME,fUPNAME],fRGN) then goto lend;
    if Prov1(tTERR,PrEmpEqualUp,['',LongInt(Terr),'Обнаружена территория с пустым номером.',
      'Обнаружен несколько территорий с совпадающим номером.'],
      [fTERR,fNAME,fUPNAME],fTERR) then goto lend;
    if Prov1(tUSERS,PrEmpEqual,['',LongInt(ProgPswd.RUsers),
      'Обнаружен некорректный пользователь.',
      'Обнаружено несколько пользователей с совпадающим именем.','Имя пользователя'],
      [fNAME],fNAME) then goto lend;
    if Prov1(tUSPRM,PrUsPrm,[qOpen(tUSERS,[fNAME]),'',''],[fUSERNAME,fNAME],GetList([fUSERNAME,fNAME])) then goto lend;
    if Prov1(tPROG,PrProg,[0,'',LongInt(@ams)],
      [fORG,fProgKP,fCDR,fDRV,'DIR',fProgCP,'STATUS',fRGN,fTERR,fACC],GetList([fORG,fProgCP])) then goto lend;
    if Prov1(tZAJ,PrZaj,[false,0],['NZ',fORG,fCDR,'TISPD','ISPTN',fTD,'TWD','WTN',fProgCP],'NZ') then goto lend;
    q.PartSelect(tPROG,[fORG,fProgCP],'',GetList([fORG,fProgCP]));
    if Prov1(tZAJ,PrZaj,[true,LongInt(q)],
      ['NZ',fORG,fCDR,'TISPD','ISPTN',fTD,'TWD','WTN',fProgCP],GetList([fORG,fProgCP])) then goto lend;
    ProgPswd.MemoDelUnused(TMain.MemoDelUnusedErr,true);
  end;
lend:
  ProgPswd.FreeQuery; ProgPswd.FreeQuery; ProgPswd.FreeQuery; Cdr.GotoRec(ii);
  DelStack;
end;

class function TMain.PrProv;
begin
  AddStack('TMain.PrProv');
  SetLogVid(logvProvData);
  result:=DcmGetWnd;
  if result then begin
    result:=LockSuper;
    if result then begin
      try
        DcmForm;
        DcmHFPage(gfHead,'PH');
        AddColHead('PH');
        AddColFoot('PF');
        DcmPart('DH');
        DcmPart('PH');
        cntErr:=0;
        if ShowStat('Проверка данных',StProv) then DcmPart('ESC');
        DcmClose;
        LogWrite;
      finally
        UnlockSuper;
      end;
      if Ask(['Внимание!','Для корректной работы программы','необходим её перезапуск.','',
        'Произвести перезапуск программы сейчас ?']) then ProgPswd.ReStart([K_Alt_0]);
    end;
  end;
  SetLogVid;
  DelStack;
end;

procedure PrMemoDelUnusedErr(const av: array of variant);
begin
  AddStack('FMain.PrMemoDelUnusedErr');
  TMemoDelUnusedProc(longint(av[0]))(av[1]);
  DelStack;
end;

class procedure TMain.MemoDelUnusedErr;
var result: TModalResult;
begin
  AddStack('TMain.MemoDelUnusedErr');
  PrAsk(result,[msg],[longint(@Proc),v],PrMemoDelUnusedErr);
  if result=mrCancel then Aborted:=true;
  DelStack;
end;

// Настройка системных параметров
function TMain.ProgDGetClick(Sender: TObject; lEval: Boolean): String;
begin
	AddStack('TMain.ProgDGetClick',Self);
  if lEval then
		if DWVidExec(Prog) then begin
      deSys.Read([sMemo+'PROGD',sMemo+'PROGW']); TDWPrm.VarCreate(Prog);
    end;
  result:='';
  DelStack;
end;

procedure TMain.ProgDGetPaint(Sender: TObject; const ARect: TRect;
  const Text: String);
begin
	AddStack('TMain.ProgDGetPaint',Self);
  TDWVid.ButGetPaint(Sender,ARect,Prog,[dwbShortType,dwbBrackets]);
  DelStack;
end;

const aProgFldHelp: TDWFormStr = ('','','Fld','Fld','Cng','Chk','','','','','','');

function TMain.ProgWGetClick(Sender: TObject; lEval: Boolean): String;
var s: string;
  aHelp: TDWFormHelp;
  nf: TDWForm;
begin
	AddStack('TMain.ProgWGetClick',Self);
  if lEval then begin
  	s:=Glob[sMemo+'PROGW'];
    for nf:=low(aHelp) to high(aHelp) do aHelp[nf]:=IfThen(aProgFldHelp[nf]='',aDWHelp[nf]);
		if DWFldExec('Окно ввода данных по программе',s,Prog,nil,nil,[],nil,nil,@aHelp,nil,ProgWinHelp) then with deSys do begin
    	FldValue[sMemo+'PROGW']:=s;
    	if Prog.DWModified then begin
      	Read(sMemo+'PROGD'); TDWPrm.VarCreate(Prog);
      end;
    end;
  end;
  result:='';
  DelStack;
end;

class function TMain.ProgWinHelp;
begin
  AddStack('TMain.ProgWinHelp');
  result := aProgFldHelp[nf]<>'';
  if result then rHelpFile(hf,HelpFileOrglist,'ProgW.'+aProgFldHelp[nf]);
  DelStack;
end;

procedure TMain.ProgWGetPaint(Sender: TObject; const ARect: TRect;
  const Text: String);
begin
	AddStack('TMain.ProgWGetPaint',Self);
  DM.DataWin.ButGetPaint(Sender,ARect,Glob[sMemo+'PROGW']);
  DelStack;
end;

procedure TMain.DirLastGetClick(Sender: TObject);
begin
  AddStack('TMain.DirLastGetClick',Self);
  TProgCopy.DirAddClick(Sender);
  DelStack;
end;

function TMain.deSysPnlValid(Sender: TObject): Boolean;
const aPart: array[TOrgDatList] of byte = (1,2);
var s: string;
  od: TOrgDatList;
  i: longint;
begin
	AddStack('TMain.deSysPnlValid',Self);
  result:=true;
  if TPanelEdit(Sender).Modified then begin
    result:=TrnsStart([tGLOB,tPROG]);
    if result then try
      with deSys.FldEdit[sMemo+'PROGD'] do result:=ChangeDat(Prog,OldValue,Value,'',false);
      if result then begin
        s:=DM.Rec['OrgDat'];
        for od:=low(OrgDatNmf) to high(OrgDatNmf) do begin
          ls.Clear; i:=lsf.Count; ls.Capacity:=i;
          for i:=1 to i do if GetByte(s,aPart[od],i)=(od=orgdatBold) then ls.Add(lsf[i-1]);
          Glob[OrgDatNmf[od]]:=StrTran(TrimRight(ls.Text),CRLF,','); LogFields.AddRecFld(Glob,OrgDatNmf[od]);
        end;
      end;
      TrnsEnd(IfThen(result,trnsCommit));
    except
      TrnsEnd; raise;
    end;
    if result then
      if Ask(['Системные параметры были изменены.','Необходима перезагрузка программы.',
        'Выполнить перезагрузку сейчас ?']) then ProgPswd.Restart([0]);
  end;
  DelStack;
end;

procedure TMain.deSysFrmHide(Sender: TObject);
begin
	AddStack('TMain.deSysFrmHide',Self);
  TDWPrm.VarCreate(Prog);
  DelStack;
end;

class procedure TMain.PrReindex;
begin
	AddStack('TMain.PrReindex');
  with ProgPswd,RG do begin
    OpenRec; Value['WASCOPY']:=bTrue; UpdateRec;
    if ExecFile(Sender,[exfBound]) then
    	if ExecFile(Sender,[exfCrt,exfBound]) then begin
      	Value['WASCOPY']:=bFalse; UpdateRec;
      end;
    if StrToBoolean(Value['WASCOPY']) then
      if Ask(['Сортировка данных была прервана.','Необходима перезагрузка программы.',
        'Выполнить перезагрузку сейчас ?']) then Restart([0]);
  end;
  DelStack;
end;

{const TimeBeg = 'TD_';
	lTimeBeg = Length(TimeBeg)+1;}

procedure ZajOtdNum(dFrom: TCustomDataFile; const FieldName: string; var v: variant);
begin
  AddStack('FMain.ZajOtdNum');
  if FieldName='OTDNUM' then v:=GlobOTDNUM;
  DelStack;
end;

function TMain.CopyFromOtd;
begin
  AddStack('TMain.CopyFromOtd',Self);
  result:=deOtd.Execute.Saved;
  DelStack;
end;

procedure StCopyFromOtd(Sender: TStat; const Params: array of variant; var Aborted: boolean);
var q,qo: TMulQuery;
	i,lr: longint;
  oZaj: TRecDB;
  a: TArrFldVal;
  a1: TArrStr;
  f: TField;
  fl: boolean;
begin
  AddStack('FMain.StCopyFromOtd');
  q:=PointerVar(Params[0]); qo:=PointerVar(Params[1]);
  SummInit; oZaj:=TRecDB.Create(Main);
  with Main do try
  	with oZaj do begin
    	Connection:=qo.Connection; DateWithTime:=true; NameDB:=tZAJ; FixFldClear; OpenRec;
    end;
    q.PartSelect(tPROG,[fORG,fProgCP]);
    ls.Clear;
    ls.Sorted:=true;
    while not q.Eof do begin
    	ls.Add(SpaceStr(q.Fields[0].AsInteger,10)+q.Fields[1].AsString);
      q.Next;
    end;
    q.PartSelect(tZAJ,[],'OTDNUM='+VTos(qo.FieldZN('OTDNUM')),'NZ');
    ProgPswd.MaxFldClear(tZAJ);
    Zaj.GetMaxFld('NZ','',nil,true,'OTDNUM<>'+Vtos(qo.FieldZN('OTDNUM')));
  	lr:=qo.RecordCount; fl:=true;
    for i:=1 to lr do begin
    	oZaj.GetFromQuery(qo);
      if Sender.SayStat('',StrNum('Номер: ',oZaj['NZ']),i/lr) then break;
      oZaj.GetAFieldValue(a);
      if q.Eof then Zaj.NewRec else Zaj.GetFromQuery(q);
      Zaj.SetAFieldValue(a);

      if (not empty(Zaj[fORG]))and(not empty(Zaj[fProgCP])) then begin
        if q.Eof then Zaj.AppRec
        else begin
          Zaj.GetMaxFldSelf('NZ'); Zaj.UpdateRec;
        end;
      end;

      if ls.IndexOf(SpaceStr(Zaj[fORG],10)+Zaj[fProgCP])<0 then begin
      	Summ.AddLine('D,'+ListKod(Zaj)+','+Zaj[fProgCP]+','); fl:=false;
      end;
      qo.Next; q.Next; 
    end;
    if not Aborted then begin
      if not q.Eof then begin
        SetLength(a1,q.RecordCount); f:=q.FindField(fRECNO);
        for i:=low(a1) to high(a1) do begin
          a1[i]:=Vtos(f); q.Next; 
        end;
        q.DeleteTableFldList(a1);
      end;
      oZaj.FixFldClear; DcmForm;
      if fl then DcmPart('NOERR')
      else begin
      	AddColHead('PH'); AddColFoot('PF');
        SDPart('D,',null,null,'PH','',VarArrayOf(['DH','PH']),null,[],Sender);
      end;
      DcmClose;
    end;
  finally
    oZaj.Free; ls.Sorted:=false; ls.Clear;
  end;
  DelStack;
end;

function TMain.deOtdPnlValid(Sender: TObject): Boolean;
var db: TDatabase;
	ost: longint;
  q,qo: TMulQuery;
begin
	ost:=AddStack('TMain.deOtdPnlValid',Self);
  result:=not empty(DM.Rec['OtdDir']); q:=nil; qo:=nil;
  if result then begin
    db:=ProgPswd.DBDBF(DM.Rec['OtdDir']);
    try
      SetConnected(db,true);
      if GlobOTDNUM=0 then begin
      	result:=false; q:=ProgPswd.GetQuery; qo:=ProgPswd.GetQuery(db);
        qo.PartSelect(tZAJ,[],'','NZ');
        if qo.Eof then meserr('В указанной папке список заявок пуст.')
        else result:=not ShowStat('Поиск заявок отделения',StCopyFromOtd,
        	[LongInt(q),LongInt(qo)]);
      end
      else result:=CopyTable(DBMain,db,tZAJ,ttNone,[cptCanEsc,cptNoTxtTo],nil,'',ZajOtdNum);
    except
      SetStack(ost);
      mess_ok([IfThen(GlobOTDNUM=0,'Ошибка чтения папки:','Ошибка записи в папку:'),
      	DM.Rec['OtdDir'],'Возможно не установлена дополнительная программа BDE.'],
        IfThen(GlobOTDNUM=0,'Ошибка приёма заявок из отделений','Ошибка передачи заявок головной организации'));
    end;
    if Assigned(q) then ProgPswd.FreeQuery;
    if Assigned(qo) then ProgPswd.FreeQuery;
    SetConnected(db,false);
  end;
  DelStack;
end;

// Помощь
procedure TMain.mnHelpProcKey(key: Integer; tw: TWinControl);
begin
	AddStack('TMain.mnHelpProcKey',Self);
  if LockRead then try
    TKeyLb.ExecFixKey(Key);
  finally
    UnLockRead;
  end;
  DelStack;
end;

// Выход
procedure TMain.mnExitProcKey(key: Integer; tw: TWinControl);
begin
	AddStack('TMain.mnExitProcKey',Self);
  Close;
  DelStack;
end;

procedure TMain.FormClose(Sender: TObject; var Action: TCloseAction);
var fl: boolean;
begin
	AddStack('TMain.FormClose',Self);
  inherited;
  if Action<>caNone then
		if not Ask(['Выйти из программы ?'],true) then Action:=caNone
    else begin
      FHelpCore.FormCloseAction;
    	CdrUpd;
      for fl:=false to true do with ProgGet(fl) do
        if Assigned(Qry) then Qry.Close;
        {with Qry do begin
          SeekKeys:=sSeekKeys; Close; SeekKeys:='';
        end;}
    end;
  DelStack;
end;

function TMain.PanelEdit1Valid(Sender: TObject): Boolean;
begin
	AddStack('TMain.PanelEdit1Valid',Self);
  inherited;
  //result:=false;
  result:=not ETn.Enabled;
  PanelEdit1.FldReadAll([ferdSvOld]);
  if ETn.Enabled then TnEnabled(false);
  DelStack;
end;

procedure TMain.PanelEdit1CngKey(Sender: TObject; var tb: TKeyBut);
begin
	AddStack('TMain.PanelEdit1CngKey',Self);
  inherited;
  with tb do case Key of
  	K_Esc: Caption:='Выход';
    K_Alt_Z: begin
    	Caption:=''; Part:=kmNone;
    end;
  end;
  DelStack;
end;

procedure TMain.TnEnabled;
  procedure tfEnbl(tf: TFldEdit);
  begin
    AddStack('TMain.TnEnabled.tfEnbl',Self);
    tf.Enabled:=Value; tf.SetReadOnly(not Value);
    DelStack;
  end;
var i: longint;
  tw: TWinControl;
  tf: TFldEdit;
begin
  AddStack('TMain.TnEnabled',Self);
  with KeyLb1 do begin
    if Value then DelKey(K_All,'pageproc')
    else begin
      SetKey(K_Ctrl_F3,'Пользователь','Сменить пользователя',PageProcKey,'pageproc',kmFile);
      SetKey(K_Ctrl_F6,'Клиент','Найти клиента',PageProcKey,'pageproc',kmFile);
      SetKey(K_CTRL_F9,'','Отправить по интернету',PageProcKey,'pageproc',kmFile);
    end;
    ReDrw;
  end;
  ETn.OnChange:=IfThenCng(Value,ETnChange); tfEnbl(ETn); NotD(Value);
  for i:=0 to ComponentCount-1 do if IsClass(Components[i],TFldEdit,pointer(tf)) then
    if (tf<>ETn)and(tf<>ETnStatus) then begin
      tw:=tf;
      while Assigned(tw) and (tw<>pnOrgDat) do ParentSelf(tw);
      if tw<>pnOrgDat then tfEnbl(tf);
    end;
  PanelEdit1.FillFldList;
  IsMsgCdr;
  DelStack;
end;

procedure ChangeETn;
begin
// информативная процедура
end;

procedure TMain.PageProcKey;
var s: string;
  mq: TMulQuery;
  k,m: longint;
  f: TField;
  il: PArrInt;
  ts: TTabSheet;
  sl: TStringList;
  sisr: TSendIntSaveRec;
begin
  AddStack('TMain.PageProcKey',Self);
  if LockRead then try
    case Key of
      K_F2: FdpUser('Список программ',['PROG'],PfFormFlt);
      K_Ctrl_F3: begin
        RbPage1.SetActivePage(tsOrg);
        ChangeETn;
        CdrUpd;
        TnEnabled;
        ETn.SetFocus;
      end;
      K_Ctrl_F6: begin
        RbPage1.SetActivePage(tsOrg); EKod.SetFocus;
        with TTimer.Create(Self) do begin
          Interval:=1; OnTimer:=TimerFind;
        end;
        KeyLb1.ExecKey(K_F2);
      end;
      K_CTRL_F9: begin
        il:=nil;
        try
          mq:=nil;
          if ParentClass(TWinControl(ts),tw.Parent,TTabSheet) then begin
            if (ts=tsOrg) then begin
              mq:=ProgGet(false).Qry;
              s:=fRECNO;
            end else begin
              if (ts=tsFlt) then begin
                mq:=ProgGet.Qry;
                s:=fRECNO;
              end else begin
                if (ts=tsZaj) then begin
                  mq:=qZajMain; s:=qZajMain.FldDuplicate(fRECNO);
                end;
              end;
            end;
          end;
          if (mq<>nil)and(mq.Active) then begin
            f:=nil;
            for k:=0 to mq.FieldCount-1 do begin
              (* Origin не пустой только под FIBPlus *)
              if (UpperCase(mq.Origin(mq.Fields[k]))<>Prog.tRecno) then continue;
              f:=mq.Fields[k];
              break;
            end;(* for k *)
            if (f=nil) then f:=mq.FindField(s);
            if (f<>nil) then begin
              New(il); m:=f.AsInteger; mq.DisableControls;
              try
                mq.SaveTo(il^,nil,f); mq.First;
                while (not mq.Eof) do begin
                  if (f.AsInteger=m) then break;
                  mq.Next;
                end;
              finally
                mq.EnableControls;
              end;
              QuickSort(il^);
            end;
          end;
          s:='*.PCK';
          OdSendIntObn.DefaultExt:=s;
          OdSendIntObn.Filter:='Файл обновления('+s+')|'+s+'|Все файлы(*.*)|*.*';
          DM.Rec['SI_KP']:=InitFIni[fiSave].ReadString('Main','SI_KP');
          DM.Rec['SI_ONSEL']:=InitFIni[fiSave].ReadBool('Main','SI_ONSEL');
          DM.Rec['SI_OBJ']:=InitFIni[fiSave].ReadString('Main','SI_OBJ');
          DM.Rec['SI_FILE']:=InitFIni[fiSave].ReadString('Main','SI_FILE');
          DM.Rec['SI_DPPATH']:=InitFIni[fiSave].ReadString('Main','SI_DPPATH');
          DM.Rec['SI_MSGPTRN']:='';
          sl:=SortStrListCreate;
          try
            DeSendInt.Param['SI_ONSEL',deNoVisible]:=bStr[il=nil];
            Finalize(sisr);
            sisr.sisrUpdZaj:=false;
            DeSendInt.Execute([longint(il),longint(@sisr),longint(sl)]);
            if (sisr.sisrKP<>'') then begin
              InitFIni[fiSave].WriteString('Main','SI_KP',sisr.sisrKP);
              InitFIni[fiSave].WriteBool('Main','SI_ONSEL',sisr.sisrONSEL);
              InitFIni[fiSave].WriteString('Main','SI_OBJ',Int2Str(sisr.sisrOBJ));
              case sisr.sisrOBJ of
                SI_OBJ_FILE: InitFIni[fiSave].WriteString('Main','SI_FILE',sisr.sisrFILE);
                SI_OBJ_DP: InitFIni[fiSave].WriteString('Main','SI_DPPATH',sisr.sisrDPPATH);
              end;
            end;
            if (sisr.sisrUpdZaj) then begin
              if (RbPage1.ActivePage=tsZaj) then brZaj.BrUpdate;
            end;
          finally
            sl.Free;
          end;
        finally
          DisposeNil(il);
        end;
      end;
    end;
  finally
    UnLockRead;
  end;
  DelStack;
end;

procedure TMain.TimerFind;
var f: TForm;
	tl: TKeyLb;
  fl: boolean;
begin
  AddStack('TMain.TimerFind',Self);
  with TTimer(Sender) do begin
  	Enabled:=false; f:=LastForm; fl:=false;
    if f<>Self then begin
      fl:=FormKeyLb(f,tl);
      if fl then tl.ExecKey(K_F6);
    end;
    if fl then Free else Enabled:=true;
  end;
  DelStack;
end;

// Параметры выборки
procedure TMain.EFltEnter(Sender: TObject);
begin
	AddStack('TMain.EFltEnter',Self);
  with KeyLb1 do begin
  	SetKey(K_F2,'Печать','',PageProcKey,'orgflt',kmFile);
  	Redrw;
  end;
  DelStack;
end;

procedure TMain.EFltExit(Sender: TObject);
begin
	AddStack('TMain.EFltExit',Self);
  KeyLb1.DelKey(K_All,'orgflt'); KeyLb1.Redrw;
  DelStack;
end;

procedure TMain.deFltFrmShow(Sender: TObject);
{$IFNDEF FLTPROG}
var tf: TFldEdit;
{$ENDIF}
begin
{$IFNDEF FLTPROG}
	AddStack('TMain.deFltFrmShow',Self);
  with deFlt do begin
    if IsFldEdit(sMemo+deFltFld,tf) then tf.HelpContext:=30002;
    if lStatInv then
      if IsFldEdit('STATUS',tf) then begin
        tf.VarValue:=NoBytes(Cdr[deFltFld+'STATUS']); lStatInv:=false;
      end;
  end;
  DelStack;
{$ENDIF}
end;

procedure TMain.deFltFldChange(Sender: TObject; const OldVal: Variant;
  FromShow: Boolean);
{$IFNDEF FLTPROG}
var lRdOnly: boolean;
  procedure Cng1(const nmf: string; gOne,gAny: TCustomGet; lBound: boolean = false;
	  const msOne: string = cCdName+cCdCod+cCd0);
	var s: string;
    flt: TFltList;
  begin
    AddStack('TMain.deFltFldChange.Cng1',Self);
    with deFlt,TFldEdit(Sender) do if lBound or (NameRecFld=deFltFld+nmf) then begin
      flt:=VarValue;
      with FldEdit[sMemo+deFltFld+nmf] do begin
        s:=Trim(VarValue); SetReadOnly((flt=fltAll) or lRdOnly);
        case flt of
          fltOne: begin
            AssignGet(gOne); Mask:=msOne;
          end;
          fltAny: begin
            AssignGet(gAny); Mask:='';
          end;
        end;
        VarValue:=s;
      end;
    end;
    DelStack;
  end;
{$ENDIF}
begin
{$IFNDEF FLTPROG}
	AddStack('TMain.deFltFldChange',Self);
  lRdOnly:=false;
  Cng1(tCDR,CdrGet,DM.btgCdr); Cng1(tORG,DM.ListGet,btgOrg);
  Cng1('PRG',DM.ProgGet,btgProg,false,''); Cng1(fCDR,CdrGet,DM.btgCdr);
  Cng1('WTN',CdrGet,DM.btgCdr);
  lRdOnly := Cdr['ZAJISPN']=ispnNoIsp;
  with TFldEdit(Sender),deFlt do if NameRecFld=deFltFld
    then SetReadOnly(['FltLs',sMemo+deFltFld],not StrToBoolean(VarValue))
  else if NameRecFld='ZAJISPN' then begin
  	SetReadOnly('VAL10',lRdOnly,ogReadOnlyNoVsbl);
    SetReadOnly(['ZAJISPD1','ZAJISPD2','VAL8','ZAJITN'],lRdOnly);
    Cng1('ITN',CdrGet,DM.btgCdr,true);
  end;
  Cng1('ITN',CdrGet,DM.btgCdr,false);
  DelStack;
{$ENDIF}
end;

function TMain.deFltPnlValid(Sender: TObject): Boolean;
{$IFNDEF FLTPROG}
var Opt: PDEFltOpt;
{$ENDIF}
begin
	AddStack('TMain.deFltPnlValid',Self);
{$IFNDEF FLTPROG}
  Opt:=PointerVar(deFlt.Params[1]);
  LogFields.AddRecFld(Cdr,[deFltFld+'STATUS',deFlt.Params[0]]);
  Cdr[deFltFld+'STATUS']:=NoBytes(DM.Rec['STATUS']);
  Cdr[deFlt.Params[0]]:=ProgGet(fltFlt in Opt^).Ord2Mem(DM.Rec['ORD'],fltZaj in Opt^);
  Cdr.UpdateRec(true);
{$ENDIF}
  result:=true;
  DelStack;
end;

const FltLastVers = 1;
  FltEof = '__EOF';

procedure TMain.FltNewRec;
var i: longint;
  s: string;
  ss: TStrBuf;
begin
  AddStack('TMain.FltNewRec',Self);
  DM.RFltNewRec(Sender,lcopy,gKey); Flt[fCDR]:=Cdr[fCDR];
  ss:=TStrBuf.CreateWrite(@s,FltLastVers);
  try
    with deFlt do for i:=0 to FldCount-1 do with FldEdit[i] do if not(ogReadOnly in Options) then begin
      ss.WriteStr(NameRecFld,stByte); ss.WriteStr(PNameRecFld.GetStrVal);
    end;
    ss.WriteStr(FltEof,stByte);
  finally
    ss.Free;
  end;
  Flt[sMemo+'FLT']:=s;
  DelStack;
end;

procedure TMain.deFltKpProcKey(key: Integer; tw: TWinControl);
var f,v: string;
  Opt: PDEFltOpt;
  gk: TFltGk;
  tf: TFldEdit;
begin
  AddStack('TMain.deFltKpProcKey',Self);
  if Key=K_Alt_F5 then begin
    Opt:=PointerVar(deFlt.Params[1]); gk:=IfThen(fltZaj in Opt^,fltgkZaj,fltgkProg);
    Flt.OnNewRec:=FltNewRec;
    try
      if TFltLs.Execute(v,gk,aFltGk[gk],nil,'',true) then with TStrBuf.CreateRead(v,FltLastVers) do try
        repeat
          f:=ReadStr(stByte);
          if f=FltEof then break;
          v:=ReadStr;
          if deFlt.IsFldEdit(f,tf) then begin
            tf.PNameRecFld.SetStrVal(v); tf.Read;
          end;
        until Eof;
      finally
        Free;
      end;
    finally
      Flt.OnNewRec:=DM.RFltNewRec;
    end;
  end;
  DelStack;
end;

// Анализ данных по "ЗАРПЛАТЕ"
procedure TMain.deZpnDirPnlSetKey(Sender: TObject; key: Integer; var txt,
  hnt: String; var Part: Integer);
begin
	AddStack('TMain.deZpnDirPnlSetKey',Self);
  case Key of
    K_F10: txt:='';
    K_Enter: begin
    	txt:='Анализ'; Part:=kmFile;
    end;
  end;
  DelStack;
end;

procedure TMain.btgOrgClick(Sender: TObject);
begin
	AddStack('TMain.btgOrgClick',Self);
  TOrgLs.Execute(Sender);
  DelStack;
end;

function TMain.btgProgClick(Sender: TObject; lEval: Boolean): String;
var tf: TFldEdit;
  s,s1: string;
  a: TArrStr;
  i,n: longint;
begin
  AddStack('TMain.btgProgClick',Self);
  tf:=pointer(Sender);
  if lEval then begin
    s:='';
    for i:=0 to LsArrDynamic(tf.Value,a,',')-1 do begin
      n:=Int0(a[i]);
      if (not InRange(n,low(ProgInfs),high(ProgInfs))) then continue;
      SetByte(s,n,true);
    end;
    DM.Rec['PROG']:=s;
    if deProgSel.Execute.Saved then begin
      s1:='';
      s:=DM.Rec['PROG'];
      for i:=low(ProgInfs) to high(ProgInfs) do begin
        if (GetByte(s,i)) then IncD(s1,StrNum(',',i));
      end;
      tf.Value:=Copy(s1,2,MaxInt);
    end;
  end;
  n:=LsArrDynamic(tf.Value,a,',');
  for i:=0 to n-1 do a[i]:=DM.ProgGet.MenuName(a[i]);
  result:=ArrayAsList(a,',',n);
  DelStack;
end;

procedure TMain.btgProgDWFldValue(Sender: TObject; r: TCustomRec;
  const Mask: String; var Value: Variant);
const Dlm: string = ',';
var Prm: TLogTrnsValPrm;
begin
  AddStack('TMain.btgProgDWFldValue',Self);
  Prm.Opt:=[]; TProgLogCompare.ExecuteStr(Prm,'',Value,@Dlm); Value:=Prm.val;
  DelStack;
end;

procedure TMain.btgProgLogCompare(tf: TFldEdit; var Prm: TLogTrnsValPrm);
begin
  AddStack('TMain.btgProgLogCompare',Self);
  TProgLogCompare.Execute(Prm,',');
  DelStack;
end;

// Печать списка программ
class function TMain.PfFormFlt;
type
  TRec = record
  	fval,ford: TField;
    g: TCustomGet;
    ms: string;
    lCod,lName,lABC,lBool: boolean;
  end;

	function Zn1(const r: TRec; var sc: string): string;
  var s,m: string;
    b: boolean;
    cg: TCodeGet;
    v: variant;
  begin
    AddStack('TMain.PfFormFlt.Zn1');
    sc:='';
    result:=TrimRight(r.fval.AsString);
    if IsClass(r.g,TCodeGet,pointer(cg)) then begin
      s:=FieldAsString(r.ford); result:=cg.CodeName(s,[cdgBufAll]);
      if r.lCod then sc:=s;
    end else begin
      if (r.g is TMenuGet) then begin
        m:=r.ms;
        if (Pos(cMnCod,AnsiUpperCase(m))>0) or r.lCod then begin
          sc:=FieldAsString(r.ford); StrTranSelf(m,cMnCod,'',[rfReplaceAll,rfIgnoreCase]);
        end;
        if (Pos(cMnNoName,AnsiUpperCase(m))=0) or r.lCod then begin
          v:=FieldAsString(r.ford); r.g.DWFldValue(Prog,m,v); result:=v;
        end;
      end else begin
        if (r.lBool) then begin
          if (r.ford=nil) then b:=false else b:=r.ford.AsBoolean;
          result:=IfThen(b,'+');
        end;
      end;
    end;
    TrimSelf(sc); TrimSelf(result);
    DelStack;
  end;

const algms: TAlgmStr = ('РАЗМ_ВЕРХ_ЛЕВ','РАЗМ_ВЕРХ_ПРАВ','РАЗМ_ВЕРХ_ЦЕНТ');
	acn: TArrBoolChr = ('N','C');

var algmn: TAlgmStr;
  algm: TAlignment;
  sel,sord: string;
  i,j,n,lr,ln: longint;
	Qry: TMulQuery;
  fdef: TProgFldDef;
  ao: TArrStr;
  s,sn,s1,sc: string;
  aw: TDEPrmStr;
	al: TArrStr;
  af: array of TRec;
  pr: ^TRec;
  f: TField;
  p: TOrdFixList;
begin
	AddStack('TMain.PfFormFlt');
  result:=DcmGetWnd;
  if result then begin
  	for algm:=low(algms) to high(algms) do algmn[algm]:=IntToStr(TInter.GetVarValue(algms[algm]));
    SummInit; sel:=EdGenFr.RDocPrm['ДАН']; sord:=''; j:=0;
    for i:=1 to ofxCnt+ProgGet.fdef.ls.Count do
      if not(GetByte(sel,i) and GetByte(sel,2,i)) then begin
        SetByte(sord,i,true); Inc(j);
        for n:=1 to 3 do SetByte(sel,n,j,GetByte(sel,n,i));
      end;
    SetLength(af,j); Qry:=ProgPswd.GetQuery; fdef:=TProgFldDef.Create; 
    try
    	Qry.Arg[sO_LIST]:='KOD';
      fdef.OrdRead(Qry,sord+'/'+DlmCopy(sel,4,1,'/'),true);
    	Qry.Arg[sWHERE]:=ProgGet.Qry.Arg[sWHERE];
      Qry.OnCalcFields:=fdef.CalcFields;
      Qry.OnFilterRecord:=fdef.FilterRecord;
      Qry.Filtered:=ProgGet.Qry.Filtered;
      fdef.lsRec.Assign(ProgGet.fdef.lsRec);
      lr:=0; n:=1;
      Qry.GetListArg(sO_LIST,ao);
      DM.DataWin.LoadFromStr(Glob[sMemo+'PROGW']);
      ln:=LsArrDynamic(DM.DataWin.Fields,al,CRLF)-1;
      for i:=0 to Qry.FieldCount-1 do begin
        f:=Qry.Fields[i];
        if (not f.Visible) then continue;
        pr:=@af[lr];
        pr^.fval:=f;
        pr^.g:=nil;
        pr^.ms:='';
        pr^.lBool:=false;
        pr^.lCod:=false;
        pr^.lName:=true;
        if Qry.FindField(ao[n-1],pr^.ford) then
          if ProgFldFind(pr^.ford.FieldName,p) then with ProgFld[p] do begin
            NameGet(pr^.g,ofvVid,ofvVName); pr^.ms:=ofvMask;
          end;
        if not Assigned(pr^.g) then begin
          s:=VarNmToRec(pr^.fval.FieldName)[2];
          for j:=0 to ln do begin
            aw:=DEGetArrParam(al[j]);
            if TrimUpper(aw[deNameRecFld])<>s then continue;
            NameGet(pr^.g,aw);
            pr^.ms:=aw[deMask];
            break;
          end;
        end;
        if (pr^.g is TCodeGet)or(pr^.g is TMenuGet) then begin
          pr^.lCod:=not GetByte(sel,n);
          pr^.lName:=not GetByte(sel,2,n);
        end;
        pr^.lABC := GetByte(sel,3,n) and pr^.lName;
        pr^.lBool := (pr^.g is TBoolGet) or (pr^.fVal is TBooleanField);
        Inc(lr);
        s:='D,'+SpaceStr(lr,2)+',';
        Summ.SetS('H',s+acn[false]+',',astolin(f.DisplayLabel,2,0));
        if (pr^.lCod) then begin
          Summ.SetS('A',s+acn[not pr^.lABC]+',',algmn[taRightJustify]);
          Summ.SetS('B',s+acn[not pr^.lABC]+',','');
        end;
        if (pr^.lName) then begin
          Summ.SetS('A',s+acn[pr^.lABC]+',',algmn[TAlignment(iif(pr^.lBool,taCenter,f.Alignment))]);
          Summ.SetS('B',s+acn[pr^.lABC]+',',IfThen(pr^.lBool,'+'));
        end;
        Inc(n);
      end;(* for *)
      SetLength(af,lr);
      Qry.Open;
      lr:=Qry.RecordCount;
      ln:=LenIntStr(lr);
      for i:=1 to lr do begin
        if Qry.Eof then break;
        if DcmSayStat(i/lr) then break;
        s:='D,';
        for j:=low(af) to high(af) do begin
          pr:=@af[j];
          if pr^.lABC then sn:=Zn1(pr^,sc) else sn:=FieldAsString(pr^.ford);
          IncD(s,StrTran(sn,',',#30)+#31);
        end;
        IncD(s,SpaceStr(i-1,ln)+',');
        if EdGenFr.RDocPrm['ГРУП'] then begin
          s1:=s;
          s:='O,';
          for j:=low(af) to high(af) do IncD(s,StrTran(FieldAsString(af[j].ford),',',#30)+#31);
          IncD(s,',');
          Summ.SetS(s,'STR',s1);
        end;
        for j:=low(af) to high(af) do begin
          pr:=@af[j];
          sn:=Zn1(pr^,sc);
          s1:='D,'+SpaceStr(j+1,2)+',';
          if pr^.lCod then Summ.SetS(s,s1+acn[not pr^.lABC]+',',sc);
          if pr^.lName then Summ.SetS(s,s1+acn[pr^.lABC]+',',sn);
        end;
        Qry.Next;
      end;
      Qry.OnCalcFields:=nil;
      Qry.OnFilterRecord:=nil;
      while Qry.FieldCount > 0 do Qry.Fields[0].Free;
    finally
      fdef.Free; 
    end;
    ProgPswd.FreeQuery;
    if not DcmAborted then begin
    	if EdGenFr.RDocPrm['ГРУП'] then
        for i:=0 to Summ.ArrName(s_line,al,'O,')-1 do Summ.Rename(s_line,al[i],Summ.Value('STR',al[i]));
      DcmForm; AddColHead('PH'); AddColFoot('PF'); 
      for i:=1 to Length(af) do begin
        pr:=@af[i-1];
        s:='D,'+SpaceStr(i,2)+',';
        if pr^.lCod then DcmAddCol(s+acn[not pr^.lABC]+',');
        if pr^.lName then DcmAddCol(s+acn[pr^.lABC]+',');
      end;
      for i:=1 to EdGenFr.RDocPrm['ДОПКОЛ'] do DcmAddCol('E,'+SpaceStr(i,2)+',N,');
      if SDPart('D,',null,null,'PH','PF',VarArrayOf(['DH','PH']),null) then DcmClose else DcmAbort;
    end;
    result:=not DcmAborted;
  end;
  DelStack;
end;

procedure TMain.tsFltEnter(Sender: TObject);
begin
	AddStack('TMain.tsFltEnter',Self);
	with ProgGet,Qry do BeforeOpen:=QryBeforeOpen;
  GotoProgSetKey('На клиента','Перейти на клиента по программе');
  DelStack;
end;

procedure TMain.tsFltExit(Sender: TObject);
begin
  AddStack('TMain.tsFltExit',Self);
  GotoProgDelKey;
  DelStack;
end;

procedure TMain.pnZajEnter(Sender: TObject);
begin
	AddStack('TMain.pnZajEnter',Self);
  qZajMain.BeforeOpen:=qZajBeforeOpen;
  pnBrEnter(Sender); MsgRebuild(Self,rbBefore);
  qZajMain.Last;
  SelSetKey(KeyLb1);
  GotoProgSetKey('На программу','Перейти на программу по заявке');
  ZajEdSetKey(KeyLb1,ZajProcKey);
  with KeyLb1 do begin
  	SetKey(K_F12,'Данные','Выводимые данные по заявке и их порядок просмотра',ZajProcKey,'zaj',kmList);
    ZajIspSetKey;
  	SetKey(K_Enter,'','Выполнить',ProgGet(false).ProcKey,'zaj',kmList);
  	SetKey(K_Shift_Enter,'','Установка с учётом рег.номера',ProgGet(false).ProcKey,'zaj',kmList);
    SetKey(K_Shift_F3,GetPrim(tZAJ),'Заявки по программе',ZajProcKey,'zaj',kmList);
    Redrw;
  end;
  DelStack;
end;

procedure TMain.ZajIspSetKey;
begin
  AddStack('TMain.ZajIspSetKey',Self);
  with KeyLb1 do begin
    SetKey(K_Ctrl_F12,'',IfThen(Cdr['ZAJISPN']=ispnIsp,'Просмотр только неисполненных заявок',
      IfThen(Cdr['ZAJISPN']=ispnNoIsp,'Просмотр исполненных и неисполненных заявок',
      'Просмотр только исполненных заявок')),ZajProcKey,'zaj',kmList);
    SetKey(K_Shift_F12,'',IfThen(lZajSelfNoisp,'Просмотр заявок в соответствии с выборкой',
    	'Просмотр своих неисполненных заявок'),ZajProcKey,'zaj',kmList);
	end;
  DelStack;
end;

procedure TMain.pnZajExit(Sender: TObject);
begin
	AddStack('TMain.pnZajExit',Self);
  pnBrExit(Sender);
  SelDelKey(KeyLb1);
  GotoProgDelKey;
  KeyLb1.DelKey(K_All,'zaj');
  KeyLb1.Redrw;
  qZajMain.BeforeOpen:=nil;
  DelStack;
end;

procedure TMain.ZajProcKey;
var ii,tr: longint;
  fl: boolean;
  f: TField;
  oLogKeys: PLogKeysSave;
begin
  AddStack('TMain.ZajProcKey',Self);
  if LockRead then try
    oLogKeys:=ProgPswd.PLogKeysLen;
    try
      fl:=false;
      case Key of
        K_F12: begin
          fl:=deFltExec('Выборка заявок',tZAJ,sMemo+'ORDZAJ','ZAJFLT',[fltZaj,fltFlt]);
          if fl then lZajSelfNoisp:=false;
        end;
        K_Ctrl_F12: begin
          Cdr['ZAJISPN']:=IfThen(Cdr['ZAJISPN']=ispnNoIsp,byte(ispnAll),Cdr['ZAJISPN']+1);
          lZajSelfNoisp:=false; fl:=true;
        end;
        K_Shift_F12: begin
          NotD(lZajSelfNoisp); fl:=true;
        end;
        K_CTRL_D,K_CTRL_G,K_CTRL_O: if qZajMain.FindField(qZajMain.FldDuplicate(fRECNO),f) then begin
          Prog.GotoRec(f); ZajLsEd(Key,tw,f);
        end;
        K_Shift_F3: if qZajMain.FindField(qZajMain.FldDuplicate(fRECNO),f) then begin
          Prog.GotoRec(f);
          try
            ZajRecno:=qZajMain.FieldZN(fRECNO,tZAJ); ProgGet(false).ProcKey(K_F3,tw);
          finally
            ZajRecno:=0;
          end;
        end;
      else ZajLsEd(Key,tw,qZajMain.FindField(qZajMain.FldDuplicate(fRECNO)));
      end;
      if fl then begin
        fl := pnZaj.Header='';
        ii:=qZajMain.FindField(fRECNO).AsInteger;
        tr:=brZaj.Row;
        ZajSetFlt;
        brZaj.BrUpdate(tr,ii);
        if fl <> (pnZaj.Header='') then pnZaj.Sort;
        ZajIspSetKey;
        FreeAndNil(ZajLs);
      end;
    finally
      ProgPswd.PLogKeys:=oLogKeys;
    end;
  finally
    UnLockRead;
  end;
  DelStack;
end;

procedure TMain.ZajEdProcKey(Key: longint; tw: TWinControl);
begin
  AddStack('TMain.ZajEdProcKey',Self);
  if LockRead then try
    ZajLsEd(Key,tw,nil);
  finally
    UnLockRead;
  end;
  DelStack;
end;

procedure TMain.ZajLsEd;
var a: TSelIspArr;
  an: TArrTN;
  br: TBrowl;
  q: TMulQuery;
  s,t: string;
  b: boolean;
  oLogKeys: PLogKeysSave;
  dNow: TDateTime;
  fNow: Double;
  i,j,tn: longint;
  pa: PSelIsp;
  ba: TSelIsp;
  af: TArrFldVal;
begin
  AddStack('TMain.ZajLsEd',Self);
  br:=pointer(tw); q:=br.Qry;
  if q.IsRecords then case Key of
    K_Ctrl_F7: if dePswd.Execute(not lZajIspCalc) then begin
      NotD(lZajIspCalc); ZajIspCalc;
    end;
    K_CTRL_D: DM.MsgApp;
    K_CTRL_G,K_CTRL_O: if (ProgTp.sid<>'') then begin
      s:=GetFtpDir(Vtos(Prog[fACC]),@t);
      if (s<>'') then begin
        case Key of
          K_CTRL_G: begin
            SetLogVid(logvSendMsg); ProgLogKeysAdd;
            t:=TrimRight(Prog['MSGPTRN']);
            if not SendMsg(s,Trim(ListKod)+'-'+Trim(Prog[fProgCP]),t,false,false,TFltLs.SelPtrn)
            then ProgPswd.CngLogVid(logvEditRec);
            if (t<>TrimRight(Prog['MSGPTRN'])) then begin
              Prog['MSGPTRN']:=t; Prog.UpdateRec(true);
              for b:=false to true do begin
                if (aProgFld[b]=nil) then continue;
                if (ProgGet(b)=nil) then continue;
                if (ProgGet(b).Qry=nil) then continue;
                ProgGet(b).Qry.Close;(* чтобы обновить список программ *)
              end;(* for b *)
            end
            else if ProgPswd.LogVid=logvSendMsg then Prog.LogWrite;
            SetLogVid;
          end;
          K_CTRL_O: SftpFilesExec(s+PathDelim,GlobDIRLAST,t,GlobLASTCNT,GlobLASTDAY);
        end;
      end;
    end;
  else
    Zaj.GotoRec(q);
    case Key of
      K_F3: begin
        DM.Rec['KOD']:=ListKod(Zaj);
        SetLogVid(logvMoveZaj); oLogKeys:=ProgPswd.PLogKeys;
        try
          if deZajMov.Execute.Saved then br.BrUpdate;
        finally
          ProgPswd.PLogKeys:=oLogKeys; SetLogVid;
        end;
      end;
      K_Ctrl_Enter: if not empty(Zaj['SELISPSH']) then begin
        SelIspEnd(s,t,ba.ball,fNow,Now,Zaj['SELISPSH'],Zaj['CNTISP'],Cdr[fCDR]);
        Zaj['WTN']:=SpaceStr(s,lCdrTn); Zaj['BALL0']:=ba.ball; Zaj['TWTN']:=t; Zaj['TCNG']:=fNow;
        Zaj.UpdateRec(true); br.BrUpdate;
      end;
      K_Ctrl_Plus: repeat
        if not empty(Zaj['WTN']) or (Zaj['CNTISP']=0) then break;
        DM.Rec['SELISPSH']:=Str2SelIsp(DeShifrStr(Zaj['SELISPSH']));
        pa:=nil; ba.ball:=1000000; j:=OLProc.IspCalc(a,an,Zaj['SELISPSH'],Zaj['CNTISP']);
        if j>0 then begin
          j:=IfThen(j<Zaj['CNTISP'],NegDef,high(an)); tn:=Int0(Cdr[fCDR]);
          for i:=high(an) downto low(an) do if a[an[i]].tn=tn then begin
            j:=i; break;
          end;
          if j<>NegDef then begin
            ba:=a[an[j]]; pa:=@ba; ba.ball:=trunc(pa.ball*0.9);
          end;
        end;
        j:=12; s:=SpaceStr0(ba.ball,j-1);
        for i:=1 to 3 do begin
          Dec(j,3); StuffStrSelf(s,j,0,'''');
        end;
        DM.Rec['BALL']:=s;
        deSelIsp.Param['CNTISP',deMaxLen]:=IntToStr(LenIntStr(Zaj['CNTISP']));
        DM.Rec['KOD']:=ListKod(Zaj);
        if not deSelIsp.Execute([longint(pa)]).Saved then break;
        i:=Length(a); SetLength(a,i+1); a[i].tn:=Int0(Cdr[fCDR]); a[i].ball:=Int064(StrTran(DM.Rec['BALL'],''''));
        SelIspSet(SelIsp2Str(a));
        dNow:=Now; fNow:=Zaj['TCNG']; Zaj['TCNG']:=dNow;
        Zaj['TSELISP']:=DateToString(dNow);
        Zaj.UpdateRec(false,nil,@i,'TCNG='+Vtos(fNow));
        if i=0 then
          if Ask(['Внимание !','Во время добавления к выбору исполнителя',
          'были произведены изменения другим пользователем.',
          'Добавление к выбору исполнителя не было произведено.','Повторить попытку добавления ?'])
            then Zaj.GotoRec(q) else break;
        br.BrUpdate;
      until i>0;
      K_Shift_F5: begin
        s:=aConcatTxt254(Zaj,false,'MOV');
        if EdTextExec('Движение заявки',s,'',nil,[],edtpText,0,0,'',0,nil,'',nil,nil,'',nil,nil,nil,TDM.ZajMovMaxLength) then begin
          aSplitTxt254(Zaj,s,true,nil,'MOV'); Zaj.UpdateRec(true); br.BrUpdate;
        end;
      end;
    else
      if not Assigned(ZajEd) then begin
        Zaj.GetAFieldValue(af); CreateForm(TProgEd,ZajEd); Zaj.SetAFieldValue(af);
      end;
      if (Key=K_Ctrl_F5) and empty(Zaj['TISPD']) then begin
        Zaj['TISPD']:=DateToString(Now); Zaj['TISPD1']:=Zaj['TISPD']; Zaj['ISPV']:=ivCdrToOrg;
        Zaj['ISPTN']:=DM.Rec[fCDR]; Zaj['ISPV']:=ivPhone;
      end;
      if ZajEdit(IfThen(Key=K_F5,'Редактировать заявку','Исполнение заявки'),frProg,
        IfThen(Key<>K_F5,[zpsVisible]),zpsDefault,[zajVsblNZ,zajVsblWISP]) then br.BrUpdate;
    end;
  end;
  DelStack;
end;

function TMain.deSelIspFldCheck(Sender: TObject): Boolean;
var pa: PSelIsp;
  l,i: Int64;
  s: string;
begin
  AddStack('TMain.deSelIspFldCheck',Self);
  with TFldEdit(Sender) do if NameRecFld='BALL' then begin
    s:=Trim(StrTran(VarValue,'''')); i:=Int064(s); result := IntToStr(i)=s;
    if not result then meserr('Значение содержит нецифровые символы.')
    else if PointerVar(deSelIsp.Params[0],pointer(pa)) then begin
      l:=pa.ball div 2; result:=InRange(i,l,pa.ball);
      if not result then meserr('Значение должно быть в пределах от %d до %d.',[l,pa.ball]);
    end;
  end
  else result:=true;
  DelStack;
end;

function TMain.deSelIspPnlValid(Sender: TObject): Boolean;
var pa: PSelIsp;
begin
  AddStack('TMain.deSelIspPnlValid',Self);
  result:=true;
  if PointerVar(deSelIsp.Params[0],pointer(pa)) then
    if pa.tn=Int0(Cdr[fCDR])
    then result:=Ask(['Последний выбор исполнителя','был заполнен текущим пользователем.','Продолжить ?']);
  DelStack;
end;

function TMain.dePswdPnlValid(Sender: TObject): Boolean;
begin
  AddStack('TMain.dePswdPnlValid',Self);
  result := DM.Rec['PSWD']=DeShifrStr(Cdr['PSWD']);
  DelStack;
end;

procedure TMain.deZajMovFldChange(Sender: TObject; const OldVal: Variant;
  FromShow: Boolean);
var tf: TFldEdit;
begin
	AddStack('TMain.deZajMovFldChange',Self);
  tf:=pointer(Sender);
  if tf.NameRecFld='KOD' then DM.ProgCpGetInit(tf,fProgCP+'<>'+QQs,DM.ProgCpGet);
  DelStack;
end;

function TMain.deZajMovPnlValid(Sender: TObject): Boolean;
var svi: TRDBSaveInf;
begin
	AddStack('TMain.deZajMovPnlValid',Self);
  Zaj[fORG]:=Int0(DM.ListGet.CodeDop(deZajMov.FldEdit['KOD'],DM.Rec['KOD'],[cdgBufAll]));
  Prog.SaveInf(svi);
  Prog.Seek(Prog.TblFldName(fORG)+'='+Vtos(Zaj[fORG])+sAND+Prog.TblFldName(fProgCP)+'='+QQs(Zaj[fProgCP]));
  ProgLogKeysAdd; TRecDB.RestInf(svi);
  result:=true;
  DelStack;
end;

function TispdIsNull: string;
begin
  AddStack('FMain.TispdIsNull');
  result:=QQNull('TISPD','');
  DelStack;
end;

procedure TMain.ZajFldGetText;
var s,t: string;
  k: longint;
  f,f2: TField;
  dt: TDateTime;
  b: boolean;
  v: variant;
  q: TMulQuery;
  svi: TRDBSaveInf;
begin
  if (DisplayText) then begin
    b:=false;
    s:=UpperCase(Sender.FieldName); q:=MulQueryOwner(Sender.DataSet);
    for k:=1 to ofzCnt do with aOrdFixz[k] do if s=ofzvCalc then begin
      b:=true; s:=ofzvFld;
      if s<>'' then if not q.FindField(s,f) then break;
      case k of
        ofzTD,ofzTWTN,ofzTSELISP: Text:=StringToDispDate(f.Value,2);
        ofzTSELISPE: Text:=StringToDispDate(f.Value,4);
        ofzDACT: begin
          dt:=f.AsDateTime;
          if dt<DateBig then Text:=StringToDispDate(dtos(dt),3);
        end;
        ofzTN: Text:=CdrGet.CodeName(f.AsString,[cdgBufAll]);
        ofzTISPD,ofzTWD: begin
          dt:=StringToDate(f.AsString);
          if (not empty(dt)) then begin
            Text:=FormatDateTime('dd/mm/yyddd hh:nn-',dt)+
              FormatDateTime('hh:nn',StringToDate(q.FindField(s+'1').AsString));
          end;
        end;
        ofzISPV,ofzISPTN: if q.FindField(aOrdFixz[ofzTISPD].ofzvFld,f2) then
          if not empty(StringToDate(f2.AsString)) then case k of
            ofzISPTN: Text:=CdrGet.CodeName(f.AsString,[cdgBufAll]);
            ofzISPV: Text:=aIspv[Int2Ispv(f.AsInteger)];
          end;
        ofzWTN: Text:=CdrGet.CodeName(f.AsString,[cdgBufAll]);
        ofzSELISPSH: Text:=Str2SelIsp(f);
        ofzISPCALC: Text:=IspCalc(q);
      else if ofzvBeg then Text:=DelTrim(StrTran(aConcatTxt254(q,false,ofzvFld),CRLF,' '));
      end;
      break;
    end;(* for k *)
    if (not b) then begin
      for k:=1 to ofxCnt do with ProgFld[k] do if s=ofvCalc then begin
        b:=true;
        s:=ofvFld;
        if not q.FindField(s,f) then break;
        case k of
          ofxKOD: Text:=DM.ListGet.Codest(f.AsString,[cdgBufAll]);
          ofxKP: Text:=ProgInf(q).Abr;
          ofxTN:; //обрабатывается отдельно после цикла
          ofxKD: Text:=DM.DrvGet.CodeName(f.AsString,[cdgBufAll]);
          ofxSTATUS: Text:=aProgStat[stvLs,ProgStatList(f.AsInteger)];
          ofxRGN: Text:=DM.RgnGet.CodeName(f.AsString,[cdgBufAll]);
          ofxTerr: Text:=DM.TerrGet.CodeName(f.AsString,[cdgBufAll]);
          ofxFbVers: Text:=DM.MgFbVers.MenuName(f.AsString);
          ofxDLast: Text:=OurFormatDateTime(DLastFormat,f.AsFloat);
        end;
        break;
      end;(* for k *)
      if (not b) then begin
        t:=qZajMain.FldDuplicate(ProgFld[ofxTN].ofvFld);
        if (s='C'+t) then begin
          b:=true;
          if q.FindField(t,f) then Text:=CdrGet.CodeName(f.AsString,[cdgBufAll]);
        end;
        if (not b) then begin
          for k:=low(afz) to high(afz) do begin
            if (Sender<>afz[k].f) then continue;
//            b:=true;
            Prog.SaveInf(svi);
            try
              TFldList.BrDopCalc(qZajMain,adopz);
              v:=lsz.BrCalc(afz[k].f,adopz,afz[k].i,true);
            finally
              TRecDB.RestInf(svi);
            end;
            if (VarType(v)=varBoolean) then Text:=IfThen(v,'+')
            else begin
              try
                Text:=v;
              except
              end;
            end;
            break;
          end;
        end;
      end;
    end;
  end;
end;

procedure TMain.ZajSetFlt;
	function dPer(const nmf,nmflt: string): string;
  begin
    AddStack('TMain.ZajSetFlt.dPer',Self);
	  with ProgPswd.CurQuery do result:=DlmBetween(
      IfThen(not empty(Cdr['ZAJ'+nmflt+'1']),nmf+'>='+QQs(DateToString(Cdr['ZAJ'+nmflt+'1']))),
      IfThen(not empty(Cdr['ZAJ'+nmflt+'2']),nmf+'<'+QQs(DateToString(Cdr['ZAJ'+nmflt+'2']+1))),sAND);
    DelStack;
  end;
  procedure FindElseCreate(bq: TBrQuery; const aFieldName,aDispLabel: string);
  begin
    AddStack('TMain.ZajSetFlt.FindElseCreate',Self);
    if (bq.Fields.FindField(aFieldName)=nil) then bq.CreateField(aFieldName).DisplayLabel:=aDispLabel;
    DelStack;
  end;
var fl: boolean;
	s,t,sord: string;
  fd: TFltDef;
  i,j,k,l: longint;
  a: TArrFldVal;
  aoTo: TArrInt;
  lsf: TOrdList;
  p: POrdRec;
  r: TDWVidRec;
  tf: TField;
	aOrdFld: TArrStr;
begin
  AddStack('TMain.ZajSetFlt',Self);
  if not empty(Cdr[fCDR]) then begin
    s:=tPROG+'.'+fORG+'='+tORG+'.'+fORG+sAND+tZAJ+'.'+fORG+'='+tPROG+'.'+fORG+sAND+tZAJ+'.'+fProgCP+'='+tPROG+'.'+fProgCP;
    lsz.Clear;
    with Prog do for i:=0 to FldDef.Count-1 do lsz.Add(DWVarName(DWSToRec(i).Name));
    lsz.Fill;
    sord:=ProgGet.Mem2Ord(Cdr[sMemo+'ORDZAJ'],true);
    i:=ofzCnt+ofxCnt+lsz.Count;
    TTblChkOrdGet.GetOrd(aoTo,i,1,sord);
    lsf:=TOrdList.Create;
    try
      aOrdFld:=nil;
      SetLength(aOrdFld,ofzCnt+ofxCnt);
      j:=0;
      for i:=1 to ofzCnt do begin
        if (GetByte(sord,aoTo[j]+1)) then with aOrdFixz[i] do begin
          t:=ReplVar(ofzvSort,ofzvFld);
          if t<>'' then begin
            k:=aoTo[j];
            if (InRange(k,low(aOrdFld),high(aOrdFld))) then aOrdFld[k]:=ofzvTbl+'.'+t;
          end;
        end;
        Inc(j);
      end;
      for i:=1 to ofxCnt do begin
        if (GetByte(sord,aoTo[j]+1)) then begin
          k:=aoTo[j];
          with ProgFld[i] do if (InRange(k,low(aOrdFld),high(aOrdFld)))and(ofvFld<>'')
          then aOrdFld[k]:=ofvTbl+'.'+ofvFld;
        end;
        Inc(j);
      end;
      qZajMain.Arg[sO_LIST]:='';
      for i:=low(aOrdFld) to high(aOrdFld) do
        if (aOrdFld[i]<>'') then qZajMain.AddArgList(sO_LIST,aOrdFld[i]);
      if qZajMain.Arg[sO_LIST]='' then with aOrdFixz[ofzTD] do qZajMain.AddArgList(sO_LIST,ofzvTbl+'.'+ofzvSort);
      Zaj.AddCList(qZajMain,[],nil,[addclSet]); TRecDBDef.AddCList(Prog,qZajMain,false); Org.AddCList(qZajMain,[]);
      qZajMain.PartSelect(qZajMain.Arg[sTABLE],'',s+sAND+QryNone,qZajMain.Arg[sO_LIST],'',false);
      while qZajMain.FieldCount > 0 do qZajMain.Fields[0].Free;
      qZajMain.FieldDefs.Update;
      qZajMain.CreateStringField('SEL').DisplayLabel:=' ';
      qZajMain.CreateField(VarArrayOf([fRECNO,qZajMain.FldDuplicate(fRECNO)]));
      j:=0;
      for i:=1 to ofzCnt do begin
        if GetByte(sord,aoTo[j]+1) then with aOrdFixz[i] do begin
          p:=lsf.AddRec(aoTo[j]);
          p^.nmf:=ofzvFld;
          fl := ofzvCalc='';
          if ofzvFld='' then p^.f:=nil
          else begin
            p^.f:=qZajMain.CreateField(p^.nmf,fl); p^.f.DisplayLabel:=ZajFldName(i);
          end;
          if fl then p^.f.DisplayWidth:=aFixzLen[i]
          else begin
            p^.f:=qZajMain.CreateStringField(ofzvCalc,ZajFldName(i),aFixzLen[i]);
            p^.f.OnGetText:=ZajFldGetText;
          end;
          if i in [ofzTISPD,ofzTWD] then qZajMain.CreateField(p^.nmf+'1')
          else if ofzvBeg then nmf254CreateField(qZajMain,Zaj,ofzvFld);
        end;
        Inc(j);
      end;
      for i:=1 to ofxCnt do begin
        if (GetByte(sord,aoTo[j]+1)) then with ProgFld[i] do begin
          p:=lsf.AddRec(aoTo[j]);
          p^.nmf:=ofvFld;
          if p^.nmf=fCDR then p^.nmf:=qZajMain.FldDuplicate(fCDR);
          if (p^.nmf='') then p^.f:=nil
          else p^.f:=qZajMain.CreateField(p^.nmf,{not IsProgFldCalc[i]}ofvCalc='');
          t:=ofvName;
          StrTranSelf(t,UnDelim,' ',[rfReplaceAll,rfIgnoreCase]);
          if (p^.f<>nil) then p^.f.DisplayLabel:=t;
          if ({not IsProgFldCalc[i]}ofvCalc='') then p^.f.DisplayWidth:=ProgFldDispWidth[i]
          else begin
            p^.f:=qZajMain.CreateStringField(IfThen(p^.nmf<>'','C'+p^.nmf,ofvCalc),t,ProgFldDispWidth[i]);
            p^.f.OnGetText:=ZajFldGetText;
          end;
        end;
        Inc(j);
      end;
      for i:=1 to ofzCnt do
        if i in [ofzTD,ofzNZ,ofzDACT,ofzTISPD,ofzISPV,ofzWTN,ofzTWTN,ofzSELISPSH,ofzSET,ofzCNTISP]
        then FindElseCreate(qZajMain,aOrdFixz[i].ofzvFld,ZajFldName(i));
      FindElseCreate(qZajMain,'TDISPD','Поступила');
      TFldList.BrDop(qZajMain,Prog,adopz);
      lsz.Clear;
      with Prog do for i:=0 to FldDef.Count-1 do lsz.Add(DWVarName(DWSToRec(i).Name));
      lsz.BrCreate(qZajMain,adopz,[fldcNoAddCList]);
      SetLength(afz,lsz.Count);
      l:=0;
      for i:=0 to lsz.Count-1 do begin
        if (GetByte(sord,aoTo[j]+1)) then begin
          afz[l].f:=lsz.BrCreate(i,qZajMain);
          afz[l].f.OnGetText:=ZajFldGetText;
          afz[l].i:=i;
          p:=lsf.AddRec(aoTo[j]);
          p^.f:=afz[l].f;
          with Prog do for k:=0 to FldDef.Count-1 do begin
            r:=DWSToRec(k);
            if TrimUpper(r.Name)=TrimUpper(lsz[i]) then begin
              p^.nmf:=Prog.FixSt(aDWVidBeg[aFixTypeCod[r.SvType,r.AType]])+r.dwCod;
              break;
            end;
          end;
          Inc(l);
        end;
        Inc(j);
      end;
      SetLength(afz,l);
      for i:=0 to lsf.Count-1 do lsf.GetRec(i).f.Index:=i+1;
    finally
      lsf.Free;
    end;
    if lZajSelfNoisp then begin
      Cdr.GetAFieldValue(a); Cdr['ZAJISPN']:=ispnNoIsp; Cdr['ZAJCDR']:=fltOne; Cdr[sMemo+'ZAJCDR']:='';
      Cdr['ZAJTN']:=fltAll; Cdr['ZAJWTN']:=fltAll; Cdr['ZAJORG']:=fltAll; Cdr['ZAJPRG']:=fltAll;
      Cdr['ZAJSTATUS']:=''; Cdr['ZAJD1']:=ctod(''); Cdr['ZAJD2']:=ctod(''); Cdr['ZAJ']:=bFalse;
    end;
    fl := Cdr['ZAJISPN']<>ispnNoIsp; ProgPswd.GetQuery;
    if fl then begin
      t:=dPer('TISPD','ISPD');
      if t<>'' then IncAnd(s,BrackNoEmp(TispdIsNull+sOR+t));
    end
    else IncAnd(s,TispdIsNull);
    for i:=1 to ofzCnt do if i in [ofzTISPD,ofzISPV,ofzISPTN] then
      if qZajMain.FindField(aOrdFixz[i].ofzvCalc,tf) then tf.Visible:=fl;
    SetLength(fd,2+IfThen(fl,1));
    for i:=low(fd) to high(fd) do with fd[i] do begin
      g:=CdrGet; ln:=lCdrTN; def:=Cdr[fCDR]; orWhere:='';
    end;
    with fd[0] do begin
      im:='принял'; mim:='приняли'; flt:=fCDR; CopyFrom(anmf,tZAJ+'.'+fCDR);
    end;
    with fd[1] do begin
      im:='предполаг.исполнитель'; mim:='предполаг.исполнители'; flt:='WTN'; CopyFrom(anmf,tZAJ+'.WTN');
    end;
    if fl then with fd[2] do begin
      im:='исполнитель'; mim:='исполнители'; flt:='ITN'; orWhere:=TispdIsNull; CopyFrom(anmf,tZAJ+'.ISPTN');
    end;
    t:='';
    case TIspnList(Cdr['ZAJISPN']) of
      ispnIsp: begin
        DlmBetwSelf(s,sNOT+TispdIsNull,sAND); t:='только исполн.';
      end;
      ispnNoIsp: begin
        DlmBetwSelf(s,TispdIsNull,sAND); t:='только неисполн.';
      end;
    end;
    qSetWhere(brZaj,DlmBetween(s,dPer('TDISPD','D'),sAND),'ZAJ',Cdr['ORGKOD'],iZaj,pnZaj,@fd,
      [fCDR,'WTN'],[fORG],[fProgKP],zFiltered,lsrz);
    pnZaj.Header:=FRup(DlmBetween(pnZaj.Header,t,'; '));
    ProgPswd.FreeQuery;
    if lZajSelfNoisp then Cdr.SetAFieldValue(a);
    ZajIspCalc;
  end;
  DelStack;
end;

procedure TMain.ZajIspCalc;
  procedure FldVisible(q: TBrQuery);
  var f: TField;
  begin
    AddStack('TMain.ZajIspCalc.FldVisible',Self);
    if q.FindField(aOrdFixz[ofzISPCALC].ofzvCalc,f) then f.Visible:=lZajIspCalc;
    DelStack;
  end;
begin
  AddStack('TMain.ZajIspCalc',Self);
  FldVisible(qZajMain);
  if Assigned(ZajLs) then FldVisible(ZajLs.BrQuery1);
  DelStack;
end;

function TMain.deFltExec;
{$IFNDEF FLTPROG}
const a: array[1..4] of string = ('VAL5','VAL7','VAL8','VAL9');
var s,s1: string;
  i: longint;
  j: byte;
{$ENDIF}
begin
  AddStack('TMain.deFltExec',Self);
  SetLogVid(logvEditRec);
  with deFlt do begin
    NameWnd:=nmWnd;
    Param[0,deMask]:=ProgGet(fltFlt in Opt).GetMask(fltZaj in Opt);
{$IFDEF FLTPROG}
    Param[1,deNoVisible]:=BStr[fltOnlyOrd in Opt]; AssignGet(1,IfThen(fltZaj in Opt,TFltZajGet,TFltProgGet));
{$ELSE}
    s:=BStr[fltOnlyOrd in Opt];
    for i:=1 to Fields.Count-1 do Param[i,deNoVisible]:=s;
{$ENDIF}
    if deFltFld<>nmf then begin
{$IFDEF FLTPROG}
      Param[1,deNameRecFld]:=StrTran(Param[1,deNameRecFld],deFltFld,nmf);
{$ELSE}
	    for i:=1 to Fields.Count-1 do
      	if TrimUpper(Param[i,deNameRec])=TrimUpper(Cdr.NameRec)
        then Param[i,deNameRecFld]:=StrTran(Param[i,deNameRecFld],deFltFld,nmf);
{$ENDIF}
      deFltFld:=nmf;
    end;
{$IFNDEF FLTPROG}
    s:=BStr[not(fltZaj in Opt)];
    for j:=low(a) to high(a) do begin
      Param[a[j],deNoVisible]:=s; s1:=TrimUpper(DM.Rec.NameRec+'.'+a[j]);
      for i:=0 to Fields.Count-1 do
        if TrimUpper(Param[i,deRelation])=s1 then Param[i,deNoVisible]:=s;
    end;
{$ENDIF}
    lStatInv:=true; DM.Rec['ORD']:=ProgGet(fltFlt in Opt).Mem2Ord(Cdr[fmem],fltZaj in Opt);
    {NmProc.Text:=IfThen(not(fltOnlyOrd in Opt),TKeyLb.GetKeySt(K_Alt_F3,'','Создать основу',kmEdit)+CRLF)
      +TKeyLb.GetKeySt(K_Alt_F5,'','Загрузить из основы',kmEdit);}
    result:=Execute([fmem,longint(@Opt)],Capt).Saved;
  end;
  SetLogVid;
  DelStack;
end;

procedure StSetInterFlt(Sender: TStat; const Params: array of variant; var Aborted: boolean);
var v: variant;
	frProg,frZaj,fKO: TField;
  i,lr,ko: longint;
  q,qList: TMulQuery;
  mgkl: TMemGkList;
  s,vflt,nmrProg,nmrZaj: string;
  a: TArrStr;
  lsRec: TIntegerList;
  Inter: TInter;
begin
	AddStack('FMain.StSetInterFlt');
  q:=PointerVar(Params[0]);
  lsRec:=PointerVar(Params[1]);
  vflt:=Params[2];
  nmrProg:=Params[3];
  nmrZaj:=Params[4];
  Inter:=PointerVar(Params[5]);
  Prog.NewRec;
  lsRec.Clear;
  qList:=ProgPswd.GetQuery;
  ListSave;
  with ProgPswd.GetQuery do try
    s:='';
    case TFltList(Cdr[vflt+'ORG']) of
      fltOne: s:=tLIST+'.'+nmfbKOD+'='+QQi(Cdr[sMemo+vflt+'ORG'],DM.ListGet.LenCode);
      fltAny: begin
        s:=Cdr[sMemo+vflt+'ORG'];
        if s<>'' then begin
          ko:=LsArrDynamic(s,a,',');
          for i:=0 to ko-1 do QQiSelf(a[i],DM.ListGet.LenCode);
          s:=FldInList(tLIST+'.'+nmfbKOD,a,ko);
        end;
      end;
    end;
    mgkl:=nil;
    if LockBuhRead then try
      TRecDBDef.PartSelect(List,qList,s,tLIST+'.'+nmfbKO);
      fKO:=qList.FindField(nmfbKO);
      MulPar.Assign(q.MulPar);
      SetPart(q);
      Open;
      frProg:=FindField(nmrProg);
      frZaj:=FindField(nmrZaj);
      lr:=RecordCount;
      if lr>0 then begin
        mgkl:=TMemGkList.Create(List,qList);(* TMemGkList удаляется на закрытии TQuery, т.е. qList *)
        qList.First;
      end;
    finally
      UnlockMode('FBUH');
    end
    else begin
      Aborted:=true;
      fKo:=nil; lr:=0; frZaj:=nil; frProg:=nil; // Variable might not have been initialized
    end;
    if not Aborted then for i:=1 to lr do begin
      if Sender.SayStat(i/lr) then break;
      Prog.GetFromQuery(nil,true,nmrProg);
      ko:=Prog[fORG];
      if nmrZaj<>'' then Zaj.GetFromQuery(nil,true,nmrZaj);
      while not qList.Eof and (fKO.AsInteger<ko) do qList.Next;
      if not qList.Eof then
        while not qList.Bof and (fKO.AsInteger>ko) do qList.Prior;
      if qList.IsRecords then mgkl.GetFromQuery else List.NewRec;
      if not InterEval(Inter,v) then begin
        Aborted:=true; break;
      end;
      if Inter.error=E_NO then
        if not v then begin
          ko:=TField(IfThen(Assigned(frZaj),frZaj,frProg)).AsInteger; lsRec.Add(ko);
        end;
      Next;
    end;
  finally
    ProgPswd.FreeQuery; ProgPswd.FreeQuery; ListRest;
  end;
  if Aborted then lsRec.Clear;
  DelStack;
end;

procedure SetInterFlt(q: TMulQuery; lsRec: TIntegerList; const vflt,nmrProg,nmrZaj: string;
  Inter: TInter; lFiltered: boolean);
begin
  AddStack('FMain.SetInterFlt');
  if lFiltered then ShowStat('Установка фильтра для выборки',StSetInterFlt,
  	[LongInt(q),LongInt(lsRec),vflt,nmrProg,nmrZaj,LongInt(Inter)]);
  DelStack;
end;

procedure TMain.qZajBeforeOpen;
begin
	AddStack('TMain.qZajBeforeOpen',Self);
  SetInterFlt(qZajMain,lsrz,'ZAJ',qZajMain.FldDuplicate(fRECNO),fRECNO,iZaj,zFiltered);
  DelStack;
end;

procedure TMain.qZajMainFilterRecord;
begin
	AddStack('TMain.qZajMainFilterRecord',Self);
  Accept := lsrz.IndexOf(qZajMain.FindField(fRECNO).AsInteger)<0;
  DelStack;
end;

procedure TMain.qZajMainAfterOpen;
type TSectList = 0..2;
const aSay: array[TSectList] of string = ('ВСЕГО','исполнено','фактически');
var bm: TBookMark;
	i: longint;
	aCnt: array[TSectList] of longint;
  fTISPD,fISPV: TField;
begin
  AddStack('TMain.qZajMainAfterOpen',Self);
  with qZajMain do begin
    fTISPD:=FindField('TISPD'); fISPV:=FindField('ISPV');
  	DisableControls;
    bm:=GetBookMark;
    First;
    ZeroMemory(@aCnt,SizeOf(aCnt));
    while not Eof do begin
    	Inc(aCnt[0]);
      if not empty(fTISPD.AsString) then begin
	    	Inc(aCnt[1]);
        if not(TIspVidList(fISPV.AsInteger) in [ivMove,ivCancel,ivError]) then Inc(aCnt[2]);
      end;
    	Next;
    end;
    GotoBookMark(bm);
    FreeBookMark(bm);
    EnableControls;
    for i:=low(aCnt) to high(aCnt) do stZaj.SectLeft[i]:=aSay[i]+StrNum(': ',aCnt[i]);
  end;
  DelStack;
end;

procedure TMain.qMsgToBeforeOpen;
begin
  AddStack('TMain.qMsgToBeforeOpen',Self);
  MulQueryOwner(DataSet).Arg['now']:=DateToString(Now);
  DelStack;
end;

procedure TMain.pnMsgEnter(Sender: TObject);
begin
  AddStack('TMain.pnMsgEnter',Self);
  pnBrEnter(Sender);
  GotoProgSetKey('На программу','Перейти на программу, указанную в сообщении');
  KeyLb1.ReDrw;
  DelStack;
end;

procedure TMain.pnMsgExit(Sender: TObject);
begin
  AddStack('TMain.pnMsgExit',Self);
  GotoProgDelKey; pnBrExit(Sender);
  DelStack;
end;

procedure TMain.GotoProgSetKey;
begin
  AddStack('TMain.GotoProgSetKey',Self);
  KeyLb1.SetKey(K_Shift_1,txt,hint,GotoProgProcKey,'gotoprog',kmList);
  DelStack;
end;

procedure TMain.GotoProgDelKey;
begin
  AddStack('TMain.GotoProgDelKey',Self);
  KeyLb1.DelKey(K_All,'gotoprog');
  DelStack;
end;

procedure TMain.GotoProgProcKey;
var r: TRecDB;
  nmf: string;
  q: TBrQuery;
  ii: longint;
  pg: TProgGet;
  a: TArrStr;
begin
  AddStack('TMain.GotoProgProcKey',Self);
  q:=pointer(TBrowl(tw).Qry); q.GetListArg(sTABLE,a); r:=nil; //Не д.б.
  for ii:=low(a) to high(a) do
    if a[ii]=tPROG then begin
      r:=Prog; nmf:=''; break;
    end
    else if a[ii]=tMSG then begin
      r:=Msg; nmf:=fProgNP; break;
    end
    else if a[ii]=tZAJ then begin
      r:=Zaj; nmf:=fProgCP; break;
    end;
  r.GotoRec(q);
  if (r=Prog) or not empty(r[fORG]) or not empty(r[nmf]) then begin
    RbPage1.SetActivePage(tsOrg);
    if (r=Msg) and Empty(r[fORG]) and (TrimUpper(r[fMsgTNFROM])<>TrimUpper(DM.Rec[fCDR])) then begin
      ChangeETn;
      CdrUpd;
      DM.Rec[fCDR]:=r[fMsgTNFROM];
      ETn.Read;
      ExitETn;
    end;
    if r=Prog
      then ii:=Prog.RecNo
    else if Prog.Seek(Prog.TblFldName(fORG)+'='+Vtos(r[fORG])+sAND+Prog.TblFldName(nmf)+'='+QQs(r[nmf]))
      then ii:=Prog.RecNo
    else ii:=-1;
    EKod.VarValue:=ListKod(r);
    EProg.SetFocus;
    pg:=ProgGet(false);
    q:=pg.Qry;
    q.DisableControls;
    try
      q.Close;
      q.Open;
      q.First;
      if (ii<>-1) then begin
        while not q.Eof and (pg.fdef.fqRECNO.AsInteger<>ii) do q.Next;
      end;
    finally
      q.EnableControls;
    end;
  end;
  DelStack;
end;

procedure TMain.IsMsgCdr;
var b: boolean;
begin
  AddStack('TMain.IsMsgCdr',Self);
  if not ETn.Enabled then with qMsgCdr do begin
    if PartCount0(GetList([tZAJ,tPROG]),
      ArrayAsList([tZAJ+'.'+fORG+'='+tPROG+'.'+fORG,tZAJ+'.'+fProgCP+'='+tPROG+'.'+fProgCP,
      tPROG+'.'+fCDR+'='+QQs(DM.Rec[fCDR]),QQNull('WTN',''),FldIsTrue('SEL',false),TispdIsNull],sAND))
    then b := not PartCount0(tZAJ,ArrayAsList(['WTN='+QQs(DM.Rec[fCDR]),FldIsTrue('SEL',false),TispdIsNull],sAND))
    else b:=true;
    SetHL(hlZaj,b);
    SetHL(hlMsgTo,not PartCount0(tMSG,fMsgTNTO+'='+QQs(DM.Rec[fCDR])+sAND+FldIsTrue('DELTO',false)+sAND
      +FldInList('SEL',[Vtos(true),QQs(MSG_DONE)],NegDef,[flsNot])+sAND+'TD1<='+QQs(DateToString(NowDouble))));
    SetHL(hlCng,not PartCount0(tCNG,fCDR+'='+QQs(DM.Rec[fCDR])+sAND+FldIsTrue('SEL')));
    SetHL(hlSftp,GetSftpBlinkState(DM.Rec[fCDR]));
    PartSelect(tCDR,'STATUS',fCDR+'='+QQs(DM.Rec[fCDR]));
    SetETnStatus(StrToIntDef(Trim(IsRecordsAsString),byte(low(aCdrStat))),true);
  end;
  ApplTitleBlink;
  DelStack;
end;

procedure TMain.SetHL;
var s: string;
begin
  AddStack('TMain.SetHL',Self);
  with aHL[i] do begin
    if o is TFldEdit then s:=TFldEdit(o).SayCaption else s:=TTabSheet(o).Caption;
    hl:=ApplTitle.SetActive(s,not ETn.Enabled and Value);
  end;
  DelStack;
end;

procedure TMain.ApplTitleBlink;
var tsAct: TTabSheet;
  i: THLList;
  Value: boolean;
begin
  AddStack('TMain.ApplTitleBlink',Self);
  tsAct:=RbPage1.ActivePage;
  if tsAct=FTsHiding then tsAct:=nil;
  for i:=low(aHL) to high(aHL) do with aHL[i] do begin
    Value:=ReDef and hl;
    if o is TFldEdit then TFldEdit(o).SetReadOnly(not Value)
    else if o is TTabSheet then TTabSheet(o).Highlighted := Value or (o=tsAct);
  end;
  DelStack;
end;

// Документы
function TMain.brDocGrayCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
  Column: TColumn; State: TGridDrawState): Boolean;
begin
	AddStack('TMain.brDocGrayCell',Self);
  result:=not empty(qDocTN.AsString);
  DelStack;
end;

procedure TMain.brDocBrowlKey(key: Integer; tw: TWinControl);
var s: string;
	fl: boolean;
begin
	AddStack('TMain.brDocBrowlKey',Self);
  if qDoc.CanEdit(Key) then if LockRead then try
    case Key of
      K_F3: TCngNum.GetNewNum('Новый номер документа',brDoc,Doc,fDOC,
        [tDOC,tDCM,tDOCPRM],[],'',DocNewNum);
      K_F4,K_F7: begin
        s:=brDoc.FieldSeek.AsString;
        if brDoc.AppRec('Добавить документ',Doc,deDoc,IfThen(Key),'',fDOC) and (Key=K_F4) then begin
          CopyFileOpt(DocName(false,s),DocName);
          UpdateDBDcm(DocName);
        end;
      end;
      K_F5: brDoc.EditRec('Редактировать документ',Doc,deDoc,fDOC);
      K_F8: begin
        s:=brDoc.FieldSeek.AsString;
        if brDoc.DelAsk(Doc) then begin
          DBDcm.DelRec(fDCM+'='+QQs(DocName(false,s)));
          ProgPswd.DeleteTable(tDOCPRM,fFDTG+'='+QQs(DocName(true,s))); 
          for fl:=false to true do DelFileAtr(ExeDir+DocName(fl,s));
        end;
      end;
      K_Enter: begin
        Doc.GotoRec(qDocRECNO); //DcmModified:=false;
        FdpUser(Doc[fNAME],[DocName,DocName(true)],nil,DocSetDcmModified,[fdoSaveDcm,fdoSayStat]);
        //if DcmModified then UpdateDBDcm(DocName);
      end;
      K_Ctrl_F5: if not empty(qDocTN.AsString) then begin
        SetLogVid(logvEditRec);
        if Ask(['Открыть доступ другим пользователям',
        'к документу '+brDoc.FieldSeek.AsString+'. '+TrimRight(qDocNAME.AsString)+' ?']) then begin
          Doc.GotoRec(qDocRECNO); Doc[fCDR]:=''; Doc.UpdateRec(true);
          brDoc.BrUpdate;
        end;
        SetLogVid;
      end;
    end;
  finally
    UnLockRead;
  end;
  DelStack;
end;

class procedure TMain.DocNewNum;
var fl: boolean;
	s: string;
begin
	AddStack('TMain.DocNewNum');
  for fl:=false to true do begin
  	s:=DocName(fl,oldnum);
    if MyFileExists(ExeDir+s) then begin
      result:=CopyFileOpt(ExeDir+s,ExeDir+DocName(fl));
      if not result then break;
      DelFileAtr(ExeDir+s);
    end;
  end;
  if result then begin
    DBDcm.UpdateTable([fDCM],[QQs(DocName)],fDCM+'='+QQs(DocName(false,oldnum)));
    ProgPswd.UpdateTable(tDOCPRM,[fFDTG],[QQs(DocName(true))],fFDTG+'='+QQs(DocName(true,oldnum)));
  end;
  DelStack;
end;

procedure TMain.DocSetDcmModified;
begin
  AddStack('TMain.DocSetDcmModified',Self);
  if CurFdp.DcmModified then begin
  	//DcmModified:=true;
  	if empty(Doc[fCDR]) then begin
      SetLogVid(logvEditRec); Doc[fCDR]:=Cdr[fCDR]; Doc.UpdateRec(true);
      SetLogVid; brDoc.BrUpdate;
    end;
  end;
  DelStack;
end;

procedure TMain.deDocFldExit(Sender: TObject);
begin
	AddStack('TMain.deDocFldExit',Self);
  SpaceStrSelf(Sender,fDOC);
  DelStack;
end;

function TMain.deDocFldCheck(Sender: TObject): Boolean;
begin
	AddStack('TMain.deDocFldCheck',Self);
  KodCheck(Sender,fDOC,result);
  DelStack;
end;

procedure TMain.pnOfisEnter(Sender: TObject);
begin
	AddStack('TMain.pnOfisEnter',Self);
  TCdrLs.ProcBeforeShow(qOfis,KeyLb1); pnBrEnter(Sender); TCdrLs.ProcShow(qOfis,afCdr);
  DelStack;
end;

procedure TMain.pnOfisExit(Sender: TObject);
begin
	AddStack('TMain.pnOfisExit',Self);
  pnBrExit(Sender);
  TCdrLs.ProcHide(afCdr,KeyLb1);
  DelStack;
end;

procedure TMain.pnBrEnter(Sender: TObject);
begin
	AddStack('TMain.pnBrEnter',Self);
  TBrowl(TRbPanel(Sender).Controls[0]).FormShow(Self);
  DelStack;
end;

procedure TMain.pnBrExit(Sender: TObject);
begin
	AddStack('TMain.pnBrExit',Self);
  TBrowl(TRbPanel(Sender).Controls[0]).FormHide(Self);
  DelStack;
end;

// Изменения
procedure TMain.SetCngFlt;
begin
  AddStack('TMain.SetCngFlt',Self);
  with KeyLb1 do begin
    if Cdr['CNGFLT']=0 then begin
      SetKey(K_F2,'','Список пользователей, следящих за данным изменением',brCngBrowlKey,'cnged',kmList);
      SetKey(K_F3,'Сменить','Сменить номер',brCngBrowlKey,'cnged',kmList);
      SetKey(K_F4,'Скопировать','',brCngBrowlKey,'cnged',kmList);
      SetKey(K_F5,'Редактировать','',brCngBrowlKey,'cnged',kmList);
      SetKey(K_F7,'Добавить','',brCngBrowlKey,'cnged',kmList);
      SetKey(K_F8,'Удалить','',brCngBrowlKey,'cnged',kmList);
      SetKeys([K_Space,K_Ins],'Отметить','Следить/нет за данным изменением',brCngBrowlKey,'cnged',kmList);
      SetKey(K_Plus,'','Следить за всеми изменениями',brCngBrowlKey,'cnged',kmList);
      SetKey(K_Minus,'','Не следить за изменениями',brCngBrowlKey,'cnged',kmList);
      qCng.BeforeOpen:=qCngBeforeOpen;
      qCng.PartSelect(tCNGV,[fCNGV,fNAME,fRECNO,'DT','TPVIEW'],'',qCng.Arg[sO_LIST],'',false);
      FreeAndNil(qCngSEL);
    end
    else begin
      DelKey(K_All,'cnged'); qCng.BeforeOpen:=nil;
      qCng.PartSelect(qCng.GetList([tCNGV,tCNG]),[fCNGV,fNAME,fRECNO,'DT','TPVIEW','SEL'],
        fCDR+'='+QQs(Cdr[fCDR])+sAND+tCNG+'.'+fCNGV+'='+tCNGV+'.'+fCNGV,qCng.Arg[sO_LIST],'',false);
      if not Assigned(qCngSEL) then with qCng,FieldDefs do begin
        Update; qCngSEL:=CreateStringField('SEL'); qCngSEL.Visible:=false;
      end;
    end;
    qCngAfterScroll(nil);
  end;
  DelStack;
end;

procedure TMain.qCngBeforeOpen;
begin
	AddStack('TMain.qCngBeforeOpen',Self);
  with ProgPswd.GetQuery do begin
    PartSelect(tCNG,[fCNGV,'SEL'],fCDR+'='+QQs(Cdr[fCDR])); lsCng.Clear;
    while not Eof do begin
      lsCng.Add(Fields[0].AsString,pointer(StrToBoolean(Fields[1]))); Next;
    end;
    ProgPswd.FreeQuery;
  end;
  DelStack;
end;

procedure TMain.qCngAfterScroll;
begin
  AddStack('TMain.qCngAfterScroll',Self);
  with KeyLb1 do begin
    if qCngTPVIEW.AsInteger=byte(tpvModel) then begin
      SetKey(K_Shift_F3,'Параметры основ','Параметры для просмотра основ',brCngBrowlKey,'cngmd',kmList);
      DelKey(K_All,'cngnomd');
    end
    else begin
      SetKey(K_Ctrl_F4,'','Скопировать изменённые файлы и папки в указанную папку',brCngBrowlKey,'cngnomd',kmList);
      DelKey(K_All,'cngmd');
    end;
    ReDrw;
  end;
  DelStack;
end;

procedure TMain.qCngCalcFields;
var fl: boolean;
	i: longint;
begin
	AddStack('TMain.qCngCalcFields',Self);
  if Assigned(qCngSel)
    then fl:=StrToBoolean(qCngSEL)
  else if not lsCng.BoolObjFind(Int0(brCng.FieldSeek.AsString),fl)
    then fl:=false;
  qCngCNG.AsBoolean:=fl; i:=qCngDT.AsInteger;
  if i>0 then qCngCDT.AsString:=FormatDateTime('dd/mm/yy hh:mm',FileDateToDateTime(i));
  DelStack;
end;

procedure TMain.brCngDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
	AddStack('TMain.brCngDrawColumnCell',Self);
  brCng.bmCheckPaint(Rect,Column);
  DelStack;
end;

function TMain.brCngGrayCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState): Boolean;
begin
	AddStack('TMain.brCngGrayCell',Self);
  if Cdr['CNGFLT']=0 then result:=lsCng.IndexOf(Int0(brCng.FieldSeek.AsString))<0 else result:=false;
  DelStack;
end;

procedure TMain.pnCngEnter(Sender: TObject);
begin
	AddStack('TMain.pnCngEnter',Self);
  qCng.AfterScroll:=qCngAfterScroll; SetCngFlt; pnBrEnter(Sender);
  DelStack;
end;

procedure TMain.pnCngExit(Sender: TObject);
begin
	AddStack('TMain.pnCngExit',Self);
  qCng.AfterScroll:=nil; KeyLb1.DelKey(K_All,'cnged'); KeyLb1.DelKey(K_All,'cngmd'); KeyLb1.DelKey(K_All,'cngnomd');
  pnBrExit(Sender);
  DelStack;
end;

procedure PrCopyFile(const av: array of variant; const sr: TSearchRec; var lDone: boolean);
begin
  AddStack('FMain.PrCopyFile');
  lDone:=CopyFileOpt(av[0]+sr.Name,av[1]+sr.Name,[cfMsg]);
  DelStack;
end;

const aCngMdTbl: array[1..3] of string = (tMDF,tMDV,tMDT);

procedure TMain.brCngBrowlKey(key: Integer; tw: TWinControl);
  procedure LogWrite(const ctn: string = ''; const msgend: string = '');
  var tn: string;
  begin
    AddStack('TMain.brCngBrowlKey.LogWrite',Self);
    if ctn='' then tn:=Cdr[fCDR] else tn:=ctn;
    ProgPswd.LogWrite(tCNG,DlmBetween([GetPrimFld(tCNG,fCNGV)+':"'+brCng.FieldSeek.AsString+'"',
      GetPrimFld(tCNG,fCDR)+':"'+tn+'"',msgend],LogDlm));
    DelStack;
  end;
var ii,tr,i,l: longint;
	s,wkc,path,nmf: string;
  ls: TStringList;
  q: TMulQuery;
  fl,fl1: boolean;
  av: TArrVar;
  a: TArrStr;
  tpv: TTpView;
begin
	AddStack('TMain.brCngBrowlKey',Self);
  if qCng.CanEdit(Key,[K_F7,K_F12],false) then if LockRead then try
    case Key of
      K_F2: with ProgPswd.GetQuery do begin
        SetLogVid(logvDelRec); ls:=SortStrListCreate;
        try
          wkc:=fCNGV+'='+brCng.QQs; PartSelect(tCNG,[fCDR],wkc); SaveTo(ls);
          s:=StrTran(ls.Text,CRLF,',');
          if TCdrLs.Execute(s,false,'Пользователи, следящие за изменением "'+Trim(qCngNAME.AsString)+'"') then begin
            ls.Sorted:=false; ls.Text:=StrTran(s,',',CRLF); ls.Sorted:=true; First; q:=ProgPswd.GetQuery;
            while not Eof do begin
              s:=Fields[0].AsString;
              if not FindDel(ls,s) then begin
                q.DeleteTable(tCNG,wkc+sAND+fCDR+'='+QQs(s)); LogWrite(s);
              end;
              Next;
            end;
            ProgPswd.CngLogVid(logvAppRec);
            for i:=0 to ls.Count-1 do begin
              q.InsertTable(tCNG,[fCNGV,fCDR,'SEL'],[brCng.QQs,QQs(ls[i]),false]);
              LogWrite(ls[i]);
            end;
            ProgPswd.FreeQuery; brCng.BrUpdate;
          end;
        finally
          ls.Free; ProgPswd.FreeQuery;
        end;
        SetLogVid;
      end;
      K_F3: TCngNum.GetNewNum('Новый номер изменения',brCng,Cngv,fCNGV,[tCNGV,tCNG],[],'',CngNewNum);
      K_F4,K_F7: brCng.AppRec('Добавление изменения',Cngv,deCng,IfThen(Key),'',fCNGV);
      K_F5: brCng.EditRec('Редактирование изменения',Cngv,deCng,fCNGV);
      K_F8: with ProgPswd.GetQuery do begin
        PartSelect(tCNG,[fCDR],fCNGV+'='+brCng.QQs);
        s:=IfThen(not Eof,'Существуют пользователи, следящие за данным изменением.'+CRLF
          +'Вы уверены, что нужно удалить ?');
        if brCng.DelAsk(Cngv,nil,s) then begin
          if s<>'' then ExecPart(sDW_TABLE);
          for i:=low(aCngMdTbl) to high(aCngMdTbl) do begin
            Arg[sTABLE]:=aCngMdTbl[i]; ExecPart(sDW_TABLE);
          end;
        end;
        ProgPswd.FreeQuery;
      end;
      K_F12: begin
        SetLogVid(logvEditRec); ii:=qCngRECNO.AsInteger; tr:=brCng.Row;
        Cdr['CNGFLT']:=1-Cdr['CNGFLT']; Cdr.UpdateRec(true);
        SetCngFlt; brCng.BrUpdate(tr,ii); KeyLb1.ReDrw;
        SetLogVid;
      end;
      K_Enter,K_Ctrl_F5: begin
        SetLogVid(logvEditRec);
        Cngv.GotoRec(qCngRECNO); tpv:=Cngv['TPVIEW']; lCngEdit := Key=K_Ctrl_F5;
        if tpv=tpvModel then begin
          MDModified:=false;
          lsMd:=TIntegerList.Create; lsgv:=TIntegerList.Create;
          try
            MdExec(nil,true);
          finally
            lsMd.Free; lsgv.Free;
          end;
          if MDModified
          then ProgPswd.UpdateTable(tCNG,['SEL'],[true],fCNGV+'='+QQs(Cngv[fCNGV])+sAND+fCDR+'<>'+QQs(Cdr[fCDR]));
        end
        else begin
          nmf:=Trim(Cngv['CMD']);
          if nmf='' then begin
            nmf:=Trim(DlmCopy(Cngv[sMemo+'F'],2,1,dlmMemF));
            if (nmf<>'') and (tpv=tpvExec) then IncL(nmf,'"','"');
          end;
          if nmf<>'' then begin
            fl:=true;
            if not lCngEdit then begin
              s:=Trim(Cngv[sMemo+'TMP']);
              if s<>'' then begin
                l:=LsArrDynamic(s,a,';')-1; s:=ExeDir+'TMP'+PathDelim; fl:=ForceDirMsg(s);
                if fl then begin
                  fl1 := nmf[1]='"';
                  if fl1 then CopySelf(nmf,2,Length(nmf)-2);
                  nmf:=s+ExtractFileName(nmf);
                  if fl1 then IncL(nmf,'"','"');
                  for i:=0 to l do DelMaskFiles(s+ExtractFileName(a[i]));
                  for i:=0 to l do if not MaskFilesProc(a[i],PrCopyFile,[ExtractFilePath(a[i]),s]) then begin
                    fl:=false; break;
                  end;
                end;
              end;
            end;
            if fl then case tpv of
              tpvExec: begin
                if nmf[1]='"' then begin
                  Delete(nmf,1,1); i:=Pos('"',nmf);
                end
                else i:=Pos(' ',nmf);
                if i=0 then begin
                  path:=nmf; nmf:='';
                end
                else begin
                  path:=LeftStr(nmf,i-1); nmf:=Trim(Copy(nmf,i+1,MaxInt));
                end;
                ShellExecute(0,nil,PChar(path),PChar(nmf),PChar(ExtractFilePath(path)),SW_SHOW);
                if not StrToBoolean(Cngv['READONLY']) then LogWrite('','изменено');
              end;
              tpvDoc: FdpUser(Cngv[fNAME],['',nmf]);
            else
              s:=GetStrFile(nmf);
              if tpv=tpvDos then DosToWinSelf(s);
              CopyFromVArr(av,[ExtractFilePath(nmf),ExtractFileName(nmf),s]);
              if EdTextExec(Trim(Cngv[fNAME]),s,'',nil,
              IfThen(not lCngEdit,edtxtReadOnly)+IfThen(not lCngEdit,edtxtWordWrap),edtpText,Length(s),0,'',0,nil,'',
              PrEditIfError,@av,nmf) then
                if lCngEdit then begin
                  if tpv=tpvDos then WinToDosSelf(s);
                  SetStrFile(nmf,s); LogWrite('','изменено');
                end;
            end;
          end;
        end;
        if qCngCNG.AsBoolean then begin
          ProgPswd.UpdateTable(tCNG,['SEL'],[false],fCNGV+'='+QQs(Cngv[fCNGV])+sAND+fCDR+'='+Cdr[fCDR]);
          LogWrite('','прочитано'); brCng.BrUpdate; IsMsgCdr;
        end;
        SetLogVid;
      end;
      K_Space,K_Ins: begin
        with ProgPswd.GetQuery do if lsCng.IndexOf(Int0(brCng.FieldSeek.AsString))<0 then begin
          SetLogVid(logvAppRec);
          InsertTable(tCNG,[fCNGV,fCDR,'SEL'],[brCng.QQs,QQs(Cdr[fCDR]),false]);
        end
        else begin
          SetLogVid(logvDelRec);
          DeleteTable(tCNG,fCNGV+'='+brCng.QQs+sAND+fCDR+'='+QQs(Cdr[fCDR]));
        end;
        LogWrite; SetLogVid; ProgPswd.FreeQuery; brCng.BrUpdate;
        if Key=K_Ins then qCng.Next;
      end;
      K_Plus: begin
        SetLogVid(logvAppRec);
        if Ask(['Следить за всеми изменениями ?']) then with qCng do begin
          ProgPswd.GetQuery;
          ii:=qCngRECNO.AsInteger; tr:=brCng.Row; DisableControls; First;
          while not Eof do begin
            if lsCng.IndexOf(Int0(brCng.FieldSeek.AsString))<0 then begin
              ProgPswd.CurQuery.InsertTable(tCNG,[fCNGV,fCDR,'SEL'],[brCng.QQs,QQs(Cdr[fCDR]),false]);
              LogWrite;
            end;
            Next;
          end;
          ProgPswd.FreeQuery;
          brCng.BrUpdate(tr,ii);
          EnableControls;
        end;
        SetLogVid;
      end;
      K_Minus: begin
        SetLogVid(logvDelRec);
        if Ask(['Не следить за изменениями ?']) then begin
          ProgPswd.DeleteTable(tCNG,fCDR+'='+QQs(Cdr[fCDR]));
          with qCng do begin
            ii:=qCngRECNO.AsInteger; tr:=brCng.Row; DisableControls; First;
            while not Eof do begin
              if lsCng.IndexOf(Int0(brCng.FieldSeek.AsString))>=0 then LogWrite;
              Next;
            end;
            brCng.BrUpdate(tr,ii); EnableControls;
          end;
        end;
        SetLogVid;
      end;
      K_Ctrl_F4: begin
        Cngv.GotoRec(qCngRECNO); path:=Trim(Cngv['COPYDIR']);
        if path<>'' then if Ask(['Скопировать изменённые файлы и папки','в папку '+path+' ?'])
        then CngCopyDir(Cngv[sMemo+'F'],path,Cngv['DIRCOPY']);
      end;
      K_Shift_F3: begin
        Cngv.GotoRec(qCngRECNO); MDFltExec(true);
      end;
    end;
  finally
    UnLockRead;
  end;
  DelStack;
end;

class procedure TMain.PrEditIfError;
const MaxBuf = 100;
var Buf: array[0..MaxBuf] of char;
  path: string;
  pav: PArrVar;
begin
  AddStack('TMain.PrEditIfError');
  pav:=PArrVar(Sender);
  path:=pav^[0];
  if Cngv['TPVIEW']=tpvDos then begin
    GetTempPath(MaxBuf,Buf);
    path:=CorrDir(string(Buf));
    SetStrFile(path+pav^[1],pav^[2]);
  end;
  ShellExecute(0,nil,'WORDPAD',PChar(path+string(pav^[1])),PChar(path),SW_SHOW);
  DelStack;
end;

class procedure TMain.CngNewNum;
  procedure Upd(const tbl: string);
  begin
  	AddStack('TMain.CngNewNum.Upd');
    ProgPswd.CurQuery.UpdateTable(tbl,[fCNGV],[QQs(Cngv[fCNGV])],fCNGV+'='+QQs(oldnum));
    DelStack;
  end;
var i: byte;
begin
	AddStack('TMain.CngNewNum');
  ProgPswd.GetQuery; Upd(tCNG);
  for i:=low(aCngMdTbl) to high(aCngMdTbl) do Upd(aCngMdTbl[i]);
  ProgPswd.FreeQuery;
  DelStack;
end;

procedure TMain.deCngFrmShow(Sender: TObject);
var a: array[1..2] of string;
begin
	AddStack('TMain.deCngFrmShow',Self);
  LsArrFill(Cngv[sMemo+'F'],a,dlmMemF);
  DM.Rec['CNGD']:=a[1]; DM.Rec['CNGF']:=a[2];
  DelStack;
end;

procedure TMain.deCngFldChange(Sender: TObject; const OldVal: Variant;
  FromShow: Boolean);
var tpv: TTpView;
  tf: TFldEdit;
  s: string;
begin
  AddStack('TMain.deCngFldChange',Self);
  with TFldEdit(Sender),deCng do if AnsiMatchText(NameRecFld,['TPVIEW','COPYDIR']) then begin
    tpv:=Cngv['TPVIEW'];
    if NameRecFld='TPVIEW' then begin
      SetReadOnly('READONLY',tpv<>tpvExec);
      SetReadOnly(fMDP,tpv<>tpvModel);
      SetReadOnly('VAL1',tpv=tpvModel);
      SetReadOnly('CNGD',tpv=tpvModel);
      SetReadOnly('CNGF',tpv=tpvModel);
      SetReadOnly('CMD',tpv=tpvModel);
      SetReadOnly(sMemo+'TMP',tpv=tpvModel);
      tf:=FldEdit['COPYDIR']; s:=tf.SayCaption;
      tf.SayCaption:=IfThen(tpv=tpvModel,'Папка с основами','Копировать изменённые файлы и папки в папку');
      tf.Mask:=IfThen(tpv=tpvModel,'Папка с основами','Папка для копирования изменённых файлов');
      if s<>tf.SayCaption then MainRebuild;
    end;
    s:=Cngv['COPYDIR'];
    SetReadOnly('DIRCOPY',(tpv=tpvModel) or empty(s));
    tf:=FldEdit['LASTCNG'];
    if tpv=tpvModel then tf.Mask:='Основа общих версий'+UnDelim+CorrDir(s)+DirModels+SchemDM.mgLastCng.Prefix+PathDelim;
    tf.SetReadOnly(tpv<>tpvModel);
  end;
  DelStack;
end;

procedure TMain.deCngFldExit(Sender: TObject);
begin
	AddStack('TMain.deCngFldExit',Self);
  SpaceStrSelf(Sender,fCNGV);
  DelStack;
end;

function TMain.deCngFldCheck(Sender: TObject): Boolean;
var p: TFileName;
  a: array[0..MAX_PATH] of char;
begin
	AddStack('TMain.deCngFldCheck',Self);
  if KodCheck(Sender,fCNGV,result) then with TFldEdit(Sender) do
    if NameRecFld='DIRCOPY' then begin
      if StrToBoolean(VarValue) then begin
        p:=CorrDir(Cngv['COPYDIR']); result := CorrDir(ExtractFileDrive(p))<>ExtractFilePath(p);
        if result then begin
          GetWindowsDirectory(a,SizeOf(a)); result:=not AnsiStartsText(StrPas(a),p);
          if not result then meserr('Не допускается точная копия в папки Windows.');
        end
        else meserr('Не допускается точная копия в корневой каталог.');
      end;
    end
    else if Cngv['TPVIEW']=tpvModel then NoEmpCheck(Sender,'COPYDIR',result);
  DelStack;
end;

function TMain.deCngPnlValid(Sender: TObject): Boolean;
begin
	AddStack('TMain.deCngPnlValid',Self);
  LogFields.AddRecFld(Cngv,sMemo+'F');
  if Cngv['TPVIEW']=tpvModel then begin
    DM.Rec['CNGD']:=CorrDir(Cngv['COPYDIR'])+DirModel; DM.Rec['CNGF']:='';
  end;
  Cngv[sMemo+'F']:=Trim(DM.Rec['CNGD'])+dlmMemF+Trim(DM.Rec['CNGF']); result:=true;
  DelStack;
end;

procedure TMain.CngGetClick(Sender: TObject);
begin
	AddStack('TMain.CngGetClick',Self);
  TProgCopy.DirAddClick(Sender,IfThen(TFldEdit(Sender).curget=CngFileGet,dlgCng));
  DelStack;
end;

procedure TMain.tsSftpShow(Sender: TObject);
begin
  inherited;
  RefreshSftpSb;
end;

procedure TMain.RefreshSftpSb;
var b: boolean;
begin
  b:=false;
  FillSftpSb(IfThen(not FShowAllAcc,string(DM.Rec[fCDR])),sbSftp,@b,FSftpSortCol);
  SetHL(hlSftp,b); ApplTitleBlink;
end;

procedure TMain.SetSftpShowModeKey;
var s: string;
begin
  KeyLb1.DelKey(K_CTRL_A,KEYLBSFTP);
  s:=IfThen(FShowAllAcc,'Показать только свои','Показать все');
  KeyLb1.SetKey(K_CTRL_A,s,s+' учётные записи',SftpKeyProc,KEYLBSFTP,kmList);
  if (bReDrw) then KeyLb1.ReDrw;
end;

procedure TMain.sbSftpEnter(Sender: TObject);
begin
  inherited;
  KeyLb1.SetKey(K_ENTER,'Просмотр','',SftpKeyProc,KEYLBSFTP,kmList);
  KeyLb1.SetKey(K_CTRL_R,'Обновить список','',SftpKeyProc,KEYLBSFTP,kmList);
  KeyLb1.SetKey(K_F5,'Редактировать','',SftpKeyProc,KEYLBSFTP,kmList);
  KeyLb1.SetKey(K_F7,'Добавить','',SftpKeyProc,KEYLBSFTP,kmList);
  KeyLb1.SetKey(K_CTRL_ENTER,'Отправить программу','Отправить программу sftp',SftpKeyProc,KEYLBSFTP,kmList);
  KeyLb1.SetKey(K_CTRL_B,'Отложенные','Применить отложенные настройки',SftpKeyProc,KEYLBSFTP,kmList);
  KeyLb1.SetKey(K_CTRL_D,'Файл паролей','Сформировать файл паролей для сервера',SftpKeyProc,KEYLBSFTP,kmList);
  KeyLb1.SetKey(K_CTRL_E,'','Переход на папку и редактирование протокола смены компьютера',SftpKeyProc,KEYLBSFTP,kmList);
  SetSftpShowModeKey(false);
  KeyLb1.ReDrw;
end;

procedure TMain.sbSftpExit(Sender: TObject);
begin
  inherited;
  KeyLb1.DelKey(K_ALL,KEYLBSFTP);
  KeyLb1.ReDrw;
end;

procedure TMain.SftpKeyProc;
var p: TPoint;
  r: TDefMenuShow;
begin
  if LockRead then try
    case key of
      K_F5,K_F7: begin
        if (AccDialog(key,sbSftp.Cells[SFTPSBCOL_ID,sbSftp.Row])) then begin
          RefreshSftpSb;
        end;
      end;
      K_ENTER: begin
        SftpFilesExec(sbSftp.Cells[SFTPSBCOL_PATH,sbSftp.Row],GlobDIRLAST,
          sbSftp.Cells[SFTPSBCOL_NAME,sbSftp.Row],GlobLASTCNT,GlobLASTDAY);
        RefreshSftpSb;
      end;
      K_CTRL_ENTER: begin
        SendSmailFtp(sbSftp.Cells[SFTPSBCOL_ID,sbSftp.Row]);
      end;
      K_CTRL_A: begin
        NotD(FShowAllAcc);
        SetSftpShowModeKey(true);
        RefreshSftpSb;
      end;
      K_CTRL_B: begin
        ApplyPendingSettings;
        RefreshSftpSb;
      end;
      K_CTRL_E: with sbSftp do begin
        p:=ClientOrigin; r.lRect:=true; r.r:=CellRect(LeftCol,Row); OffsetRect(r.r,p.X,p.Y);
        dmSftpExec(@r);
      end;
      K_CTRL_D: begin
        MakeAccountsFile;
      end;
      K_CTRL_R: begin
        RefreshSftpSb;
      end;
    end;
  finally
    UnLockRead;
  end;
end;

procedure TMain.dmSftpExec;
var nc,nr,key: longint;
  s: TFileName;
  t: string;
  bp,bf: TRbmKeyOptions;
  p: TPoint;
begin
  AddStack('TMain.dmSftpExec',Self);
  with sbSftp do begin
    p:=ScreenToClient(IfThen(pShow.lRect,pShow.r.TopLeft,pShow.p)); MouseToCell(p.X,p.Y,nc,nr);
  end;
  bp:=[]; bf:=[];
  if InRange(nr,sbSftp.FixedRows,sbSftp.RowCount-1) and InRange(nc,0,sbSftp.ColCount-1) then begin
    t:=sbSftp.Cells[SFTPSBCOL_PATH,nr];
    SetSet(bp,rmkNoEval,not DirectoryExists(t));
    SetSet(bf,rmkNoEval,not FirstMaskFiles(s,ExcludeTrailingPathDelimiter(t)+'*.'+LOGFILE_CHANGENAME));
  end;
  if not((bp=[]) and (bf=[])) then with dmSftp do begin
    InsertKey(K_1,t,'',bp+[rmkVisible]);
    InsertKey(K_2,s,'',bf+[rmkVisible]);
    key:=0;
    if Execute(@key,pShow) then case key of
      K_1: ShellExecute(0,nil,'EXPLORER.EXE',PChar('"'+t+'"'),nil,SW_SHOW);
      K_2: ShellExecute(0,nil,'notepad',PChar('"'+t+s+'"'),nil,SW_SHOW);
    end;
  end;
  DelStack;
end;

procedure TMain.RbPage1Changing(Sender: TObject; var AllowChange: Boolean);
begin
  inherited;
  FTsHiding:=RbPage1.ActivePage;
end;

procedure TMain.RbPage1Change(Sender: TObject);
begin
  inherited;
  FTsHiding:=nil;
  if (RbPage1.ActivePage=tsInstructions) then FHelpCore.ShowTreeAction;
  TTimerOne.CreateProc(CngPage,Self);
end;

procedure TMain.CngPage;
begin
  RenameKeyStack(RbPage1.ActivePage.Caption);
end;

procedure TMain.UpdateInstructionsSheetState;
begin
  TsInstructions.TabVisible:=DirectoryExists(GetHelpDir);
end;

class function TMain.GetHelpDir;
begin
  result:=TrimRight(ProgPswd.Rec['DIRHELP']);
end;

procedure TMain.TsInstructionsShow(Sender: TObject);
begin
  inherited;
  FHelpCore.ReloadTree;
end;

procedure TMain.ETnStatusUpdate;
var s,t: string;
begin
  AddStack('TMain.ETnStatusUpdate',Self);
  s:=TrimRight(aTn);
  if s='' then begin
    t:=TrimRight(ETn.VarValue);
    if Cdr.Seek(Cdr.TblFldName(fCDR)+'='+QQs(t)) then begin
      s:=t; aStatus:=Cdr['STATUS'];
    end;
  end;
  if TrimUpper(s)=TrimUpper(ETn.VarValue) then SetETnStatus(aStatus);
  DelStack;
end;

procedure TMain.SetETnStatus;
var s: string;
    b: boolean;
begin
  AddStack('TMain.SetETnStatus',Self);
  s:='';
  b:=false;
  if InRange(aStatus,byte(low(aCdrStat)),byte(high(aCdrStat))) then begin
    if iiCdr=NegDef
    then Cdr['STATUS']:=aStatus; // Не менять статус при просмотре списка пользователей
    s:=aCdrStat[TCdrStatList(aStatus)];
    b:=not CdrWorking(aStatus);
  end;
  ETnStatus.VarValue:=s;
  SetHL(hlTnStatus,b);
  if (not noUpdateBlinkState) then ApplTitleBlink;
  DelStack;
end;

procedure TMain.sbSftpMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if (Button=mbLeft) then begin
    FSftpSortX:=X;
    FSftpSortY:=Y;
  end;
end;

procedure TMain.sbSftpMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
const SORTCAPT = '(сорт.)';
var p: TPoint;
  nc,nr,k,j: longint;
  sbiz: TStrBrInfZn;
  r: TDefMenuShow;
begin
  inherited;
  if (Button=mbLeft)and(FSftpSortX=X)and(FSftpSortY=Y) then begin
    p:=sbSftp.ScreenToClient(Mouse.CursorPos);
    sbSftp.MouseToCell(p.X,p.Y,nc,nr);
    if (InRange(nr,0,sbSftp.FixedRows-1)) then begin
      if (FSftpSortCol<>nc) then begin
        FSftpSortCol:=nc;
        for k:=0 to sbSftp.ColCount-1 do begin
          sbiz:=sbSftp.InfoCol[k];
          j:=length(sbiz.aName);
          if (j>0) then begin
            if (sbiz.aName[j-1]=SORTCAPT) then begin
              SetLength(sbiz.aName,j-1);
              sbSftp.InfoCol[k]:=sbiz;
              break;
            end;
          end;
        end;(* for k *)
        if (InRange(nc,1,sbSftp.ColCount-1)) then begin
          sbiz:=sbSftp.InfoCol[nc];
          j:=length(sbiz.aName);
          if (j>0) then begin
            if (sbiz.aName[j-1]<>SORTCAPT) then begin
              SetLength(sbiz.aName,j+1);
              sbiz.aName[j]:=SORTCAPT;
              sbSftp.InfoCol[nc]:=sbiz;
            end;
          end;
        end;
        RefreshSftpSb;
      end;
    end;
  end;
  if Button=mbRight then begin
    r.lRect:=false; r.p:=sbSftp.ClientToScreen(Point(X,Y)); dmSftpExec(@r);
  end;
end;

procedure TMain.sbSftpMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var p: TPoint;
    s,t: string;
    c,r: longint;
begin
  inherited;
  s:='';
  p:=sbSftp.ScreenToClient(Mouse.CursorPos);
  sbSftp.MouseToCell(p.X,p.Y,c,r);
  if (InRange(r,0,sbSftp.FixedRows-1)) then begin
    if (InRange(c,0,sbSftp.ColCount-1)) then begin
      t:=sbSftp.Cells[c,0];
      if (t<>'') then begin
        s:=t+CRLF+'всего: '+Int2Str(sbSftp,c,0);
      end;
    end;
  end;
  if (s<>sbSftp.Hint) then begin
    Application.CancelHint;
    sbSftp.Hint:=s;
  end;
end;

procedure TMain.DeSendIntFldChange(Sender: TObject; const OldVal: Variant; FromShow: Boolean);
  procedure SetFeRo(const nmf: string; ro: boolean);
  begin
    DeSendInt.SetReadOnly(nmf,ro,[ogReadOnly,ogReadOnlyNoVsbl]);
  end;
var fe: TFldEdit;
  s: string;
  dt: TDateTime;
  si: TSIObjList;
begin
  AddStack('TMain.DeSendIntFldChange',Self);
  inherited;
  fe:=pointer(Sender);
  if fe.NameRecFld='SI_OBJ' then begin
    si:=TProgLs.Str2SI(fe);
    SetFeRo('SI_MSGPTRN',si<>SI_OBJ_MSG);
    SetFeRo('SI_FILE',si<>SI_OBJ_FILE);
    SetFeRo('SI_BG',not(si in [SI_OBJ_MSG,SI_OBJ_DP,SI_OBJ_ZAJ]));
    if DeSendInt.IsFldEdit('SI_BG',fe) then begin
      case si of
        SI_OBJ_MSG: fe.Mask:=ButPrm2Mask('Текст сообщения');
        SI_OBJ_DP: fe.Mask:=ButPrm2Mask('Список файлов');
        SI_OBJ_ZAJ: begin
          fe.Mask:=ButPrm2Mask('Заявка');
          DeZajIsp.Param['SI_ZAJ_ISPV',deMask]:=RadioMask(ISPVID_NAMES);
          DM.Rec['SI_ZAJ_TN']:=DM.Rec[fCDR];
          DM.Rec['SI_ZAJ_ISPTN']:=DM.Rec[fCDR];
          dt:=dZajBeg;
          DM.Rec['SI_ZAJ_DATE']:=dt;
          DM.Rec['SI_ZAJ_TIME']:=TTimeCurGet.DateToTime(dt);
          DM.Rec['SI_ZAJ_DATE1']:=dt;
          DM.Rec['SI_ZAJ_TIME1']:=TTimeCurGet.DateToTime(dt);
          dt:=Now;
          DM.Rec['SI_ZAJ_TIME2']:=TTimeCurGet.DateToTime(dt);
          DM.Rec['SI_ZAJ_ISPV']:=ivPhone;
        end;
      end;
    end;
  end
  else if fe.NameRecFld='SI_MSGPTRN' then begin
    s:=TrimRight(fe.Value);
    if s<>'' then
      if DeSendInt.IsFldEdit('SI_OBJ',fe) then
        if TProgLs.Str2SI(fe)=SI_OBJ_MSG then begin
          DM.Rec['SI_MSG']:=s;
          if DeSendInt.IsFldEdit('SI_BG',fe) then fe.Read;
        end;
  end
  else if fe.NameRecFld='SI_ONSEL'
    then StringListVar(DeSendInt.Params[2]).Clear;
  DelStack;
end;

function TMain.DeSendIntFldCheck(Sender: TObject): Boolean;
var fe: TFldEdit;
    s: string;
begin
  AddStack('TMain.DeSendIntFldCheck',Self);
  inherited;
  result:=true;
  if TFldEdit(Sender).NameRecFld='SI_BG' then
    if DeSendInt.IsFldEdit('SI_OBJ',fe) then begin
      case TProgLs.Str2SI(fe) of
        SI_OBJ_MSG: s:=DM.Rec['SI_MSG'];
        SI_OBJ_DP: s:=DM.Rec['SI_DPFILES'];
        SI_OBJ_ZAJ: s:=NOTEMPTYSTR;
        else s:='';
      end;
      if (TrimRight(s)='') then begin
        result:=false;
        BgSendIntClick(nil,true);
      end;
    end;
  DelStack;
end;

procedure TMain.DeSendIntPnlCngKey(Sender: TObject; var tb: TKeyBut);
begin
  with tb do if key=K_F10 then Caption:='Продолжить';
end;

function TMain.BgSendIntClick(Sender: TObject; lEval: Boolean): String;
var fe: TFldEdit;
    s,t,u,v: string;
begin
  AddStack('TMain.BgSendIntClick',Self);
  inherited;
  result:='';
  if DeSendInt.IsFldEdit('SI_OBJ',fe) then case TProgLs.Str2SI(fe) of
    SI_OBJ_MSG: begin
      s:=DM.Rec['SI_MSG'];
      if (lEval) then begin
        EdTextExec('Текст сообщения',s); DM.Rec['SI_MSG']:=s;
      end;
      result:=s;
    end;
    SI_OBJ_DP: begin
      t:=DM.Rec['SI_DPPATH'];
      s:=DM.Rec['SI_DPFILES'];
      if (lEval) then begin
        if DeSendInt.IsFldEdit('SI_KP',fe) then u:=GetProgInf(Int0(fe.Value)).Abr else u:='';
        if (SendDpExec(t,s,u)) then begin
          DM.Rec['SI_DPPATH']:=t;
          DM.Rec['SI_DPFILES']:=s;
        end;
      end;
      result:=s;
    end;
    SI_OBJ_ZAJ: begin
      if (lEval) then begin
        DeZajIsp.Execute;
      end;
      s:=TrimRight(DM.Rec['SI_ZAJ_TN']);
      if (s<>'') then s:=Trim(s)+': '+CdrGet.CodeName(s,[cdgBufAll]);
      t:=TrimRight(DM.Rec['SI_ZAJ_ISPTN']);
      if (t<>'') then t:=Trim(t)+': '+CdrGet.CodeName(t,[cdgBufAll]);
      if (empty(DM.Rec['SI_ZAJ_DATE'])) then u:=''
      else u:=FormatDateTime('dd.mm.yyyy',DM.Rec['SI_ZAJ_DATE'])+' '+DM.Rec['SI_ZAJ_TIME'];
      if (empty(DM.Rec['SI_ZAJ_DATE1'])) then v:=''
      else v:=FormatDateTime('dd.mm.yyyy',DM.Rec['SI_ZAJ_DATE1'])+' '+DM.Rec['SI_ZAJ_TIME1']+'-'+DM.Rec['SI_ZAJ_TIME2'];
      result:=
        'Текст:'+CRLF+
        TrimRight(DM.Rec['SI_ZAJ_TXT'])+CRLF+
        CRLF+
        'Принял:'+CRLF+
        s+CRLF+
        CRLF+
        'Поступила:'+CRLF+
        u+CRLF+
        CRLF+
        'Исполнение:'+CRLF+
        ISPVID_NAMES[Int2Ispv(DM.Rec['SI_ZAJ_ISPV'])]+CRLF+
        t+CRLF+
        v;
    end;
  end;
  DelStack;
end;

function TMain.DeSendIntPnlValid(Sender: TObject): Boolean;
var s: string;
  il: PArrInt;
  sisr: ^TSendIntSaveRec;
  plr: TProgListRec;
begin
  AddStack('TMain.DeSendIntPnlValid',Self);
  inherited;
  result:=false;
  plr.plrObj:=TProgLs.Str2SI(DM.Rec['SI_OBJ']);
  case plr.plrObj of
    SI_OBJ_MSG: s:=DM.Rec['SI_MSG'];
    SI_OBJ_FILE: s:=DM.Rec['SI_FILE'];
    SI_OBJ_DP: s:=DM.Rec['SI_DPFILES'];
    SI_OBJ_ZAJ: begin
      s:=NOTEMPTYSTR;(* без разницы - лишь бы не пусто *)
      plr.plrZajTxt:=DM.Rec['SI_ZAJ_TXT'];
      plr.plrZajTn:=DM.Rec['SI_ZAJ_TN'];
      plr.plrZajTd:=DateTimeToString(DM.Rec['SI_ZAJ_DATE'],DM.Rec['SI_ZAJ_TIME']);
      plr.plrZajIspv:=DM.Rec['SI_ZAJ_ISPV'];
      plr.plrZajIspTn:=DM.Rec['SI_ZAJ_ISPTN'];
      plr.plrZajTispd:=DateTimeToString(DM.Rec['SI_ZAJ_DATE1'],DM.Rec['SI_ZAJ_TIME1']);
      plr.plrZajTispd1:=DateTimeToString(DM.Rec['SI_ZAJ_DATE1'],DM.Rec['SI_ZAJ_TIME2']);
    end;
    else s:='';
  end;
  TrimRightSelf(s);
  if (s<>'') then begin
    plr.plrTn:=DM.Rec[fCDR];
    plr.plrKp:=TrimRight(DM.Rec['SI_KP']);
    plr.plrData:=s;
    if DM.Rec['SI_ONSEL'] then il:=PointerVar(DeSendInt.Params[0]) else il:=nil;
    if (ProgLsExec(GetPrim(tPROG),'','',nil,@plr,il,PointerVar(DeSendInt.Params[2]))) then begin
      sisr:=PointerVar(DeSendInt.Params[1]);
      sisr^.sisrKP:=DM.Rec['SI_KP'];
      sisr^.sisrONSEL:=DM.Rec['SI_ONSEL'];
      sisr^.sisrOBJ:=TProgLs.Str2SI(DM.Rec['SI_OBJ']);
      sisr^.sisrFILE:=DM.Rec['SI_FILE'];
      sisr^.sisrDPPATH:=DM.Rec['SI_DPPATH'];
      if (not sisr^.sisrUpdZaj) then begin
        sisr^.sisrUpdZaj:=(sisr^.sisrOBJ=SI_OBJ_ZAJ);
      end;
    end;
  end;
  DelStack;
end;

function TMain.DeZajIspFldCheck(Sender: TObject): Boolean;
begin
  inherited;
  with TFldEdit(Sender) do
    if NameRecFld='SI_ZAJ_TN'
      then result:=empty(DM.Rec['SI_ZAJ_DATE']) or not empty(VarValue)
    else if NameRecFld='SI_ZAJ_ISPTN'
      then result:=empty(DM.Rec['SI_ZAJ_DATE1']) or not empty(VarValue)
    else if NameRecFld='SI_ZAJ_DATE'
      then result:=not empty(DM.Rec['SI_ZAJ_DATE1']) or not empty(VarValue)
    else result:=true;
end;

procedure TMain.MsgToZaj;
begin
  AddStack('TMain.MsgToZaj');
  if GetParentForm(pointer(Sender))=Self then begin
    KeyLb1.ExecKey(K_Shift_1); RbPage1.SetActivePage(tsOrg);
  end;
  DelStack;
end;

class procedure TMain.qProgFilterRecord;
begin
  AddStack('TMain.qProgFilterRecord');
  if not Assigned(fProgRECNO) then fProgRECNO:=qProg.FindField(fRECNO);
  Accept := ProgGet.fdef.lsRec.IndexOf(fProgRECNO.AsInteger)<0;
  DelStack;
end;

procedure TMain.qZajFilterRecord;
begin
  AddStack('TMain.qZajFilterRecord',Self);
  if not Assigned(fZajRECNO) then fZajRECNO:=qZaj.FindField(tZAJ,fRECNO);
  Accept := lsrz.IndexOf(fZajRECNO.AsInteger)<0;
  DelStack;
end;

// Model
function TMain.MdGVersLoad;
begin
  AddStack('TMain.MdGVersLoad',Self);
  result:=true;
  case Oper of
    mdgoBeg: begin
      DM.MDGVersGet.Items.Capacity:=1+av[3]; result:=MaxInt;
    end;
    mdgoGet: result:=longint(rMDGVers);
    mdgoApp: DM.MDGVersGet.Items.Insert(0,IntToStr(rMDGVers[fLastcngVERS])+UnDelim
      +StrNum('Сборка: ',rMDGVers['VERSEXE'])+' ('+FormatDateTime(LastCngFmtD,rMDGVers['D'])+')');
  end;
  DelStack;
end;

const
  mdpPrimLen  = 0;
  mdpPrimArr  = 1;
  mdpPrimLArr = 2;

  mdpHigh     = 2;

function SortUpper(const v1,v2: string): longint;
begin
  result:=CompSign(v1,v2);
end;

type
  TMDFRec = record
    q: TMulQuery;
    qfRECNO,qfDEL: TField;
    adel: array[boolean] of record
      a: TArrStr;
      l: longint;
    end;
  end;

  TMDPrimArr = array of record
    n,l: longint;
  end;

procedure DelF(var rF: TMDFRec; ldel: boolean);
begin
  AddStack('FMain.DelF');
  with rF do begin
    if StrToBoolean(qfDEL.AsString)<>ldel then with adel[ldel] do begin
      a[l]:=Vtos(qfRECNO); Inc(l);
    end;
    q.Next;
  end;
  DelStack;
end;

procedure StMdPathLoad(Sender: TStat; const Params: array of variant; var Aborted: boolean);
var i: longint;
  function np: variant;
  begin
    Inc(i); result:=Params[i];
  end;
  function npp: pointer;
  begin
    result:=PointerVar(np);
  end;
var rF: ^TMDFRec;
  procedure DelF(ldel: boolean);
  begin
    FMain.DelF(rF^,ldel);
  end;
var qT: TMulQuery;
  adT: PArrStr;
  ldT: PLongint;
  procedure DelT;
  begin
    adT^[ldT^]:=Vtos(qT.Fields[0]); Inc(ldT^); qT.Next;
  end;
var lsf: TStringList;
  lf,j,k: longint;
  f,tnm: string;
  qV: TMulQuery;
  qfPATH,qfFILE,qfD,
  qvPATH,qvFILE,qvVERS,qvD: TField;
  mg: TModelGet;
  fl: boolean;
  PrimLen: PLongInt;
  afPrim: ^TMDPrimArr;
begin
  AddStack('FMain.StMdPathLoad');
  PrimLen:=PointerVar(Params[mdpPrimLen]);
  afPrim:=PointerVar(Params[mdpPrimArr]);
  i:=mdpHigh; lsf:=npp; lf:=np; mg:=npp;
  rF:=npp; qfPATH:=npp; qfFILE:=npp; qfD:=npp;
  qV:=npp; qvPATH:=npp; qvFILE:=npp; qvVERS:=npp; qvD:=npp;
  qT:=npp; adT:=npp; ldT:=npp;
  for i:=0 to lf-1 do begin
    f:=TrimUpper(lsf[i]); j:=IntObj(lsf,i);
    if Sender.SayStat('','Основа: '+f,(i+1)/lf) then break;
    with rF^,q do begin
      while not Eof and (TrimRight(qfPATH.AsString)<mg.Prefix) do DelF(true);
      while not Eof and (TrimRight(qfPATH.AsString)=mg.Prefix) and (TrimRight(qfFILE.AsString)<f) do DelF(true);
      if not Eof and (TrimRight(qfPATH.AsString)=mg.Prefix) and (TrimRight(qfFILE.AsString)=f) then begin
        fl := qfD.AsInteger<>j;
        if fl then MDF.GetFromQuery(q);
        DelF(false);
      end
      else begin
        fl:=true; MDF.NewRec; MDF[fCNGV]:=Cngv[fCNGV]; MDF[fMdPATH]:=mg.Prefix; MDF[fMdFILE]:=f;
      end;
    end;
    with qV do begin
      while not Eof and (TrimRight(qvPATH.AsString)<mg.Prefix) do Next;
      while not Eof and (TrimRight(qvPATH.AsString)=mg.Prefix) and (TrimRight(qvFILE.AsString)<f) do Next;
    end;
    if fl then begin
      MDF['D']:=j;
      if mg.LoadFromFile(f,[mdldCheckSum]) then begin
        MDF[fNAME]:=mg.MDName;
        for j:=low(mg.MDPrim) to high(mg.MDPrim) do with mg.MDPrim[j] do begin
          TrimRightSelf(Prim);
//if not empty(Date) then
          if Prim<>'' then begin
            with qV do begin
              while not Eof and (TrimRight(qvPATH.AsString)=mg.Prefix) and (TrimRight(qvFILE.AsString)=f) and (qvVERS.AsInteger<NumSave) do Next;
              if not Eof and (TrimRight(qvPATH.AsString)=mg.Prefix) and (TrimRight(qvFILE.AsString)=f) and (qvVERS.AsInteger=NumSave) then begin
                fl := qvD.AsFloat<>Date;
                if fl then MDV.GetFromQuery(qV);
                Next;
              end
              else begin
                fl:=true; MDV.NewRec; MDV[fCNGV]:=Cngv[fCNGV]; MDV[fMdPATH]:=mg.Prefix; MDV[fMdFILE]:=f; MDV[fMDV]:=NumSave;
              end;
              if fl then begin
                MDV['D']:=Date; MDV['AUTOR']:=Autor; MaxSelf(PrimLen^,Length(Prim));
                for k:=0 to Params[mdpPrimLArr] do with afPrim^[k] do begin
                  MDV.ValueNum[n]:=Prim; CopySelf(Prim,l+1,MaxInt);
                end;
                if Prim<>'' then MDF['D']:=0;
                MDV.AppUpdRec;
              end;
            end;
            with qT do begin
              while not Eof and (TrimRight(Fields[1].AsString)<mg.Prefix) do Next;
              while not Eof and (TrimRight(Fields[1].AsString)=mg.Prefix) and (TrimRight(Fields[2].AsString)<f) do Next;
              while not Eof and (TrimRight(Fields[1].AsString)=mg.Prefix) and (TrimRight(Fields[2].AsString)=f) and (Fields[3].AsInteger<NumSave) do Next;
              k:=Length(Themes); fl := k=0;
              if fl then CopyFrom(Themes)
              else begin
                QuickSort(SortUpper,Themes); Dec(k);
              end;
              for k:=0 to k do begin
                tnm:=TrimUpper(Themes[k]);
                if (tnm<>'') or fl then begin
                  while not Eof and (TrimRight(Fields[1].AsString)=mg.Prefix) and (TrimRight(Fields[2].AsString)=f) and (Fields[3].AsInteger=NumSave) and (TrimRight(Fields[4].AsString)<tnm) do DelT;
                  if not Eof and (TrimRight(Fields[1].AsString)=mg.Prefix) and (TrimRight(Fields[2].AsString)=f) and (Fields[3].AsInteger=NumSave) and (TrimRight(Fields[4].AsString)=tnm)
                  then Next
                  else begin
                    MDT.NewRec; MDT[fCNGV]:=Cngv[fCNGV]; MDT[fMdPATH]:=mg.Prefix; MDT[fMdFILE]:=f; MDT[fMDV]:=NumSave;
                    MDT[fNAME]:=tnm; MDT.AppRec;
                  end;
                end;
                while not Eof and (TrimRight(Fields[1].AsString)=mg.Prefix) and (TrimRight(Fields[2].AsString)=f) and (Fields[3].AsInteger=NumSave) do DelT;
              end;
            end;
          end;
        end;
        MDF.AppUpdRec;
      end
      else if MDF.RecNo>0 then with rF.adel[true] do begin
        a[l]:=Vtos(MDF.RecNo); Inc(l);
      end;
    end
    else begin
      with qV do while not Eof and (TrimRight(qvPATH.AsString)=mg.Prefix) and (TrimRight(qvFILE.AsString)=f) do Next;
      with qT do while not Eof and (TrimRight(Fields[1].AsString)=mg.Prefix) and (TrimRight(Fields[2].AsString)=f) do Next;
    end;
  end;
  DelStack;
end;

const
  nmdMG     = 0;
  nmdWhere  = 1;
  nmdVers   = 2;
  nmdLS     = 3;
  nmdAF     = 4;
  nmdLF     = 5;

{$IFDEF TEST}
  TestPath = 'FORM';
  TestFile = 'СВЕНДФЛ3';
{$ENDIF}

procedure StMdPathFirst(Sender: TStat; const Params: array of variant; var Aborted: boolean);
var mg: TModelGet;
  ls: TStringList;
  af: PArrStr;
  i,j,k,lf,ov: longint;
  f,w: string;
  d: Double;
begin
  AddStack('FMain.StMdPathFirst');
  mg:=PointerVar(Params[nmdMG]); ls:=PointerVar(Params[nmdLS]); af:=PointerVar(Params[nmdAF]); lf:=Params[nmdLF];
  for i:=0 to lf-1 do begin
    f:=TrimUpper(af^[i]);
    if Sender.SayStat('','Основа: '+f,(i+1)/lf) then break;
{$IFDEF TEST}
if f<>TestFile then continue;
{$ENDIF}
    if mg.LoadFromFile(f,[mdldCheckSum]) then begin
      d:=GetFileDateTime(mg.Root+DirModels+mg.Prefix+PathDelim+f);
      for j:=high(mg.MDPrim) downto low(mg.MDPrim) do with mg.MDPrim[j] do if not empty(Prim) then with ProgPswd.CurQuery do begin
        if IgnoreSlFindAdd(ls,mg.Prefix+','+f,k) then begin
          ov:=IntObj(ls,k);
          if NumSave<=ov then break;
          w:=fMDV+'>'+Vtos(ov)+sAND+fMDV+'<='+Vtos(NumSave);
        end
        else w:=fMDV+'='+Vtos(NumSave);
        ls.Objects[k]:=pointer(NumSave); IncL(w,Params[1]+fMdFILE+'='+QQs(f)+sAND,sAND);
        UpdateTable('',[fMDG],[Params[nmdVers]],w+QQNull(fMDG,0));
        UpdateTable('',['D'],[d],w+QQNull('D',0));
        break;
      end;
    end;
  end;
  DelStack;
end;

procedure StMdGVersFirst(Sender: TStat; const Params: array of variant; var Aborted: boolean);
var mg: TModelGet;
  ap,af: TArrStr;
  i,lp,lf: longint;
  gp,s: string;
  av: TArrVar;
begin
  AddStack('FMain.StMdGVersFirst');
  mg:=PointerVar(Params[nmdMG]); gp:=mg.Root+DirModels; GetMaskFiles(ap,lp,gp+'*.*',[fmDir],[msfSort]);
  CopyFromVArr(av,Params); AddFromVArr(av,[longint(@af),0]);
  for i:=0 to lp-1 do begin
    mg.Prefix:=TrimUpper(ap[i]); s:='Папка: '+mg.Prefix;
    if Sender.SayStat('',s,(i+1)/lp) then break;
{$IFDEF TEST}
if mg.Prefix<>TestPath then continue;
{$ENDIF}
    GetMaskFiles(af,lf,gp+mg.Prefix+PathDelim+'*.*',[],[msfSort]);
    av[nmdWhere]:=Params[nmdWhere]+fMdPATH+'='+QQs(mg.Prefix)+sAND; av[nmdLF]:=lf;
    if ShowStat(s,StMdPathFirst,av,lf,10) then begin
      Aborted:=true; break;
    end;
  end;
  DelStack;
end;

procedure StMdLoad(Sender: TStat; const Params: array of variant; var Aborted: boolean);
var lsp,lsf: TStringListCase;
  i,lp,lf,id,ldT: longint;
  rF: TMDFRec;
  qP,qV,qT: TMulQuery;
  qfPATH,qfFILE,qfD,
  qvPATH,qvFILE,qvVERS,qvD: TField;
  wkc,gp,s,gv: string;
  adT: TArrStr;
  mg: TModelGet;
  ldel,lFirst: boolean;
  av: TArrVar;
begin
  AddStack('FMain.StMdLoad');
  id:=Cngv[fMDP]; wkc:=fCNGV+'='+QQs(Cngv[fCNGV]);
  qP:=ProgPswd.GetQuery; qP.PartSelect(tMDP,fMdPATH,fMDP+'='+Vtos(id),fMdPATH);
  rF.q:=ProgPswd.GetQuery;
  with rF,q do begin
    PartSelect(tMDF,[],wkc,GetList([fMdPATH,fMdFILE]));
    qfRECNO:=FindField(fRECNO); qfPATH:=FindField(fMdPATH); qfFILE:=FindField(fMdFILE); qfD:=FindField('D'); qfDEL:=FindField('DEL');
    i:=RecordCount; lFirst := i=0;
{$IFDEF TEST}
lFirst:=true;
{$ENDIF}
    for ldel:=false to true do with adel[ldel] do begin
      l:=0; SetLength(a,i);
    end;
  end;
  qV:=ProgPswd.GetQuery;
  with qV do begin
    PartSelect(tMDV,[],wkc,GetList([fMdPATH,fMdFILE,fMDV]));
    qvPATH:=FindField(fMdPATH); qvFILE:=FindField(fMdFILE);
    qvVERS:=FindField(fMDV); qvD:=FindField('D');
  end;
  qT:=ProgPswd.GetQuery;
  with qT do begin
    PartSelect(tMDT,[fRECNO,fMdPATH,fMdFILE,fMDV,fNAME],wkc,GetList([fMdPATH,fMdFILE,fMDV,fNAME]));
    ldT:=0; SetLength(adT,RecordCount);
  end;
  lsp:=TStringListCase.Create; lsf:=TStringListCase.Create;
  mg:=TModelGet.Create(Application.MainForm);
  try
    mg.Root:=CorrDir(Cngv['COPYDIR']); gp:=mg.Root+DirModels;
    GetMaskFiles(lsp,gp+'*.*',[fmDir],[msfSort]); lp:=lsp.Count;
    for i:=0 to lp-1 do begin
      mg.Prefix:=TrimUpper(lsp[i]);
      if Sender.SayStat('','Папка: '+mg.Prefix,(i+1)/lp) then break;
      with qP do begin
        while not Eof and (TrimRight(Fields[0].AsString)<mg.Prefix) do Next;
        if Eof or (TrimRight(Fields[0].AsString)>mg.Prefix) then begin
          MDP.NewRec; MDP[fMDP]:=id; MDP[fMdPATH]:=mg.Prefix; MDP.AppRec;
        end;
      end;
      GetMaskFiles(lsf,gp+mg.Prefix+PathDelim+'*.*',[],[msfAge,msfSort]); lf:=lsf.Count;
      CopyFromVArr(av,Params);
      AddFromVArr(av,[longint(lsf),lf,longint(mg),
        longint(@rF),longint(qfPATH),longint(qfFILE),longint(qfD),
        longint(qV),longint(qvPATH),longint(qvFILE),longint(qvVERS),longint(qvD),
        longint(qT),longint(@adT),longint(@ldT)]);
      if ShowStat('Папка: '+mg.Prefix,StMdPathLoad,av,lf,10) then begin
        Aborted:=true; break;
      end;
    end;
    if not Aborted then begin
      with rF,q do begin
        while not Eof do DelF(rF,true);
        for ldel:=false to true do with adel[ldel] do if l>0 then UpdateTableFldList(['DEL'],[ldel],a,l);
      end;
      if ldT>0 then qT.DeleteTableFldList(adT,ldT);
      if lFirst then if Main.deMDFirst.Execute.Saved then if not Sender.SayStat(Main.deMDFirst.FrmCaption) then begin
        gp:=CorrDir(Main.rMDFirst['PATH']); GetMaskFiles(adT,ldT,gp+'*.*',[fmDir],[msfSort]); lsp.Clear;
        for i:=0 to ldT-1 do begin
          gv:=DlmCopy(adT[i],1,1,'_'); s:='Версия: '+gv;
          if Sender.SayStat('',s,(i+1)/ldT) then break;
          mg.Root:=gp+adT[i]+PathDelim; ProgPswd.CurQuery.Arg[sTABLE]:=tMDV;
          if ShowStat(s,StMdGVersFirst,[longint(mg),wkc+sAND,Int0(gv),longint(lsp)]) then begin
            Aborted:=true; break;
          end;
        end;
      end;
    end;
  finally
    lsp.Free; lsf.Free; mg.Free;
  end;
  ProgPswd.FreeQuery; ProgPswd.FreeQuery; ProgPswd.FreeQuery; ProgPswd.FreeQuery;
  DelStack;
end;

procedure TMain.MdExec;
const
  aSort: array[TMdSort] of record
    f: TArrBoolStr;
    desc: boolean;
  end =
    (()
    ,(f:(tMDV+'.D,'+tMDV+'.'+fMDV             ,tMDV+'.D,'+tMDV+'.'+fMDV             ); desc:true)
    ,(f:(tMDV+'.'+fMDG                        ,tMDV+'.'+fMDG                        ); desc:true)
    ,(f:(tMDV+'.'+fMdPATH+','+tMDV+'.'+fMdFILE,tMDV+'.'+fMdPATH                     ))
    ,(f:(tMDV+'.'+fMdPATH+','+tMDV+'.'+fMdFILE,tMDV+'.'+fMdPATH+','+tMDV+'.'+fMdFILE))
    ,(f:(tMDT+'.'+fNAME                       ,tMDT+'.'+fNAME                       ))
    ,(f:(tMDF+'.DEL'                          ,tMDF+'.DEL'                          ))
    );
var aog: array[boolean] of TArrVar;
  procedure fSort(st: TMdSort; lg: boolean = false);
  var a: TArrStr;
    i,j,l,l2: longint;
  begin
    AddStack('TMain.MdExec.fSort',Self);
    with aSort[st] do begin
      l:=LsArrDynamic(f[lg],a,',');
      if not lg then begin
        if desc then for i:=0 to l-1 do IncD(a[i],' desc');
        l2:=(l shl 1)-1; j:=l2;
        if Length(a)<j then SetLength(a,j);
        for i:=l-1 downto 0 do begin
          Dec(j); a[j]:=a[i];
          if i>0 then begin
            Dec(j); a[j]:=QQs('.');
          end;
        end;
        l:=l2;
      end;
      AddFromVArr(aog[lg],[ProgPswd.CurQuery.GetList(ArrStrToArrVar(a,l))]);
    end;
    DelStack;
  end;
var sg: set of TMdSort;
  i: longint;
  lPart: boolean;
  function sVers(lg: boolean): string;
    function IsType(st: TMdSort): boolean;
    begin
      AddStack('TMain.MdExec.sVers.IsType',Self);
      result := (st in sg) = lg;
      DelStack;
    end;
  var d: Double;
    a: array[1..8] of string;
    Style: THelpStyleList;
    sd: char;
  begin
    AddStack('TMain.MdExec.sVers',Self);
    InitArr(a); Style:=SCE_OURLIB_HELP_HEAD;
    with ProgPswd.CurQuery,aMd[i] do begin
      if not lPart then begin
        gv:=Fields[2].AsInteger; p:=Fields[3].AsString; f:=Fields[4].AsString; v:=Fields[5].AsInteger;
        del:=StrToBoolean(Fields[6].AsString);
      end;
      sd:=IfThenChar(lsgv.IndexOf(Fields[9].AsInteger)<0,'-','+');
      if IsType(mdsrtD) then begin
        d:=Fields[0].AsFloat;
        if d=0 then a[1]:='00:00 00.00.0000' else a[1]:=FormatDateTime('hh:nn dd.mm.yyyy',d); //дата
      end;
      if IsType(mdsrtGVers) then //общая версия
        if gv=0 then a[3]:='()' else a[3]:=IfThen(not lg,sd)+Format('(%d)',[gv]);
      if IsType(mdsrtPath) or IsType(mdsrtFile) then begin
        a[4]:='-'+ReplVar(Trim(DM.MDPGet.CodeName(p,[cdgBufAll])),p); //папка
        if IsType(mdsrtFile) then begin
          IncD(a[4],'.'+f); //файл
          a[6]:=TrimRight(Fields[7].AsString); //наим.основы
        end;
      end;
      if not lg then begin
        a[2]:=BrackNoEmp(Trim(Fields[1].AsString)); //автор
        a[5]:=IfThen(mdsrtGVers in sg,sd)+Format('[%d]',[v]); //версия
      end;
      if IsType(mdsrtTheme) then a[7]:=TrimRight(Fields[8].AsString); //тема
      if IsType(mdsrtDel) then if lg then a[8]:=aMdDel[del] else if del then Style:=SCE_OURLIB_HELP_PRIM; //удалено/нет
    end;
    result:=DlmBetween(a,' ',false);
    if not(lg or (result='')) then HelpBoldStrSelf(result,Style);
    DelStack;
  end;
var fl,fl1: boolean;
  s,w: string;
  at: TArrStr;
  stDel: TBoolSet;
  a: THelpArr;
  ost,j,l,ln,np,lp: longint;
  r: TMdInf;
  afPrim: TMDPrimArr;
  st: TMdSort;
begin
  ost:=AddStack('TMain.MdExec',Self);
  if Assigned(Sender) then begin
    Sender.SetModalResult(mrCancel); r:=aMd[MdIndex[Sender]];
  end;
  MDV.FieldFind('PRIM',i); j:=MDV.FieldCount; SetLength(afPrim,j-i+1); lp:=0;
  while i<j do
    if AnsiStartsText('PRIM',MDV.FieldName[i]) then with afPrim[lp] do begin
      n:=i; l:=MDV.Field[i].Info.Size; Inc(i); Inc(lp);
    end
    else break;
  Dec(lp);
  if lLoad then begin
    fl:=MDFltPrepare;
    if fl then begin
      i:=0; j:=Int0(Cngv[fCNGV]); fl:=false;
      if LockMode(StrNum('Загрузка основ для изменения ',j),'FMDLOAD','FMDLOAD='+Vtos(j),j) then
        try
          fl:=not ShowStat('Загрузка основ',StMdLoad,[longint(@i),longint(@afPrim),lp]);
        finally
          UnlockMode('FMDLOAD');
        end;
      for np:=0 to lp do Dec(i,afPrim[np].l);
      if i>0 then begin
        s:=Format('Ошибка загрузки основ: необходимо увеличить размер примечания на %d символов%s(добавить %d полей длиной %d символов)',
          [i,CRLF,Ceil(i/MaxByte),MaxByte]);
        OutStack(s,[outstMsgOnly]); MsgDlg(s);
      end;
    end;
  end
  else fl:=true;
  if fl then with ProgPswd.GetQuery do begin
    lsgv.SetOption(ilsSorted,false); lsgv.Clear;
    PartSelect(tMDV,[Concat([fMdPATH,QQs('.'),fMdFILE,QQs('.'),fMDG]),fRECNO],fCNGV+'='+QQs(Cngv[fCNGV]),fMDV);
    lsgv.Capacity:=RecordCount; Last;
    while not Bof do begin
      s:=Fields[0].AsString; lsgv.Add(Fields[1].AsInteger);
      repeat
        Prior;
      until Bof or (Fields[0].AsString<>s);
    end;
    lsgv.SetOption(ilsSorted,true);
    w:=ArrayAsList([tMDF+'.'+fCNGV+'='+QQs(Cngv[fCNGV]),
      tMDV+'.'+fCNGV+'='+tMDF+'.'+fCNGV,tMDV+'.'+fMdPATH+'='+tMDF+'.'+fMdPATH,tMDV+'.'+fMdFILE+'='+tMDF+'.'+fMdFILE,
      tMDT+'.'+fCNGV+'='+tMDV+'.'+fCNGV,tMDT+'.'+fMdPATH+'='+tMDV+'.'+fMdPATH,tMDT+'.'+fMdFILE+'='+tMDV+'.'+fMdFILE,tMDT+'.'+fMDV+'='+tMDV+'.'+fMDV],sAND);
    if rMDFlt['MDLD'] then IncAnd(w,tMDV+'.D>='+Vtos(trunc(rMDFlt['MDDB']))+sAND+tMDV+'.D<'+Vtos(trunc(rMDFlt['MDDE'])+1));
    if rMDFlt['MDLGVERS'] then IncAnd(w,tMDV+'.'+fMDG+'='+Vtos(rMDFlt['MDGVERS']));
    if rMDFlt['MDLFILE'] then begin
      IncAnd(w,tMDV+'.'+fMdPATH+'='+QQs(rMDFlt['MDPATH'])); s:=rMDFlt['MDFILE'];
      if not empty(s) then IncAnd(w,tMDV+'.'+fMdFILE+'='+QQs(rMDFlt['MDFILE']));
    end;
    if rMDFlt['MDLTHEMES'] then begin
      s:=TrimRight(rMDFlt['MDTHEMES']);
      if s='' then s:=tMDT+'.'+fNAME+'='+QQs
      else begin
        LsArrDynamic(s,at,CRLF,lsaSetLen); TrimUpperSelf(at); s:=FldInListQQ(tMDT+'.'+fNAME,at,NegDef,[flsUnique]);
      end;
      IncAnd(w,s);
    end;
    s:=rMDFlt['MDDEL']; stDel:=[]; fl1:=false;
    for fl:=false to true do
      if GetByte(s,1+byte(fl)) then Include(stDel,fl) else fl1:=true;
    if fl1 then for fl:=false to true do if fl in stDel then IncAnd(w,FldIsTrue(tMDF+'.DEL',fl));
    fl:=true; Finalize(aog); ZeroMemory(@aog,SizeOf(aog)); sg:=[];
    for i:=1 to cntMdSort do begin
      s:=IntToStr(i); st:=rMdFlt['ST'+s];
      case st of
        mdsrtNone: break;
        mdsrtD: fl:=false;
      end;
      fSort(st);
      if rMdFlt['SG'+s] then begin
        fSort(st,true); Include(sg,st);
      end;
    end;
    if fl then fSort(mdsrtD);
    if aog[true]=nil then aog[true]:=ArrStrToArrVar([QQs]);
    SetArrayList(sC_LIST,[tMDV+'.D',tMDV+'.AUTOR',tMDV+'.'+fMDG,
      tMDV+'.'+fMdPATH,tMDV+'.'+fMdFILE,tMDV+'.'+fMDV,tMDF+'.DEL',tMDF+'.'+fNAME,tMDT+'.'+fNAME,Mdv.tRecno,Concat(aog[true])]);
    for np:=0 to lp do AddArgList(sC_LIST,MDV.FieldName[afPrim[np].n]);
    PartSelect(GetList([tMDF,tMDV,tMDT]),'',w,GetList(aog[false]));
    l:=RecordCount; lMdEdit := l>0; oMdIndex:=NegDef;
    if lMdEdit then begin
      SetLength(a,l); SetLength(aMd,l); lsMd.Clear; lsMd.Capacity:=l; i:=0; j:=0; ln:=0; lPart:=false;
      while i<l do with a[j] do begin
        avk:=nil; part:=sVers(true); lPart:=true; txt:=''; w:=Fields[10].AsString;
        while (i<l) and (Fields[10].AsString=w) do begin
          s:='';
          for np:=0 to lp do IncD(s,FieldValueIndex(11+np));
          s:=CRLF+DlmBetween(sVers(false),TrimRight(s),CRLF,false); IncD(txt,s);
          if Assigned(Sender) then with aMd[i] do if p=r.p then if f=r.f then if v=r.v then oMdIndex:=i;
          lsMd.Add(ln); Inc(ln,IfThen(lPart,1)+StrCount(CRLF,s)); lPart:=false; Next; Inc(i);
        end;
        Inc(j);
      end;
      SetLength(a,j);
    end
    else begin
      SetLength(a,1); SetLength(aMd,1); ZeroMemory(@aMd[0],SizeOf(aMd[0]));
      with a[0] do begin
        avk:=nil; part:='Отсутствуют основы'; txt:=' (см. Параметры <F3> - Фильтр)';
      end;
    end;
    ProgPswd.FreeQuery; AndD(lMdEdit,lCngEdit);
    try
      THelpLs.Execute(a,NegDef,nil,MdShow,MdHide);
    except
      SetStack(ost);
      mess_ok(['Ошибка просмотра основ: слишком большое количество информации.',
        'Выполнение программы будет завершено.','При последующем запуске программы перед просмотром основ',
        'воспользуйтесь клавишей «<Shift+F3> - Параметры основ - Фильтр».']);
      raise;
    end;
  end;
  DelStack;
end;

procedure TMain.TimerMdExec;
begin
  AddStack('TMain.TimerMdExec',Self);
  with TTimerOne(Sender) do MdExec(pointer(Owner),Params[0]);
  DelStack;
end;

procedure TMain.MdShow;
var f: THelpLs;
begin
  AddStack('TMain.MdShow',Self);
  f:=pointer(GetParentForm(TControl(Sender))); f.Caption:=Cngv[fNAME];
  if oMdIndex<>NegDef then MdIndex[f]:=oMdIndex;
  with FormKeyLb(f) do begin
    SetKey(K_F3,'Параметры','',MdProcKey,'model',kmList);
    SetKey(K_Ctrl_R,'Обновить','',MdProcKey,'model',kmList);
    SetKey(K_Ctrl_F4,'Виды','',MdProcKey,'model',kmList);
    if lMdEdit then begin
      SetKey(K_F5,'Версия','Установка общей версии',MdProcKey,'model',kmList);
      SetKey(K_F8,'Удалить','Удалить из базы отсутствующую в папке основу',MdProcKey,'model',kmList);
    end;
    ReDrw;
  end;
  DelStack;
end;

procedure TMain.MdHide;
begin
  AddStack('TMain.MdHide',Self);
  with FormKeyLb(TControl(Sender)) do begin
    DelKey(K_All,'model'); ReDrw;
  end;
  DelStack;
end;

procedure TMain.MdProcKey;
var Sender: THelpLs;
  procedure ReLoad(lLoad: boolean = false);
  begin
    AddStack('TMain.MdProcKey.ReLoad',Self);
    TTimerOne.CreateProc(TimerMdExec,Sender,[lLoad]);
    DelStack;
  end;
var lr: TListF2Result;
	mr: TMenuGetRec;
  i,vb,gvn: longint;
  s: string;
  fqMDG,fqMDV: TField;
begin
  AddStack('TMain.MdProcKey',Self);
  Sender:=pointer(GetParentForm(tw));
  with aMd[MdIndex[Sender]] do case Key of
    K_F3: if MDFltExec(false) then ReLoad;
    K_F5: begin
      ProgPswd.LogVid:=logvEditRec;
      lr:=TListF2Result.Create;
      with DM.MDGVersGet do try
        s:='';
        for i:=0 to Items.Count-1 do if not Empty(Items[i]) then begin
          mr:=ACodName(i); IncD(s,CRLF+mr.Cod+' '+mr.Name); lr.Add(mr.Cod);
          //if Int0(mr.Cod)= then lr.SelectStr:=i;
        end;
        if ListF2Down(copy(s,lCRLF1,MaxInt),lr,nil,0,SchemDM.Browl.CaptSmall,'',nil,0,nil,nil,nil,nil,nil,
        Format('%s.%s [%d]',[ReplVar(Trim(DM.MDPGet.CodeName(p,[cdgBufAll])),p),f,v])) then begin
          gvn:=Int0(ACodName(lr.SelectStr).Cod);
          if gvn<>gv then with ProgPswd.GetQuery do begin
            s:=ArrayAsList([fCNGV+'='+QQs(Cngv[fCNGV]),fMdPATH+'='+QQs(p),fMdFILE+'='+QQs(f),fMDV+'<='+Vtos(v)],sAND);
            PartSelect(tMDV,[],s,fMDV); fqMDG:=FindField(fMDG); fqMDV:=FindField(fMDV); Last; vb:=NegDef;
            while not Bof do begin
              if fqMDG.AsInteger<>gv then begin
                vb:=fqMDV.AsInteger; break;
              end;
              Prior;
            end;
            MDV.UpdateTable([fMDG],[gvn],ArrayAsList([s,fMDV+'>'+Vtos(vb),fMDV+'<='+Vtos(v)],sAND));
            Last;
            while not Bof do begin
              if fqMDG.AsInteger<>gv then break;
              MDV.GetFromQuery; MDV[fMDG]:=gvn; MDV.LogWriteMod; Prior;
            end;
            ProgPswd.FreeQuery; MDModified:=true; ReLoad;
          end;
        end;
      finally
        lr.Free;
      end;
      ProgPswd.LogVid:=logvNone;
    end;
    K_F8:
      if del then begin
        if Ask(['Удалить основу '+ReplVar(Trim(DM.MDPGet.CodeName(p,[cdgBufAll])),p)+'.'+f+' ?']) then begin
          s:=ArrayAsList([fCNGV+'='+QQs(Cngv[fCNGV]),fMdPATH+'='+QQs(p),fMdFILE+'='+QQs(f)],sAND);
          MDT.DelRec(s); MDV.DelRec(s); MDT.Seek(s); MDT.DelRec('',[delLog]);
          i:=MdIndex[Sender]; MdIndex[Sender]:=i+aSign[i=high(aMd)]; MDModified:=true; ReLoad;
        end;
      end
      else mess_ok(['Нельзя удалять основу, для которой существует файл:',
        CorrDir(Cngv['COPYDIR'])+DirModels+p+PathDelim+f]);
    K_Ctrl_F4: begin
      TMDPLs.Prepare(p); MDPLs.ShowModal;
      if MDPLs.Modified then ReLoad;
      FormFree(MDPLs);
    end;
    K_Ctrl_R: ReLoad(true);
  end;
  DelStack;
end;

function TMain.MDFltExec;
begin
  AddStack('TMain.MDFltExec',Self);
  SetLogVid(logvEditRec);
  if Prepare then result:=MDFltPrepare else result:=true;
  if result then result:=deMDFlt.Execute.Saved;
  SetLogVid;
  DelStack;
end;

function TMain.MDFltPrepare;
var s: string;
  oMdLoad: TLastCngMdLoad;
  i: byte;
begin
  AddStack('TMain.MDFltPrepare',Self);
  DM.MDGVersGet.Items.BeginUpdate; DM.MDGVersGet.Items.Text:='0'+UnDelim;
  CreateForm(TLastCngLs,LastCngLs);
  with LastCngLs,SchemDM.mgLastCng do begin
    oMdLoad:=PrMdLoad; s:=Root;
    try
      PrMdLoad:=MdGVersLoad; Root:=CorrDir(Cngv['COPYDIR']);
      result:=LoadFromFile(TrimRight(Cngv['LASTCNG']),[mdldCheckSum,mdldDoLoad]);
    finally
      PrMdLoad:=oMdLoad; Root:=s;
    end;
  end;
  FormFree(LastCngLs);
  DM.MDGVersGet.Items.EndUpdate;
  for i:=1 to cntMdSort do begin
    s:=IntToStr(i); rMdFlt['ST'+s]:=iif(i=1,mdsrtD,mdsrtNone); rMdFlt['SG'+s] := i=1;
  end;
  rMdFlt.RestFromIni('MDFLT.'+Trim(Cngv[fCNGV]));
  DM.MDPGet.MulPar.Values['id']:=Vtos(Cngv[fMDP]);
  DM.MDFGet.MulPar.Values['kc']:=Cngv[fCNGV];
  DelStack;
end;

procedure TMain.deMdFltFrmShow(Sender: TObject);
var AOwner: TCustomRbPanel;
begin
  AddStack('TMain.deMdFltFrmShow',Self);
  AOwner:=pointer(deMdFlt.FldEdit[StrNum('ST',1)].Parent);
  TPaintSay.CreatePrm('Сортировки',AOwner);
  TPaintSay.CreatePrm('Группировать',AOwner);
  DelStack;
end;

procedure TMain.deMdFltFldChange(Sender: TObject; const OldVal: Variant;
  FromShow: Boolean);
var i,j,k: byte;
  s: string;
  fl: boolean;
  tf: TFldEdit;
begin
  AddStack('TMain.deMdFltFldChange',Self);
  with TFldEdit(Sender),deMdFlt do
    if NameRecFld='MDLD' then SetReadOnly(['VAL1','MDDB','MDDE'],not VarValue)
    else if NameRecFld='MDLGVERS' then SetReadOnly('MDGVERS',not VarValue)
    else if NameRecFld='MDLFILE' then SetReadOnly(['VAL2','MDPATH','MDFILE'],not VarValue)
    else if NameRecFld='MDLTHEMES' then SetReadOnly('MDTHEMES',not VarValue)
    else if NameRecFld='MDPATH' then DM.MDFGet.GlobKey:=VarValue
    else for i:=1 to cntMdSort do begin
      s:=IntToStr(i);
      if NameRecFld='ST'+s then begin
        fl := VarValue=mdsrtNone; FldEdit['SG'+s].SetReadOnly(fl);
        if fl and (i<cntMdSort) then FldEdit[StrNum('ST',i+1)].VarValue:=mdsrtNone;
        for j:=1 to cntMdSort do begin
          tf:=FldEdit[StrNum('ST',j)]; tf.SetReadOnly(false);
          if tf.VarValue=mdsrtNone then begin
            for k:=j+1 to cntMdSort do FldEdit[StrNum('ST',k)].SetReadOnly(true);
            break;
          end;
        end;
      end
      else if NameRecFld='SG'+s then
        if VarValue then for j:=1 to i-1 do FldEdit[StrNum('SG',j)].VarValue:=true
        else for j:=i+1 to cntMdSort do FldEdit[StrNum('SG',j)].VarValue:=false;
    end;
  DelStack;
end;

function TMain.deMdFltFldCheck(Sender: TObject): Boolean;
begin
  AddStack('TMain.deMdFltFldCheck',Self);
  NoEmpCheck(Sender,'MDPATH',result);
  DelStack;
end;

function TMain.deMdFltPnlValid(Sender: TObject): Boolean;
begin
  AddStack('TMain.deMdFltPnlValid',Self);
  rMdFlt.SaveToIni(nil,'MDFLT.'+Trim(Cngv[fCNGV])); result:=true;
  DelStack;
end;

function TMain.deMDFirstFldCheck(Sender: TObject): Boolean;
begin
  AddStack('TMain.deMDFirstFldCheck',Self);
  NoEmpCheck(Sender,'PATH',result);
  DelStack;
end;

function TMain.GetMdIndex;
begin
  AddStack('TMain.GetMdIndex',Self);
  if not lsMd.Find(Sender.Line,result)
  then Dec(result);
  DelStack;
end;

procedure TMain.SetMdIndex;
begin
  AddStack('TMain.SetMdIndex',Self);
  Sender.Line:=lsMd[Value];
  DelStack;
end;

{ TProgLogCompare }
class procedure TProgLogCompare.GetItem;
var n: longint;
begin
  AddStack('TProgLogCompare.GetItem');
  inherited GetItem(Prm,pv,lso,lsn,no,nn,tp);
  if (tp=clogPrn) and not empty(Prm.val) then begin
    n:=Int0(Prm.val);
    if InRange(n,low(ProgInfs),high(ProgInfs)) then Prm.val:=ProgInfs[n].Name;
  end;
  DelStack;
end;

{ TOrgDatLogCompare }
class procedure TOrgDatLogCompare.GetItem;
var n: longint;
begin
  AddStack('TOrgDatLogCompare.GetItem');
  inherited GetItem(Prm,pv,lso,lsn,no,nn,tp);
  TrimRightSelf(Prm.val);
  if (tp=clogPrn) and (Prm.val<>'') then begin
    n:=Main.lsf.IndexOf(Prm.val);
    if n>=0 then Prm.val:=DlmCopy(DlmCopy(Main.deSys.Param['OrgDat',deMask],3,1,UnDelim),n+1,1,mniDlm);
  end;
  DelStack;
end;

procedure LogTrnsValProc(var Prm: TLogTrnsValPrm);
const aTxt: array[0..1] of string = (fTXT,'MOV');
var i,j: byte;
  s: string;
label lend;
begin
  AddStack('FMain.LogTrnsValProc');
  with Prm do begin
    if LogEqual(Prm,tCDR) then begin
      if AnsiMatchText(nmf,[sMemo+'FLTPRG',sMemo+'ZAJPRG']) then begin
        TProgLogCompare.Execute(Prm,','); goto lend;
      end;
      for i:=low(aFlt) to high(aFlt) do with aFlt[i] do if nmf=deFltFld+f then begin
        LogEnumVal(Prm,aSex[sex]); goto lend;
      end;
    end;
    if LogEqual(Prm,tGLOB,OrgDatNmf) and Assigned(Main) then begin
      TOrgDatLogCompare.Execute(Prm,','); goto lend;
    end;
    if LogEqual(Prm,tMSG,'SEL') then begin
      val:=IfThen(val=MSG_DONE,'выполнено',IfThen(StrToBoolean(val),'прочитано','не прочитано')); lBreak:=true; goto lend;
    end;
    if LogEqual(Prm,[tMSG,tZAJ],[]) then for j:=low(aTxt) to high(aTxt) do begin
      i:=1;
      repeat
        s:=nmf254(i,aTxt[j]);
        if not Sender.IsField(s) then break;
        if nmf=s then begin
          if Length(av)=0 then AddFromVArr(av,[false,false]);
          if av[byte(lOld)] then lOut:=false
          else begin
            val:=aConcatTxt254(Sender,lOld,aTxt[j]); av[byte(lOld)]:=true;
          end;
          lBreak:=true; goto lend;
        end;
        Inc(i);
      until false;
    end;
    if nmf=fORG then begin
      nm:='клиент'; val:=ListKod(Int0(val)); lBreak:=true; goto lend;
    end;
  end;
lend:
  DelStack;
end;

initialization
  AddStack('FMain.initialization');
  OLTypes.c_ProgBeg:=c_ProgBeg; OLTypes.c_ProgEof:=c_ProgEof;
  OLTypes.c_ProgNext:=c_ProgNext; OLTypes.c_ProgEnd:=c_ProgEnd;
  OLTypes.SetInterFlt:=SetInterFlt;
  lStatus:=MaxSelf(aCdrStat);
  LogTrnsValProcAdd(LogTrnsValProc);
  DelStack;
finalization
  AddStack('FMain.finalization');
  lsIpClear;
  DelStack;
end.
