unit FMDTLs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Menus, DB, Grids,
    DBGrids, ExtCtrls,
  MyTypes, FrmBrIB, KeyMenu, Browl, Keylb, Fpanel;

type
  TMDTLs = class(TFormBrIB)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Browl1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    BrQuery1SEL: TBooleanField;
    ls: TStringList;
    procedure BrQuery1CalcFields(DataSet: TDataSet);
    procedure SelKey(key: longint; tw: TWinControl);
		procedure WMRebuild(var Message: TWMRebuild); message WM_REBUILD;
		procedure WMFormLimit(var Message: TMessage); message WM_FORMLIMIT;
  public
    { Public declarations }
		class function Execute(Sender: TObject; lEval: Boolean): string;
  end;

var
  MDTLs: TMDTLs;

implementation

uses My_pr,mulqry,FFldEdit,
  OLTypes;

{$R *.dfm}

class function TMDTLs.Execute;
begin
  AddStack('TMDTLs.Execute');
  with TFldEdit(Sender) do begin
    if lEval then begin
      CreateForm(TMDTLs,MDTLs);
      with MDTLs do begin
        BrQuery1.GlobKey:=Cngv[fCNGV]; ls.Text:=TrimRight(Value);
        if ls.Count=0 then ls.Add('') else TrimSelf(ls);
        ls.Sorted:=true; ShowModal; ls.Sorted:=false; TrimSelf(ls); Value:=TrimRight(ls.Text);
      end;
      FormFree(MDTLs);
    end;
    result:=Value;
  end;
  DelStack;
end;

procedure TMDTLs.FormCreate(Sender: TObject);
begin
  AddStack('TMDTLs.FormCreate',Self);
  inherited;
  with BrQuery1 do begin
    GlobKey:='1';
    Init(DBMain,[fNAME],[fNAME],tMDT,[fNAME],fCNGV+'='+QQs(qGlobKey),fNAME,BrQuery1CalcFields);
    BrQuery1SEL:=CreateBooleanField('CSEL');
    Browl1.FieldLong:=CreateStringField(fNAME);
  end;
  ls:=TStringList.Create;
  with KeyLb1 do begin
    SetKeys([K_Space,K_Enter,K_Ins],'־עלועטעü','',SelKey,'sel',kmList);
    SetKeySel([K_F2,K_Plus],[K_F3,K_Minus],SelKey,'sel');
  end;
  DelStack;
end;

procedure TMDTLs.FormDestroy(Sender: TObject);
begin
  AddStack('TMDTLs.FormDestroy',Self);
  ls.Free;
  inherited;
  DelStack;
end;

procedure TMDTLs.FormShow(Sender: TObject);
begin
  AddStack('TMDTLs.FormShow',Self);
  inherited;
  MainRebuild;
  DelStack;
end;

procedure TMDTLs.SelKey;
var bm: TBookMark;
  v: string;
begin
	AddStack('TMDTLs.SelKey',Self);
  case Key of
    K_F2,K_Plus: if AskSel(true) then with BrQuery1 do begin
    	bm:=GetBookMark; DisableControls; First;
      while not Eof do begin
      	ls.Add(TrimRight(Browl1.FieldLong.AsString)); Next;
      end;
      GotoBookMark(bm); FreeBookMark(bm); EnableControls;
    end;
    K_F3,K_Minus: if AskSel(false) then begin
    	ls.Clear; Browl1.BrUpdate(NegDef,Browl1.FieldLong.AsString,fNAME);
    end;
  else
  	v:=Browl1.FieldLong.AsString; IgnoreSlAddDel(ls,TrimRight(v)); Browl1.BrUpdate(NegDef,v,fNAME);
    if Key=K_Ins then BrQuery1.Next;
  end;
  DelStack;
end;

procedure TMDTLs.BrQuery1CalcFields;
begin
	AddStack('TOrgLs.BrQuery1CalcFields',Self);
  if BrQuery1SEL.Visible then BrQuery1SEL.AsBoolean := ls.IndexOf(TrimRight(Browl1.FieldLong.AsString)) >= 0;
  DelStack;
end;

procedure TMDTLs.Browl1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  AddStack('TMDTLs.Browl1DrawColumnCell',Self);
  inherited;
	Browl1.bmCheckPaint(Rect,Column);
  DelStack;
end;

procedure TMDTLs.WMRebuild;
begin
  AddStack('TMDTLs.WMRebuild',Self);
  if Message.Oper=rbBefore then Browl1.ColWidths[0]:=bmCheckSize.cX+2;
  DelStack;
end;

procedure TMDTLs.WMFormLimit;
begin
	AddStack('TMDTLs.WMFormLimit',Self);
  inherited;
  FreeLimit(MDTLs);
  DelStack;
end;

end.
