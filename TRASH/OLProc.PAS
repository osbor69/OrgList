unit OLProc;

interface

uses Windows,SysUtils,Classes;

type
  PSelIsp = ^TSelIsp;
  TSelIsp = record
    tn: longint;
    ball: Int64;
  end;
  TSelIspArr = array of TSelIsp;

  PArrTN = ^TArrTN; TArrTN = array of longint;

  TConcatTxt254Proc = function(const av: array of variant; const nmf: string; var txt: string): boolean;
  TSplitTxt254Proc = procedure(const av: array of variant; const nmf,txt: string);

  TGetStrFileDateProc = procedure(Sender: TStringList) of object;

const
  TelPathOut = 'исходящие'+PathDelim;
  TelFilePrm = 'CDR.TEL';

function DateToString(d: TDateTime; lSec: boolean = false): string;
function StringToDate(const s: string): TDateTime;
function StringDate(const st: string; var dt: TDateTime): boolean;
function Str2SelIsp(var a: TSelIspArr; const Value: string): boolean; overload;
function IspCalc(var a: TSelIspArr; var an: TArrTN; const SelIspSh: string; CntIsp: longint): longint; overload;
procedure SelIspEnd(var wtn,twtn: string; var ball0: Int64; var tcng: Double;
  dNow: TDateTime; const SelIspSh: string; CntIsp: longint; const Admin: string);
function nmf254(i: byte; const sBeg: string = 'TXT'): string;
function aConcatTxt254(Proc: TConcatTxt254Proc; const av: array of variant;
  const sBeg: string = 'TXT'): string; overload;
procedure aSplitTxt254(Proc: TSplitTxt254Proc; const av: array of variant;
  const aTxtSplit: string; CntFld: byte; lmax: PLongint = nil; const sBeg: string = 'TXT'); overload;
procedure TelMsgAdd(const PathOut: TFileName; MsgRecno: longint; Now: TDateTime; const td1,id,txt: string);
function GetStrFile(const FileName: TFileName; Count: longint = MaxInt;
  Succed: PBoolean = nil; Handle: PHandle = nil): string; overload;
function GetStrFile(var od: longint; const FileName: TFileName;
  ls: TStringList = nil; Proc: TGetStrFileDateProc = nil): boolean; overload;

implementation

uses
  StrUtils,Math,DateUtils,
  Shifr;

function DateToString;
begin
  if d=0 then result:='' else result:=FormatDateTime('yyyymmddhhnn'+IfThen(lSec,'ss'),d);
end;

function StringToDate;
  function Part(p: byte; l: byte = 2): Word;
  begin
    result:=StrToIntDef(Copy(s,p,l),0);
  end;
var t: TDateTime;
begin
  if not TryEncodeDate(Part(1,4),Part(5),Part(7),result) then result:=0;
  if TryEncodeTime(Part(9),Part(11),Part(13),0,t) then result:=result+t;
end;

function StringDate;
var p,ls: longint;
  function Part(l: byte): Word;
  begin
    if p>ls then result:=0
    else begin
      result:=StrToIntDef(Copy(st,p,l),MaxWord); Inc(p,l);
    end;
  end;
var y,m,d,h,n: Word;
begin
  if Trim(st)='' then result:=false
  else begin
    p:=1; ls:=Length(st); y:=Part(4); m:=Part(2); d:=Part(2); h:=Part(2); n:=Part(2);
    result:=TryEncodeDateTime(y,m,d,h,n,0,0,dt);
  end;
end;

function Str2SelIsp(var a: TSelIspArr; const Value: string): boolean;
  function Int0(const ss: string): Int64;
  var s: string;
    i,l: longint;
  begin
    s:=TrimLeft(ss); l:=1;
    if length(s)>0 then
      if s[1] in ['+','-'] then begin
        Inc(l); s:=s[1]+TrimLeft(Copy(s,2,MaxInt));
      end;
    for i:=l to length(s) do
      if not(s[i] in ['0'..'9']) then begin
        SetLength(s,i-1); break;
      end;
    result:=StrToInt64Def(s,0);
  end;
var s,s1: string;
  i,j,l,p,p0: longint;
begin
  s:=Trim(Value)+' '; l:=Length(s); SetLength(a,l shr 1); j:=0; p0:=1;
  for i:=1 to l do if s[i]<=' ' then begin
    if i>p0 then with a[j] do begin
      s1:=Copy(s,p0,i-p0); p:=Pos('-',s1);
      if p=0 then begin
        tn:=Int0(s1); ball:=0;
      end
      else begin
        tn:=Int0(LeftStr(s1,p-1)); ball:=Int0(Copy(s1,p+1,MaxInt));
      end;
      Inc(j);
    end;
    p0:=i+1;
  end;
  SetLength(a,j); result := j>0;
