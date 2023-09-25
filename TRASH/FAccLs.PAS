unit FAccLs;

interface

{$I LIBTEST}
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, Menus, DB, Grids, DBGrids, ExtCtrls,
  MyTypes, My_pr, FRMBRIB, KeyMenu, Browl, Keylb, Fpanel, FCngNum;

type
  TAccLs = class(TFormBrIB)
    procedure FormCreate(Sender: TObject);
    procedure Browl1BrowlKey(key: Integer; tw: TWinControl);
  private
    class procedure NewCod(const oldnum: string; Options: TCngNumOptions; var result: boolean);
    procedure WMFormLimit(var Message: TMessage); message WM_FORMLIMIT;
  end;

var
  AccLs: TAccLs;

function AccDialog(key: longint; const aAccId: string; br: TBrowl=nil): boolean;
function AccDialogOnSave: boolean;
procedure SendSmailFtp(const aAccId: string);
function GetFtpDir(const aAcid: string; aName: pstring=nil): string;
procedure ApplyPendingSettings;
procedure MakeAccountsFile;

implementation
{$R *.dfm}
{$B-}

uses
  StrUtils, Math,
  FrmPswd, mulqry, Shifr, Pack, FStat, FDirTree,
    BufFile, DefEdit, FFldedit, GGMReg, GGI,
  SggUtils, ProgType,
  OLTypes,FDM;

const
  SECTION_ACCOUNTS = 'SECTION_ACCOUNTS';

procedure TAccLs.FormCreate(Sender: TObject);
begin
  AddStack('TAccLs.FormCreate',Self);
  inherited;
  Randomize;
  with BrQuery1 do begin
    Init(DBMain,[fACC,fUPNAME],[],tACC,[]);
    Browl1.FieldSeek:=CreateStringField(fACC);
    CreateField(fUPNAME).DisplayLabel:=CreateStringField(fNAME,'Наименование').DisplayLabel;
    CreateStringField(fFTPSRV);
    CreateField('ACDIR');
  end;
  DelStack;
end;

class procedure TAccLs.NewCod;
begin
  AddStack('TAccLs.NewCod');
  Prog.UpdateTable([fACC],[Int0(Acc[fACC])],fACC+'='+Vtos(Int0(oldnum)));
  DelStack;
end;

procedure TAccLs.WMFormLimit;
begin
	AddStack('TAccLs.WMFormLimit',Self);
  inherited;
  FreeLimit(AccLs);
  DelStack;
end;

function AccDialog;
var isEditing,isCopy: boolean;
    s: string;
begin
  result:=false;
  try
    isEditing:=(key=K_F5); SetLogVid(aEdAppLog[not isEditing]);
    if (key in [K_F4,K_F5]) then begin
      if (not Acc.Seek(Acc.TblFldName(fACC)+'='+QQs(AcidAsStr(aAccId)))) then ThrowGoto;(* throws EGoto *)
    end;
    if (not IsEditing) then begin
      isCopy:=(key=K_F4);
      Acc.NewRec(IfThen(isCopy,newrCopy));
      Acc.KodNextSelf(fACC);
      if (isCopy) then begin
        Acc['ACPASS']:='';
        Acc['ACKEY']:='';
      end else begin
        s:=Trim(Cdr['ORGKOD']);
        Acc[fNAME]:=TrimRight(List[fNAME])+' ('+s+')';
        Acc['ACPASS']:=GetRandom10;
        Acc['ACKEY']:=GetRandom10;
        Acc['ACDIR']:='box'+PadL(s,4,'0');
      end;
    end;
    DM.deAcc.Param[fACC,deNoReadOnly]:=BStr[not isEditing];
    if (DM.deAcc.Execute(IfThen(isEditing,'Редактировать уч.запись инт.','Добавить уч.запись инт.')).Saved) then begin
      result:=true;
      if (not isEditing) then Acc.AppRec(true);
      if (br<>nil) then br.BrUpdate(br.Row,Acc.RecNo);
    end;
    SetLogVid;
  except
    on EGoto do;
  end;
end;

