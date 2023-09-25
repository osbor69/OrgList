unit OLGets;

interface

{$I ORGTEST}
uses
  Windows, Messages, Controls, Classes, DB, Math, Clipbrd, SysUtils, Grids, DBGrids,
  MyTypes, My_pr, FDWPrm, MulQry, FFldEdit, DefEdit, Inter, Browl, BrQuery, ChkGets, StrBrowl,
    FPanel, RecVal, RecDB, MultiGet, //SpinGet, PaintCtl,
  ProgType,
  OLTypes, FDM;

type
  TProgFldDef = class(TObject)
  private
    aField: TFieldInd;
  public
    fqRECNO: TField;
    ls: TFldList;
    lsRec: TIntegerList;
    q: TMulQuery;
    adop: TFldArrDop;
    constructor Create;
    destructor Destroy; override;
    class function BeforeForm(Sender: TObject): boolean;
    class procedure AfterForm(Sender: TObject);
    procedure OrdRead(Qry: TMulQuery; const sOrder: string; notForceAcc: boolean=false);
    procedure CalcFields(DataSet: TDataSet);
    procedure FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  end;

  TUpdateSftpKeysOpt = set of (uskToReDrw,uskCheckBrowlActive);

  TProgGet = class(TCustomGet)
  private
    br: TBrowl;
    PrCopyValid: TProcValid;
    deCopy: TDefEdit;
    FirstRecno: longint;
    procedure QryAfterOpen(DataSet: TDataSet);
    function ProgCopyValid(Sender: TObject): boolean;
    function ProgMoveValid(Sender: TObject): boolean;
    class function ProgDel(Sender: TObject): boolean;
    class function deCopyFldCheck(Sender: TObject): Boolean;
    procedure deCopyFldChange(Sender: TObject; const OldVal: Variant; FromShow: Boolean);
    procedure deCopyFrmShow(Sender: TObject);
    procedure deCopyKpProcKey(Key: longint; tw: TWinControl);
    function deCopyPnlValid(Sender: TObject): Boolean;
    procedure BrInf(var ii,tr: longint; lGet: boolean = false);
    function OrdListCreate(lZaj: boolean): TStringList;
    procedure brBoolDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    class procedure DataChange(Sender: TObject; Field: TField);
    class function PrCopyOld(Sender: TObject): boolean;
  protected
    ds: TDataSource;
    procedure CreateObj(tf: TFldEdit); override;
    procedure PaintObj(tf: TFldEdit); override;
    function GetValue(tf: TFldEdit): string; override;
    procedure SetValue(tf: TFldEdit; const v: string); override;
    procedure DoEnter(tf: TFldEdit); override;
    procedure DoExit(tf: TFldEdit); override;
    function MayDoKey(tf: TFldEdit; Key: longint): boolean; override;
  public
    fdef: TProgFldDef;
    lFlt,qFiltered,FShowSftpKeys,lInterFlt: boolean;
    Qry: TBrQuery;
    Inter: TInter;
    Status: TRbStatus;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function RestValType: TGetRestValType; override;
    class function GetProgGet(aDs: TDataSource; out aPg: TProgGet): boolean;
    procedure OrderList(var a: TArrStr; var l: longint; lZaj: boolean = false);
    function GetMask(lZaj: boolean = false): string;
    procedure OrdRead(lUpd: boolean = true);
    procedure BrUpdate(lUpd: boolean = true);
    procedure QryBeforeOpen(DataSet: TDataSet);
    procedure ProcKey(Key: longint; tw: TWinControl);
    procedure UpdateSftpKeys(Opt: TUpdateSftpKeysOpt);
    function Ord2Mem(const s: string; lZaj: boolean): string;
    function Mem2Ord(const s: string; lZaj: boolean): string;
  end;

  TTblChkOrdVal = class(TComponent)
  private
    aord: TArrInt;
  end;

  TTblChkOrdGet = class(TTblChkGet)
  private
    flOrdMove: boolean;
    OrdIndex: longint;
    procedure OrdMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
      X, Y: longint);
    procedure OrdMouseMove(Sender: TObject; Shift: TShiftState; X,Y: longint);
    procedure OrdMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
      X, Y: longint);
    procedure Move(tbl: TStrTable; oi,ni: longint);
    procedure PrMove(oY,nY: longint; const av: array of variant);
    procedure MoveProcKey(key: longint; tw: TWinControl);
  protected
    Val: TTblChkOrdVal;
    procedure CreateObj(tf: TFldEdit); override;
    function GetValue(tf: TFldEdit): string; override;
    procedure SetValue(tf: TFldEdit; const v: string); override;
    procedure DoEnter(tf: TFldEdit); override;
    procedure DoExit(tf: TFldEdit); override;
    function MayDoKey(tf: TFldEdit; Key: longint): boolean; override;
    function AssignObj(tf: TFldEdit): boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    class procedure GetOrd(var aord: TArrInt; cntRow,cntCol: longint; const v: string);
  end;

  TProgSelGet = class(TMultiGet)
  private
		procedure fKodChange(Sender: TObject; const OldVal: Variant; FromShow: boolean);
  protected
  	Rec: TRecVal;
  	fKod,fProg: TFldEdit;
		procedure CreateObj(tf: TFldEdit); override;
    procedure ReCreateObj(tf: TFldEdit); override;
    function GetValue(tf: TFldEdit): string; override;
    procedure SetValue(tf: TFldEdit; const v: string); override;
    function AssignObj(tf: TFldEdit): boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TOrdList = class(TIntegerList)
  private
    aRec: array of TOrdRec;
  public
    constructor Create;
    function AddRec(Value: LongInt): POrdRec;
    function GetRec(Index: LongInt): POrdRec;
  end;

  TTimeGet = class(TSimpleGet)
  protected
  	procedure CreateObj(tf: TFldEdit); override;
    function GetValue(tf: TFldEdit): string; override;
    procedure SetValue(tf: TFldEdit; const vv: string); override;
    function Check(tf: TFldEdit): boolean; override;
		procedure DispValue(tf: TFldEdit); override;
    function MayDoKey(tf: TFldEdit; Key: longint): boolean; override;
		function DWFldUnAllowType(const Mask: string): TDWFldSetType; override;
  public
		constructor Create(AOwner: TComponent = nil); override;
  end;

var
  aProgFld: array[boolean] of TFldEdit;

function ProgGet(lFlt: boolean = true): TProgGet;

implementation
{$B-}

uses
  Forms, StrUtils, Variants, DBTables, ShellApi, FIBDatabase, DateUtils,
  FDWVid, MenuGet, CodeGets, KeyLb, KeyMenu, FrmPswd, Schem, Askp, GGMReg, FStat,
    FSchemDM, DirGet, Shifr, GGI,
  SggUtils, FSGWMain, SftpDir, FbServices,
  FCopyLs,
  FAccLs, FZajLs, FFltLs, FMsgLs, OLProc;

const
  KLP_PROGGET = 'progget';

type
  TTblChkOrdLogCompare = class(TDlmLogCompare)
  public
    class function ListCreate(pv: pointer; const Value: string; lNew: boolean): pointer; override;
    class procedure ListDestroy(pv,ls: pointer); override;
    class function GetCount(pv,ls: pointer): longint; override;
    class procedure GetItem(var Prm: TLogTrnsValPrm; pv,lso,lsn: pointer; no,nn: longint; tp: TLogCompareItemList); override;
    class procedure Execute(var Prm: TLogTrnsValPrm; Opt: TDEFltOpt); overload;
  end;

function ProgGet;
begin
  result:=pointer(aProgFld[lFlt].curget);
end;

procedure TProgFldDef.OrdRead;
var i,j,k,l,n,la: longint;
  aoTo: TArrInt;
  lsf: TOrdList;
  p: POrdRec;
  r: TDWVidRec;
  s: string;
  b: boolean;
  a: TArrStr;
begin
	AddStack('TProgFldDef.OrdRead');
  ls.Clear;
  with Prog do for i:=0 to FldDef.Count-1 do ls.Add(DWVarName(DWSToRec(i).Name));
  ls.Fill;
  if (not empty(Cdr[fCDR])) then begin
    TTblChkOrdGet.GetOrd(aoTo,ofxCnt+ls.Count,1,sOrder);
    j:=0;
    lsf:=TOrdList.Create;
    try
      Qry.Arg[sC_LIST]:='KOD';
      TRecDBDef.AddCList(Prog,Qry,false);
      Qry.PartSelect(Qry.GetList([tPROG,tORG]),'',tPROG+'.'+fORG+'='+tORG+'.'+fORG,Qry.Arg[sO_LIST],'',false);
      while Qry.FieldCount > 0 do Qry.Fields[0].Free;
      Qry.FieldDefs.Update;
      for i:=1 to ofxCnt do begin
        b:=GetByte(sOrder,aoTo[i-1]+1);(* выводить данное *)
        if (b)or((i=ofxAcc)and(not notForceAcc)) then with ProgFld[i] do begin
          p:=lsf.AddRec(aoTo[j]);
          p^.nmf:=ofvFld;
          if (p^.nmf='') then p^.f:=nil
          else p^.f:=Qry.CreateField(p^.nmf,(b)and({not IsProgFldCalc[i]}ofvCalc=''));
          s:=StrTran(ofvName,UnDelim,' ',[rfReplaceAll,rfIgnoreCase]);
          if (p^.f<>nil) then p^.f.DisplayLabel:=s;
          if ({not IsProgFldCalc[i]}ofvCalc='') then p^.f.DisplayWidth:=ProgFldDispWidth[i]
          else p^.f:=Qry.CreateStringField(ofvCalc,s,ProgFldDispWidth[i]);
        end;
        Inc(j);
      end;
      fqRECNO:=Qry.CreateIntegerField(fRECNO);
      fqRECNO.Visible:=false;
      TFldList.BrDop(Qry,Prog,adop); q:=Qry;
      ls.Clear;
      with Prog do for i:=0 to FldDef.Count-1 do ls.Add(DWVarName(DWSToRec(i).Name));
      ls.BrCreate(Qry,adop,[fldcNoAddCList]);
      SetLength(aField,ls.Count);
      l:=0;
      for i:=0 to ls.Count-1 do begin
        if (GetByte(sOrder,aoTo[ofxCnt+i]+1)) then begin
          aField[l].f:=ls.BrCreate(i,Qry);
          aField[l].i:=i;
          p:=lsf.AddRec(aoTo[j]);
          p^.f:=aField[l].f;
          with Prog do for k:=0 to FldDef.Count-1 do begin
            r:=DWSToRec(k);
            if (TrimUpper(r.Name)<>TrimUpper(ls[i])) then continue;
            s:=Prog.FixSt(aDWVidBeg[aFixTypeCod[r.SvType,r.AType]]);
            if r.AType=dwtManyStr then begin
              la:=LsArrDynamic(r.dwCod,a,',');
              for n:=0 to la-1 do IncL(a[n],s);
              p^.nmf:=ArrayAsList(a,',',la);
            end
            else p^.nmf:=s+r.dwCod;
            break;
          end;
          Inc(l);
        end;
        Inc(j);
      end;
      SetLength(aField,l);
      Qry.Arg[sO_LIST]:=''; s:=QQs('1');
      for i:=0 to lsf.Count-1 do  begin
        p:=lsf.GetRec(i); Qry.AddArgList(sO_LIST,ReplVar(p^.nmf,s)); p^.f.Index:=i;
      end;
    finally
      lsf.Free;
    end;
  end;
  DelStack;
