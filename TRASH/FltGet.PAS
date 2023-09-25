unit FltGet;

interface

uses Classes,DB,
  MultiGet;

type
  TFltProgGet = class(TMultiGet)
  private
  protected
    Rec: TRecVal;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TFltZajGet = class(TFltProgGet)
  private
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

uses My_pr,FFldEdit;

{ TFltProgGet }
constructor TFltProgGet.Create;
begin
  AddStack('TFltProgGet.Create',Self);
  inherited Create(AOwner);
  RVid:='Фильтр'; RVName:='по программам';
  Rec.CreateFld('CDRVID',ftInteger,0,0); Rec.CreateFld('CDRCOD',ftMemo,0,'');
  Rec.CreateFld('ORGVID',ftInteger,0,0); Rec.CreateFld('ORGCOD',ftMemo,0,'');
  Rec.CreateFld('PRGVID',ftInteger,0,0); Rec.CreateFld('PRGCOD',ftMemo,0,'');
  DelStack;
end;

destructor TFltProgGet.Destroy;
begin
  AddStack('TFltProgGet.Destroy',Self);
  inherited Destroy;
  DelStack;
end;

{ TFltZajGet }
constructor TFltZajGet.Create;
begin
  AddStack('TFltZajGet.Create',Self);
  inherited Create(AOwner);
  RVName:='по заявкам';
  DelStack;
end;

destructor TFltZajGet.Destroy;
begin
  AddStack('TFltZajGet.Destroy',Self);
  inherited Destroy;
  DelStack;
end;

end.
