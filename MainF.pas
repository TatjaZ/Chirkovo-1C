unit MainF;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ADODB, Db, Dbf, Grids, DBGridEh, Mask, ToolEdit, RxLookup,
  ExtCtrls, Placemnt, FR_DSet, FR_DBSet, FR_Class,  RxLogin;
  //ehshelprouter, ehsbase, ehswhatsthis, ehscontextmap;

type
  TMainForm = class(TForm)
    Division: TDbf;
    TurnIn: TDbf;
    DivisionDSet: TADODataSet;
    DivisionButton: TButton;
    INDSet: TADODataSet;
    DocButton: TButton;
    DS_3: TDataSource;
    SG: TDBGridEh;
    Label1: TLabel;
    DateInEdit: TDateEdit;
    Label2: TLabel;
    DateOutEdit: TDateEdit;
    DS_2: TDataSource;
    Connect: TADOConnection;
    Label3: TLabel;
    WareHouseBox: TRxDBLookupCombo;
    WareHouseDSet: TADODataSet;
    WareHouseDSetID: TFloatField;
    WareHouseDSetDivisionName: TStringField;
    WareHouseDSetKind: TSmallintField;
    WareHouseDSetDateAutomat: TDateTimeField;
    WareHouseDSetIsMRP: TSmallintField;
    WareHouseDSetIsContract: TSmallintField;
    WareHouseDSetIsLocked: TSmallintField;
    WareHouseDSetIsBookcard: TSmallintField;
    WareHouseDSetIsCells: TSmallintField;
    WareHouseDSetIsAutoRevaluation: TSmallintField;
    WareHouseDSetDateLock: TDateTimeField;
    WareHouseDSetDescribe: TStringField;
    WareHouseDSetDivisionID: TFloatField;
    WareHouseDSetDivisionExtID: TFloatField;
    DS: TDataSource;
    Label4: TLabel;
    OpenDialog1: TOpenDialog;
    KindBox: TRadioGroup;
    FormStorage1: TFormStorage;
    IsZapBox: TCheckBox;
    IsReportBox: TCheckBox;
    frReport1: TfrReport;
    frDS: TfrDBDataSet;
    CancelButton: TButton;
    RxLoginDialog1: TRxLoginDialog;
    DivisionDSetUNN: TStringField;
    DivisionDSetName: TStringField;
    DivisionDSetFullName: TStringField;
    DivisionDSetOKPO: TStringField;
    DivisionDSetAccount: TStringField;
    DivisionDSetMFO: TStringField;
    DivisionDSetAddress: TStringField;
    PathEdit: TDirectoryEdit;
    DivisionYNN: TStringField;
    DivisionNAME: TStringField;
    DivisionFULLNAME: TStringField;
    DivisionOKPOCOD: TStringField;
    DivisionLICENSE: TStringField;
    DivisionADRESS: TStringField;
    DivisionPHONE: TStringField;
    DivisionRS: TStringField;
    DivisionBANK: TFloatField;
    INDSetWHDocumentID: TFloatField;
    INDSetTypeTurn: TIntegerField;
    INDSetKind: TSmallintField;
    INDSetDate: TDateTimeField;
    INDSetNumber: TStringField;
    INDSetDate_Reestr: TStringField;
    INDSetUNN: TStringField;
    INDSetFixedPrice: TIntegerField;
    INDSetIsTara: TIntegerField;
    INDSetsumPriceF: TFloatField;
    INDSetsumPriceN: TFloatField;
    INDSetsumPricePALL: TFloatField;
    INDSetSummOperWithDiscont: TFloatField;
    INDSetSummDiscont: TFloatField;
    INDSetSummTradeRaiseDiscont: TFloatField;
    INDSetSummNDSDiscont: TFloatField;
    INDSetSummRoundDiscon: TFloatField;
    INDSetsumPricePALL_0: TFloatField;
    INDSetsumPricePALL_10: TFloatField;
    INDSetsumPricePALL_18: TFloatField;
    INDSetNDSIn_10: TFloatField;
    INDSetNDSIn_18: TFloatField;
    INDSetQuantityFact: TFloatField;
    INDSetNDSIn: TFloatField;
    INDSetNDSOut: TFloatField;
    INDSetNDSOut_10: TFloatField;
    INDSetNDSOut_18: TFloatField;
    INDSetSumTradeRaise: TFloatField;
    INDSetSumSalesTax: TFloatField;
    INDSetSumRestOfRound: TBCDField;
    INDSetGlassPrice: TFloatField;
    INDSetGlassNDS: TFloatField;
    INDSetSumNal: TBCDField;
    INDSetSumBNal: TBCDField;
    INDSetWareHouseID: TFloatField;
    INDSetDivisionID: TFloatField;
    INDSetsumPriceN_0: TFloatField;
    INDSetsumPriceN_10: TFloatField;
    INDSetsumPriceN_18: TFloatField;
    INDSetSumNotCach: TBCDField;
    TurnInID: TFloatField;
    TurnInKIND: TFloatField;
    TurnInDOCDATE: TDateField;
    TurnInNUMBER: TStringField;
    TurnInUNN: TStringField;
    TurnInSUMF: TFloatField;
    TurnInSUMN: TFloatField;
    TurnInSUMPALL: TFloatField;
    TurnInSUMP_0: TFloatField;
    TurnInSUMP_10: TFloatField;
    TurnInSUMP_18: TFloatField;
    TurnInNDSIN: TFloatField;
    TurnInNDSOUT: TFloatField;
    TurnInNDSOUT_10: TFloatField;
    TurnInNDSOUT_18: TFloatField;
    TurnInTRADERAISE: TFloatField;
    TurnInNP: TFloatField;
    TurnInROUNDOFF: TFloatField;
    TurnInGLASSPRICE: TFloatField;
    TurnInGLASSNDS: TFloatField;
    TurnInDESCRIBE: TStringField;
    TurnInISTARA: TFloatField;
    TurnInTYPE: TFloatField;
    TurnInISFIXPRICE: TFloatField;
    TurnInSUMNAL: TFloatField;
    TurnInSUMBNAL: TFloatField;
    TurnInNDSIN_10: TFloatField;
    TurnInNDSIN_18: TFloatField;
    TurnInDATE_REEST: TDateField;
    TurnInSUMMWITHD: TFloatField;
    TurnInSUMMD: TFloatField;
    TurnInSUMMTRD: TFloatField;
    TurnInSUMMNDSD: TFloatField;
    TurnInSUMMROUNDD: TFloatField;
    TurnInSUMN_0: TFloatField;
    TurnInSUMN_10: TFloatField;
    TurnInSUMN_18: TFloatField;
    TurnInDIVISIONID: TFloatField;
    TurnInWHID: TFloatField;
    TurnInSUMNOTCACH: TFloatField;
    procedure DivisionButtonClick(Sender: TObject);
    procedure DocButtonClick(Sender: TObject);
    procedure TMCDSetBeforeOpen(DataSet: TDataSet);
    procedure TMCDSetAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure KindBoxClick(Sender: TObject);
    procedure FormStorage1RestorePlacement(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
    procedure RxLoginDialog1CheckUser(Sender: TObject; const UserName,
      Password: String; var AllowLogin: Boolean);
    procedure RxLoginDialog1IconDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    ExePath: String;
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

{18.02.2015 таня. Добавлено 5 полей. Сумма со скидкой. Скидка, ТН в скидке, НДС в скидке, округление в скидке. Заявка от 23,01,2015}

procedure TMainForm.DivisionButtonClick(Sender: TObject);
begin
 if DivisionDSet.Active then DivisionDSet.Close;
 try
 DivisionDSet.Open;
 except
 Application.HandleException(Self);
 Exit;
 end;
 Division.CreateTable;
 Division.Open;
 //if not Division.Active then Division.Active:=True;
 SG.DataSource:=DS_2;
 //Division.Zap;
 DivisionDSet.First;
 Screen.Cursor:=crSQLWait;
 while not DivisionDSet.Eof do
  begin
   Division.Append;
   DivisionYNN.Value:=DivisionDSetUNN.Value;
   DivisionName.Value:=DivisionDSetName.Value;
   DivisionFULLName.Value:=DivisionDSetFullName.Value;
   DivisionOKPOCOD.Value:=DivisionDSetOKPO.Value;
   DivisionADRESS.Value:=DivisionDSetAddress.Value;
   DivisionRS.Value:=DivisionDSetAccount.Value;
   if DivisionDSetMFO.Value<>' ' then
    begin
     try
     if length(DivisionDSetMFO.Value)>3
     then DivisionBank.Value:=StrToInt(copy(DivisionDSetMFO.Value,length(DivisionDSetMFO.Value)-2,3))
     else DivisionBank.Value:=DivisionDSetMFO.AsInteger;
     except
     DivisionBank.Value:=0;
     end;
    end
   else DivisionBank.Value:=0;
   Division.Post;
   Application.ProcessMessages;
   DivisionDSet.Next;
  end;
 Screen.Cursor:=crDefault;
 ShowMessage('Формирование файла контрагентов завершено!');
 DivisionDSet.Close;
end;

procedure TMainForm.DocButtonClick(Sender: TObject);
begin
 //if not TurnIn.Active then TurnIn.Active;
 //TurnIn.Open;
 //TurnIn.Zap;
 //TurnIn.Open;
 //if IsZapBox.Checked then TurnIn.Zap;
 TurnIn.CreateTable;
 TurnIn.Open;

 while not InDSet.Eof do
  begin
   TurnIn.Append;
   TurnInID.Value         := INDSetWHDocumentID.Value;
   TurnInTYPE.Value       := INDSetTypeTurn.Value;
   TurnInKIND.Value       := INDSetKind.Value;
   TurnInDOCDATE.Value    := INDSetDate.Value;
   TurnInNUMBER.Value     := INDSetNumber.Value;
   TurnInWHID.Value       := INDSetWareHouseID.AsInteger;
   TurnInDivisionID.Value := INDSetDivisionID.AsInteger;
   TurnInDATE_REEST.Value := StrToDate(INDSetDate_Reestr.Value);
   TurnInUNN.Value        := INDSetUNN.Value;
   TurnInSUMF.Value       := INDSetsumPriceF.Value;
   TurnInSUMN.Value       := INDSetsumPriceN.Value;
   TurnInSUMPALL.Value    := INDSetsumPricePALL.Value;
   TurnInSUMP_0.Value     := INDSetsumPricePALL_0.Value;
   TurnInSUMP_10.Value    := INDSetsumPricePALL_10.Value;
   TurnInSUMP_18.Value    := INDSetsumPricePALL_18.Value;
   TurnInNDSIN.Value      := INDSetNDSIn.Value;
   TurnInNDSOUT.Value     := INDSetNDSOUT.Value;
   TurnInNDSOUT_10.Value  := INDSetNDSOUT_10.Value;
   TurnInNDSOUT_18.Value  := INDSetNDSOUT_18.Value;
   TurnInTRADERAISE.Value := INDSetSumTradeRaise.Value;
   TurnInNP.Value         := INDSetSumSalesTax.Value;
   TurnInISFIXPRICE.Value := INDSetFixedPrice.Value;
   TurnInISTARA.Value     := INDSetIsTara.Value;
   TurnInROUNDOFF.Value   := INDSetSumRestOfRound.Value;
   TurnInGLASSPRICE.Value := INDSetGlassPrice.Value;
   TurnInGLASSNDS.Value   := INDSetGlassNDS.Value;
   TurnInDESCRIBE.Value   := '';
   TurnInSUMNAL.Value     := INDSetSumNal.Value;
   TurnInSUMBNAL.Value    := INDSetSumBNal.Value;
   TurnInNDSIN_10.Value  := INDSetNDSIn_10.Value;
   TurnInNDSIN_18.Value  := INDSetNDSIn_18.Value;
   TurnInSUMMWITHD.Value :=INDSetSummOperWithDiscont.Value;
   TurnInSUMMD.Value  := INDSetSummDiscont.Value;
   TurnInSUMMTRD.Value  := INDSetSummTradeRaiseDiscont.Value;
   TurnInSUMMNDSD.Value  := INDSetSummNDSDiscont.Value;
   TurnInSUMMROUNDD.Value  :=INDSetSummRoundDiscon.Value;
   TurnInSUMN_0.Value     := INDSetsumPriceN_0.Value;
   TurnInSUMN_10.Value    := INDSetsumPriceN_10.Value;
   TurnInSUMN_18.Value    := INDSetsumPriceN_18.Value;
   TurnInSumNotCach.Value    := INDSetSumNotCach.Value;
   TurnIn.Post;
   Application.ProcessMessages;
   InDset.Next;
  end;

 Screen.Cursor:=crDefault;
 InDset.First;
 TurnIn.Close;

 if IsReportBox.Checked then
  begin
    frDS.DataSet := INDSet;
    frReport1.LoadFromFile(ExePath+'Приход.frf');
    frReport1.ShowReport;
    frReport1.Clear;
  end else ShowMessage('Формирование документов завершено!');
end;


procedure TMainForm.TMCDSetBeforeOpen(DataSet: TDataSet);
begin
 Screen.Cursor:=crSQLWait;
end;

procedure TMainForm.TMCDSetAfterOpen(DataSet: TDataSet);
begin
 Screen.Cursor:=crDefault;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
 //ExePath:=GetExePath;
 WareHouseDSet.Parameters.ParamByName('@Type').Value:=1;
 if WareHouseDSet.Active then WareHouseDSet.Close;
 try
  WareHouseDSet.Open;
 except
  Application.HandleException(Self);
 end;
 WareHouseBox.OnChange := KindBoxClick;
 //CodeTable.FilePathFull:=ExePath+'DBF\';
 //CodeTable.TableName:=ExePath+'DBF\Коды.dbf';
 //CodeTable.Open;
end;

procedure TMainForm.KindBoxClick(Sender: TObject);
begin
 case KindBox.ItemIndex of
 0 : begin
      Division.FilePathFull:=PathEdit.Text;
      Division.TableName:=PathEdit.Text+'\Kontr.dbf';
      if DivisionDSet.Active then DivisionDSet.Close;
      Screen.Cursor:=crSQLWait;
      if WareHouseBox.Value<>'0' then
      DivisionDSet.Parameters.ParamByName('@WareHouseID').Value:=WareHouseBox.KeyValue
      else DivisionDSet.Parameters.ParamByName('@WareHouseID').Value:=0;
      DivisionDSet.Parameters.ParamByName('@DateIn').Value:=DateInEdit.Date;
      DivisionDSet.Parameters.ParamByName('@DateTo').Value:=DateOutEdit.Date;
      try
      DivisionDSet.Open;
      DivisionButton.Enabled:=True;
      DocButton.Enabled:=False;
      SG.DataSource:=DS_2;
      Screen.Cursor:=crDefault;
      except
      Application.HandleException(Self);
      Screen.Cursor:=crDefault;
      end;
     end;
 1 : begin
      TurnIn.FilePathFull:=PathEdit.Text;
      TurnIn.TableName:=PathEdit.Text+'\Document.dbf';
      Screen.Cursor:=crSQLWait;
      if INDSet.Active then INDSet.Close;
      InDSet.Parameters.ParamByName('@DateFrom').Value:=DateInEdit.Date;
      InDSet.Parameters.ParamByName('@DateTo').Value:=DateOutEdit.Date;
      if WareHouseBox.Value<>'0' then InDset.Parameters.ParamByName('@WareHouseID').Value:=WareHouseBox.KeyValue
      else InDset.Parameters.ParamByName('@WareHouseID').Value:=0;
      try
      InDset.Open;
      Screen.Cursor:=crDefault;
      SG.DataSource:=DS_3;
      DivisionButton.Enabled:=False;
      DocButton.Enabled:=True;
      except
      Application.HandleException(Self);
      Screen.Cursor:=crDefault;
      end;
     end;
 else ShowMessage('Не указан справочник!');
end;

end;

procedure TMainForm.FormStorage1RestorePlacement(Sender: TObject);
begin
 DateInEdit.OnChange := KindBoxClick;
 DateOutEdit.OnChange := KindBoxClick;
end;

procedure TMainForm.CancelButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
if MessageBox(0,'Вы действительно хотите выйти?','Предупреждение',
               MB_YESNO or MB_ICONWARNING or MB_TASKMODAL)=IDYES
 then CanClose:=True
  else CanClose:=False;
end;

procedure TMainForm.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
 if ParName='Скдад' then ParValue:=WareHouseBox.Text;
 if ParName='Дата1' then ParValue:=DateInEdit.Text;
 if ParName='Дата2' then ParValue:=DateOutEdit.Text;
end;

procedure TMainForm.RxLoginDialog1CheckUser(Sender: TObject;
  const UserName, Password: String; var AllowLogin: Boolean);
begin
 Connect.Open(UserName, Password);
 try
 AllowLogin:=Connect.Connected;
 except
 Application.HandleException(Self);
 end;
end;

procedure TMainForm.RxLoginDialog1IconDblClick(Sender: TObject);
begin
 if OpenDialog1.Execute then
  Connect.ConnectionString:='FILE NAME='+OpenDialog1.FileName;
end;

end.
