unit FSendDp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, ExtCtrls, Menus, Grids,
  MyTypes, FRMEMPTY, Keylb, Fpanel, KeyMenu, FFldedit, StrBrowl, PnlEdit, RecVal;

{$I LIBTEST}

type
  TSendDp = class(TFormEmp)
    KeyMenu1: TKeyMenu;
    PanelEdit1: TPanelEdit;
    RbPanel3: TRbPanel;
    SbFiles: TStringBrowl;
    FeFrom: TFldEdit;
    RvSendDp: TRecVal;
    procedure FeFromChange(Sender: TObject; const OldVal: Variant; FromShow: Boolean);
    procedure KeyLb1ProcKey(key: Integer; tw: TWinControl);
    procedure SbFilesDblClick(Sender: TObject);
    procedure RbPanel3Enter(Sender: TObject);
    procedure RbPanel3Exit(Sender: TObject);
    function FeFromCheck(Sender: TObject): Boolean;
    procedure SbFilesBeforeDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    lsFiles: TStringList;
    FFiles2Sel,FAbr,FPathFiles: string;
    procedure FillFilesGet;
    function ActionOnSave: Boolean;
    procedure SelectAction(aSelNextRow: boolean);
  end;

function SendDpExec(var aDirSrc,aFiles: string; const aAbr: string): boolean;

implementation
{$R *.dfm}
{$B-}

uses
  Math, StrUtils,
  My_pr, Pack,
  FSGWMain, GGMReg, SggUtils;

var SendDp: TSendDp;

const
  STR_SELECTED  = 'ДА';
  KEYLB_PARENT = 'sendopkeylb';
  SBIX_FILE = 5;

function SendDpExec;
var k: longint;
begin
  AddStack('FSendDp.SendDpExec');
  CreateForm(TSendDp,SendDp);
  try
    SendDp.FPathFiles:='';
    SendDp.FFiles2Sel:=TrimRight(aFiles);
    SendDp.FAbr:=aAbr;
    SendDp.SbFiles.ColZn.Text:=
      'Отправить##'+CRLF+
      'Имя##L'+CRLF+
      'Описание##L'+CRLF+
      'Для##L'+CRLF+
      'Версия##R'+CRLF+
      'Имя файла##L';
    SendDp.MainRebuild;
    SendDp.FeFrom.VarValue:=aDirSrc;

    result:=(SendDp.ShowModal=mrOk);
    if (result) then begin
      aDirSrc:=CorrDir(SendDp.RvSendDp[SendDp.FeFrom.NameRecFld]);
      aFiles:='';
      for k:=0 to SendDp.lsFiles.Count-1 do IncD(aFiles,aDirSrc+SendDp.lsFiles[k]+CRLF);
    end;
  finally
    FormFree(SendDp);
  end;
  DelStack;
end;

procedure TSendDp.FormCreate(Sender: TObject);
begin
  AddStack('TSendDp.FormCreate',Self);
  inherited;
  lsFiles:=TStringList.Create;
  DelStack;
end;

procedure TSendDp.FormDestroy(Sender: TObject);
begin
  AddStack('TSendDp.FormDestroy',Self);
  lsFiles.Free;
  inherited;
  DelStack;
end;

procedure TSendDp.FillFilesGet;
var s,t,pathSrc: string;
  i: longint;
  dh: TDopHeader;
  b,isSftp,bsel: boolean;
  sl: TStringList;
  sa: TArrStr;
