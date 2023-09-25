unit FSftpFiles;

interface

{$I LIBTEST}
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, ExtCtrls, Menus, Grids,
  MyTypes, My_pr, FRMEMPTY, Keylb, Fpanel, KeyMenu, RbMenu, RbScroll, StrBrowl, DefEdit, RecVal,
  SftpDir, SggUtils;

type
  TSftpFiles = class(TFormEmp)
    KeyMenu1: TKeyMenu;
    RbPanel5: TRbPanel;
    sbFiles: TStringBrowl;
    RbPanel4: TRbPanel;
    RbScrollBox1: TRbScrollBox;
    rmFiles: TRbMenu;
    DeSetupUtil: TDefEdit;
    RvSftpFiles: TRecVal;
    tmWatchFile: TTimer;
    procedure FormShow(Sender: TObject);
    function DeSetupUtilFldCheck(Sender: TObject): Boolean;
    procedure tmWatchFileTimer(Sender: TObject);
  private
    FPathSftp,FRzrvCopyDir,FWatchFile: string;
    FSftpDir: TSftpDir;
    FRzrvCopyLastCnt,FRzrvCopyLastDay: longint;
    procedure WMFormLimit(var Message: TMessage); message WM_FORMLIMIT;
    function GetSftpPath: string;
    function GetFocusNeed: boolean;
    function UtilSetupFunc(const dirEnum: string=''; slEnum: TStringList=nil;
      aShowFiles: boolean=false): boolean;
    procedure FProgSetup(const aPath,aFile: string; aArjFor: TArjForList);
    procedure ProgSetupFunc(const aFile: string);
    procedure ExtraKeysFunc(var ekp: TExtraKeysPrm);
  end;

implementation
{$R *.dfm}
{$B-}

uses Math, StrUtils, ShellApi,
  FFldEdit, MulQry, BufFile, FrmPswd, RecDB,
  FSGWMain, ProgType,
  OLTypes, FPswdEd, OLGets, FDM, FFltLs, OLProc, FProgLs;

var SftpFiles: TSftpFiles;

procedure SftpFilesExec(const pathSftp,rzrvCopyDir,aCaption: string;
  rzrvCopyLastCnt,rzrvCopyLastDay: longint; SftpLogProc: TSftpLogProc = nil);
var jc: boolean;
begin
  jc:=CreateForm(TSftpFiles,SftpFiles);
  with SftpFiles do begin
    FPathSftp:=pathSftp;
    FRzrvCopyLastCnt:=rzrvCopyLastCnt;
    FRzrvCopyLastDay:=rzrvCopyLastDay;
    FRzrvCopyDir:=Trim(rzrvCopyDir);
    Caption:=TrimRight(aCaption)+' <'+pathSftp+'>';
    if (jc) then begin
      FSftpDir:=TSftpDir.Make(SftpFiles,RbPanel2,rmFiles,sbFiles,GetSftpPath,true,GetFocusNeed,
        UtilSetupFunc,ProgSetupFunc,nil,ExtraKeysFunc,nil,nil,nil,SftpLogProc,nil);
      FSftpDir.RmInit;
      MainRebuild;
    end;
  end;
  SftpFiles.ShowModal;
end;

procedure TSftpFiles.WMFormLimit;
begin
  AddStack('TSftpFiles.WMFormLimit',Self);
  inherited;
  FreeLimit(SftpFiles);
  DelStack;
end;

function TSftpFiles.GetSftpPath;
begin
  result:=FPathSftp;
end;

function TSftpFiles.GetFocusNeed;
begin
  result:=(not(csDestroying in Self.ComponentState))and(Self.Visible);
end;

procedure TSftpFiles.FormShow(Sender: TObject);
begin
  inherited;
  FSftpDir.ReloadFiles([sftpIsAppearance]);
end;

function TSftpFiles.UtilSetupFunc;
var sl: TStringList;
  s,t: string;
  dir: TFileName;
  k: longint;
  a: TArrStr;
begin
  result:=false;
  sl:=TStringList.Create;
  try
    GetFixedDrives(sl);
    RvSftpFiles['DESTDIR']:=GetDirEnum(sl,DirGG);
  finally
    sl.Free;
  end;
  if (DeSetupUtil.Execute.Saved) then begin
