unit FDM;

interface

{$I ORGTEST}
uses
  Windows, SysUtils, Classes, Controls, DB, Math, Forms, StrUtils, FIBDataSet, FIBQUery, Grids, DBGrids,
  MyTypes, My_pr, RecVal, RecDB, FrmPswd, FFldedit, Codegets, BrQuery, FrmBrIB, ChkGets, DirGet, FDWPrm,
    Dateget, Schem, Inter, ButGet, BtTxtGet, DefEdit, CCodeGet, MenuGet, StrBrowl, KeyLb, MulQry, Browl,
    FPanel, Askp,
  ProgType,
  BuhTypes,
  OLTypes, OLProc, MemoGet;

type
  TBotN = record
    i: longint;
    id: string;
    lOff: boolean;
  end;

  TDM = class(TDataModule)
    ListGet: TCodeGet;
    SimpleGet1: TSimpleGet;
    RCdr: TRecDB;
    ROrg: TRecDB;
    RList: TRecDBDef;
    RVan: TRecDB;
    BoolMultiGet1: TBoolMultiGet;
    DirGet1: TDirGet;
    DrvGet: TCodeGet;
    RDrv: TRecDB;
    RProg: TRecDBDef;
    DateGet1: TDateGet;
    NumGet1: TNumGet;
    RadioGet1: TRadioGet;
    TblChkGet1: TTblChkGet;
    schBold: TSchem;
    MenuGet1: TMenuGet;
    ProgGet: TMenuGet;
    RZaj: TRecDB;
    RMsg: TRecDB;
    BtMskGet1: TBtMskGet;
    StatusGet: TRadioGet;
    RDoc: TRecDB;
    ProgCpGet: TCodeGet;
    ROfis: TRecDB;
    RCngv: TRecDB;
    RgnGet: TCodeGet;
    RRgn: TRecDB;
    ProgNpGet: TCodeGet;
    RProgCalc: TRecDBDef;
    TerrGet: TCodeGet;
    RTerr: TRecDB;
    RAcc: TRecDB;
    AccGet: TCodeGet;
    SrvGet: TCodeGet;
    RSrv: TRecDB;
    deAcc: TDefEdit;
    MgFbVers: TMenuGet;
    RFlt: TRecDB;
    FltGet: TButFormGet;
    Rec: TRecVal;
    deMsg: TDefEdit;
    deProgStat: TDefEdit;
    DeProgUser: TDefEdit;
    deProgCng: TDefEdit;
    btgCdr: TButTextGet;
    RMDV: TRecDB;
    RMDT: TRecDB;
    RMDP: TRecDB;
    RMDF: TRecDB;
    MDPGet: TCodeGet;
    MDFGet: TCodeGet;
    MDGVersGet: TMenuGet;
    procedure DataModuleCreate(Sender: TObject);
    procedure RUpNameCalculate(Sender: TCustomRec; lApp: boolean);
    procedure RListDWTrans(Sender: TObject; var sTrans: String; lSave: Boolean);
    procedure RListDWFldSeek(Sender: TObject; var a: TDWFldArrSeek; prAdd: TDWFldProcAdd);
    procedure RProgDWTrans(Sender: TObject; var sTrans: String; lSave: Boolean);
    function RProgDWCanDel(Sender: TObject; const VarName,MsgName: String): Boolean;
    procedure DataModuleDestroy(Sender: TObject);
    procedure RProgDWCngName(Sender: TObject; const OldName,NewName: String; var result: Boolean);
    procedure RProgDWFldSeek(Sender: TObject; var a: TDWFldArrSeek; prAdd: TDWFldProcAdd);
    procedure RProgDWVarValid(Sender: TObject; Proc: TProcVarValid; const r: TDWVidRec; var result: Boolean);
    procedure schBoldSample(Sender: TObject; Parent: TWinControl; var Header: String; var AfterRebuild: TNotifyEvent);
    function ListGetStrDop(Sender: TObject; Qry: TBrQuery): String;
    procedure RMsgNewRec(Sender: TRecDB; lcopy: Boolean; const gKey: String);
    procedure RZajCalculate(Sender: TCustomRec; lApp: boolean);
    procedure RDocNewRec(Sender: TRecDB; lcopy: Boolean; const gKey: String);
    function DrvGetStrDop(Sender: TObject; Qry: TBrQuery): String;
    function ProgCpGetStrName(Sender: TObject; Qry: TBrQuery): String;
    procedure RCngvNewRec(Sender: TRecDB; lcopy: Boolean; const gKey: String);
    procedure RProgCalculate(Sender: TCustomRec; lApp: boolean);
    procedure RRgnNewRec(Sender: TRecDB; lcopy: Boolean; const gKey: String);
    procedure RDrvNewRec(Sender: TRecDB; lcopy: Boolean; const gKey: String);
    function RProgDWRdbSeek(Sender: TObject): TRecDBDef;
    procedure RTerrNewRec(Sender: TRecDB; lcopy: Boolean; const gKey: String);
    procedure RSrvNewRec(Sender: TRecDB; lcopy: Boolean; const gKey: String);
    function SrvGetStrName(Sender: TObject; Qry: TBrQuery): String;
    procedure deAccFldChange(Sender: TObject; const OldVal: Variant; FromShow: Boolean);
    function deAccFldCheck(Sender: TObject): Boolean;
    procedure deAccFldEnter(Sender: TObject);
    procedure deAccFldExit(Sender: TObject);
    procedure RFltNewRec(Sender: TRecDB; lcopy: Boolean;
      const gKey: String);
    procedure RZajNewRec(Sender: TRecDB; lcopy: Boolean;
      const gKey: String);
    function AccGetStrDop(Sender: TObject; Qry: TBrQuery): String;
    function SrvGetStrDop(Sender: TObject; Qry: TBrQuery): String;
    procedure deMsgFrmShow(Sender: TObject);
    procedure deMsgFldChange(Sender: TObject; const OldVal: Variant;
      FromShow: Boolean);
    procedure deMsgPnlUpdateRec(Sender: TObject);
    procedure deProgStatFldChange(Sender: TObject; const OldVal: Variant;
      FromShow: Boolean);
    procedure deProgStatFldExit(Sender: TObject);
    function deProgStatPnlValid(Sender: TObject): Boolean;
    procedure DeProgUserFrmShow(Sender: TObject);
    procedure DeProgUserKpProcKey(key: Integer; tw: TWinControl);
    function DeProgUserPnlValid(Sender: TObject): Boolean;
    procedure deProgCngFldExit(Sender: TObject);
    function deProgCngFldCheck(Sender: TObject): Boolean;
    function deProgCngPnlValid(Sender: TObject): Boolean;
    function MDPGetStrName(Sender: TObject; Qry: TBrQuery): String;
    function NameGetTransSeek(Sender: TObject; tf: TFldEdit;
      const Value: String; Size: Integer; lSQL: Boolean): String;
    procedure RMsgCalculate(Sender: TCustomRec; lApp: Boolean);
  private
    { Private declarations }
    IntProgCalc: TInter;
    dFileBot: longint;
    lsBotN_ID: TIntStrList;
    function FGetBotN(const tn: string; var bn: TBotN): boolean;
  	function MsgMaxLength(Sender: TObject): longint;
  	function ZajMaxLength(Sender: TObject): longint;
    procedure TelCdrRead(Sender: TStringList);
		class procedure ProcKey(Key: longint; tw: TWinControl);
    class procedure BoolGet1DWFldInfo(Sender: TObject; const Mask: String; var FldInfo: TDWFldInfo);
		class procedure BoolGet1DWFldValue(Sender: TObject; r: TCustomRec; const Mask: String; var Value: Variant);
    class procedure AccGenPassKeyProc(key: longint; tw: TWinControl);
    class procedure DateToRec(r: TRecDB; const f,s: string; var d: TDateTime; var t: string); overload;
    class function DfrmDWCanDel(Sender: TObject; const VarName,MsgName: String): Boolean;
    class procedure DfrmDWCngName(Sender: TObject; const OldName,NewName: String; var result: Boolean);
  public
    { Public declarations }
    DataWin: TDataWin;
		function ProgCalc(lLog: boolean): boolean;
    procedure DateToRec(r: TRecDB; const f: string; const sEnd: string = ''); overload;
    procedure ProgCpGetInit(tf: TFldEdit; const cpwhere: string; g: TCodeGet);
		procedure qProgCalcFields(DataSet: TDataSet);
    procedure MsgApp;
    class procedure TabProc(key: longint; tw: TWinControl);
    class procedure deSelIspFldChange(Sender: TObject; const OldVal: Variant; FromShow: Boolean);
    class procedure ZajCalcFields(DataSet: TDataSet);
    class function brZajGrayCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState): Boolean;
    class procedure brZajDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  	class function ZajMovMaxLength(Sender: TObject): longint;
    procedure MsgDel(Sender: TObject);
    procedure TelCdrN;
    function GetBotN(const tn: string; var bn: TBotN): boolean;
    procedure SetBotN(const bn: TBotN);
    procedure DelBotN(const tn: string);
  end;

  TAccDataType = (ADF_ACTIVITY,ADF_INOUT,ADF_ONSRV);

  TWriteSetIniOpt = set of (winiWin,winiClearIniDirs);
  TPrep2RunOpt = set of (p2rRunMode,p2rMakeDir);
  TGetFbPortOpt = set of (fbpNotShowMsg,fbpRunMode);
  TExecFileOpt = set of (exfCrt,exfBound,exfNoCanEsc);

var
  DM: TDM;

function ProgSeek(const where,msg: string): boolean;
function ProgInf(Sender: TObject): TProgInf; overload;
function ProgInf: TProgInf; overload;
function ProgStatList(i: longint): TProgStatList;
function ProgFldFind(const nmf: string; var i: TOrdFixList): boolean;
function CdrStatList(i: longint): TCdrStatList;
function ListKod(ko: longint): string; overload;
function ListKod(r: TCustomRec): string; overload;
function ListKod: string; overload;
procedure ListKodLoad;
function DateTimeToString(d: TDateTime; const t: string): string;
function StringToDispDate(const s: variant; nFormat: byte = 1): string;
function IsSelfComp(const DrvName: string): boolean;
function IPToHost(const ip: string): string;
procedure MsgFindError(const msg: string);
function GetMaxStrDate: string;
procedure nmf254CreateField(q: TMulQuery; r: TRecDB; const sBeg: string = fTXT);
function aConcatTxt254(Sender: TObject; lOld: boolean = false; const sBeg: string = fTXT): string; overload;
procedure aSplitTxt254(Sender: TRecDB; const aTxtSplit: string; lLog: boolean = false; lmax: PLongint = nil; const sBeg: string = fTXT); overload;
function NeedClearProgDir(const aProgKP: string): boolean;
function NeedClearFbVers(const aProgKP: string): boolean;
function ZajFldName(i: TOrdFixzList): string;
function GetRandom(sz: longint): string;
function GetRandom10: string;
function GetSftpBlinkState(const aTn: string): boolean;
procedure FillSftpSb(const aTn: string; sb: TStringBrowl; isInExists: System.pboolean=nil;
  aCol2Sort: longint=0);
function GetAccData(adf: TAccDataType; aAccId: longint): longint;
function Activity2Str(aMinutes: longint): string;
function Inout2Str(aInout: longint): string;
function GetSftpDataDir(const aDir: string): string;
function AcidAsStr(const s: string): string;
function SYSDBA: boolean;
procedure ZajEdSetKey(tl: TKeyLb; proc: TKeyProc);
function Str2SelIsp(const Value: string): string; overload;
function Str2SelIsp(f: TField): string; overload;
procedure Str2SelIspSelf(var Value: string);
function SelIsp2Str(const a: TSelIspArr; an: PArrTN = nil): string;
procedure SelIspSet(const Value: string);
function lsFldLabel(ls: TFldList; i: longint): string;
function CngCopyDir(const mem_f,ccopydir,cdircopy: string): boolean;
procedure ProgLogKeysAdd;
procedure MsgLogKeysAdd;
function Int2Ispv(i: longint): TIspVidList;
function IspCalc(q: TMulQuery): string;
function CdrOrdZajDef(CntSel: longint; const aClr,aOrd: array of longint): string;
procedure qSetWhere(br: TBrowl; const cwhere,vflt,defOrgKod: string; Inter: TInter;
  pnh: TRbPanel; fd: PFltDef; afCdr,afOrg,afProg: array of string; var lFiltered: boolean;
  lsRec: TIntegerList);
function ProgTp: TProgType;
function MakeFullPath(const ProgND: string; const ProgDir: string = ''): TFileName; overload;
function MakeFullPath(const ProgND,ProgDir: string; var dir: TFileName): boolean; overload;
function Prepare2RunProg(out dir: TFileName; const aProgType: TProgType; Opt: TPrep2RunOpt;
  pPort: PString = nil): boolean; 
function GetFbPort(aRdbDrv: TRecDB; const aVers,aPorts: array of string; const aFbVers: string;
  Opt: TGetFbPortOpt = []; aAborted: pboolean=nil): string;
function RegNum: string; overload;
procedure Write_SET_XXX_Ini(const progSid,progTn,progKP,progND,progDIR,progFbVers: string;
  progKo: longint; progStatus: TProgStatList; const progCP,progCPA: string;
  out dir: TFileName; Opt: TWriteSetIniOpt; const fileSftp: string=''); overload;
procedure Write_SET_XXX_Ini(out dir: TFileName; Opt: TWriteSetIniOpt = []; const fileSftp: string=''); overload;
procedure SetInfo;
function ExecFile(Sender: TAsk; Opt: TExecFileOpt = [];
  tp: TIndFileTypes = [low(TIndFileType)..high(TIndFileType)]; pSucced: PBoolean = nil): boolean; overload;
function ExecFile(Sender: TAsk; lCrt: boolean; tp: TIndFileType): boolean; overload;
function ExecFile(Opt: TExecFileOpt; const ChrsExt: string; pSucced: PBoolean = nil): boolean; overload;
procedure SetStatusNone(const where: string);
function LockBuhRead: boolean;
function LockBuhWrite: boolean;
procedure ListSave;
procedure ListRest;
function DBBuh: TComponent;
function IfThen(AValue: boolean; ATrue: TZajEditOpt = []): TZajEditOpt; overload;

implementation

uses
  DateUtils,ShellApi,Variants,
  KeyMenu,BufFile,SpGet,FDWVid,FDWFld,GGMReg,Shifr,FSchemDM,FldMask,FrmEdt,FEdText,FStat,FDFrmLs,FDFrmEd,
  SggUtils,FbServices,FSGWMain,FCopyLs,
  FPswdEd;

{$R *.dfm}
{$B-}

type
  TCodLogCompare = class(TDlmLogCompare)
  public
    class function ListCreate(pv: pointer; const Value: string; lNew: boolean): pointer; override;
    class procedure GetItem(var Prm: TLogTrnsValPrm; pv,lso,lsn: pointer; no,nn: longint; tp: TLogCompareItemList); override;
  end;

  TCngvLogCompare = class(TDlmLogCompare)
  public
    class function ListCreate(pv: pointer; const Value: string; lNew: boolean): pointer; override;
    class procedure ListDestroy(pv,ls: pointer); override;
    class function GetCount(pv,ls: pointer): longint; override;
    class procedure GetItem(var Prm: TLogTrnsValPrm; pv,lso,lsn: pointer; no,nn: longint; tp: TLogCompareItemList); override;
  end;

const
  FLD_FBVERSPORT: array[0..1,1..5] of string = (
    ('FBVERS','FBVERS2','FBVERS3','FBVERS4','FBVERS5'),
    ('FBPORT','FBPORT2','FBPORT3','FBPORT4','FBPORT5')
  );

  ACTIVITY_EMPTY = MaxInt;

  cBotOff='*'; lBotOff=Length(cBotOff);

var lsRec: TIntStrList;
  lsAcc: TIntegerList = nil;
  adAcc: array of record
    adTime: longword;
    adActivity,adOnsrv: longint;
    adInout: TAccInOut;
  end;
  nSvi: longint;
  aSvi: array of record
    recno: longint;
  	af: TArrFldVal;
  end;
  lsHost: TStrStrList;

function ProgSeek;
begin
  AddStack('FDM.ProgSeek');
  with ProgPswd.GetQuery do begin
    PartSelect(tPROG,[fORG,fProgKP],where); result:=IsRecords;
    if result then mess_ok([msg,'Клиент: '+Trim(DM.ListGet.Codest(ListKod(Fields[0].AsInteger))),
      'Программа: '+Trim(ProgInf(ProgPswd.CurQuery).Name)]);
    ProgPswd.FreeQuery;
  end;
  DelStack;
end;

function ProgInf(Sender: TObject): TProgInf;
var v: variant;
begin
  AddStack('FDM.ProgInf');
  if Assigned(Sender) then v:=FldValue(Sender,fProgKP) else v:=null;
  if MyVarType(v)=varString then result:=GetProgInf(Int0(v))
  else begin
    Finalize(result); ZeroMemory(@result,SizeOf(result));
  end;
  DelStack;
end;

function ProgInf: TProgInf;
begin
  result:=ProgInf(Prog);
end;

function ProgStatList;
begin
  AddStack('FDM.ProgStatList');
  result:=TProgStatList(EnsureRange(i,byte(low(TProgStatList)),byte(high(TProgStatList))));
  DelStack;