end;

procedure TProgFldDef.CalcFields;
var i: longint;
  Qry: TMulQuery;
  oProg: TRecDBDef;
begin
	AddStack('TProgFldDef.CalcFields');
  oProg:=Prog;
  Prog:=DM.RProgCalc;
  try
    DM.qProgCalcFields(DataSet);
    Qry:=MulQueryOwner(DataSet);
    Prog.GetFromQuery(Qry,false);
    TFldList.BrDopCalc(Qry,adop);
    for i:=low(aField) to high(aField) do ls.BrCalc(aField[i].f,adop,aField[i].i);
  finally
    Prog:=oProg;
  end;
  DelStack;
end;

procedure TProgFldDef.FilterRecord;
begin
  AddStack('TProgFldDef.FilterRecord');
  Accept := lsRec.IndexOf(fqRECNO.AsInteger)<0;
  DelStack;
end;

class function TProgFldDef.BeforeForm;
begin
  AddStack('TProgFldDef.BeforeForm');
  InitArr(aFltCur);
  result:=true;
  DelStack;
end;

class procedure TProgFldDef.AfterForm;
begin
  AddStack('TProgFldDef.AfterForm');
  if Assigned(qList) then qList.Close;
  if Assigned(qProg) then qProg.Close;
  if Assigned(qZaj) then qZaj.Close;
  lListOpen:=false;
  DelStack;
end;

constructor TProgFldDef.Create;
begin
	AddStack('TProgFldDef.Create');
  ls:=TFldList.Create;
  lsRec:=TIntegerList.Create([ilsSorted]);
  DelStack;
end;

destructor TProgFldDef.Destroy;
begin
	AddStack('TProgFldDef.Destroy');
  inherited Destroy;
  if Assigned(q) then TFldList.BrFree(q,adop);
  ls.Free; lsRec.Free;
  DelStack;
end;

procedure TProgGet.BrUpdate;
var ii,tr: longint;
begin
  AddStack('TProgGet.BrUpdate',Self);
  with Qry do begin
    if lUpd then BrInf(ii,tr,true);
    if lFlt	then qSetWhere(br,tPROG+'.'+fORG+'='+tORG+'.'+fORG,'FLT','',Inter,TRbPanel(aProgFld[lFlt].Parent),nil,
    	[fCDR],[fORG],[fProgKP],qFiltered,fdef.lsRec)
    else Arg[sWHERE]:=tPROG+'.'+fORG+'='+tORG+'.'+fORG+sAND+fORG+'='+VTos(List[nmfbKO])
    	+IfThen(empty(Cdr['ORGKOD']),sAND+fCDR+'='+QQs(DM.Rec[fCDR]));
    if lUpd then BrInf(ii,tr);
  end;
  DelStack;
end;

constructor TProgGet.Create;
var av: TDEPrmVar;
begin
	AddStack('TProgGet.Create',Self);
  lInterFlt:=true;
  fdef:=TProgFldDef.Create;
  deCopy:=TDefEdit.Create(Self);
  with deCopy do begin
    InitArr(av);
    av[deCaption]:='Новое расположение программы:';
    av[deNameRec]:=DM.Rec.NameRec;
    av[deNameRecFld]:='VAL1';
    SchemDM.MultiGet1.AssignGet(av);
    av[deNoReadOnly]:=true;
    av[deWidth]:=wallDefault;
  	CreateFld(av);

    av[deCaption]:='диск';
    av[deNameRecFld]:='COPYND';
    DM.DrvGet.AssignGet(av);
    av[deMask]:=cCdName+cCdCod;
    av[deAutoSel]:=true;
    av[deRelation]:=DM.Rec.NameRec+'.VAL1';
    av[deWidth]:=0;
  	CreateFld(av);

    av[deCaption]:='папка';
    av[deNameRecFld]:='COPYDIR';
    DM.DirGet1.AssignGet(av);
    av[deMask]:='';
    av[deWidth]:=wallNoSay;
  	CreateFld(av);

    av[deCaption]:='';
    av[deNameRecFld]:='COPYPROG';
    SchemDM.BoolGet1.AssignGet(av);
    av[deMask]:='Создать учётную запись';
    av[deRelation]:='';
    av[deWidth]:=0;
  	CreateFld(av);

    with ProgFld[ofxSTATUS] do begin
      av[deCaption]:='Статус';
      av[deNameRecFld]:='COPYSTATUS';
      av[deVid]:=ofvVid;
      av[deVName]:=ofvVName;
      av[deMask]:=ofvMask;
      av[deReadOnlyNoVsbl]:=true;
      CreateFld(av);
    end;

    NameWnd:='ProgCopy'; NmProc.Text:=TKeyLb.GetKeySt(K_Ctrl_B); OnKpProcKey:=deCopyKpProcKey;
    OnFldCheck:=deCopyFldCheck; OnFldChange:=deCopyFldChange;
    OnFrmShow:=deCopyFrmShow; OnPnlValid:=deCopyPnlValid;
  end;
  Inter:=TInter.Create('Формула фильтра (программы)');
  with Inter do begin
  	ShowError:=false; value_types:='L';
  end;
  inherited Create(AOwner);
  DelStack;
end;

destructor TProgGet.Destroy;
begin
	AddStack('TProgGet.Destroy',Self);
  inherited Destroy;
  fdef.Free; Inter.Free;
  DelStack;
end;

procedure TProgGet.CreateObj;
begin
	AddStack('TProgGet.CreateObj',Self);
  DestroyObj(tf);
  br:=TBrowl.Create(tf);
  with br do begin
    Parent:=tf;
    CloseOnSelect:=False;
    ReadOnly:=True;
    Options:=[dgTitles,dgColumnResize,dgColLines,dgRowLines,dgRowSelect];
    OnDrawColumnCell:=brBoolDrawColumnCell;
  end;
  ds:=TDataSource.Create(tf);
  Qry:=TBrQuery.CreateConnection(tf,nil,ds);
  br.DataSource:=ds;
  ds.OnDataChange:=DataChange;
  Qry.OnCalcFields:=fdef.CalcFields;
  Qry.OnFilterRecord:=fdef.FilterRecord;
  Qry.AfterOpen:=QryAfterOpen;
  inherited CreateObj(tf);
  DelStack;
end;

class function TProgGet.GetProgGet;
var b: boolean;
begin
  result:=false;
  for b:=false to true do begin
    aPg:=ProgGet(b);
    if Assigned(aPg) then if aPg.ds=aDs then begin
      result:=true; break;
    end;
  end;
end;

procedure TProgGet.UpdateSftpKeys;
var kl: TKeyLb;
begin
  if not (uskCheckBrowlActive in Opt)or(Screen.ActiveControl=br) then begin
    kl:=FormKeyLb(aProgFld[lFlt]);
    if (FShowSftpKeys) then begin
      kl.SetKey(K_CTRL_G,'Сообщение(инт.)','Отправить сообщение по программе',ProcKey,KLP_PROGGET,kmList);
      kl.SetKey(K_CTRL_E,'Отправить файл','',ProcKey,KLP_PROGGET,kmList);
      kl.SetKey(K_CTRL_O,'','Интернет файлы',ProcKey,KLP_PROGGET,kmList);
    end else begin
      kl.DelKey(K_CTRL_G,KLP_PROGGET);
      kl.DelKey(K_CTRL_E,KLP_PROGGET);
      kl.DelKey(K_CTRL_O,KLP_PROGGET);
    end;
    if uskToReDrw in Opt then kl.ReDrw;
  end;
end;

procedure TProgGet.BrInf;
begin
  AddStack('TProgGet.BrInf',Self);
  with Qry do begin
    if lGet then begin
      ii:=0; tr:=br.Row;
      if Assigned(Qry) then
        if Qry.Active then begin
	        ii:=fdef.fqRECNO.AsInteger; Close;
        end;
    end
    else if ii=0 then Open
    {begin
    	SeekKeys:=sSeekKeys; Open; SeekKeys:='';
    end}
    else br.BrUpdate(tr,ii);
  end;
  DelStack;
end;

