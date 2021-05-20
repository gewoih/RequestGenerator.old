unit ufXMLViewer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SynEditHighlighter, SynHighlighterXML,
  SynEdit;

type
  TForm3 = class(TForm)
    SynEdit1: TSynEdit;
    SynXMLSyn1: TSynXMLSyn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

end.