begin
  AddStack('TSendDp.FillFilesGet');
  pathSrc:=CorrDir(RvSendDp[FeFrom.NameRecFld]);
  lsFiles.Sorted:=false;
  GetMaskFiles(lsFiles,pathSrc+GGMasterSetupExeFile);
  i:=lsFiles.Count;
  GetMaskFiles(lsFiles,pathSrc+DIR_UTEXE+PathDelim+DOP_PREFIX+'*',[],[msfAdd]);
  for i:=i to lsFiles.Count-1 do IncL(lsFiles,i,DIR_UTEXE+PathDelim);
  lsFiles.Sorted:=true;
  SbFiles.Init;
  if lsFiles.Count>0 then begin
    if (FFiles2Sel<>'') then begin
      TokenStr(FFiles2Sel,CRLF,sa,true);
      FFiles2Sel:='';
    end;
    sl:=SortStrListCreate;
    try
      for i:=0 to high(sa) do if sa[i]<>'' then sl.Add(ExtractFileName(sa[i]));
      SbFiles.RowCount:=lsFiles.Count+1;
      for i:=1 to lsFiles.Count do begin
        s:=lsFiles[i-1];
        t:=ExtractFileName(s);
        b:=AnsiStartsText(DOP_PREFIX,t);
        if (b) then DopGetHeader(pathSrc+s,dh);
        isSftp:=(b)and(TrimUpper(dh.dhName)=TrimUpper(UTILCOD_SFTP));
        if (sl.Count>0) then bsel:=(sl.IndexOf(t)>=0)
        else begin
          if (b) then bsel:=(IsItemInCommaEnum(FAbr,dh.dhProgs))and(not isSftp)
          else bsel:=false;
        end;
        SbFiles.Cells[0,i]:=IfThen(bsel,STR_SELECTED);
        SbFiles.Cells[1,i]:=IfThen(b,dh.dhName,t);
        SbFiles.Cells[2,i]:=IfThen(b,dh.dhPrim);
        SbFiles.Cells[3,i]:=IfThen(b,dh.dhProgs);
        SbFiles.Cells[4,i]:=IfThen(b,IntToStr(dh.dhVers));
        SbFiles.Cells[SBIX_FILE,i]:=s;
      end;(* for i *)
    finally
      sl.Free;
    end;
    SbFiles.AdjustColsWidth;
    MainRebuild;
  end;
  DelStack;
end;

procedure TSendDp.FeFromChange(Sender: TObject; const OldVal: Variant; FromShow: Boolean);
var s: string;
begin
  AddStack('TSendDp.FeFromChange');
  inherited;
  TSGWMain.RootFlop(Sender,FeFrom.NameRecFld);
  
  s:=TrimUpper(CorrDir(RvSendDp[FeFrom.NameRecFld]));
  if (FPathFiles='')or(FPathFiles<>s) then begin(* т.к. Change может вызываться хрен знает когда *)
    FPathFiles:=s;
    FillFilesGet;
  end;
  DelStack;
end;

function TSendDp.ActionOnSave;
var i,j: longint;
begin
  AddStack('TSendDp.ActionOnSave');
  inherited;
  result:=true;
  i:=0;
  j:=1;
  while i<lsFiles.Count do begin
    if (SbFiles.Cells[0,j]=STR_SELECTED) then inc(i) else lsFiles.Delete(i);
    inc(j);
  end;(* while i *)
  DelStack;
end;

procedure TSendDp.SelectAction;
var k: longint;
begin
  k:=SbFiles.Row;
  if (InRange(k,1,SbFiles.RowCount-1)) then begin
    if (SbFiles.Cells[SBIX_FILE,k]<>'') then begin
      SbFiles.Cells[0,k]:=IfThen(SbFiles.Cells[0,k]<>STR_SELECTED,STR_SELECTED);
    end;
    if (aSelNextRow) then begin
      if (k<SbFiles.RowCount-1) then SbFiles.Row:=k+1;
    end;
  end;
end;

procedure TSendDp.KeyLb1ProcKey(key: Integer; tw: TWinControl);
begin
  case key of
    K_F10: begin
      if (ActionOnSave) then ModalResult:=mrOk;
    end;
    K_SPACE: begin
      SelectAction(true);
    end;
    else inherited;
  end;
end;

procedure TSendDp.SbFilesDblClick(Sender: TObject);
begin
  inherited;
  SelectAction(false);
end;

procedure TSendDp.RbPanel3Enter(Sender: TObject);
begin
  inherited;
  KeyLb1.SetKey(K_F10,'Продолжить','',KeyLb1ProcKey,KEYLB_PARENT,kmList);
  KeyLb1.SetKey(K_SPACE,'Отметка','',KeyLb1ProcKey,KEYLB_PARENT,kmList);
end;

procedure TSendDp.RbPanel3Exit(Sender: TObject);
begin
  inherited;
  KeyLb1.DelKey(K_ALL,KEYLB_PARENT);
end;

function TSendDp.FeFromCheck(Sender: TObject): Boolean;
begin
  inherited;
  result:=DirectoryExists(FeFrom.VarValue);
end;

procedure TSendDp.SbFilesBeforeDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  inherited;
  if (SbFiles.Cells[0,ARow]<>STR_SELECTED)and(not(gdSelected in State)) then begin
    SbFiles.Canvas.Brush.Color:=SbFiles.FixedColor;
  end;
end;

end.
