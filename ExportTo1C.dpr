program ExportTo1C;

uses
  Forms,
  MainF in 'MainF.pas' {MainForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := '�������� ������ � "1�"';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
