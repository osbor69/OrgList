unit FCdrLs;

interface

{$I ORGTEST}
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, Menus, DB, DBTables, Grids, DBGrids, ExtCtrls, Math, StdCtrls, StrUtils,
  MyTypes, My_pr, FRMBRIB, KeyMenu, BrQuery, Browl, Keylb, Fpanel, DefEdit, FFldEdit,
    ComboGet, ListF2, PaintCtl, RbMenu, RecVal, CCodeGet;

type
  TCdrLs = class(TFormBrIB)
    de: TDefEdit;
    PhoneGet: TComboGet;
    Rec: TRecVal;
    dmStatus: TDefMenu;
    dmPhone: TDefMenu;
    dePswd: TDefEdit;
    procedure deFldExit(Sender: TObject);
    function deFldCheck(Sender: TObject): Boolean;
    procedure Browl1BrowlKey(key: Integer; tw: TWinControl);
    procedure Browl1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function Browl1GrayCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState): Boolean;
    procedure deFldChange(Sender: TObject; const OldVal: Variant;
      FromShow: Boolean);
    procedure deFrmShow(Sender: TObject);
    function PhoneGetListResult(Sender: TObject;
      lr: TListF2Result): String;
    function PhoneGetListOwner(Sender: TObject; SpdBut: TPaintButton;
      const RectList: TRect; PozList: TPozList): Boolean;
    procedure PhoneGetAfterList(Sender: TObject);
    procedure Browl1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Browl1BrMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    function dePnlValid(Sender: TObject): Boolean;
    procedure Browl1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure deFrmHide(Sender: TObject);
  private
    { Private declarations }
    BrQuery1SEL: TBooleanField;
    BrQuery1RECNO: TField;
    ls: TStringList;
    afCdr: TArrFldVal;
    oPhone: string;
    brCur: TBrowl;
		oStatus: byte;
    procedure BrQuery1CalcFields(DataSet: TDataSet);
		class function PrDel(Sender: TObject): boolean;
		//class procedure NewNum(const oldnum: string; var result: boolean);
    function CheckTn: boolean;
    procedure dmStatusExec(pShow: PDefMenuShow);
    procedure dmPhoneExec(pShow: PDefMenuShow);
		function OfisAdd(lLog: boolean = true): boolean;
    class procedure TabKey(key: Integer; tw: TWinControl);
		procedure WMRebuild(var Message: TWMRebuild); message WM_REBUILD;
  public
    { Public declarations }
		class procedure ProcBeforeShow(q: TBrQuery; KeyLb1: TKeyLb);
		class procedure ProcShow(q: TBrQuery; var afCdr: TArrFldVal);
		class procedure ProcHide(const afCdr: TArrFldVal; tl: TKeyLb);
		class function Execute(var Value: string; lTrim: boolean; const Capt: string = ''): boolean;
  end;

function PhoneVisible(status: longint): boolean;
function CdrWorking(status: longint): boolean;
procedure CdrAdmZajSet;
procedure lsIpClear;

var
  CdrLs: TCdrLs;

implementation

{$R *.dfm}

uses mulqry,FrmPswd,FCngNum,Shifr,
  OLTypes,FDM,FOfisLs,FZajLs,OLProc;

const K_Beg=K_A;

var lsIP: TStrStrList;
  WithOut: boolean;
  nStatus,nPhone: longint;

function PhoneVisible;
begin
  AddStack('FCdrLs.PhoneVisible');
  result := TCdrStatList(status) in [cstFree,cstBusy,cstOrder];
  DelStack;
end;

function CdrWorking;
begin
  AddStack('FCdrLs.CdrWorking');
  result := PhoneVisible(status) or (TCdrStatList(status)=cstRemote);
  DelStack;
end;

procedure DerIPTrans(q: TMulQuery; var Value: string);
var i: longint;
begin
  AddStack('FCdrLs.DerIPTrans');
  if q.Connection=DBMain then begin
    if not Assigned(lsIp) then begin
      with ProgPswd.GetQuery do begin
        PartSelect(tDRV,[fIP,fNAME]); i:=RecordCount; lsIp:=TStrStrList.Create(true,i); lsIp.BeginUpdate;
        for i:=1 to i do begin
          lsIP.IgnoreFindAdd(StrTran(Fields[0].AsString,' '),TrimRight(Fields[1].AsString)); Next;
        end;
        lsIp.EndUpdate; ProgPswd.FreeQuery;
      end;
    end;
    lsIP.FindValue(Value,Value);
  end;
  DelStack;
