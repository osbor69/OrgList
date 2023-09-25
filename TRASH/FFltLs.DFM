inherited FltLs: TFltLs
  Caption = ''
  PixelsPerInch = 96
  TextHeight = 15
  inherited RbPanel1: TRbPanel
    inherited KeyLb1: TKeyLb
      NmProc.Strings = (
        'F10#####Esc')
    end
    inherited RbPanel2: TRbPanel
      inherited Browl1: TBrowl
        CloseOnSelect = True
      end
    end
  end
  object de: TDefEdit
    DcmBased = False
    FrmBorderIcons = [biSystemMenu, biMinimize, biMaximize]
    FrmBorderStyle = bsSizeable
    Fields.Strings = (
      #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077'#FLT#NAME#TSimpleGet###0#1#T#F#T#F#F####-1#0#F#F#F#T'
      '#FLT#MEM_FLT####0#1#F#F#T#F#F####-1#-1#F#F#F#F')
    HelpContext = 0
    NmProc.Strings = (
      '')
    PnlAskByCancel = False
    PnlSortMode = smDefault
    OnPnlValid = dePnlValid
    Left = 112
  end
end
