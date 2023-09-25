unit FDrvLs;

interface

{$I ORGTEST}
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, Menus, DB, DBTables, Grids, DBGrids, ExtCtrls, StdCtrls,
  MyTypes, My_pr, FRMBRIB, KeyMenu, Browl, Keylb, Fpanel, DefEdit, FCngNum,
    FFldedit, MenuGet, ComboGet, CCodeGet;

type
  TDrvLs = class(TFormBrIB)
    de: TDefEdit;
    KdGet: TComboGet;
    NameGet: TComboGet;
    MgFbVersWithEmpty: TMenuGet;
    procedure Browl1BrowlKey(key: Integer; tw: TWinControl);
    procedure deFldChange(Sender: TObject; const OldVal: Variant;
      FromShow: Boolean);
    function deFldCheck(Sender: TObject): Boolean;
    procedure deFrmShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure deFldExit(Sender: TObject);
    procedure NameGetDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
  private
    { Private declarations }
    class procedure NewCod(const oldnum: string; Options: TCngNumOptions; var result: boolean);
		procedure WMFormLimit(var Message: TMessage); message WM_FORMLIMIT;
    class procedure FbVersGetText(Sender: TField; var Text: string; DisplayText: Boolean);
  end;

var
  DrvLs: TDrvLs;

function CheckIP(const ip: string): boolean;

implementation
{$R *.dfm}
{$B-}

uses
  mulqry,FSchemDM,FrmPswd,ListF2,
  ProgType,FbServices,
  OLTypes,FDM,FCdrLs;

function CheckIP;
var a: array[1..4] of string;
	i: longint;
begin
  AddStack('FDrvLs.CheckIP');
  LsArrFill(ip,a,'.'); result:=false;
  for i:=low(a) to high(a) do if Int0(a[i])<>0 then begin
    result:=true; break;
  end;
  DelStack;
end;

{ TDrvLs }
procedure TDrvLs.FormCreate(Sender: TObject);
var f: TField;
    sl: TStringList;
    k: longint;
begin
  AddStack('TDrvLs.FormCreate',Self);
  inherited;
  with BrQuery1 do begin
  	Init(DBMain,[fDRV,fUPNAME,fIP,'KD'],[],tDRV,[]);
    Browl1.FieldSeek:=CreateStringField(fDRV,'Номер');
    CreateField(fUPNAME).DisplayLabel:=CreateStringField(fNAME,'Наименование').DisplayLabel;
    CreateStringField('LOCAL','Локальный диск');
    CreateStringField(fIP,'IP-адрес');
    CreateStringField('PHONE','Телефон');
    CreateStringField('KD','Имя для подкл.');
    CreateField('DIR');
    f:=CreateStringField('FBVERS','Версия FB');
    f.DisplayWidth:=3;
    f.OnGetText:=FbVersGetText;
  end;
  NameGet.LenName:=Length(Drv[fNAME]);
  
  sl:=MgFbVersWithEmpty.Items;
  sl.BeginUpdate;
  try
    sl.Capacity:=1+Length(FBSERVODS); sl.Add(''+UnDelim+'');
    for k:=low(FBSERVODS) to high(FBSERVODS) do sl.Add(FBSERVODS[k,2]+UnDelim+FBSERVODS[k,0]);
  finally
    sl.EndUpdate;
  end;
  
  DelStack;
end;

class procedure TDrvLs.FbVersGetText;
begin
  if (DisplayText)and(Sender<>nil) then begin
    Text:=DM.MgFbVers.MenuName(Sender.AsString);
  end;
end;

procedure TDrvLs.Browl1BrowlKey(key: Integer; tw: TWinControl);
var fl: boolean;
begin
	AddStack('TDrvLs.Browl1BrowlKey',Self);
  inherited;
  fl:=false;
  if BrQuery1.CanEdit(Key) then case Key of
  	K_F3: begin
    	Drv.NewRec; deFrmShow(nil);
    	fl:=TCngNum.GetNewNum('Новое имя диска',Browl1,Drv,fDRV,[tDRV,tPROG],[],'',NewCod);
    end;
    K_F4,K_F7: fl:=Browl1.AppRec('Добавить сетевой диск',Drv,de,IfThen(Key),'',fDRV);
    K_F5: fl:=Browl1.EditRec('Редактировать сетевой диск',Drv,de,fDRV);
    K_F8: if not ProgSeek(fDRV+'='+Browl1.QQs,
      'На данном сетевом диске содержатся программы.') then fl:=Browl1.DelAsk(Drv);
  end;
  if fl then begin
    DM.DrvGet.ClearBuf; ProgPswd.SendUpd(updCodeGet); lsIpClear;
  end;
  DelStack;
end;

class procedure TDrvLs.NewCod;
begin
	AddStack('TDrvLs.NewCod');
  ProgPswd.UpdateTable(tPROG,[fDRV],[QQs(Drv[fDRV])],fDRV+'='+QQs(oldnum)); 
  DelStack;
end;

function PrNetRes(const av: array of variant; var NetResource: TNetResource): boolean;
begin
	AddStack('FDrvLs.PrNetRes');
  result:=true;
  with NetResource do if (dwUsage and RESOURCEUSAGE_CONNECTABLE)=RESOURCEUSAGE_CONNECTABLE
  	then DrvLs.NameGet.Items.Add(lpRemoteName);
  DelStack;
end;

procedure TDrvLs.deFrmShow(Sender: TObject);
var i,j: longint;
  ls: TStringList;
  c: char;
