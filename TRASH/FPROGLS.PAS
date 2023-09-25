unit FProgLs;

interface

{$I LIBTEST}
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, Menus, DB, DBTables, Grids, DBGrids, ExtCtrls,
  MyTypes, My_pr, FRMBRIB, KeyMenu, Browl, Keylb, Fpanel, FFldEdit;

type
  TSIObjList = (SI_OBJ_NONE,SI_OBJ_MSG,SI_OBJ_FILE,SI_OBJ_DP,SI_OBJ_ZAJ);

  PProgListRec = ^TProgListRec;
  TProgListRec = record
    plrTn,plrKp,plrData,plrZajTxt,plrZajTn,plrZajTd,plrZajIspTn,plrZajTispd,plrZajTispd1: string;
    plrObj: TSIObjList;
    plrZajIspv: longint;
  end;
  TProgLs = class(TFormBrIB)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure KeyLb1ProcKey(key: Integer; tw: TWinControl);
    procedure Browl1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Browl1DblClick(Sender: TObject);
  private
    FIsSending: boolean;
    FSlSel: TStringList;
    FFldKO,FFldKOD,FFldACID: TField;
    FFilter: PArrInt;
    FPlr: TProgListRec;
    procedure WMFormLimit(var Message: TMessage); message WM_FORMLIMIT;
    function GetSelId: string; overload;
    class function GetSelId(ko: longint; const cp: string; acid: longint): string; overload;
    procedure ToggleSelection(aDoNext: boolean);
    procedure BrQuery1FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure ProgLsCalcFields(DataSet: TDataSet);
  public
    FFldRecno: TIntegerField;
    FFldCP: TField;
    class function Str2SI(const s: string): TSIObjList; overload;
    class function Str2SI(tf: TFldEdit): TSIObjList; overload;
  end;

function ProgLsExec(const aCaption,aArgCp,aOrder: string; aFrm: ppointer=nil;
  aPlr: PProgListRec=nil; aFilter: PArrInt=nil; aSlSel: TStringList=nil): boolean;

var ProgLs: TProgLs;

implementation
{$R *.dfm}
{$B-}

uses
  StrUtils, Math,
  BufFile, mulqry, FrmPswd, Inter, FStat,
  SggUtils, ProgType, GGMReg,
  OLTypes, FDM, FAccLs, OLGets;

const KLB_PROGLS = 'KLB_PROGLS';

function ProgLsExec;
  procedure SetFieldVsb(const aName: string; aVsb: boolean);
  var f: TField;
  begin
    if ProgLs.BrQuery1.FindField(aName,f) then f.Visible:=aVsb;
  end;
