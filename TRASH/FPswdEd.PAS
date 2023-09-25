unit FPswdEd;

interface

{$I ORGTEST}
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, ExtCtrls, DB, DBTables, StdCtrls, Math, ComCtrls, RegStr, StrUtils,
  MyTypes, My_pr, FrmPswd, FFldedit, ButGet, DefEdit, mulqry, PnlEdit, Keylb, Fpanel,
    Askp, KeyMenu, Codegets, ComboGet, FrmBrIB, CCodeGet, Recdb, RecVal, BrQuery;

type
  TPswdEd = class(TFormPswd)
    RGLob: TRecDB;
    tmCng: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure KeyLb1ProcKey(key: Integer; tw: TWinControl);
    procedure FormDestroy(Sender: TObject);
    function dePrmPnlValid(Sender: TObject): Boolean;
    procedure tmCngTimer(Sender: TObject);
    function PnPswValid(Sender: TObject): Boolean;
  private
    { Private declarations }
    UOffEsc,UOffMsg,UbuhLoadLocking: boolean;
    oLockLstCalcFields: TDataSetNotifyEvent;
    qCng: Tmulquery;
    nRead: longint;
    oPrivProc: TPrivProc;
		procedure LockLstCngFldProc(Sender: TObject; lBefore: boolean; var BrQuery1NAME: TField);
    procedure LockLstBrQuery1CalcFields(DataSet: TDataSet);
    procedure LogFltMaskFldProc(const NmFld: string; var Mask: string);
		class procedure PrOff(Sender: TAsk);
    function OffHookProc(var Message: TMessage): Boolean;
		class procedure TimerOff(Sender: TObject);
		procedure SetPrmLocal;
    class procedure QryMsgBeforeOpen(DataSet: TDataSet);
    class function CdrGetFormIBList(Sender: TFldEdit): TFormBrIB;
    class procedure CdrGetAfterList(Sender: TObject);
	  class function CdrGetStrName(Sender: TObject; Qry: TBrQuery): string;
  protected
		function CreateIndex(Sender: TAsk): boolean; override;
		function LoadForms(Sender: TAsk): boolean; override;
		procedure ExecProg; override;
		function RegModify(Sender: TAsk; const Vers,LastVers: string; fl: TDBMainModify): boolean; override;
		function DBMainModify(Sender: TAsk; const Vers: string; fl: TDBMainModify): boolean; override;
		function GetPswdInit: string; override;
		function MsgGetUpd: boolean; override;
    procedure DateRegSet; override;
  public
    { Public declarations }
		function CalcMode(DataSet: TMulQuery): string; override;
		function PrmLocal(const aDopName,aDopSection: array of string;
    	const Capt: TCaption = ''; lRestart: boolean = true): boolean; override;
		procedure GetUpd(const nmMsg: string); override;
  end;

var
  PswdEd: TPswdEd;

implementation

{$R *.dfm}

uses
  IdGlobalProtocols,
  FSchemDM, DirGet, FMsOffEd, FFdp, FLockLst, Tone, FDWPrm,
    FEdGenFr, RbPage, Shifr, fsumm, FHelpLs, CopyData, FStat, BufFile,
  ProgType,
  FCopyLs,
  BuhTypes,
  OLTypes, FDM, DMProc, FMain, FCdrLs, OLGets, OLProc;

type TMsgOffList = 1..5;
  TLogKeyList = logkOLCnt..-1;

const acMsgOff: array[TMsgOffList] of string = ('Внимание !','Ваш компьютер будет выключен администратором.',
	'Необходимо закрыть все работающие программы.','Для выключения компьютера вручную нажмите "Отмена".',
  'До выключения компьютера осталось 1 минута.');

  sISDEVELOP = 'ISDEVELOP';

var aMsgOff: array[TMsgOffList] of variant;

function LockRead: boolean;
begin
	AddStack('FPswdEd.LockRead');
  with PswdEd do begin
    result:=LockMode('Просмотр данных','FREAD','FMONO>0',1,0,IfThen(nRead<>0,lockmdNo));
    if result then Inc(nRead);
  end;
  DelStack;
end;

procedure UnLockRead;
begin
	AddStack('FPswdEd.UnLockRead');
  with PswdEd do begin
    Dec(nRead);
    if nRead=0 then UnlockMode('FREAD');
  end;
  DelStack;
end;

procedure PrivProc(const Priv: string; var result: boolean);
begin
  AddStack('FPswdEd.PrivProc');
  if Priv=sISDEVELOP then result:=true else IfThenPrivProc(PswdEd.oPrivProc,Priv,result);
  DelStack;
end;

{ TPswdEd }
procedure TPswdEd.FormCreate(Sender: TObject);
const acLogKeysOrd: array[TLogKeyList] of longint = (logkCp,logkNp);
var af: TArrFldVal;
  av: TDEPrmVar;
