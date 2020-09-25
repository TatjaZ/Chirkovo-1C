object MainForm: TMainForm
  Left = 452
  Top = 237
  HelpContext = 11
  AutoScroll = False
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #1060#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1089#1082#1080#1093' '#1087#1088#1086#1074#1086#1076#1086#1082
  ClientHeight = 373
  ClientWidth = 617
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 625
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  DesignSize = (
    617
    373)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 5
    Top = 5
    Width = 143
    Height = 13
    Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072' '#1092#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1103
  end
  object Label2: TLabel
    Left = 257
    Top = 5
    Width = 37
    Height = 13
    Caption = #1087#1086' '#1076#1072#1090#1091
  end
  object Label3: TLabel
    Left = 17
    Top = 30
    Width = 131
    Height = 13
    Caption = #1057#1082#1083#1072#1076' '#1076#1083#1103' '#1092#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1103
  end
  object Label4: TLabel
    Left = 7
    Top = 55
    Width = 141
    Height = 13
    Caption = #1050#1072#1090#1072#1083#1086#1075' '#1076#1083#1103' '#1092#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1103
  end
  object DivisionButton: TButton
    Left = 193
    Top = 338
    Width = 90
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1055#1072#1088#1090#1085#1077#1088#1099
    Enabled = False
    TabOrder = 7
    OnClick = DivisionButtonClick
  end
  object DocButton: TButton
    Left = 292
    Top = 338
    Width = 90
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1044#1086#1082#1091#1084#1077#1085#1090#1099
    Enabled = False
    TabOrder = 8
    OnClick = DocButtonClick
  end
  object SG: TDBGridEh
    Left = 0
    Top = 76
    Width = 617
    Height = 247
    HelpContext = 10
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DS_3
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -11
    FooterFont.Name = 'MS Sans Serif'
    FooterFont.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 9
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object DateInEdit: TDateEdit
    Left = 153
    Top = 2
    Width = 97
    Height = 21
    HelpContext = 10
    NumGlyphs = 2
    TabOrder = 0
  end
  object DateOutEdit: TDateEdit
    Left = 300
    Top = 2
    Width = 97
    Height = 21
    HelpContext = 10
    NumGlyphs = 2
    TabOrder = 1
  end
  object WareHouseBox: TRxDBLookupCombo
    Left = 153
    Top = 27
    Width = 244
    Height = 21
    HelpContext = 10
    DropDownCount = 8
    DisplayEmpty = #1055#1086' '#1074#1089#1077#1084' '#1089#1082#1083#1072#1076#1072#1084
    EmptyValue = '0'
    LookupField = 'ID'
    LookupDisplay = 'DivisionName'
    LookupSource = DS
    TabOrder = 2
  end
  object KindBox: TRadioGroup
    Left = 400
    Top = 1
    Width = 215
    Height = 72
    Caption = #1060#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100
    Columns = 2
    Items.Strings = (
      #1055#1072#1088#1090#1085#1077#1088#1099
      #1044#1086#1082#1091#1084#1077#1085#1090#1099)
    TabOrder = 4
    OnClick = KindBoxClick
  end
  object IsZapBox: TCheckBox
    Left = 3
    Top = 330
    Width = 114
    Height = 17
    Alignment = taLeftJustify
    Anchors = [akLeft, akBottom]
    Caption = #1054#1095#1080#1097#1072#1090#1100' '#1090#1072#1073#1083#1080#1094#1099
    Checked = True
    State = cbChecked
    TabOrder = 5
  end
  object IsReportBox: TCheckBox
    Left = 5
    Top = 347
    Width = 112
    Height = 17
    Alignment = taLeftJustify
    Anchors = [akLeft, akBottom]
    Caption = #1042#1099#1074#1086#1076#1080#1090#1100' '#1086#1090#1095#1077#1090
    TabOrder = 6
    Visible = False
  end
  object CancelButton: TButton
    Left = 517
    Top = 338
    Width = 90
    Height = 25
    Hint = #1047#1072#1082#1088#1099#1090#1100' '#1086#1082#1085#1086
    Anchors = [akRight, akBottom]
    Caption = #1042'&'#1099#1093#1086#1076
    TabOrder = 10
    OnClick = CancelButtonClick
  end
  object PathEdit: TDirectoryEdit
    Left = 153
    Top = 51
    Width = 243
    Height = 21
    NumGlyphs = 1
    TabOrder = 3
  end
  object Division: TDbf
    FilePath = 'D:\'
    IndexDefs = <>
    TableName = 'Kontr.dbf'
    TableLevel = 4
    Left = 59
    Top = 239
    object DivisionYNN: TStringField
      FieldName = 'YNN'
    end
    object DivisionNAME: TStringField
      FieldName = 'NAME'
      Size = 50
    end
    object DivisionFULLNAME: TStringField
      FieldName = 'FULLNAME'
      Size = 200
    end
    object DivisionOKPOCOD: TStringField
      FieldName = 'OKPOCOD'
    end
    object DivisionLICENSE: TStringField
      FieldName = 'LICENSE'
    end
    object DivisionADRESS: TStringField
      FieldName = 'ADRESS'
      Size = 200
    end
    object DivisionPHONE: TStringField
      FieldName = 'PHONE'
    end
    object DivisionRS: TStringField
      FieldName = 'RS'
    end
    object DivisionBANK: TFloatField
      FieldName = 'BANK'
    end
  end
  object TurnIn: TDbf
    FilePath = 'E:\UDARNIK\Program\ExportTo1C\'#1063#1080#1088#1082#1086#1074#1086#1055#1083#1102#1089'\DBF\'
    IndexDefs = <>
    TableName = 'DOCUMENT.DBF'
    TableLevel = 4
    Left = 128
    Top = 239
    object TurnInID: TFloatField
      FieldName = 'ID'
    end
    object TurnInKIND: TFloatField
      FieldName = 'KIND'
    end
    object TurnInDOCDATE: TDateField
      FieldName = 'DOCDATE'
    end
    object TurnInNUMBER: TStringField
      FieldName = 'NUMBER'
      Size = 30
    end
    object TurnInUNN: TStringField
      FieldName = 'UNN'
    end
    object TurnInSUMF: TFloatField
      FieldName = 'SUMF'
    end
    object TurnInSUMN: TFloatField
      FieldName = 'SUMN'
    end
    object TurnInSUMPALL: TFloatField
      FieldName = 'SUMPALL'
    end
    object TurnInSUMP_0: TFloatField
      FieldName = 'SUMP_0'
    end
    object TurnInSUMP_10: TFloatField
      FieldName = 'SUMP_10'
    end
    object TurnInSUMP_18: TFloatField
      FieldName = 'SUMP_18'
    end
    object TurnInNDSIN: TFloatField
      FieldName = 'NDSIN'
    end
    object TurnInNDSOUT: TFloatField
      FieldName = 'NDSOUT'
    end
    object TurnInNDSOUT_10: TFloatField
      FieldName = 'NDSOUT_10'
    end
    object TurnInNDSOUT_18: TFloatField
      FieldName = 'NDSOUT_18'
    end
    object TurnInTRADERAISE: TFloatField
      FieldName = 'TRADERAISE'
    end
    object TurnInNP: TFloatField
      FieldName = 'NP'
    end
    object TurnInROUNDOFF: TFloatField
      FieldName = 'ROUNDOFF'
    end
    object TurnInGLASSPRICE: TFloatField
      FieldName = 'GLASSPRICE'
    end
    object TurnInGLASSNDS: TFloatField
      FieldName = 'GLASSNDS'
    end
    object TurnInDESCRIBE: TStringField
      FieldName = 'DESCRIBE'
      Size = 50
    end
    object TurnInISTARA: TFloatField
      FieldName = 'ISTARA'
    end
    object TurnInTYPE: TFloatField
      FieldName = 'TYPE'
    end
    object TurnInISFIXPRICE: TFloatField
      FieldName = 'ISFIXPRICE'
    end
    object TurnInSUMNAL: TFloatField
      FieldName = 'SUMNAL'
    end
    object TurnInSUMBNAL: TFloatField
      FieldName = 'SUMBNAL'
    end
    object TurnInNDSIN_10: TFloatField
      FieldName = 'NDSIN_10'
    end
    object TurnInNDSIN_18: TFloatField
      FieldName = 'NDSIN_18'
    end
    object TurnInDATE_REEST: TDateField
      FieldName = 'DATE_REEST'
    end
    object TurnInSUMMWITHD: TFloatField
      FieldName = 'SUMMWITHD'
    end
    object TurnInSUMMD: TFloatField
      FieldName = 'SUMMD'
    end
    object TurnInSUMMTRD: TFloatField
      FieldName = 'SUMMTRD'
    end
    object TurnInSUMMNDSD: TFloatField
      FieldName = 'SUMMNDSD'
    end
    object TurnInSUMMROUNDD: TFloatField
      FieldName = 'SUMMROUNDD'
    end
    object TurnInSUMN_0: TFloatField
      FieldName = 'SUMN_0'
    end
    object TurnInSUMN_10: TFloatField
      FieldName = 'SUMN_10'
    end
    object TurnInSUMN_18: TFloatField
      FieldName = 'SUMN_18'
    end
    object TurnInDIVISIONID: TFloatField
      FieldName = 'DIVISIONID'
    end
    object TurnInWHID: TFloatField
      FieldName = 'WHID'
    end
    object TurnInSUMNOTCACH: TFloatField
      FieldName = 'SUMNOTCACH'
    end
  end
  object DivisionDSet: TADODataSet
    Connection = Connect
    CursorType = ctStatic
    BeforeOpen = TMCDSetBeforeOpen
    AfterOpen = TMCDSetAfterOpen
    CommandText = 'LoadDataTo1cDivision'
    CommandTimeout = 500
    CommandType = cmdStoredProc
    EnableBCD = False
    Parameters = <
      item
        Name = 'RETURN_VALUE'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = 1
      end
      item
        Name = '@WareHouseID'
        Attributes = [paNullable]
        DataType = ftFloat
        Precision = 10
        Value = 0.000000000000000000
      end
      item
        Name = '@DateIn'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = 38504d
      end
      item
        Name = '@DateTo'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = 38504d
      end
      item
        Name = '@Result'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdOutput
        Precision = 10
        Value = 0
      end>
    Left = 59
    Top = 183
    object DivisionDSetUNN: TStringField
      DisplayLabel = #1059#1053#1053
      FieldName = 'UNN'
      ReadOnly = True
    end
    object DivisionDSetName: TStringField
      DisplayLabel = #1053#1072#1079#1074#1072#1085#1080#1077
      FieldName = 'Name'
      ReadOnly = True
      Size = 100
    end
    object DivisionDSetFullName: TStringField
      DisplayLabel = #1055#1086#1083#1085#1086#1077' '#1085#1072#1079#1074#1072#1085#1080#1077
      FieldName = 'FullName'
      ReadOnly = True
      Size = 150
    end
    object DivisionDSetOKPO: TStringField
      DisplayLabel = #1054#1050#1055#1054
      FieldName = 'OKPO'
      ReadOnly = True
    end
    object DivisionDSetAccount: TStringField
      DisplayLabel = #1057#1095#1077#1090
      FieldName = 'Account'
      ReadOnly = True
      Size = 30
    end
    object DivisionDSetMFO: TStringField
      DisplayLabel = #1041#1072#1085#1082
      FieldName = 'MFO'
      ReadOnly = True
      Size = 30
    end
    object DivisionDSetAddress: TStringField
      DisplayLabel = #1040#1076#1088#1077#1089
      FieldName = 'Address'
      ReadOnly = True
      Size = 100
    end
  end
  object INDSet: TADODataSet
    AutoCalcFields = False
    Connection = Connect
    CursorType = ctStatic
    BeforeOpen = TMCDSetBeforeOpen
    AfterOpen = TMCDSetAfterOpen
    CommandText = 'LoadDataTo1cTurn'
    CommandTimeout = 500
    CommandType = cmdStoredProc
    EnableBCD = False
    IndexFieldNames = 'Kind;Date;Number'
    Parameters = <
      item
        Name = 'RETURN_VALUE'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = 1
      end
      item
        Name = '@DateFrom'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = 42005d
      end
      item
        Name = '@DateTo'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = 42005d
      end
      item
        Name = '@WareHouseID'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 10
        Value = 10000c
      end
      item
        Name = '@Result'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdOutput
        Precision = 10
        Value = 0
      end>
    Left = 128
    Top = 183
    object INDSetWHDocumentID: TFloatField
      FieldName = 'WHDocumentID'
      ReadOnly = True
    end
    object INDSetTypeTurn: TIntegerField
      FieldName = 'TypeTurn'
      ReadOnly = True
    end
    object INDSetKind: TSmallintField
      FieldName = 'Kind'
      ReadOnly = True
    end
    object INDSetDate: TDateTimeField
      FieldName = 'Date'
      ReadOnly = True
    end
    object INDSetNumber: TStringField
      FieldName = 'Number'
      ReadOnly = True
      Size = 30
    end
    object INDSetWareHouseID: TFloatField
      FieldName = 'WareHouseID'
      ReadOnly = True
    end
    object INDSetDivisionID: TFloatField
      FieldName = 'DivisionID'
      ReadOnly = True
    end
    object INDSetDate_Reestr: TStringField
      FieldName = 'Date_Reestr'
      ReadOnly = True
      Size = 10
    end
    object INDSetUNN: TStringField
      FieldName = 'UNN'
      ReadOnly = True
    end
    object INDSetFixedPrice: TIntegerField
      FieldName = 'FixedPrice'
      ReadOnly = True
    end
    object INDSetIsTara: TIntegerField
      FieldName = 'IsTara'
      ReadOnly = True
    end
    object INDSetsumPriceF: TFloatField
      FieldName = 'sumPriceF'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object INDSetsumPriceN: TFloatField
      FieldName = 'sumPriceN'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object INDSetsumPricePALL: TFloatField
      FieldName = 'sumPricePALL'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object INDSetSummOperWithDiscont: TFloatField
      FieldName = 'SummOperWithDiscont'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object INDSetSummDiscont: TFloatField
      FieldName = 'SummDiscont'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object INDSetSummTradeRaiseDiscont: TFloatField
      FieldName = 'SummTradeRaiseDiscont'
      ReadOnly = True
    end
    object INDSetSummNDSDiscont: TFloatField
      FieldName = 'SummNDSDiscont'
      ReadOnly = True
    end
    object INDSetSummRoundDiscon: TFloatField
      FieldName = 'SummRoundDiscon'
      ReadOnly = True
    end
    object INDSetsumPricePALL_0: TFloatField
      FieldName = 'sumPricePALL_0'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object INDSetsumPricePALL_10: TFloatField
      FieldName = 'sumPricePALL_10'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object INDSetsumPricePALL_18: TFloatField
      FieldName = 'sumPricePALL_18'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object INDSetNDSIn_10: TFloatField
      FieldName = 'NDSIn_10'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object INDSetNDSIn_18: TFloatField
      FieldName = 'NDSIn_18'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object INDSetQuantityFact: TFloatField
      FieldName = 'QuantityFact'
      ReadOnly = True
    end
    object INDSetNDSIn: TFloatField
      FieldName = 'NDSIn'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object INDSetNDSOut: TFloatField
      FieldName = 'NDSOut'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object INDSetNDSOut_10: TFloatField
      FieldName = 'NDSOut_10'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object INDSetNDSOut_18: TFloatField
      FieldName = 'NDSOut_18'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object INDSetSumTradeRaise: TFloatField
      FieldName = 'SumTradeRaise'
      ReadOnly = True
    end
    object INDSetSumSalesTax: TFloatField
      FieldName = 'SumSalesTax'
      ReadOnly = True
      Visible = False
    end
    object INDSetSumRestOfRound: TBCDField
      FieldName = 'SumRestOfRound'
      ReadOnly = True
      Precision = 19
    end
    object INDSetGlassPrice: TFloatField
      FieldName = 'GlassPrice'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object INDSetGlassNDS: TFloatField
      FieldName = 'GlassNDS'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object INDSetSumNal: TBCDField
      FieldName = 'SumNal'
      ReadOnly = True
      Precision = 19
    end
    object INDSetSumBNal: TBCDField
      FieldName = 'SumBNal'
      ReadOnly = True
      Precision = 19
    end
    object INDSetsumPriceN_0: TFloatField
      FieldName = 'sumPriceN_0'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object INDSetsumPriceN_10: TFloatField
      FieldName = 'sumPriceN_10'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object INDSetsumPriceN_18: TFloatField
      FieldName = 'sumPriceN_18'
      ReadOnly = True
      DisplayFormat = '0.00'
    end
    object INDSetSumNotCach: TBCDField
      FieldName = 'SumNotCach'
    end
  end
  object DS_3: TDataSource
    DataSet = INDSet
    Left = 128
    Top = 211
  end
  object DS_2: TDataSource
    DataSet = DivisionDSet
    Left = 59
    Top = 211
  end
  object Connect: TADOConnection
    CommandTimeout = 300
    ConnectionString = 
      'FILE NAME=C:\Program Files\Common Files\System\OLE DB\Data Links' +
      '\PSTrade.udl;'
    IsolationLevel = ilReadUncommitted
    LoginPrompt = False
    Mode = cmReadWrite
    Provider = 'Sybase.ASEOLEDBProvider.2'
    Left = 59
    Top = 115
  end
  object WareHouseDSet: TADODataSet
    Connection = Connect
    CommandText = 'WareHouseSelectAll'
    CommandType = cmdStoredProc
    EnableBCD = False
    IndexFieldNames = 'DivisionName'
    Parameters = <
      item
        Name = 'RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = 1
      end
      item
        Name = '@Type'
        DataType = ftSmallint
        Size = 6
        Value = 1
      end
      item
        Name = '@Result'
        DataType = ftInteger
        Direction = pdOutput
        Precision = 10
        Value = 0
      end
      item
        Name = '@ResultMessage'
        DataType = ftString
        Direction = pdOutput
        Size = 150
        Value = 'OK!'
      end>
    Left = 168
    Top = 24
    object WareHouseDSetID: TFloatField
      FieldName = 'ID'
      ReadOnly = True
    end
    object WareHouseDSetDivisionName: TStringField
      FieldName = 'DivisionName'
      ReadOnly = True
      Size = 100
    end
    object WareHouseDSetKind: TSmallintField
      FieldName = 'Kind'
      ReadOnly = True
    end
    object WareHouseDSetDateAutomat: TDateTimeField
      FieldName = 'DateAutomat'
      ReadOnly = True
    end
    object WareHouseDSetIsMRP: TSmallintField
      FieldName = 'IsMRP'
      ReadOnly = True
    end
    object WareHouseDSetIsContract: TSmallintField
      FieldName = 'IsContract'
      ReadOnly = True
    end
    object WareHouseDSetIsLocked: TSmallintField
      FieldName = 'IsLocked'
      ReadOnly = True
    end
    object WareHouseDSetIsBookcard: TSmallintField
      FieldName = 'IsBookcard'
      ReadOnly = True
    end
    object WareHouseDSetIsCells: TSmallintField
      FieldName = 'IsCells'
      ReadOnly = True
    end
    object WareHouseDSetIsAutoRevaluation: TSmallintField
      FieldName = 'IsAutoRevaluation'
      ReadOnly = True
    end
    object WareHouseDSetDateLock: TDateTimeField
      FieldName = 'DateLock'
      ReadOnly = True
    end
    object WareHouseDSetDescribe: TStringField
      FieldName = 'Describe'
      ReadOnly = True
      Size = 255
    end
    object WareHouseDSetDivisionID: TFloatField
      FieldName = 'DivisionID'
      ReadOnly = True
    end
    object WareHouseDSetDivisionExtID: TFloatField
      FieldName = 'DivisionExtID'
      ReadOnly = True
    end
  end
  object DS: TDataSource
    DataSet = WareHouseDSet
    Left = 197
    Top = 24
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.udl'
    Filter = #1048#1089#1090#1086#1095#1085#1080#1082#1080' '#1076#1072#1085#1085#1099#1093'|*.udl'
    InitialDir = 'C:\Program Files\Common Files\System\OLE DB\Data Links'
    Left = 90
    Top = 115
  end
  object FormStorage1: TFormStorage
    IniFileName = '1c.ini'
    OnRestorePlacement = FormStorage1RestorePlacement
    StoredProps.Strings = (
      'DateInEdit.Text'
      'DateOutEdit.Text'
      'PathEdit.Text')
    StoredValues = <>
    Left = 31
    Top = 115
  end
  object frReport1: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    OnGetValue = frReport1GetValue
    Left = 192
    Top = 182
    ReportForm = {18000000}
  end
  object frDS: TfrDBDataSet
    DataSet = INDSet
    Left = 193
    Top = 211
  end
  object RxLoginDialog1: TRxLoginDialog
    IniFileName = '1c.ini'
    UpdateCaption = ucFormCaption
    OnCheckUser = RxLoginDialog1CheckUser
    OnIconDblClick = RxLoginDialog1IconDblClick
    Left = 272
    Top = 176
  end
end
