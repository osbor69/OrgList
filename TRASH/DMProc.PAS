unit DMProc;

interface

procedure DMAfterCreate;

implementation

uses Classes,SysUtils,Math,
  MyTypes,My_pr,CodeGets,FFldEdit,FrmBrIB,RecDB,
  OLTypes,FDM,FOrgLs,FDrvLs,FProgLs,FRgnLs,FTerrLs,FAccLs,FSrvLs,OLGets,FCdrLs,FMDPLs,FMDFLs;

type
  TNone = class
  private
    { TRecDB }
    class procedure ProgNewRec(Sender: TRecDB; lcopy: Boolean; const gKey: String);
    class procedure CdrNewRec(Sender: TRecDB; lcopy: Boolean; const gKey: String);
    { TCodeGet }
    class function ListGetFormIBList(Sender: TFldEdit): TFormBrIB;
    class procedure ListGetAfterList(Sender: TObject);
    class function DrvGetFormIBList(Sender: TFldEdit): TFormBrIB;
    class procedure DrvGetAfterList(Sender: TObject);
    class function ProgCpGetFormIBList(Sender: TFldEdit): TFormBrIB;
    class procedure ProgCpGetAfterList(Sender: TObject);
    class function RgnGetFormIBList(Sender: TFldEdit): TFormBrIB;
    class procedure RgnGetAfterList(Sender: TObject);
    class function TerrGetFormIBList(Sender: TFldEdit): TFormBrIB;
    class procedure TerrGetAfterList(Sender: TObject);
    class function AccGetFormIBList(Sender: TFldEdit): TFormBrIB;
    class procedure AccGetAfterList(Sender: TObject);
    class function SrvGetFormIBList(Sender: TFldEdit): TFormBrIB;
    class procedure SrvGetAfterList(Sender: TObject);
    class function MDPGetFormIBList(Sender: TFldEdit): TFormBrIB;
    class procedure MDPGetAfterList(Sender: TObject);
    class function MDFGetFormIBList(Sender: TFldEdit): TFormBrIB;
    class procedure MDFGetAfterList(Sender: TObject);
    { TDefEdit }
    class function deAccPnlValid(Sender: TObject): Boolean;
    { TButTextGet }
    class procedure btgCdrClick(Sender: TObject);
  end;

procedure DMAfterCreate;
  function CodeGetInit(g: TCodeGet; PrFormIBList: TCGFormIBListEvent; PrAfterList: TNotifyEvent): TCodeGet;
  begin
    AddStack('DMProc.DMAfterCreate.CodeGetInit');
    result:=g; g.OnFormIBList:=PrFormIBList; g.OnAfterList:=PrAfterList;
    DelStack;
  end;
begin
  AddStack('DMProc.DMAfterCreate');
  with DM,TNone do begin
    { TRecDB }
    Prog     .OnNewRec:=ProgNewRec;
    RProgCalc.OnNewRec:=ProgNewRec;
    Cdr      .OnNewRec:=CdrNewRec;
    { TCodeGet }
    CodeGetInit(ListGet  ,ListGetFormIBList  ,ListGetAfterList);
    CodeGetInit(DrvGet   ,DrvGetFormIBList   ,DrvGetAfterList);
    CodeGetInit(ProgCpGet,ProgCpGetFormIBList,ProgCpGetAfterList);
    CodeGetInit(ProgNpGet,ProgCpGetFormIBList,ProgCpGetAfterList);
    CodeGetInit(RgnGet   ,RgnGetFormIBList   ,RgnGetAfterList);
    CodeGetInit(TerrGet  ,TerrGetFormIBList  ,TerrGetAfterList);
    CodeGetInit(AccGet   ,AccGetFormIBList   ,AccGetAfterList);
    CodeGetInit(SrvGet   ,SrvGetFormIBList   ,SrvGetAfterList);
    CodeGetInit(MDPGet   ,MDPGetFormIBList   ,MDPGetAfterList);
    CodeGetInit(MDFGet   ,MDFGetFormIBList   ,MDFGetAfterList);
    { TDefEdit }
    deAcc.OnPnlValid:=deAccPnlValid;
    { TButTextGet }
    btgCdr.OnClick:=btgCdrClick;
  end;
  DelStack;
end;

{ TNone }

// Prog
class procedure TNone.ProgNewRec;
begin
	AddStack('TNone.ProgNewRec');
	Prog[fORG]:=List[nmfbKO];
  if (not lcopy) then Prog[fRGN]:=1;
  if Assigned(DM) then Prog[fCDR]:=DM.Rec[fCDR];
  DelStack;
end;

// Cdr
class procedure TNone.CdrNewRec;
var i: byte;
	lFlt: boolean;
  s: string;
