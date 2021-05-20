program RequestsGenerator;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {Form1},
  ufFillRequest in 'ufFillRequest.pas' {Form2},
  ufXMLViewer in 'ufXMLViewer.pas' {Form3},
  uxADO_cutted in 'uxADO_cutted.pas',
  uxSQL in 'uxSQL.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