end;

function CompBall(Item1, Item2: Pointer): Integer;
var pa1,pa2: PSelIsp;
begin
  pa1:=Item1; pa2:=Item2; result:=IfThen(pa1.ball>pa2.ball,1,IfThen(pa1.ball<pa2.ball,-1));
  if result=0 then result:=pa1.tn-pa2.tn;
end;

function IspCalc(var a: TSelIspArr; var an: TArrTN; const SelIspSh: string; CntIsp: longint): longint;
var ls: TList;
  lstn: TStringList;
  i,l,n: longint;
  pa: PSelIsp;
  ap: TSelIspArr;
begin
  Str2SelIsp(a,DeShifrStr(SelIspSh));
  if CntIsp=0 then an:=nil
  else begin
    i:=Length(a); SetLength(an,min(i,CntIsp)); ls:=TList.Create; lstn:=TStringList.Create; lstn.Sorted:=true;
    try
      SetLength(ap,i); ls.Capacity:=i;
      for i:=low(a) to high(a) do begin
        pa:=@ap[i]; ls.Add(pa); pa.tn:=i; pa.ball:=a[i].ball;
      end;
      ls.Sort(CompBall); l:=0;
      for i:=0 to ls.Count-1 do begin
        n:=PSelIsp(ls[i]).tn; lstn.Add(IntToStr(a[n].tn));
        if lstn.Count>l then begin
          an[l]:=n; Inc(l);
          if l=Length(an) then break;
        end;
      end;
      SetLength(an,l);
    finally
      ls.Free; lstn.Free;
    end;
  end;
  result:=Length(an);
end;

procedure SelIspEnd;
var a: TSelIspArr;
  an: TArrTN;
begin
  twtn:=DateToString(dNow); tcng:=dNow;
  if (CntIsp=1) and (IspCalc(a,an,SelIspSh,CntIsp)=1) then with a[an[0]] do begin
    wtn:=IntToStr(tn); ball0:=ball;
  end
  else begin
    wtn:=Admin; ball0:=0;
  end;
end;

const lTxt254 = 254;

function nmf254;
begin
  result:=sBeg;
  if i>1 then result:=result+IntToStr(i);
end;

function aConcatTxt254(Proc: TConcatTxt254Proc; const av: array of variant;
  const sBeg: string = 'TXT'): string;
var i: byte;
  s: string;
begin
  result:=''; i:=1;
  repeat
    if not Proc(av,nmf254(i,sBeg),s) then break;
    s:=TrimRight(s);
    (* удаляем последнюю точку или последние две точки *)
    if length(s)=lTxt254 then
      if s[lTxt254]='.' then SetLength(s,lTxt254-1-ord(s[lTxt254-1]='.'));
    result:=result+s; Inc(i);
  until false;
end;

procedure aSplitTxt254(Proc: TSplitTxt254Proc; const av: array of variant;
  const aTxtSplit: string; CntFld: byte; lmax: PLongint = nil; const sBeg: string = 'TXT');
  function SetLMax(Value: longint): boolean;
  begin
    result:=Assigned(lmax);
    if result then lmax^:=Value;
  end;
const sCont=' ->'; lCont=Length(sCont);
var i: byte;
  n: longint;
  s,t: string;
  b: boolean;