begin
	AddStack('TPswdEd.FormCreate',Self);
  FileIdentProg:={PROG_FILEID_ORGLIST}'ORGLIST'+'.'+PROG_FILEID_EXT;
  lCopLast:=true;
  UserCntEndReserv:=1; // Последний для OrgCng.TBot
  TIniFileData.Init;
  inherited;
  QryMsg.BeforeOpen:=QryMsgBeforeOpen;
  RecGlob:=RGlob; KeyPrmLocal:=K_Alt_6;
  lLogVid:=logvOLCnt;
  lLogKeys:=logkOLCnt; CopyFromInt(aLogKeysOrd,acLogKeysOrd);
  AddFrom(aModeFld,['FREAD','FDER','FBUH','FMDLOAD']);
  LsUpdNm.Add('UBUHLOAD');
  LsUpdNm.Add('UOFF');
  TKeyLb.SetFixKey(K_Ctrl_H,'О программе',KeyLb1ProcKey,kmHelp);
	TKeyLb.SetFixKey(K_Ctrl_J,'Последние изменения',KeyLb1ProcKey,kmHelp);
  Rec.GetAFieldValue(af);
  Rec.CreateFld('CngEvalIntervalMin',ftInteger,0,InitFIni[fiSave].ReadInteger('OrgWorkStat','CngEvalIntervalMin',10));
  Rec.CreateFld('FdpFormOnView',ftBoolean,0,InitFIni[fiSave].ReadBool('OrgWorkStat','FdpFormOnView',true));
  Rec.CreateFld('IPToHost',ftBoolean,0,InitFIni[fiSave].ReadBool('OrgWorkStat','IPToHost'));
  Rec.CreateFld('DIRHELP',ftMemo,0,'');
  Rec['DIRHELP']:=InitFIni[fiSave].ReadString('PswdEd','DirHelp');
  Rec.SetAFieldValue(af);
  SetPrmLocal;

  dePrm.GetArrParam('FORMLIMTIME',av);
  av[deCaption]:='Интервал копирования изменений (мин.)'+UnDelim+'(0-не копировать)';
  av[deNameRecFld]:='CngEvalIntervalMin';
  av[deMask]:='0,999';
  dePrm.CreateFld(av,'BRFINDALL');

  dePrm.GetArrParam('BRFINDALL',av);
  av[deNameRecFld]:='FdpFormOnView';
  av[deMask]:='При входе в документ запускать формирование';
  dePrm.CreateFld(av);

  av[deNameRecFld]:='IPToHost';
  av[deMask]:='Преобразовывать IP-адрес в HOST-имя';
  dePrm.CreateFld(av);

  av[deCaption]:='Папка с инструкциями';
  av[deNameRecFld]:='DIRHELP';
  SchemDM.DirGet1.AssignGet(av);
  av[deMask]:='';
  av[deWidth]:=wallDefault;
  dePrm.CreateFld(av);

  ProcIndex:=ExecFile;
  MsgSound:=true;
  MyTypes.LockLstCngFldProc:=LockLstCngFldProc;
  MyTypes.LogFltMaskFldProc:=LogFltMaskFldProc;
  Application.HookMainWindow(OffHookProc);
  PrivDesign:=sISDEVELOP; oPrivProc:=MyTypes.PrivProc; MyTypes.PrivProc:=PrivProc;
  DelStack;
end;

procedure TPswdEd.FormDestroy(Sender: TObject);
begin
	AddStack('TPswdEd.FormDestroy',Self);
  MyTypes.PrivProc:=oPrivProc;
  Application.UnHookMainWindow(OffHookProc);
  InitFIni[fiSave].WriteString('PswdEd','DIRHELP',Rec['DirHelp']);
  InitFIni[fiSave].WriteBool('OrgWorkStat','FdpFormOnView',Rec['FdpFormOnView']);
  InitFIni[fiSave].WriteBool('OrgWorkStat','IPToHost',Rec['IPToHost']);
  InitFIni[fiSave].WriteInteger('OrgWorkStat','CngEvalIntervalMin',Rec['CngEvalIntervalMin']);
  inherited;
  SetConnected(false);
  DelStack;
end;

function TPswdEd.CreateIndex;
begin
  AddStack('TPswdEd.CreateIndex',Self);
  if ExecFile(Sender) then result:=ExecFile(Sender,[exfCrt]) else result:=false;
  DelStack;
end;

function TPswdEd.LoadForms;
type TLogOLKeys = array[TLogKeyList] of TLogKeys;
const OrgBM: array[1..1] of string = ('DOMSG');
  acLogVid: array[logvOLCnt..-1] of TLogVid =
    ((v:logvCurTn    ;nm:'установка текущего пользователя')
    ,(v:logvExec     ;nm:'выполнение')
    ,(v:logvSetGGW   ;nm:'установка с учётом рег.номера')
    ,(v:logvCopy     ;nm:'копирование в другую папку')
    ,(v:logvMove     ;nm:'перенос в другую папку')
    ,(v:logvDel      ;nm:'удаление папки')
    ,(v:logvMoveZaj  ;nm:'перенос заявок на другую программу'; ltbl:true)
    ,(v:logvStruct   ;nm:'корректировка структуры')
    ,(v:logvPack     ;nm:'упаковка')
    ,(v:logvChk      ;nm:'проверка и исправление')
    ,(v:logvDelRegs  ;nm:'удаление регистрационной таблицы')
    ,(v:logvSendMsg  ;nm:'отправка сообщения по программе')
    ,(v:logvSendFile ;nm:'отправка файла')
    ,(v:logvCngExt   ;nm:'смена расширения базы данных')
    ,(v:logvProvData ;nm:'проверка данных')
    ,(v:logvBuhLoad  ;nm:'загрузка из "Бухгалтерии"')
    );
  acLogKeys: TLogOLKeys =
    ( // Добавлять не в конце, а в начале
    (cod:'NP'; nm:'программа(№ п/п)'; ms:'1'+UnDelim+'ProgNp'),
    (cod:'CP'; nm:'программа(рег.№)'; ms:'1'+UnDelim+'Prog'));
var i: longint;
  aLogKeys: TLogOLKeys;
