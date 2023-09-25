unit FMsgLs;

interface

{$I ORGTEST}
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, ExtCtrls, Menus, DB, DBGrids, Grids,
  MyTypes, My_pr, FRMEMPTY, Keylb, Fpanel, BrQuery, Browl, KeyMenu, RecDB;

type
  TMsgBrowl = class(TBrowl)
  private
    fqRECNO: TIntegerField;
    fqCTD,fqCTD1,fqCTN,fqCKOD,fqNP,fqCTXT: TStringField;
    fqKO,fqTD,fqTD1: TField;
    FBeforeOpen,FCalcFields: TDataSetNotifyEvent;
    oMsgNewRec: TRDBNewRec;
    procedure QryCalcFields(DataSet: TDataSet);
    procedure QryBeforeOpen(DataSet: TDataSet);
    procedure QryAfterScroll(DataSet: TDataSet);
    procedure SetFlt;
    procedure ProcKey(key: Integer; tw: TWinControl);
    procedure MsgProgNewRec(Sender: TRecDB; lcopy: boolean; const gKey: string);
    procedure MsgAnswNewRec(Sender: TRecDB; lcopy: boolean; const gKey: string);
    class function CanDel(Sender: TObject): boolean;
    class procedure DeFltInMsgFrmShow(Sender: TObject);
    class procedure DeFltInMsgFldChange(Sender: TObject; const OldVal: Variant; romShow: Boolean);
    class function DeFltInMsgPnlValid(Sender: TObject): Boolean;
    class procedure SelProcKey(Key: longint; tw: TWinControl);
    class procedure SentRead(Sender: TStringList);
		procedure WMRebuild(var Message: TWMRebuild); message WM_REBUILD;
  protected
    procedure DrawColumnCell(const Rect: TRect; DataCol: longint;
      Column: TColumn; State: TGridDrawState); override;
  public
    fTNFROM,fTNTO: TField;
    LsSel: TIntegerList;
    constructor CreatePrm(AOwner: TComponent; AParent: TWinControl; const ASeekSection,TnCapt,where: string;
      const aArg: array of string; PrBeforeOpen: TDataSetNotifyEvent = nil; PrCalcFields: TDataSetNotifyEvent = nil);
    destructor Destroy; override;
  	procedure DoEnter; override;
  	procedure DoExit; override;
		function GrayCell(const Rect: TRect; DataCol: longint; Column: TColumn;
    	State: TGridDrawState): boolean; override;
  end;

  TMsgLs = class(TFormEmp)
    KeyMenu1: TKeyMenu;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    { Private declarations }
    Browl1: TMsgBrowl;
    procedure BrQuery1CalcFields(DataSet: TDataSet);
		procedure WMFormLimit(var Message: TMessage); message WM_FORMLIMIT;
  public
    { Public declarations }
  end;

var
  MsgLs: TMsgLs;

procedure SelSetKey(tl: TKeyLb);
procedure SelDelKey(tl: TKeyLb);

implementation

{$R *.dfm}

uses StrUtils,
  FrmPswd,MulQry,FFldEdit,DefEdit,Calc,RecVal,DateGet,
  SggUtils,
  OLTypes,OLProc,FDM,FSchemDM;

const aFltInMsg: array[1..3] of string = ('новые','прочитанные','выполненные');
  aFltD: array[boolean] of record
    fMsg,fPer: string;
    aPer: array[boolean] of record
      fCdr,fEnd: string;
    end;
  end =
    ((fMsg:fTD  ; fPer:'VAL1'; aPer:
      ((fCdr:'DBMSG')
      ,(fCdr:'DEMSG' ; fEnd:'1')
      ))
    ,(fMsg:'TD1'; fPer:'VAL2'; aPer:
      ((fCdr:'DB1MSG'; fEnd:'2')
      ,(fCdr:'DE1MSG'; fEnd:'3')
      ))
    );

var bmDoMsg: TBitMap;
  DeFltInMsg: TDefEdit;
  dSent,lSent: longint;
  aSent: TArrStr;

procedure SelSetKey;
begin
  AddStack('FMsgLs.SelSetKey');
  tl.SetKeys([K_Space,K_Ins],'Прочитано','',TMsgBrowl.SelProcKey,'sel',kmList);
  DelStack;
end;