end;

function ProgFldFind;
begin
  AddStack('FDM.ProgFldFind');
  result:=false; i:=1;
  while i<=ofxCnt do if ProgFld[i].ofvFld=nmf then begin
    result:=true; break;
  end
  else Inc(i);
  DelStack;
end;

function CdrStatList;
begin
  AddStack('FDM.CdrStatList');
  result:=TCdrStatList(EnsureRange(i,byte(low(aCdrStat)),byte(high(aCdrStat))));
  DelStack;
end;

function ListKod(ko: longint): string;
begin
  AddStack('FDM.ListKod');
  result:=lsRec.FindValue(ko);
  DelStack;
end;

function ListKod(r: TCustomRec): string;
begin
  result:=ListKod(r[fORG]);
end;

function ListKod: string;
begin
  result:=ListKod(Prog);
end;

procedure ListKodLoad;
var i: longint;
begin
  AddStack('FDM.ListKodLoad');
  lsRec.Clear;
  with PswdEd.GetQuery do begin
  	PartSelect(tLIST,[nmfbKOD,nmfbKO,fRECNO],'',nmfbKO); i:=RecordCount; lsRec.Capacity:=i;
    for i:=1 to i do begin
      lsRec.Add(Fields[1].AsInteger,TrimRight(Fields[0].AsString)); Next;
    end;
  	PswdEd.FreeQuery;
  end;
  DM.ListGet.BufCodLoadAll;
  DelStack;
end;

function DateTimeToString;
var Hour,Min,Sec,MSec: Word;
begin
	AddStack('FDM.DateTimeToString');
  if not empty(d) then begin
    Hour:=Int0(LeftStr(t,2));
    Min:=Int0(Copy(t,4,MaxInt));
    Sec:=0;
    MSec:=0;
    IncD(d,EncodeTimeTry(Hour,Min,Sec,MSec));
  end;
  result:=DateToString(d);
  DelStack;
end;

function StringToDispDate;
const aFormat: array[1..4] of string = ('dd/mm/yy (hh:nn)','dd/mm/yyddd hh:nn','dd/mm/yyddd','hh:nn dd/mm/yyddd');
var d: TDateTime;
begin
	AddStack('FDM.StringToDispDate');
  if MyVarType(s)=varString then d:=StringToDate(s) else d:=IsNilc(s,DateEmpty);
  if empty(d) then result:='' else result:=OurFormatDateTime(aFormat[nFormat],d);
  DelStack;
end;

function IsSelfComp;
begin
  AddStack('FDM.IsSelfComp');
  result := not IsNetDrive(DrvName) or (TrimUpper(CompName) = AnsiUpperCase(DlmCopy(DrvName,3,1,PathDelim)));
  DelStack;
end;

function IPToHost;
const ipCnt = 4;
var i: longint;
  a: array[1..ipCnt] of string;
  a1: TNamePrimStr;
begin
  AddStack('FDM.IPToHost');
  result:=StrTran(ip,' ','');
  if ProgPswd.Rec['IPToHost'] then begin
  	if not Assigned(lsHost) then begin
    	lsHost:=TStrStrList.Create(false); lsHost.NoDelObj:=true; lsHost.Init(GetStrFile(FileHosts)); i:=0;
      while i<lsHost.Count do begin
        LsArrFill(DelTrim(lsHost[i]),a1,' ');
        if ListAsArray(a1[1],a,'.')=ipCnt then begin
        	lsHost[i]:=StrTran(a1[1],' ',''); lsHost.Value[i]:=a1[2]; Inc(i);
        end
        else lsHost.Delete(i);
      end;
      lsHost.Sorted:=true;
    end;
    lsHost.FindValue(result,result);
  end;
  DelStack;
end;

procedure MsgFindError;
begin
  mess_ok([msg+'.',
    'Большая просьба запомнить свои действия до этого момента',
    'и обратиться к разработчику Островскому Б.Л.']);
  OutStack(msg+'.');
end;

{ TDM }
const ZpwDir='C:'+PathDelim+'DPROG'+PathDelim+'ZPN'+PathDelim;

procedure CopyFromZpw(const av: array of variant; const sr: TSearchRec; var lDone: boolean);
begin
  AddStack('FDM.CopyFromZpw');
  CopyFileOpt(ZpwDir+sr.Name,ExeDir+sr.Name);
  DelStack;
end;

procedure TDM.DataModuleCreate(Sender: TObject);
var lCng: boolean;
  s,pggm: string;
  function DpMustCopy(const fn: string): boolean;
  begin
    AddStack('TDM.DataModuleCreate.DpMustCopy',Self);
    result := CompareUtils(s+fn,pggm+DIR_UTEXE+PathDelim+fn)>0;
    if result then begin
      lCng:=true; result := CompareUtils(s+fn,pggm+DIR_UTEXE_NEW+PathDelim+fn)>0;
    end;
    DelStack;
  end;
var i: longint;
  sl: TStringList;
  lDone: boolean;
  od: TOrgDatList;
begin
  AddStack('TDM.DataModuleCreate',Self);
  lTrash:=DirectoryExists(ExeDir+'TRASH');
  if lTrash then begin
    MaskFilesProc(ZpwDir+'STD.*',CopyFromZpw,[]);
    MaskFilesProc(ZpwDir+'SCILEXER.DPG',CopyFromZpw,[]);
  end;
  with ListGet,MulPar do begin
    FieldsCode:=nmfbKOD; LenCode:=CODSZ_ORG;
    Values[sC_LIST]:=ArrayAsList([nmfbKOD,fNAME,fUPNAME,nmfbKO],',');
    Values[sWHERE]:=nmfbKOD+qCod_C;
  end;
  SchemDM.RestSchem(schBold);
  SchemDM.BoolGet1.OnDWFldInfo:=BoolGet1DWFldInfo;
  SchemDM.BoolGet1.OnDWFldValue:=BoolGet1DWFldValue;
  Glob:=ProgPswd.RecGlob; Cdr:=RCdr; Org:=ROrg; List:=RList; Van:=RVan; Prog:=RProg; Drv:=RDrv;
  Zaj:=RZaj; Msg:=RMsg; Doc:=RDoc; Ofis:=ROfis; Cngv:=RCngv; Rgn:=RRgn; Terr:=RTerr;
  Acc:=RAcc; Srv:=RSrv; Flt:=RFlt; MDP:=RMDP; MDF:=RMDF; MDV:=RMDV; MDT:=RMDT;
  OpenDB;
  GlobDIRLAST:=Trim(Glob['DIRLAST']);
  GlobTELPATH:=CorrDir(Glob['TELPATH']); GlobTELPATHOUT:=GlobTELPATH+TelPathOut;
  GlobTELCDR:=GlobTELPATH+TelFilePrm; GlobTELREAD:=GlobTELPATH+'прочитанныеУК'; 
  GlobLASTCNT:=Glob['LASTCNT']; GlobLASTDAY:=Glob['LASTDAY'];
  GlobOTDNUM:=Glob['OTDNUM']; GlobVIDNO:=Glob['VIDNO'];
  for od:=low(OrgDatNmf) to high(OrgDatNmf) do GlobORGDAT[od]:=TrimRight(Glob[OrgDatNmf[od]]);
  if not Van.Active then
    if ProgPswd.DBConnect(DBBuh,'BUH','Ошибка подключения к данным "Бухгалтерии"') then begin
      if LockBuhWrite then
        try
          CopyTable(DBBuh,DBMain,tVAN,ttNone);
        finally
          UnlockMode('FBUH');
        end
      else Application.Terminate;
      SetConnected(DBBuh,false); OpenDB;
    end;
  if LockBuhRead then
    try
      Van.Seek(Van.TblFldName('VIDNO')+'='+QQs(GlobVIDNO));
      List.InitFldDef(dwdefGotoRec);
      Prog.InitFldDef(dwdefGotoRec);
      ListKodLoad;
    finally
      UnlockMode('FBUH');
    end
  else Application.Terminate;
  TKeyLb.SetFixKey(K_Ctrl_I,'О пользователе',ProcKey,kmHelp);
  TKeyLb.SetFixKey(K_Alt_D,'Просмотр протокола',ProcKey,kmDesign);
  if lTrash then TKeyLb.SetFixKey(K_Alt_C,'',ProcKey,kmHelp);
  DataWin:=TDataWin.Create; lCdrTN:=Length(Cdr[fCDR]);
  lProgCP:=Length(Prog[fProgCP]); lProgNP:=Length(Prog[fProgNP]); lProgKP:=Length(Prog[fProgKP]);
  lPhone:=Length(Cdr['PHONE']);

  sl:=ProgGet.Items;
  sl.BeginUpdate;
  try
    sl.Capacity:=Length(ProgInfs);
    for i:=low(ProgInfs) to high(ProgInfs) do sl.Add(SpaceStr(i,lProgKP)+UnDelim+ProgInfs[i].Name);
  finally
    sl.EndUpdate;
  end;

  sl:=MgFbVers.Items;
  sl.BeginUpdate;
  try
    sl.Capacity:=Length(FBSERVODS);
    for i:=low(FBSERVODS) to high(FBSERVODS) do sl.Add(FBSERVODS[i,2]+UnDelim+FBSERVODS[i,0]);
  finally
    sl.EndUpdate;
  end;

  TDFrmLs.Init;
  TDFrmEd.Init(DfrmDWCanDel,DfrmDWCngName);
  IntProgCalc:=TInter.Create('Формула вычисления данных по программе');
  IntProgCalc.ShowError:=false; IntProgCalc.SetProg(Glob[sMemo+'CALC']);
  TTimeCurGet.Create(Self);
  StatusGet.Items.Text:=ArrayAsList(aProgStat[stvName],CRLF);
  SetStatusNone('');
  TVarChkGet.Create(Self);
  Rec.CreateFld(fCDR,ftString,lCdrTn,InitFIni[fiSave].ReadString('Main','TN'));
  Rec.CreateFld('TNSTATUS',ftString,lStatus,'');
  Rec.CreateFld('CopyND',ftString,Length(Prog[fDRV]),'');
  Rec.CreateFld('PROG',ftString,length(ProgInfs),'');
  Rec.CreateFld('KOD',ftString,ListGet.LenCode,'');
  Rec.CreateFld('STATUS',ftString,Length(Cdr['FLTSTATUS']),'');
  Rec.CreateFld('ZajMovCP',ftString,Length(Zaj[fProgCP]),'');
  Rec.CreateFld('PUPASS',ftString,Length(Prog['PUPASS']),'');
  Rec['OtdDir']:=InitFIni[fiSave].ReadString('Main','OtdDir');
  with deMsg do begin
    Param['MSGTXT',deMask]:=TSpGkLs.GetPrm(tMSG);
    AssignGet('TIME',TTimeCurGet);
    AssignGet('TIME1',TTimeCurGet);
  end;
  s:=Trim(Glob[sMemo+'DP']);
  if s<>'' then begin
    pggm:=Trim(GetRegKey(HKEY_LOCAL_MACHINE,REGSTR_PATH_GGMASTER,REGSTR_KEY_GGMASTER));
    if pggm<>'' then begin
      lCng:=false; CorrDirSelf(s); CorrDirSelf(pggm); lDone:=ForceDirMsg(pggm+DIR_UTEXE_NEW);
      if lDone then begin
        if DpMustCopy(GGMasterSetupExeFile)
        then lDone:=CopyFileOpt(s+GGMasterSetupExeFile,pggm+DIR_UTEXE_NEW+PathDelim+GGMasterSetupExeFile,[cfStat,cfMsg]);
        if lDone then begin
          sl:=TStringList.Create;
          try
            IncD(s,DIR_UTEXE+PathDelim); GetMaskFiles(sl,s+DOP_PREFIX+'*'); i:=0;
            while i<sl.Count do begin
              if not(FileMaskEquate(sl[i],DOP_PREFIX+UTILCOD_SFTP+'*')
              or FileMaskEquate(sl[i],DOP_PREFIX+UTILCOD_SFTPUP+'*')) then
                if DpMustCopy(sl[i]) then begin
                  Inc(i); continue;
                end;
              sl.Delete(i);
            end;
            if sl.Count>0 then begin
              sl.Sorted:=true; lDone:=DiskWait(pggm+DIR_UTEXE_NEW+PathDelim,s,Ls2Var(sl));
            end;
          finally
            sl.Free;
          end;
        end;
        if lDone and lCng then begin
          s:=pggm+GGMasterExeFile;
          if FileExists(s) then ShellExecute(0,nil,PChar(s),nil,PChar(pggm),SW_SHOW);
        end;
      end;
    end;
  end;
  DelStack;
end;

procedure TDM.DataModuleDestroy(Sender: TObject);
begin
	AddStack('TDM.DataModuleDestroy',Self);
  InitFIni[fiSave].WriteString('Main','TN',Rec[fCDR]);
  InitFIni[fiSave].WriteString('Main','OtdDir',Rec['OtdDir']);
  DataWin.Free; IntProgCalc.Free; lsBotN_ID.Free; 
  DelStack;
end;

class procedure TDM.ProcKey;
begin
	AddStack('TDM.ProcKey');
  TKeyLb.FixKeyShow(Key,false);
  case Key of
    K_Ctrl_I: ViewUserInfo;
    K_Alt_C: NotD(CopyCommandToClipBoard);
    K_Alt_D: ProgPswd.ViewDerTbl;
  end;
  TKeyLb.FixKeyShow(Key,true);
  DelStack;
end;

class procedure TDM.TabProc;
begin
  AddStack('TDM.TabProc');
  GetParentForm(tw).ModalResult:=mrOk;
  DelStack;
end;

class procedure TDM.deSelIspFldChange;
var tf: TFldEdit;
  tm: TFldMask;
begin
  AddStack('TDM.deSelIspFldChange');
  // Чтобы было видно последнее значение
  tf:=pointer(Sender);
  if tf.NameRecFld='SELISPSH' then if ComponentsClass(tf,TFldMask,pointer(tm)) then tm.SelectAll;
  DelStack;
end;

procedure TDM.DateToRec(r: TRecDB; const f: string; const sEnd: string = '');
var d: TDateTime;
  t: string;
begin
  DateToRec(r,f,r.FldName(f).GetStrVal,d,t); Rec['DATE'+sEnd]:=d; Rec['TIME'+sEnd]:=t;
end;

class procedure TDM.DateToRec(r: TRecDB; const f,s: string; var d: TDateTime; var t: string);
var v: string;
begin
  AddStack('TDM.DateToRec');
  if MyVarType(r[f])=varString then v:=s else v:=DateToString(Float0(s));
  d:=stod(v); t:=TTimeCurGet.DateToTime(StringToDate(v));
  DelStack;
end;

class function TDM.DfrmDWCanDel;
var s: string;
  sai: TDWSearchAInfo;
begin
  AddStack('TDM.DfrmDWCanDel');
  //result:=RDBCanDel(Dfrm,sMemo+'W',VarName,MsgName,['FRM'],[sAlg]);
  s:=Dfrm[sMemo+'W'];
  try
    result:=DataWinSearchIdent(DataWinCreate,s,VarName,sai);
  finally
    DataWinFree;
  end;
  if (result) then s:='окне ввода'
  else begin
    result:=TInter.SearchIdent(Dfrm[sMemo+'FRM'],VarName);
    if result then s:='алгоритме';
  end;
  if (result) then meserr(Format('Данное "%s" используется в %s.',[MsgName,s]));
  NotD(result);
  DelStack;
end;

class procedure TDM.DfrmDWCngName;
var s: string;
begin
  AddStack('TDM.DfrmDWCngName');
  s:=Dfrm[sMemo+'W'];
  try
    DataWinReplaceIdent(DataWinCreate,s,OldName,NewName);
  finally
    DataWinFree;
  end;
  Dfrm[sMemo+'W']:=s;
  s:=Dfrm[fFRM];
  TInter.ReplaceIdent(s,OldName,NewName);
  Dfrm[fFRM]:=s;
  DelStack;
end;

procedure TDM.ProgCpGetInit;
var ko: string;
begin
  AddStack('TDM.ProgCpGetInit',Self);
  ko:=Vtos(Int0(ListGet.CodeDop(tf,Rec['KOD'],[cdgBufAll])));
  g.MulPar.Values['cp']:=cpwhere;
  g.MulPar.Values['ko']:=ko;
  g.GlobKey:=ko;
  g.ClearBuf;
  DelStack;
end;

class procedure TDM.ZajCalcFields;
var f: TField;
  function CalcPer(q: TMulQuery; const vid: string): boolean;
  var d: TDateTime;
  begin
    AddStack('TDM.ZajCalcFields.CalcPer');
    with q do begin
      result:=false;
      if FindField(vid+'D',f) then begin
        d:=StringToDate(f.AsString);
        result:=not empty(d);
        if result then
          if FindField('C'+vid+'D',f) then
            f.AsString:=FormatDateTime('dd/mm/yyddd hh:nn-',d)+FormatDateTime('hh:nn',StringToDate(FindField(vid+'D1').AsString));
      end;
    end;
    DelStack;
  end;
