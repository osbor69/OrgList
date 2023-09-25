unit FOfisLs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, Menus, DB, DBTables, Grids, DBGrids, ExtCtrls, Math, StrUtils,
  FRMBRIB, KeyMenu, Browl, Keylb, Fpanel;

type
  TOfisLs = class(TFormBrIB)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    BrQuery1STATUS: TIntegerField;
    BrQuery1TD: TStringField;
    BrQuery1CTD: TDateTimeField;
    BrQuery1CSTATUS: TStringField;
    procedure BrQuery1CalcFields(DataSet: TDataSet);
  public
    { Public declarations }
  end;

var
  OfisLs: TOfisLs;

implementation

{$R *.dfm}

uses
  MyTypes, My_pr, mulqry, FrmPswd,  
  OLTypes,FDM,OLProc;

procedure TOfisLs.FormCreate(Sender: TObject);
begin
	AddStack('TOfisLs.FormCreate',Self);
  inherited;
  with BrQuery1 do begin
    Connection:=DBMain; GlobKey:=QQs;
    Init(DBMain,[fTD],[],tOFIS,[],fCDR+'='+qGlobKey,'',BrQuery1CalcFields);
    BrQuery1CTD:=CreateDateField('CTD','Дата','dd/mm/yyddd hh:nn',LenDispDate);
    BrQuery1CSTATUS:=CreateStringField('CSTATUS','Статус',lStatus);
    BrQuery1STATUS:=CreateIntegerField('STATUS'); BrQuery1STATUS.Visible:=false;
    BrQuery1TD:=CreateStringField(fTD); BrQuery1TD.Visible:=false;
  end;
  DelStack;
end;

procedure TOfisLs.BrQuery1CalcFields;
var status: TCdrStatList;
begin
	AddStack('TOfisLs.BrQuery1CalcFields',Self);
  BrQuery1CTD.AsDateTime:=StringToDate(BrQuery1TD.AsString);
  status:=CdrStatList(BrQuery1STATUS.AsInteger);
  if status<>cstNone then BrQuery1CSTATUS.AsString:=aCdrStat[status];
  DelStack;
end;

end.
