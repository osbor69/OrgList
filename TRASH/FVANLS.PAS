unit FVanLs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, Menus, DB, DBTables, Grids, DBGrids, ExtCtrls,
  MyTypes, My_pr, FRMBRIB, KeyMenu, Browl, Keylb, Fpanel;

type
  TVanLs = class(TFormBrIB)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
		procedure WMFormLimit(var Message: TMessage); message WM_FORMLIMIT;
  public
    { Public declarations }
  end;

var
  VanLs: TVanLs;

implementation

uses
  OLTypes,FDM;

{$R *.dfm}

procedure TVanLs.FormCreate(Sender: TObject);
begin
	AddStack('TVanLs.FormCreate',Self);
  inherited;
  with BrQuery1 do begin
  	Init(DBBuh,['VIDNO'],[],tVAN,['VIDNO',fNAME,fRECNO,'LENKOD']);
    Browl1.FieldSeek:=CreateStringField('VIDNO','Номер',0,taRightJustify);
    CreateStringField(fNAME,'Наименование');
    CreateField('LENKOD');
  end;
	DelStack;
end;

procedure TVanLs.WMFormLimit;
begin
	AddStack('TVanLs.WMFormLimit',Self);
  inherited;
  FreeLimit(VanLs);
  DelStack;
end;

end.