var q: TMulQuery;
begin
  AddStack('TDM.ZajCalcFields');
  q:=MulQueryOwner(DataSet);
  with q do begin
    if FindField('CTD',f) then f.AsString:=StringToDispDate(FindField(fTD).AsString,2);
    if FindField('CTXT',f) then f.AsString:=DelTrim(StrTran(aConcatTxt254(q),CRLF,' '));
    if FindField('CMOV',f) then f.AsString:=DelTrim(StrTran(aConcatTxt254(q,false,'MOV'),CRLF,' '));
    if FindField('CTN',f) then f.AsString:=CdrGet.CodeName(FindField(fCDR).AsString,[cdgBufAll]);
    if CalcPer(q,'TISP') then begin
      if FindField('CISPTN',f) then f.AsString:=CdrGet.CodeName(FindField('ISPTN').AsString,[cdgBufAll]);
      if FindField('CISPV',f) then f.AsString:=aIspv[Int2Ispv(FindField('ISPV').AsInteger)];
    end;
    CalcPer(q,'TW');
    if FindField('CWTN',f) then f.AsString:=CdrGet.CodeName(FindField('WTN').AsString,[cdgBufAll]);
    if FindField('CSELISPSH',f) then f.AsString:=Str2SelIsp(FindField('SELISPSH'));
    if FindField('CCALC',f) then f.AsString:=IspCalc(q);
    if FindField('CTSELISP',f) then f.AsString:=StringToDispDate(FindField('TSELISP').Value,2);
    if FindField('CTSELISPE',f) then f.AsString:=StringToDispDate(FindField('TSELISPE').Value,4);
  end;
  DelStack;
end;

class function TDM.brZajGrayCell;
begin
	AddStack('TDM.brZajGrayCell');
  result:=not empty(TBrowl(Sender).Qry.FindField('TISPD').AsString);
  DelStack;
end;

class procedure TDM.brZajDrawColumnCell;
begin
  AddStack('TDM.brZajDrawColumnCell');
	TBrowl(Sender).bmCheckPaint(Rect,['LSET','SEL'],Column);
  DelStack;
end;

procedure TDM.MsgDel;
var fl: boolean;
begin
  AddStack('TDM.MsgDel',Self);
  if Msg[fMsgTNFROM]=Rec[fCDR] then Msg['DELFROM']:=bTrue;
  if Msg[fMsgTNTO]=Rec[fCDR] then Msg['DELTO']:=bTrue;
  ProgPswd.CngLogVid(logvDelRec); fl:=StrToBoolean(Msg['DELTO']);
  if StrToBoolean(Msg['DELFROM']) and (fl or (TrimUpper(Msg['SEL'])=bFalse)) then Msg.DelRec('',[delLog])
  else begin
  	if fl then Msg['SEL']:=MSG_DONE;
  	Msg.UpdateRec(true);
  end;
  DelStack;
end;

function TDM.ProgCalc;
begin
  AddStack('TDM.ProgCalc',Self);
  result:=IntProgCalc.EvalChk;
  if result then Prog.UpdateRec(lLog)
  else result := InterShowError(IntProgCalc,[ieEsc],nil,nil,'Формула вычисления данных по программе')=mrOk;
  DelStack;
end;

procedure TDM.RUpNameCalculate(Sender: TCustomRec; lApp: boolean);
begin
	AddStack('TDM.RUpNameCalculate',Self);
  with TRecDB(Sender) do Value[fUPNAME]:=AnsiUpperCase(Value[fNAME]);
  DelStack;
end;

// Prog
procedure TDM.RProgCalculate(Sender: TCustomRec; lApp: boolean);
begin
  AddStack('TDM.RProgCalculate',Self);
  if not CanCngStatus and (not lApp) and (Prog.FldName('STATUS').OldValue<>Prog['STATUS']) then begin
    Prog['STATUS']:=Prog.FldName('STATUS').OldValue;
    MsgFindError('Попытка смены статуса программы ('+Trim(ListKod)+'-'+Trim(Prog[fProgNP])+')');
  end
  else if Prog['STATUS']=stpTemp then Prog[fProgCP]:='';
  if (NeedClearFbVers(Prog[fProgKP])) then Prog['FBVERS']:='';
  DelStack;
end;

procedure TDM.RProgDWTrans(Sender: TObject; var sTrans: String; lSave: Boolean);
begin
	AddStack('TDM.RProgDWTrans',Self);
  if lSave then Glob[sMemo+'PROGD']:=sTrans else sTrans:=Glob[sMemo+'PROGD'];
  DelStack;
end;

function TDM.RProgDWCanDel(Sender: TObject; const VarName, MsgName: String): Boolean;
var a: TDWSearchAInfo;
begin
	AddStack('TDM.RProgDWCanDel',Self);
  result := not DataWinSearchIdent(DataWin,Glob[sMemo+'PROGW'],VarName,a);
  if not result then mess_ok(['Данное "'+MsgName+'" используется',
  	'в окне ввода данных по программе.']);
  DelStack;
end;

procedure TDM.RProgDWCngName(Sender: TObject; const OldName,
  NewName: String; var result: Boolean);
var s: string;
begin
	AddStack('TDM.RProgDWCngName',Self);
	if result then begin
    s:=Glob[sMemo+'PROGW'];
    if DataWinReplaceIdent(DataWin,s,OldName,NewName) > 0 then Glob[sMemo+'PROGW']:=s;
  end;
  DelStack;
end;

procedure TDM.RProgDWFldSeek(Sender: TObject; var a: TDWFldArrSeek;
  prAdd: TDWFldProcAdd);
begin
	AddStack('TDM.RProgDWFldSeek',Self);
	PrAdd(a,Glob[sMemo+'PROGD'],Glob[sMemo+'PROGW'],true); PrAdd(a,Glob[sMemo+'PROGD']);
  DelStack;
end;

function TDM.RProgDWRdbSeek(Sender: TObject): TRecDBDef;
begin
  AddStack('TDM.RProgDWRdbSeek',Self);
  result:=Prog;
  DelStack;
end;

procedure TDM.RProgDWVarValid(Sender: TObject; Proc: TProcVarValid;
  const r: TDWVidRec; var result: Boolean);
begin
	AddStack('TDM.RProgDWVarValid',Self);
  Proc(r,result,Glob[sMemo+'PROGW'],'Окно ввода данных по программе');
  DelStack;
end;

// Drv
procedure TDM.RDrvNewRec(Sender: TRecDB; lcopy: Boolean; const gKey: String);
begin
  AddStack('TDM.RDrvNewRec',Self);
  Drv.KodNextSelf(fDRV);
  DelStack;
end;

// Zaj
procedure TDM.RZajNewRec(Sender: TRecDB; lcopy: Boolean;
  const gKey: String);
begin
  AddStack('TDM.RZajNewRec',Self);
  Zaj['CNTISP']:=1;
  DelStack;
end;

function GetMaxStrDate;
begin
  result:=DateTimeToString(EncodeDateTry(9999,MonthsPerYear,31),'');
end;

procedure TDM.RZajCalculate(Sender: TCustomRec; lApp: boolean);
var s: string;
begin
	AddStack('TDM.RZajCalculate',Self);

  if (lApp) then Zaj.GetMaxFldSelf('NZ');

  if (empty(Zaj['TISPD']))or(not empty(Zaj[fTD])) then s:=Zaj[fTD] else s:=Zaj['TISPD'];
  Zaj['TDISPD']:=s;

  s:=Zaj['TWD'];
  if (Trim(s)='') then s:=GetMaxStrDate;
  Zaj['TWDSORT']:=s;

  DelStack;
end;

// Msg
procedure TDM.RMsgNewRec(Sender: TRecDB; lcopy: Boolean; const gKey: String);
begin
	AddStack('TDM.RMsgNewRec',Self);
  Msg[fTD]:=DateToString(Now);
  Msg['TD1']:=Msg[fTD];
  Msg['SEL']:=bFalse;
  if lcopy then begin
    Msg['DELFROM']:=bFalse;
    Msg['DELTO']:=bFalse;
  end
  else begin
	  Msg[fMsgTNFROM]:=Cdr[fCDR];
    Msg[fMsgTNTO]:=Cdr[fCDR];
  end;
  DelStack;
end;

procedure TDM.RMsgCalculate(Sender: TCustomRec; lApp: Boolean);
var txt: string;
  bn: TBotN;
  fTNTO: TFld;
begin
  AddStack('TDM.RMsgCalculate',Self);
  if GlobTELPATH<>'' then begin
    txt:=TrimRight(aConcatTxt254(Sender)); fTNTO:=Sender.FldName(fMsgTNTO);
    //После добавления или редактирования текста или получателя сообщения создать папку GLOB.TELPATH\исходящие
    if lApp or (txt<>TrimRight(aConcatTxt254(Sender,true))) or fTNTO.Modified then
      //если в CDR.TEL ID отправителя определено и не отключен
      if GetBotN(fTNTO.Value,bn) then if not bn.lOff
      then TelMsgAdd(GlobTELPATHOUT,Msg.Recno,NowDouble,Sender['TD1'],bn.id,
        Trim(CdrGet.Codest(Sender[fMsgTNFROM]))+CRLF+txt);
  end;
  DelStack;
end;

procedure TDM.TelCdrN;
var f: TFileBuf;
  tn: string;
  bn: TBotN;
begin
  AddStack('FDM.TelCdrN');
  if GlobTELPATH<>'' then with PswdEd.GetQuery do begin
    PartSelect(tCDR,[fCDR,fNAME],'',fCDR); f:=TFileBuf.Create(GlobTELCDR,true);
    try
      while not Eof do begin
        tn:=Trim(Fields[0].AsString);
        if not FGetBotN(tn,bn) then begin
          Finalize(bn); ZeroMemory(@bn,SizeOf(bn));
        end;
        f.WriteString(tn+'='+Trim(Fields[1].AsString)+','+bn.id+','+bStr[bn.lOff],[wrCrlf]); Next;
      end;
    finally
      f.Free;
    end;
    PswdEd.FreeQuery;
  end;
  DelStack;
end;

function TDM.GetBotN;
begin
  AddStack('TDM.GetBotN',Self);
  result:=false;
  if GlobTELPATH<>'' then if ForceDirMsg(GlobTELPATHOUT) then begin
    if not Assigned(lsBotN_ID) then lsBotN_ID:=TIntStrList.Create;
    if not GetStrFile(dFileBot,GlobTELCDR,nil,TelCdrRead) then with lsBotN_ID do begin
      Clear; SetOption(ilsSorted,true);
    end;
    result:=FGetBotN(tn,bn);
  end;
  DelStack;
end;

procedure TDM.TelCdrRead;
var i: longint;
  a: array[1..3] of string;
begin
  AddStack('TDM.TelCdrRead',Self);
  with lsBotN_ID do begin
    i:=Sender.Count; SetOption(ilsSorted,false); Clear; Capacity:=i;
    for i:=0 to i-1 do begin
      ListAsArray(Sender.ValueFromIndex[i],a,',');
      if a[2]<>'' then Add(Int0(Sender.Names[i]),IfThen(StrToBoolean(a[3]),cBotOff)+a[2]);
    end;
    SetOption(ilsSorted,true);
  end;
  DelStack;
end;

function TDM.FGetBotN;
begin
  AddStack('TDM.FGetBotN',Self);
  with bn do begin
    result:=lsBotN_ID.Find(Int0(tn),i);
    if result then begin
      id:=lsBotN_ID.Value[i]; lOff := StrToChar(id)=cBotOff;
      if lOff then Delete(id,1,lBotOff);
    end;
  end;
  DelStack;
end;

procedure TDM.SetBotN;
begin
  AddStack('TDM.SetBotN',Self);
  with bn do lsBotN_ID.Value[i]:=IfThen(lOff,cBotOff)+id;
  TelCdrN;
  DelStack;
end;

procedure TDM.DelBotN;
var bn: TBotN;
begin
  AddStack('TDM.DelBotN',Self);
  if GetBotN(tn,bn) then begin
    lsBotN_ID.Delete(bn.i); TelCdrN;
  end;
  DelStack;
end;

// Doc
procedure TDM.RDocNewRec(Sender: TRecDB; lcopy: Boolean; const gKey: String);
begin
	AddStack('TDM.RDocNewRec',Self);
  Doc.KodNextSelf(fDOC);
  Doc[fCDR]:=Cdr[fCDR];
  DelStack;
end;

// Cngv
procedure TDM.RCngvNewRec(Sender: TRecDB; lcopy: Boolean; const gKey: String);
var s: string;
  ldel: boolean;
begin
	AddStack('TDM.RCngvNewRec',Self);
	Cngv.KodNextSelf(fCNGV);
  Cngv['DT']:=0;
  for ldel:=false to true do SetByte(s,1+byte(ldel),true);
  Cngv['MDDEL']:=s;
  DelStack;
end;

// Rgn
procedure TDM.RRgnNewRec(Sender: TRecDB; lcopy: Boolean;
  const gKey: String);
begin
  AddStack('TDM.RRgnNewRec',Self);
  Rgn.KodNextSelf(fRGN);
  DelStack;
end;

// Terr
procedure TDM.RTerrNewRec(Sender: TRecDB; lcopy: Boolean;
  const gKey: String);
begin
  AddStack('TDM.RTerrNewRec',Self);
  Terr.KodNextSelf(fTERR);
  DelStack;
end;

procedure TDM.RSrvNewRec(Sender: TRecDB; lcopy: Boolean; const gKey: String);
begin
  AddStack('TDM.RSrvNewRec',Self);
  Srv.KodNextSelf(fFTPSRV);
  DelStack;
end;

procedure TDM.RFltNewRec(Sender: TRecDB; lcopy: Boolean;
  const gKey: String);
begin
  AddStack('TDM.RFltNewRec',Self);
  if not lcopy then Flt[fFltGK]:=Int0(gKey);
  DelStack;
end;

// List
procedure TDM.RListDWTrans(Sender: TObject; var sTrans: String;
  lSave: Boolean);
begin
	AddStack('TDM.RListDWTrans',Self);
  if not lSave then sTrans:=Van[VAN_DD];
  DelStack;
end;

procedure TDM.RListDWFldSeek(Sender: TObject; var a: TDWFldArrSeek;
  prAdd: TDWFldProcAdd);
begin
	AddStack('TDM.RListDWFldSeek',Self);
  prAdd(a,Van[VAN_DD],Van[VAN_WD],true); prAdd(a,Van[VAN_DD]);
  DelStack;
end;

// ListGet
function TDM.ListGetStrDop(Sender: TObject; Qry: TBrQuery): String;
begin
	AddStack('TDM.ListGetStrDop',Self);
  result:=IntToStr(Qry.FindField(nmfbKO).AsInteger);
  DelStack;
end;

// DrvGet
function TDM.DrvGetStrDop(Sender: TObject; Qry: TBrQuery): String;
var k: longint;
    s,t: string;
    f: TField;
begin
  AddStack('TDM.DrvGetStrDop',Self);
  s:='';
  t:='';
  for k:=low(FLD_FBVERSPORT[0]) to high(FLD_FBVERSPORT[0]) do begin
    if not Qry.FindField(FLD_FBVERSPORT[0,k],f) then break;
    IncD(s,IfThen(s<>'',DGSPFB)+Trim(f.AsString));
    if not Qry.FindField(FLD_FBVERSPORT[1,k],f) then break;
    IncD(t,IfThen(t<>'',DGSPFB)+Trim(f.AsString));
  end;(* for k *)
  result:=ArrayAsList([Qry.FieldZN('LOCAL'),IPToHost(Qry.FieldZN(fIP)),Qry.FieldZN('DIR'),s,t],UnDelim);
  DelStack;
end;

// ProgCpGet,ProgNpGet
function TDM.ProgCpGetStrName(Sender: TObject; Qry: TBrQuery): String;
begin
	AddStack('TDM.ProgCpGetStrName',Self);
  with Qry do result:=DlmBetween([Trim(DrvGet.CodeName(FieldZN(fDRV),[cdgBufAll]))
  	+PathDelim+FindField('DIR').AsString,ProgInf(Qry).Abr,CdrGet.CodeName(FieldZN(fCDR),[cdgBufAll]),
    aProgStat[stvLs,ProgStatList(FieldZN('STATUS'))]],', ');
  DelStack;
end;

// AccGet
function TDM.AccGetStrDop(Sender: TObject; Qry: TBrQuery): String;
begin
  AddStack('TDM.AccGetStrDop',Self);
  with Qry do result:=TrimRight(FindField('ACDIR').AsString)+#31+TrimRight(FindField(fFTPSRV).AsString);
  DelStack;
end;

// SrvGet
function TDM.SrvGetStrName(Sender: TObject; Qry: TBrQuery): String;
begin
	AddStack('TDM.SrvGetStrName',Self);
  result:=Qry.FindField('SRVADDR').AsString;
  DelStack;
end;

function TDM.SrvGetStrDop(Sender: TObject; Qry: TBrQuery): String;
begin
	AddStack('TDM.SrvGetStrDop',Self);
  result:=TrimRight(Qry.FindField('SRVDIR').AsString);
  DelStack;
end;

// MDPGet
function TDM.MDPGetStrName(Sender: TObject; Qry: TBrQuery): String;
begin
  AddStack('TDM.MDPGetStrName',Self);
  result:=Qry.FieldZn('ABR');
  DelStack;
end;