begin
  SetLMax(0); s:=TrimRight(aTxtSplit); n:=1;
  for i:=1 to CntFld do begin
    b:=(copy(s,n+lTxt254-2,2)=#13#10);
    t:=copy(s,n,lTxt254-1-ord(b));
    if (b) then begin
      t:=t+'..';(* две точки будут обозначать перенесённый CRLF *)
    end else begin
      if (length(t)=lTxt254-1) then begin
        (* т.е. здесь длина строки s >= 253 *)
        if (t[length(t)]<=' ') then begin
          (* добавляем точку, чтобы сохранить пробелы и(или) CRLF'ы в конце строки t *)
          t:=t+'.';
        end;
      end;
    end;
    Inc(n,lTxt254-1);
    if i=CntFld then
      if not SetLMax(n) then
        if Length(s)>n then t:=StuffString(t,lTxt254-lCont+1,lCont,sCont);
    Dec(n,ord(b));
    if not Assigned(lmax) then Proc(av,nmf254(i,sBeg),t);
  end;
end;

//создать файл GLOB.TELPATH\исходящие\<ID получателя>_<Msg.Recno>_<YYYYMMDDHHNNSSZZZ> с датой получения
// №.ФИО отправителя
// Текст сообщения
procedure TelMsgAdd;
  function SetStrFile(const FileName: TFileName; const Value: string; Handle: PHandle = nil): boolean;
    function FileClrAttr(const FileName: string; Attr: longword = 0): boolean;
    begin
    {$IFDEF MSWINDOWS}
      result:=SetFileAttributes(PChar(FileName),Attr);
    {$ELSE}
      result:=true;
    {$ENDIF}
    end;
    function FileBufCreate(const FileName: string): longint;
    begin
    {$IFDEF MSWINDOWS}
      Result:=longint(CreateFile(PChar(FileName),GENERIC_READ or GENERIC_WRITE,
        0,nil,CREATE_ALWAYS,FILE_FLAG_SEQUENTIAL_SCAN,0));
    {$ELSE}
      Result:=FileCreate(FileName);
    {$ENDIF}
    end;
  var i: THandle;
    j: longint;
    NoHandle: boolean;
  begin
    NoHandle:=not Assigned(Handle);
    if NoHandle then Handle:=@i;
    Handle^:=FileBufCreate(FileName); result := Handle^<>INVALID_HANDLE_VALUE;
    if not result then begin
      FileClrAttr(FileName); Handle^:=FileBufCreate(FileName); result := Handle^<>INVALID_HANDLE_VALUE;
    end;
    if result then begin
      j:=Length(Value); WriteFile(Handle^,pointer(Value)^,j,LongWord(j),nil);
      if NoHandle then FileClose(Handle^);
    end;
  end;
var s: string;
  f: THandle;
  dt: TDateTime;
begin
  s:=PathOut+id+Format('_%d_',[MsgRecno])+FormatDateTime('yyyymmddhhnnsszzz',Now);
  SetStrFile(s,txt,@f);
  if StringDate(td1,dt) then FileSetDate(f,DateTimeToFileDate(dt));
  FileClose(f);
end;

function GetStrFile(const FileName: TFileName; Count: longint = MaxInt;
  Succed: PBoolean = nil; Handle: PHandle = nil): string;
  function FileBufOpen(const FileName: string; Mode: LongWord): longint;
  {$IFDEF MSWINDOWS}
  const
    AccessMode: array[0..2] of LongWord = (
      GENERIC_READ,
      GENERIC_WRITE,
      GENERIC_READ or GENERIC_WRITE);
    ShareMode: array[0..4] of LongWord = (
      0,
      0,
      FILE_SHARE_READ,
      FILE_SHARE_WRITE,
      FILE_SHARE_READ or FILE_SHARE_WRITE);
  {$ENDIF}
  begin
  {$IFDEF MSWINDOWS}
    Result:=-1;
    if ((Mode and 3) <= fmOpenReadWrite) and
      ((Mode and $F0) <= fmShareDenyNone) then
      Result:=longint(CreateFile(PChar(FileName),AccessMode[Mode and 3],
        ShareMode[(Mode and $F0) shr 4],nil,OPEN_EXISTING,
        FILE_FLAG_SEQUENTIAL_SCAN,0));
  {$ELSE}
    result:=FileOpen(FileName,Mode);
  {$ENDIF}
  end;
  function SetPBoolean(p: PBoolean; Value: boolean = false): boolean;
  begin
    result:=Assigned(p);
    if result then p^:=Value;
  end;
var i: THandle;
  j: longint;
  fl,NoHandle: boolean;
begin
  NoHandle:=not Assigned(Handle);
  if NoHandle then Handle:=@i;
  Handle^:=FileBufOpen(FileName,fmShareDenyNone or fmOpenRead); fl := Handle^<>INVALID_HANDLE_VALUE;
  SetPBoolean(Succed,fl);
  if fl then begin
    j:=min(Count,Windows.GetFileSize(Handle^,nil)); SetLength(result,j);
    if ReadFile(Handle^,pointer(result)^,j,LongWord(j),nil)
    then SetLength(result,j) else result:='';
    if NoHandle then FileClose(Handle^);
	end
  else result:='';
end;

// считать FileName при смене его даты
function GetStrFile(var od: longint; const FileName: TFileName;
  ls: TStringList = nil; Proc: TGetStrFileDateProc = nil): boolean; overload;
var s: string;
  f: THandle;
  nd: longint;
  fls: boolean;
begin
  fls:=Assigned(ls); s:=GetStrFile(FileName,MaxInt,@result,@f);
  if result then begin
    nd:=FileGetDate(f);
    if nd<>od then begin
      od:=nd;
      if not fls then ls:=TStringList.Create;
      try
        ls.Text:=s;
        if Assigned(Proc) then Proc(ls);
      finally
        if not fls then ls.Free;
      end;
    end;
    FileClose(f);
  end
  else begin
    od:=0;
    if fls then ls.Clear;
  end;
end;

end.
