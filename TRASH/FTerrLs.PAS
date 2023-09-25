unit FTerrLs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, Menus, DB, Grids, DBGrids, ExtCtrls,
  MyTypes, My_pr, FrmBrIB, KeyMenu, Browl, Keylb, Fpanel, DefEdit, FCngNum;

type
  TTerrLs = class(TFormBrIB)
    de: TDefEdit;
    procedure FormCreate(Sender: TObject);
    procedure Browl1BrowlKey(key: Integer; tw: TWinControl);
    procedure deFldExit(Sender: TObject);
    function deFldCheck(Sender: TObject): Boolean;
  private
    { Private declarations }
    class procedure NewCod(const oldnum: string; Options: TCngNumOptions; var result: boolean);
		procedure WMFormLimit(var Message: TMessage); message WM_FORMLIMIT;
  public
    { Public declarations }
  end;

var
  TerrLs: TTerrLs;

implementation

uses
  FrmPswd, MulQry, FFldEdit,
  OLTypes,FDM;

{$R *.dfm}

procedure TTerrLs.FormCreate(Sender: TObject);
begin
  AddStack('TTerrLs.FormCreate',Self);
  inherited;
  with BrQuery1 do begin
  	Init(DBMain,[fTERR,fUPNAME],[],tTERR,[]);
    Browl1.FieldSeek:=CreateStringField(fTERR,'Номер');
    CreateField(fUPNAME).DisplayLabel:=CreateStringField(fNAME,'Наименование').DisplayLabel;
  end;
  DelStack;
end;

procedure TTerrLs.Browl1BrowlKey(key: Integer; tw: TWinControl);
var fl: boolean;
begin
  AddStack('TTerrLs.Browl1BrowlKey',Self);
  inherited;
  fl:=false;
  if BrQuery1.CanEdit(Key) then case Key of
  	K_F3: fl:=TCngNum.GetNewNum('Новый номер территории',Browl1,Terr,fTERR,[tTERR,tPROG],[],'',NewCod);
    K_F4,K_F7: fl:=Browl1.AppRec('Добавить территорию',Terr,de,IfThen(Key),'',fTERR);
    K_F5: fl:=Browl1.EditRec('Редактировать территорию',Terr,de,fTERR);
    K_F8:
      if not ProgSeek(fTERR+'='+Vtos(Int0(Browl1.FieldSeek.AsString)),'Существуют программы по данной территории.')
      then fl:=Browl1.DelAsk(Terr);
  end;
  if fl then begin
    DM.TerrGet.ClearBuf; ProgPswd.SendUpd(updCodeGet);
  end;
  DelStack;
end;

procedure TTerrLs.deFldExit(Sender: TObject);
begin
  AddStack('TTerrLs.deFldExit',Self);
  SpaceStrSelf(Sender,fTERR);
  DelStack;
end;

function TTerrLs.deFldCheck(Sender: TObject): Boolean;
begin
  AddStack('TTerrLs.deFldCheck',Self);
  KodCheck(Sender,fTERR,result);
  DelStack;
end;

class procedure TTerrLs.NewCod;
begin
  AddStack('TTerrLs.NewCod');
  Prog.UpdateTable([fTERR],[Int0(Terr[fTERR])],fTERR+'='+Vtos(Int0(oldnum)));
  DelStack;
end;

procedure TTerrLs.WMFormLimit;
begin
	AddStack('TTerrLs.WMFormLimit',Self);
  inherited;
  FreeLimit(TerrLs);
  DelStack;
end;

end.