begin
	AddStack('TNone.CdrNewRec');
  Cdr.KodNextSelf(fCDR);
  if not lcopy then begin
    Cdr.SetArrayValue(['FLTORG','FLTPRG','ZAJORG','ZAJPRG','ZAJTN','ZAJITN'],fltAll);
    for lFlt:=false to true do begin
    	s:='';
	  	for i:=1 to ofxCnt-IfThen(not lFlt,1) do SetByte(s,i,true);
      Cdr[sMemo+'ORD'+afOrd[lFlt]]:=ProgGet(lFlt).Ord2Mem(s,false);
    end;
    Cdr[sMemo+'ORDZAJ']:=ProgGet.Ord2Mem(CdrOrdZajDef(ofzCnt+ofxCnt,[ofzCnt+ofxSTATUS],
      [ofzTD,ofzWTN,ofzNZ,ofzDACT,ofzTXT,ofzTN,ofzTISPD,ofzISPV,ofzISPTN,ofzTWD]),true);
  end;
  DelStack;
end;

// ListGet
class function TNone.ListGetFormIBList;
begin
	AddStack('TNone.ListGetFormIBList');
  if LockRead then begin
    CreateForm(TOrgLs,OrgLs); result:=OrgLs;
  end
  else result:=nil;
  DelStack;
end;

class procedure TNone.ListGetAfterList;
begin
	AddStack('TNone.ListGetAfterList');
  FormFree(OrgLs); UnLockRead;
  DelStack;
end;

// DrvGet
class function TNone.DrvGetFormIBList;
begin
	AddStack('TNone.DrvGetFormIBList');
  CreateForm(TDrvLs,DrvLs); result:=DrvLs;
  DelStack;
end;

class procedure TNone.DrvGetAfterList;
begin
	AddStack('TNone.DrvGetAfterList');
  FormFree(DrvLs);
  DelStack;
end;

// ProgCpGet,ProgNpGet
class function TNone.ProgCpGetFormIBList;
var cg: TCodeGet;
begin
  AddStack('TNone.ProgCpGetFormIBList');
  cg:=pointer(Sender.curget);
  ProgLsExec('Программы по клиенту: '+Trim(DM.ListGet.Codest(ListKod(Int0(cg.MulPar.Values['ko'])))),
    cg.MulPar.Values['cp'],cg.FieldsCode,@result);
  DelStack;
end;

class procedure TNone.ProgCpGetAfterList;
begin
  AddStack('TNone.ProgCpGetAfterList');
  FormFree(ProgLs);
  DelStack;
end;

// RgnGet
class function TNone.RgnGetFormIBList;
begin
	AddStack('TNone.RgnGetFormIBList');
  CreateForm(TRgnLs,RgnLs); result:=RgnLs;
  DelStack;
end;

class procedure TNone.RgnGetAfterList;
begin
	AddStack('TNone.RgnGetAfterList');
  FormFree(RgnLs);
  DelStack;
end;

// TerrGet
class function TNone.TerrGetFormIBList;
begin
	AddStack('TNone.TerrGetFormIBList');
  CreateForm(TTerrLs,TerrLs); result:=TerrLs;
  DelStack;
end;

class procedure TNone.TerrGetAfterList;
begin
  AddStack('TNone.TerrGetAfterList');
  FormFree(TerrLs);
  DelStack;
end;

// AccGet
class function TNone.AccGetFormIBList;
begin
	AddStack('TNone.AccGetFormIBList');
  CreateForm(TAccLs,AccLs); result:=AccLs;
  DelStack;
end;

class procedure TNone.AccGetAfterList;
begin
  AddStack('TNone.AccGetAfterList');
  FormFree(AccLs);
  DelStack;
end;

// SrvGet
class function TNone.SrvGetFormIBList;
begin
	AddStack('TNone.SrvGetFormIBList');
  CreateForm(TSrvLs,SrvLs); result:=SrvLs;
  DelStack;
end;

class procedure TNone.SrvGetAfterList;
begin
	AddStack('TNone.SrvGetAfterList');
  FormFree(SrvLs);
  DelStack;
end;

// MDPGet
class function TNone.MDPGetFormIBList;
begin
	AddStack('TNone.MDPGetFormIBList');
  TMDPLs.Prepare(''); result:=MDPLs;
  DelStack;
end;

class procedure TNone.MDPGetAfterList;
begin
	AddStack('TNone.MDPGetAfterList');
  FormFree(MDPLs);
  DelStack;
end;

// MDFGet
class function TNone.MDFGetFormIBList;
begin
	AddStack('TNone.MDFGetFormIBList');
  CreateForm(TMDFLs,MDFLs); MDFLs.BrQuery1.Arg['kc']:=Cngv[fCNGV]; result:=MDFLs;
  DelStack;
end;

class procedure TNone.MDFGetAfterList;
begin
	AddStack('TNone.MDFGetAfterList');
  FormFree(MDFLs);
  DelStack;
end;

// deAcc
class function TNone.deAccPnlValid;
begin
  result:=AccDialogOnSave;
end;

// btgCdr
class procedure TNone.btgCdrClick;
var tf: TFldEdit;
	s: string;
begin
	AddStack('TNone.btgCdrClick');
  tf:=pointer(Sender); s:=tf.Value;
  if TCdrLs.Execute(s,true) then tf.Value:=s;
  DelStack;
end;

end.