end;

procedure DerIPTrans0(q: TMulQuery; var Value: string);
begin
  Value:='';
end;

function DerTrans(const Prim: string): string;
const
  s1='SELISPSH="'; l1=Length(s1);
  s2='"'         ; l2=Length(s2);
var p,p1,p2: longint;
begin
  AddStack('FCdrLs.DerTrans');
  result:=Prim; p:=1;
  repeat
    if not IsPos(p1,s1,result,p) then break;
    Inc(p1,l1);
    if not IsPos(p2,s2,result,p1) then break;
    p:=p2+l2; Dec(p2,p1); StuffStrSelf(result,p1,p2,DeShifrStr(Copy(result,p1,p2)));
  until false;
  DelStack;
end;

procedure CdrAdmZajSet;
begin
  AddStack('FCdrLs.CdrAdmZajSet');
  FreeAndNil(ZajLs);
  if StrToBoolean(Cdr['ADMZAJ']) then begin
    FrmPswd.DerIPTrans:=DerIPTrans; MyTypes.DerTrans:=DerTrans;
  end
  else begin
    FrmPswd.DerIPTrans:=DerIPTrans0; MyTypes.DerTrans:=nil;
  end;
  DelStack;
end;

procedure lsIpClear;
begin
  AddStack('FCdrLs.lsIpClear');
  FreeAndNil(lsIp);
  DelStack;
end;

{ TCdrLs }
procedure TCdrLs.FormCreate(Sender: TObject);
var i: TCdrStatList;
  BrQuery1PHONE: TStringField;
begin
	AddStack('TCdrLs.FormCreate',Self);
  inherited;
  with BrQuery1 do begin
  	BrQuery1RECNO:=Init(DBMain,[fCDR,fUPNAME],[fCDR],tCDR,[fCDR,fRECNO,fNAME,fUPNAME,'STATUS','PHONE','OUT','PRIM'],
      FldIsTrue('OUT',false),'',BrQuery1CalcFields);
    BrQuery1SEL:=CreateBooleanField('SEL'); BrQuery1SEL.Visible:=false;
    Browl1.FieldSeek:=CreateStringField(fCDR,'Номер',0,taRightJustify);
    CreateStringField(fNAME,'Фамилия Имя Отчество');
    CreateStringField('OUT');
    CreateStringField('CSTATUS','Статус',lStatus);
    BrQuery1PHONE:=CreateStringField('PHONE','Телефон'); BrQuery1PHONE.Visible:=false;
    CreateStringField('CPHONE','Телефон',BrQuery1PHONE.Size);
    CreateStringField('PRIM');
    CreateStringField(fUPNAME,'Фамилия Имя Отчество').Visible:=false;
    CreateField('STATUS');
  end;
  for i:=low(aCdrStat) to high(aCdrStat) do dmStatus.InsertKey(K_Beg+byte(i),aCdrStat[i]);
  de.Param['STATUS',deMask]:=RadioMask(aCdrStat,0);
  PhoneGet.LenName:=lPhone;
  DelStack;
end;

procedure TCdrLs.FormShow(Sender: TObject);
var tr,ii: longint;
begin
	AddStack('TCdrLs.FormShow',Self);
  tr:=Browl1.Row; ii:=BrQuery1RECNO.AsInteger; ProcBeforeShow(BrQuery1,KeyLb1); Browl1.BrUpdate(tr,ii);
  inherited;
  ProcShow(BrQuery1,afCdr); MainRebuild;
  DelStack;
end;

class procedure TCdrLs.ProcBeforeShow;
var i,j: longint;
begin
  AddStack('TCdrLs.ProcBeforeShow');
  with q do begin
    FindField('OUT').Visible:=WithOut;
    SetPart(aPartWOGH[WithOut,Arg[sO_LIST]='',Arg[sG_LIST]='',Arg[sHAVE]='']);
    KeyLb1.SetKey(K_Tab,IfThen(WithOut,'Без выбывших','С выбывшими'),'',TabKey,'out',kmList);
    j:=0;
    for i:=0 to FieldCount-1 do with Fields[i] do begin
      if FieldName='CSTATUS' then nStatus:=j;
      if FieldName='CPHONE' then nPhone:=j;
      if Visible then Inc(j);
    end;
  end;
  DelStack;