procedure SelDelKey;
begin
  AddStack('FMsgLs.SelDelKey');
  tl.DelKey(K_All,'sel');
  DelStack;
end;

{ TMsgBrowl }
constructor TMsgBrowl.CreatePrm;
var i: longint;
begin
  AddStack('TMsgBrowl.CreatePrm',Self);
  inherited Create(AOwner);
  Parent:=AParent; DataSource:=TDataSource.Create(AOwner);
  FBeforeOpen:=PrBeforeOpen; FCalcFields:=PrCalcFields;
  Qry:=TBrQuery.CreateConnection(Self,nil,DataSource);
  with TBrQuery(Qry) do begin
    SeekSection:=ASeekSection;
    for i:=low(aArg) to high(aArg) do Arg[aArg[i]]:='1';
    Arg['flt']:=sAND+QryNone;
    fqRECNO:=Init(DBMain,[fTD,'TD1'],[fTD],tMSG,[],where+'{flt}','',QryCalcFields);
    CreateStringField('SEL',' ');
    fqCTD:=CreateStringField('CTD','Дата',LenDispDate);
    fqTD:=CreateField(fTD); fqTD.DisplayLabel:='Дата';
    fqTD1:=CreateField('TD1'); fqTD1.DisplayLabel:='Дата получения';
    fqKO:=CreateField(fORG);
    with ProgFld[ofxKOD] do fqCKOD:=CreateStringField(ofvCalc,ofvName,4);
    fqNP:=CreateStringField(fProgNP,'Прог.',3);
    fqCTXT:=CreateStringField('CTXT','Текст',254*2);
    fqCTN:=CreateStringField('CTN',TnCapt,ProgFldDispWidth[ofxTN]);
    fqCTD1:=CreateStringField('CTD1','Дата получения',LenDispDate);
    CreateStringField(fTXT,'Текст').Visible:=false;
    fTNFROM:=CreateField(fMsgTNFROM);
    fTNTO:=CreateField(fMsgTNTO);
    nmf254CreateField(Qry,Msg);
    BeforeOpen:=QryBeforeOpen; AfterScroll:=QryAfterScroll;
  end;
  LsSel:=TIntegerList.Create([ilsSorted]);(* список значений поля SEL, используемый, чтобы не выполнять запрос при каждом нажатии на SPACE, иначе browl update может сместить список на экране, что не очень красиво *)
  DelStack;
end;

destructor TMsgBrowl.Destroy;
begin
  AddStack('TMsgBrowl.Destroy',Self);
  FreeAndNil(LsSel);
  inherited Destroy;
  DelStack;
end;

procedure TMsgBrowl.QryCalcFields;
var tn: string;
begin
  AddStack('TMsgBrowl.QryCalcFields',Self);
  tn:=fTNTO.AsString;
  if tn=Cdr[fCDR] then tn:=fTNFROM.AsString;
  fqCTN.AsString:=CdrGet.CodeName(tn,[cdgBufAll]);
  fqCTXT.AsString:=DelTrim(StrTran(aConcatTxt254(Qry),CRLF,' '));
  fqCTD.AsString:=StringToDispDate(fqTD.AsString,2);
  fqCTD1.AsString:=StringToDispDate(fqTD1.AsString,2);
  fqCKOD.AsString:=ListKod(fqKO.AsInteger);
  IfThenDataSet(FCalcFields,DataSet);
  DelStack;
end;

procedure TMsgBrowl.SetFlt;
var v: string;
  function IsVal(const nmf: string): boolean;
  begin
    AddStack('TMsgBrowl.SetFlt.IsVal',Self);
    v:=Cdr[nmf]; result := not empty(v);
    DelStack;
  end;
var s: string;
  i: byte;
begin
  AddStack('TMsgBrowl.SetFlt',Self);
  s:='';
  if IsVal('FLTINMSG') then for i:=low(aFltInMsg) to high(aFltInMsg) do if not GetByte(v,i) then IncD(s,', '+aFltInMsg[i]);
  fqCTN.Visible:=not IsVal('TNMSG');
  if not fqCTN.Visible then IncD(s,', '+FLow(fqCTN.DisplayLabel)+' '+Trim(CdrGet.CodeName(v)));
  TRbPanel(Parent).Header:=FRup(Copy(s,3,MaxInt));
  DelStack;
end;