procedure TProgGet.PaintObj;
begin
	AddStack('TProgGet.PaintObj',Self);
  br.Color:=tf.Color1(SchemName(tf.Schem));
  br.SetBounds(BevelFld,BevelFld,tf.Width-BevelFld2,tf.Height-BevelFld2);
  DelStack;
end;

function TProgGet.GetValue;
begin
	result:='';
end;

procedure TProgGet.SetValue;
begin
end;

function TProgGet.MayDoKey;
begin
  AddStack('TProgGet.MayDoKey',Self);
  result:=inherited MayDoKey(tf,Key);
  if result then case Key of
    K_PgUp,K_PgDn,K_Down: result:=false;
    K_Up: result := not lFlt and (Qry.FieldZN(fRECNO)=FirstRecno);
  end;
  DelStack;
end;

class function TProgGet.RestValType;
begin
  result:=grvNone;
end;

procedure TProgGet.DoEnter;
begin
  AddStack('TProgGet.DoEnter',Self);
  inherited DoEnter(tf);
  GetParentForm(tf).ActiveControl:=br; //br.BrUpdate;
  Qry.Open;
  with FormKeyLb(aProgFld[lFlt]) do begin
    SetKey(K_Enter,'','Выполнить',ProcKey,KLP_PROGGET,kmList);
    SetKey(K_Shift_Enter,'','Установка с учётом рег.номера',ProcKey,KLP_PROGGET,kmList);
    SetKey(K_Shift_F2,'','Сообщения по программе',ProcKey,KLP_PROGGET,kmList);
    SetKey(K_F3,GetPrim(tZAJ),'Заявки по программе',ProcKey,KLP_PROGGET,kmList);
    SetKey(K_Shift_F3,'','Сменить вид, номер клиента или рег.N',ProcKey,KLP_PROGGET,kmList);
    SetKey(K_Alt_F3,'','Сменить статус, перенести заявки на др.программу',ProcKey,KLP_PROGGET,kmList);
    SetKey(K_Alt_E,'','Сменить расширение базы данных',ProcKey,KLP_PROGGET,kmList);
    SetKey(K_F4,'','Скопировать',ProcKey,KLP_PROGGET,kmList);
    SetKey(K_Ctrl_F4,'','Скопировать в другую папку',ProcKey,KLP_PROGGET,kmList);
    SetKey(K_F5,'','Редактировать',ProcKey,KLP_PROGGET,kmList);
    SetKey(K_Alt_R,'','Редактировать без обновления списка',ProcKey,KLP_PROGGET,kmList);
    SetKey(K_ALT_F5,'','Уч.запись для входа в программу',ProcKey,KLP_PROGGET,kmList);
    SetKey(K_Ctrl_F5,'','Перенести в другую папку',ProcKey,KLP_PROGGET,kmList);
    SetKey(K_F7,'','Добавить',ProcKey,KLP_PROGGET,kmList);
    SetKey(K_F8,'','Удалить',ProcKey,KLP_PROGGET,kmList);
    SetKey(K_Ctrl_F8,'','Удалить вместе с папкой',ProcKey,KLP_PROGGET,kmList);
    SetKey(K_SHIFT_F8,'','Удалить только папку',ProcKey,KLP_PROGGET,kmList);
    SetKey(K_Shift_O,'','Перейти в папку',ProcKey,KLP_PROGGET,kmList);
    SetKey(K_F12,'Данные','Выводимые данные по программе и их порядок просмотра',ProcKey,KLP_PROGGET,kmList);
    if lFlt then SetKey(K_Ctrl_F12,'','Просмотр всех программ',ProcKey,KLP_PROGGET,kmList);
    SetKey(K_Ctrl_F7,'Заявка','Добавить заявку',ProcKey,KLP_PROGGET,kmList);
    SetKey(K_Shift_F5,'Исполнение без заявки','Добавить исполнение без заявки',ProcKey,KLP_PROGGET,kmList);
    SetKey(K_Shift_F7,'Заявка с исполнением','Добавить заявку с исполнением',ProcKey,KLP_PROGGET,kmList);
    SetKey(K_Ctrl_D,'Сообщение','Добавить сообщение по программе',ProcKey,KLP_PROGGET,kmList);
    SetKey(K_Ctrl_P,'','Упаковать данные',ProcKey,KLP_PROGGET,kmList);
    SetKey(K_Ctrl_S,'','Корректировка структуры данных',ProcKey,KLP_PROGGET,kmList);

    SetKey(K_CTRL_U,'','Упаковка',ProcKey,KLP_PROGGET,45);
    SetKey(K_CTRL_K,'','Проверка и исправление',ProcKey,KLP_PROGGET,45);
    SetKey(K_CTRL_T,'','Удаление регистрационной таблицы',ProcKey,KLP_PROGGET,45);

    UpdateSftpKeys([]);
    DelKeys([K_PgUp,K_PgDn]);
    Redrw;
  end;
  DelStack;
end;

procedure TProgGet.DoExit;
begin
  AddStack('TProgGet.DoExit',Self);
  with FormKeyLb(aProgFld[lFlt]) do begin
    DelKey(K_All,KLP_PROGGET); Redrw;
  end;
  Qry.BeforeOpen:=nil;
  inherited DoExit(tf);
  DelStack;
end;

function TProgGet.Ord2Mem;
var aord,aord1: TArrInt;
  i: longint;
begin
  AddStack('TProgGet.Ord2Mem',Self);
  result:=DlmCopy(s,1,1,'/');
  with OrdListCreate(lZaj) do try
    TTblChkOrdGet.GetOrd(aord,Count,1,s);
    SetLength(aord1,Count); SetMemory(@aord1[0],Count*SizeOf(aord1[0]));
    for i:=0 to Count-1 do aord1[aord[i]]:=i;
    for i:=0 to Count-1 do IncD(result,IfThen(i=0,'/',',')+Strings[aord1[i]]);
  finally
    Free;
  end;
  DelStack;
end;

function TProgGet.Mem2Ord;
var a: array[1..2] of string;
  aord: TArrStr;
  i,j,l: longint;
  ls: TStringList;
begin
  AddStack('TProgGet.Mem2Ord',Self);
  LsArrFill(s,a,'/'); result:=a[1]; l:=LsArrDynamic(a[2],aord,','); ls:=OrdListCreate(lZaj);
  with ls do try
    i:=0;
    while i<l do begin
      j:=IndexOf(aord[i]);
      if j<0 then begin
        for j:=i+1 to l-1 do aord[j-1]:=aord[j];
        Dec(l); System.Delete(result,i+1,1);
      end
      else begin
        Inc(i); Objects[j]:=pointer(i);
      end;
    end;
    for j:=0 to Count-1 do begin
      if Assigned(Objects[j]) then l:=IntObj(ls,j)
      else begin
        Inc(i); l:=i;
      end;
      IncD(result,StrNum(IfThen(j=0,'/',','),l));
    end;
  finally
    Free;
  end;
  DelStack;
end;

function TProgGet.OrdListCreate;
var i,l: longint;
  adef: TArrStr;
begin
  AddStack('TProgGet.OrdListCreate',Self);
  result:=TStringList.Create;
  with result do begin
    BeginUpdate;
    l:=LsArrDynamic(Glob[sMemo+'PROGD'],adef,CRLF);
    Capacity:=IfThen(lZaj,ofzCnt)+ofxCnt-IfThen(lFlt,1)+l;
    if lZaj then for i:=1 to ofzCnt do with aOrdFixz[i] do
      Add(ofzvTbl+'.'+ReplVar(ofzvFld,ofzvCalc));
    for i:=1+IfThen(not lFlt,1) to ofxCnt do with ProgFld[i] do
      Add(ofvTbl+'.'+ReplVar(ofvFld,ofvCalc));
    for i:=0 to l-1 do Add(Prog.DWVarName(DWSToRec(adef[i]).Name));
    EndUpdate;
  end;
  DelStack;
end;

procedure StfpLogProc(Oper: TSftpLogOper; const FileName: TFileName);
begin
  AddStack('OLGets.StfpLogProc');
  case Oper of
    slogBeg: SetLogVid(logvSendFile);
    slogWrite: Prog.LogWrite(Prog.LogPrim+LogDlm+'файл:"'+FileName+'"');
    slogEnd: SetLogVid;
  end;
  DelStack;
end;

procedure TProgGet.ProcKey;
	procedure ProgGotoRec;
  var f: TField;
  begin
    AddStack('TProgGet.ProcKey.ProgGotoRec',Self);
    if FormKeyLb(tw).SeekKey(Key).NmParent=KLP_PROGGET
    then f:=fdef.fqRECNO
    else f:=qZajMain.FindField(qZajMain.FldDuplicate(fRECNO));
    Prog.GotoRec(f); ProgLogKeysAdd;
    DelStack;
  end;
  function CheckUndoneMsg(aProgKo: longint; const aProgNp: string): boolean;
  var mq: TMulQuery;
  begin
    mq:=ProgPswd.GetQuery;
    try
      mq.PartSelect(mq.GetList([tMSG,tCDR]),[fMsgTNFROM,fMsgTNTO],
        ArrayAsList([tCDR+'.'+fCDR+'='+tMSG+'.'+fMsgTNTO,FldIsTrue(tCDR+'.OUT',false),
        tMSG+'.'+fORG+'='+Vtos(aProgKo),tMSG+'.'+fProgNP+'='+QQs(aProgNp),tMSG+'.SEL<>'+QQs(MSG_DONE)],sAND));
      result:=mq.Eof;
      if not result then mess_ok(['По данной программе есть невыполненные сообщения.',
        'Отправитель: '+Trim(CdrGet.Codest(mq.Fields[0].AsString)),
        'Получатель: '+Trim(CdrGet.Codest(mq.Fields[1].AsString))]);
    finally
      ProgPswd.FreeQuery;
    end;
  end;
