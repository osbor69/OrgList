unit FFltLs;

interface

{$I LIBTEST}
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, Menus, DB, DBTables, Grids, DBGrids, ExtCtrls,
  MyTypes, FRMBRIB, KeyMenu, Browl, Keylb, Fpanel, DefEdit, FFldEdit;

type
  TFltLs = class(TFormBrIB)
    de: TDefEdit;
    procedure FormCreate(Sender: TObject);
    procedure KeyLb1ProcKey(key: Integer; tw: TWinControl);
    function dePnlValid(Sender: TObject): Boolean;
  private
    { Private declarations }
    BrQuery1TN: TStringField;
    BrQuery1RECNO: TIntegerField;
    BrQuery1NPP: TField;
    FCanCngFltCdr: boolean;
    procedure SetFltCdr(Value: boolean);
    procedure ProcKey(key: Integer; tw: TWinControl);
  public
    { Public declarations }
    class function Execute(var sMem: string; gk: longint; const Capt: TCaption;
      gMem: TCustomGet = nil; const msMem: string = ''; CanCngFltCdr: boolean = false): boolean;
    class function SelPtrn(Sender: TObject): string;
  end;

var
  FltLs: TFltLs;

implementation

{$R *.dfm}

uses
  Math,StrUtils,
  My_pr,Inter,FrmPswd,MulQry,RecVal,RecDB,
  OLTypes,FDM,FSchemDM;

// FltLs()
function c_FltLs(var av: array of variant): variant;
var s: string;
begin
	AddStack('FFltLs.c_FltLs');
  result:=null;
  if TFltLs.Execute(s,0,'Основы для формулы фильтра',DM.FltGet,ButPrm2Mask('Формула фильтра'))
  then ActiveDefEdit.FldValue[sMemo+deFltFld]:=s;
  DelStack;
end;

{ TFltLs }
class function TFltLs.Execute;
var nmf: string;
  a: TDEPrmStr;
  i: longint;
begin
  AddStack('TFltLs.Execute');
  CreateForm(TFltLs,FltLs);
  with FltLs do begin
    Caption:=Capt; nmf:=sMemo+'FLT';
    if de.GetArrParam(nmf,i,a) then begin
      if Assigned(gMem) then begin
        gMem.AssignGet(a); a[deMask]:=msMem;
      end;
      a[deNoVisible]:=bStr[not Assigned(gMem)]; de.SetArrParam(i,a);
    end;
    BrQuery1.GlobKey:=IntToStr(gk); FCanCngFltCdr:=CanCngFltCdr; SetFltCdr(CanCngFltCdr);
    de.NameWnd:=StrNum('Flt',gk);
    result := ShowModal=mrOk;
    if result then begin
    	Flt.GotoRec(BrQuery1RECNO); sMem:=Flt[nmf];
    end;
  end;
  FormFree(FltLs);
  DelStack;
end;

procedure TFltLs.FormCreate(Sender: TObject);
begin
	AddStack('TFltLs.FormCreate',Self);
  inherited;
  with BrQuery1 do begin
    Connection:=DBMain; GlobKey:='0';
  	BrQuery1RECNO:=Init(DBMain,['NPP'],['NPP'],tFLT,[fCDR,fNAME,'NPP',fRECNO],fFltGK+'='+qGlobKey);
    BrQuery1TN:=CreateStringField(fCDR);
    CreateStringField(fNAME,'Наименование');
    BrQuery1NPP:=CreateField('NPP');
  end;
  DelStack;
end;

procedure TFltLs.SetFltCdr;
begin
  AddStack('TFltLs.SetFltCdr',Self);
  BrQuery1.Arg[sWHERE]:=fFltGK+'='+qGlobKey+IfThen(Value,sAND+fCDR+'='+QQs(Cdr[fCDR]));
  BrQuery1TN.Visible := FCanCngFltCdr and not Value;
  BrQuery1.Orders[0]:=IfThen(BrQuery1TN.Visible,fCDR+',')+'NPP';
  with KeyLb1 do begin
    if FCanCngFltCdr and Value
    then DelKey(K_All,'fltcopy')
    else SetKey(K_F4,'Скопировать','',ProcKey,'fltcopy',kmList);
    if FCanCngFltCdr and not Value then DelKey(K_All,'flt')
    else begin
      SetKey(K_F5,'Редактировать','',ProcKey,'flt',kmList);
      SetKey(K_F7,'Добавить','',ProcKey,'flt',kmList);
      SetKey(K_F8,'Удалить','',ProcKey,'flt',kmList);
      SetKey(K_Ctrl_Up,'Выше','Переместить выше',ProcKey,'flt',kmList);
      SetKey(K_Ctrl_Down,'Ниже','Переместить ниже',ProcKey,'flt',kmList);
    end;
    if FCanCngFltCdr
    then SetKey(K_Tab,IfThen(Value,'Все','Только свои'),IfThen(Value,'Основы всех пользователей'),ProcKey,'fltcng',kmList)
    else DelKey(K_All,'fltcng');
    ReDrw;
  end;
  DelStack;