procedure TMsgBrowl.QryBeforeOpen;
var v,s,tn: string;
  sa: TArrStr;
  l: longint;
  fl,le: boolean;
begin
  AddStack('TMsgBrowl.QryBeforeOpen',Self);
  IfThenDataSet(FBeforeOpen,DataSet);
  SetFlt;
  v:=NoBytes(Cdr['FLTINMSG']); sa:=nil;
  if GetByte(v,1) then AddFrom(sa,Vtos(false));
  if GetByte(v,2) then AddFrom(sa,Vtos(true));
  if GetByte(v,3) then AddFrom(sa,My_pr.QQs(MSG_DONE));
  l:=length(sa);
  if l in [1..2] then s:=FldInList('SEL',sa) else s:=QryNone(l>0);
  IncAnd(s);
  v:=Cdr['TNMSG'];
  if not empty(v) then begin
    tn:=QQs(Cdr[fCDR]); v:='='+My_pr.QQs(v);
    IncAnd(s,BrackNoEmp(fMsgTNTO+'='+tn+sAND+fMsgTNFROM+v+sOR+fMsgTNTO+'<>'+tn+sAND+fMsgTNTO+v)); //QryCalcFields
  end;
  for fl:=false to true do with aFltD[fl] do
    for le:=false to true do with aPer[le] do begin
      v:=Cdr[fCdr];
      if not empty(v) then IncAnd(s,fMsg+IfThen(le,'<=','>=')+My_pr.QQs(v));
    end;
  l:=Cdr['KOMSG'];
  if l<>0 then begin
    IncAnd(s,fORG+'='+Vtos(l)); v:=Cdr['NPMSG'];
    if not empty(v) then IncAnd(s,fProgNP+'='+My_pr.QQs(v)); 
  end;
  Qry.Arg['flt']:=s;
  Qry.SetPart;
  if Assigned(LsSel) then LsSel.Clear;
  DelStack;
end;

procedure TMsgBrowl.QryAfterScroll;
begin
  AddStack('TMsgBrowl.QryAfterScroll',Self);
  if Assigned(FKeyPanel) then with FKeyPanel do begin
    if (fTNTO.AsString=Cdr[fCDR]) and (fTNFROM.AsString<>fTNTO.AsString)
    then SetKey(K_F3,'Ответить','',ProcKey,'msg',kmList)
    else DelKey(K_F3,'msg');
    ReDrw;
  end;
  DelStack;
end;

procedure TMsgBrowl.WMRebuild;
begin
  AddStack('TMsgBrowl.WMRebuild',Self);
  inherited;
  if ColCount>0 then ColWidths[0]:=bmCheckSize.cX+2;
  DelStack;
end;

procedure TMsgBrowl.DrawColumnCell;
var bm: TBitMap;
  s: string;
  fl: boolean;
  n: longint;
begin
	AddStack('TMsgBrowl.DrawColumnCell',Self);
  inherited DrawColumnCell(Rect,DataCol,Column,State);
	if Assigned(Column.Field) then if Column.FieldName='SEL' then begin
    if LsSel.IntObjFind(fqRECNO.AsInteger,n) then s:=chr(n) else s:=Column.Field.AsString;
    fl := s=MSG_DONE; bm:=nil;
    if fl then begin
      if not Assigned(bmDoMsg) then begin
        bmDoMsg:=TBitMap.Create; bmByName(bmDoMsg,'ORG_DOMSG');
      end;
      bm:=bmDoMsg;
    end
    else fl:=StrToBoolean(s);
    My_pr.bmCheckPaint(Canvas,Rect,fl,bm);
  end;
  DelStack;
end;

function TMsgBrowl.GrayCell;
begin
	AddStack('TMsgBrowl.GrayCell',Self);
  result := fqRECNO.AsInteger=rMsgToZaj;
  DelStack;
end;