end;

class procedure TCdrLs.ProcShow;
var i,l: longint;
begin
  AddStack('TCdrLs.ProcShow');
  with Cdr do begin
	  iiCdr:=RecNo; GetAFieldValue(afCdr);
    for l:=low(afnmCdr) to high(afnmCdr) do
      for i:=low(afCdr) to high(afCdr) do with afCdr[i] do if nm=afnmCdr[l] then nm:='';
  end;
  DelStack;
end;

class procedure TCdrLs.ProcHide;
begin
  AddStack('TCdrLs.ProcHide');
  with Cdr do begin
  	if iiCdr=0 then NewRec else GotoRec(iiCdr);
    SetAFieldValue(afCdr); iiCdr:=NegDef;
  end;
  tl.DelKey(K_All,'out'); tl.ReDrw;
  DelStack;
end;

procedure TCdrLs.FormHide(Sender: TObject);
begin
	AddStack('TCdrLs.FormHide',Self);
  ProcHide(afCdr,KeyLb1);
  inherited;
  DelStack;
end;

class function TCdrLs.Execute;
var i: longint;
  bm: TBookMark;
  oCapt,ov: string;
begin
  AddStack('TCdrLs.Execute');
  CreateForm(TCdrLs,CdrLs);
  with CdrLs do begin
  	ls:=TStringList.Create;
    try
      ls.Text:=TrimRight(StrTran(Value,',',CRLF)); SpaceStrList(ls,lCdrTn); ls.Sorted:=true;
      with KeyLb1 do begin
      	SetKeys([K_Space,K_Enter,K_Ins],'Отметить','',Browl1BrowlKey,'sel',kmList);
      	SetKeySel([K_Plus],[K_Minus],Browl1BrowlKey,'sel');
        Redrw;
      end;
      BrQuery1SEL.Visible:=true; oCapt:=Caption; ov:=TrimRight(ls.Text);
      if Capt<>'' then Caption:=Capt;
      ShowModal; Caption:=oCapt;
      BrQuery1SEL.Visible:=false; KeyLb1.DelKey(K_All,'sel'); KeyLb1.Redrw;
      with BrQuery1 do begin
      	DisableControls; Open; bm:=GetBookMark; First;
        while not Eof do begin
        	if ls.Find(Browl1.FieldSeek.AsString,i) then ls.Objects[i]:=ObjectTrue;
        	Next;
        end;
        BoolObjPack(ls); GotoBookMark(bm); FreeBookMark(bm); EnableControls; Close;
      end;
      result := TrimRight(ls.Text)<>ov;
      if result then begin
        if lTrim then begin
          ls.Sorted:=false; TrimSelf(ls);
        end;
        Value:=StrTran(TrimRight(ls.Text),CRLF,',');
      end;
    finally
      ls.Free;
    end;
  end;
  DelStack;
end;

function TCdrLs.CheckTn;
begin
  AddStack('TCdrLs.CheckTn',Self);
  if brCur.Qry.FieldZN(fCDR)=DM.Rec[fCDR]
  then result:=true
  else result:=Ask(['Внимание !','Вы пытаетесь изменить параметры другого пользователя.','Продолжить ?'],false);
  DelStack;
end;

procedure TCdrLs.Browl1BrowlKey(key: Integer; tw: TWinControl);
var fl,lCng: boolean;
	bm: TBookMark;
  s,tn: string;
  q: TBrQuery;
  fqTN,fqNAME: TField;
  p: TPoint;
  r: TDefMenuShow;
  bn: TBotN;