label lend;
begin
  AddStack('TPswdEd.LoadForms',Self);
  result:=false;
  TMulQuery.AddTablesFreeHandle([tVAN,tLIST]);
  for i:=low(OrgBM) to high(OrgBM) do InitBM.AddBM('ORG_'+OrgBM[i]);
  if empty(My_pr.GetEnvironmentVariable('GG')) then begin
    MsgDlg(['Необходимо установить значение системной переменной','GG=1']);
    goto lend;
  end;
  CreateForm(TDM,DM);
  DMAfterCreate;
  if Sender.SayCapt(['Загрузка главного меню']) then goto lend;
  CreateForm(TMain,Main);
  aLogKeys:=acLogKeys;
  aLogKeys[logkCp].g:=TProgSelGet.Create(Self); aLogKeys[logkNp].g:=aLogKeys[logkCp].g;
  LogInit(acLogVid,aLogKeys,low(aLogKeys));
  if tmCng.Interval>0 then tmCngTimer(tmCng); //tmCng.Enabled:=true;
  result:=true;
lend:
  DelStack;
end;

procedure TPswdEd.ExecProg;
begin
	AddStack('TPswdEd.ExecProg',Self);
  TMsOffInit.Create(Self); Main.ShowModal;
  DelStack;
end;

procedure TPswdEd.KeyLb1ProcKey(key: Integer; tw: TWinControl);
begin
	AddStack('TPswdEd.KeyLb1ProcKey');
  case Key of
    // О программе
    K_Ctrl_H: begin
      TKeyLb.FixKeyShow(Key,false);
      DefEditInfo('О программе','AboutProg',
        ['Название'       ,'Версия'           ,'Номер сборки','Разработчики'                ,''],
        ['"Учёт клиентов"',GetExeInfo.MainVers,StrExeVersion ,'Гуляев Г.Ю., Островский Б.Л.','Сыктывкар 2023г.']);
      TKeyLb.FixKeyShow(Key,true);
    end;
    // Последние изменения
		K_Ctrl_J: THelpLs.Execute('OrgLastCng');
  else inherited;
	end;
  DelStack;
end;

function TPswdEd.GetPswdInit;
begin
	AddStack('TPswdEd.GetPswdInit',Self);
  result:=inherited GetPswdInit;
  if result='' then result:='ks,rmtnpoJ';//'su'+IntToStr(Day(Date));
  DelStack;
end;

function TPswdEd.CalcMode;
var f: TField;
  i: longint;
begin
	AddStack('TPswdEd.CalcMode',Self);
	result := inherited CalcMode(DataSet);
  with DataSet do begin
    if not empty(FieldZN('FREAD')) then DlmBetwSelf(result,'просмотр данных',',');
    if not empty(FieldZN('FDER')) then DlmBetwSelf(result,'сохранение протоколов',',');
    if FindField('FBUH',f) then case f.AsInteger of
      1: DlmBetwSelf(result,'поиск в "Бухгалтерии"',',');
      2: DlmBetwSelf(result,'загрузка из "Бухгалтерии"',',');
    end;
    if FindField('FMDLOAD',f) then begin
      i:=f.AsInteger;
      if i>0 then DlmBetwSelf(result,Format('загрузка основ (изм.%d)',[i]),',');
    end;
  end;
  DelStack;
end;

function TPswdEd.PrmLocal;
begin
	AddStack('TPswdEd.PrmLocal',Self);
  result:=inherited PrmLocal(['Бухгалтерия'],[stpSection+'.BUH'],Capt,lRestart);
  DelStack;
end;

function TPswdEd.dePrmPnlValid(Sender: TObject): Boolean;
begin
	AddStack('TPswdEd.dePrmPnlValid',Self);
  result:=inherited dePrmPnlValid(Sender);
  if result then SetPrmLocal;
  DelStack;
end;

procedure TPswdEd.SetPrmLocal;
begin
  AddStack('TPswdEd.SetPrmLocal',Self);
 	FdpFormOnView:=Rec['FdpFormOnView'];
  tmCng.Interval:=Rec['CngEvalIntervalMin']*MSecsPerMin;
  DelStack;
end;

class procedure TPswdEd.QryMsgBeforeOpen;
begin
	AddStack('TPswdEd.QryMsgBeforeOpen');
  inherited;
  if Assigned(Main) then Main.IsMsgCdr;
  DelStack;
end;

class function TPswdEd.CdrGetFormIBList;
begin
	AddStack('TPswdEd.CdrGetFormIBList');
  if LockRead then begin
    CreateForm(TCdrLs,CdrLs); result:=CdrLs;
  end
  else result:=nil;
  DelStack;
end;

class procedure TPswdEd.CdrGetAfterList;
begin
  AddStack('TPswdEd.CdrGetAfterList');
  UnLockRead;
  DelStack;
end;

class function TPswdEd.CdrGetStrName;
var fn,fp: TField;
begin
  AddStack('TPswdEd.CdrGetStrName');
  fn:=Qry.FindField(fNAME); fp:=Qry.FindField('PRIM');
  result:=Padr(DlmBetween(fn.AsString,fp.AsString,' '),fn.Size+1+fp.Size);
  DelStack;
end;

procedure TPswdEd.LockLstCngFldProc;
begin
  AddStack('TPswdEd.LockLstCngFldProc',Self);
  if ProgPswd=Self then
    if IsField(tREGS,fCDR) then with LockLst,BrQuery1 do
      if lBefore then AddArgList(sC_LIST,fCDR)
      else begin
        BrQuery1NAME.Visible:=false;
        CreateField(fCDR);
        BrQuery1NAME:=CreateStringField('CTN','Пользователь',30); BrQuery1NAME.Index:=0;
        oLockLstCalcFields:=OnCalcFields; OnCalcFields:=LockLstBrQuery1CalcFields;
      end;
  DelStack;