procedure TMsgBrowl.DoEnter;
begin
  AddStack('TMsgBrowl.DoEnter',Self);
  if not IsCalculator then begin
    inherited DoEnter;
    if Assigned(FKeyPanel) then with FKeyPanel do begin
      SetKey(K_F4,'Скопировать','',ProcKey,'msg',kmList);
      SetKeys([K_F5,K_Enter],'Редактировать','',ProcKey,'msg',kmList);
      SetKey(K_F7,'Добавить','',ProcKey,'msg',kmList);
      SetKey(K_F8,'Удалить','',ProcKey,'msg',kmList);
      SetKey(K_F12,'Фильтр','',ProcKey,'msg',kmList);
      SetKey(K_Ctrl_X,'В заявку','Перенести сообщение в заявку',ProcKey,'msg',kmList);
      SetKey(K_Ctrl_F4,'','Скопировать сообщение для нескольких пользователей',ProcKey,'msg',kmList);
      SetKey(K_Ctrl_F7,'','Добавить сообщение для нескольких пользователей',ProcKey,'msg',kmList);
      SelSetKey(FKeyPanel);
      QryAfterScroll(nil);
    end;
  end;
  DelStack;
end;

procedure TMsgBrowl.DoExit;
begin
  AddStack('TMsgBrowl.DoExit',Self);
  if not IsCalculator then begin
    if Assigned(FKeyPanel) then begin
      FKeyPanel.DelKey(K_All,'msg');
      SelDelKey(FKeyPanel);
      FKeyPanel.ReDrw;
    end;
    inherited DoExit;
  end;
  DelStack;
end;

procedure TMsgBrowl.ProcKey;
var r,i: longint;
  s: string;
  a: TDEPrmStr;
  av: TDEPrmVar;
  a1: TArrStr;
  oLogKeys: PLogKeysSave;
  fl,le: boolean;
