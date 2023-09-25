unit FMDPLs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Menus, DB,
    Grids, DBGrids,ExtCtrls,
  MyTypes, FrmBrIB, KeyMenu, Browl, Keylb, Fpanel, DefEdit;

type
  TMDPLs = class(TFormBrIB)
    de: TDefEdit;
    procedure FormCreate(Sender: TObject);
    procedure Browl1BrowlKey(key: Integer; tw: TWinControl);
  private
    { Private declarations }
		procedure WMFormLimit(var Message: TMessage); message WM_FORMLIMIT;
  public
    { Public declarations }
    Modified: boolean;
    class procedure Prepare(const path: string);
  end;

var
  MDPLs: TMDPLs;

implementation

{$R *.dfm}

uses My_Pr,FrmPswd,
  OLTypes,FDM;

class procedure TMDPLs.Prepare;
begin
  AddStack('TMDPLs.Prepare');
  CreateForm(TMDPLs,MDPLs,true);
  with MDPLs do begin
    BrQuery1.Arg['id']:=Vtos(Cngv[fMDP]); Modified:=false;
    if path<>'' then with BrQuery1 do begin
      Open; DisableControls;
      while not Eof and (TrimRight(Browl1.FieldSeek.AsString)<>path) do Next;
      EnableControls;
    end;
  end;
  DelStack;
end;

procedure TMDPLs.FormCreate(Sender: TObject);
begin
  AddStack('TMDPLs.FormCreate',Self);
  inherited;
  with BrQuery1 do begin
    Arg['id']:=Vtos(1);
    Init(DBMain,[fMdPATH],[],tMDP,[fRECNO,fMdPATH,'ABR'],fMDP+'={id}');
    Browl1.FieldSeek:=CreateStringField(fMdPATH);
    CreateStringField('ABR');
  end;
  DelStack;
end;

procedure TMDPLs.Browl1BrowlKey(key: Integer; tw: TWinControl);
  procedure Modify;
  begin
    AddStack('TMDPLs.Browl1BrowlKey.Modify',Self);
    DM.MDPGet.ClearBuf; ProgPswd.SendUpd(updCodeGet); Modified:=true;
    DelStack;
  end;
begin
  AddStack('TMDPLs.Browl1BrowlKey',Self);
  case Key of
    K_F5,K_Enter: if Browl1.EditRec('Вид основ: '+TrimRight(Browl1.FieldSeek.AsString),MDP,de) then Modify;
    K_F8: if Browl1.DelAsk(MDP) then Modify;
  end;
  DelStack;
end;

procedure TMDPLs.WMFormLimit;
begin
	AddStack('TMDPLs.WMFormLimit',Self);
  inherited;
  FreeLimit(MDPLs);
  DelStack;
end;

end.