procedure TAccLs.Browl1BrowlKey(key: Integer; tw: TWinControl);
var fl: boolean;
begin
  AddStack('TAccLs.Browl1BrowlKey',Self);
  inherited;
  fl:=false;
  if BrQuery1.CanEdit(Key) then begin
    case Key of
      K_F3: fl:=TCngNum.GetNewNum('Новый номер уч.записи',Browl1,Acc,fACC,[tACC,tPROG],[],'',NewCod);
      K_F4,K_F5,K_F7: fl:=AccDialog(key,Browl1.FieldSeek.AsString,Browl1);
      K_F8:
        if not ProgSeek(fACC+'='+Vtos(Int0(Browl1.FieldSeek.AsString)),'Существуют программы по данной уч.записи.')
        then fl:=Browl1.DelAsk(Acc);
      K_CTRL_ENTER: begin
        SendSmailFtp(Browl1.FieldSeek.AsString);
      end;
    end;
  end;
  if fl then begin
    DM.AccGet.ClearBuf;
    ProgPswd.SendUpd(updCodeGet);
  end;
  DelStack;
end;

function CheckSmailDir(const dir: string): string;
begin
  result:=ExcludeTrailingPathDelimiter(Trim(dir));
  if (result='') then begin
    ThrowGoto('В параметрах сервера не указана папка программы sftp');(* throws EGoto *)
  end;
  if (not DirectoryExists(result)) then begin
    ThrowGoto('В параметрах сервера указана несуществующая папка программы sftp'+CRLF+'<'+result+'>');(* throws EGoto *)
  end;
end;

procedure CheckSmailDirSelf(var dir: string);
begin
  dir:=CheckSmailDir(dir);
end;


function ProcessPathChange(isEditing: boolean; const dirNew,srvNew,dirOld,srvOld: string): boolean;
  procedure DirUsingConfirm(const dir: string; var riz: boolean);
  begin
    if (not ask(['Папка уже существует <'+dir+'>','Вы уверены, что хотите её использовать?'])) then begin
      riz:=false;
      ThrowGoto;(* throws EGoto *)
    end;
  end;
  procedure CreateFtpDir(const dir: string; var riz: boolean; noConf: boolean=false);
  begin
    if (DirectoryExists(dir)) then begin
      if (not noConf) then DirUsingConfirm(dir,riz);(* throws EGoto *)
    end else begin
      if (not CreateDir(dir)) then begin
        ThrowGoto('Не могу создать папку <'+dir+'>'+GetSysErrMsg);(* throws EGoto *)
      end;
    end;
  end;
var s,t,u,v,w: string;
    b,noChange: boolean;
    gle: longword;
begin
  AddStack('FAccLs.ProcessPathChange');
  result:=true;
  try
    t:=TrimRight(dirNew);
    if (t<>'') then begin
      s:=TrimRight(srvNew);
      if (not Srv.Seek(Srv.TblFldName(fFTPSRV)+'='+QQs(s))) then ThrowGoto;(* throws EGoto *)
      s:=CheckSmailDir(Srv['SRVDIR']);(* throws EGoto *)
      s:=GetSftpDataDir(s);
      u:=s+PathDelim+t;
      if (not isEditing) then begin(* добавление,копирование *)
        CreateFtpDir(u,result);(* throws EGoto *)
      end else begin(* редактирование *)
        v:=TrimRight(dirOld);
        s:=TrimRight(srvOld);
        if (not Srv.Seek(Srv.TblFldName(fFTPSRV)+'='+QQs(s))) then s:=''
        else begin
          s:='';
          try
            s:=CheckSmailDir(Srv['SRVDIR']);(* throws EGoto *)
          except
            on E:EGoto do;
          end;
        end;
        w:=GetSftpDataDir(s)+PathDelim+v;
        noChange:=(AnsiUpperCase(u)=AnsiUpperCase(w));
        if (noChange)or(s='')or(not DirectoryExists(w)) then begin
          CreateFtpDir(u,result,noChange);(* throws EGoto *)
        end else begin
          b:=false;
          if (DirectoryExists(u)) then DirUsingConfirm(u,result)(* throws EGoto *)
          else begin
            if (AnsiUpperCase(ExtractFileDrive(w))=AnsiUpperCase(ExtractFileDrive(u))) then b:=true;
          end;
          if (b) then begin
            if (not RenameFile(w,u)) then begin
              ThrowGoto('Не могу переименовать папку <'+w+'>'+CRLF+'в папку <'+u+'>'+
                        GetSysErrMsg);(* throws EGoto *)
            end;
          end else begin
            gle:=0;
            CopyDir(w,u,b,@gle);
            if (not b) then begin
              ThrowGoto('Не могу скопировать папку <'+w+'>'+CRLF+'в папку <'+u+'>'+CRLF+
                        IfThen(gle<>0,SysErrorMessage(gle)));(* throws EGoto *)
            end;
            gle:=0;
            DeleteDir(w,@gle);
            if (DirectoryExists(w)) then begin
              ThrowGoto('Не могу удалить папку <'+w+'>'+CRLF+IfThen(gle<>0,SysErrorMessage(gle)));(* throws EGoto *)
            end;
          end;
        end;
      end;

    end;(* if (t<>'') *)

  except
    on E:EGoto do begin
      if (E.Message<>'') then begin
        result:=false;
        mess_ok([E.Message]);
      end;
    end;
  end;
  DelStack;