begin
	AddStack('TMsgBrowl.ProcKey',Self);
  if LockRead then try
    if TBrQuery(Qry).CanEdit(Key,[K_F12]) then begin
      oLogKeys:=ProgPswd.PLogKeysLen;
      try
        case Key of
          K_F3,K_F4,K_F7: begin
            oMsgNewRec:=Msg.OnNewRec;
            case Key of
              K_F3: Msg.OnNewRec:=MsgAnswNewRec;
              K_F7: if Owner is TMsgLs then Msg.OnNewRec:=MsgProgNewRec;
            end;
            i:=Row; r:=fqRECNO.AsInteger;
            if AppRec('Добавить сообщение',Msg,DM.deMsg,IfThen(Key<>K_F7,brappCopy),'','',nil,'','','',nil,@fl) then
              if not fl then BrUpdate(i,r);
            Msg.OnNewRec:=oMsgNewRec;
          end;
          K_F5,K_Enter: EditRec('Редактировать сообщение',Msg,DM.deMsg);
          K_F8: begin
            Msg.NewRec; DelAsk(Msg,CanDel,'',nil,true,DM.MsgDel);
          end;
          K_F12: begin
            SetLogVid(logvEditRec); DM.Rec['FLTINMSG']:=NoBytes(Cdr['FLTINMSG']);
            if not Assigned(DeFltInMsg) then begin
              DeFltInMsg:=TDefEdit.Create(Application.MainForm);
              with DeFltInMsg do begin
                FrmCaption:='Фильтр'; NameWnd:='FltInMsg'; PnlSortMode:=smColumns;
                OnFrmShow:=DeFltInMsgFrmShow; OnFldChange:=DeFltInMsgFldChange; OnPnlValid:=DeFltInMsgPnlValid;

                InitArr(av);
                av[deCaption]:='Показать';
                av[deNameRec]:=DM.Rec.NameRec;
                av[deNameRecFld]:='FLTINMSG';
                SchemDM.BoolMultiGet1.AssignGet(av);
                av[deMask]:=ArrayAsList(aFltInMsg,mniDlm);
                av[deAutoSel]:=true;
                av[deNoReadOnly]:=true;
                CreateFld(av);

                av[deNameRec]:=Cdr.NameRec;
                av[deNameRecFld]:='TNMSG';
                CdrGet.AssignGet(av);
                av[deMask]:=cCd0;
                CreateFld(av);

                av[deNameRec]:=DM.Rec.NameRec;
                for fl:=false to true do with aFltD[fl] do begin
                  av[deCaption]:=FRup(Msg.GetPrimFld(fMsg))+':';
                  av[deNameRecFld]:=fPer;
                  SchemDM.MultiGet1.AssignGet(av);
                  av[deMask]:=Int2Str(smRows);
                  CreateFld(av);
                  av[deRelation]:=av[deNameRec]+'.'+av[deNameRecFld];

                  for le:=false to true do with aPer[le] do begin
                    av[deCaption]:=IfThen(le,'по','с');
                    av[deNameRecFld]:='DATE'+fEnd;
                    SchemDM.DateGet1.AssignGet(av);
                    av[deMask]:=cDtWeek;
                    CreateFld(av);

                    av[deCaption]:='';
                    av[deNameRecFld]:='TIME'+fEnd;
                    TTimeCurGet.AssignGetClass(av);
                    av[deMask]:='';
                    CreateFld(av);
                  end;
                  av[deRelation]:='';
                end;

                av[deCaption]:='Клиент'+UnDelim+'(пусто - все)';
                av[deNameRecFld]:='KOD';
                DM.ListGet.AssignGet(av);
                av[deMask]:=cCdName+cCdCod+cCd0;
                CreateFld(av);

                av[deCaption]:='Программа'+UnDelim+'(пусто - все)';
                av[deNameRec]:=Cdr.NameRec;
                av[deNameRecFld]:='NPMSG';
                DM.ProgNpGet.AssignGet(av);
                av[deMask]:=cCd0;
                av[deReadOnlyNoVsbl]:=true;
                av[deWidth]:=wallNoSay;
                CreateFld(av);
              end;
            end;
            DeFltInMsg.Param['TNMSG',deCaption]:=fqCTN.DisplayLabel+UnDelim+'(пусто - все)';
            if DeFltInMsg.Execute.Saved then begin
              r:=Row; i:=fqRECNO.AsInteger; SetFlt; BrUpdate(r,i);
            end;
            SetLogVid;
          end;
          K_Ctrl_F4,K_Ctrl_F7: with DM.deMsg do begin
            SetLogVid(logvAppRec); s:=Fields[0];
            try
              a:=DEGetArrParam('');
              a[deCaption]:='Получатели';
              a[deNameRec]:=DM.Rec.NameRec;
              a[deNameRecFld]:='TNMSG';
              DM.btgCdr.AssignGet(a);
              a[deAutoSel]:=bTrue;
              a[deNoReadOnly]:=bTrue;
              a[deWidth]:=IntToStr(wallNoSay);
              SetArrParam(0,a);
              fl := Key=K_Ctrl_F4;
              if fl then Msg.GotoRec(fqRECNO.AsInteger);
              Msg.NewRec(IfThen(fl,newrCopy)); FrmCaption:='Добавить сообщение для нескольких пользователей';
              if Execute.Saved then begin
                r:=fqRECNO.AsInteger;
                for i:=0 to LsArrDynamic(DM.Rec['TNMSG'],a1,',')-1 do begin
                  SpaceStrSelf(a1[i],lCdrTN);
                  if CdrGet.IsCod(a1[i],[cdgBufAll]) then begin
                    Msg.NewRec([newrCopy,newrNoDoNewRec]);
                    Msg[fMsgTNTO]:=a1[i];
                    Msg.AppRec(true);
                    r:=Msg.RecNo;
                  end;
                end;
                BrUpdate(NegDef,r);
              end;
            finally
              Fields[0]:=s;
            end;
            SetLogVid;
          end;
          K_Ctrl_X: begin
            r:=fqRECNO.AsInteger;
            if r=rMsgToZaj then begin
              rMsgToZaj:=0; Refresh;
            end
            else begin
              rMsgToZaj:=r; MsgToZaj(Self);
            end;
          end;
        end;
      finally
        ProgPswd.PLogKeys:=oLogKeys;
      end;
    end;
  finally
    UnLockRead;
  end;
  DelStack;
end;

procedure TMsgBrowl.MsgProgNewRec;
begin
  AddStack('TMsgBrowl.MsgProgNewRec',Self);
  Sender.DoNewRec(oMsgNewRec,lcopy,gKey);
  Msg[fORG]:=Prog[fORG]; Msg[fProgNP]:=Prog[fProgNP];
  DelStack;
end;

procedure TMsgBrowl.MsgAnswNewRec;
var s: string;
begin
  AddStack('TMsgBrowl.MsgAnswNewRec',Self);
  Sender.DoNewRec(oMsgNewRec,lcopy,gKey);
  s:=Msg[fMsgTNTO]; Msg[fMsgTNTO]:=Msg[fMsgTNFROM]; Msg[fMsgTNFROM]:=s;
  aSplitTxt254(Msg,'['+TrimRight(aConcatTxt254(Msg))+']');
  DelStack;