begin
	AddStack('TCdrLs.Browl1BrowlKey',Self);
  inherited;
  brCur:=pointer(tw); q:=pointer(brCur.Qry);
  if q.CanEdit(key) then begin
  	fl:=false; fqTN:=q.FindField(fCDR);
    case Key of
    	K_F2: begin
      	CreateForm(TOfisLs,OfisLs);
        with OfisLs do begin
        	s:=fqTN.AsString; Caption:=Trim(s)+'. '+Trim(q.FindField(fNAME).AsString);
          BrQuery1.GlobKey:=QQs(s); ShowModal;
        end;
        FormFree(OfisLs);
      end;
      {K_F3: fl:=TCngNum.GetNewNum('Новый номер пользователя',brCur,Cdr,fCDR,
        [tCDR,tPROG,tZAJ,tMSG,tDOC,tOFIS,tDOCPRM],[],'',NewNum);}
      K_F4,K_F7: begin
        de.Param['TELON',deNoVisible]:=bTrue;
        fl:=brCur.AppRec('Добавление пользователя',Cdr,de,IfThen(Key),'',fCDR);
        // При добавлении пользователя перезаполнять CDR.TEL
        if fl then DM.TelCdrN;
      end;
      K_F5:
        if brCur.Col in [nStatus,nPhone] then begin
          p:=brCur.ClientOrigin; r.lRect:=true; r.r:=brCur.SelRect; OffsetRect(r.r,p.X,p.Y);
          if brCur.Col=nStatus then dmStatusExec(@r) else dmPhoneExec(@r);
        end
        else if CheckTn then begin
          de.Param['TELON',deNoVisible]:=bStr[not DM.GetBotN(fqTN.AsString,bn)]; Rec['TELON']:=not bn.lOff;
          fqNAME:=q.FindField(fNAME); s:=fqNAME.AsString;
          fl:=brCur.EditRec('Редактирование пользователя',Cdr,de,fCDR);
          if fl then begin
            // При редактировании ФИО пользователя или откл.Telegram перезаполнять CDR.TEL
            lCng:=Rec['TELON']=bn.lOff;
            if lCng then bn.lOff:=not Rec['TELON']
            else lCng := fqNAME.AsString<>s;
            if lCng then DM.SetBotN(bn);
            ETnStatusUpdate('',0);
          end;
        end;
      K_F8: with ProgPswd.GetQuery do begin
        tn:=fqTN.AsString; s:='='+QQs(tn);
        PartSelect(tPROG,[fORG,fProgKP],fCDR+s);
        if Eof then begin
          PartSelect(tZAJ,[fCDR,fTD,'NZ'],fCDR+s+sOR+'ISPTN'+s);
          if Eof then begin
            PartSelect(tMSG,[fMsgTNTO,fTD],fMsgTNFROM+s+sOR+fMsgTNTO+s);
            if Eof then begin
              fl:=brCur.DelAsk(Cdr,PrDel);
              // При удалении пользователя перезаполнять CDR.TEL
              if fl then begin
                DM.TelCdrN; DM.DelBotN(tn);
              end;
            end
            else begin
              mess_ok([IfThen(Fields[0].AsString=fqTN.AsString,
                'Существуют сообщения, адресованные данному пользователю.',
                'Существуют сообщения, отправленные данным пользователем.'),
                'Дата: '+StringToDispDate(Fields[1].AsString)]);
            end;
          end else begin
            mess_ok([IfThen(Fields[0].AsString=fqTN.AsString,
              'Существуют заявки, которые принял данный пользователь.',
              'Существуют заявки, исполнителем которых является данный пользователь.'),
              'Поступила: '+StringToDispDate(Fields[1].AsString),
              StrNum('Номер: ',Fields[2].AsInteger)]);
          end;
        end else begin
          mess_ok(['У данного пользователя есть подответственные программы.',
            'Клиент: '+Trim(DM.ListGet.Codest(ListKod(Fields[0].AsInteger))),
            'Программа: '+Trim(ProgInf(ProgPswd.CurQuery).Name)]);
        end;
        ProgPswd.FreeQuery;
      end;
      K_Plus: if AskSel(true) then with q do begin
        bm:=GetBookMark; DisableControls; First;
        while not Eof do begin
          ls.Add(fqTN.AsString); Next;
        end;
        GotoBookMark(bm); FreeBookMark(bm); EnableControls;
      end;
      K_Minus: if AskSel(false) then begin
        ls.Clear; brCur.BrUpdate;
      end;
      K_Ctrl_F8: if Ask(['Установить статус "нет" для всех пользователей ?'])
      then with ProgPswd.GetQuery do begin
        PartSelect(tCDR,[]);
        while not Eof do begin
          Cdr.GetFromQuery;
          oStatus:=Cdr['STATUS'];
          Cdr['STATUS']:=cstNone;
          OfisAdd;
          Cdr.UpdateRec;
          Next;
        end;
        ProgPswd.FreeQuery;
        brCur.BrUpdate;
        ETnStatusUpdate('',0);
      end;
      K_Ctrl_P: begin
        ProgPswd.LogVid:=logvEditRec;
        Cdr.GotoRec(q); Rec['PSWD']:=DeShifrStr(Cdr['PSWD']);
        if dePswd.Execute(TrimRight(Cdr[fNAME])).Saved then begin
          LogFields.AddRecFld(Cdr,'PSWD'); Cdr['PSWD']:=ShifrStr(Rec['PSWD']); Cdr.UpdateRec(true);
        end;
        ProgPswd.LogVid:=logvNone;
      end;
    else
      IgnoreSlAddDel(ls,fqTN.AsString); brCur.BrUpdate;
      if Key=K_Ins then q.Next;
    end;
    if fl then begin
      CdrGet.ClearBuf; ProgPswd.SendUpd(updCodeGet);
    end;
  end;
  DelStack;