var s: string;
begin
  AddStack('FProgLs.ProgLsExec');
  CreateForm(TProgLs,ProgLs);
  ProgLs.FIsSending:=(aPlr<>nil)and(aPlr^.plrKp<>'');
  Finalize(ProgLs.FPlr);
  if (aPlr<>nil) then ProgLs.FPlr:=aPlr^;
  ProgLs.Caption:=aCaption;
  ProgLs.KeyLb1.DelKey(K_ALL,KLB_PROGLS);
  ProgLs.FSlSel:=aSlSel;
  ProgLs.FFilter:=aFilter;
  ProgLs.BrQuery1.SetFilterProc(Assigned(aFilter),ProgLs.BrQuery1FilterRecord);
  if (ProgLs.FIsSending) then begin
    ProgLs.KeyLb1.SetKey(K_SPACE,'Отметка','',ProgLs.KeyLb1ProcKey,KLB_PROGLS,kmList);
    ProgLs.KeyLb1.SetKeySel([K_F2,K_Plus],[K_F3,K_Minus],ProgLs.KeyLb1ProcKey,KLB_PROGLS);
    ProgLs.KeyLb1.SetKeys([K_Shift_F2,K_Shift_Plus],'Отметить "Программы"','Отметить по выборке на странице "Программы"',ProgLs.KeyLb1ProcKey,KLB_PROGLS,kmList);
    ProgLs.KeyLb1.SetKey(K_F10,'Отправить','',ProgLs.KeyLb1ProcKey,KLB_PROGLS,kmList);
    ProgLs.BrQuery1.Arg[sWHERE]:=DlmBetween(
      [IfThen(not ProgLs.BrQuery1.Filtered,fCDR+'='+QQs(ProgLs.FPlr.plrTn))
      ,fProgKP+'='+QQs(ProgLs.FPlr.plrKp)
      ,QQNull(fACC,0,true)
      ,fProgCP+'<>'+QQs
      ,QQNull(fORG,0,true)
      ,tPROG+'.'+fORG+'='+tORG+'.'+fORG
      ],sAND);
    s:='KOD,'+fProgCP;
  end else begin
    ProgLs.BrQuery1.Arg[sWHERE]:=tPROG+'.'+fORG+'='+tORG+'.'+fORG+sAND+fORG+'='+qGlobKey+sAND+'{cp}';
    ProgLs.BrQuery1.Arg['cp']:=aArgCp;
    s:=aOrder;
  end;
  ProgLs.BrQuery1.Orders.Text:=s;
  SetFieldVsb('CKP',not ProgLs.FIsSending);
  SetFieldVsb('CTN',not ProgLs.FIsSending);
  SetFieldVsb(ProgFld[ofxAcc].ofvFld,ProgLs.FIsSending);
  SetFieldVsb('CSEL',ProgLs.FIsSending);
  SetFieldVsb('KOD',ProgLs.FIsSending);
  SetFieldVsb(ProgFld[ofxAccAct].ofvCalc,ProgLs.FIsSending);
  if (aFrm<>nil) then aFrm^:=ProgLs;
  if (not ProgLs.FIsSending) then result:=true
  else begin
    result:=(ProgLs.ShowModal=mrOk);
    FormFree(ProgLs);
  end;
  DelStack;
end;

procedure TProgLs.FormCreate(Sender: TObject);
begin
	AddStack('TProgLs.FormCreate',Self);
  inherited;
  with BrQuery1 do begin
    Connection:=DBMain;
    GlobKey:='0';
    Arg['cp']:=fProgCP+'<>'+QQs;
    FFldRecno:=Init(DBMain,[fProgCP],[],GetList([tPROG,tORG]),
      [fProgNP,fProgCP,fProgKP,fCDR,fDRV,'DIR','STATUS',tPROG+'.'+fRECNO,fORG,fACC,tORG+'.KOD'],
      tPROG+'.'+fORG+'='+tORG+'.'+fORG+sAND+QryNone{where не пусто!, т.к. динамически меняется в ProgLsExec},'',ProgLsCalcFields);
//    AfterOpen:=BrQuery1AfterOpen;
    CreateStringField('CSEL','Отправить');
    FFldKOD:=CreateStringField('KOD','Клиент',DM.ListGet.LenCode,taRightJustify);
    FFldCP:=CreateStringField(fProgCP,'Рег.N',0,taRightJustify);
    CreateStringField(fProgNP,'№ п/п',0,taRightJustify);
    CreateStringField('CND','Сетевой диск',Length(Drv[fNAME]));
    CreateStringField('DIR','Папка',30);
    CreateStringField('CKP','Вид',ProgFldDispWidth[ofxCnt]);
    CreateStringField('CTN','Ответственный',ProgFldDispWidth[ofxTN]);
    CreateStringField('CSTATUS','Статус',ProgFldDispWidth[ofxSTATUS]);
    with ProgFld[ofxAcc] do FFldACID:=CreateIntegerField(ofvFld,ofvName);
    FFldKO:=CreateIntegerField(fORG);
    FFldKO.Visible:=false;
    CreateField(VarArrayOf([fProgKP,fCDR,fDRV,'STATUS']));
    with ProgFld[ofxAccAct] do CreateStringField(ofvCalc,ofvName,ProgFldDispWidth[ofxAccAct]).Calculated:=true;
  end;
  DelStack;
