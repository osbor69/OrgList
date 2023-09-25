unit FOrgLs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, Menus, DB, DBTables, Grids, DBGrids, ExtCtrls,
  MyTypes, My_pr, FRMBRIB, KeyMenu, Browl, Keylb, Fpanel;

type
  TOrgLs = class(TFormBrIB)
    procedure FormCreate(Sender: TObject);
    procedure Browl1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    BrQuery1SEL: TBooleanField;
    ls: TStringList;
    procedure BrQuery1BeforeOpen(DataSet: TDataSet);
    procedure BrQuery1AfterOpen(DataSet: TDataSet);
    procedure BrQuery1CalcFields(DataSet: TDataSet);
    procedure SelKey(key: longint; tw: TWinControl);
		procedure WMFormLimit(var Message: TMessage); message WM_FORMLIMIT;
  public
    { Public declarations }
		class procedure Execute(Sender: TObject);
  end;

var
  OrgLs: TOrgLs;

implementation

{$R *.dfm}

uses
  FFldEdit, FrmPswd, 
  OLTypes,FDM;

class procedure TOrgLs.Execute;
var tf: TFldEdit;
	i: longint;
  bm: TBookMark;
begin
	AddStack('TOrgLs.Execute');
  tf:=pointer(Sender); CreateForm(TOrgLs,OrgLs);
  with OrgLs do begin
  	ls:=TStringList.Create;
    try
      ls.Text:=TrimRight(StrTran(tf.Value,',',CRLF)); SpaceStrList(ls,DM.ListGet.LenCode); ls.Sorted:=true;
      with KeyLb1 do begin
      	SetKeys([K_Space,K_Enter,K_Ins],'Отметить','',SelKey,'sel',kmList);
      	SetKeySel([K_F2,K_Plus],[K_F3,K_Minus],SelKey,'sel');
        Redrw;
      end;
      BrQuery1SEL.Visible:=true; ShowModal;
      BrQuery1SEL.Visible:=false; KeyLb1.DelKey(K_All,'sel'); KeyLb1.Redrw;
      with BrQuery1 do begin
      	DisableControls; Open; bm:=GetBookMark; First;
        while not Eof do begin
        	if ls.Find(TrimRight(Browl1.FieldSeek.AsString),i) then ls.Objects[i]:=ObjectTrue;
        	Next;
        end;
        BoolObjPack(ls); GotoBookMark(bm); FreeBookMark(bm); EnableControls; Close;
      end;
      ls.Sorted:=false; TrimSelf(ls); tf.Value:=StrTran(TrimRight(ls.Text),CRLF,',');
    finally
      ls.Free;
    end;
  end;
  FormFree(OrgLs);
  DelStack;
end;

procedure TOrgLs.SelKey;
var bm: TBookMark;
begin
	AddStack('TOrgLs.SelKey',Self);
  case Key of
    K_F2,K_Plus: if AskSel(true) then with BrQuery1 do begin
    	bm:=GetBookMark; DisableControls; First;
      while not Eof do begin
      	ls.Add(TrimRight(Browl1.FieldSeek.AsString)); Next;
      end;
      GotoBookMark(bm); FreeBookMark(bm); EnableControls;
    end;
    K_F3,K_Minus: if AskSel(false) then begin
    	ls.Clear; Browl1.BrUpdate;
    end;
  else
  	IgnoreSlAddDel(ls,TrimRight(Browl1.FieldSeek.AsString)); Browl1.BrUpdate;
    if Key=K_Ins then BrQuery1.Next;
  end;
  DelStack;
end;

procedure TOrgLs.FormCreate(Sender: TObject);
begin
	AddStack('TOrgLs.FormCreate',Self);
  inherited;
  with BrQuery1 do begin
  	Init(DBMain,[nmfbKOD,fUPNAME],[nmfbKOD],tLIST,[nmfbKOD,fNAME,fUPNAME,fRECNO,nmfbKO],'','',BrQuery1CalcFields);
    BeforeOpen:=BrQuery1BeforeOpen; AfterOpen:=BrQuery1AfterOpen;
    BrQuery1SEL:=CreateBooleanField('SEL'); BrQuery1SEL.Visible:=false;
    Browl1.FieldSeek:=CreateStringField(nmfbKOD,'Номер',DM.ListGet.LenCode,taRightJustify);
    CreateField(fUPNAME).DisplayLabel:=CreateStringField(fNAME,'Наименование',DM.ListGet.LenName).DisplayLabel;
    CreateField(nmfbKO);
  end;
  DelStack;
end;

procedure TOrgLs.WMFormLimit;
begin
	AddStack('TOrgLs.WMFormLimit',Self);
  inherited;
  FreeLimit(OrgLs);
  DelStack;
end;

procedure TOrgLs.BrQuery1BeforeOpen;
begin
  AddStack('TOrgLs.BrQuery1BeforeOpen',Self);
  LockBuhRead;
  DelStack;
end;

procedure TOrgLs.BrQuery1AfterOpen;
begin
  AddStack('TOrgLs.BrQuery1AfterOpen',Self);
  UnlockMode('FBUH');
  DelStack;
end;

procedure TOrgLs.BrQuery1CalcFields;
begin
	AddStack('TOrgLs.BrQuery1CalcFields',Self);
  if BrQuery1SEL.Visible then BrQuery1SEL.AsBoolean := ls.IndexOf(TrimRight(Browl1.FieldSeek.AsString)) >= 0;
  DelStack;
end;

procedure TOrgLs.Browl1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
	AddStack('TOrgLs.Browl1DrawColumnCell',Self);
  inherited;
	Browl1.bmCheckPaint(Rect,Column);
  DelStack;
end;

end.
