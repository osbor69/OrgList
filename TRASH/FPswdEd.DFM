inherited PswdEd: TPswdEd
  Caption = #1059#1095#1105#1090' '#1082#1083#1080#1077#1085#1090#1086#1074
  PixelsPerInch = 96
  TextHeight = 15
  inherited RbPanel1: TRbPanel
    inherited KeyLb1: TKeyLb
      OnProcKey = KeyLb1ProcKey
    end
  end
  inherited RG: TRecDB
    Left = 488
    Top = 120
  end
  inherited dePswd: TDefEdit
    Left = 488
    Top = 168
  end
  inherited RUsers: TRecDB
    Left = 544
    Top = 120
  end
  inherited deUser: TDefEdit
    Left = 544
    Top = 168
  end
  inherited deGlob: TDefEdit
    Left = 488
    Top = 216
  end
  inherited dePrm: TDefEdit
    Left = 488
    Top = 328
  end
  inherited IconGet: TButGet
    Left = 544
    Top = 216
  end
  inherited dlgIco: TOpenDialog
    Left = 600
    Top = 216
  end
  inherited deCopyData: TDefEdit
    Left = 544
    Top = 328
  end
  object RGLob: TRecDB
    NameRec = 'GLOB'
    OnAfterOpen = RGAfterOpen
    DateWithTime = False
    NameDB = 'GLOB'
    Prim = #1054#1073#1097#1080#1077' '#1076#1072#1085#1085#1099#1077
    Left = 488
    Top = 64
  end
  object tmCng: TTimer
    Enabled = False
    OnTimer = tmCngTimer
    Left = 632
    Top = 24
  end
end