const aStat: array[0..1] of longint = (byte(stpMain),byte(stpLast));
var d2,s,t,dsk,d1,aPort: string;
  dir: TFileName;
  fl,lCng: boolean;
  i,l: longint;
  n: byte;
  fzf: TFld;
  j: TOrdFixzList;
  ls1: TStringList;
  fz: TField;
  f: TIniFileCheck;
  pt: TProgType;
  oe,ne: TInterbaseExt;
  oLogKeys: PLogKeysSave;
  fltOpt: TDEFltOpt;
  zvOpt: TZajVsblOpt;
  p2r: TPrep2RunOpt;
  fEdit: TObject;
  br0: TBrowl;
  afio: array[1..3] of string;
begin
  AddStack('TProgGet.ProcKey',Self);
  if Qry.CanEdit(Key,[K_F12,K_Ctrl_F12]) then if LockRead then try
    oLogKeys:=ProgPswd.PLogKeysLen;
    try
      lCng:=false; fEdit:=ProgEdExec(Key,lFlt);
      case Key of
        K_F3: begin
          if CreateForm(TZajLs,ZajLs) then with ZajLs do begin
            with BrQuery1 do begin
              OnCalcFields:=TDM.ZajCalcFields;
              for i:=0 to qZajMain.FieldCount-1 do with qZajMain.Fields[i] do begin
                fz:=nil; l:=Size;
                case FieldKind of
                  fkData: if Zaj.IsField(FieldName) then fz:=CreateField(FieldName);
                  fkCalculated: for j:=1 to ofzCnt do with aOrdFixz[j] do if FieldName=ofzvCalc then begin
                    if ofzvBeg then begin
                      l:=0; n:=1;
                      repeat
                        if not Zaj.FldName(nmf254(n,ofzvFld),fzf) then break;
                        Inc(l,fzf.Info.Size); Inc(n);
                      until false;
                      fz:=CreateStringField(FieldName,DisplayLabel,l); fz.DisplayWidth:=DisplayWidth;
                    end
                    else fz:=CreateStringField(FieldName,DisplayLabel,DisplayWidth);
                    break;
                  end;
                end;
                if Assigned(fz) then begin
                  fz.Visible := Visible or AnsiStartsStr('CISP',fz.FieldName) or (fz.FieldName='CTISPD');
                  fz.DisplayLabel:=DisplayLabel;
                  if fz.Visible then begin
                    fz.Size:=l; fz.DisplayWidth:=DisplayWidth;
                    if fz is TDateTimeField
                    then TDateTimeField(fz).DisplayFormat:=TDateTimeField(qZajMain.Fields[i]).DisplayFormat;
                  end;
                end;
              end;
            end;
            Browl1.OnGrayCell:=TDM.brZajGrayCell; Browl1.OnDrawColumnCell:=TDM.brZajDrawColumnCell;
            ZajEdSetKey(ZajLs.KeyLb1,ZajEdProcKey);
            SelSetKey(ZajLs.KeyLb1);
          end;
          ProgGotoRec;
          with ZajLs do begin
            BrQuery1.Arg[sWHERE]:=fORG+'='+Vtos(Prog[fORG])+sAND+fProgCP+'='+QQs(Prog[fProgCP]);
            ShowModal;
          end;
        end;
        K_F4,K_F5,K_F7,K_Alt_R: begin
          Prog.NewRec;
          case Key of
            K_F4,K_F7: begin
              if not lFlt and (Key=K_F7) then Prog[fORG]:=DM.ListGet.CodeDop(Cdr['ORGKOD']);
              lCng:=br.AppRec('Добавить программу',Prog,fEdit,[brappCopy]+IfThen(Key<>K_F4,brappNoGoRecCopy));
            end;
            K_F5: lCng:=br.EditRec('Редактировать программу',Prog,fEdit);
            K_Alt_R: begin
              ProgGotoRec; br0:=nil; br0.EditRec('Редактировать программу',Prog,fEdit);
            end;
          end;
        end;
        K_F8,K_Ctrl_F8: begin
          ProgGotoRec;
          if CheckUndoneMsg(Prog[fORG],Prog[fProgNP]) then
            if ProgPswd.PartCount0(tZAJ,fORG+'='+Vtos(Prog[fORG])+sAND+fProgCP+'='+QQs(Prog[fProgCP]))
            then begin
              d2:=fORG+'='+Vtos(Prog[fORG])+sAND+fProgNP+'='+QQs(Prog[fProgNP]);
              case Key of
                K_F8: lCng:=br.DelAsk(Prog);
                K_Ctrl_F8: begin
                  Write_SET_XXX_Ini(dir);
                  lCng:=br.DelAsk(Prog,ProgDel,'Удалить программу вместе с папкой ?')
                end;
              end;
              if (lCng) then Msg.UpdateTable([fProgNP],[QQs],d2);
            end
            else meserr('По данной программе есть заявки.');
        end;
        K_F12: begin
          s:=sMemo+'ORD'+afOrd[lFlt]; dsk:=Cdr[s];
          if lFlt then fltOpt:=[fltFlt] else fltOpt:=[fltOnlyOrd];
          if deFltExec('Данные по программе','FLT',s,'ORD'+afOrd[lFlt],fltOpt) then begin
            OrdRead;
            if not lFlt and (Cdr[s]<>dsk) then ZajLoaded:=false;
          end;
        end;
        K_Enter,K_CTRL_K,K_Ctrl_P,K_Ctrl_S,K_CTRL_U,K_Ctrl_T: begin
          ProgGotoRec;
          pt:=ProgTp;
          if ((Key=K_Enter)or(pt.lWin))and(pt.sid<>'') then begin
            if Key=K_Enter then p2r:=[p2rRunMode] else p2r:=[];
            if Prepare2RunProg(dir,pt,p2r) then begin
              if Key=K_Enter then begin
                SetLogVid(logvExec); s:='';
                if (not pt.lWin) then begin
                  ls1:=TStringList.Create;
                  try
                    d1:=GetRegKey(HKEY_LOCAL_MACHINE,REGSTR_PATH_GGMASTER,REGSTR_KEY_GGMASTER);
                    if not empty(d1) then begin
                      CorrDirSelf(d1); f:=TIniFileCheck.Create(d1+GGMasterIniFile,nil,[finiNoDelOld],GGMasterExeFile);
                      try
                        f.ReadSectionValues(GGMUtilSect,ls1);
                        for i:=0 to ls1.Count-1 do begin
                          ls1[i]:=ls1.ValueFromIndex[i];
                          d2:=GGMUtilSectBeg+ls1[i];
                          dsk:=f.ReadString(d2,'UserDir',f.ReadString(d2,'Dir'));
                          if empty(ExtractFileDrive(dsk)) then IncL(dsk,d1);
                          IncD(ls1,i,ls1.NameValueSeparator+CorrDir(dsk));
                        end;
                      finally
                        f.Free;
                      end;
                    end;
                    TProgCopy.UtePathIniSave(dir,ls1);
                  finally
                    ls1.Free;
                  end;
                end else begin
                  t:=TrimRight(Prog['PUNAME']);
                  if (t<>'') then begin
                    s:='USNM='+t+' PSWD='+TrimRight(DeshifrStr(Prog['PUPASS']));
                  end;
                end;
                Prog[ProgFld[ofxDLast].ofvFld]:=NowDouble; Prog.UpdateRec; Prog.LogWrite;
                LsArrFill(DelTrim(Cdr[fNAME]),afio,' ');
                ShellExecute(0,nil,PChar(dir+ExeMenu),
                  PChar(DlmBetween(s,PrmAutor+'='+StrToChar(afio[2])+StrToChar(afio[3]),' ')),
                  PChar(CorrDir(dir,crdrNoDlmEnd)),SW_SHOW);
                lInterFlt:=false; br.BrUpdate; lInterFlt:=true;
              end else begin
                Write_SET_XXX_Ini(dir);
    //d:=Now; d:=Now;
                case Key of
                  K_CTRL_K: begin
                    SetLogVid(logvChk);
                    if TProgCopy.DataFix(dir,pt.fdbf,PrCopyOld,true) then Prog.LogWrite;
                  end;
                  K_Ctrl_P,K_CTRL_U: begin
                    SetLogVid(logvPack);
                    if TProgCopy.DataPack(dir,pt.fdbf,PrCopyOld,true,Key=K_CTRL_U) then Prog.LogWrite;
                  end;
                  K_CTRL_S: begin
                    SetLogVid(logvStruct);
                    if TProgCopy.DataStruct(dir,pt.fdbf,PrCopyOld) then Prog.LogWrite;
                  end;
                  K_CTRL_T: begin
                    SetLogVid(logvDelRegs);
                    if TProgCopy.DeleteRegs(dir,pt.fdbf) then Prog.LogWrite;
                  end;
                end;
    //d:=Now-d; meserr(d);
              end;
              SetLogVid;
            end;
          end;
        end;
        K_Ctrl_F4: with deCopy do begin
          SetLogVid(logvCopy); ProgGotoRec;
          Param['CopyProg',deNoVisible]:=bFalse; Param['CopyStatus',deNoVisible]:=bFalse;
          PrCopyValid:=ProgCopyValid; DM.Rec['CopyStatus']:=1;
          lCng := Execute('Скопировать программу в другую папку').Saved and DM.Rec['CopyProg'];
          SetLogVid;
        end;
        K_Ctrl_F5: with deCopy do begin
          SetLogVid(logvMove); ProgGotoRec;
          Param['CopyProg',deNoVisible]:=bTrue; Param['CopyStatus',deNoVisible]:=bTrue;
          PrCopyValid:=ProgMoveValid;
          lCng:=Execute('Перенести программу в другую папку').Saved;
          SetLogVid;
        end;
        K_Ctrl_F7,K_Shift_F5,K_Shift_F7: begin
          SetLogVid(logvAppRec); ProgGotoRec; Zaj.NewRec;
          d2:=DateToString(Now);
          d1:=IfThen((Key in [K_Shift_F5,K_Shift_F7]) and not lFlt,DateToString(dZajBeg),d2);
          if Key<>K_Shift_F5 then begin
            Zaj[fCDR]:=DM.Rec[fCDR];
            Zaj[fTD]:=d1;
          end;
          if Key<>K_Ctrl_F7 then begin
            Zaj['ISPTN']:=DM.Rec[fCDR];
            Zaj['TISPD']:=d1;
            Zaj['TISPD1']:=d2;
            Zaj['ISPV']:=iif(Key in [K_Shift_F5,K_Shift_F7],ivPhone,ivCdrToOrg);
          end;
          if rMsgToZaj<>0 then begin
            Msg.GotoRec(rMsgToZaj);
            if Msg.Recno=0 then rMsgToZaj:=0
            else begin
              if Key<>K_Shift_F5 then begin
                Zaj[fTD]:=Msg[fTD]; Zaj[fCDR]:=Msg[fMsgTNFROM];
              end;
              i:=1;
              repeat
                s:=nmf254(i);
                if not(Msg.IsField(s) and Zaj.IsField(s)) then break;
                Zaj[s]:=Msg[s]; Inc(i);
              until false;
            end;
          end;
          if Key=K_Shift_F7 then zvOpt:=[] else zvOpt:=[zajVsblWISP];
          with FormKeyLb(aProgFld[lFlt]) do if ZajEdit(SeekKey(Key).Hint,fdef.fqRECNO,
          IfThen(Key=K_Shift_F5),IfThen(Key=K_Ctrl_F7),zvOpt) then begin
            qZajMain.Close;
            if rMsgToZaj<>0 then begin
              DM.MsgDel(Msg); rMsgToZaj:=0;
            end
          end;
          SetLogVid;
        end;
        K_Ctrl_F12: begin
          SetLogVid(logvEditRec); Cdr.UpdateRec;
          Cdr.SetArrayValue(['FLTCDR','FLTORG','FLTPRG'],fltAll); Cdr['FLT']:=bFalse; Cdr['FLTSTATUS']:='';
          if Cdr.UpdateRec(true) then BrUpdate;
          SetLogVid;
        end;
        K_CTRL_D: begin
          ProgGotoRec; DM.MsgApp;
        end;
        K_CTRL_E,K_CTRL_G,K_CTRL_O: begin
          ProgGotoRec;
          if (ProgTp.sid<>'') then begin
            s:=GetFtpDir(Vtos(Prog[fACC]),@t);
            if (s<>'') then begin
              case Key of
                K_CTRL_E: begin
                  TSftpDir.File2Outbox(s+PathDelim,nil,StfpLogProc);
                end;
                K_CTRL_G: begin
                  SetLogVid(logvSendMsg);
                  t:=TrimRight(Prog['MSGPTRN']);
                  if not SendMsg(s,Trim(ListKod)+'-'+Trim(Prog[fProgCP]),t,false,false,TFltLs.SelPtrn)
                  then ProgPswd.CngLogVid(logvEditRec);
                  if (t<>TrimRight(Prog['MSGPTRN'])) then begin
                    Prog['MSGPTRN']:=t; Prog.UpdateRec(true); br.BrUpdate;
                  end
                  else if ProgPswd.LogVid=logvSendMsg then Prog.LogWrite;
                  SetLogVid;
                end;
                K_CTRL_O: SftpFilesExec(s+PathDelim,GlobDIRLAST,t,GlobLASTCNT,GlobLASTDAY,StfpLogProc);
              end;
            end;
          end;
        end;
        K_Alt_F3: begin
          SetLogVid(logvEditRec); ProgGotoRec;
          if Prog['STATUS']<>stpTemp then begin
            DM.Rec['KOD']:=ListKod; DM.Rec['ZajMov']:=false; DM.Rec['ZajMovCP']:='';
            DM.ProgCpGetInit(nil,DlmBetween(FldInListQQ('STATUS',aStat),Prog.rRecNo(false),sAND),DM.ProgCpGet);
            fl:=CanCngStatus; CanCngStatus:=true;
            try
              if DM.deProgStat.Execute.Saved then br.BrUpdate;
            finally
              CanCngStatus:=fl;
            end;
          end;
          SetLogVid;
        end;
        K_ALT_F5: begin
          Prog.NewRec;(* <- может и не нужно? сделано по аналогии с K_F5 *)
          lCng:=br.EditRec('Редактирование уч.записи',Prog,DM.DeProgUser);
        end;
        K_Alt_E: begin
          ProgGotoRec; MakeFullPath(Prog[fDRV],Prog['DIR'],dir); d1:=dir+DirDATAs;
          SetLogVid(logvCngExt);
          if TProgCopy.CngDBExt(ProgTp,true,dir,@d1,oe,ne)
          then Prog.LogWrite(Prog.LogPrim+LogDlm+'расширение:"'+aInterbaseExt[oe]+'"->"'+aInterbaseExt[ne]+'"');
          SetLogVid;
        end;
        K_Shift_F2: begin
          ProgGotoRec; CreateShow(TMsgLs,MsgLs,true);
        end;
        K_Shift_F3: begin
          SetLogVid(logvEditRec); ProgGotoRec; DM.Rec['KOD']:=ListKod;
          with DM.deProgCng do begin
            Param[fProgCP,deNoVisible]:=BStr[Prog['STATUS']=stpTemp];
            if Execute.Saved then br.BrUpdate;
          end;
          SetLogVid;
        end;
        K_SHIFT_F8: begin
          SetLogVid(logvDel); ProgGotoRec;
          if CheckUndoneMsg(Prog[fORG],Prog[fProgNP]) then
            if Ask(['Удалить папку?']) then
              if (ProgDel(Prog)) then mess_ok(['Папка удалена.']);
          SetLogVid;
        end;
        K_Shift_Enter: begin
          SetLogVid(logvSetGGW); ProgGotoRec; pt:=ProgTp; s:=pt.sid;
          if s<>'' then
            if Prepare2RunProg(dir,pt,[p2rMakeDir],@aPort) then begin
              Write_SET_XXX_Ini(dir,[winiClearIniDirs]);
              IncD(s,Format(' E DIRLAST=%s LASTCNT=%d  LASTDAY=%d REGNUM=%s ABR=%s %s=%s',
                [GlobDIRLAST,GlobLASTCNT,GlobLASTDAY,RegNum,ProgInf.Abr,ibpPort,aPort]));
              t:=GetFtpDir(Vtos(Prog[fACC]));
              if (t<>'') then begin
                IncD(s,' FTPDIR='+Trim(t));
              end;
              if CopyCommandToClipBoard then ClipBoard.AsText:=s;
              Prog.LogWrite;
              ShellExecute(0,nil,SetggwExeFile,PChar(s),PChar(ExeDir),SW_SHOW);
              //TSGWMain.Init([ProgInf.id],ExeDir,SGWInfo); SGWMain.ShowModal; FreeAndNil(SGWMain);
            end;
          SetLogVid;
        end;
        K_Shift_O: begin
          ProgGotoRec; DirectoryView(MakeFullPath(Prog[fDRV],Prog['DIR']));
        end;
      end;
      if lCng and not lFlt then ProgGet.Qry.Close;
    finally
      ProgPswd.PLogKeys:=oLogKeys;
    end;
  finally
    UnLockRead;
  end;
  DelStack;