end;

procedure TPswdEd.LockLstBrQuery1CalcFields;
begin
	AddStack('TPswdEd.LockLstBrQuery1CalcFields',Self);
  IfThenDataSet(oLockLstCalcFields,DataSet);
  with MulQueryOwner(DataSet) do
    FindField('CTN').AsString:=CdrGet.CodeName(FindField(fCDR).AsString,[cdgBufAll]);
  DelStack;
end;

procedure TPswdEd.LogFltMaskFldProc;
var a: TArrStr;
  acn: TArrNamePrimStr;
  i: longint;
begin
  AddStack('TPswdEd.LogFltMaskFldProc',Self);
  if NmFld=fUSERNAME then begin
    i:=LsArrDynamic(StrTran(Mask,cMnNoNum,'',[rfIgnoreCase]),a,mniDlm); SetLength(acn,i);
    for i:=0 to i-1 do begin
      ListAsArray(a[i],acn[i],UnDelim); acn[i,2]:=Trim(CdrGet.CodeName(acn[i,1])); 
    end;
    Mask:=MenuACN2Mask(acn,[mngCod,mngName]);
  end;
  DelStack;
end;

procedure TPswdEd.GetUpd;
var tw,twp: TWinControl;
	ts: TTabSheet;
	cds: TCopyDataStruct;
begin
	AddStack('TPswdEd.GetUpd',Self);
  if nmMsg='UBUHLOAD' then begin
    if not UbuhLoadLocking then begin
      Timer1.Enabled:=false;
      UbuhLoadLocking:=true;
      if LockBuhRead then
        try
          ListKodLoad; Van.Seek(Van.TblFldName('VIDNO')+'='+QQs(GlobVIDNO));
        finally
          UnlockMode('FBUH');
        end
      else Application.Terminate;
      UbuhLoadLocking:=false; DM.ListGet.ClearBuf; List.InitFldDef(dwdefRestVal);
      if Assigned(Main) then with Main do begin
        tw:=ActiveControl; DefOrgDat; ChildFldReadAll(pnOrgDat); twp:=tw.Parent;
        while Assigned(twp) do begin
          if IsClass(twp,TTabSheet,pointer(ts)) then TRbPage(ts.PageControl).SetActivePage(ts);
          ParentSelf(twp);
        end;
        ActiveControl:=tw;
      end;
      Timer1.Enabled:=true;
    end;
  end
  else if nmMsg='UOFF'then begin
    if not UOffEsc then if Cdr['STATUS']<>cstRemote then begin
      SetStatusNone(RecnoWhere(Cdr.RecNo));
      Timer1.Enabled:=false; MelodyOn(aSndSmith); UOffMsg:=true;
      mess_wait(acMsgOff,PrOff,[Now,EncodeTime(0,1,0,0)],true,'',taCenter,TimerOff);
      UOffMsg:=false;
      if not Application.Terminated then begin
        ZeroMemory(@cds,SizeOf(cds)); cds.dwData:=idOffEsc; CopyDataAllWnd(Application.Handle,cds);
      end;
      MelodyOff; Timer1.Enabled:=true;
    end;
  end
  else inherited GetUpd(nmMsg);
  DelStack;
end;

function TPswdEd.MsgGetUpd;
begin
  AddStack('TPswdEd.MsgGetUpd',Self);
  result:=inherited MsgGetUpd;
  if result then with GRegistry do begin
    RootKey:=HKEY_CURRENT_USER;
    if OpenKeyReadOnly(REGSTR_PATH_EXPLORER) then
      if ValueExists('PINF')
      then mess_ok(['Внимание !','На компьютере возможено наличие вируса Win32.Parite.']);
    CloseKey;
  end;
  DelStack;
end;

procedure TPswdEd.DateRegSet;
begin
  AddStack('TPswdEd.DateRegSet',Self);
  // Синхронизация времени с центральным компьютером
  if not SetLocalTime(DateReg) then begin
    mess_ok(['Ошибка синхронизации времени с центральным компьютером.',
      'Возможно, программа запущена пользователем,','не являющимся администратором.']);
    Application.Terminate;
  end;
  DelStack;
end;

class procedure TPswdEd.PrOff;
begin
end;

function TPswdEd.OffHookProc;
var msg: TWMCopyData;
begin
  AddStack('TPswdEd.OffHookProc',Self);
  result:=false;
  if Message.Msg=WM_COPYDATA then begin
    msg:=TWMCopyData(Message);
    if msg.CopyDataStruct.dwData=idOffEsc then begin
      UOffEsc:=true;
      if UOffMsg then TAsk(LastForm).Abort;
    end;
  end;
  DelStack;
end;

class procedure TPswdEd.TimerOff;
var f: TAsk;
  ost: TDateTime;
  Hour,Min,Sec,MSec: Word;
begin
  AddStack('TPswdEd.TimerOff');
  with TTimer(Sender) do begin
  	Enabled:=false; Interval:=MSecsPerSec; f:=pointer(LastForm); ost:=Now-f.Params[0];
    if ost<f.Params[1] then begin
      DecodeTime(f.Params[1]-ost,Hour,Min,Sec,MSec);
      aMsgOff[5]:=Format('До выключения компьютера осталось %d секунд.',[Sec]);
      f.ClearCurTime;
      if not f.SayCapt(aMsgOff) then Enabled:=true;
    end
    else begin
   	  MelodyOff; Application.Terminate;
    	ReBoot(EWX_FORCE+IfThen(Win32Platform=VER_PLATFORM_WIN32_NT,EWX_POWEROFF,EWX_SHUTDOWN));
    end;
  end;
  DelStack;
