inherited MDPLs: TMDPLs
  Caption = #1042#1080#1076#1099' '#1086#1089#1085#1086#1074
  PixelsPerInch = 96
  TextHeight = 15
  inherited RbPanel1: TRbPanel
    inherited RbPanel2: TRbPanel
      inherited Browl1: TBrowl
        NmProc.Strings = (
          'F5#'#1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100'##LIST##'
          'F8#'#1059#1076#1072#1083#1080#1090#1100'##LIST##'
          'Enter###LIST##F5')
        OnBrowlKey = Browl1BrowlKey
      end
    end
  end
  object de: TDefEdit
    DcmBased = False
    FrmBorderIcons = [biSystemMenu, biMinimize, biMaximize]
    FrmBorderStyle = bsSizeable
    Fields.Strings = (
      #1057#1086#1082#1088#1072#1097#1077#1085#1080#1077'#MDP#ABR#TSimpleGet###0#1#T#F#T#F#F####0#0#F#F#F#T')
    HelpContext = 0
    NameWnd = 'MDP'
    PnlAskByCancel = False
    PnlSortMode = smDefault
    Left = 120
    Top = 8
  end
end