end;

function AccDialogOnSave;
var fe: TFldEdit;
    de: TDefEdit;
    s,t,v,u: string;
begin
  AddStack('FAccLs.AccDialogOnSave');
  de:=DM.deAcc;
  if de.IsFldEdit('ACDIR',fe) then begin
    t:=TrimRight(fe.Value); v:=TrimRight(fe.OldValue);
  end
  else begin
    t:=''; v:='';
  end;
  if de.IsFldEdit(fFTPSRV,fe) then begin
    s:=TrimRight(fe.Value); u:=TrimRight(fe.OldValue);
  end
  else begin
    s:=''; u:='';
  end;
  result:=ProcessPathChange(Acc.RecNo<>0,t,s,v,u);
  DelStack;
end;

function ASwap(const s: string): string;
var k,j: longint;
begin
  k:=1;
  j:=length(s);
  SetLength(result,j);
  while k<=j do begin (* '=' для среднего байта при нечётной длине *)
    result[k]:=s[j];
    result[j]:=s[k];
    inc(k);
    dec(j);
  end;
end;

function AEncode(const s: string): string;
var k: longint;
    b,dlt: byte;
begin
  k:=length(s);
  SetLength(result,k);
  if (k>0) then begin
    dlt:=ord(s[1]);
    result[1]:=s[1];
    for k:=2 to k do begin
      b:=ord(s[k]);
      result[k]:=chr(b+dlt);
      inc(dlt,b*k);
    end;
  end;
end;

function AScrumble(const s: string): string;
var w: word;
    k: longint;
begin
  w:=Windows.GetTickCount; result:=s+chr(HiByte(w))+chr(w);
  for k:=1 to (byte(w) div 4)+6 do result:=AEncode(ASwap(result));
  IncD(result,chr(byte(w)));
end;

procedure MakeFile(const fn,cnt: string);
begin
  if (FileExists(fn)) then begin
    if (not DelFile(fn)) then begin
      ThrowGoto('Не могу удалить файл <'+fn+'>'+GetSysErrMsg);(* throws EGoto *)
    end;
  end;
  try
    SetStrFile(fn,cnt);
  except
    on E:Exception do begin
      ThrowGoto('Не могу записать файл <'+fn+'>'+CRLF+E.Message);(* throws EGoto *)
    end;
  end;
end;

procedure CreateDirIfNotExists(const dir: string);
begin
  if (not DirectoryExists(dir)) then begin
    if (not CreateDir(dir)) then begin
      ThrowGoto('Не могу создать папку <'+dir+'>'+GetSysErrMsg);(* throws EGoto *)
    end;
  end;
end;

procedure GetSrvProps(const sSrvid: string; out dirFtp,aAddr,aLogSuff: string);
var mq: TMulQuery;
begin
  mq:=ProgPswd.GetQuery;
  try
    mq.PartSelect(tFTPSRV,['SRVDIR','SRVADDR','SRVLOGSUFF'],fFTPSRV+'='+QQs(sSrvid));
    if not mq.IsRecords
    then ThrowGoto('У этой учётной записи установлен несуществующий сервер');(* throws EGoto *)
    dirFtp:=mq.Fields[0].AsString;
    aAddr:=Trim(mq.Fields[1].AsString);
    aLogSuff:=Trim(mq.Fields[2].AsString);
  finally
    ProgPswd.FreeQuery;
  end;
