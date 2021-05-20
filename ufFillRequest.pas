unit ufFillRequest;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ValEdit, Vcl.StdCtrls,
  uBase, uSysCtrls;

type
  TForm2 = class(TForm)
    ValueListEditor1: TValueListEditor;
    StringContainer1: TStringContainer;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses ufXMLViewer;

procedure TForm2.Button1Click(Sender: TObject);
var
    req:	AnsiString;
begin
    with TForm3.Create(nil) do
    try
        req := StringContainer1.Items.Text;
        for var i := 0 to 17 do
        begin
            req := StringReplace(req, '%s', ValueListEditor1.Cells[1, i+1], []);
        end;

        SynEdit1.Lines.Text := req;
        ShowModal;
    finally
        Free;
    end;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
    ModalResult := mrOK;
end;

end.