end;

procedure TPswdEd.tmCngTimer(Sender: TObject);
var d,od: longint;
	kc,Ident,mem_f,copydir,dircopy: string;
  fl: boolean;
begin
	AddStack('TPswdEd.tmCngTimer',Self);
  tmCng.Enabled:=false;
  qCng.Open;
  while not qCng.Eof do begin
    kc:=TrimRight(qCng.Fields[0].AsString);
    Ident:='DT'+Trim(kc);
    od:=InitFIni[fiSave].ReadInteger('Changes',Ident);
    d:=qCng.Fields[1].AsInteger;
    fl := {(od > 0) and }(d > od);
    mem_f:=''; copydir:=qCng.Fields[3].AsString; dircopy:=qCng.Fields[4].AsString;
    while not qCng.Eof and (TrimRight(qCng.Fields[0].AsString)=kc) do begin
      if fl then IncD(mem_f,TrimRight(qCng.Fields[2].AsString));
      qCng.Next;
    end;
    if fl then
      if CngCopyDir(StrDeshifr(mem_f),copydir,dircopy) {or (od=0) and (d>0)}
      then InitFIni[fiSave].WriteInteger('Changes',Ident,d);
  end;
  qCng.Close;
  tmCng.Enabled:=true;
  DelStack;
end;

function TPswdEd.PnPswValid(Sender: TObject): Boolean;
begin
  AddStack('TPswdEd.PnPswValid',Self);
  if Assigned(PswdPrm.DBMain) then begin
    SetConnected(false); FreeAndNil(PswdPrm.DBMain);
    SetConnected(DBBuh,false); FreeAndNil(FDBBuh);
    FreeAndNil(CdrGet); FreeAndNil(FVanGet); FreeAndNil(qCng);
  end;
  PswdPrm.DBMain:=CreateDatabase('REG','ORG',false);
  CdrGet:=TCodeGet.Create(Self);
  with CdrGet do begin
  	Connection:=DBMain;
    VName:='Cdr';
    RVid:='Пользователь';
    FieldsCode:=fCDR; FieldsName:=fUPNAME;
    with MulPar do begin
    	Values[sCod_C]:=QQs('%'); Values[sTABLE]:=tCDR; Values[sC_LIST]:='*';
      Values[sWHERE]:=fCDR+qCod_C;
    end;
    Part:=sSELECT_WORDER; OnFormIBList:=CdrGetFormIBList; OnAfterList:=CdrGetAfterList; OnStrName:=CdrGetStrName;
  end;
  qCng:=Tmulquery.CreateConnection(Self);
  qCng.PartSelect(GetList([tCNGV,tMEMO]),[fCNGV,'DT','ZN','COPYDIR','DIRCOPY'],
    tCNGV+'.'+sMemo+'F='+tMEMO+'.'+fMGK+sAND+'TPVIEW<>'+Vtos(tpvModel)+sAND+'COPYDIR<>'+QQs,GetList([fCNGV,fMNPP]),'',false);
  result:=inherited PnPswValid(Sender);
  DelStack;
end;

procedure Init;
var i: TMsgOffList;
begin
  AddStack('FPswdEd.Init');
  OLTypes.LockRead:=LockRead; OLTypes.UnLockRead:=UnLockRead;
  for i:=low(aMsgOff) to high(aMsgOff) do aMsgOff[i]:=acMsgOff[i];
  DelStack;
end;

function TPswdEd.RegModify;
	procedure MdfTable(const asv: array of string);
	var k: longint;
  begin
  	AddStack('TPswdEd.RegModify.MdfTable',Self);
		for k:=Low(asv) to High(asv) do
	    if Vers<asv[k] then ModifyTable(true,asv[k]);
    DelStack;
  end;
begin
	AddStack('TPswdEd.RegModify',Self);
  result:=true;
  case fl of
    mdfExec: begin
      result:=inherited RegModify(Sender,Vers,LastVers,fl);
      if LastVers='1.05 ' then MdfTable(['1.05a','1.05b','1.05c']);
      if LastVers='1.07 ' then begin
        ExecFile(Sender,[],[iftReg]);
        MdfTable(['1.07a','1.07b','1.07c']);
      end;
      if LastVers='1.08 ' then begin
        MdfTable(['1.08a','1.08b','1.08c','1.08d','1.08e','1.08f','1.08g','1.08h','1.08i','1.08j','1.08k']);
      end;
    end;
  end;
  DelStack;
end;

procedure Upd_1_19(Sender: TStat; const Params: array of variant; var Aborted: boolean);
var q: TMulQuery;
	i,j,n,lr: longint;
begin
  AddStack('FPswdEd.Upd_1_19');
  with ProgPswd do begin
    q:=GetQuery;
    with GetQuery do begin
      PartSelect('PROG',['KO','NP'],'','KO'); i:=0; j:=0; lr:=RecordCount;
      for n:=1 to lr do begin
        Sender.SayStat(n/lr); 
        if Fields[0].AsInteger > i then begin
          i:=Fields[0].AsInteger; j:=0;
        end;
        Inc(j); q.UpdateTable('PROG',['CP'],[QQi(j,2)],'NP='+Vtos(Fields[1]));
        q.Arg[sTABLE]:='ZAJ'; q.AddArgList(sC_LIST,'KO'); q.AddArgList(sV_LIST,i);
        q.ExecPart(sUW_TABLE); Next;
      end;
    end;
    FreeQuery; FreeQuery;
  end;
  DelStack;