end;

procedure TProgGet.brBoolDrawColumnCell;
begin
	AddStack('TProgGet.brBoolDrawColumnCell',Self);
	br.bmCheckPaint(Rect,Column);
  DelStack;
end;

class procedure TProgGet.DataChange;
var pg: TProgGet;
    f: TField;
begin
  if (Sender is TDataSource)and(GetProgGet(pointer(Sender),pg)) then begin
    pg.FShowSftpKeys:=false;
    if (pg.Qry<>nil)and(pg.Qry.Active)and(pg.Qry.IsRecords) then
      if pg.Qry.FindField(fACC,f) and (Int0(f.AsString)>0)
      then pg.FShowSftpKeys:=true;
    pg.UpdateSftpKeys([uskToReDrw,uskCheckBrowlActive]);
  end;
end;

class function TProgGet.PrCopyOld;
var abr: string;
  odir,fn: TFileName;
  sa: TArrStr;
begin
  AddStack('TProgGet.PrCopyOld');
  if lTrash then result:=true
  else begin
    abr:=ProgInf.Abr;
    result:=TSGWMain.OldDirFile(GlobDIRLAST,RZRVMODE_FREE,StrNum(abr,ListKod,CODSZ_ORG)
      +StrNum('-',Prog[IfThen(Prog['STATUS']=stpTemp,'CPA',fProgCP)],CODSZ_PRG)+'-','',0,0,sa,fn);
    if (result) then begin
      if (sa<>nil) then odir:=sa[0];
      IncL(fn,CorrDir(odir),'.PCK');
      abr:=Format('%s E DIRLAST=%s LASTCNT=%d LASTDAY=%d REGNUM=%s ABR=%s COPYOLD=%d',
        [ProgTp.sid,GlobDIRLAST,GlobLASTCNT,GlobLASTDAY,RegNum,abr,
        IfThen(Assigned(Sender),byte(Sender),iif(LastKey in [K_Ctrl_P,K_Ctrl_U],coaPack,coaStruct))]);
      if CopyCommandToClipBoard then ClipBoard.AsText:=abr;
      result:=RunExe(SetggwExeFile+' '+abr,
        ExeDir,'Создание резервной копии',[],'',[runNoConsole,runWin]);
      if (result) then result:=FileExists(fn) else DelFileAtr(fn);
    end;
  end;
  DelStack;
