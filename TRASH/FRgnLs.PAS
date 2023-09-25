unit FRgnLs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, Menus, DB, Grids, DBGrids, ExtCtrls,
  MyTypes, My_pr, FrmBrIB, KeyMenu, Browl, Keylb, Fpanel, DefEdit, FCngNum;

type
  TRgnLs = class(TFormBrIB)
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
  RgnLs: TRgnLs;

implementation

uses
  FrmPswd, MulQry, FFldEdit, 
  OLTypes,FDM;

{$R *.dfm}

procedure TRgnLs.FormCreate(Sender: TObject);
begin
  AddStack('TRgnLs.FormCreate',Self);
  inherited;
  with BrQuery1 do begin
  	Init(DBMain,[fRGN,fUPNAME],[],tRGN,[]);
    Browl1.FieldSeek:=CreateStringField(fRGN,'Номер');
    CreateField(fUPNAME).DisplayLabel:=CreateStringField(fNAME,'Наименование').DisplayLabel;
  end;
  DelStack;
end;

procedure TRgnLs.Browl1BrowlKey(key: Integer; tw: TWinControl);
var fl: boolean;
begin
  AddStack('TRgnLs.Browl1BrowlKey',Self);
  inherited;
  fl:=false;
  if BrQuery1.CanEdit(Key) then case Key of
  	K_F3: fl:=TCngNum.GetNewNum('Новый номер региона',Browl1,Rgn,fRGN,[tRGN,tPROG],[],'',NewCod);
    K_F4,K_F7: fl:=Browl1.AppRec('Добавить регион',Rgn,de,IfThen(Key),'',fRGN);
    K_F5: fl:=Browl1.EditRec('Редактировать регион',Rgn,de,fRGN);
    K_F8:
      if not ProgSeek(fRGN+'='+Vtos(Int0(Browl1.FieldSeek.AsString)),'Существуют программы по данному региону.')
      then fl:=Browl1.DelAsk(Rgn);
  end;
  if fl then begin
    DM.RgnGet.ClearBuf; ProgPswd.SendUpd(updCodeGet);
  end;
  DelStack;
end;

procedure TRgnLs.deFldExit(Sender: TObject);
begin
  AddStack('TRgnLs.deFldExit',Self);
  SpaceStrSelf(Sender,fRGN);
  DelStack;
end;

function TRgnLs.deFldCheck(Sender: TObject): Boolean;
begin
  AddStack('TRgnLs.deFldCheck',Self);
  KodCheck(Sender,fRGN,result);
  DelStack;
end;

class procedure TRgnLs.NewCod;
begin
  AddStack('TRgnLs.NewCod');
  Prog.UpdateTable([fRGN],[Int0(Rgn[fRGN])],fRGN+'='+Vtos(Int0(oldnum)));
  DelStack;
end;

procedure TRgnLs.WMFormLimit;
begin
	AddStack('TRgnLs.WMFormLimit',Self);
  inherited;
  FreeLimit(RgnLs);
  DelStack;
end;

end.