function TDM.NameGetTransSeek(Sender: TObject; tf: TFldEdit;
  const Value: String; Size: Integer; lSQL: Boolean): String;
begin
  AddStack('TDM.MDPGetTransSeek',Self);
  result:=Padr(Value,Size);
  DelStack;
end;

procedure TDM.qProgCalcFields;
var f,fa: TField;
  q: TMulQuery;
  k: longint;
  dt: TDateTime;
begin
	AddStack('TDM.qProgCalcFields',Self);
  q:=MulQueryOwner(DataSet);
  with q do begin
    if FindField('CKOD',f) then f.AsString:=ListGet.Codest(FindField('KOD').AsString,[cdgBufAll]);
    if FindField('CND',f) then f.AsString:=DrvGet.CodeName(FindField(fDRV).AsString,[cdgBufAll]);
    if FindField('CKP',f) then f.AsString:=ProgInf(DataSet).Abr;
    if FindField('C'+fCDR,f) then f.AsString:=CdrGet.CodeName(FindField(fCDR).AsString,[cdgBufAll]);
    if FindField('CSTATUS',f) then f.AsString:=aProgStat[stvLs,ProgStatList(FindField('STATUS').AsInteger)];
    if FindField('CKR',f) then f.AsString:=RgnGet.CodeName(FindField(fRGN).AsString,[cdgBufAll]);
    if FindField('CKT',f) then f.AsString:=TerrGet.CodeName(FindField(fTERR).AsString,[cdgBufAll]);
    if FindField(ProgFld[ofxAccAct].ofvCalc,f) then
      if FindField(ProgFld[ofxAcc].ofvFld,fa) then f.AsString:=Activity2Str(GetAccData(ADF_ACTIVITY,fa.AsInteger));
    if FindField(ProgFld[ofxFbVers].ofvCalc,f) then
      if FindField(ProgFld[ofxFbVers].ofvFld,fa) then f.AsString:=MgFbVers.MenuName(fa.AsString);
    if FindField(ProgFld[ofxAccInout].ofvCalc,f) then
      if FindField(ProgFld[ofxAcc].ofvFld,fa) then f.AsString:=Inout2Str(GetAccData(ADF_INOUT,fa.AsInteger));
    if FindField(ProgFld[ofxAccOnsrv].ofvCalc,f) then
      if FindField(ProgFld[ofxAcc].ofvFld,fa) then begin
        k:=GetAccData(ADF_ONSRV,fa.AsInteger);
        if k<>0 then f.AsString:=IntToStr(k);
      end;
    if FindField(ProgFld[ofxDLast].ofvCalc,f) then if FindField(ProgFld[ofxDLast].ofvFld,fa) then begin
      dt:=fa.AsFloat;
      if not empty(dt) then f.AsString:=OurFormatDateTime(DLastFormat,dt);
    end;
  end;
  DelStack;
end;

procedure TDM.MsgApp;
begin
  AddStack('TDM.MsgApp',Self);
  SetLogVid(logvAppRec);
  Msg.NewRec; Msg[fORG]:=Prog[fORG]; Msg[fProgNP]:=Prog[fProgNP];
  if DM.deMsg.Execute('Добавить сообщение').Saved then Msg.AppRec(true);
  SetLogVid;
  DelStack;
end;

procedure TDM.schBoldSample(Sender: TObject; Parent: TWinControl;
  var Header: String; var AfterRebuild: TNotifyEvent);
var tf: TFldEdit;
begin
	AddStack('TDM.schBoldSample',Self);
  tf:=TFldEdit.Create(Parent.Owner); tf.Parent:=Parent;
  with tf do begin
    Vid:=TSimpleGet.ClassName; Value:='Поле'; MaxLength:=Length(Value); SayCaption:='Подсказка ';
    SetReadOnly(true);
  end;
  DelStack;
end;

class procedure TDM.BoolGet1DWFldInfo;
begin
	AddStack('TDM.BoolGet1DWFldInfo');
	TBoolGet(Sender).StdDWFldInfo(Mask,FldInfo); FldInfo.Size:=0;
  DelStack;
end;

class procedure TDM.BoolGet1DWFldValue;
begin
end;

procedure TDM.deAccFldChange(Sender: TObject; const OldVal: Variant; FromShow: Boolean);
begin
  AddStack('TDM.deAccFldChange',Self);
  inherited;
  with TFldEdit(Sender) do if NameRecFld='PENDSET'
  then deAcc.SetReadOnly(['DATE2','ACPASS2','ACKEY2','ACDIR2','SRVID2'],not StrToBoolean(VarValue));
  DelStack;
end;

function TDM.deAccFldCheck(Sender: TObject): Boolean;
begin
  AddStack('TDM.deAccFldCheck',Self);
  inherited;
  if KodCheck(Sender,fACC,result) then with TFldEdit(Sender) do
    if NameRecFld='DATE2' then result:=(TDateTime(VarValue)>=Trunc(Now));
  DelStack;
end;

function IsPassFld(const s: string): boolean;
begin
  result:=(s='ACPASS')or(s='ACKEY')or(s='ACPASS2')or(s='ACKEY2');
end;

procedure TDM.deAccFldEnter(Sender: TObject);
var kl: TKeyLb;
    fe: TFldEdit;
    s: string;
begin
  AddStack('TDM.deAccFldEnter',Self);
  inherited;
  fe:=pointer(Sender); s:=TrimUpper(fe.NameRecFld);
  if IsPassFld(s) then
    if FormKeyLb(GetParentForm(fe),kl) then kl.SetKey(K_F5,'Сгенерировать','',AccGenPassKeyProc,s,kmNone);
  DelStack;
end;

procedure TDM.deAccFldExit(Sender: TObject);
var kl: TKeyLb;
    fe: TFldEdit;
    s: string;
begin
  AddStack('TDM.deAccFldExit',Self);
  inherited;
  if SpaceStrSelf(Sender,fACC) then begin
    fe:=pointer(Sender); s:=TrimUpper(fe.NameRecFld);
    if IsPassFld(s) then
      if FormKeyLb(GetParentForm(fe),kl) then kl.DelKey(K_ALL,s);
  end;
  DelStack;
end;

class procedure TDM.AccGenPassKeyProc;
var fe: TFldEdit;
begin
  if key=K_F5 then
    if ParentClass(TWinControl(fe),tw.Parent,TFldEdit) then if IsPassFld(TrimUpper(fe.NameRecFld))
    then fe.VarValue:=GetRandom10;
end;

procedure TDM.deMsgFrmShow(Sender: TObject);
type TRO = (roFrom,roTo,roOther);
var sro: set of TRO;
  i: longint;
begin
	AddStack('TDM.deMsgFrmShow',Self);
  DateToRec(Msg,fTD);
  DateToRec(Msg,'TD1','1');
  Rec['KOD']:=ListKod(Msg);
  sro:=[];
  if Msg.RecNo>0 then begin
    Include(sro,roFrom);
    if (StrToBoolean(Msg['SEL']) or (Msg['SEL']=MSG_DONE)) and (Msg[fMsgTNTO]<>Rec[fCDR])
    then sro:=sro+[roTo,roOther];
    if Msg[fMsgTNFROM]<>Rec[fCDR] then Include(sro,roTo);
  end;
  with TFormEdt(Sender).PanelEdit1 do
    for i:=0 to FieldCount-1 do with Fields[i] do
      SetReadOnly(TRO(iif(NameRecFld=fMsgTNFROM,roFrom,iif(NameRecFld=fMsgTNTO,roTo,roOther))) in sro);
  Rec['MSGTXT']:=aConcatTxt254(Msg);
  if Msg.RecNo>0 then MsgLogKeysAdd;
  DelStack;
end;

procedure TDM.deMsgFldChange(Sender: TObject; const OldVal: Variant;
  FromShow: Boolean);
var tf: TFldEdit;
  s: string;
begin
  AddStack('TDM.deMsgFldChange',Self);
  tf:=pointer(Sender);
  if tf.NameRecFld='KOD' then begin
    if empty(tf.VarValue) then s:=fCDR+'='+QQs(Rec[fCDR]) else s:=QryNone(true);
    ProgCpGetInit(tf,s,ProgNpGet);
  end;
  DelStack;
end;

procedure TDM.deMsgPnlUpdateRec(Sender: TObject);
begin
  AddStack('TDM.deMsgPnlUpdateRec',Self);
  Msg[fTD]:=DateTimeToString(Rec['DATE'],Rec['TIME']);
  Msg['TD1']:=DateTimeToString(Rec['DATE1'],Rec['TIME1']);
  Msg[fORG]:=Int0(ListGet.CodeDop(Rec['KOD']));
  aSplitTxt254(Msg,Rec['MSGTXT'],true);
  LogFields.AddRecFld(Msg,[fTD,'TD1',fORG]); MsgLogKeysAdd;
  Msg.UpdateRec(true);
  DelStack;
end;

procedure TDM.deProgStatFldChange(Sender: TObject; const OldVal: Variant;
  FromShow: Boolean);
  function StatZajMov(const status: longint): boolean;
  begin
    AddStack('TDM.deProgStatFldChange',Self);
    result := TProgStatList(status) in [stpMain,stpLast];
    DelStack;
  end;
begin
  AddStack('TDM.deProgStatFldChange',Self);
  with TFldEdit(Sender) do
    if NameRecFld='STATUS'
      then deProgStat.SetReadOnly('ZAJMOV',StatZajMov(Int0(OldValue)) and not StatZajMov(Prog['STATUS']))
    else if NameRecFld='ZAJMOV'
      then deProgStat.SetReadOnly('ZajMovCP',not VarValue);
  DelStack;
end;

procedure TDM.deProgStatFldExit(Sender: TObject);
begin
  AddStack('TDM.deProgStatFldExit',Self);
  if TFldEdit(Sender).NameRecFld='STATUS' then with deProgStat.FldEdit['ZajMov'] do
    if ogReadOnly in Options then VarValue:=true;
  DelStack;
end;

function TDM.deProgStatPnlValid(Sender: TObject): Boolean;
var oLogVid: longint;
  oLogKeys: PLogKeysSave;
  svi: TRDBSaveInf;
begin
  AddStack('TDM.deProgStatPnlValid',Self);
  result:=true;
  if Rec['ZajMov'] then begin
    Zaj.UpdateTable([fProgCP],[QQs(Rec['ZajMovCP'])],fORG+'='+Vtos(Prog[fORG])+sAND+fProgCP+'='+QQs(Prog[fProgCP]));
    oLogVid:=ProgPswd.LogVid; oLogKeys:=ProgPswd.PLogKeys;
    try
      ProgPswd.CngLogVid(logvMoveZaj);
      Prog.SaveInf(svi);
      Prog.Seek(Prog.TblFldName(fORG)+'='+Vtos(Prog[fORG])+sAND+Prog.TblFldName(fProgCP)+'='+QQs(Rec['ZajMovCP']));
      ProgLogKeysAdd; TRecDB.RestInf(svi);
      Prog.LogWrite;
    finally
      ProgPswd.PLogKeys:=oLogKeys; ProgPswd.CngLogVid(oLogVid);
    end;
  end;
  DelStack;
end;

procedure TDM.DeProgUserFrmShow(Sender: TObject);
var pt: TProgType;
    fe: TFldEdit;
    b: boolean;
begin
  AddStack('TDM.DeProgUserFrmShow',Self);
  Rec['PUPASS']:=DeshifrStr(Prog['PUPASS']);
  if DeProgUser.IsFldEdit('PUDEV',fe) then begin
    pt:=ProgTp;
    b:=(pt.dvlp='');
    if (b) then Prog['PUDEV']:=bFalse;
    fe.SetReadOnly(b);
  end;
  DelStack;
end;

procedure TDM.DeProgUserKpProcKey(key: Integer; tw: TWinControl);
  procedure SetDeProgUserEdit(const aEdit,aValue: string);
  var fe: TFldEdit;
  begin
    if DeProgUser.IsFldEdit(aEdit,fe) then fe.VarValue:=aValue;
  end;
  function GetDeProgUserEdit(const aEdit: string): string;
  begin
    (* берём Value, а не VarValue, т.к. VarValue возвращает старое значение пока не выйдешь с поля *)
    result:=DeProgUser.EditValueDef(aEdit,'');
  end;
var ost,k: longint;
  pt: TProgType;
  odir,s,t: string;
  dir: TFileName;
  oProgPswd: TFormPswd;
  mq: TMulQuery;
  b,e: boolean;
begin
  ost:=AddStack('TDM.DeProgUserKpProcKey',Self);
  inherited;
  case key of
    K_F4,K_F7: begin
      pt:=ProgTp;
      if (pt.lWin) then begin
        if Prepare2RunProg(dir,pt,[p2rRunMode]) then begin
          odir:=CngDir(dir);
          try
            oProgPswd:=ProgPswd;
            try
              TSQLDM.Load;
              CreateForm(TFormPswd,FormPswd);
              FormPswd.FileIdentProg:=pt.fdbf;
              ProgPswd:=FormPswd;
              ProgPswd.PswdPrm.DBMain:=FormPswd.CreateDatabase('REG','GETSETUSER');
              try
                FormPswd.SetDBPrm(DBMain,'REG',ExeDir,true);
                SetConnected(true);
                try
                  if not IsTable(tUSERS) then ThrowGoto('Отсутствует таблица '+tUSERS);(* throws EGoto *)
                  mq:=ProgPswd.GetQuery;
                  try
                    if (key=K_F4) then begin
                      s:=RTrimUpper(GetDeProgUserEdit('PUNAME'));
                      if (s<>'') then begin
                        t:=Vtos(false);
                        if pt.dvlp<>'' then 
                          if IsField(tUSERS,pt.dvlp) then t:=pt.dvlp;
                        mq.PartSelect(tUSERS,'PASSW,'+t,fNAME+'='+QQs(s));
                        if (not mq.IsRecords) then begin
                          ThrowGoto('Пользователя с таким именем не существует');(* throws EGoto *)
                        end else begin
                          SetDeProgUserEdit('PUPASS',DeshifrStr(mq.Fields[0].AsString));
                          SetDeProgUserEdit('PUDEV',mq.Fields[1].AsString);
                        end;
                      end else begin
                        b:=false;
                        if pt.dvlp<>'' then
                          if IsField(tUSERS,pt.dvlp) then begin
                            mq.PartSelect(tUSERS,fNAME+',PASSW',FldIsTrue(pt.dvlp));
                            if (mq.IsRecords) then begin
                              b:=true;
                              SetDeProgUserEdit('PUNAME',mq.Fields[0].AsString);
                              SetDeProgUserEdit('PUPASS',DeshifrStr(mq.Fields[1].AsString));
                              SetDeProgUserEdit('PUDEV',bTrue);
                            end;
                          end;
                        if (not b) then begin
                          mq.PartSelect(tUSERS,fNAME+',PASSW',FldIsTrue('SUPER'));
                          if (mq.IsRecords) then begin
                            SetDeProgUserEdit('PUNAME',mq.Fields[0].AsString);
                            SetDeProgUserEdit('PUPASS',DeshifrStr(mq.Fields[1].AsString));
                            SetDeProgUserEdit('PUDEV',bFalse);
                          end;
                        end;
                      end;
                    end else begin
                      b:=StrToBoolean(GetDeProgUserEdit('PUDEV'));
                      if (b) then begin
                        if pt.dvlp='' then ThrowGoto(
                          'В этой программе нельзя устанавливать пользователю право "Разработчик"');(* throws EGoto *)
                        if not IsField(tUSERS,pt.dvlp) then ThrowGoto(
                          'В этой базе данных нельзя устанавливать пользователю право "Разработчик".'+CRLF+'Возможно необходимо обновить программу.');(* throws EGoto *)
                      end;
                      s:=RTrimUpper(GetDeProgUserEdit('PUNAME'));
                      if s='' then ThrowGoto('Имя пользователя не может быть пустым!');(* throws EGoto *)
                      e := not mq.PartCount0(tUSERS,fNAME+'='+QQs(s));
                      t:=ShifrStr(GetDeProgUserEdit('PUPASS'));
                      if (e) then begin
                        mq.SetArrayList(sC_LIST,['PASSW','SUPER','LMONO']);
                        mq.SetArrayList(sV_LIST,[QQs(t) ,true   ,true]);
                        if (b) then begin
                          (* устанавливаем только true, т.к. иначе надо ещё проверить есть ли поле в таблице *)
                          mq.AddArrayList(sC_LIST,[pt.dvlp]);
                          mq.AddArrayList(sV_LIST,[true]);
                        end;
                        mq.UpdateTable(tUSERS,fNAME+'='+QQs(s));
                      end else begin
                        k:=mq.PartMaxInt(tUSERS,fRECNO)+1;
                        mq.SetArrayList(sC_LIST,[fRECNO,fNAME ,'PASSW','SUPER','LMONO']);
                        mq.SetArrayList(sV_LIST,[k     ,QQs(s),QQs(t) ,true   ,true]);
                        if (b) then begin
                          (* устанавливаем только true, т.к. иначе надо ещё проверить есть ли поле в таблице *)
                          mq.AddArrayList(sC_LIST,[pt.dvlp]);
                          mq.AddArrayList(sV_LIST,[true]);
                        end;
                        mq.Arg[sTABLE]:=tUSERS;
                        mq.ExecPart(sI_TABLE);
                      end;
                    end;
                  finally
                    ProgPswd.FreeQuery;
                  end;
                except
                  on E:EGoto do begin
                    if (E.Message<>'') then meserr(E.Message);
                  end;
                  on E:Exception do begin
                    SetStack(ost);
                    meserr('Ошибка чтения данных: '+E.ClassName+CRLF+E.Message);
                  end;
                end;
              finally
                SetConnected(false); FreeAndNil(FormPswd);
              end;
            finally
              ProgPswd:=oProgPswd;
            end;
          finally
            CngDir(odir);
          end;
        end;
      end;
    end;
  end;
  DelStack;