end;

procedure TProgGet.OrderList;
var i,ldef: longint;
  bf: byte;
begin
  AddStack('TProgGet.OrderList',Self);
  bf:=IfThen(not lFlt,1); ldef:=fdef.ls.Count; SetLength(a,IfThen(lZaj,ofzCnt)+ofxCnt-bf+ldef);
  l:=0;
  if lZaj then for i:=1 to ofzCnt do AddFrom(a,l,ZajFldName(i));
  for i:=1+bf to ofxCnt do AddFrom(a,l,StrTran(ProgFld[i].ofvName,UnDelim,' ',[rfReplaceAll,rfIgnoreCase]));
  for i:=0 to ldef-1 do AddFrom(a,l,lsFldLabel(fdef.ls,i));
  DelStack;
end;

function TProgGet.GetMask;
var a: TArrStr;
  l: longint;
begin
  AddStack('TProgGet.GetMask',Self);
  OrderList(a,l,lZaj);
  result:='ДАННЫЕ'+UnDelim+'выводить'+UnDelim+ArrayAsList(a,mniDlm,l);
  DelStack;
end;

class function TProgGet.ProgDel;
var dir: TFileName;
  s: string;
  gle: longword;
  oLogVid: longint;
begin
	AddStack('TProgGet.ProgDel');
  MakeFullPath(Prog[fDRV],Prog['DIR'],dir);
  result:=CheckDir(dir,ProgInf,@s);
  if result and not empty(Prog[fProgCP]) then begin
    result:=Prepare2RunProg(dir,ProgTp,[]);
    if result then begin
      Write_SET_XXX_Ini(dir); result:=PrCopyOld(pointer(coaDelDir));
    end;
  end;
  if result then begin
    gle:=0;
    DeleteDir_LastFile(ExcludeTrailingPathDelimiter(dir),s,@gle);
    if (DirectoryExists(dir)) then begin
      result:=false;
      mess_ok(['Не могу удалить папку <'+dir+'>',IfThen(gle<>0,SysErrorMessage(gle))],'',taLeftJustify);
    end
    else begin
      oLogVid:=ProgPswd.LogVid; ProgPswd.CngLogVid(logvDel);
      Prog.LogWrite(Prog.LogPrim+LogDlm+'папка:"'+dir+'"'); ProgPswd.CngLogVid(oLogVid);
    end;
  end;
  DelStack;
end;

class function TProgGet.deCopyFldCheck;
begin
	AddStack('TProgGet.deCopyFldCheck');
  NoEmpCheck(Sender,'COPYDIR',result);
  DelStack;
end;

procedure TProgGet.deCopyFldChange;
begin
	AddStack('TProgGet.deCopyFldChange',Self);
  with TFldEdit(Sender),deCopy do
    if NameRecFld='COPYND'
      then Mask['CopyDir']:='Папка для нового расположения данных'+UnDelim+MakeFullPath(VarValue)
    else if NameRecFld='COPYPROG'
      then SetReadOnly('CopyStatus',not VarValue);
  DelStack;
end;

procedure TProgGet.deCopyFrmShow;
begin
	AddStack('TProgGet.deCopyFrmShow',Self);
  Prog.GotoRec(fdef.fqRECNO);
  DM.Rec['CopyND']:=Prog[fDRV];
  DM.Rec['CopyDir']:=Prog['Dir'];
  DelStack;
end;

procedure TProgGet.deCopyKpProcKey;
begin
  AddStack('TProgGet.deCopyKpProcKey',Self);
  with ProgPswd.GetQuery do begin
    PartSelect(tDRV,[fDRV,fNAME]);
    while not Eof do begin
      if IsSelfComp(Fields[1].AsString) then begin
        deCopy.FldValue['CopyND']:=Fields[0].AsString;
        deCopy.FldValue['CopyDir']:='GG'+PathDelim+ProgTp.sid;
        break;
      end;
      Next;
    end;
  end;
  ProgPswd.FreeQuery;
  DelStack;
end;

function TProgGet.deCopyPnlValid;
begin
	AddStack('TProgGet.deCopyPnlValid',Self);
  result := (TrimUpper(DM.Rec['CopyND'])<>TrimUpper(Prog[fDRV]))
  	or (TrimUpper(DM.Rec['CopyDir'])<>TrimUpper(Prog['Dir']));
  if result then result:=PrCopyValid(Sender)
  else meserr('Новое расположение программы совпадает с текущим.');
  DelStack;
end;

function TProgGet.ProgCopyValid;
var dirFrom,dirTo: TFileName;
  s: string;
	pi: TProgInf;
begin
  AddStack('TProgGet.ProgCopyValid',Self);
  MakeFullPath(Prog[fDRV],Prog['DIR'],dirFrom); result:=DirectoryExists(dirFrom);
  if (not result) then begin
    mess_ok(['Ошибка доступа к папке:',dirFrom]);
  end else begin
    dirTo:=DlmCopy(deCopy.Mask['CopyDir'],2,1,UnDelim)+DM.Rec['CopyDIR'];
    result:=not TCopyLs.PrCopy(dirFrom,dirTo);
    if result then
      if DM.Rec['CopyProg'] then begin
        ProgPswd.CngLogVid(logvAppRec); LogFields.Clear;
        Prog.NewRec([newrCopy]);
        Prog[fDRV]:=DM.Rec['CopyND'];
        Prog['Dir']:=DM.Rec['CopyDir'];
        Prog.KodNextSelf(fProgNP,fORG+'='+Vtos(Prog[fORG]));
        Prog.KodNextSelf(fProgCP,fORG+'='+Vtos(Prog[fORG]));
        Prog['STATUS']:=DM.Rec['CopyStatus'];
        Prog.AppRec(true);
        br.BrUpdate(br.Row,Prog.RecNo);
      end else begin
        pi:=ProgInf;
        if (ProgTypes[pi.id].lWin) then begin
          s:=CngDir(dirTo);
          TDBPrmGet.DirDataToIni(ProgTypes[pi.id].sid,stpReg,GetFbPort(Drv,[],[],Prog['FBVERS'],[fbpNotShowMsg]));
          CngDir(s);
        end;
        Prog.LogWrite(Prog.LogPrim+LogDlm+'в папку "'+dirTo+'"');
      end;
  end;
  DelStack;
end;

function TProgGet.ProgMoveValid;
var odir: TFileName;
begin
  AddStack('TProgGet.ProgMoveValid',Self);
  MakeFullPath(Prog[fDRV],Prog['DIR'],odir);
  result:=CheckDir(odir,ProgInf);
  if result then begin
    result:=TProgCopy.Copy('Перенос программы',odir,MakeFullPath(DM.Rec['CopyND'],DM.Rec['CopyDIR']));
    if result then begin
      LogFields.Clear;
      Prog[fDRV]:=DM.Rec['CopyND'];
      Prog['Dir']:=DM.Rec['CopyDir'];
      Prog.UpdateRec(true);
      XDel(odir);
      br.BrUpdate;
    end;
  end;
  DelStack;
end;

procedure TProgGet.OrdRead;
var i,l,ii,tr: longint;
  a: array[1..2] of string;
  a1: TArrStr;
  f: TField;
begin
  AddStack('TProgGet.OrdRead',Self);
  if lUpd then BrInf(ii,tr,true);
  LsArrFill(Mem2Ord(Cdr[sMemo+'ORD'+afOrd[lFlt]],false),a,'/');
  if empty(a[1]) then
  	for i:=1 to ofxCnt-IfThen(not lFlt,1) do SetByte(a[1],i,true);
  if not lFlt then begin
  	IncL(a[1],' '); l:=LsArrDynamic(a[2],a1,',');
    for i:=0 to l-1 do a1[i]:=IntToStr(Int0(a1[i])+1);
    a[2]:='1,'+ArrayAsList(a1,',',l);
  end;
  Qry.Orders.Text:='KOD';
  fdef.OrdRead(Qry,ArrayAsList(a,'/'));
  BrUpdate(false);
	if not lFlt and (List.RecNo=0) and Qry.FindField('CTN',f) then f.Visible:=false;
  if lUpd then BrInf(ii,tr);
  DelStack;
end;

procedure TProgGet.QryBeforeOpen;
begin
  AddStack('TProgGet.QryBeforeOpen',Self);
  if lInterFlt then SetInterFlt(Qry,fdef.lsRec,'FLT',fRECNO,'',Inter,qFiltered);
  DelStack;
end;

procedure TProgGet.QryAfterOpen;
var q: TMulQuery;
  k: longint;
  ibq: TIBQuery;
begin
  AddStack('TProgGet.QryAfterOpen',Self);
  q:=MulQueryOwner(DataSet);
  if lFlt then begin
    if q.Filtered and IsClass(q.DataSet,TIBQuery,pointer(ibq))
    then k:=ibq.VisibleRecordCount
    else k:=q.RecordCount;
    Status.SectLeft[0]:=StrNum('ВСЕГО: ',k);
  end
  else FirstRecno:=q.FindField(fRECNO).AsInteger;
  DelStack;
end;

{ TTblChkOrdGet }
constructor TTblChkOrdGet.Create;
begin
	AddStack('TTblChkOrdGet.Create',Self);
  inherited Create(AOwner);
  RVName:='с редактированием порядка';
  DelStack;
end;

procedure TTblChkOrdGet.CreateObj;
begin
	AddStack('TTblChkOrdGet.CreateObj',Self);
  inherited CreateObj(tf);
  with tbl do begin
  	OnMouseDown:=OrdMouseDown;
    OnMouseMove:=OrdMouseMove;
    OnMouseUp:=OrdMouseUp;
  end;
  Val:=TTblChkOrdVal.Create(tf);
  tf.ReCreateObj;
  DelStack;