begin
	AddStack('TDrvLs.deFrmShow',Self);
  KdGet.Items.BeginUpdate; KdGet.Items.Clear; KdGet.Items.Add(' ');
  NameGet.Items.BeginUpdate; NameGet.Items.Clear;
  ls:=SortStrListCreate;
  try
    GetDriveList(ls);
  	for i:=Ord('C') to Ord('Z') do begin
    	c:=Chr(i);
      if ls.Find(c+DriveDelim+PathDelim,j) then
	    	if GetDriveType(PChar(ls[j]))<>DRIVE_REMOTE then begin
        	NameGet.Items.Add(c+DriveDelim); continue;
        end;
    	KdGet.Items.Add(c);
    end;
  finally
    ls.Free;
  end;
  ProcNetRes(PrNetRes,[0]);
  with ProgPswd.GetQuery do begin
  	PartSelect(tDRV,['KD',fUPNAME],Drv.rRecNo(false));
    while not Eof do begin
      FindDel(KdGet.Items,Fields[0].AsString);
    	if NameGet.Items.Find(TrimRight(Fields[1].AsString),i) then NameGet.Items.Objects[i]:=ObjectTrue;
    	Next;
    end;
  	ProgPswd.FreeQuery;
  end;
  KdGet.Items.EndUpdate; NameGet.Items.EndUpdate;
  DelStack;
end;

procedure TDrvLs.deFldChange(Sender: TObject; const OldVal: Variant; FromShow: Boolean);
  procedure SetFbPortRo(const aFldPort: string; feFbVers: TFldEdit);
  var fe: TFldEdit;
      s: string;
  begin
    if de.IsFldEdit(aFldPort,fe) then begin
      s:=Trim(feFbVers.Value);
      fe.SetReadOnly((ogReadOnly in feFbVers.Options)or(s='')or(s='0'));
    end;
  end;
  procedure SetFbVersRo(const aFldVers,aParentFldVers: string);
  var b: boolean;
      fe,feParent: TFldEdit;
      s: string;
  begin
    {b:=not IsNetDrive(Drv[fNAME]);}
    b:=false;
    if de.IsFldEdit(aFldVers,fe) then begin
      if (not b)and(aParentFldVers<>'') then
        if de.IsFldEdit(aParentFldVers,feParent) then begin
          s:=Trim(feParent.Value);
          b:=(s='')or(s='0');
        end;
      fe.SetReadOnly(b,'');
    end;
  end;
var fl: boolean;
  tf: TFldEdit;
begin
	AddStack('TDrvLs.deFldChange',Self);
  tf:=pointer(Sender);
  with tf do
    if NameRecFld=fNAME then begin
      fl:=not IsNetDrive(VarValue);
      de.SetReadOnly(fIP,fl);
      de.SetReadOnly('LOCAL',fl);
      de.SetReadOnly('DIR',fl);
      de.SetReadOnly('PHONE',fl);
      {de.SetReadOnly('MULTIGET',fl);
      SetFbVersRo('FBVERS','');}
    end
    else if NameRecFld='FBVERS' then begin
      SetFbPortRo('FBPORT',tf);
      SetFbVersRo('FBVERS2','FBVERS');
    end
    else if NameRecFld='FBVERS2' then begin
      SetFbPortRo('FBPORT2',tf);
      SetFbVersRo('FBVERS3','FBVERS2');
    end
    else if NameRecFld='FBVERS3' then begin
      SetFbPortRo('FBPORT3',tf);
      SetFbVersRo('FBVERS4','FBVERS3');
    end
    else if NameRecFld='FBVERS4' then begin
      SetFbPortRo('FBPORT4',tf);
      SetFbVersRo('FBVERS5','FBVERS4');
    end
    else if NameRecFld='FBVERS5'
      then SetFbPortRo('FBPORT5',tf)
    else if NameRecFld=fIP
      then VarValue:=IPSpaceStr(VarValue)
  ;DelStack;
end;

procedure TDrvLs.deFldExit(Sender: TObject);
begin
  AddStack('TDrvLs.deFldExit',Self);
  SpaceStrSelf(Sender,fDRV);
  DelStack;
end;

function TDrvLs.deFldCheck(Sender: TObject): Boolean;
var a: TArrStr;
  i,j: longint;
begin
	AddStack('TDrvLs.deFldCheck',Self);
  if KodCheck(Sender,fDRV,result) then with TFldEdit(Sender) do
    if NameRecFld='LOCAL'
      then result := StrToChar(VarValue) in ['A'..'Z']
    else if NameRecFld=fIP
      then result:=CheckIP(VarValue)
    else if (NameRecFld='KD') and empty(VarValue) then begin
      SetLength(a,Length(ProgInfs)); j:=0;
      for i:=low(ProgInfs) to high(ProgInfs) do if not GetProgType(ProgInfs[i].id).lWin then begin
        a[j]:=QQi(i,lProgKP); Inc(j);
      end;
      result:=not ProgSeek(fDRV+'='+QQs(Drv[fDRV])+sAND+FldInList(fProgKP,a,j),
        'На данном диске находятся программы под DOS.');
    end
    else result:=true;
  DelStack;
end;

procedure TDrvLs.WMFormLimit;
begin
	AddStack('TDrvLs.WMFormLimit',Self);
  inherited;
  FreeLimit(DrvLs);
  DelStack;
end;

procedure TDrvLs.NameGetDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
  AddStack('TDrvLs.NameGetDrawItem',Self);
  with TFindListBox(Control),Canvas do begin
    Index:=GetIndexFiltered(Index);
    if BoolObj(NameGet.Items,Index) then
      if odSelected in State
      then Font.Color:=SchemDM.Browl.Color2
      else Brush.Color:=SchemDM.Browl.Color2;
    TextRect(Rect,Rect.Left,Rect.Top,NameGet.Items[Index]);
  end;
  DelStack;
end;

end.