end;

class procedure TCdrLs.TabKey;
var brCur: TBrowl;
  tr,ii: longint;
  tl: TKeyLb;
  q: TBrQuery;
begin
  AddStack('TCdrLs.TabKey');
  brCur:=pointer(tw); q:=pointer(brCur.Qry); tr:=brCur.Row; ii:=q.FieldZN(fRECNO);
  NotD(WithOut); tl:=FormKeyLb(brCur); ProcBeforeShow(q,tl); tl.ReDrw; brCur.BrUpdate(tr,ii);
  DelStack;
end;

class function TCdrLs.PrDel;
var w: string;
begin
  AddStack('TCdrLs.PrDel');
  w:=fCDR+'='+QQs(Cdr[fCDR]); Ofis.DelRec(w); ProgPswd.DeleteTable(tCNG,w); result:=true;
  DelStack;
end;

{ Временно закрыто, т.к. не поддерживается ZAJ.SELISPSH
class procedure TCdrLs.NewNum;
var so,sn: string;
begin
	AddStack('TCdrLs.NewNum');
  sn:=QQs(Cdr[fCDR]); so:='='+QQs(oldnum);
  Prog.UpdateTable([fCDR],[sn],fCDR+so);
  Zaj.UpdateTable([fCDR],[sn],fCDR+so,false);
  Zaj.UpdateTable(['WTN'],[sn],'WTN'+so,false);
  Zaj.UpdateTable(['ISPTN'],[sn],'ISPTN'+so);
  Msg.UpdateTable([fMsgTNFROM],[sn],fMsgTNFROM+so,false);
  Msg.UpdateTable([fMsgTNTO],[sn],fMsgTNTO+so);
  Doc.UpdateTable([fCDR],[sn],fCDR+so);
  Ofis.UpdateTable([fCDR],[sn],fCDR+so);
  with ProgPswd.GetQuery do begin
    UpdateTable(tCNG,[fCDR],[sn],fCDR+so);
    UpdateTable(tDOCPRM,[fUSERNAME],[sn],fUSERNAME+so);
    UpdateTable(tCDR,['TNMSG'],[sn],'TNMSG'+so);
  end;
  DelStack;
end;}

procedure TCdrLs.deFrmShow(Sender: TObject);
var SelfPhone: string;
    mq: TMulQuery;
    sl: TStringList;
begin
	AddStack('TCdrLs.deFrmShow',Self);
  {Cdr.FixFld:=Cdr.FldName('STATUS');
  Cdr.FixError:='Попытка смены статуса пользователя во время редактирования';}
  oStatus:=Cdr['STATUS'];
  sl:=PhoneGet.Items;
  mq:=ProgPswd.GetQuery;
  try
    sl.BeginUpdate;
    try
      mq.PartSelect(tDRV,[fNAME,'PHONE'],'PHONE<>'+QQs);
      sl.Clear;
      sl.Sorted:=true;
      SelfPhone:='';
      while not mq.Eof do begin
        if IsSelfComp(TrimRight(mq.Fields[0].AsString)) then SelfPhone:=TrimRight(mq.Fields[1].AsString)
        else sl.Add(TrimRight(mq.Fields[1].AsString));
        mq.Next;
      end;
      sl.Sorted:=false;
      if not empty(SelfPhone) then sl.Insert(0,SelfPhone+' (на данном компьютере)');
      sl.Add(Space(lPhone));
    finally
      sl.EndUpdate;
    end;
  finally
    ProgPswd.FreeQuery;
  end;
  DelStack;