end;

function TTblChkOrdGet.GetValue;
var a,a1: TArrStr;
	i: longint;
begin
	AddStack('TTblChkOrdGet.GetValue',Self);
  result:=inherited GetValue(tf);
  if AssignObj(tf) then begin
    SetLength(a,Length(Val.aord));
    for i:=low(a) to high(a) do a[i]:=IntToStr(Val.aord[i]+1);
    SetLength(a1,tbl.HeadX.Count+1);
    LsArrFill(result,a1,'/');
    a1[tbl.HeadX.Count]:=ArrayAsList(a,',');
    result:=ArrayAsList(a1,'/');
  end;
  DelStack;
end;

procedure TTblChkOrdGet.SetValue;
var i,l: longint;
	ah: TArrStr;
begin
	AddStack('TTblChkOrdGet.SetValue',Self);
  inherited SetValue(tf,v);
  if AssignObj(tf) then begin
    l:=tbl.HeadY.Count; GetOrd(Val.aord,l,tbl.HeadX.Count,v);
    SetLength(ah,l); LsArrFill(DlmCopy(tf.Mask,3,1,UnDelim),ah,mniDlm);
    for i:=0 to tbl.HeadY.Count-1 do begin
    	tbl.HeadY[Val.aord[i]]:=ah[i]; tbl.Cells[0,tbl.FixedRows+Val.aord[i]]:=ah[i];
    end;
  end;
  DelStack;
end;

class procedure TTblChkOrdGet.GetOrd;
var ao: TArrStr;
	sfl: TArrBoolSet;
	i,j: longint;
begin
  AddStack('TTblChkOrdGet.GetOrd');
  SetLength(ao,CntRow); SetLength(sfl,CntRow); SetLength(aord,CntRow);
  LsArrFill(DlmCopy(v,cntCol+1,1,'/'),ao,',');
  if CntRow>0 then SetMemory(@sfl[0],SizeOf(sfl[0])*CntRow);
  for i:=low(ao) to high(ao) do begin
    j:=Int0(ao[i]);
    if InRange(j,1,CntRow) then
      if true in sfl[i] then begin
        Exclude(sfl[j-1],false);
        Exclude(sfl[i],true);
        aord[i]:=j-1;
      end;
  end;
  j:=low(ao);
  for i:=low(ao) to high(ao) do if true in sfl[i] then begin
    while not(false in sfl[j]) do Inc(j);
    aord[i]:=j; Inc(j);
  end;
  DelStack;
end;

procedure TTblChkOrdGet.DoEnter;
var tl: TKeyLb;
begin
	AddStack('TTblChkOrdGet.DoEnter',Self);
  inherited DoEnter(tf);
  if not(ogReadOnly in tf.Options) then if FormKeyLb(tf,tl) then with tl do begin
    SetKey(K_Ctrl_Up,'Выше','Переместить выше',MoveProcKey,'orgdatget',kmEdit);
    SetKey(K_Ctrl_Down,'Ниже','Переместить ниже',MoveProcKey,'orgdatget',kmEdit);
    Redrw;
  end;
  DelStack;
end;

procedure TTblChkOrdGet.DoExit;
var tl: TKeyLb;
begin
	AddStack('TTblChkOrdGet.DoExit',Self);
  if FormKeyLb(tf,tl) then tl.DelKey(K_All,'orgdatget');
  inherited DoExit(tf);
  DelStack;
end;

function TTblChkOrdGet.MayDoKey;
begin
	AddStack('TTblChkOrdGet.MayDoKey',Self);
  result:=inherited MayDoKey(tf,Key);
  if result and (Key in [K_PgUp,K_PgDn]) then result:=false;
  DelStack;
end;

procedure TTblChkOrdGet.MoveProcKey;
begin
	AddStack('TTblChkOrdGet.MoveProcKey',Self);
  case Key of
    K_Ctrl_Up: Move(tbl,tbl.Row,tbl.Row-1);
    K_Ctrl_Down: Move(tbl,tbl.Row,tbl.Row+1);
  end;
  DelStack;
end;

procedure TTblChkOrdGet.Move;
var X,oY,nY: Word;
begin
  AddStack('TTblChkOrdGet.Move',Self);
  with tbl do begin
    ColRowToXY(Col,oi,X,oY); ColRowToXY(Col,ni,X,nY);
    if ListMoveItem(oY,nY,0,HeadY.Count-1,PrMove,[oi,ni,LongInt(tbl)]) then Row:=ni;
  end;
  DelStack;
end;

procedure TTblChkOrdGet.OrdMouseDown;
var ACol: longint;
begin
	AddStack('TTblChkOrdGet.OrdMouseDown',Self);
	if not flOrdMove and (Button = mbLeft) then with TStrTable(Sender) do begin
  	MouseToCell(X,Y,ACol,OrdIndex); flOrdMove := OrdIndex >= tbl.FixedRows; NoSel:=false;
  end;
  DelStack;
end;

procedure TTblChkOrdGet.OrdMouseMove;
var ACol,nr: longint;
	  tbl: TStrTable;
begin
	AddStack('TTblChkOrdGet.OrdMouseMove',Self);
	if flOrdMove then begin
  	tbl:=pointer(Sender); tbl.MouseToCell(X,Y,ACol,nr);
  	if (nr >= tbl.FixedRows) and (nr <> OrdIndex) then begin
		  Move(tbl,OrdIndex,nr); OrdIndex:=nr;
    end;
  end;
  DelStack;
end;

procedure TTblChkOrdGet.OrdMouseUp;
begin
	flOrdMove:=false;
end;

procedure TTblChkOrdGet.PrMove;
var i,oi,ni: longint;
	s: string;
begin
	AddStack('TTblChkOrdGet.PrMove',Self);
  with TStrTable(LongInt(av[2])) do begin
  	HeadY.Exchange(oY,nY);
    oi:=av[0];
    ni:=av[1];
    for i:=0 to RowCount-1 do begin
	    s:=Cells[i,oi]; Cells[i,oi]:=Cells[i,ni]; Cells[i,ni]:=s;
    end;
    oi:=0; ni:=0;
    for i:=low(Val.aord) to high(Val.aord) do
    	if Val.aord[i]=oY then oi:=i
    	else if Val.aord[i]=nY then ni:=i;
    i:=Val.aord[oi]; Val.aord[oi]:=Val.aord[ni]; Val.aord[ni]:=i;
  end;
  DelStack;
end;

function TTblChkOrdGet.AssignObj;
begin
	AddStack('TTblChkOrdGet.AssignObj',Self);
  result:=false; Val:=nil;
  if inherited AssignObj(tf) then
    if tf.ComponentCount>1 then result:=IsClass(tf.Components[1],TTblChkOrdVal,pointer(Val));
  DelStack;
end;

{ TTblChkOrdLogCompare }

type
  TTblChkOrdLogList = (cologBase,cologCol);

  PTblChkOrdLogPrm = ^TTblChkOrdLogPrm;
  TTblChkOrdLogPrm = record
    v: TTblChkOrdLogList;
  	case TTblChkOrdLogList of
	  	cologBase: (Opt: TDEFltOpt);
	  	cologCol: (ar: PArrStr; aord: PArrBoolArrInt; cntRow,ic: longint);
  end;

class function TTblChkOrdLogCompare.ListCreate;
var p: PTblChkOrdLogPrm;
  a: PArrStr;
  i,j,l: longint;
begin
  AddStack('TTblChkOrdLogCompare.ListCreate');
  p:=pv;
  case p.v of
    cologBase: result:=TStrLogCompare.ListCreate(nil,Value,lNew);
    cologCol: begin
      result:=TDlmLogCompare.ListCreateDlm('',''); a:=result; l:=p.cntRow; InitArrLen(a^,l);
      for i:=low(a^) to high(a^) do
        if GetByte(Value,p.ic+1,p.aord[lNew,i]+1) then a^[p.aord[lNew,i]]:=IntToStr(i);
      i:=0;
      while i<l do
        if a^[i]='' then begin
          for j:=i+1 to l-1 do a^[j-1]:=a^[j];
          Dec(l);
        end
        else Inc(i);
      SetLength(a^,l);
    end;
  else result:=nil; // Return value of function might be undefined
  end;
  DelStack;
end;

function TblChkLogClass(pv: pointer): TCustomLogCompareClass;
begin
  AddStack('OLGets.CngvLogClass');
  with PTblChkOrdLogPrm(pv)^ do
    result:=IfThenCustomLogCompareClass(v=cologBase,TStrLogCompare,
            IfThenCustomLogCompareClass(v=cologCol,TDlmLogCompare));
  DelStack;
end;

class procedure TTblChkOrdLogCompare.ListDestroy;
begin
  AddStack('TTblChkOrdLogCompare.ListDestroy');
  TblChkLogClass(pv).ListDestroy(nil,ls);
  DelStack;
end;

class function TTblChkOrdLogCompare.GetCount;
begin
  AddStack('TTblChkOrdLogCompare.GetCount');
  result:=TblChkLogClass(pv).GetCount(pv,ls);
  DelStack;
end;

class procedure TTblChkOrdLogCompare.GetItem;
var p: PTblChkOrdLogPrm;
  cop: TTblChkOrdLogPrm;
  pt: TTblChkGetPrm;
  ic: longint;
  aord: TArrBoolArrInt;
  so,sn: string;