end;

procedure TProgLs.ProgLsCalcFields;
var f: TField;
begin
  AddStack('TProgLs.ProgLsCalcFields',Self);
  DM.qProgCalcFields(DataSet);
  if BrQuery1.FindField(ProgFld[ofxAccAct].ofvCalc,f) and f.Visible
  then f.AsString:=Activity2Str(GetAccData(ADF_ACTIVITY,FFldACID.AsInteger));
  DelStack;
end;

procedure TProgLs.BrQuery1FilterRecord;
begin
  AddStack('TProgLs.BrQuery1FilterRecord',Self);
  Accept:=QuickFind(FFldRecno.AsInteger,FFilter^);
  DelStack;
end;

procedure TProgLs.FormShow(Sender: TObject);
var s: string;
begin
  AddStack('TProgLs.FormShow',Self);
  inherited;
  if (FIsSending) then s:='KOD' else s:=BrQuery1.Orders[0];
  Browl1.FieldSeek:=BrQuery1.FindField(s);
  //if (Browl1.FieldSeek<>nil) then Browl1.FieldSeek.Index:=1;
  MainRebuild;
  DelStack;
end;

procedure TProgLs.WMFormLimit;
begin
  AddStack('TProgLs.WMFormLimit',Self);
  inherited;
  FreeLimit(ProgLs);
  DelStack;
end;

function TProgLs.GetSelId: string;
begin
  result:=GetSelId(FFldKO.AsInteger,FFldCP.AsString,FFldACID.AsInteger);
end;

class function TProgLs.GetSelId(ko: longint; const cp: string; acid: longint): string;
begin
  result:=Format('%d,%s,%d',[ko,cp,acid]);
end;

procedure TProgLs.Browl1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  AddStack('TProgLs.Browl1DrawColumnCell',Self);
  if (FIsSending) then begin
    if (not(gdFixed in State))and(Assigned(Column.Field)) then begin
      if (Column.Field.FieldName='CSEL')and(FSlSel<>nil) then begin
        bmCheckPaint(TBrowl(Sender).Canvas,Rect,FSlSel.IndexOf(GetSelId)>=0);
      end;
    end;
  end;
  DelStack;
end;

procedure TProgLs.ToggleSelection;
begin
  AddStack('TProgLs.ToggleSelection',Self);
  if FIsSending then begin
    if BrQuery1.IsRecords and Assigned(FSlSel) then IgnoreSlAddDel(FSlSel,GetSelId);
    Browl1.Repaint;
    if aDoNext then BrQuery1.Next;
  end;
  DelStack;
end;

procedure TProgLs.Browl1DblClick(Sender: TObject);
begin
  inherited;
  ToggleSelection(false);
end;

procedure SelStat(Sender: TStat; const Params: array of variant; var Aborted: boolean);
var bm: TBookMark;
  i,lr: longint;
  id: string;
  a: TArrStr;
  lAll: boolean;
begin
  AddStack('FProgLs.SelStat');
  lAll:=Params[0];
  with ProgLs do begin
    if not lAll then begin
      TProgFldDef.BeforeForm(nil); aFltCur[false]:=true; SetLength(a,c_ProgBeg); i:=0;
      while not c_ProgEof do begin
        a[i]:=GetSelId(Prog[fORG],Prog[fProgCP],Prog[fACC]); Inc(i); c_ProgNext;
      end;
      c_ProgEnd; TProgFldDef.AfterForm(nil); QuickSort(a); Sender.SayStat('Отметка программ');
    end;
    with BrQuery1 do begin
      bm:=GetBookMark; DisableControls; lr:=RecordCount; First;
      for i:=1 to lr do begin
        if Sender.SayStat('','Клиент: '+FFldKO.AsString+'  Программа: '+FFldCP.AsString,i/lr) then break;
        id:=GetSelId;
        if lAll or QuickFind(id,a) then FSlSel.Add(id);
        Next;
      end;
      GotoBookMark(bm); FreeBookMark(bm); EnableControls;
    end;
  end;
  DelStack;
