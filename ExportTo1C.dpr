program ExportTo1C;

uses
  Forms,
  MainF in 'MainF.pas' {MainForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Выгрузка данных в "1С"';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