end;

class function TMsgBrowl.CanDel;
begin
  AddStack('TMsgBrowl.CanDel');
  MsgLogKeysAdd; result:=true;
  DelStack;
end;

class procedure TMsgBrowl.DeFltInMsgFrmShow;
var fl,le: boolean;
begin
  AddStack('TMsgBrowl.DeFltInMsgFrmShow');
  for fl:=false to true do with aFltD[fl] do
    for le:=false to true do with aPer[le] do DM.DateToRec(Cdr,fCdr,fEnd);
  DM.Rec['KOD']:=ListKod(Cdr['KOMSG']);
  DelStack;
end;

class procedure TMsgBrowl.DeFltInMsgFldChange;
var tf: TFldEdit;
  ro: boolean;
begin
  AddStack('TMsgBrowl.DeFltInMsgFldChange');
  tf:=pointer(Sender);
  if tf.NameRecFld='KOD' then begin
    ro:=empty(tf.VarValue); DeFltInMsg.SetReadOnly('NPMSG',ro);
    if not ro then DM.ProgCpGetInit(tf,QryNone(true),DM.ProgNpGet);
  end;
  DelStack;
end;

class function TMsgBrowl.DeFltInMsgPnlValid;
var fl,le: boolean;
  se: string;
begin
  AddStack('TMsgBrowl.DeFltInMsgPnlValid');
  inherited;
  result:=true; LogFields.Clear; Cdr['FLTINMSG']:=NoBytes(DM.Rec['FLTINMSG']);
  for fl:=false to true do with aFltD[fl] do begin
    for le:=false to true do with aPer[le] do
      Cdr[fCdr]:=DateTimeToString(DM.Rec['DATE'+fEnd],DM.Rec['TIME'+fEnd]);
    se:=Cdr[aPer[true].fCdr];
    if not empty(se) then if se<Cdr[aPer[false].fCdr] then begin
      DeFltInMsg.PanelEdit.FldFocus:=DeFltInMsg.FldEdit[
        IfThen(DM.Rec['DATE'+aPer[false].fEnd]=DM.Rec['DATE'+aPer[true].fEnd],'TIME','DATE')+aPer[true].fEnd];
      result:=false; break;
    end;
  end;
  if result then begin
    Cdr['KOMSG']:=Int0(DM.ListGet.CodeDop(DM.Rec['KOD']));
    Cdr.UpdateRec(true);
  end;
  DelStack;
end;

class procedure TMsgBrowl.SelProcKey;
var br: TBrowl;
  msgbr: TMsgBrowl;
  q: TBrQuery;
  fl: boolean;
  s,t: string;
  rn,k,n: longint;
  il: TIntegerList;
  r: TRecDB;
begin
	AddStack('TMsgBrowl.SelProcKey');
  if LockRead then try
    SetLogVid(logvEditRec); br:=pointer(tw);
    if IsClass(br,TMsgBrowl,pointer(msgbr)) then fl := msgbr.fTNTO.AsString=DM.Rec[fCDR] else fl:=true;
    if fl then begin
      q:=pointer(br.Qry); rn:=q.FieldZN(fRECNO); s:=q.FieldZN('SEL');
      if Assigned(msgbr) then begin
        il:=msgbr.LsSel;
        if il.IntObjFind(rn,k,n) then s:=chr(n);
        s:=IfThen(s=MSG_DONE,bFalse,IfThen(s=bTrue,MSG_DONE,bTrue));
        if k<0 then il.Add(rn,pointer(ord(s[1]))) else il.Objects[k]:=pointer(ord(s[1]));
      end
      else s:=bStr[not StrToBoolean(s)];
      t:=q.GetListArg(sTABLE);
      with LsCustomRec do for k:=0 to Count-1 do
        if IsClass(LsCustomRec.Objects[k],TRecDB,pointer(r)) then if r.NameDB=t then begin
          r.GotoRec(rn); r['SEL']:=s; r.UpdateRec(true); break;
        end;
      if GlobTELPATH<>'' then if s=bTrue then begin // При установке статуса сообщения "Прочитано"
        if not GetStrFile(dSent,GlobTELPATH+'отправленные',nil,SentRead) then lSent:=0;
        // если Msg.Recno есть в "отправленные"
        t:=IntToStr(rn);
        if QuickFind(t,aSent,lSent) then begin
          // добавить строку в "прочитанныеУК" Msg.Recno=№ получателя
          if FileExists(GlobTELREAD) then n:=FileBufOpen(GlobTELREAD,fmOpenWrite or fmShareDenyNone) else n:=FileBufCreate(GlobTELREAD);
          if longword(n)<>INVALID_HANDLE_VALUE then begin
            IncD(t,'='+Trim(q.FieldZN(fMsgTNTO))+CRLF); FileSeek(n,0,soFromEnd); FileWrite(n,pointer(t)^,Length(t)); FileClose(n);
          end;
        end;
      end;
      if Assigned(msgbr) then msgbr.Repaint else br.BrUpdate;
      if Key=K_Ins then q.Next;
    end;
    SetLogVid;
  finally
    UnLockRead;
  end;
  DelStack;