end;

procedure TCdrLs.deFrmHide(Sender: TObject);
begin
  AddStack('TCdrLs.deFrmHide',Self);
  inherited;
  //Cdr.FixFld:=nil;
  DelStack;
end;

procedure TCdrLs.deFldChange(Sender: TObject; const OldVal: Variant;
  FromShow: Boolean);
begin
	AddStack('TCdrLs.deFldChange',Self);
  with TFldEdit(Sender) do if NameRecFld='STATUS' then de.SetReadOnly('PHONE',not PhoneVisible(VarValue));
  DelStack;
end;

procedure TCdrLs.deFldExit(Sender: TObject);
begin
	AddStack('TCdrLs.deFldExit',Self);
  SpaceStrSelf(Sender,fCDR);
  DelStack;
end;

function TCdrLs.deFldCheck(Sender: TObject): Boolean;
begin
	AddStack('TCdrLs.deFldCheck',Self);
  if KodCheck(Sender,fCDR,result) then CharCheck(Sender,fNAME,result);
  DelStack;
end;

function TCdrLs.dePnlValid(Sender: TObject): Boolean;
var f: TField;
begin
	AddStack('TCdrLs.dePnlValid',Self);
  if qZajMain.FindField('CCALC',f) then f.DisplayLabel:=ZajFldName(ofzISPCALC);
  CdrAdmZajSet; OfisAdd(false); result:=true;
  DelStack;
end;

procedure TCdrLs.BrQuery1CalcFields;
var status: TCdrStatList;
  q: TMulQuery;
begin
	AddStack('TCdrLs.BrQuery1CalcFields',Self);
  if BrQuery1SEL.Visible then BrQuery1SEL.AsBoolean := ls.IndexOf(Browl1.FieldSeek.AsString) >= 0;
  q:=MulQueryOwner(DataSet);
  with q do begin
    status:=CdrStatList(FindField('STATUS').AsInteger);
    if not(status in [cstNone,cstFree]) then FindField('CSTATUS').AsString:=aCdrStat[status];
    if PhoneVisible(byte(status)) then FindField('CPHONE').AsString:=FindField('PHONE').AsString;
  end;
  DelStack;
end;

procedure TCdrLs.Browl1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
	AddStack('TCdrLs.Browl1DrawColumnCell',Self);
  inherited;
  with TBrowl(Sender) do
    if not bmCheckPaint(Rect,Column)
    then   bmCheckPaint(Rect,['OUT'],Column,true,InitBM.FindBM(bmNoAllowed));
  DelStack;
end;

function TCdrLs.Browl1GrayCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState): Boolean;
begin
	AddStack('TCdrLs.Browl1GrayCell',Self);
  inherited;
  result:=not CdrWorking(TBrowl(Sender).Qry.FindField('STATUS').AsInteger);
  DelStack;
end;

function TCdrLs.PhoneGetListResult(Sender: TObject;
  lr: TListF2Result): String;
begin
	AddStack('TCdrLs.PhoneGetListResult',Self);
  if lr.SelectStr < 0 then result:=''
  else begin
  	result:=Padr(PhoneGet.Items[lr.SelectStr],lPhone); oPhone:=result;
  end;
  DelStack;
end;

function TCdrLs.PhoneGetListOwner(Sender: TObject; SpdBut: TPaintButton;
  const RectList: TRect; PozList: TPozList): Boolean;
var tf: TFLdEdit;
begin
  AddStack('TCdrLs.PhoneGetListOwner',Self);
  tf:=de.FldEdit['PHONE']; SetRedraw(tf); oPhone:=tf.Value; tf.Value:=''; result:=false;
  DelStack;
end;

