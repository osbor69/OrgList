unit FProgEd;

interface

{$I ORGTEST}
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, Menus, ExtCtrls, StdCtrls, StrUtils, Math, DB,
  MyTypes, My_pr, FRMEDT, KeyMenu, PnlEdit, Keylb, Fpanel, FFldedit, FDWPrm, RecVal, DefEdit,
  OLTypes, OLProc;

type
  TProgEd = class(TFormEdt)
    pnProg: TRbPanel;
    pnOsn: TRbPanel;
    EProg: TFldEdit;
    ETn: TFldEdit;
    EKd: TFldEdit;
    EDir: TFldEdit;
    pnDat: TRbPanel;
    pnTxtZajIsp: TRbPanel;
    ENp: TFldEdit;
    pnKo: TRbPanel;
    EKo: TFldEdit;
    ECp: TFldEdit;
    ERgn: TFldEdit;
    ETerr: TFldEdit;
    EAcc: TFldEdit;
    EKolvo: TFldEdit;
    EMsgPattern: TFldEdit;
    EFbVers: TFldEdit;
    RvProgEd: TRecVal;
    pnStatus: TRbPanel;
    EStatus: TFldEdit;
    ECpa: TFldEdit;
    pnTxt: TRbPanel;
    ETxt: TFldEdit;
    pnZajIsp: TRbPanel;
    pnZaj: TRbPanel;
    EZTn: TFldEdit;
    pnZaj1: TRbPanel;
    ENz: TFldEdit;
    EDate: TFldEdit;
    ETime: TFldEdit;
    EDAct: TFldEdit;
    pnWIsp: TRbPanel;
    pnWd: TRbPanel;
    EWd: TFldEdit;
    EWt1: TFldEdit;
    EWt2: TFldEdit;
    EWtn: TFldEdit;
    pnWtn: TRbPanel;
    EDWtn: TFldEdit;
    ETWtn: TFldEdit;
    pnSelIsp: TRbPanel;
    EDSelIsp: TFldEdit;
    ETSelIsp: TFldEdit;
    ESelIspSh: TFldEdit;
    ESelIsp: TFldEdit;
    pnSelIsp1: TRbPanel;
    ECntIsp: TFldEdit;
    ESelIspEndD: TFldEdit;
    ESelIspEndT: TFldEdit;
    EMov: TFldEdit;
    pnIsp: TRbPanel;
    EIspv: TFldEdit;
    EIsptn: TFldEdit;
    pnIspd: TRbPanel;
    EIspd: TFldEdit;
    EIspt1: TFldEdit;
    EIspt2: TFldEdit;
    EProgWnd: TFldEdit;
    pnBall: TRbPanel;
    ELSet: TFldEdit;
    EBall0: TFldEdit;
    EBall1: TFldEdit;
    EBall2: TFldEdit;
    ERevalue: TFldEdit;
    procedure FormCreate(Sender: TObject);
    procedure EKdChange(Sender: TObject; const OldVal: Variant; FromShow: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    function PanelEdit1Valid(Sender: TObject): Boolean;
    procedure PanelEdit1Escape(Sender: TObject; var Action: TCloseAction);
    function PanelEdit1AskCancel(Sender: TObject): Boolean;
    function EDirCheck(Sender: TObject): Boolean;
    function EZTnCheck(Sender: TObject): Boolean;
    procedure EKoChange(Sender: TObject; const OldVal: Variant; FromShow: Boolean);
    procedure ENpExit(Sender: TObject);
    function ENpCheck(Sender: TObject): Boolean;
    function EWtnCheck(Sender: TObject): Boolean;
    function EIsptnCheck(Sender: TObject): Boolean;
    procedure EProgChange(Sender: TObject; const OldVal: Variant; FromShow: Boolean);
    procedure ELSetChange(Sender: TObject; const OldVal: Variant;
      FromShow: Boolean);
    procedure EStatusChange(Sender: TObject; const OldVal: Variant;
      FromShow: Boolean);
    function EIspdCheck(Sender: TObject): Boolean;
    procedure PanelEdit1AfterEscape(Sender: TObject);
  private
    aProgFix: array[TOrdFixList] of record
      Fld: TFldEdit;
      oEnter,oExit: TNotifyEvent;
      oChange: TFEChangeEvent;
      oCheck: TProcValid;
    end;
    zajmov: string;
    function ProgFixSeek(Sender: TObject): TOrdFixList;
    procedure ProgFixShow(Sender: TObject);
    procedure ProgFixEnter(Sender: TObject);
    procedure ProgFixExit(Sender: TObject);
    procedure ProgFixChange(Sender: TObject; const OldVal: variant; FromShow: boolean);
    function ProgFixCheck(Sender: TObject): boolean;
    procedure dwRedefParam(Sender: TObject; var av: TArrVar);
    function IsProgRo: boolean;
    class function ESelIspShCheck(Sender: TObject): Boolean;
    procedure ZajBeforeEd;
    procedure SetZajMov;
		procedure ProcKey(Key: longint; tw: TWinControl);
    procedure WMFormLimit(var Message: TMessage); message WM_FORMLIMIT;
  public
    dw: TDWWin;
  end;

var
  ProgEd,ZajEd: TProgEd;

implementation
{$R *.dfm}

uses
  MulQry,DateGet,SpGet,Shifr,FrmPswd,Inter,FldMask,FSchemDM,RecDB,FEdText,
  FDM,OLGets;

procedure PrSetPnlState(Sender: TFldEdit; const av: array of variant);
var st: TZajEditOpt;
begin
	AddStack('FProgEd.PrSetPnlState');
  with Sender do begin
  	st:=TZajEditOpt(byte(av[0])); Visible := zpsVisible in st;
    if Visible and (Sender<>ZajEd.ENz) and (Sender<>ZajEd.EMov)
    and (Sender.Parent<>ZajEd.pnSelIsp) and (Sender.Parent<>ZajEd.pnWtn)
      then SetReadOnly(not(zpsEnabled in st) or not StrToBoolean(Cdr['ADMZAJ']) and (Sender.Parent=ZajEd.pnSelIsp1));
  end;
  DelStack;
end;

function ZajEdit(const Capt: string; fqRECNO: TField; stZaj,stIsp: TZajEditOpt; Opt: TZajVsblOpt): boolean;
var lRebuild: boolean;
  procedure SetPnl(pn: TRbPanel; st: TZajEditOpt);
  var fl: boolean;
  begin
    AddStack('FProgEd.ZajEdit.SetPnl');
    fl := zpsVisible in st;
    if pn.Visible<>fl then begin
    	pn.Visible:=fl; lRebuild:=true;
    end;
    ChildFldAll(pn,PrSetPnlState,[byte(st)],false);
    DelStack;
  end;
var a: TArrStr;
	i: longint;
  ap: TDEPrmStr;
  oLogKeys: PLogKeysSave;
begin
  AddStack('FProgEd.ZajEdit');
  if Assigned(fqRECNO)
    then Prog.GotoRec(fqRECNO)
  else if (Zaj.RecNo>0) and not((Prog[fORG]=Zaj[fORG]) and (Prog[fProgCP]=Zaj[fProgCP]))
    then Prog.Seek(Prog.TblFldName(fORG)+'='+Vtos(Zaj[fORG])+sAND+Prog.TblFldName(fProgCP)+'='+QQs(Zaj[fProgCP]));
  result:=false;
  if (Zaj.RecNo>0) or (not empty(Prog[fORG]) and (TProgStatList(Prog['STATUS']) in [stpMain,stpLast])) then with ZajEd do begin
    Zaj.SetLogVidRecno;
    if Assigned(fqRECNO) then oLogKeys:=ProgPswd.PLogKeysLen else oLogKeys:=nil;
    try
      if Assigned(fqRECNO) then ProgLogKeysAdd;
      if not ZajLoaded then begin
        ZajLoaded:=true; dw.dw.LoadFromStr(Glob[sMemo+'PROGW']);
        for i:=0 to LsArrDynamic(dw.dw.Fields,a,CRLF)-1 do begin
          ap:=DEGetArrParam(a[i]);
          ap[deNoVisible]:=BStr[not ProgGet(false).Qry.IsField(Prog.DWVarName(ap[deNameRecFld]))];
          ap[deNoReadOnly]:=bFalse; a[i]:=DESetArrParam(ap);
        end;
        dw.dw.Fields:=ArrayAsList(a,CRLF);
        dw.FldOnPanel(null,'Prog','Окно редактирования заявки',ZajEd.pnDat);
      end;
      Caption:=Capt;
      ENZ.SetReadOnly(not(zajVsblNZ in Opt),ogReadOnlyNoVsbl);
      ZajBeforeEd;
      lRebuild:=false;
      SetPnl(pnZaj,stZaj);
      SetPnl(pnIsp,stIsp);
      if pnWIsp.Visible<>(zajVsblWISP in Opt) then begin
        pnWIsp.Visible := zajVsblWISP in Opt; lRebuild:=true;
      end;
      if lRebuild then begin
        PanelEdit1.FillFldList; ZajEd.MainRebuild;
      end;
      result:=ShowModal=mrOk;
    finally
      if Assigned(fqRECNO) then ProgPswd.PLogKeys:=oLogKeys;
      SetLogVid;
    end;
  end;
  DelStack;
end;

{ TProgEd }
procedure TProgEd.FormCreate(Sender: TObject);
	procedure FldSet(tf: TFldEdit; n: TOrdFixList; pn: TCustomRbPanel = nil);
  var v: variant;
  begin
    AddStack('TProgEd.FormCreate.FldSet',Self);
    PointerDef(pointer(pn),tf);
    with ProgFld[n],aProgFix[n],tf do begin
      pn.SayCaption:=SpaceCapt(Trim(ReplVar(ofvCapt,ofvName)));
      if empty(NameRec) then NameRec:=Prog.NameRec;
      if empty(NameRecFld) then NameRecFld:=ofvFld;
      v:=VarValue; AssignGet(ofvVid,ofvVName); Mask:=ofvMask; CharWidth:=ofvWidth; CharHeight:=ofvHeight;
      SetReadOnly(IsProgRo); VarValue:=v;
      if ofvVar<>'' then begin
        Fld:=tf;
        if not IsProgRo then begin
          oEnter:=OnEnter; OnEnter:=ProgFixEnter;
          oExit:=OnExit; OnExit:=ProgFixExit;
          oChange:=OnChange; OnChange:=ProgFixChange;
          oCheck:=OnCheck; OnCheck:=ProgFixCheck;
        end;
      end;
    end;
    DelStack;
  end;
var s: string;
begin
	AddStack('TProgEd.FormCreate',Self);
  s:=TTimeCurGet.ClassName; ETime.Vid:=s; EWt1.Vid:=s; EWt2.Vid:=s; EIspt1.Vid:=s; EIspt2.Vid:=s;
  ETSelIsp.Vid:=s; ESelIspEndT.Vid:=s; ZeroMemory(@aProgFix,SizeOf(aProgFix));
  FldSet(EProg,ofxKP);
  FldSet(ETn,ofxTN);
  FldSet(EKo,ofxKOD,pnKo);
  FldSet(ENp,ofxNp);
  FldSet(EKd,ofxKD);
  FldSet(EDir,ofxDIR);
  FldSet(EStatus,ofxSTATUS,pnStatus);
  FldSet(ECp,ofxCP);
  FldSet(ERgn,ofxRGN);
  FldSet(ETerr,ofxTerr);
  FldSet(EAcc,ofxAcc);
  FldSet(EKolvo,ofxKolvo);
  FldSet(EMsgPattern,ofxMsgPtrn);
  FldSet(EFbVers,ofxFbVers);
  ETxt.Mask:=TSpGkLs.GetPrm(tZAJ);
  TSpGkLs.GetPrm(ERevalue);
  dw:=TDWWin.Create(Self);
  if IsProgRo then begin
    EIspv.Mask:=RadioMask(ISPVID_NAMES);
    (* NameRec присваивается динамически только для ZajEd.RvProgEd, т.к. если присвоить
      в проектировании, то получатся два TRecVal с одинаковым NameRec: ProgEd.RvProgEd и ZajEd.RvProgEd *)
    s:=Self.Name+'NrProgEd';{Self.Name на всякий случай}
    RvProgEd.NameRec:=s; ETxt.NameRec:=s; EMov.NameRec:=s;
    dw.OnFrmShow:=ProgFixShow;
    KeyLb1.SetKey(K_Shift_F5,'','Движение заявки',ProcKey,'zajmov',kmEdit);
  end
  else begin
    dw.FldOnPanel(Glob[sMemo+'PROGW'],'Prog','Окно редактирования программы',pnDat);
    pnTxtZajIsp.Free; pnProg.ProcentWnd:=100;
  end;
  dw.PrRedefParam:=dwRedefParam;
  ECpa.SetReadOnly(IsProgRo);
  inherited;
  DelStack;
end;

procedure TProgEd.FormShow(Sender: TObject);
var fl: boolean;
  s: string;
begin
	AddStack('TProgEd.FormShow',Self);
  if IsProgRo then Prog.FixRecnoMsg:='Попытка смены программы во время редактирования заявки' else dw.Active:=true;
  inherited;
  EKo.VarValue:=ListKod;
  if IsProgRo then with ESelIspSh do begin
    fl:=StrToBoolean(Cdr['ADMZAJ']); SetReadOnly(not fl); s:=DeShifrStr(Zaj['SELISPSH']);
    if fl then begin
      OnChange:=nil; OnCheck:=ESelIspShCheck;
    end
    else begin
      OnChange:=TDM.deSelIspFldChange; OnCheck:=nil; Str2SelIspSelf(s);
    end;
    DM.Rec['SELISPSH']:=TrimRight(s); Read([ferdSvOld,ferdFromShow]);
  end
  else begin
	  dw.FrmShow(Sender);
    if Prog.RecNo>0 then ProgLogKeysAdd;
  end;
  DelStack;
end;

procedure TProgEd.FormHide(Sender: TObject);
begin
	AddStack('TProgEd.FormHide',Self);
  inherited;
  if IsProgRo then Prog.FixRecnoMsg:=''
  else begin
	  dw.FrmHide(Sender); dw.Active:=false;
  end;
  DelStack;
end;

procedure TProgEd.EKdChange(Sender: TObject; const OldVal: Variant;
  FromShow: Boolean);
begin
	AddStack('TProgEd.EKdChange',Self);
	EDir.Mask:='Папка с программой'+UnDelim+Trim(MakeFullPath(Prog[fDRV]));
  DelStack;
end;

function TProgEd.PanelEdit1Valid(Sender: TObject): Boolean;
	procedure SetTime(tfd,tft: TFldEdit; const nmfDate: string);
  var s: string;
  begin
    AddStack('TProgEd.PanelEdit1Valid.SetTime',Self);
    if tft.Visible then begin
      s:=DateTimeToString(tfd.VarValue,tft.Value);
      if MyVarType(Zaj[nmfDate])=varString then Zaj[nmfDate]:=s else Zaj[nmfDate]:=StringToDate(s);
      LogFields.AddRecFld(Zaj,nmfDate);
    end;
    DelStack;
  end;
var sNow: string;
  procedure SetNow(tfVal: TFldEdit; const nmfDate: string);
  begin
  	AddStack('TProgEd.PanelEdit1Valid.SetNow',Self);
    if TrimRight(tfVal.OldValue)<>TrimRight(tfVal.Value) then Zaj[nmfDate]:=sNow;
    DelStack;
  end;
var i: longint;
  dNow: TDateTime;
  fNow: Double;
  af: TArrBool;
  lUpd,lLog: boolean;
begin
	AddStack('TProgEd.PanelEdit1Valid',Self);
  if IsProgRo then begin
	  result := not(empty(EDate.VarValue) and empty(EIspd.VarValue));
    if result then begin
      SetTime(EDate,ETime,fTD);
      SetTime(EIspd,EIspt1,'TISPD');
      SetTime(EIspd,EIspt2,'TISPD1');
      SetTime(EWd,EWt1,'TWD');
      SetTime(EWd,EWt2,'TWD1');
      SetTime(ESelIspEndD,ESelIspEndT,'TSELISPE');
      dNow:=Now; sNow:=DateToString(dNow);
      SetNow(EWtn,'TWTN');
      aSplitTxt254(Zaj,RvProgEd['ZAJTXT'],true);
      aSplitTxt254(Zaj,zajmov,true,nil,'MOV');
      if StrToBoolean(Cdr['ADMZAJ']) then begin
        SetNow(ESelIspSh,'TSELISP'); SelIspSet(ESelIspSh.VarValue);
      end;
      if Zaj.RecNo=0 then begin
        Zaj[fORG]:=Prog[fORG];
        Zaj[fProgCP]:=Prog[fProgCP];
        if (not empty(Zaj[fORG]))and(not empty(Zaj[fProgCP])) then begin
          Zaj.AppRec(true);
          meserr('Добавлена заявка с номером %d.',[Longint(Zaj['NZ'])]);
        end;
      end
      else if not empty(Zaj[fORG]) and not empty(Zaj[fProgCP]) then begin
        Zaj.GetFieldsModified(af); lUpd:=false; lLog:=false;
        for i:=low(af) to high(af) do if af[i] then begin
          lUpd:=true;
          if not AnsiMatchText(Zaj.FieldName[i],['SELISPSH','TSELISP']) then lLog:=true;
        end;
        if lUpd then begin
          if not((Prog[fCDR]=Cdr[fCDR]) and empty(Zaj['WTN']) or (Zaj['WTN']=Cdr[fCDR]))
          then Zaj['SEL']:=bFalse;
          fNow:=Zaj['TCNG']; Zaj['TCNG']:=dNow;
          Zaj.UpdateRec(lLog,nil,@i,'TCNG='+Vtos(fNow)); result := i>0;
          if not result then
            if Ask(['Внимание !','Во время редактирования были произведены изменения другим пользователем.',
            'Загрузить изменения, произведённые другим пользователем ?']) then begin
              Zaj.GotoRec; ZajBeforeEd; PanelEdit1.FldReadAll([ferdSvOld,ferdFromShow]);
            end
            else Zaj['TCNG']:=fNow;
        end;
      end;
    end
    else PanelEdit1.FldFocus:=EDate;
  end
  else begin
    result:=dw.PnlValid(Sender);
    if result then begin
      ListSave;
      try
        result:=LockBuhRead;
        if result then try
          List.Seek(List.TblFldName(nmfbKOD)+'='+QQs(EKo.Value));
        finally
          UnlockMode('FBUH');
        end;
        if result then begin
          ProgLogKeysAdd;
          result:=DM.ProgCalc(true);
          if result then Prog[fORG]:=List[nmfbKO];
          Prog.UpdateRec(true);
        end;
      finally
        ListRest;
      end;
    end;
  end;
  DelStack;
end;

procedure TProgEd.PanelEdit1Escape(Sender: TObject;
  var Action: TCloseAction);
begin
	AddStack('TProgEd.PanelEdit1Escape',Self);
  inherited;
  if not IsProgRo then dw.PnlEscape(Sender,Action);
  DelStack;
end;

procedure TProgEd.PanelEdit1AfterEscape(Sender: TObject);
begin
	AddStack('TProgEd.PanelEdit1AfterEscape',Self);
  inherited;
  if not IsProgRo then dw.PnlAfterEscape(Sender);
  DelStack;
end;

function TProgEd.PanelEdit1AskCancel(Sender: TObject): Boolean;
begin
	AddStack('TProgEd.PanelEdit1AskCancel',Self);
  if IsProgRo then result:=false else result:=dw.PnlAskCancel(Sender);
  DelStack;
end;

function TProgEd.EDirCheck(Sender: TObject): Boolean;
begin
  AddStack('TProgEd.EDirCheck',Self);
  result:=not empty(Prog['DIR']);
  DelStack;
end;

procedure TProgEd.WMFormLimit;
begin
	AddStack('TProgEd.WMFormLimit',Self);
  inherited;
  if not FreeLimit(ProgEd) then FreeLimit(ZajEd);
  DelStack;
end;

function TProgEd.EZTnCheck(Sender: TObject): Boolean;
begin
  AddStack('TProgEd.EZTnCheck',Self);
  result := empty(EDate.VarValue) or not empty(Zaj[fCDR]);
  DelStack;
end;

function TProgEd.EWtnCheck(Sender: TObject): Boolean;
begin
	AddStack('TProgEd.EWtnCheck',Self);
  result := empty(EWd.VarValue) or not empty(Zaj['WTN']);
  DelStack;
end;

function TProgEd.EIsptnCheck(Sender: TObject): Boolean;
begin
	AddStack('TProgEd.EIsptnCheck',Self);
  result := empty(EIspd.VarValue) or not empty(Zaj['ISPTN']);
  DelStack;
end;

procedure TProgEd.EKoChange(Sender: TObject; const OldVal: Variant;
  FromShow: Boolean);
var s: string;
begin
  AddStack('TProgEd.EKoChange',Self);
  if (Prog.RecNo=0) and (FromShow or (OldVal<>EKo.VarValue)) then begin
    s:=fORG+'='+Vtos(Int0(DM.ListGet.CodeDop(EKo.VarValue,[cdgBufAll])));
    ECp.VarValue:=Prog.KodNext(fProgCP,s);
    ENp.VarValue:=Prog.KodNext(fProgNP,s);
  end;
  DelStack;
end;

procedure TProgEd.ENpExit(Sender: TObject);
begin
	AddStack('TProgEd.ENpExit',Self);
  SpaceStrSelf(Sender);
  DelStack;
end;

function TProgEd.ENpCheck(Sender: TObject): Boolean;
begin
	AddStack('TProgEd.ENpCheck',Self);
  if (Sender=ECp) and empty(Prog[fProgCP]) and (Prog['STATUS']=stpTemp)
  then result:=true
  else result:=KodCheck(Sender,
    fORG+'='+Vtos(Int0(DM.ListGet.CodeDop(EKo.VarValue,[cdgBufAll]))),
    IfThen(Sender=ECp,'','Программа с таким номером уже есть у данного клиента.'));
  DelStack;
end;

function TProgEd.IsProgRo;
begin
  result := Self=ZajEd;
end;

procedure TProgEd.EProgChange(Sender: TObject; const OldVal: Variant; FromShow: Boolean);
var hideDir,hideFbVers: boolean;
  go: TGetOptions;
begin
  inherited;
  hideDir:=(NeedClearProgDir(Prog[fProgKP]));

  go:=IfThen(not IsProgRo or hideDir,ogReadOnly)+[ogReadOnlyNoVsbl];
  EKd.SetReadOnly(hideDir,go);
  EDir.SetReadOnly(hideDir,go);

  EKolvo.SetReadOnly(not hideDir,IfThen(not(IsProgRo and hideDir),ogReadOnly)+[ogReadOnlyNoVsbl]);
  
  hideFbVers:=(NeedClearFbVers(Prog[fProgKP]));
  EFbVers.SetReadOnly(hideFbVers,IfThen(not IsProgRo or hideFbVers,ogReadOnly)+[ogReadOnlyNoVsbl]);
  
  if (hideDir) then begin
    EKd.VarValue:='';
    EDir.VarValue:='';
  end;
end;

procedure TProgEd.ELSetChange(Sender: TObject; const OldVal: Variant;
  FromShow: Boolean);
var oset,nset: boolean;
begin
  AddStack('TProgEd.ELSetChange',Self);
  oset:=StrToBoolean(OldVal); nset:=StrToBoolean(Zaj['LSET']);
  EBall1.SetReadOnly(not nset); EBall2.SetReadOnly(not nset);
  if not FromShow and (nset<>oset) then
    if nset then EBall1.VarValue:=EBall0.VarValue
    else begin
      EBall1.VarValue:=0; EBall2.VarValue:=0;
    end;
  DelStack;
end;

procedure TProgEd.EStatusChange(Sender: TObject; const OldVal: Variant;
  FromShow: Boolean);
begin
  AddStack('TProgEd.EStatusChange',Self);
  ECpa.SetReadOnly(Prog['STATUS']<>stpTemp);
  DelStack;
end;

function TProgEd.EIspdCheck(Sender: TObject): Boolean;
var disp: TDateTime;
begin
  AddStack('TProgEd.EIspdCheck',Self);
  disp:=TFldEdit(Sender).VarValue; result := empty(disp) or InRange(disp,bom(EDate.VarValue),Date);
  DelStack;
end;

class function TProgEd.ESelIspShCheck;
var a: TSelIspArr;
  i: longint;
begin
  AddStack('TProgEd.ESelIspShCheck');
  result:=true;
  if Str2SelIsp(a,TFldEdit(Sender).Value) then for i:=low(a) to high(a) do with a[i] do
    if not CdrGet.IsCod(IntToStr(tn)) then begin
      meserr('Отсутствует пользователь с номером %d.',[tn]);
      result:=false; break;
    end
    else if ball=0 then begin
      meserr('Не заполнены баллы для пользователя с номером %d.',[tn]);
      result:=false; break;
    end;
  DelStack;
end;

function TProgEd.ProgFixSeek;
begin
  AddStack('TProgEd.ProgFixSeek',Self);
  result:=low(aProgFix);
  while result<=high(aProgFix) do if aProgFix[result].Fld=Sender then break else Inc(result);
  DelStack;
end;

procedure TProgEd.ProgFixShow;
var n: TOrdFixList;
begin
  AddStack('TProgEd.ProgFixShow',Self);
  for n:=low(aProgFix) to high(aProgFix) do with aProgFix[n] do
    if Assigned(Fld) then dw.FldChange(Fld,Fld.VarValue,true);
  DelStack;
end;

procedure TProgEd.ProgFixEnter;
begin
  AddStack('TProgEd.ProgFixEnter',Self);
  IfThenNotify(aProgFix[ProgFixSeek(Sender)].oEnter,Sender); dw.FldEnter(Sender);
  DelStack;
end;

procedure TProgEd.ProgFixExit;
begin
  AddStack('TProgEd.ProgFixExit',Self);
  IfThenNotify(aProgFix[ProgFixSeek(Sender)].oExit,Sender); dw.FldExit(Sender);
  DelStack;
end;

procedure TProgEd.ProgFixChange;
begin
  AddStack('TProgEd.ProgFixChange',Self);
  IfThenCng(aProgFix[ProgFixSeek(Sender)].oChange,Sender,OldVal,FromShow); dw.FldChange(Sender,OldVal,FromShow);
  DelStack;
end;

function TProgEd.ProgFixCheck;
begin
  AddStack('TProgEd.ProgFixCheck',Self);
  result:=IfThenValid(aProgFix[ProgFixSeek(Sender)].oCheck,Sender);
  if result then result:=dw.FldCheck(Sender);
  DelStack;
end;

procedure TProgEd.dwRedefParam;
var n: TOrdFixList;
begin
  AddStack('TProgEd.dwRedefParam',Self);
  n:=ProgFixSeek(Sender);
  if n<=ofxCnt then av[0]:=ProgFld[n].ofvVar;
  DelStack;
end;

procedure TProgEd.ZajBeforeEd;
begin
  AddStack('TProgEd.ZajBeforeEd',Self);
  DM.DateToRec(Zaj,fTD);
  DM.DateToRec(Zaj,'TISPD','1');
  DM.DateToRec(Zaj,'TISPD1','2');
  DM.DateToRec(Zaj,'TWD','3');
  DM.DateToRec(Zaj,'TWD1','4');
  DM.DateToRec(Zaj,'TSELISP','5');
  DM.DateToRec(Zaj,'TWTN','6');
  DM.DateToRec(Zaj,'TSELISPE','7');
  RvProgEd['ZAJTXT']:=aConcatTxt254(Zaj);
  zajmov:=aConcatTxt254(Zaj,false,'MOV');
  SetZajMov;
  DelStack;
end;

procedure TProgEd.SetZajMov;
begin
  AddStack('TProgEd.SetZajMov',Self);
  RvProgEd['ZAJMOV']:=DlmCopy(zajmov,1,1,CRLF);
  DelStack;
end;

procedure TProgEd.ProcKey;
begin
  AddStack('TProgEd.ProcKey',Self);
  if EdTextExec('Движение заявки',zajmov,'',nil,[],edtpText,0,0,'',0,nil,'',nil,nil,'',nil,nil,nil,TDM.ZajMovMaxLength) then begin
    SetZajMov; EMov.Read;
  end;
  DelStack;
end;

function ProgEdExec(Key: longint; lFlt: boolean): TObject;
begin
  AddStack('FProgEd.ProgEdExec');
  result:=nil;
  case Key of
    K_F4,K_F5,K_F7,K_Alt_R: begin
      CreateForm(TProgEd,ProgEd);
      with ProgEd do begin
        ETn.SetReadOnly(not lFlt and (List.RecNo=0));
        EKo.SetReadOnly(not lFlt or (Key=K_F5));
        ECp.SetReadOnly(Key=K_F5);
        EProg.SetReadOnly(Key=K_F5);
        EStatus.SetReadOnly(Key=K_F5);
      end;
      result:=ProgEd;
    end;
    K_Ctrl_F7,K_Shift_F5,K_Shift_F7: CreateForm(TProgEd,ZajEd);
  end;
  DelStack;
end;

// ProgDatEd()
function c_ProgDatEd(var av: array of variant): variant;
  {function sPrg(r: TRecDB): string;
  begin
  	AddStack('FProgEd.c_ProgDatEd.sPrg');
    result:='('+ListKod(r)+'.'+r[fProgCP]+')';
    DelStack;
  end;}
begin
	AddStack('FProgEd.c_ProgDatEd');
  with ZajEd do begin
    {if not((Zaj.RecNo=0) or (Prog[fORG]=Zaj[fORG]) and (Prog[fProgCP]=Zaj[fProgCP])) then begin
      MsgFindError('Несоответствие заявки'+sPrg(Zaj)+' программе'+sPrg(Prog));
      Prog.Seek(Prog.TblFldName(fORG)+'='+Vtos(Zaj[fORG])+sAND+Prog.TblFldName(fProgCP)+'='+QQs(Zaj[fProgCP]));
    end;}
  	dw.Execute(Glob[sMemo+'PROGW'],'ProgDat',Prog,'Окно редактирования программы',[0]);
  end;
  DelStack;
end;

initialization
  OLTypes.ProgEdExec:=ProgEdExec; OLTypes.ZajEdit:=ZajEdit;
  TInter.SetFunction('ProgDatEd',c_ProgDatEd);
end.