end;

class procedure TMsgBrowl.SentRead;
var i: longint;
begin
  AddStack('TMsgBrowl.SentRead');
  lSent:=Sender.Count;
  if Length(aSent)<lSent then SetLength(aSent,lSent);
  for i:=0 to lSent-1 do aSent[i]:=Sender.ValueFromIndex[i];
  QuickSort(aSent,lSent);
  DelStack;
end;

{ TMsgLs }
const aTnArr: TArrBoolStr = ('<-','->');

procedure TMsgLs.FormCreate(Sender: TObject);
const aTnCapt: TArrBoolStr = ('Отправитель','Получатель');
  TnCaptDlm = ' / ';
var s: string;
  fl: boolean;
begin
  AddStack('TMsgLs.FormCreate',Self);
  s:='';
  for fl:=false to true do IncD(s,TnCaptDlm+aTnCapt[fl]+'('+aTnArr[fl]+')');
  Browl1:=TMsgBrowl.CreatePrm(Self,RbPanel2,'MsgProg',Copy(s,Length(TnCaptDlm)+1,MaxInt),
    BrackNoEmp(fMsgTNFROM+'='+QQs(qGlobKey)+sAND+FldIsTrue('DELFROM',false)
    +sOR+fMsgTNTO+'='+QQs(qGlobKey)+sAND+FldIsTrue('DELTO',false))
    +sAND+fORG+'={ko}'+sAND+fProgNP+'='+QQs('{np}'),['ko','np'],nil,BrQuery1CalcFields);
  Browl1.fqCKOD.Visible:=false; Browl1.fqNP.Visible:=false;
  Browl1.fqCTN.Index:=Browl1.fqCTD.Index;
  inherited;
  DelStack;
end;

procedure TMsgLs.FormShow(Sender: TObject);
begin
  AddStack('TMsgLs.FormShow',Self);
  inherited;
  with TBrQuery(Browl1.Qry) do begin
    GlobKey:=Cdr[fCDR]; Arg['ko']:=Prog[fORG]; Arg['np']:=Prog[fProgNP];
  end;
  Browl1.FormShow(Sender);
  DelStack;
end;

procedure TMsgLs.FormHide(Sender: TObject);
begin
  AddStack('TMsgLs.FormHide',Self);
  inherited;
	Browl1.FormHide(Sender);
  DelStack;
end;

procedure TMsgLs.BrQuery1CalcFields;
var tnfrom,tnto,s: string;
begin
  AddStack('TMsgLs.BrQuery1CalcFields',Self);
  tnfrom:=Browl1.fTNFROM.AsString; tnto:=Browl1.fTNTO.AsString;
  if tnfrom=tnto then s:='  ' else s:=aTnArr[tnfrom=Cdr[fCDR]];
  Browl1.fqCTN.AsString:=s+Browl1.fqCTN.AsString;
  DelStack;
end;

procedure TMsgLs.WMFormLimit;
begin
	AddStack('TMsgLs.WMFormLimit',Self);
  inherited;
  FreeLimit(MsgLs);
  DelStack;
end;

procedure LogTrnsValProc(var Prm: TLogTrnsValPrm);
begin
  AddStack('FMsgLs.LogTrnsValProc');
  if LogEqual(Prm,tCDR,'FLTINMSG') then TChkLogCompare.Execute(Prm,aFltInMsg,true);
  DelStack;
end;

initialization
  AddStack('FMsgLs.initialization');
  LogTrnsValProcAdd(LogTrnsValProc);
  DelStack;
end.