end;

procedure SendSmailFtp;
const dirTmp='SMAIL.TMP';
  dirSmail='SFTP';
  fileIni='setttings';
  fileGgm='ggm_sftp';
  fileExe='sftp.exe';
  EXT_TMP= '.tmp.pck';
  aIniExt: array[0..1] of string = ('.ini',IniExt);
var dirFtp,dirDest,s,t,u,v,sDir,sDir2,sPass,sPass2,sSrvid,sSrvid2,sKeyword,sKeyword2,sAddr,sAddr2,sLogSuff,sLogSuff2: string;
  mq: TMulQuery;
  sr: TSearchRec;
  isPendSet: boolean;
  dtDate2: TDateTime;
  gle: longword;
  p: TPacker;
  fn: TFileName;
  i: byte;
begin
  AddStack('FAccLs.SendSmailFtp');
  try
    mq:=ProgPswd.GetQuery;
    try
      mq.PartSelect(tACC,['ACDIR','ACPASS',fFTPSRV,'ACKEY',
        'PENDSET','DATE2','ACDIR2','ACPASS2','SRVID2','ACKEY2'],
        fACC+'='+QQs(AcidAsStr(aAccId)));
      if not mq.IsRecords then ThrowGoto;(* throws EGoto *)
      sDir:=mq.Fields[0].AsString;
      sPass:=mq.Fields[1].AsString;
      sSrvid:=mq.Fields[2].AsString;
      sKeyword:=mq.Fields[3].AsString;
      isPendSet:=StrToBoolean(mq.Fields[4]);
      dtDate2:=mq.Fields[5].AsDateTime;
      sDir2:=mq.Fields[6].AsString;
      sPass2:=mq.Fields[7].AsString;
      sSrvid2:=mq.Fields[8].AsString;
      sKeyword2:=mq.Fields[9].AsString;
    finally
      ProgPswd.FreeQuery;
    end;
    if (sDir='')or((isPendSet)and(sDir2='')) then begin
      ThrowGoto('У этой учётной записи не установлена папка ftp');(* throws EGoto *)
    end;
    if (sPass='')or((isPendSet)and(sPass2='')) then begin
      ThrowGoto('У этой учётной записи не установлен пароль');(* throws EGoto *)
    end;
    if (sSrvid='')or((isPendSet)and(sSrvid2='')) then begin
      ThrowGoto('У этой учётной записи не установлен сервер');(* throws EGoto *)
    end;

    if (isPendSet) then begin
      GetSrvProps(sSrvid2,s,sAddr2,sLogSuff2);(* throws EGoto *)
    end;
    GetSrvProps(sSrvid,dirFtp,sAddr,sLogSuff);(* throws EGoto *)

    CheckSmailDirSelf(dirFtp);(* throws EGoto *)
    if (sAddr='')or((isPendSet)and(sAddr2='')) then begin
      ThrowGoto('В параметрах сервера не указан его адрес');(* throws EGoto *)
    end;
    
    dirDest:=GetSftpDataDir(dirFtp)+PathDelim+sDir;
    CreateDirIfNotExists(dirDest);(* throws EGoto *)
    
    if Ask(['Отправить тестовое письмо ?']) then begin
      s:=dirDest+PathDelim+SmailDirBox[true,false]+PathDelim;
      CreateDirIfNotExists(s);(* throws EGoto *)
      GetUniqueFn(GetPckPref(ABR_MSG,''),s,'',dirDest,FILE_MSG_EXT,fn);
      MakeFile(s+fn+FILE_MSG_EXT,
        'Здравствуйте!'+CRLF+
        CRLF+
        'Если Вы читаете это письмо, значит обмен файлами работает.'+CRLF+
        CRLF+
        'Можете для тестирования отправить какой-нибудь файл небольшого размера'+CRLF+
        CRLF+
        'С уважением Гуляев Георгий!');(* throws EGoto *)
    end;
    
    v:=dirFtp+PathDelim+fileExe;
    if (not FileExists(v)) then begin
      ThrowGoto('Отсутствует необходимый файл <'+v+'>');(* throws EGoto *)
    end;
    
    try
      s:=ExeDir+dirTmp;
      CreateDirIfNotExists(s);(* throws EGoto *)
      u:=s+PathDelim+dirSmail;
      CreateDirIfNotExists(u);(* throws EGoto *)

      t:=u+PathDelim+fileExe;
      if (not CopyFile(PChar(v),PChar(t),false)) then begin
        ThrowGoto('Не могу скопировать файл <'+v+'>'+CRLF+'в файл <'+t+'>'+GetSysErrMsg);(* throws EGoto *)
      end;

      t:=
        '[GGM_sftp]'+CRLF+
        'Name=Обмен файлами через интернет'+CRLF+
        'Dir='+dirSmail+CRLF+
        'NotDelDir=1';
      for i:=low(aIniExt) to high(aIniExt) do MakeFile(s+PathDelim+fileGgm+aIniExt[i],t);(* throws EGoto *)
      t:=
        '[ftpacc]'+CRLF+
        'ISMAIN=0'+CRLF+
        'SRV='+sAddr+CRLF+
        'PORT=21'+CRLF+
        'PASSIVE=1'+CRLF+
        'USER='+sDir+sLogSuff+CRLF+
        'PASS='+StrShifr(AScrumble(sPass))+CRLF+
        ''+CRLF+
        '[miscstn]'+CRLF+
        'keyword='+StrShifr(AScrumble(sKeyword));
      if (IsPendSet) then begin
        IncD(t,CRLF+
        ''+CRLF+
        '[pending]'+CRLF+
        'DATE='+FormatDateTime('yyyy.mm.dd',dtDate2)+CRLF+
        'SRV='+sAddr2+CRLF+
        'USER='+sDir2+sLogSuff2+CRLF+
        'PASS='+StrShifr(AScrumble(sPass2))+CRLF+
        'keyword='+StrShifr(AScrumble(sKeyword2)));
      end;
      for i:=low(aIniExt) to high(aIniExt) do MakeFile(u+PathDelim+fileIni+aIniExt[i],t);(* throws EGoto *)

      t:=dirDest+PathDelim+GetRandom(25)+EXT_TMP;

      p:=TPacker.Create;
      try
        p.sPath:=s+PathDelim;
        p.ArhName:=t;
        p.avSubDir:=true;
        p.Comment:=DopMakePackerComment('SFTP','Обмен файлами через интернет','',1);
        if (p.DoPack) then begin
          s:=dirDest+PathDelim+DOP_PREFIX+'sftp_'+TrimLeft(sDir)+'.pck';
          if (FileExists(s)) then begin
            if (not DelFile(s)) then begin
              ThrowGoto('Не могу удалить файл <'+s+'>'+GetSysErrMsg);(* throws EGoto *)
            end;
          end;

          repeat
            if (RenameFile(t,s)) then break;
            gle:=GetLastError;
  {          ThrowGoto('Не могу переименовать файл <'+t+'>'+CRLF+'в файл <'+s+'>'+GetSysErrMsg);(* throws EGoto *)}
            if (not ask([
                'Не могу переименовать файл <'+t+'>',
                'в файл <'+s+'>',
                IfThen(gle<>0,SysErrorMessage(gle)),
                '',
                'Попытаться ещё раз?'])) then begin
              ThrowGoto('');(* throws EGoto *)
            end;
          until false;

          for i:=low(aIniExt) to high(aIniExt) do begin
            t:=u+PathDelim+fileIni+aIniExt[i];
            s:=dirDest+PathDelim+fileIni+aIniExt[i];
            if (not CopyFile(PChar(t),PChar(s),false)) then begin
              ThrowGoto('Не могу скопировать файл <'+t+'>'+CRLF+'в файл <'+s+'>'+GetSysErrMsg);(* throws EGoto *)
            end;
          end;
        end;
      finally
        p.Free;
      end;
    finally
      if (FindFirst(dirDest+PathDelim+'*'+EXT_TMP,faAnyFile,sr)=0) then begin
        repeat
          DelFile(dirDest+PathDelim+sr.Name);
        until (FindNext(sr)<>0);
        FindClose(sr);
      end;
      s:=ExeDir+dirTmp;
      u:=s+PathDelim+dirSmail;
      for i:=low(aIniExt) to high(aIniExt) do DelFile(u+PathDelim+fileIni+aIniExt[i]);
      DelFile(u+PathDelim+fileExe);
      RemoveDir(u);
      for i:=low(aIniExt) to high(aIniExt) do DelFile(s+PathDelim+fileGgm+aIniExt[i]);
      RemoveDir(s);
    end;
  except
    on E:EGoto do begin
      if (E.Message<>'') then mess_ok([E.Message]);
    end;
  end;
  DelStack;