(*
    SGWMain:=nil;
    try
      TSGWMain.Init(['ZPW','E'],
        []{GgmSgwFiles},ExeDir,FRzrvCopyLastCnt,FRzrvCopyLastDay,nil);
      result:=SGWMain.SgwUtilSetup(dirEnum,RvSftpFiles['DESTDIR'],nil,slEnum);
    finally
      FreeAndNil(SGWMain);
    end;
*)
    if (slEnum<>nil)and(slEnum.Count>0) then begin
      s:=dirEnum+PathDelim;
      CopyFrom(a,slEnum);
      for k:=low(a) to high(a) do IncL(a[k],s);
      t:=ArrayAsList(a,CRLF);
      FWatchFile:=a[0];
    end else begin
      FWatchFile:='';
      t:='';
    end;
    s:='ZPW';
    Write_SET_XXX_Ini(s,'','','','','',0,low(TProgStatList),'','',dir,[winiWin],t);
    IncD(s,Format(' %s "%s" "%s" LASTCNT=%d LASTDAY=%d SFTP=%s',
      [SGW_CMD[cmdUte],dirEnum,string(RvSftpFiles['DESTDIR']),FRzrvCopyLastCnt,FRzrvCopyLastDay,
      IfThen(FSftpDir.IsArchFiles,'3','4')]));
    ShellExecute(0,nil,SetggwExeFile,PChar(s),PChar(ExeDir),SW_SHOW);
    result:=true;(* не важен, т.к. далее не используется *)
    if (not FSftpDir.IsArchFiles) then begin
      tmWatchFile.Enabled:=true;
    end;
  end;
end;

function TSftpFiles.DeSetupUtilFldCheck(Sender: TObject): Boolean;
begin
  inherited;
  NoEmpCheck(Sender,'DESTDIR',result);
end;

procedure TSftpFiles.ProgSetupFunc;
begin
  ProgSetup(aFile,FProgSetup);
end;

procedure TSftpFiles.FProgSetup;
const aArh: array[TArjForList] of TCmdSetggw = (cmdUst,cmdObn);
var svi: TRDBSaveInf;
  pni: TPckNameInf;
  q: TTblConcat;
  sProgPath: TFileName;
  inf: TProgInf;
  tp: TProgType;
  aPort: string;
begin
  AddStack('TSftpFiles.FProgSetup',Self);
  TRecDB.SaveInf([Prog,Drv],svi);
  try
    GetPckNameInf(aFile,pni);
    if (pni.pniNoPrg) then begin
      ThrowGoto;(* throws EGoto *)
    end;
    q:=TTblConcat.CreateConnection(Application.MainForm);
    try
      q.RdbPartSelect([Prog,Drv,Org],[2],
        ArrayAsList([tPROG+'.'+fORG+'='+tORG+'.'+fORG,tDRV+'.'+fDRV+'='+tPROG+'.'+fDRV,
        tORG+'.kod='+Org2Sql(pni.pniOrg),tPROG+'.'+fProgCP+'='+Reg2Sql(pni.pniReg)],sAND));
      if (q.Eof) then begin
        ThrowGoto;(* throws EGoto *)
      end;
      q.RdbGetFromQuery;
      if Prepare2RunProg(sProgPath,tp,[p2rMakeDir],@aPort) then begin
        FWatchFile:=aPath+aFile;
        Write_SET_XXX_Ini(sProgPath,[],FWatchFile);
        inf:=ProgInf; tp:=ProgTp;
        ShellExecute(0,nil,SetggwExeFile,PChar(Format(
          '%s %s DIRLAST=%s REGNUM=%s-%s ABR=%s LASTCNT=%d LASTDAY=%d SFTP=%s %s=%s',
          [tp.sid,SGW_CMD[cmd],FRzrvCopyDir,Trim(pni.pniOrg),Trim(pni.pniReg),
          inf.Abr,FRzrvCopyLastCnt,FRzrvCopyLastDay,IfThen(FSftpDir.IsArchFiles,'1','2'),ibpPort,aPort])),PChar(ExeDir),SW_SHOW);
        if (not FSftpDir.IsArchFiles) then begin
          tmWatchFile.Enabled:=true;
        end;
      end;
    finally
      q.Free;
    end;
  except
    on EGoto do;
  end;
  TRecDB.RestInf(svi);
  DelStack;
end;

procedure TSftpFiles.tmWatchFileTimer(Sender: TObject);
begin
  inherited;
  if (not GetFocusNeed) then tmWatchFile.Enabled:=false
  else begin
    if (not FileExists(FWatchFile)) then begin
      tmWatchFile.Enabled:=false;
      FSftpDir.ReloadFiles;
    end;
  end;
end;

procedure TSftpFiles.ExtraKeysFunc;
var s,sOrg,sReg,sNum,sSel,wOrg,wStat: string;
  b: boolean;
  svi: TRDBSaveInf;
  oLogKeys: PLogKeysSave;
  i: longint;