procedure TCdrLs.PhoneGetAfterList(Sender: TObject);
var tf: TFLdEdit;
begin
  AddStack('TCdrLs.PhoneGetAfterList',Self);
  tf:=de.FldEdit['PHONE']; tf.Value:=oPhone; SetRedraw(tf,rdrwSet);
  DelStack;
end;

procedure TCdrLs.Browl1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var cr: TCursor;
  p: TGridCoord;
begin
	AddStack('TCdrLs.Browl1MouseMove',Self);
  inherited;
  with TBrowl(Sender) do begin
    cr:=crDefault;
    if FindQuery then if Qry.Active then begin
      p:=MouseCoord(X,Y);
      if InRange(p.Y,1,Qry.RecordCount) and (p.X in [nStatus,nPhone]) then cr:=crHandPoint;
    end;
    Cursor:=cr;
  end;
  DelStack;
end;

procedure TCdrLs.Browl1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var p: TPoint;
  r: TDefMenuShow;
begin
	AddStack('TCdrLs.Browl1MouseUp',Self);
  inherited;
  if Button=mbRight then with TBrowl(Sender) do if Cursor=crHandPoint then begin
    p:=ClientOrigin; r.lRect:=false; r.p:=Point(p.X+X,p.Y+Y);
    if MouseCoord(X,Y).X=nStatus then dmStatusExec(@r)
    else if PhoneVisible(Qry.FindField('STATUS').AsInteger)
    then dmPhoneExec(@r);
  end;
  DelStack;
end;

procedure TCdrLs.Browl1BrMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
	AddStack('TCdrLs.Browl1BrMouseDown',Self);
  inherited;
  if Button=mbRight then brCur:=pointer(Sender);
  DelStack;
end;

function TCdrLs.OfisAdd;
var nStatus: byte;
begin
  AddStack('FCdrLs.OfisAdd');
  nStatus:=Cdr['STATUS']; result := oStatus<>nStatus;
  if result then begin
  	Ofis.NewRec; Ofis[fCDR]:=Cdr[fCDR]; Ofis['STATUS']:=nStatus;
    Ofis[fTD]:=DateToString(Now,true); Ofis.AppRec;
    if lLog then with Cdr.FldName('STATUS') do begin
      SetLogVid(logvEditRec);
      nStatus:=OldValue; OldValue:=oStatus; Cdr.LogWriteMod; OldValue:=nStatus;
      SetLogVid;
    end;
  end;
  DelStack;
end;

procedure TCdrLs.dmStatusExec;
var key: longint;
begin
  AddStack('TCdrLs.dmStatusExec',Self);
  if CheckTn then begin
    Cdr.GotoRec(brCur.Qry); key:=K_Beg+byte(CdrStatList(Cdr['STATUS']));
    if dmStatus.Execute(@key,pShow) then begin
      oStatus:=Cdr['STATUS']; Cdr['STATUS']:=key-K_Beg; OfisAdd; Cdr.UpdateRec;
      ETnStatusUpdate(Cdr[fCDR],Cdr['STATUS']); brCur.BrUpdate;
    end;
  end;
  DelStack;
end;

procedure TCdrLs.dmPhoneExec;
var i,key: longint;
  s: string;
begin
  AddStack('TCdrLs.dmPhoneExec',Self);
  if CheckTn then begin
    Cdr.GotoRec(brCur.Qry); deFrmShow(de); dmPhone.Keys.Clear;
    key:=0;
    for i:=0 to PhoneGet.Items.Count-1 do begin
      s:=PhoneGet.Items[i]; dmPhone.InsertKey(K_Beg+i,s);
      if AnsiStartsStr(Cdr['PHONE'],s) then key:=K_Beg+i;
    end;
    if dmPhone.Execute(@key,pShow) then begin
      SetLogVid(logvEditRec);
      Cdr['PHONE']:=PhoneGet.Items[key-K_Beg]; Cdr.UpdateRec(true); brCur.BrUpdate;
      SetLogVid;
    end;
  end;
  DelStack;
end;

procedure TCdrLs.WMRebuild;
begin
  AddStack('TCdrLs.WMRebuild',Self);
  if Message.Oper=rbBefore then
  if Assigned(BrQuery1SEL) then
  if BrQuery1SEL.Visible
  then Browl1.ColWidths[0]:=bmCheckSize.cX+2;
  DelStack;
end;

end.