begin
  AddStack('TTblChkOrdLogCompare.GetItem');
  p:=pv;
  case p.v of
    cologBase: if tp<>clogKey then begin
      sn:=PString(lsn)^;
      if tp=clogNoKey then Prm.val:=sn
      else begin
        pt:=TTblChkGet.Mask2Prm(ProgGet(fltFlt in p.Opt).GetMask(fltZaj in p.Opt));
        cop.cntRow:=pt.aRow.l;
        cop.v:=cologCol; cop.ar:=@pt.aRow.a; cop.aord:=@aord; so:=PString(lso)^;
        TTblChkOrdGet.GetOrd(aord[false],cop.cntRow,pt.aCol.l,ProgGet(fltFlt in p.Opt).Mem2Ord(so,fltZaj in p.Opt));
        TTblChkOrdGet.GetOrd(aord[true ],cop.cntRow,pt.aCol.l,ProgGet(fltFlt in p.Opt).Mem2Ord(sn,fltZaj in p.Opt));
        for ic:=0 to pt.aCol.l-1 do begin
          cop.ic:=ic; AddRes(Prm,so,sn,@cop,IfThen(pt.aCol.l>1,pt.aCol.a[ic]));
        end;
      end;
    end;
    cologCol: begin
      inherited GetItem(Prm,pv,lso,lsn,no,nn,tp);
      if (tp=clogPrn) and not empty(Prm.val) then Prm.val:=PTblChkOrdLogPrm(pv).ar^[Int0(Prm.val)];
    end;
  end;
  DelStack;
end;

class procedure TTblChkOrdLogCompare.Execute(var Prm: TLogTrnsValPrm; Opt: TDEFltOpt);
var cop: TTblChkOrdLogPrm;
begin
  AddStack('TTblChkOrdLogCompare.Execute');
  cop.v:=cologBase; cop.Opt:=Opt; Execute(Prm,@cop);
  DelStack;
end;

{ TProgSelGet }
constructor TProgSelGet.Create;
begin
	AddStack('TProgSelGet.Create',Self);
  inherited Create(AOwner);
  RVid:='';
  DelStack;
end;

procedure TProgSelGet.CreateObj;
	function tfCrt(const Capt,nmf: string; r: TCustomRec): TFldEdit;
  begin
    AddStack('TProgSelGet.CreateObj.tfCrt',Self);
    result:=TFldEdit.Create(tf);
    with result do begin
      Parent:=tf; NameRec:=r.NameRec; NameRecFld:=nmf;
      CharWidth:=wallNoSay; SayCaption:=Capt; Mask:=cCdAny;
      onDblClick:=tf.EdDblClick;
      onKeyDown:=tf.EdKeyDown; onKeyPress:=tf.EdKeyPress; onKeyUp:=tf.EdKeyUp;
      onMouseDown:=tf.EdMouseDown; onMouseMove:=tf.EdMouseMove; onMouseUp:=tf.EdMouseUp;
    end;
    DelStack;
  end;
var r: TRecVal;
begin
	AddStack('TProgSelGet.CreateObj',Self);
  DestroyObj(tf); r:=TRecVal.Create(tf); r.CreateFld('PROG',ftString,max(lProgCP,lProgKP),'');
  with tfCrt('клиент','KOD',DM.Rec) do begin
    AssignGet(DM.ListGet); OnChange:=fKodChange;
  end;
  tfCrt('программа','PROG',r).Vid:=TCodeGet.ClassName;
  tf.Relation:=frMain; tf.ReCreateObj;
  DelStack;
end;

procedure TProgSelGet.ReCreateObj;
begin
	AddStack('TProgSelGet.ReCreateObj',Self);
  if AssignObj(tf) then begin
    fKod.Options:=tf.Options; fProg.Options:=tf.Options;
    fProg.VName:=DlmCopy(tf.Mask,2,1,UnDelim); fKodChange(fKod,fKod.VarValue,false);
  end;
  inherited RecreateObj(tf);
  DelStack;
end;

function TProgSelGet.GetValue;
begin
	AddStack('TProgSelGet.GetValue',Self);
  result := inherited GetValue(tf);
  if AssignObj(tf) then begin
    result:=TrimRight(fProg.VarValue);
    if result<>'' then IncL(result,'-');
    IncL(result,fKod.VarValue);
  end;
  DelStack;
end;

procedure TProgSelGet.SetValue;
var a: array[1..2] of string;
begin
	AddStack('TProgSelGet.SetValue',Self);
  if AssignObj(tf) then begin
    LsArrFill(v,a,'-'); fKod.VarValue:=a[1]; fProg.VarValue:=a[2];
  end;
  DelStack;
end;

function TProgSelGet.AssignObj;
var i: longint;
  tc: TComponent;
  tf1: TFldEdit;
begin
	AddStack('TProgSelGet.AssignObj',Self);
  Rec:=nil; fKod:=nil; fProg:=nil;
  if inherited AssignObj(tf) then begin
    for i:=0 to tf.ComponentCount-1 do begin
      tc:=tf.Components[i];
      if not IsClass(tc,TRecVal,pointer(Rec),false) then
        if IsClass(tc,TFldEdit,pointer(tf1)) then
          if tf1.NameRecFld='KOD'
            then fKod:=tf1
          else if tf1.NameRecFld='PROG'
            then fProg:=tf1;
    end;
    result := Assigned(Rec) and Assigned(fKod) and Assigned(fProg);
  end
  else result:=false;
  DelStack;
end;

procedure TProgSelGet.fKodChange;
begin
  AddStack('TProgSelGet.fKodChange',Self);
  if AssignObjOwner(Sender)
  then DM.ProgCpGetInit(fKod,QryNone(true),pointer(fProg.curget));
  DelStack;
end;

constructor TOrdList.Create;
begin
  AddStack('TOrdList.Create');
  inherited Create([ilsSorted]);
  SetLength(aRec,10);
  DelStack;
end;

function TOrdList.AddRec;
var i: longint;
begin
  AddStack('TOrdList.AddRec');
  i:=Count;
  if Length(aRec)=i then SetLength(aRec,i shl 1);
  Add(Value,i); result:=@aRec[i];
  DelStack;
end;

function TOrdList.GetRec;
begin
  AddStack('TOrdList.GetRec');
  result:=@aRec[IntObj(Index)];
  DelStack;
end;

{ TTimeGet }
constructor TTimeGet.Create;
begin
	AddStack('TTimeGet.Create',Self);
	Inherited Create(AOwner);
  RVid:='Ввод времени';
  DelStack;
end;

procedure TTimeGet.CreateObj;
begin
	AddStack('TTimeGet.CreateObj',Self);
  inherited CreateObj(tf);
  tf.Mask:='99:99:99';
  DelStack;
end;

function TTimeGet.GetValue;
var a: array[1..3] of string;
  h: Word;
begin
  AddStack('TTimeGet.GetValue',Self);
  if AssignObj(tf) then begin
    LsArrFill(tm.Text,a,':'); h:=Int0(a[1]);
    result:=TFld.VarToStr((h div HoursPerDay)+EncodeTimeTry(h mod HoursPerDay,Int0(a[2]),Int0(a[3]),0),ftFloat);
  end
  else result:='';
  DelStack;
end;

procedure TTimeGet.SetValue;
var dt: TDateTime;
  y,m,d,h,n,s,z: Word;
begin
  AddStack('TTimeGet.GetValue',Self);
	if AssignObj(tf) then begin
    dt:=Float0(vv); DecodeDateTry(dt,y,m,d); DecodeTime(dt,h,n,s,z);
    if z >= MSecsPerSec div 2 then begin
      Inc(s);
      if s=SecsPerMin then begin
        Inc(n); s:=0;
        if n=MinsPerHour then begin
          Inc(h); n:=0;
          if h=HoursPerDay then begin
            if m=0 then Inc(d) else DecodeDateTry(dt+1,y,m,d);
            h:=0;
          end;
        end;
      end;
    end;
    if m>0 then begin
      m:=DaysInAMonth(y,m);
      if y>0 then Inc(m,DaysInAYear(y-1));
    end;
    tm.Text:=NumStr((m+d)*HoursPerDay+h,2)+':'+NumStr(n,2)+':'+NumStr(s,2);
    tm.SelAll;
  end;
  DelStack;
end;

function TTimeGet.Check;
var a: array[1..3] of string;
begin
	AddStack('TTimeGet.Check',Self);
  if AssignObj(tf) then begin
    LsArrFill(tm.Text,a,':');
    result := InRange(Int0(a[2]),0,MinsPerHour-1) and InRange(Int0(a[3]),0,SecsPerMin-1);
  end
  else result:=true;
  DelStack;
end;

procedure TTimeGet.DispValue;
begin
end;

function TTimeGet.MayDoKey;
begin
	AddStack('TTimeGet.MayDoKey',Self);
	if Key in [K_Esc,K_Alt_Z]
  then result := inherited MayDoKey(tf,Key)
  else result:=Check(tf);
  if not result and (ogAutoSelect in tf.Options) and AssignObj(tf)
  then tm.SelAll(true);
  DelStack;
end;

function TTimeGet.DWFldUnAllowType;
begin
  AddStack('TTimeGet.DWFldUnAllowType',Self);
  result:=[low(aDWFld)..high(aDWFld)]-[dwtFloat];
  DelStack;
end;

procedure LogTrnsValProc(var Prm: TLogTrnsValPrm);
var lFlt: boolean;
  fo: TDEFltOpt;
label lend;
begin
  AddStack('OLGets.LogTrnsValProc');
  with Prm do if LogEqual(Prm,tCDR) then begin
    fo:=[];
    for lFlt:=false to true do if nmf=sMemo+'ORD'+afOrd[lFlt] then begin
      if lFlt then Include(fo,fltFlt);
      TTblChkOrdLogCompare.Execute(Prm,fo); goto lend;
    end;
    if nmf=sMemo+'ORDZAJ' then begin
      TTblChkOrdLogCompare.Execute(Prm,[fltFlt,fltZaj]); goto lend;
    end;
  end;
lend:
  DelStack;
end;

initialization
  AddStack('OLGets.initialization');
  LogTrnsValProcAdd(LogTrnsValProc);
  DelStack;
end.