end;

function GetFtpDir;
var
  {s,t: string;
  mq: TMulQuery;}
  a: TArrBoolStr;
  a1: array[1..2] of string;
  s: string;
begin
  result:='';
  try
    {mq:=ProgPswd.GetQuery;
    try
      if (Trim(aAcid)='') then ThrowGoto;(* throws EGoto *)
      mq.PartSelect(tACC,['ACDIR',fNAME,fFTPSRV],fACC+'='+QQs(AcidAsStr(aAcid)));
      if (not mq.IsRecords) then ThrowGoto;(* throws EGoto *)
      t:=mq.Fields[0].AsString;
      if (t='') then ThrowGoto;(* throws EGoto *)
      SetPString(aName,mq.Fields[1].AsString);
      mq.PartSelect(tFTPSRV,'SRVDIR',fFTPSRV+'='+QQs(mq.Fields[2]));
      if (not mq.IsRecords) then ThrowGoto;(* throws EGoto *)
      s:=CheckSmailDir(mq.Fields[0].AsString);(* throws EGoto *)
      s:=GetSftpDataDir(s)+PathDelim+t;
      if (not DirectoryExists(s)) then ThrowGoto;(* throws EGoto *)
      result:=s;
    finally
      ProgPswd.FreeQuery;
    end;}
    if empty(aAcid) then ThrowGoto;(* throws EGoto *)
    a:=DM.AccGet.GetNameDop(AcidAsStr(aAcid),[cdgBufAll]);
    if a[true]='' then ThrowGoto;(* throws EGoto *)
    ListAsArray(a[true],a1,#31);
    if (a1[1]='') or (a1[2]='') then ThrowGoto;(* throws EGoto *)
    SetPString(aName,TrimRight(a[false]));
    s:=DM.SrvGet.CodeDop(a1[2],[cdgBufAll]);
    if s='' then ThrowGoto;(* throws EGoto *)
    CheckSmailDirSelf(s);(* throws EGoto *)
    s:=GetSftpDataDir(s)+PathDelim+a1[1];
    if not DirectoryExists(s) then ThrowGoto;(* throws EGoto *)
    result:=s;
  except
    on EGoto do;
  end;
end;

procedure StApplyPendingSettings(Sender: TStat; const Params: array of variant; var Aborted: boolean);
var a: PArrInt;
  k,rn,l: longint;
  dt: TDateTime;
begin
  AddStack('FAccLs.StApplyPendingSettings');
  a:=PointerVar(Params[0]); l:=Params[1]; dt:=Now;
  for k:=0 to l-1 do begin
    rn:=a^[k];
    Acc.GotoRec(rn);
    if (Acc.RecNo<>rn) then continue;
    if (Sender.SayStat('',Trim(Acc[fACC])+': '+TrimRight(Acc[fNAME]),k/l)) then break;
    if (not StrToBoolean(Acc['PENDSET'])) then continue;
    if (TDateTime(Acc['DATE2'])>dt) then continue;
    if (not ProcessPathChange(true,Acc['ACDIR2'],Acc['SRVID2'],Acc['ACDIR'],Acc[fFTPSRV])) then break;
    Acc[fFTPSRV]:=Acc['SRVID2'];
    Acc['ACDIR']:=Acc['ACDIR2'];
    Acc['ACPASS']:=Acc['ACPASS2'];
    Acc['ACKEY']:=Acc['ACKEY2'];
    Acc['PENDSET']:=bFalse;
    Acc.UpdateRec;
  end;(* for k *)
  DelStack;
end;

procedure ApplyPendingSettings;
var mq: TMulQuery;
  k,rc,l: longint;
  a: TArrInt;
  dt: TDateTime;
  isAnyPendSt: boolean;
begin
  AddStack('FAccLs.ApplyPendingSettings');
  mq:=ProgPswd.GetQuery;
  try
    mq.PartSelect(tACC,[fRECNO,'PENDSET','DATE2'],'',fACC);
    dt:=Now; isAnyPendSt:=false; rc:=mq.RecordCount; l:=0;
    for k:=1 to rc do begin
      if StrToBoolean(mq.Fields[1]) then begin
        isAnyPendSt:=true;
        if mq.Fields[2].AsDateTime<=dt then begin
          a[l]:=mq.Fields[0].AsInteger; Inc(l);
        end;
      end;
      mq.Next;
    end;(* for k *)
  finally
    ProgPswd.FreeQuery;
  end;
  if l=0 then begin
    if rc>0
    then meserr(IfThen(isAnyPendSt,'Нет отложенных настроек, нуждающихся в применении','Отложенные настройки не найдены'));
  end
  else ShowStat('Применение отложенных настроек',StApplyPendingSettings,[longint(@a)],l);
  DelStack;
end;

procedure MakeAccountsFile;
var mq: TMulQuery;
    s,t,u: string;
    k,j,l: longint;
    od: TOpenDialog;
    sa: TArrStr;
begin
  AddStack('FAccLs.MakeAccountsFile');
  try
    mq:=ProgPswd.GetQuery;
    try
      mq.PartSelect(tFTPSRV,[fFTPSRV,'ACC2FILE']);
      j:=mq.RecordCount;
      if (j=0) then begin
        ThrowGoto('Список серверов пуст');(* throws EGoto *)
      end;
      SetLength(sa,j); l:=0;
      for k:=1 to j do begin
        if StrToBoolean(mq.Fields[1]) then begin
          sa[l]:=QQs(mq.Fields[0]); Inc(l);
        end;
        mq.Next;
      end;(* for k *)
      if l=0 then ThrowGoto('Ни один из серверов не участвует в создании файла паролей');(* throws EGoto *)
      mq.PartSelect(tACC,[fACC,'ACDIR','ACPASS'],FldInList(fFTPSRV,sa,l),'ACDIR');
      u:='';
      j:=0;
      while not mq.Eof do begin
        s:=TrimRight(mq.Fields[1].AsString);
        if (s='') then begin
          ThrowGoto('У учётной записи <'+mq.Fields[0].AsString+'> не установлена папка ftp');(* throws EGoto *)
        end;
        t:=TrimRight(mq.Fields[2].AsString);
        if (t='') then begin
          ThrowGoto('У учётной записи <'+mq.Fields[0].AsString+'> не установлен пароль');(* throws EGoto *)
        end;
        IncD(u,s+' '+t+CRLF);
        inc(j);
        mq.Next;
      end;
    finally
      ProgPswd.FreeQuery;
    end;
    if (u='') then begin
      ThrowGoto('Отсутствуют учётные записи');(* throws EGoto *)
    end;
    
    od:=TOpenDialog.Create(nil);
    try
      s:='*.txt';
      od.DefaultExt:=s;
      od.Filter:='Файлы учётных записей('+s+')|'+s+'|Все файлы (*.*)|*.*';
      od.FileName:=InitFIni[fiSave].ReadString(SECTION_ACCOUNTS,'ACCFILE');
      if (FileExec('SaveAccounts',od,nil,[],'','Сохранить')) then begin
        InitFIni[fiSave].WriteString(SECTION_ACCOUNTS,'ACCFILE',od.FileName);
        if SetStrFile(od.FileName,u) then meserr('Сохранено записей: %d',[j]);
      end;
    finally
      od.Free;
    end;
    
  except
    on E:EGoto do begin
      if (E.Message<>'') then mess_ok([E.Message]);
    end;
  end;
  DelStack;
end;

end.
