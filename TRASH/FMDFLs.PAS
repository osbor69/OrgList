unit FMDFLs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Menus, DB,
    Grids, DBGrids, ExtCtrls,
  MyTypes, FrmBrIB, KeyMenu, Browl, Keylb, Fpanel;

type
  TMDFLs = class(TFormBrIB)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
		procedure WMFormLimit(var Message: TMessage); message WM_FORMLIMIT;
  end;

var
  MDFLs: TMDFLs;

implementation

{$R *.dfm}

uses My_Pr,
  OLTypes;

procedure TMDFLs.FormCreate(Sender: TObject);
begin
  AddStack('TMDFLs.FormCreate',Self);
  inherited;
  with BrQuery1 do begin
    Arg['kc']:='1'; GlobKey:='1';
    Init(DBMain,[fMdFILE],[],tMDF,[fRECNO,fMdFILE,fNAME],fCNGV+'='+QQs('{kc}')+sAND+fMdPATH+'='+QQs(qGlobKey));
    Browl1.FieldSeek:=CreateStringField(fMdFILE);
    CreateStringField(fNAME);
  end;
  DelStack;
end;

procedure TMDFLs.WMFormLimit;
begin
	AddStack('TMDFLs.WMFormLimit',Self);
  inherited;
  FreeLimit(MDFLs);
  DelStack;
end;

end.
