unit FSrvLs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, Menus, DB, Grids, DBGrids, ExtCtrls, StrUtils,
  MyTypes, My_pr, FRMBRIB, KeyMenu, Browl, Keylb, Fpanel, DefEdit, FCngNum;

type
  TSrvLs = class(TFormBrIB)
    de: TDefEdit;
    procedure FormCreate(Sender: TObject);
    procedure Browl1BrowlKey(key: Integer; tw: TWinControl);
    function deFldCheck(Sender: TObject): Boolean;
    procedure deFldExit(Sender: TObject);
  private
    class procedure NewCod(const oldnum: string; Options: TCngNumOptions; var result: boolean);
    procedure WMFormLimit(var Message: TMessage); message WM_FORMLIMIT;
end;

var
  SrvLs: TSrvLs;

function SrvidAsStr(const s: string): string;

implementation
{$R *.dfm}

uses
  FFldEdit, FrmPswd, mulqry, 
  OLTypes,FDM;

function SrvidAsStr;
begin
  result:=SpaceStr(s,2);
end;

procedure TSrvLs.FormCreate(Sender: TObject);
begin
  AddStack('TSrvLs.FormCreate',Self);
  inherited;
  with BrQuery1 do begin
  	Init(DBMain,[fFTPSRV,'SRVADDR'],[],tFTPSRV,[]);
    Browl1.FieldSeek:=CreateStringField(fFTPSRV,'�����');
    CreateStringField('SRVADDR','�����').DisplayWidth:=25;
    CreateStringField('SRVDIR','�����').DisplayWidth:=40;
  end;
  DelStack;
end;

class procedure TSrvLs.NewCod;
begin
  AddStack('TSrvLs.NewCod');
  Acc.UpdateTable([fFTPSRV],[QQs(Srv[fFTPSRV])],fFTPSRV+'='+Vtos(oldnum,true));
  DelStack;
end;

procedure TSrvLs.WMFormLimit;
begin
	AddStack('TSrvLs.WMFormLimit',Self);
  inherited;
  FreeLimit(SrvLs);
  DelStack;
end;

procedure TSrvLs.Browl1BrowlKey(key: Integer; tw: TWinControl);
var fl: boolean;
    s: string;
begin
  AddStack('TSrvLs.Browl1BrowlKey',Self);
  inherited;
  fl:=false;
  if BrQuery1.CanEdit(Key) then begin
    case Key of
      K_F3: fl:=TCngNum.GetNewNum('����� ����� �������',Browl1,Srv,fFTPSRV,[tFTPSRV,tACC],[],'',NewCod);
      K_F4,K_F7: fl:=Browl1.AppRec('�������� ������',Srv,de,IfThen(Key),'',fFTPSRV);
      K_F5: fl:=Browl1.EditRec('������������� ������',Srv,de,fFTPSRV);
      K_F8: begin
        s:='';
        with ProgPswd.GetQuery do begin
          PartSelect(tACC,[fACC,fNAME],fFTPSRV+'='+Browl1.QQs);
          if IsRecords then begin
            s:=TrimRight(Fields[1].AsString);
            if (s<>'') then IncL(s,': ');
            IncL(s,Trim(Fields[0].AsString));
          end;
          ProgPswd.FreeQuery;
        end;
        if (s<>'') then begin
          mess_ok(['���������� ��.������ �� ������� �������.',s]);
        end else begin
          fl:=Browl1.DelAsk(Srv);
        end;
      end;
    end;
  end;
  if fl then begin
    DM.SrvGet.ClearBuf; ProgPswd.SendUpd(updCodeGet);
  end;
  DelStack;
end;

function TSrvLs.deFldCheck(Sender: TObject): Boolean;
begin
  AddStack('TSrvLs.deFldCheck',Self);
  inherited;
  if KodCheck(Sender,fFTPSRV,result) then NoEmpCheck(Sender,['SRVADDR','SRVDIR'],result);
  DelStack;
end;

procedure TSrvLs.deFldExit(Sender: TObject);
begin
  AddStack('TSrvLs.deFldExit',Self);
  inherited;
  SpaceStrSelf(Sender,fFTPSRV);
  DelStack;
end;

end.