end;

procedure SendingStat(Sender: TStat; const Params: array of variant; var Aborted: boolean);
var k,j,cnt: longint;
  sl,slSel: TStringList;
  sa,saDir,saDp: TArrStr;
  s,t,u,v,capt,sDir,sRegNum,sAcid,path2,path3: string;
  fn: TFileName;
  prc,prcInc: double;
  oLogKeys: PLogKeysSave;
begin
  AddStack('FProgLs.SendingStat');
  slSel:=SortStrListCreate;
  with ProgLs do try
    case FPlr.plrObj of
      SI_OBJ_DP: begin
        for k:=0 to FSlSel.Count-1 do begin
          TokenStr(FSlSel[k],',',sa);
          if (high(sa)<2) then continue;
          slSel.Add(',,'+sa[2]);
        end;(* for k *)
      end;
      SI_OBJ_ZAJ: begin
        for k:=0 to FSlSel.Count-1 do begin
          TokenStr(FSlSel[k],',',sa);
          if (high(sa)<1) then continue;
          slSel.Add(sa[0]+','+sa[1]+',');
        end;(* for k *)
      end;
      else begin
        slSel.Assign(FSlSel);
      end;
    end;
    cnt:=slSel.Count;
    if (cnt>0) then begin
      prcInc:=0;
      if (FPlr.plrObj=SI_OBJ_DP) then begin
        TokenStr(FPlr.plrData,CRLF,saDp,true);
        if (saDp<>nil) then prcInc:=(1/cnt)/length(saDp);
      end;
      oLogKeys:=ProgPswd.PLogKeysLen; sl:=SortStrListCreate;
      try
        SetLength(saDir,cnt);
        for k:=0 to cnt-1 do begin
          TokenStr(slSel[k],',',sa,true);
          if (high(sa)<2) then continue;
          sRegNum:=Trim(ListKod(StrToIntDef(sa[0],0)))+'-'+sa[1];
          sAcid:=sa[2];
          capt:=IfThen(FPlr.plrObj=SI_OBJ_DP,sAcid,sRegNum);
          prc:=k/cnt;
          if (Sender.SayStat('',capt,prc)) then begin
            break;
          end;
          if (FPlr.plrObj<>SI_OBJ_ZAJ) then begin
            if (not IgnoreSlFindAdd(sl,sAcid,j)) then begin
              saDir[k]:=GetFtpDir(sAcid);
              sl.Objects[j]:=pointer(k);
            end;
            sDir:=saDir[IntObj(sl,j)];
            if (sDir='') then continue;
            s:=CorrDir(sDir)+SmailDirBox[true,false]+PathDelim;
          end;
          case FPlr.plrObj of
            SI_OBJ_MSG: begin
              GetUniqueFn(GetPckPref(ABR_MSG,sRegNum),s,'',sDir,FILE_MSG_EXT,fn);
              SetStrFile(s+fn+FILE_MSG_EXT,FPlr.plrData);
            end;
            SI_OBJ_FILE: begin
              t:=GetProgInf(Int0(FPlr.plrKp)).Abr;
              GetUniqueFn(GetPckPref(t,sRegNum),s,'',sDir,EXTPCK,fn);
              CopyFileOpt(FPlr.plrData,s+fn+EXTPCK,[cfNoSetAttr,cfStat]);
            end;
            SI_OBJ_DP: begin
              path2:=CorrDir(sDir)+SmailDirOnServer+PathDelim;
              path3:=CorrDir(sDir)+SmailDirBox[true,true]+PathDelim;
              for j:=0 to high(saDp) do begin
                t:=saDp[j];
                if (not FileExists(t)) then continue;
                u:=ExtractFileName(t);
                if (Sender.SayStat('',capt+': '+u,prc+j*prcInc)) then begin
                  break;
                end;
                v:=s+u;
                if (not FileExists(v)) then begin
                  v:=path2+u;
                  if (not FileExists(v)) then begin
                    v:=path3+u;
                    if (not FileExists(v)) then v:='';
                  end;
                end;
                if (v='')or(CompareUtils(t,v)>0) then
                  if not CopyFileOpt(t,s+u,[cfStat,cfMsg]) then begin
                    Aborted:=true; break;
                  end;
              end;(* for j *)
              if Aborted then break;
            end;
            SI_OBJ_ZAJ: begin
              SetLogVid(logvAppRec);
              Zaj.NewRec;
              Zaj[fCDR]:=FPlr.plrZajTn;
              Zaj['ISPTN']:=FPlr.plrZajIspTn;
              Zaj['ISPV']:=FPlr.plrZajIspv;
              Zaj[fTD]:=FPlr.plrZajTd;
              Zaj['TISPD']:=FPlr.plrZajTispd;
              Zaj['TISPD1']:=FPlr.plrZajTispd1;
              aSplitTxt254(Zaj,FPlr.plrZajTxt);
              if (TrimUpper(Zaj[fCDR])=TrimUpper(FPlr.plrTn)) then begin
                Zaj['SEL']:=bTrue;
              end;
              Zaj[fORG]:=StrToIntDef(sa[0],0);
              Zaj[fProgCP]:=SpaceStr(sa[1],CODSZ_PRG);
              if (not empty(Zaj[fORG]))and(not empty(Zaj[fProgCP])) then begin
                Prog.Seek(Prog.TblFldName(fORG)+'='+Vtos(Zaj[fORG])
                  +sAND+Prog.TblFldName(fProgCP)+'='+QQs(Zaj[fProgCP]));
                ProgPswd.LogKeys:=nil; ProgLogKeysAdd; Zaj.AppRec(true);
              end;
              SetLogVid;
            end;
          end;
        end;(* for k *)
      finally
        sl.Free; ProgPswd.PLogKeys:=oLogKeys;
      end;
    end;
  finally
    slSel.Free;
  end;
  DelStack;