end;

procedure Upd_1_21(Sender: TStat; const Params: array of variant; var Aborted: boolean);
var q: TMulQuery;
	procedure UpdTbl(const vid,tbl: string; const clist: array of variant);
  var i,j,lr: longint;
  	afn,av: TArrVar;
    af: TArrField;
    fqRECNO: TField;
  begin
    AddStack('FPswdEd.Upd_1_21.UpdTbl');
    if not Aborted then
    	if not Sender.SayStat('Обновление до версии 1.21 ('+vid+')') then	with ProgPswd.CurQuery do begin
      	lr:=Length(clist); SetLength(af,lr); SetLength(av,lr);
      	CopyFromVArr(afn,clist); AddFromVArr(afn,['RECNO']);
        PartSelect(tbl,afn,'',afn[0]); SetLength(afn,lr);
        lr:=RecordCount; fqRECNO:=FindField('RECNO');
        for j:=low(af) to high(af) do begin
        	af[j]:=FindField(clist[j]); IncL(afn[j],'T');
        end;
        for i:=1 to lr do begin
        	if Sender.SayStat('','Дата: '+FormatDateTime('dd/mm/yy (hh:nn)',Fields[0].AsDateTime),i/lr) then break;
	        for j:=low(af) to high(af) do av[j]:=QQs(DateToString(af[j].AsDateTime));
          q.UpdateTable(tbl,afn,av,'RECNO='+Vtos(fqRECNO)); Next;
        end;
      end;
    DelStack;
  end;
begin
	AddStack('FPswdEd.Upd_1_21');
  with ProgPswd do begin
    q:=GetQuery; GetQuery;
    UpdTbl('сообщения','MSG',['D']);
    UpdTbl('заявки','ZAJ',['DISPD','D','ISPD','ISPD1','WD','WD1']);
    q.UpdateTable('MSG',['TD1'],['TD']); FreeQuery; FreeQuery;
  end;
  DelStack;
end;

function TPswdEd.DBMainModify;
type TOper = (opInd,opIndMod,opNone);
  function ModTbl(const ver: string; op: TOper = opIndMod): boolean;
  begin
    AddStack('TPswdEd.DBMainModify.ModTbl',Self);
    result := not Sender.Aborted and (Vers<ver);
    if result and (op<>opNone) then begin
      if ExecFile(Sender,[],[iftMain]) then if op=opIndMod then ModifyTable(false,ver);
      result:=not Sender.Aborted;
    end;
    DelStack;
  end;
  procedure ModTblRange(vfrom,vto: Double);
  	function sVers(v: Double): string;
    begin
	    AddStack('TPswdEd.DBMainModify.ModTblRange.sVers',Self);
      result:=StrTran(SpaceStr(v,4,2),DecimalSeparator,'.')+' ';
      DelStack;
    end;
  begin
    AddStack('TPswdEd.DBMainModify.ModTblRange',Self);
    while sVers(vfrom) <= sVers(vto) do begin
    	ModTbl(sVers(vfrom)); IncD(vfrom,0.01);
    end;
    DelStack;
  end;
  procedure ModDISPD(const ver: string; op: TOper = opIndMod);
  begin
    AddStack('TPswdEd.DBMainModify.ModDISPD',Self);
    if ModTbl(ver,op) then with GetQuery do begin
      UpdateTable('ZAJ',['DISPD'],[null]);
      UpdateTable('',['DISPD'],['D'],'ISPD'+sISNULL+sOR+BracketNot('D'+sISNULL));
      UpdateTable('',['DISPD'],['ISPD'],BracketNot('ISPD'+sISNULL)+sAND+'D'+sISNULL);
      FreeQuery;
    end;
    DelStack;
  end;
var ar: TArrRecDB;
	function rSet(const nmdb: string): TRecDB;
  begin
  	AddStack('TPswdEd.DBMainModify.rSet',Self);
    result:=TRecDB.Create(Self); AddFromRecDB(ar,result);
    with result do begin
	  	NameDB:=nmdb; NameRec:=NameDB; OpenRec;
    end;
    DelStack;
  end;
var i,j,l: longint;
	r: TRecDB;
  s,s1: string;
  q,q1: TMulQuery;
  ls: TStringList;
  lsi: TIntegerList;
  a: TDEPrmStr;
  a1: TArrStr;
  ai: TArrInt;
  fls: boolean;
  aTel: array of record
    id: string;
    lOff: boolean;
  end;
  f: TFileBuf;