begin
  AddStack('TSftpFiles.ExtraKeysFunc',Self);
  case ekp.ekpAction of
    EKP_SETKEYS: if ekp.ekpKi=kiFilesInMsg then begin
      SetLength(ekp.ekpKeys,3);
      with ekp.ekpKeys[0] do begin
        ekKey:=K_CTRL_X; ekCaption:='В заявку'; ekHint:='Скопировать сообщение в заявку';
      end;
      with ekp.ekpKeys[1] do begin
        ekKey:=K_CTRL_Y; ekCaption:='В заявку(выбор)'; ekHint:='Выбрать программу для копирования сообщения в заявку';
      end;
      with ekp.ekpKeys[2] do begin
        ekKey:=K_CTRL_G; ekCaption:='Ответить'; ekHint:='Ответить на сообщение';
      end;
    end;
    EKP_PROCKEY: begin
      oLogKeys:=ProgPswd.PLogKeysLen;
      try
        case ekp.ekpKey of
          K_CTRL_G: begin
            ekp.ekpKeyProcessed:=true;
            if (ekp.ekpFileName<>'') then begin
              SetLogVid(logvSendMsg);
              ParsePckFn(ExtractFileName(ekp.ekpFileName),sOrg,sReg,sNum);
              Prog.SaveInf(svi);
              if Prog.Seek(Prog.TblFldName(fORG)+'='+Vtos(Int0(DM.ListGet.CodeDop(sOrg)))
              +sAND+Prog.TblFldName(fProgCP)+'='+Reg2Sql(sReg)) then begin
                s:=TrimRight(Prog['MSGPTRN']); ProgLogKeysAdd;
              end
              else s:='';
              if SendMsg(ExcludeTrailingPathDelimiter(FPathSftp),MakeRegNum(sOrg,sReg),s,false,true,TFltLs.SelPtrn) then begin
                ekp.ekpReloadFiles:=true; Prog.LogWrite;
              end;
              TRecDB.RestInf(svi);
              SetLogVid;
            end;
          end;
          K_CTRL_X,K_Ctrl_Y: begin
            ekp.ekpKeyProcessed:=true;
            if (ekp.ekpFileName<>'') then begin
              SetLogVid(logvAppRec); s:=Trim(GetStrFile(ekp.ekpFileName,MaxInt,@b));
              if (b)and(s<>'') then begin
                ParsePckFn(ExtractFileName(ekp.ekpFileName),sOrg,sReg,sNum);
                if (Int0(sReg)<>0) then
                  {q:=PswdEd.GetQuery;
                  try
                    q.PartSelect(tPROG+' p join '+tORG+' o on p.'+fORG+'=o.'+fORG,
                      ['distinct p.'+fCDR+',p.'+fORG],
                      Format('o.kod=%s%sp.%s=%s',[Org2Sql(sOrg),sAND,fProgCP,Reg2Sql(sReg)]));
                    b:=(q.IsRecords);
                    if (b) then begin
                      t:=q.Fields[0].AsString;
                      u:=q.Fields[1].AsString;
                    end;
                  finally
                    PswdEd.FreeQuery;
                  end;}
                  wOrg:=Prog.TblFldName(fORG)+'='+Vtos(Int0(DM.ListGet.CodeDop(sOrg))); sSel:='';
                  if (ekp.ekpKey=K_Ctrl_X) and Prog.Seek(wOrg+sAND+Prog.TblFldName(fProgCP)+'='+Reg2Sql(sReg)) then begin
                    b := (not empty(Prog[fORG]))and(not empty(Prog[fProgCP]));
                    if b then if Prog['STATUS']<>stpMain
                    then sSel:='Статус программы отличается от основного. Выберите программу для добавления заявки.';
                  end
                  else begin
                    b:=Prog.Seek(wOrg);
                    if b then sSel:=IfThen(ekp.ekpKey=K_Ctrl_X,'Не найдена программа '+sOrg+'.'+sReg+'. ')
                      +'Выберите программу для добавления заявки.';
                  end;
                  if sSel<>'' then begin
                    with ProgPswd.GetQuery do begin
                      wStat:=tPROG+'.STATUS='+Vtos(stpMain); PartSelect(tPROG,fRECNO,wOrg+sAND+wStat); i:=RecordCount;
                      b := i>0;
                      if b then begin
                        if i=1 then i:=Fields[0].AsInteger
                        else begin
                          ProgLsExec(sSel,wStat,tPROG+'.'+fProgCP);
                          with ProgLs,BrQuery1 do begin
                            GlobKey:=Vtos(Prog[fORG]);
                            Browl1.CloseOnSelect:=true; b := ShowModal=mrOk; i:=FFldRecno.AsInteger;
                            if not FormFree(ProgLs) then Browl1.CloseOnSelect:=false;
                          end;
                        end;
                        if b then Prog.GotoRec(i);
                      end
                      else meserr('Не найдены основные программы клиента '+sOrg+'.');
                      ProgPswd.FreeQuery;
                    end;
                  end;
                  if b then begin
                    Zaj.NewRec;
                    Zaj[fCDR]:=DM.Rec[fCDR];
                    Zaj[fTD]:=DateToString(Now);
                    Zaj[fORG]:=Prog[fORG];
                    Zaj[fProgCP]:=Prog[fProgCP];
                    Zaj['ISPV']:=ivCdrToOrg;
                    aSplitTxt254(Zaj,s);
                    ProgLogKeysAdd;
                    Zaj.AppRec(true);
                    meserr('Добавлена заявка с номером %d.',[longint(Zaj['NZ'])]);
                  end;
              end;
              SetLogVid;
            end;
          end;
        end;
      finally
        ProgPswd.PLogKeys:=oLogKeys;
      end;
    end;
  end;
  DelStack;
end;

initialization
  OLTypes.SftpFilesExec:=SftpFilesExec;
end.