end;

procedure TFltLs.ProcKey;
var ii,npp: longint;
begin
	AddStack('TFltLs.ProcKey',Self);
  if BrQuery1.CanEdit(Key,[K_Tab]) then case Key of
    K_F4,K_F7: Browl1.AppRec('Добавить',Flt,de,IfThen((Key=K_F4) or BrQuery1.IsRecords and FCanCngFltCdr,brappCopy));
    K_F5: Browl1.EditRec('Редактировать',Flt,de);
    K_F8: Browl1.DelAsk(Flt);
    K_Tab: begin
      npp:=Browl1.Row; ii:=BrQuery1RECNO.AsInteger; SetFltCdr(BrQuery1TN.Visible); Browl1.BrUpdate(npp,ii);
    end;
    K_Ctrl_Up,K_Ctrl_Down: begin
      SetLogVid(logvEditRec);
      ii:=BrQuery1RECNO.AsInteger; npp:=BrQuery1NPP.AsInteger; BrQuery1.MoveBy(aSign[Key=K_Ctrl_Up]);
      if not(BrQuery1.Bof or BrQuery1.Eof) then
        if TrnsStart([tFLT]) then try
          Flt.UpdateTable(['NPP'],[npp],RecnoWhere(BrQuery1RECNO));
          Flt.GotoRec(ii); Flt['NPP']:=BrQuery1NPP.AsInteger; Flt.UpdateRec(true);
          TrnsEnd([trnsCommit]);
        except
          TrnsEnd; raise
        end;
      Browl1.BrUpdate(NegDef,ii); SetLogVid;
    end;
  end;
  DelStack;
end;

procedure TFltLs.KeyLb1ProcKey(key: Integer; tw: TWinControl);
begin
  AddStack('TFltLs.KeyLb1ProcKey',Self);
  if Key=K_F10 then Key:=K_Esc;
  inherited;
  DelStack;
end;

function TFltLs.dePnlValid(Sender: TObject): Boolean;
var svi: TRDBSaveInf;
  w,m: string;
begin
  AddStack('TFltLs.dePnlValid',Self);
  result:=true;
  if Flt.Recno=0 then begin
    Flt.SaveInf(svi);
    w:=fFltGK+'='+BrQuery1.GlobKey+IfThen(FCanCngFltCdr,sAND+fCDR+'='+QQs(Cdr[fCDR]));
    m:=Flt[sMemo+'FLT'];
    if Flt.Seek(w+sAND+fNAME+'='+QQs(Flt[fNAME])) then begin
      result:=Ask(['Основа с таким наименование уже есть.','Заменить ?']);
      if result then begin
        ProgPswd.CngLogVid(logvEditRec); Flt[sMemo+'FLT']:=m; Flt.UpdateRec(true);
      end
      else TRecDB.RestInf(svi);
    end
    else begin
      TRecDB.RestInf(svi); Flt['NPP']:=Int0(Flt.KodNext('NPP',w));
    end;
  end;
  DelStack;
end;

class function TFltLs.SelPtrn;
begin
  AddStack('TFltLs.SelPtrn');
  if not Execute(result,Prog[fProgKP],'Шаблоны интернет сообщений ('+DM.ProgGet.MenuName(Prog[fProgKP])+')',
    SchemDM.MemoGet1,',,,3,Текст') then result:='';
  DelStack;
end;

procedure LogTrnsValProc(var Prm: TLogTrnsValPrm);
var gk: longint;
begin
  AddStack('FFltLs.LogTrnsValProc');
  with Prm do if LogEqual(Prm,tFLT) then begin
    gk:=Sender[fFltGK];
    if nmf=fFltGK then begin
      case gk of
        0: val:='Основы для формулы фильтра';
        fltgkLow..fltgkHigh: val:=aFltGk[gk];
      else val:='Шаблоны интернет сообщений ('+DM.ProgGet.MenuName(IntToStr(gk))+')';
      end;
      lBreak:=true;
    end
    else if nmf=sMemo+'FLT' then begin
      case gk of
        0: nm:='формула';
        fltgkLow..fltgkHigh: lOut:=false;
      else val:='шаблон';
      end;
      lBreak:=true;
    end
    else if nmf=fCDR then begin
      lOut:=InRange(gk,fltgkLow,fltgkHigh); lBreak:=true;
    end;
  end;
  DelStack;
end;

initialization
	AddStack('FFltLs.initialization');
  LogTrnsValProcAdd(LogTrnsValProc);
  LogFieldsBound.Add(tFLT+'.'+fFltGK);
  InterCurHelpFile:=HelpFileOrglist;
	TInter.SetFunction('FltLs','',c_fltls,null);
  DelStack;
end.