begin
	AddStack('TPswdEd.DBMainModify',Self);
  OldVers:=Vers;
	if fl = mdfExec then begin
    ar:=nil;
    try
      ModTbl('1.00 ');
      if ModTbl('1.01 ') then SetInfo;
      ModTbl('1.02 ');
      if ModTbl('1.03 ',opNone) then with GetQuery do begin
        Arg[sTABLE]:='PROG'; Arg[sC_LIST]:='KP';
        for i:=low(ProgInfs) to high(ProgInfs) do begin
        	Arg[sV_LIST]:=QQi(i,2);
          Arg[sWHERE]:='KP='+QQi(i);
          ExecPart(sUW_TABLE);
        end;
        FreeQuery;
        with rSet('ORG') do begin
        	NewRec; AppRec;
        end;
      end;
      if ModTbl('1.04 ') then with GetQuery do begin
      	PartSelect('CDR',[]); r:=rSet('CDR');
        s:=SetByte([1,2,3,4]); s1:=s; SetByte(s1,5,true);
        while not Eof do begin
        	r.GetFromQuery; r['MEM_ORDORG']:=s; r['MEM_ORDFLT']:=s1; r.UpdateRec; Next;
        end;
        FreeQuery;
      end;
      if ModTbl('1.05 ') then UpdateTable('PROG',['NP'],['RECNO'],QQNull('NP',0));
      ModTblRange(1.06,1.11);
      if ModTbl('1.12 ') then UpdateTable('PROG',['STATUS'],[stpMain],'STATUS'+sISNULL);
      ModDISPD('1.13 '); ModTbl('1.14 ');
      if ModTbl('1.15 ') then UpdateTable('CDR',['ZAJISPN'],[2],FldIsTrue('ZAJISP',false));
      ModTbl('1.15a');
      ModTblRange(1.16,1.17);
      ModDISPD('1.18 ',opNone);
      if ModTbl('1.19 ') then begin
      	ShowStat('Обновление до версии 1.19',Upd_1_19,false);
        Van:=rSet('VAN'); Org:=rSet('ORG'); Glob:=rSet('GLOB');
        if not TMain.PrBuhLoad(nil) then Sender.Abort;
      end;
      ModTbl('1.19a'); ModTbl('1.20 ');
      if ModTbl('1.21 ') then ShowStat('',Upd_1_21,false);
      ModTbl('1.21a'); ModTbl('1.22 ');
      if ModTbl('1.23 ') then with GetQuery do begin
      	DeleteTable('OFIS'); UpdateTable('CDR',['STATUS'],[cstNone]); FreeQuery;
      end;
      if ModTbl('1.25 ') then with GetQuery do begin
        s:=CdrOrdZajDef(37,[27],[1,10,2,3,4,5,6,7,8,9]); r:=rSet('CDR'); PartSelect('CDR',[]);
        while not Eof do begin
        	r.GetFromQuery; r['MEM_ORDZAJ']:=s; r.UpdateRec; Next;
        end;
      	FreeQuery;
      end;
      ModTblRange(1.26,1.28);
      if ModTbl('1.29 ',opNone) then InitFIni[fiSave].EraseSection('Changes');
      ModTbl('1.30 ');
      if ModTbl('1.31 ') then begin
        q:=GetQuery; q1:=GetQuery;
        with GetQuery do begin
          PartSelect('PROG',['CP'],'','CP','CP');
          while not Eof do begin
            s:=Fields[0].AsString; s1:='CP='+QQs(s); QQiSelf(s,3);
            q.UpdateTable('PROG',['CP'],[s],s1); q.UpdateTable('ZAJ',['CP'],[s],s1);
            Next;
          end;
          UpdateTable('PROG',['NP'],['CP']);
          ls:=SortStrListCreate;
          try
            ListKodLoad; s:=GetList(['KO','CP']);
            PartSelect('PROG',['KO','CP','STATUS','TN','RECNO'],'STATUS='+Vtos(stpTemp),s);
            q.PartSelect('ZAJ',['KO','CP'],'',s,s);
            while not Eof do begin
              s1:=Spacestr(Fields[0].AsInteger,10)+Fields[1].AsString;
              while not q.Eof and (Spacestr(q.Fields[0].AsInteger,10)+q.Fields[1].AsString<s1) do q.Next;
              if not q.Eof and (Spacestr(q.Fields[0].AsInteger,10)+q.Fields[1].AsString=s1) then begin
                ls.Add(Fields[3].AsString+','+ListKod(Fields[0].AsInteger)+','+Fields[1].AsString);
                q1.UpdateTable('PROG',['STATUS'],[stpMain],'RECNO='+Vtos(Fields[4]));
              end;
              Next;
            end;
            ls.SaveToFile(ExeDir+'ZAJ.DER');
          finally
            ls.Free;
          end;
          UpdateTable('PROG',['CP'],[QQs],'STATUS='+Vtos(stpTemp));
        end;
        FreeQuery; FreeQuery; FreeQuery;
      end;
      if ModTbl('1.32 ') then begin
        r:=rSet('RGN');
        with rSet('GLOB') do begin
          GotoRec(1); ls:=TStringList.Create;
          with TDataWin.Create do
            try
              LoadFromStr(Value['MEM_PROGW']); ls.Text:=Fields; l:=Length(r['KR']);
              for i:=0 to ls.Count-1 do begin
                a:=DEGetArrParam(ls[i]);
                if a[deNameRecFld]='РАЙОН' then begin
                  for j:=0 to LsArrDynamic(a[deMask],a1,mniDlm)-1 do begin
                    r.NewRec; r['KR']:=SpaceStr(j+1,l); r['NAME']:=a1[j];
                    r['UPNAME']:=AnsiUpperCase(a1[j]); r.AppRec;
                  end;
                  ls.Delete(i); Fields:=ls.Text; Value['MEM_PROGW']:=SaveToStr; break;
                end;
              end;
              ls.Text:=Value['MEM_PROGD'];
              for i:=0 to ls.Count-1 do
                if Trim(DWSToRec(ls[i]).Name)='РАЙОН' then begin
                  ls.Delete(i); Value['MEM_PROGD']:=ls.Text; break;
                end;
            finally
              Free; ls.Free;
            end;
          UpdateRec;
        end;
        UpdateTable('PROG',['KR'],['FIX_N0']);
      end;
      if ModTbl('1.33 ',opNone) then UpdateTable('PROG',['KR'],[1],'KR='+VToS);
      if ModTbl('1.34 ') then begin
        q:=GetQuery; q1:=GetQuery; q.PartSelect('DRV',['KD'],'','KD'); i:=1;
        while not q.Eof do begin
          q1.UpdateTable('DRV',['ND'],[QQi(i,3)],'KD='+QQs(q.Fields[0]));
          q1.Arg[sTABLE]:='PROG'; q1.ExecPart(q1.Part); q.Next; Inc(i);
        end;
        FreeQuery; FreeQuery;
      end;
      ModTbl('1.34a');
      ModTblRange(1.35,1.40);
      if (ModTbl('1.41 ')) then begin
        q:=GetQuery;
        try
          q.UpdateTable('ZAJ',['TWDSORT'],['TWD']);
          q.UpdateTable('ZAJ',['TWDSORT'],[QQs(GetMaxStrDate)],QQNull('TWDSORT',''));
        finally
          FreeQuery;
        end;
      end;
      ModTblRange(1.42{213},1.54{276});
      if ModTbl('1.55 '{278},opNone) then begin
        with GetQuery do UpdateTable('ZAJ',['DACT'],[null],'DACT='+VarToS(DateBig));
        FreeQuery;
      end;
      ModTbl('1.56 '{283});
      if ModTbl('1.57 '{284},opNone) then with GetQuery do begin
        DropTable('DBSTRNZ'); DropTable('PRNSP'); FreeQuery;
      end;
      ModTblRange(1.58{285},1.59{296});
      if ModTbl('1.60 '{298},opNone) then UpdateTable('MSG',['SEL'],[false],'SEL='+QQs);
      ModTblRange(1.61{299},1.62{301});
      if ModTbl('1.63 '{306}) then begin
        q:=GetQuery;
        with GetQuery do begin
          PartSelect('FLT',['RECNO'],'','NAME'); i:=0;
          while not Eof do begin
            q.UpdateTable('FLT',['NPP'],[i],'RECNO='+Vtos(Fields[0])); Inc(i); Next;
          end;
        end;
        FreeQuery; FreeQuery;
      end;
      ModTblRange(1.64{316,1.65{319 см. FMain,1.66{321,1.67{325,1.68{327},1.69{328});
      if ModTbl('1.70 '{329}) then GetQuery.UpdateTable('ZAJ',['TSELISPE'],[QQs],'TSELISPE'+sISNULL);
      ModTblRange(1.71{344},1.72{349});
      ModTbl('1.74 '{360},opInd);
      ModTblRange(1.75{381,1.76{383,1.77{385,1.78{392,1.79{403,1.80{418,1.81{430,1.82{431,1.83{432,1.84{433,1.85{441,1.86{442,1.87{453,1.88{454},1.89{456});
      if ModTbl('1.90 '{459},opNone) then with GetQuery do begin
        PartSelect('GLOB','TELPATH'); s:=CorrDir(Fields[0].AsString);
        if s<>'' then begin
          lsi:=TIntegerList.Create;
          try
            s1:=GetStrFile(s+'CDR.ID',MaxInt,@fls);
            if fls then begin
              ls:=TStringList.Create;
              try
                ls.Text:=s1; i:=ls.Count; lsi.Capacity:=i; SetLength(aTel,1+i);
                Finalize(aTel[0]); ZeroMemory(@aTel[0],SizeOf(aTel[0]));
                for i:=0 to i-1 do with aTel[1+i] do begin
                  id:=ls.ValueFromIndex[i]; lOff := id[1]='*';
                  if lOff then System.Delete(id,1,1);
                  lsi.Add(ls.Names[i],1+i);
                end;
              finally
                ls.Free;
              end;
            end;
            lsi.SetOption(ilsSorted,true);
            PartSelect('CDR',['TN','NAME'],'','TN'); f:=TFileBuf.Create(s+TelFilePrm,true);
            try
              while not Eof do begin
                s1:=Trim(Fields[0].AsString);
                if lsi.Find(Int0(s1),i) then lsi.IntObjSelf(i) else i:=0;
                with aTel[i] do f.WriteString(s1+'='+Trim(Fields[1].AsString)+','+id+','+bStr[lOff],[wrCrlf]);
                Next;
              end;
            finally
              f.Free;
            end;
            DelFileAtr(s+'CDR.ID');
          finally
            lsi.Free;
          end;
        end;
        FreeQuery;
      end;
      if ModTbl('1.91 '{460}) then with GetQuery do begin
        PartSelect('GLOB','TELPATH'); s:=CorrDir(Fields[0].AsString);
        if s<>'' then begin
          IncD(s,'отправленные'); s1:=GetStrFile(s,MaxInt,@fls);
          if fls then begin
            ls:=TStringList.Create;
            try
              ls.Text:=s1; i:=ls.Count;
              if i>0 then begin
                SetLength(a1,i);
                for i:=0 to i-1 do a1[i]:=ls.ValueFromIndex[i];
                PartSelect('MSG','RECNO',FldInList('RECNO',a1,NegDef,[flsUnique])+sAND+'SEL='+Vtos(false),'RECNO');
                SaveTo(ai); i:=0; fls:=false;
                while i<ls.Count do
                  if QuickFind(Int0(ls.ValueFromIndex[i]),ai) then Inc(i)
                  else begin
                    ls.Delete(i); fls:=true;
                  end;
                if fls then ls.SaveToFile(s);
              end;
            finally
              ls.Free;
            end;
          end;
        end;
        FreeQuery;
      end;
    finally
      for i:=low(ar) to high(ar) do ar[i].Free;
    end;
  end;
  result:=not Sender.Aborted;
  DelStack;
end;

// !!! Область только для для процедур перехода на след.версию данных !!!
initialization
	Init;
end.
