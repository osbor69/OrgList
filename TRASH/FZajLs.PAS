unit FZajLs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, Menus, DB, DBTables, Grids, DBGrids, ExtCtrls, StrUtils,
  MyTypes, My_pr, FRMBRIB, KeyMenu, Browl, Keylb, Fpanel;

type
  TZajLs = class(TFormBrIB)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    BrQuery1RECNO: TIntegerField;
    procedure SetTab;
    procedure ProcKey(Key: longint; tw: TWinControl);
    procedure BrQuery1FilterRecord(DataSet: TDataSet; var Accept: Boolean);
		procedure WMRebuild(var Message: TWMRebuild); message WM_REBUILD;
		procedure WMFormLimit(var Message: TMessage); message WM_FORMLIMIT;
  public
    { Public declarations }
  end;

var
  ZajLs: TZajLs;
  ZajRecno: longint;

implementation

{$R *.dfm}

uses mulqry, FrmPswd,
  OLTypes,FDM;

procedure TZajLs.FormCreate(Sender: TObject);
begin
	AddStack('TZajLs.FormCreate',Self);
  inherited;
  BrQuery1RECNO:=BrQuery1.Init(DBMain,['TDISPD'],[],tZAJ,[],QryNone);
  BrQuery1.OnFilterRecord:=BrQuery1FilterRecord;
  DelStack;
end;

procedure TZajLs.FormShow(Sender: TObject);
begin
  AddStack('TZajLs.FormShow',Self);
  SetTab;
  inherited;
  with BrQuery1 do if ZajRecno=0 then Last
  else begin
    First;
    while not Eof and (BrQuery1RECNO.AsInteger<>ZajRecno) do Next;
  end;
  MainRebuild;
  DelStack;
end;

procedure TZajLs.SetTab;
begin
  AddStack('TZajLs.SetTab',Self);
  KeyLb1.SetKey(K_Tab,IfThen(BrQuery1.Filtered,'Все','Неисполн.'),
    IfThen(BrQuery1.Filtered,'Просмотр всех заявок','Просмотр только неисполненных заявок'),
    ProcKey,'zaj',kmList);
  DelStack;
end;

procedure TZajLs.ProcKey;
begin
  AddStack('TZajLs.ProcKey',Self);
  BrQuery1.Filtered:=not BrQuery1.Filtered; SetTab; KeyLb1.ReDrw;
  DelStack;
end;

procedure TZajLs.BrQuery1FilterRecord;
begin
  AddStack('TZajLs.BrQuery1FilterRecord',Self);
  if Browl1.OnGrayCell(Browl1,Rect0,0,nil,[]) then Accept:=false;
  DelStack;
end;

procedure TZajLs.WMRebuild;
begin
  AddStack('TZajLs.WMRebuild',Self);
  if Message.Oper=rbBefore then Browl1.ColWidths[0]:=bmCheckSize.cX+2;
  DelStack;
end;

procedure TZajLs.WMFormLimit;
begin
	AddStack('TZajLs.WMFormLimit',Self);
  inherited;
  FreeLimit(ZajLs);
  DelStack;
end;

end.