end;

function TDM.DeProgUserPnlValid(Sender: TObject): Boolean;
begin
  AddStack('TDM.DeProgUserPnlValid',Self);
  Prog['PUPASS']:=ShifrStr(Rec['PUPASS']); LogFields.AddRecFld(Prog,'PUPASS'); result:=true;
  DelStack;
end;

procedure TDM.deProgCngFldExit(Sender: TObject);
begin
  AddStack('TDM.deProgCngFldExit',Self);
  SpaceStrSelf(Sender,fProgCP);
  DelStack;
end;

function TDM.deProgCngFldCheck(Sender: TObject): Boolean;
begin
  AddStack('TDM.deProgCngFldCheck',Self);
  KodCheck(Sender,fProgCP,result,fORG+'='+Vtos(Int0(ListGet.CodeDop(Rec['KOD'],[cdgBufAll]))));
  DelStack;
end;

function TDM.deProgCngPnlValid(Sender: TObject): Boolean;
var nko: longint;
  lKP,lKO,lCP: boolean;
  okp,okod,ocp: string;
  tf: TFldEdit;
  mq: TMulQuery;
begin
  AddStack('TDM.deProgCngPnlValid',Self);
  result:=true;
  okp:=deProgCng.OldValue[fProgKP];
  lKP := Prog[fProgKP]<>okp;
  if (NeedClearProgDir(Prog[fProgKP])) then begin
    Prog[fDRV]:='';
    Prog['DIR']:='';
  end;
  okod:=deProgCng.OldValue['KOD'];
  lKO := Rec['KOD']<>okod;
  if deProgCng.IsFldEdit(fProgCP,tf) then ocp:=tf.OldValue else ocp:=Prog[fProgCP];
  lCP := Prog[fProgCP]<>ocp;
  if lKP or lKO or lCP then begin
    if lKO or lCP then begin
      mq:=ProgPswd.GetQuery;
      try
        mq.Arg[sC_LIST]:='';
        mq.Arg[sV_LIST]:='';
        nko:=0;
        if lKO then begin
          nko:=Int0(ListGet.CodeDop(Rec['KOD'],[cdgBufAll]));
          mq.AddArgList(sC_LIST,fORG);
          mq.AddArgList(sV_LIST,nko);
        end;
        if lCP then begin
          mq.AddArgList(sC_LIST,fProgCP);
          mq.AddArgList(sV_LIST,QQs(Prog[fProgCP]));
        end;
        mq.UpdateTable(tZAJ,[mq.Arg[sC_LIST]],[mq.Arg[sV_LIST]],
          fORG+'='+Vtos(Prog[fORG])+sAND+fProgCP+'='+QQs(ocp));
        if lKO then Prog[fORG]:=nko;
      finally
        ProgPswd.FreeQuery;
      end;
    end;
    ProgLogKeysAdd;
    TProgCopy.RegNumCng(TProgCopy.RegNumBeg(GetProgInf(Int0(okp)).Abr,okod+'-'+ocp),ProgInf.Abr,
      Rec['KOD']+'-'+Prog[fProgCP],GlobDIRLAST);
  end;
  DelStack;
end;

{ TCodLogCompare }
class function TCodLogCompare.ListCreate;
begin
  AddStack('TCodLogCompare.ListCreate');
  result:=ListCreateDlm(Value,',');
  DelStack;
end;

class procedure TCodLogCompare.GetItem;
begin
  AddStack('TCodLogCompare.GetItem');
  inherited GetItem(Prm,pv,lso,lsn,no,nn,tp);
  if (tp=clogPrn) and not empty(Prm.val) then Prm.val:=TCodeGet(pv).Codest(Prm.val,[cdgBufAll]);
  TrimSelf(Prm.val);
  DelStack;
end;

{ TCngvLogCompare }
class function TCngvLogCompare.ListCreate;
begin
  AddStack('TCngvLogCompare.ListCreate');
  if Assigned(pv) then result:=ListCreateDlm(Value,';') else result:=TStrLogCompare.ListCreate(nil,Value,lNew);
  DelStack;
end;

function CngvLogClass(pv: pointer): TCustomLogCompareClass;
begin
  AddStack('FDM.CngvLogClass');
  result:=IfThenCustomLogCompareClass(Assigned(pv),TDlmLogCompare,TStrLogCompare);
  DelStack;
end;

class procedure TCngvLogCompare.ListDestroy;
begin
  AddStack('TCngvLogCompare.ListDestroy');
  CngvLogClass(pv).ListDestroy(nil,ls);
  DelStack;
end;

class function TCngvLogCompare.GetCount;
begin
  AddStack('TCngvLogCompare.GetCount');
  result:=CngvLogClass(pv).GetCount(nil,ls);
  DelStack;
end;

type TCngvList = 1..2;

function LogCompareStrCngv(const Prm: TLogTrnsValPrm; p,pv: pointer): string;
begin
  AddStack('FDM.LogCompareStrCngv');
  result:=DlmCopy(PString(p)^,TCngvList(pv),1,dlmMemF);
  DelStack;
end;

class procedure TCngvLogCompare.GetItem;
const a: array[TCngvList] of string = ('папок','файлов');
var i: TCngvList;
begin
  AddStack('TCngvLogCompare.GetItem');
  if Assigned(pv) then inherited GetItem(Prm,nil,lso,lsn,no,nn,tp)
  else case tp of
    clogNoKey: TStrLogCompare.GetItem(Prm,nil,lso,lsn,no,nn,clogKey);
    clogPrn: for i:=low(a) to high(a) do AddRes(LogCompareStrCngv,Prm,lso,lsn,pointer(i),a[i]);
  end;
  DelStack;
end;

procedure nmf254CreateField;
var i: byte;
  s: string;
begin
  AddStack('FDM.nmf254CreateField');
  i:=2;
  repeat
    s:=nmf254(i,sBeg);
    if not r.IsField(s) then break;
    q.CreateField(s); Inc(i);
  until false;
  DelStack;
end;

function PrConcatTxt254(const av: array of variant; const nmf: string; var txt: string): boolean;
var Sender: TObject;
  v: variant;
  qf: TField;
begin
  Sender:=PointerVar(av[0]);
  if Sender is TRecDB then begin
    result:=TRecDB(Sender).IsFldValue(nmf,av[1],v);
    if result then txt:=v;
  end
  else begin
    result:=TMulQuery(Sender).FindField(nmf,qf);
    if result then txt:=qf.AsString;
  end;
end;

function aConcatTxt254(Sender: TObject; lOld: boolean = false; const sBeg: string = fTXT): string;
begin
  result:=aConcatTxt254(PrConcatTxt254,[longint(Sender),lOld],sBeg);
end;

procedure PrSplitTxt254(const av: array of variant; const nmf,txt: string);
var Sender: TRecDB;
begin
  Sender:=PointerVar(av[0]); Sender[nmf]:=txt;
  if av[1] then LogFields.AddRecFld(Sender,nmf);
end;

procedure aSplitTxt254(Sender: TRecDB; const aTxtSplit: string; lLog: boolean = false; lmax: PLongint = nil; const sBeg: string = fTXT);
var CntFld: byte;
begin
  CntFld:=1;
  while Sender.IsField(nmf254(CntFld,sBeg)) do Inc(CntFld);
  Dec(CntFld);
  aSplitTxt254(PrSplitTxt254,[longint(Sender),lLog],aTxtSplit,CntFld,lmax,sBeg);
end;

function NeedClearProgDir;
begin
  result:=(GetProgInf(Int0(aProgKP)).id in [PTIX_AV,PTIX_RZV]);
end;

function NeedClearFbVers;
begin
  result:=not ArrIntMatch(GetProgInf(Int0(aProgKP)).id,aProgId);
end;

function ZajFldName;
begin
  AddStack('FDM.ZajFldName');
  if i=ofzISPCALC
  then result:=IfThen(StrToBoolean(Cdr['ADMZAJ']),'Лидеры','Свой выбор')
  else result:=aOrdFixz[i].ofzvName;
  DelStack;
end;

function GetRandom;
var k: longint;
begin
  SetLength(result,sz);
  for k:=1 to length(result) do result[k]:=IntToStr(RandomRange(10,99))[2];
end;

function GetRandom10;
begin
  result:=GetRandom(10);
end;

function GetSftpBlinkState;
begin
  result:=false;
  FillSftpSb(aTn,nil,@result);
end;

type
  PAccInfo = ^TAccInfo;
  TAccInfo = record
    aiId,aiName,aiPath,aiLastVisit,aiLastVisitRaw,aiVers,aiComp,aiChangeName: string;
    aiCnt: TArrBoolBoolInt;
    aiSrv,aiSort: longint;
    aiSl: TStringList;
  end;
  TAAccInfo = array of TAccInfo;

function AccSortFunc(p: pointer; fi,si: longint; sortID: TSortID): boolean;
  function CompareStrAsNumb(s1,s2: string): longint;
  var i1,i2: Int64;
  begin
    TrimSelf(s1); TrimSelf(s2);
    if Str2IntEq(i1,s1,MaxInt) or Str2IntEq(i2,s1,MaxInt) then result:=AnsiCompareText(s1,s2) else result:=i1-i2;
  end;
var aAcc: ^TAAccInfo;
  ai: TAccInfo;
  k: longint;
  io,ld: boolean;
begin
  result:=false; aAcc:=p;
  case sortID of
    sort1MORE2: begin
      case aAcc^[fi].aiSort of
        SFTPSBCOL_NAME: k:=AnsiCompareText(aAcc^[fi].aiName,aAcc^[si].aiName);
        SFTPSBCOL_SRV: k:=(aAcc^[fi].aiSrv-aAcc^[si].aiSrv);
        SFTPSBCOL_ACT: k:=AnsiCompareText(aAcc^[si].aiLastVisitRaw,aAcc^[fi].aiLastVisitRaw);
        SFTPSBCOL_VER: k:=AnsiCompareText(aAcc^[fi].aiVers,aAcc^[si].aiVers);
        SFTPSBCOL_PATH: k:=AnsiCompareText(aAcc^[fi].aiPath,aAcc^[si].aiPath);
        SFTPSBCOL_COMP: k:=AnsiCompareText(aAcc^[fi].aiComp,aAcc^[si].aiComp);
        SFTPSBCOL_CHANGENAME: k:=CompareStrAsNumb(aAcc^[fi].aiChangeName,aAcc^[si].aiChangeName);
      else
        k:=0;
        for io:=false to true do
          for ld:=false to true do if aAcc^[fi].aiSort=SFTPSBCOL_BOX[io,ld] then begin
            k:=(aAcc^[fi].aiCnt[io,ld]-aAcc^[si].aiCnt[io,ld]); break;
          end;
      end;
      if (k=0) then begin
        k:=CompareStrAsNumb(aAcc^[fi].aiId,aAcc^[si].aiId);
      end;
      result:=(k>0);
    end;
    sortEXCHANGE: begin
      ai:=aAcc^[fi]; aAcc^[fi]:=aAcc^[si]; aAcc^[si]:=ai;
    end;
  end;
end;

function GetLastVisit(const aPath: string; aVers: pstring=nil; aRawLastVisit: pstring=nil;
  aComp: pstring=nil; aRizMinutes: PLongInt=nil): string;
var dt,dtNow: TDateTime;
  s: TFileName;
  sVers,sRawLastVisit,sComp: string;
  sa: TArrStr;
  k: longint;
begin
  result:='';
  SetPLongInt(aRizMinutes,ACTIVITY_EMPTY);
  FirstMaskFiles(s,IncludeTrailingPathDelimiter(aPath)+'*.last.visit');
  TokenStr(s,'.',sa); sRawLastVisit:=IfThen(sa);
  SetPString(aRawLastVisit,sRawLastVisit);
  sVers:='';
  sComp:='';
  if (length(sa)>3) then begin
    sVers:=sa[1];
    if (length(sa)>4) then sComp:=sa[2];
  end;
  SetPString(aVers,sVers);
  SetPString(aComp,sComp);
  if StringDate(s,dt) then begin
    dtNow:=Now;
    k:=Trunc(MinuteSpan(dtNow,dt));
    if (dt>dtNow) then k:=-k;
    if not SetPLongInt(aRizMinutes,k) then result:=Activity2Str(k);
  end;
end;

function Activity2Str;
var d,h,m: longword;
    s: string;
begin
  if (aMinutes=ACTIVITY_EMPTY) then result:=''
  else begin
    m:=abs(aMinutes);
    h:=m div MinsPerHour; ModD(m,MinsPerHour);
    d:=h div HoursPerDay; ModD(h,HoursPerDay);
    s:='%2:dм.';
    if (d>0)or(h>0) then begin
      IncL(s,'%1:dч. ');
      if (d>0) then IncL(s,'%0:dд. ');
    end;
    result:=Format(s,[d,h,m]);
    if (aMinutes<0) then IncL(result,'-');
  end;
end;

procedure FGetFilesCount(const av: array of variant; const sr: TSearchRec; var lDone: boolean);
begin
  Inc(LongIntVar(av[0])^);
end;

procedure FillSftpSb;
var aPath: string;
  function GetFilesCount(const aDir: string): longint;
  begin
    result:=0; MaskFilesProc(aPath+aDir+PathDelim+'*.*',FGetFilesCount,[longint(@result)]);
  end;
var aAcc: TAAccInfo;
  function IsFilesOnTn: boolean;
  var sl: TStringList;
      k,j: longint;
      sOrg,sReg,sNum,s: string;
      q: TMulQuery;
      ai: PAccInfo;
  begin
    result:=false;
    for j:=0 to high(aAcc) do begin
      if (result) then break;
      ai:=@aAcc[j];
      if (ai^.aiSl=nil) then continue;
      k:=ai^.aiSl.Count;
      if (k=0) then continue;
      sl:=SortStrListCreate;
      try
        for k:=0 to k-1 do begin
          ParsePckFn(ai^.aiSl[k],sOrg,sReg,sNum);
          sl.Add(BrackNoEmp('o.kod='+Org2Sql(sOrg)+sAND+'p.'+fProgCP+'='+Reg2Sql(sReg)));
        end;(* for k *)
        s:=sl[0];
        for k:=1 to sl.Count-1 do IncD(s,sOR+sl[k]);
      finally
        sl.Free;
      end;
      q:=PswdEd.GetQuery;
      try
        q.PartSelect(tPROG+' p '
                    +'join '+tORG+' o on p.'+fORG+'=o.'+fORG,
                    ['distinct p.'+fCDR],
                    BrackNoEmp(s)+sAND+'p.'+fACC+'='+ai^.aiId);
        s:=RTrimUpper(aTn);
        if q.IsRecords then
          while not q.Eof do begin
            if (RTrimUpper(q.Fields[0].AsString)=s) then begin
              result:=true;
              break;
            end;
            q.Next;
          end
        else begin
          //т.е. здесь: эти файлы не имеют соответствующей программы
          q.PartSelect(tPROG,['distinct '+fCDR],fACC+'='+ai^.aiId);
          if q.IsRecords then
            while not q.Eof do begin
              if (RTrimUpper(q.Fields[0].AsString)=s) then begin
                result:=true;
                break;
              end;
              q.Next;
            end
          else begin
            //т.е. здесь: эти файлы висят на аккаунте который не относится ни к одному пользователю
            result:=true;
          end;
        end;
      finally
        PswdEd.FreeQuery;
      end;
    end;(* for j *)
  end;
  function GetChangeName(const aPath: string): string;
  var s: TFileName;
    sa: TArrStr;
    k: Int64;
  begin
    FirstMaskFiles(s,IncludeTrailingPathDelimiter(aPath)+'*.'+LOGFILE_CHANGENAME);
    TokenStr(s,'.',sa,true);
    if (length(sa)<3) then result:=''
    else begin
      s:=sa[0];
      if Str2IntEq(k,s,MaxInt) then result:=s else result:=IfThen(k<>1,IntToStr(k-1));
    end;
  end;
  function DecodeCompName(const aCompName: string): string;
  var k: longint;
    j: Int64;
    s: string;
  begin
    result:=aCompName;
    if (result<>'')and(result[1]='$'{COMPNAME_PREFIX}) then begin
      s:='';
      for k:=1 to (length(result) div 2) do
        if Str2IntNeg(j,'$'+copy(result,2*k,2)) then begin
          s:=''; break;
        end
        else IncD(s,chr(j));
      if s<>'' then result:=s;
    end;
  end;
var q: TMulQuery;
  k,j,r,r2s,sumId,sumName,sumSrv,sumAct,sumVer,sumPath,sumComp,sumChangeName: longint;
  sumCnt: TArrBoolBoolInt;
  ai: PAccInfo;
  t,u,w: string;
  io,io1,io2,ld,ld1,ld2: boolean;
  a: TArrStr;
  otl: TGridCoord;
