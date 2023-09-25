program Menu;

uses
  Forms,
  FPrnTxt {initialization},
  MskProp {initialization},
  FEdSchem {initialization},
  FDInter {initialization},
  FDQuery {initialization},
  FLogLs {initialization},
  FTblFld {initialization},
  FMDDir {initialization},
  FTabuLs {initialization},
  FrmSumm {initialization},
  FrmWnd in '..\..\OURLIB\FORMS\FRMWND.PAS' {FormWnd},
  FrmNul in '..\..\OURLIB\FORMS\FRMNUL.pas' {FormNul},
  FRMEMPTY in '..\..\OURLIB\FORMS\FRMEMPTY.PAS' {FormEmp},
  FrmPswd in '..\..\OURLIB\FORMS\FrmPswd.PAS' {FormPswd},
  FPswdEd in 'FPswdEd.pas' {PswdEd},
  FSchemDM in '..\..\OURLIB\FORMS\FSchemDM.pas' {SchemDM: TDataModule},
  FDM in 'FDM.pas' {DM: TDataModule},
  FVanLs in 'FVanLs.pas' {VanLs},
  FrmEdt in '..\..\OURLIB\FORMS\FRMEDT.PAS' {FormEdt},
  FMain in 'FMain.pas' {Main},
  FCdrLs in 'FCDRLS.PAS' {CdrLs},
  FOrgLs in 'FOrgLs.pas' {OrgLs},
  FDrvLs in 'FDrvLs.pas' {DrvLs},
  FProgEd in 'FPROGED.PAS' {ProgEd},
  FFltLs in 'FFltLs.pas' {FltLs},
  FZajLs in 'FZajLs.pas' {ZajLs},
  FProgLs in 'FPROGLS.PAS' {ProgLs},
  FOfisLs in 'FOfisLs.pas' {OfisLs},
  FrmBrIB in '..\..\OURLIB\FORMS\FrmBrIB.PAS' {FormBrIB},
  FRgnLs in 'FRgnLs.pas' {RgnLs},
  FTerrLs in 'FTerrLs.pas' {TerrLs},
  FAccLs in 'FAccLs.pas' {AccLs},
  FSrvLs in 'FSrvLs.pas' {SrvLs},
  FrmMenu in '..\..\ourlib\forms\FRMMENU.PAS' {FormMenu},
  SftpDir in '..\..\SETGGW\SftpDir.pas',
  FSftpFiles in 'FSftpFiles.pas' {SftpFiles},
  OLGets in 'OLGets.pas',
  KatDiff in '..\..\ourlib\KatDiff.pas',
  FSendDp in 'FSendDp.pas' {SendDp},
  OLProc in 'OLProc.pas',
  OLTypes in 'OLTypes.pas',
  DMProc in 'DMProc.pas',
  FMsgLs in 'FMsgLs.pas' {MsgLs},
  FMDPLs in 'FMDPLs.pas' {MDPLs},
  FMDFLs in 'FMDFLs.pas' {MDFLs},
  FMDTLs in 'FMDTLs.pas' {MDTLs};

{$R *.res}
{$R ORGLIST.RES}

begin
  Application.Initialize;
  Application.Title := 'Учёт клиентов';
  Application.HelpFile := '';
  Application.CreateForm(TSchemDM, SchemDM);
  Application.CreateForm(TPswdEd, PswdEd);
  Application.Run;
end.