end;

procedure TProgLs.KeyLb1ProcKey(key: Integer; tw: TWinControl);
var lAll: boolean;
begin
  AddStack('TProgLs.KeyLb1ProcKey',Self);
  inherited;
  case key of
    K_SPACE: begin
      ToggleSelection(true);
    end;
    K_F2,K_Plus,K_Shift_F2,K_Shift_Plus: begin
      lAll := Key in [K_F2,K_Plus];
      if Ask([IfThen(lAll,'Отметить все','Отметить по выборке на странице "Программы"')+' ?'])
      then ShowStat(IfThen(lAll,'Отметка программ','Поиск программ по выборке'),SelStat,[lAll]);
    end;
    K_F3,K_Minus: if AskSel(false) then begin
    	FSlSel.Clear; Browl1.BrUpdate;
    end;
    K_F10: begin
      if (FIsSending) then begin
        ModalResult:=mrNone;
        if FSlSel.Count=0 then mess_ok(['Необходимо выбрать хотя-бы одну программу.'])
        else if not ShowStat('Отправка',SendingStat) then ModalResult:=mrOk;
      end;
    end;
  end;
  DelStack;
end;

class function TProgLs.Str2SI(const s: string): TSIObjList;
var i: longint;
begin
  AddStack('TProgLs.Str2SI');
  i:=Int0(s);
  if InRange(i,byte(low(TSIObjList)),byte(high(TSIObjList)))
  then result:=TSIObjList(i)
  else result:=SI_OBJ_NONE;
  DelStack;
end;

class function TProgLs.Str2SI(tf: TFldEdit): TSIObjList;
begin
  result:=TProgLs.Str2SI(tf.Value);
end;

end.