begin
  SetPBoolean(isInExists);
  q:=PswdEd.GetQuery;
  try
    q.PartSelect(tPROG+' p '
                +'join '+tACC+' a on p.'+fACC+'=a.'+fACC+' '
                +'join '+tFTPSRV+' f on a.'+fFTPSRV+'=f.'+fFTPSRV,
                ['distinct p.'+fACC+',a.name,a.acdir,f.srvdir'],
                IfThen(not empty(aTn),'p.'+fCDR+'='+QQs(aTn)));
    k:=q.RecordCount; SetLength(aAcc,k);
    if k>0 then ZeroMemory(@aAcc[0],k*SizeOf(aAcc[0]));
    if Assigned(sb) then begin
      io1:=false; io2:=true; ld1:=false; ld2:=true;
    end
    else begin
      io1:=false; io2:=false; ld1:=false; ld2:=false;
    end;
    try
      for j:=0 to k-1 do begin
        ai:=@aAcc[j];
        ai^.aiId:=q.Fields[0].AsString;
        aPath:=GetSftpDataDir(Trim(q.Fields[3].AsString))
          +PathDelim
          +TrimRight(q.Fields[2].AsString)+PathDelim;
        for io:=io1 to io2 do
          for ld:=ld1 to ld2 do ai^.aiCnt[io,ld]:=GetFilesCount(SmailDirBox[io,ld]);
        if not GetPBoolean(isInExists,true) and (ai^.aiCnt[false,false]>0) then begin
          t:=aPath+SmailDirBox[false,false]+PathDelim;
          GetMaskFiles(a,r,t+'*.pck');
          GetMaskFiles(a,r,t+ABR_MSG+'*'+FILE_MSG_EXT,[],[msfAdd]);
          if r<ai^.aiCnt[false,false](*т.е. есть файлы без рег.номера*) then begin
            isInExists^:=true;
            if not Assigned(sb) then break;
          end;
          if (not isInExists^) then begin
            ai^.aiSl:=SortStrListCreate; AddFrom(ai^.aiSl,a,r);
          end;
        end;
        if Assigned(sb) then begin
          ai^.aiSort:=aCol2Sort;
          ai^.aiName:=q.Fields[1].AsString;
          ai^.aiPath:=aPath;
          ai^.aiLastVisit:=GetLastVisit(aPath,@t,@u,@w);
          ai^.aiLastVisitRaw:=u;
          ai^.aiVers:=t;
          ai^.aiComp:=DecodeCompName(w);
          ai^.aiChangeName:=GetChangeName(aPath);
          ai^.aiSrv:=GetFilesCount(SmailDirOnServer);
        end;
        q.Next;
      end;(* for j *)
      if not GetPBoolean(isInExists,true) and IsFilesOnTn then isInExists^:=true;
    finally
      for j:=0 to high(aAcc) do aAcc[j].aiSl.Free;
    end;
  finally
    PswdEd.FreeQuery;
  end;
  if Assigned(sb) then begin
    t:=sb.Cells[0,sb.Row]; otl:=sb.TopLeft;
    sb.Init;
    if (k>0) then begin
      if (aCol2Sort<>SFTPSBCOL_ID) then begin
        QuickSort(AccSortFunc,@aAcc,low(aAcc),high(aAcc));
      end;
      sb.RowCount:=sb.FixedRows+k;
      sumId:=0; sumName:=0; ZeroMemory(@sumCnt,SizeOf(sumCnt)); sumSrv:=0;
      sumAct:=0; sumVer:=0; sumPath:=0; sumComp:=0; sumChangeName:=0;
      r2s:=0;
      for j:=0 to k-1 do begin
        ai:=@aAcc[j];
        r:=sb.FixedRows+j;
        sb.Cells[SFTPSBCOL_ID,r]:=ai^.aiId;
        inc(sumId,ord(ai^.aiId<>''));
        if (r2s=0)and(ai^.aiId=t) then r2s:=r;
        sb.Cells[SFTPSBCOL_NAME,r]:=ai^.aiName;
        inc(sumName,ord(ai^.aiName<>''));
        for io:=false to true do
          for ld:=false to true do begin
            sb.Cells[SFTPSBCOL_BOX[io,ld],r]:=Int2StrDef(ai^.aiCnt[io,ld]); inc(sumCnt[io,ld],ai^.aiCnt[io,ld]);
          end;
        sb.Cells[SFTPSBCOL_SRV,r]:=Int2StrDef(ai^.aiSrv);
        inc(sumSrv,ai^.aiSrv);
        sb.Cells[SFTPSBCOL_ACT,r]:=ai^.aiLastVisit;
        inc(sumAct,ord(ai^.aiLastVisit<>''));
        sb.Cells[SFTPSBCOL_VER,r]:=ai^.aiVers;
        inc(sumVer,ord(ai^.aiVers<>''));
        sb.Cells[SFTPSBCOL_PATH,r]:=ai^.aiPath;
        inc(sumPath,ord(ai^.aiPath<>''));
        sb.Cells[SFTPSBCOL_COMP,r]:=ai^.aiComp;
        inc(sumComp,ord(ai^.aiComp<>''));
        sb.Cells[SFTPSBCOL_CHANGENAME,r]:=ai^.aiChangeName;
        inc(sumChangeName,StrToIntDef(ai^.aiChangeName,0));
      end;(* for j *)
      sb.AdjustColsWidth;
      if (r2s>0) then sb.Row:=r2s;
      sb.Objects[SFTPSBCOL_ID,0]:=pointer(sumId);
      sb.Objects[SFTPSBCOL_NAME,0]:=pointer(sumName);
      sb.Objects[SFTPSBCOL_SRV,0]:=pointer(sumSrv);
      sb.Objects[SFTPSBCOL_ACT,0]:=pointer(sumAct);
      sb.Objects[SFTPSBCOL_VER,0]:=pointer(sumVer);
      sb.Objects[SFTPSBCOL_PATH,0]:=pointer(sumPath);
      sb.Objects[SFTPSBCOL_COMP,0]:=pointer(sumComp);
      sb.Objects[SFTPSBCOL_CHANGENAME,0]:=pointer(sumChangeName);
      for io:=false to true do
        for ld:=false to true do sb.Objects[SFTPSBCOL_BOX[io,ld],0]:=pointer(sumCnt[io,ld]);
      sb.TopLeft:=otl;
    end;
  end;
end;

function Inout2Str;
var io: TAccInOut;
  fl: boolean;
begin
  result:='';
  if aInout<>0 then begin
    io.dw:=aInout;
    for fl:=false to true do IncD(result,IntToStr(io.a[fl])+'/');
    DecLen(result);
  end;
end;

function GetSftpDataDir;
var s: string;
begin
  result:=ExcludeTrailingPathDelimiter(aDir);
  if (result<>'') then begin
    s:=result+PathDelim+'DATA';
    if (DirectoryExists(s)) then begin
      result:=s;
    end;
  end;
end;

function AcidAsStr;
begin
  result:=SpaceStr(s,4);
end;

function SYSDBA;
begin
  AddStack('FDM.SYSDBA');
  result := TrimRight(CdrGet.CodeName(DM.Rec[fCDR]))=sSYSDBA;
  DelStack;
end;

procedure ZajEdSetKey;
begin
	AddStack('FDM.ZajEdSetKey');
  tl.SetKey(K_F3,'','Перенос на другую программу',proc,'zaj',kmList);
  tl.SetKey(K_F5,'Редактировать','',proc,'zaj',kmList);
  tl.SetKey(K_Ctrl_F5,'Исполнение','',proc,'zaj',kmList);
  if StrToBoolean(Cdr['ADMZAJ']) then begin
    tl.SetKey(K_Ctrl_F7,'','Лидеры',proc,'zaj',kmList);
    tl.SetKey(K_Ctrl_Enter,'Фиксация','Фиксация выбора исполнителя',proc,'zaj',kmList)
  end
  else begin
    tl.SetKey(K_Ctrl_Plus,'Голосование','Добавление к выбору исполнителя',proc,'zaj',kmList);
    tl.SetKey(K_Ctrl_F7,'','Выбор текущего пользователя',proc,'zaj',kmList);
  end;
  tl.SetKey(K_Ctrl_D,'Сообщение','Добавить сообщение по программе',proc,'zaj',kmList);
  tl.SetKey(K_CTRL_G,'Сообщение(инт.)','Отправить сообщение по программе',proc,'zaj',kmList);
  tl.SetKey(K_CTRL_O,'','Интернет файлы',proc,'zaj',kmList);
  tl.SetKey(K_Shift_F5,'','Движение заявки',proc,'zaj',kmList);
  DelStack;
end;

function Str2SelIsp(const Value: string): string;
const PrmBall: TFmtNum = (DigDlm:''''; DigIsDlm:true);
var i: longint;
  a: TSelIspArr;
begin
  AddStack('FDM.Str2SelIsp');
  result:='';
  if Str2SelIsp(a,Value) then begin
    for i:=low(a) to high(a) do IncD(result,FmtNum(a[i].ball,PrmBall)+',');
    DecLen(result);
  end;
  DelStack;
end;

function Str2SelIsp(f: TField): string;
begin
  AddStack('FDM.Str2SelIsp(browl)');
  result:=DeShifrStr(f.AsString);
  if not StrToBoolean(Cdr['ADMZAJ']) then Str2SelIspSelf(result);
  if Length(result)>aFixzLen[ofzSELISPSH] then RightSelf(result,aFixzLen[ofzSELISPSH]);
  DelStack;
end;

procedure Str2SelIspSelf;
begin
  Value:=Str2SelIsp(Value);
end;

function SelIsp2Str;
var i: longint;
  lan: boolean;
begin
  AddStack('FDM.SelIsp2Str');
  result:=''; lan:=not Assigned(an);
  try
    if lan then begin
      New(an); i:=Length(a); SetLength(an^,i);
      for i:=0 to i-1 do an^[i]:=i;
    end;
    for i:=low(an^) to high(an^) do with a[an^[i]] do IncD(result,Format('%d-%d ',[tn,ball]));
    DecLen(result);
  finally
    if lan then Dispose(an);
  end;
  DelStack;
end;

procedure SelIspSet;
var s: string;
  a: TSelIspArr;
  an: TArrTN;
begin
  AddStack('FDM.SelIspSet');
  s:=ShifrStr(Value);
  if Length(s)>Length(Zaj['SELISPSH']) then begin
    OLProc.IspCalc(a,an,s,Zaj['CNTISP']); s:=ShifrStr(SelIsp2Str(a,@an));
  end;
  Zaj['SELISPSH']:=s;
  DelStack;
end;

function lsFldLabel;
var fi: PFldInf;
begin
  AddStack('FDM.lsFldLabel');
  fi:=ls.GetInf(i); result:=fi^.DWFldInfo.DisplayLabel;
  if empty(result) then result:=fi^.DWFldInfo.r.Prim;
  if empty(result) then result:=ls[i];
  DelStack;
end;

procedure PrCngCopy(const av: array of variant; const sr: TSearchRec; var lDone: boolean);
var fl: PBoolean;
	fo,fn: string;
begin
  AddStack('FDM.PrCngCopy');
  fo:=av[0]+sr.Name;
  fn:=av[1]+sr.Name;
  fl:=PointerVar(av[2]);
  if (sr.Attr and faDirectory)=faDirectory then
    if DirectoryExists(fo) then begin
      IncD(fo,PathDelim); MaskFilesProc(fo+'*.*',PrCngCopy,[fo,fn+PathDelim,av[2]],[fmFiles,fmDir]);
    end
    else begin
      lDone:=false; fl^:=false;
    end
  else if sr.Time<>FileAge(fn) then
    if not ForceDirectories(av[1]) then fl^:=false
    else if not CopyFileOpt(fo,fn) then fl^:=false;
  DelStack;
end;

function CngCopyDir;
var Attr: TFileMaskType;
  a: array[1..2] of string;
	i: byte;
  j: longint;
  a1: TArrStr;
  copydir,s: string;
  dircopy: boolean;
begin
  AddStack('FDM.CngCopyDir');
  result:=true; copydir:=CorrDir(ccopydir); dircopy:=StrToBoolean(cdircopy);
  Attr:=[fmFiles,fmDir]; LsArrFill(mem_f,a,dlmMemF);
  for i:=low(a) to high(a) do if not empty(a[i]) then begin
    if i=2 then Exclude(Attr,fmDir);
    for j:=0 to LsArrDynamic(a[i],a1,DirAddDlm)-1 do begin
      if (i=1) and empty(Pos('*',a1[j]))  and empty(Pos('?',a1[j]))
      then a1[j]:=CorrDir(a1[j])+'*.*';
      s:=ExtractFilePath(a1[j]);
      if DirectoryExists(s) then
        if dircopy then begin
          if TCopyLs.PrCopy(s,copydir,'','','','',avCopy,avcNormal,nil,'',false) then result:=false;
        end
        else MaskFilesProc(a1[j],PrCngCopy,[s,copydir,LongInt(@result)],Attr)
      else result:=false;
      if not result then break;
    end;
  end;
  DelStack;
end;

procedure ProgLogKeysAdd;
var i: longint;
  kod: string;
  procedure KeyAdd(logk: longint; const nmf: string);
  begin
    AddStack('FDM.ProgLogKeysAdd.KeyAdd');
    with ProgPswd do begin
      LogKeys[i].key:=logk; LogKeys[i].val:=kod; Inc(i);
      LogKeys[i].key:=logk; LogKeys[i].val:=kod+'-'+VarAsType(Prog[nmf],varString); Inc(i);
    end;
    DelStack;
  end;
begin
  AddStack('FDM.ProgLogKeysAdd');
  with ProgPswd do begin
    i:=Length(LogKeys); SetLength(LogKeys,i+4); kod:=ListKod; KeyAdd(logkCp,fProgCP); KeyAdd(logkNp,fProgNP);
  end;
  DelStack;
end;

procedure MsgLogKeysAdd;
begin
  AddStack('FDM.MsgLogKeysAdd');
  if Prog.Seek(Prog.TblFldName(fORG)+'='+Vtos(Msg[fORG])+sAND+Prog.TblFldName(fProgNP)+'='+QQs(Msg[fProgNP]))
  then ProgLogKeysAdd;
  DelStack;
end;

function Int2Ispv;
begin
  AddStack('FDM.Int2Ispv');
  result:=TIspVidList(EnsureRange(i,byte(low(aIspv)),byte(high(aIspv))));
  DelStack;
end;

function IspCalc(q: TMulQuery): string;
var a: TSelIspArr;
  an: TArrTN;
  i,tn,cnt: longint;
begin
  AddStack('FDM.IspCalc');
  result:=''; OLProc.IspCalc(a,an,q.FindField('SELISPSH').AsString,q.FindField('CNTISP').AsInteger);
  if StrToBoolean(Cdr['ADMZAJ']) then begin
    for i:=low(an) to high(an) do with a[an[i]] do IncD(result,Format('%d-%d ',[tn,ball]));
    DecLen(result);
  end
  else begin
    tn:=Int0(Cdr[fCDR]); cnt:=0;
    for i:=low(a) to high(a) do if a[i].tn=tn then begin
      result:=IntToStr(a[i].ball); Inc(cnt);
    end;
    if cnt>1 then IncD(result,Format('(%d)',[cnt]));
    for i:=low(an) to high(an) do if a[an[i]].tn=tn then begin
      IncD(result,'*'); break;
    end;
  end;
  DelStack;
end;

function CdrOrdZajDef;
var i: longint;
  ao: TArrInt;
begin
  AddStack('FDM.CdrOrdZajDef');
  result:=SetByte(CntSel);
  for i:=low(aClr) to high(aClr) do SetByte(result,aClr[i],false);
  SetLength(ao,Length(aOrd));
  for i:=low(aOrd) to high(aOrd) do ao[aOrd[i]-1]:=i;
  for i:=low(ao) to high(ao) do IncD(result,StrNum(IfThen(i=low(ao),'/',','),ao[i]+1));
  DelStack;
end;

procedure qSetWhere;
var h,where: string;
  q: TBrQuery;
  function Zn(const s: string; ln: longint): string;
  begin
    AddStack('FDM.qSetWhere.Zn');
    if ln=0 then result:=Vtos(Int0(DM.ListGet.CodeDop(s,[cdgBufAll]))) else result:=QQi(s,ln);
    DelStack;
  end;
	procedure Flt1(const im,mim,flt: string; const anmf: array of string; g: TCustomGet;
  	ln: longint; const def: string = ''; const orWhere: string = '');
  var a,a1: TArrStr;
    i,l: longint;
    s: string;
  begin
    AddStack('FDM.qSetWhere.Flt1');
    case TFltList(Cdr[vflt+flt]) of
      fltOne: begin
      	s:=Cdr[sMemo+vflt+flt];
        if empty(s) then s:=def;
        SetLength(a,Length(anmf)+1);
        for i:=low(anmf) to high(anmf) do a[i]:=anmf[i]+'='+Zn(s,ln);
        a[high(a)]:=orWhere;
        DlmBetwSelf(where,BrackNoEmp(DlmBetween(a,sOR)),sAND);
        if g is TCodeGet
        then s:=TCodeGet(g).CodeName(s,[cdgBufAll])
        else s:=TMenuGet(g).MenuName(s);
        IncD(h,'; '+im+': '+Trim(s));
      end;
      fltAny: begin
        s:=Cdr[sMemo+vflt+flt];
        if (s<>'') then begin
          l:=LsArrDynamic(s,a,',');
          if g is TMenuGet then begin
            s:='';
            for i:=0 to l-1 do DlmBetwSelf(s,GetProgInf(Int0(a[i])).Abr,',')
          end;
          IncD(h,'; '+mim+': '+s);
          for i:=0 to l-1 do a[i]:=Zn(a[i],ln);
          SetLength(a1,Length(anmf)+1);
          for i:=low(anmf) to high(anmf) do a1[i]:=FldInList(anmf[i],a,l);
          a1[high(a1)]:=orWhere;
          DlmBetwSelf(where,BrackNoEmp(DlmBetween(a1,sOR)),sAND);
        end;
      end;
    end;
    DelStack;
  end;
var i,j: longint;
  	s: string;
    a: TArrStr;
begin
  AddStack('FDM.qSetWhere');
  br.FindQuery; q:=pointer(br.Qry); q.ClearFilter; h:=''; where:=cwhere;
  Flt1('пользователь',FLow(GetPrim(tCDR)),'CDR',afCdr,CdrGet,lCdrTN,Cdr[fCDR]);
  Flt1('клиент',FLow(GetPrim(tLIST)),'ORG',afOrg,DM.ListGet,0,defOrgKod);
  Flt1('вид','виды','PRG',afProg,DM.ProgGet,lProgKP,'1');
  if (fd<>nil) then begin
    for i:=low(fd^) to high(fd^) do
      Flt1(fd^[i].im,fd^[i].mim,fd^[i].flt,fd^[i].anmf,fd^[i].g,fd^[i].ln,fd^[i].def,fd^[i].orWhere);
  end;
  s:=Cdr[vflt+'STATUS'];
  if (not empty(s)) then begin
    IncD(h,'; Статус: ');
    SetLength(a,Length(aProgStat[stvHead]));
    j:=0;
    for i:=byte(low(aProgStat[stvHead])) to byte(high(aProgStat[stvHead])) do begin
      if (GetByte(s,i+1)) then continue;
      IncD(h,aProgStat[stvHead,TProgStatList(i)]+',');
      a[j]:=Vtos(i);
      Inc(j);
    end;
    DecLen(h);
    DlmBetwSelf(where,FldInList('STATUS',a,j),sAND);
  end;
  if (q.Arg[sWHERE]<>where) then begin
    q.Arg[sWHERE]:=where; q.SetPart(aPartWOGH[where='',false,true,true]);
  end;
  q.Filtered:=StrToBoolean(Cdr[vflt]) and not empty(Cdr[sMemo+vflt]);
  if (not q.Filtered) then lsRec.Clear
  else begin
    Inter.SetProg(Cdr[sMemo+vflt]);
    IncD(h,'; доп.фильтр');
  end;
  lFiltered:=q.Filtered;
  pnh.Header:=FRup(Copy(h,3,MaxInt));
  DelStack;
end;

function ProgTp;
var k: longint;
begin
  AddStack('FDM.ProgTp');
  k:=ProgInf.id;
  if (InRange(k,low(ProgTypes),high(ProgTypes))) then result:=ProgTypes[k]
  else Finalize(result);
  DelStack;
end;

function MakeFullPath(const ProgND,ProgDir: string; var dir: TFileName): boolean; 
var s: string;
begin
  AddStack('FDM.MakeFullPath');
  Drv.Seek(Drv.TblFldName(fDRV)+'='+QQs(ProgND)); s:=Drv[fNAME]; result:=IsSelfComp(s);
  if result and IsNetDrive(s) then dir:=Drv['LOCAL']+DriveDelim+PathDelim else dir:=CorrDir(s);
  if not empty(ProgDir) then IncD(dir,CorrDir(ProgDir));
  DelStack;
end;

function MakeFullPath(const ProgND: string; const ProgDir: string = ''): TFileName;
begin
  MakeFullPath(ProgND,ProgDir,result);
end;

function GetDbSrvName(const aDrvIp,aPort,aDrvLocal,aDrvDir,aEnding: string): string;
var s: string;
begin
  s:=aDrvLocal;
  if (s<>'')and(s[length(s)]=DriveDelim) then DecLen(s);
  result:=IPToHost(aDrvIp)+IfThen(aPort<>'',SRVPORTDELIM+aPort)+DriveDelim+
          s+DriveDelim+PathDelim+
          IfThen(not empty(aDrvDir),CorrDir(aDrvDir))+
          CorrDir(aEnding);
end;

function PrNetRes(const av: array of variant; var NetResource: TNetResource): boolean;
var p: PNetResource;
    pfl,pNoMap: PBoolean;
begin
  AddStack('FDM.PrNetRes');
  result:=true; p:=PointerVar(av[0]);
  with NetResource do begin
    if Assigned(lpLocalName)
    then result := AnsiStrComp(StrUpper(p.lpLocalName),StrUpper(lpLocalName))<>0;
    if not result then begin
      pfl:=PointerVar(av[1]); pNoMap:=PointerVar(av[2]);
      if Assigned(lpRemoteName)
      then pNoMap^:=AnsiStrComp(StrUpper(p.lpRemoteName),StrUpper(lpRemoteName))<>0;
      if pNoMap^ then
        if WNetCancelConnection2(lpLocalName,CONNECT_UPDATE_PROFILE,false)<>NO_ERROR then begin
          mess_ok(['Ошибка отключения сетевого диска '+string(lpLocalName)+DriveDelim,string(lpRemoteName)]);
          pfl^:=false;
        end;
    end;
  end;
  DelStack;
end;

function Prepare2RunProg;
var d1,dsk,s,aPort{,t,u,v}: string;
  lSelfDir,NoMap,b: boolean;
  lpNetResource: TNetResource;
  {dcp: TDbConnectPrms;}
  f: TIniFileCheck;
  fn: TFileName;
  fbp: TGetFbPortOpt;
begin
  AddStack('FDM.Prepare2RunProg');
  lSelfDir:=MakeFullPath(Prog[fDRV],Prog['DIR'],dir); dsk:=Trim(Drv[fNAME]);
  if not Assigned(pPort) then pPort:=@aPort;
  if p2rMakeDir in Opt then result:=ForceDirMsg(dir)
  else begin
    result:=DirectoryExists(dir);
    if not result then mess_ok(['Отсутствует папка:',dir])
  end;
  if result then begin
    if not(p2rMakeDir in Opt) then
      if not MyFileExists(CorrDir(dir)+ExeMenu) then begin
        mess_ok(['В папке '+dir,'отсутствует программа "'+ProgInf.Name+'".']); result:=false;
      end;
    if result then begin
      if ProgTp.lWin then begin
{ $IFDEF OLDCNF
        dsk:='';
        SetByte(dsk,cnfClient,true);
{$ENDIF}
        if p2rRunMode in Opt then fbp:=[fbpRunMode] else fbp:=[];
        pPort^:=GetFbPort(Drv,[],[],Prog['FBVERS'],fbp,@b);
        if (b) then result:=false
        else begin
          if lSelfDir then begin
{ $IFDEF OLDCNF
            SetByte(dsk,cnfServer,true);
{$ENDIF}
            s:=TrimRight(Drv['LOCAL']);
            if (s='') then s:=dsk;
            d1:=GetDbSrvName('127.0.0.1',pPort^,s,Drv['DIR'],Prog['DIR']);
          end else begin
            d1:=GetDbSrvName(Drv[fIP],pPort^,Drv['LOCAL'],Drv['DIR'],Prog['DIR']);
          end;
          if GetDataIniFileExisting(dir,fn) then begin
            f:=TIniFileCheck.Create(fn);
            try
{ $IFDEF OLDCNF
              TDBPrmGet.WriteConfigFile(f,stpReg,dsk);
{$ENDIF}
              s:=stpReg+'.'+drvINTRBASE;
              f.WriteString(s,ibpServerName,d1+DirDatas+ProgTp.sid+'.'
                +aInterbaseExt[TInterbaseExt(f.ReadInteger(s,ibpExt))]);
              f.WriteInteger(s,ibpPath,byte(ibppNoStd));
              f.WriteString(s,ibpUserName,GetDBParams.Values[GetDBUserName]);
              f.WriteInteger(s,ibpType,byte(ibtFIB));
              f.WriteString(s,ibpFBLocal,bFalse);
            finally
              f.Free;
            end;
          end;
        end;
      end else begin
        if not lSelfDir then with lpNetResource do begin
          result:=not empty(Drv['KD']);
          if (not result) then mess_ok(['Необходимо присвоить имя для подключения',
            'диску '+Trim(DM.DrvGet.Codest(Prog[fDRV]))])
          else begin
            dir:=Drv['KD']+DriveDelim+PathDelim+CorrDir(Prog['DIR']);
            dwScope:=0;
            dwType:=RESOURCETYPE_DISK;
            dwDisplayType:=RESOURCEDISPLAYTYPE_SERVER;
            lpLocalName:=StrAlloc(Length(Drv['KD'])+2);
            lpRemoteName:=StrAlloc(Length(dsk)+1);
            try
              StrCopy(lpLocalName,PChar(string(Drv['KD'])+DriveDelim));
              StrCopy(lpRemoteName,PChar(dsk));
              NoMap:=true;
              ProcNetRes(PrNetRes,[LongInt(@lpNetResource),LongInt(@result),LongInt(@NoMap)],RESOURCE_CONNECTED);
              if (result)and(NoMap) then begin
                result:=WNetAddConnection2(lpNetResource,nil,nil,0)=NO_ERROR;
                if not result then mess_ok(['Ошибка подключения к сетевому диску '+Drv['KD']+DriveDelim,dsk]);
              end;
            finally
              StrDispose(lpLocalName); StrDispose(lpRemoteName);
            end;
          end;
        end;
      end;
      {
      if (result) then begin
        s:=FbsSrvVers2DotFmt(Prog['FBVERS']);(* предполагаемая версия gdb файла *)
        t:=FbsSrvVers2DotFmt(Drv['FBVERS']);(* предполагаемая версия сервера, где лежит gdb *)
        if (s<>'')and(t<>'')and(s>t) then begin
          if (GetDbAddress(dir,aProgType.fdbf,dcp)) then begin
            if (FbsFile2SrvVers(dcp,s,u,@v)) then begin
              try
                GetSrvOds(dcp,t);
              except
                t:='';
              end;
              if (t<>'')and(s>t) then begin
                if (not Ask(['Версия '+s+' базы данных <'+v+'>','несовместима с версией сервера, на котором находится этот файл('+t+').','Продолжить?'])) then begin
                  result:=false;
                end;
              end;
            end;
          end;
        end;
      end;
      }
    end;
  end;
  DelStack;
end;

function GetFbPort;
var sl: TStringList;
  procedure GetFbVersList(aRecDB: TRecDB; const aFldVers,aFldPort: array of string);
  var k,j: longint;
      s,t: string;
  begin
    for k:=0 to high(aFldVers) do begin
      s:=aFldVers[k];
      if (aRecDB<>nil) then s:=aRecDB[s];
      s:=FbsSrvVers2DotFmt(s);
      if (s='') then break;
      if (k>high(aFldPort)) then break;
      t:=aFldPort[k];
      if (aRecDB<>nil) then j:=aRecDB[t] else j:=StrToIntDef(Trim(t),0);
      sl.AddObject(s,pointer(j));
    end;(* for k *)
  end;
var s,t: string;
  k,j: longint;
begin
  AddStack('FDM.GetFbPort');
  SetPBoolean(aAborted);
  t:=FbsSrvVers2DotFmt(aFbVers);(* предполагаемая версия gdb файла *)
  sl:=SortStrListCreate;
  try
    if aRdbDrv=nil
    then GetFbVersList(nil,aVers,aPorts)
    else GetFbVersList(aRdbDrv,FLD_FBVERSPORT[0],FLD_FBVERSPORT[1]);
    k:=sl.IndexOf(t);
    if (k<0) then begin
      if (sl.Count>0) then begin
        for j:=low(FBSERVODS) to high(FBSERVODS) do begin
          s:=FBSERVODS[j,0];
          if (s<t) then continue;
          k:=sl.IndexOf(s);
          if (k>=0) then break;
        end;(* for j *)
      end;
      if not(fbpNotShowMsg in Opt)and(not(fbpRunMode in Opt)or(k<0)) then begin
        s:='Возможно, на компьютере с базой данных отсутствует соответствующий учётной записи сервер Firebird.';
        if (k>=0) then IncD(s,CRLF+'Подключение будет осуществлено к серверу версии '+sl[k]+'.');
        IncD(s,CRLF+'Продолжить?');
        if not Ask(s) then SetPBoolean(aAborted,true);
      end;
    end;
    if k<0 then result:='' else result:=Int2Str(sl,k);
  finally
    sl.Free;
  end;
  DelStack;
end;

function RegNum(ko: longint; status: TProgStatList; const cp,cpa: string): string; overload;
begin
  AddStack('FDM.RegNum');
  result:=Trim(ListKod(ko))+'-'+Trim(IfThen(status=stpTemp,cpa,cp));
  DelStack;
end;

function RegNum: string;
begin
  result:=RegNum(Prog[fORG],Prog['STATUS'],Prog[fProgCP],Prog['CPA']);
end;

procedure Write_SET_XXX_Ini(const progSid,progTn,progKP,progND,progDIR,progFbVers: string;
  progKo: longint; progStatus: TProgStatList; const progCP,progCPA: string;
  out dir: TFileName; Opt: TWriteSetIniOpt; const fileSftp: string='');
var af: array of TIniFileCheck;
  procedure WriteBool(const Ident: string; Value: Boolean);
  var i: byte;
  begin
    for i:=low(af) to high(af) do af[i].WriteBool('SETGGW',Ident,Value);
  end;
  procedure WriteString(const Ident,Value: String);
  var i: byte;
  begin
    for i:=low(af) to high(af) do af[i].WriteString('SETGGW',Ident,Value);
  end;
  procedure WriteInteger(const Ident: string; Value: Longint);
  var i: byte;
  begin
    for i:=low(af) to high(af) do af[i].WriteInteger('SETGGW',Ident,Value);
  end;
var getDbaDir,b: boolean;
  s,otv: string;
  mq: TMulQuery;
  a: TArrStr;
  k: longint;
begin
  AddStack('FDM.Write_SET_XXX_Ini');
  b := (progKo=0) and empty(progCP) and empty(progCPA); SetLength(af,IfThen(b,1,2));
  af[0]:=TIniFileCheck.Create(ExeDir+'SET_'+progSid+'.INI',nil,[],SetggwExeFile);
  if not b then af[1]:=TIniFileCheck.Create(ExeDir+'SET_'
    +GetRegNum(RegNum(progKo,progStatus,progCP,progCPA))+'.INI',nil,[],SetggwExeFile);
  try
    if (not SYSDBA) then begin
      otv:=progTn;
      getDbaDir:=empty(progKo);
      WriteBool('Osn',not getDbaDir);
      b:=true;
      if (getDbaDir) then begin
        mq:=ProgPswd.GetQuery;
        try
          mq.PartSelect(Cdr.NameDB,[fCDR],fNAME+'='+QQs(sSYSDBA));
          b:=mq.IsRecords;
          otv:=mq.Fields[0].AsString;
        finally
          ProgPswd.FreeQuery;
        end;
      end;
      if (b) then begin
        mq:=ProgPswd.GetQuery;
        try
          mq.PartSelect(tPROG,[fDRV,'DIR'],
            fCDR+'='+QQs(otv)+sAND+fORG+'='+VToS+sAND+fProgKP+'='+QQs(progKP),fProgNP);
          if mq.IsRecords
          then WriteString('NDir',TrimRight(MakeFullPath(mq.Fields[0].AsString,mq.Fields[1].AsString)));
        finally
          ProgPswd.FreeQuery;
        end;
      end;
    end;
    if MakeFullPath(progND,progDIR,dir) then s:=dir
    else s:=GetDbSrvName(Drv[fIP],GetFbPort(Drv,[],[],progFbVers,[fbpNotShowMsg]),Drv['LOCAL'],Drv['DIR'],progDIR);
    WriteString('DBSRVNAME',s);
    WriteString('IDir',dir);
    WriteString('ADir',dir);

    if winiClearIniDirs in Opt then begin
      //зануляем "Папку для архива программы" при создании архива (F5)
      WriteString('AAdir','');
      //зануляем "Папку с архивом программы" при установке из архива (F3)
      WriteString('IAdir','');
    end;

    for k:=0 to LsArrDynamic(fileSftp+CRLF(* запишем пустую строку - признак окончания перечня файлов *),a,CRLF)-1 do
      WriteString(StrNum('FILESFTP',k),a[k]);

    WriteBool('MinInterface',false);
    WriteBool('LUst',true);
    WriteBool('LRest',true);
    WriteInteger('FlRest',2);
    WriteInteger('FlModel',2);
    WriteInteger('FlData',IfThen(winiWin in Opt,2,1));
    WriteString('FBVERS',progFbVers);
  finally
    for k:=low(af) to high(af) do af[k].Free;
  end;
  DelStack;
end;

procedure Write_SET_XXX_Ini(out dir: TFileName; Opt: TWriteSetIniOpt = []; const fileSftp: string=''); overload;
begin
  if ProgTp.lWin then Include(Opt,winiWin);
  Write_SET_XXX_Ini(ProgTp.sid,Prog[fCDR],Prog[fProgKP],Prog[fDRV],Prog['DIR'],Prog['FBVERS'],
    Prog[fORG],Prog['STATUS'],Prog[fProgCP],Prog['CPA'],dir,Opt,fileSftp);
end;

procedure SetInfo;
begin
  AddStack('FDM.SetInfo');
  ProgPswd.SetInfoName('Программа "Учёт клиентов"');
  DelStack;
end;

const aExecFileCapt: TArrBoolStr = ('Обновление','Создание');
var lExecFileInd: boolean;

function ExecFile(Sender: TAsk; Opt: TExecFileOpt = [];
  tp: TIndFileTypes = [low(TIndFileType)..high(TIndFileType)]; pSucced: PBoolean = nil): boolean;
const
  a: array[boolean,TIndFileType] of string =
    (('D','4')
    ,('C','3')
    );
var t: TIndFileType;
  fl: boolean;
  ChrsExt: string;
begin
  AddStack('FDM.ExecFile');
  if (lExecFileInd=(exfCrt in Opt)) or (exfBound in Opt) then begin
    if Assigned(Sender) then begin
      Sender.ClearCurTime; fl:=not Sender.SayCapt([aExecFileCapt[exfCrt in Opt]+' индексов']);
    end
    else fl:=true;
    if fl then begin
      lExecFileInd:=not(exfCrt in Opt); ChrsExt:='';
      for t:=low(t) to high(t) do
        if t in tp then IncD(ChrsExt,a[exfCrt in Opt,t]);
      if not ExecFile(Opt,ChrsExt,pSucced) then Sender.Abort;
    end;
  end;
  result:=not Sender.Aborted;
  DelStack;
end;

function ExecFile(Sender: TAsk; lCrt: boolean; tp: TIndFileType): boolean;
var Opt: TExecFileOpt;
begin
  if lCrt then Opt:=[exfCrt] else Opt:=[];
  result:=ExecFile(Sender,Opt,[tp]);
end;

procedure StExecFile(Sender: TStat; const Params: array of variant; var Aborted: boolean);
var ls: TStringList;
  q: TMulQuery;
  ost,i: longint;
  f: TFileName;
  ChrsExt,s: string;
  pSucced: PBoolean;
  lCrt: boolean;
begin
  ost:=AddStack('ZpProc.StExecFile');
  lCrt:=Params[0]; pSucced:=PointerVar(Params[2]); SetPBoolean(pSucced,true);
  q:=TMulQuery.CreateConnection; ls:=TStringList.Create;
  try
    q.DBFlush([flushConnect,flushBound]); ChrsExt:=Params[1];
    for i:=1 to Length(ChrsExt) do begin
      f:=ExeDir+GetDriverName(DBMain)+'.SQ'+ChrsExt[i];
      if MyFileExists(f) then begin
        s:=ls.Text; ls.LoadFromFile(f); ls.Text:=s+ls.Text;
      end;
    end;
    for i:=0 to ls.Count-1 do begin
      if Sender.SayStat((i+1)/ls.Count) then break;
      if not AnsiStartsStr('&&',ls[i]) then begin
        q.SQLText(ls[i]);
        try
          q.ExecSQL;
        except
          on E:EDatabaseError do begin
            SetStack(ost);
            if not SetPBoolean(pSucced) then
              if lCrt then mess_ok([TrimRight(q.Text),'',E.Message,'',
                'Рекомендуется выполнить проверку данных,','а затем сортировку данных.'],
                'Ошибка создания индекса');
          end;
        end;
      end;
    end;
  finally
    q.Free; ls.Free;
  end;
  DelStack;
end;

function ExecFile(Opt: TExecFileOpt; const ChrsExt: string; pSucced: PBoolean = nil): boolean;
begin
  AddStack('FDM.ExecFile(f)');
  result:=not ShowStat(aExecFileCapt[exfCrt in Opt]+' индексов'+IfThen(exfCrt in Opt,StLongProcess),StExecFile,
    [exfCrt in Opt,ChrsExt,LongInt(pSucced)],IfThen(exfNoCanEsc in Opt,stNoCanEsc));
  DelStack;
end;

function LockBuhRead;
begin
	AddStack('FDM.LockBuhRead');
  result:=LockMode('Поиск в данных "Бухгалтерии"','FBUH','FBUH=2',1);
  DelStack;
end;

function LockBuhWrite;
begin
	AddStack('FDM.LockBuhWrite');
  result:=LockMode('Загрузка данных из "Бухгалтерии"','FBUH','FBUH>0',2{,0});
  DelStack;
end;

procedure ListSave;
begin
  AddStack('FDM.ListSave');
  if Length(aSvi)=nSvi then SetLength(aSvi,nSvi+1);
  with aSvi[nSvi] do begin
    recno:=List.RecNo; List.GetAFieldValue(af);
  end;
  Inc(nSvi);
  DelStack;
end;

procedure ListRest;
begin
  AddStack('FDM.ListRest');
  Dec(nSvi);
  with aSvi[nSvi] do if recno<>List.RecNo then begin
    List.RecNo:=recno; List.SetAFieldValue(af);
  end;
  DelStack;
end;

function DBBuh;
begin
  AddStack('FDM.DBBuh');
  if not Assigned(FDBBuh) then FDBBuh:=ProgPswd.CreateDatabase('BUH','BUH',false);
  result:=FDBBuh;
  DelStack;
end;

procedure EvalEnclosingProc(beforeEval: boolean; var p: pointer);
begin
  if Assigned(List) then
    if beforeEval then ListSave else ListRest;
end;

function IfThen(AValue: boolean; ATrue: TZajEditOpt = []): TZajEditOpt;
begin
  if AValue then Result:=ATrue else Result:=zpsDefault;
end;

// Вчера все ушли в 18:00
procedure SetStatusNone;
var s: string;
  a: TArrStr;
  i: longint;
begin
  AddStack('FDM.SetStatusNone');
  if PswdPrm.UserNum=0 then with ProgPswd.GetQuery do begin
    s:=FldInSel(fCDR,tCDR,DlmBetween(where,'STATUS<>'+Vtos(cstNone),sAND),'',[fselList]);
    if not empty(s) then begin
      PartMax(tOFIS,fTD,[fCDR],s); s:=DateToString(trunc(Now));
      SetLength(a,RecordCount); i:=0;
      while not Eof do begin
        if TrimRight(Fields[1].AsString)<s then begin
          Ofis.NewRec; Ofis[fCDR]:=Fields[0].AsString; a[i]:=QQs(Ofis[fCDR]);
          Ofis['STATUS']:=cstNone; Ofis[fTD]:=StuffString(Fields[1].AsString,9,6,'180000');
          Ofis.AppRec; Inc(i);
        end;
        Next;
      end;
      UpdateTableFldList(['STATUS'],[cstNone],a,i,fCDR,[],tCDR);
    end;
    ProgPswd.FreeQuery;
  end;
  DelStack;
end;

function GetAccData;
  function GetFilesCount(const aDir: string): longint;
  var sr: TSearchRec;
  begin
    result:=0;
    if (FindFirst(aDir+PathDelim+'*.*',faAnyFile and (not faDirectory),sr)=0) then begin
      try
        repeat
          inc(result);
        until (FindNext(sr)<>0);
      finally
        SysUtils.FindClose(sr);
      end;
    end;
  end;
var k,iAct,iOnsrv: longint;
  iInout: TAccInOut;
  b: boolean;
  q: TMulQuery;
  s: string;
begin
  if lsAcc=nil then begin
    lsAcc:=TIntegerList.Create([ilsSorted]); SetLength(adAcc,10);
  end;
  b:=lsAcc.IntObjFindAdd(aAccId,k);
  if not b then if Length(adAcc)=k then SetLength(adAcc,k shl 1);
  with adAcc[k] do begin
    if (not b)or(longword(Windows.GetTickCount-adTime)>MSecsPerMin) then begin
      iAct:=ACTIVITY_EMPTY;
      iInout.dw:=0;
      iOnsrv:=0;
      if aAccId>0 then begin(* чтобы не делать запрос для 0 *)
        q:=PswdEd.GetQuery;
        try
          q.PartSelect(tACC+' a join '+tFTPSRV+' f on a.'+fFTPSRV+'=f.'+fFTPSRV,
                      ['a.acdir,f.srvdir'],
                      'a.'+fACC+'='+QQs(AcidAsStr(IntToStr(aAccId))));
          if (q.IsRecords) then begin
            s:=GetSftpDataDir(Trim(q.Fields[1].AsString))+PathDelim+
              TrimRight(q.Fields[0].AsString)+PathDelim;
            GetLastVisit(s,nil,nil,nil,@iAct);
            for b:=false to true do iInout.a[b]:=GetFilesCount(s+SmailDirBox[b,false]);
            iOnsrv:=GetFilesCount(s+SmailDirOnServer);
          end;
        finally
          PswdEd.FreeQuery;
        end;
      end;
      adTime:=Windows.GetTickCount;
      adActivity:=iAct;
      adInout:=iInout;
      adOnsrv:=iOnsrv;
    end;
    case adf of
      ADF_ACTIVITY: result:=adActivity;
      ADF_INOUT: result:=longint(adInout);
      ADF_ONSRV: result:=adOnsrv;
      else result:=0;
    end;
  end;
end;

procedure PrFldMaxLength(tf: TFldEdit; var Proc: TMaxLengthEvent);
begin
  AddStack('FDM.PrFldMaxLength');
  if tf.NameRecFld='MSGTXT' then Proc:=DM.MsgMaxLength
  else if AnsiMatchText(tf.NameRecFld,['ZAJTXT','SI_ZAJ_TXT']) then Proc:=DM.ZajMaxLength;
  DelStack;
end;

function TDM.MsgMaxLength;
begin
  AddStack('TDM.MsgMaxLength',Self);
  aSplitTxt254(Msg,TCustomEdMemo(Sender).Text,false,@result);
  DelStack;
end;

function TDM.ZajMaxLength;
begin
  AddStack('TDM.ZajMaxLength',Self);
  aSplitTxt254(Zaj,TCustomEdMemo(Sender).Text,false,@result);
  DelStack;
end;

class function TDM.ZajMovMaxLength;
begin
  AddStack('TDM.ZajMovMaxLength');
  aSplitTxt254(Zaj,TCustomEdMemo(Sender).Text,false,@result,'MOV');
  DelStack;
end;

procedure PrimFldProc(const tbl,nmf: string; var prim: string; var PrimSave: boolean);
const aDrvFB: array[0..1] of string = ('FBVERS','FBPORT');
var i: byte;
  p: TOrdFixList;
  s: string;
label lend;
begin
  AddStack('FDM.PrimFldProc');
  if PrimFld(prim,nmf,
    [fCNGV            ,fMdPATH,fMdFILE,fMDV    ,fMDG          ,fMDP           ],
    ['номер изменения','папка','файл' ,'версия','общая версия','вид программы']) then goto lend;
  if tbl=tDRV then for i:=low(aDrvFB) to high(aDrvFB) do if AnsiStartsText(aDrvFB[i],nmf) then begin
    prim:=GetPrimFld(tbl,aDrvFB[i])+' '+Copy(nmf,Length(aDrvFB[i])+1,MaxInt); goto lend;
  end;
  if tbl=tPROG then if ProgFldFind(nmf,p) then prim:=FLow(ProgFld[p].ofvName);
  if tbl=tZAJ then for i:=1 to ofzCnt do begin
    s:=FLow(ZajFldName(i));
    with aOrdFixz[i] do if PrimFld(prim,nmf,
    [ofzvFld,ofzvSort               ,ofzvFld+'1'    ],
    [s      ,s+'(значение в списке)',s+'(окончание)']) then goto lend;
  end;
  if PrimFld(prim,nmf,
    [fCDR                ,fORG],
    ['номер пользователя','уникальный номер клиента']) then goto lend;
lend:
  DelStack;
end;

procedure SpGkDefProc(lsDef: TSpGkStrList);
var p: PSpGkStr;
begin
  AddStack('FDM.SpGkDefProc');
  p:=lsDef.AddKey('MSG');
  p[spgkPrim]:='текст';
  p[spgkMinRow]:='3';
  p[spgkWndName]:=FLow(GetPrim(tMSG));

  p:=lsDef.AddKey('ZAJ');
  p[spgkPrim]:='текст';
  p[spgkMinRow]:='3';
  p[spgkWndName]:=FLow(GetPrim(tZAJ));

  p:=lsDef.AddKey('simsg');
  p[spgkPrim]:='шаблон';
  p[spgkMinRow]:='3';
  p[spgkWndName]:='отправить по интернету';
  DelStack;
end;

procedure LogTrnsValProc(var Prm: TLogTrnsValPrm);
var d: TDateTime;
  t: string;
begin
  AddStack('FDM.LogTrnsValProc');
  with Prm do
    if LogEqual(Prm,tCDR,'STATUS')
      then LogEnumVal(Prm,aCdrStat)
    else if LogEqual(Prm,tCDR,'CNGFLT') then begin
      val:=bRus[Int0(val)=0]; lBreak:=true;
    end
    else if LogEqual(Prm,tCDR,['FLTSTATUS','ZAJSTATUS'])
      then TChkLogCompare.Execute(Prm,aProgStat[stvName],true)
    else if LogEqual(Prm,tCDR,[sMemo+'FLT',sMemo+'ZAJ'])
    or LogEqual(Prm,tFLT,sMemo+'FLT')
    or LogEqual(Prm,tGLOB,sMemo+'CALC')
      then TCrlfLogCompare.Execute(Prm)
    else if LogEqual(Prm,tCDR,[sMemo+'FLTCDR',sMemo+'ZAJCDR',sMemo+'ZAJITN',sMemo+'ZAJTN',sMemo+'ZAJWTN'])
      then TCodLogCompare.Execute(Prm,CdrGet)
    else if LogEqual(Prm,tCDR,[sMemo+'FLTORG',sMemo+'ZAJORG'])
      then TCodLogCompare.Execute(Prm,DM.ListGet)
    else if LogEqual(Prm,tCDR,'PSWD') then begin
      val:=StringOfChar('*',Length(TrimRight(DeShifrStr(val)))); lBreak:=true;
    end
    else if LogEqual(Prm,tCNGV,sMemo+'F')
      then TCngvLogCompare.Execute(Prm)
    else if LogEqual(Prm,tGLOB,sMemo+'PROGD')
      then TDatLogCompare.Execute(Prm,Prog)
    else if LogEqual(Prm,tGLOB,sMemo+'PROGW')
      then TWinLogCompare.Execute(Prm)
    else
    if not DM.ProgGet.LogEqual(Prm,tPROG,fProgKP) then
    if not DM.MgFbVers.LogEqual(Prm,tPROG,'FBVERS') then
    if LogEqual(Prm,tPROG,'DLAST') then begin
      val:=OurFormatDateTime(DLastFormat,Sender[nmf]); lBreak:=true;
    end
    else if LogEqual(Prm,tPROG,'PUPASS') then begin
      val:=StringOfChar('*',Length(TrimRight(DeShifrStr(val)))); lBreak:=true;
    end
    else if LogEqual(Prm,tPROG,'STATUS')
      then LogEnumVal(Prm,aProgStat[stvName])
    else if LogEqual(Prm,tZAJ,'ISPV')
      then LogEnumVal(Prm,ISPVID_NAMES,byte(low(ISPVID_NAMES)))
    else if LogEqual(Prm,tZAJ,['SELISPSH','TSELISP']) then begin
      lOut:=false; lBreak:=true;
    end
    else if LogEqual(Prm,tMSG,[fTD,'TD1'])
    or LogEqual(Prm,tZAJ,[fTD,'TDISPD','TISPD','TISPD1','TSELISP','TSELISPE','TWD','TWD1','TWDSORT','TWDTN']) then begin
      TDM.DateToRec(TRecDB(Sender),nmf,val,d,t); val:=dtoc(d)+' '+t; lBreak:=true;
    end;
  ;DelStack;
end;

procedure Init;
const aSpGk: array[0..0] of TSpGkTblDef =
  ((tbl:tZAJ;nmf:'REVALUE';key:'REVAL'; minrow:3)
  );
begin
  AddStack('FDM.Init');
  SetLength(aSvi,1); AddFrom(EvalEnclosingProc);
  FEdText.PrFldMaxLength:=PrFldMaxLength;
  lsRec:=TIntStrList.Create([ilsSorted],0); LenDispDate:=Length(StringToDispDate('20000101',2));
  SetPrim(tCNG,'Слежение за изменениями');
  AddFrom(PrimFldProc);
  AddFrom(aSpGk);
  AddFrom(SpGkDefProc);
  LogTrnsValProcAdd(LogTrnsValProc);
  DelStack;
end;

initialization
  Init;
finalization
	AddStack('FDM.finalization');
  lsHost.Free; lsRec.Free; lsAcc.Free;
  DelStack;
end.
