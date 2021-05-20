unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Tabs, VirtualTrees, Vcl.Menus,
  Vcl.StdCtrls, Vcl.ExtCtrls, TFlatPanelUnit, uBase, uSysCtrls, ufFillRequest,
  Winapi.ActiveX, System.Win.ComObj, SyncObjs, Xml.xmldom, Xml.XMLIntf,
  Xml.XMLDoc;

  	type
        TRequest = Class
        private
        	Requests:		array of OleVariant;
            FRowCount:		integer;
            FColumnCount:	integer;
    		FRequestType: 	integer;

            procedure SetColumnCount(const Value: integer);
            procedure SetRowCount(const Value: integer);
    		procedure SetRequestType(const Value: integer);
        public
            Constructor	Create(RequestType: integer);
            property 	RequestType: integer read FRequestType write SetRequestType;
            property 	RowCount: integer read FRowCount write SetRowCount;
            property 	ColumnCount:  integer read FColumnCount write SetColumnCount;
            function 	GetValue(row, column: integer): OleVariant;
            procedure 	SetValue(row, column:	integer; R: OleVariant);
            procedure 	FillUpRequests(K: integer; R: OleVariant);
        End;


type
  TForm1 = class(TForm)
    RequestsTree: TVirtualStringTree;
    PopupMenu1: TPopupMenu;
    miCreateRequest: TMenuItem;
    miOpenXML: TMenuItem;
    miSendRequest: TMenuItem;
    XMLDocument1: TXMLDocument;
    miSaveXML: TMenuItem;
    N2: TMenuItem;
    SaveDialog1: TSaveDialog;
    btUpdateInfo: TButton;
    FlatPanel1: TFlatPanel;
    procedure miCreateRequestClick(Sender: TObject);
    procedure RequestsTreeBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure RequestsTreeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure miSendRequestClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LoadRequests;
    procedure miOpenXMLClick(Sender: TObject);
    procedure FillUpRequestsAddProducts(K: integer; R: OleVariant);
    procedure miSaveXMLClick(Sender: TObject);
    procedure btUpdateInfoClick(Sender: TObject);

  private
    RequestsAddProducts:	array of array [0..22] of AnsiString;
    fLastNode:  			PVirtualNode;
    RequestAddProducts:     TRequest;

//    FSRAR_ID:			0
//    client_id:        1
//    request_number:   2
//    request_date:     3
//    producer:         4
//    request_type:     5
//    vid_code:         6
//    country_code:     7
//    full_name:        8
//    short_name:       9
//    unpacked_flag:    10
//    capacity:         11
//    alc_percent:      12
//    alc_percent_min:  13
//    alc_percent_max:  14
//    frap_id:          15
//    brand:            16
//    package_type:     17
//    status:           18
//    xml:              19
//    version:          20
//    querry_id:        21
//    reply_text:       22
  end;

var
  Form1:					TForm1;
  fcon_local, fcon_egais:	OleVariant;
  fLast:                    AnsiString;

implementation

{$R *.dfm}

uses System.AnsiStrings, uxADO_cutted, ufXMLViewer, uxSQL;

procedure TForm1.btUpdateInfoClick(Sender: TObject);
var
R, R1:	OleVariant;
    K, temp_id:										Integer;
	N:												PVirtualNode;
    reply_text, query_ids:							AnsiString;
begin
  try
  	RequestsTree.BeginUpdate;
    btUpdateInfo.Enabled := false;

  	N := Nil;
    try
        R := fcon_local.Execute('select query_id from Requests where isnull(query_id, '''') <> ''''');
        while not R.EOF do
        begin
            query_ids := query_ids + AsStr(R, 0) + ',';
            R.MoveNext;
        end;
        delete(query_ids, High(query_ids), 1);

        if query_ids <> '' then
            begin
            R1 := fcon_egais.Execute('select queryid, data from Reply where queryid in (' + query_ids + ')');
            while not R1.EOF do
            begin
                XMLDocument1.LoadFromXML(UTF8Encode(AsStr(R1, 1)));
                XMLDocument1.Version := '1.0';
                XMLDocument1.Encoding := 'UTF-8';
                XMLDocument1.Active := true;
                reply_text := XMLDocument1.DocumentElement.ChildNodes['Document'].ChildNodes['Ticket'].ChildNodes['Result'].ChildNodes['Comments'].Text;
                reply_text := StringReplace(reply_text, #39, '', [rfReplaceAll]);
                fcon_local.Execute('update Requests set reply_text = ' + #39 + reply_text + #39 + ', vers = convert(char(23), getdate(), 126) where query_id = ' + #39 + AsStr(R1, 0) + #39);

                R1.MoveNext;
                XMLDocument1.Active := false;
            end;
        end;

    	R := fcon_local.Execute('select * from Requests where vers > ''' + FLast + '''');
        if R.EOF then Exit;

       while not R.EOF do
        begin
        	temp_id := AsInt(R, 'request_number');
            K := -1;

            N := RequestsTree.GetFirst;
            while Assigned(N) do
            begin
                if (RequestsAddProducts[N.RowIndex, 2] = temp_id.ToString) then
                begin
                    K := N.RowIndex;
                    break;
                end;
                N := N.NextSibling;
            end;

            if K < 0 then // Значит появилась новая запись
            begin
                K := Length(RequestsAddProducts);
                SetLength(RequestsAddProducts, K + 1);
                N := RequestsTree.AddChild(Nil, pointer(K));
            end;

            if FLast < AsStr(R, 'vers') then
                FLast := AsStr(R, 'vers');

            FillUpRequestsAddProducts(K, R);
            R.MoveNext;
        end;
    finally
        RequestsTree.EndUpdate;
        RequestsTree.Invalidate;
        btUpdateInfo.Enabled := true;
    end;
  except
    K := K;
  end;
end;

procedure TForm1.FillUpRequestsAddProducts(K: integer; R: OleVariant); //Готов
begin
	for var i: integer := 0 to 22 do
	begin
    	RequestsAddProducts[K, i] := AsStr(R, i+1);
    end;
end;

procedure TForm1.LoadRequests;
var
    R:	OleVariant;
    K:	integer;
begin
    try
        RequestsTree.BeginUpdate;
        RequestsTree.Clear;

        K := 0;
    	R := fcon_local.Execute('select * from Requests');
        while not R.EOF do
        begin
            SetLength(RequestsAddProducts, K + 1);
        	RequestsTree.AddChild(nil, pointer(K));
            FillUpRequestsAddProducts(K, R);

            if FLast < AsStr(R, 'vers') then
            	FLast := AsStr(R, 'vers');

            R.MoveNext;
            Inc(K);
        end;

    finally
    	RequestsTree.EndUpdate;
        RequestsTree.Invalidate;
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    ConnectSQL(fcon_local, 'local');
    ConnectSQL(fcon_egais, 'egais');
    LoadRequests;
end;

procedure TForm1.miCreateRequestClick(Sender: TObject);
procedure SendToBase(Request: array of AnsiString);
var
    text:	AnsiString;
begin
    text := 'insert into Requests values(';

    for var i := 0 to 22 do
    begin
    	if i = 20 then
        	text := text + 'convert(char(23), getdate(), 126),'
        else if i = 22 then
        	text := text + 'null)'
        else
        	text := text + #39 + Request[i] + #39 + ',';
    end;

    text := StringReplace(text, #$a0, '', [rfReplaceAll]);
    text := StringReplace(text, #$0a, '', [rfReplaceAll]);
	text := StringReplace(text, #$0d, '', [rfReplaceAll]);
    text := StringReplace(text, #$d, '', [rfReplaceAll]);
    text := StringReplace(text, #$9, '', [rfReplaceAll]);

    fcon_local.Execute(text);
end;

var
    K:	integer;
    s:  AnsiString;
begin
    try
        with TForm2.Create(nil) do
        begin
        	RequestsTree.BeginUpdate;

        	K := Length(RequestsAddProducts);
            ValueListEditor1.Cells[1, 1] := '010060693049';
            ValueListEditor1.Cells[1, 2] := ValueListEditor1.Cells[1, 1];
            ValueListEditor1.Cells[1, 3] := (K+1).ToString;
            ValueListEditor1.Cells[1, 4] := FormatDateTime('yyyy-mm-dd', Now);
            for var i: integer := 4 to 17 do
            begin
            	ValueListEditor1.Cells[1, i+1] := RequestsAddProducts[RequestsTree.FocusedNode.Index, i];
            end;

            if ShowModal = mrOk then
            begin
                SetLength(RequestsAddProducts, K + 1);
                for var i := 0 to 17 do
                begin
                    RequestsAddProducts[K][i] := ValueListEditor1.Cells[1, i+1];
                end;
                RequestsAddProducts[K][18] := 'Новый';

                s := StringContainer1.Items.Text;
                for var i := 0 to 18 do
                begin
                	s := StringReplace(s, '%s', RequestsAddProducts[K, i], []);
                end;
                RequestsAddProducts[K][19] := s;

                SendToBase(RequestsAddProducts[K]);
                RequestsTree.AddChild(nil, pointer(K));
            end;
        end;
    finally
        RequestsTree.EndUpdate;
        RequestsTree.Invalidate;
    end;
end;

procedure TForm1.miOpenXMLClick(Sender: TObject);
var
    req:	AnsiString;
begin
    with TForm3.Create(nil) do
    try
        req := Form2.StringContainer1.Items.Text;
        for var i := 0 to 17 do
        begin
            req := StringReplace(req, '%s', RequestsAddProducts[RequestsTree.FocusedNode.Index, i], []);
        end;

        SynEdit1.Lines.Text := req;
        ShowModal;
    finally
        Free;
    end;
end;

procedure TForm1.miSaveXMLClick(Sender: TObject);
begin
    try
    	with TStringList.Create do
        begin
            Add(RequestsAddProducts[RequestsTree.FocusedNode.Index, 19]);
            SaveDialog1.FileName := RequestsAddProducts[RequestsTree.FocusedNode.Index, 9];
        	if SaveDialog1.Execute then
        	begin
                SaveToFile(SaveDialog1.FileName);
                Free;
        	end;
        end;
    finally
    end;
end;

procedure TForm1.miSendRequestClick(Sender: TObject);
var
    R:	OleVariant;
begin
	try
    	R := fcon_egais.Execute('exec dbo.QueryAdd ''010060693049'',''' + RequestsAddProducts[RequestsTree.FocusedNode.Index, 19] + ''',35');
        if AsStr(R, 0) = '1' then
        begin
        	fcon_local.Execute('update Requests set query_id = ''' + AsStr(R, 1)
             + ''', status = ''В обработке'', vers = convert(char(23), getdate(), 126) where request_number = ' +
             RequestsAddProducts[RequestsTree.FocusedNode.Index, 2]);

        	ShowMessage('Запрос успешно отправлен. Его номер - ' + AsStr(R, 1));
        end;
    finally

    end;
end;

procedure TForm1.RequestsTreeBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
	var R := CellRect;
    if Node.Index mod 2 = 0 then TargetCanvas.Brush.Color := $E0FFE0 else TargetCanvas.Brush.Color := $E0FFFF;
    if (Node=Sender.FocusedNode) or (Column=Sender.FocusedColumn) then TargetCanvas.Brush.Color := TargetCanvas.Brush.Color - $200020;
    if (Node=Sender.FocusedNode) and (Column=Sender.FocusedColumn) then TargetCanvas.Brush.Color := $FFFFFF;
    TargetCanvas.FillRect(R);
end;

procedure TForm1.RequestsTreeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
begin
	case RequestsTree.Header.Columns[Column].Tag of
    0: CellText := RequestsAddProducts[Node.RowIndex, 2];
    1: CellText := RequestsAddProducts[Node.RowIndex, 3];
    2: CellText := RequestsAddProducts[Node.RowIndex, 8];
    3: CellText := RequestsAddProducts[Node.RowIndex, 18];
    5: CellText := RequestsAddProducts[Node.RowIndex, 20];
    6: CellText := RequestsAddProducts[Node.RowIndex, 21];
    7: CellText := RequestsAddProducts[Node.RowIndex, 22];
    8: CellText := RequestsAddProducts[Node.RowIndex, 11];
    9: CellText := RequestsAddProducts[Node.RowIndex, 12];
end;
end;

{ TRequest }

constructor TRequest.Create(RequestType: integer);
begin
    SetRequestType(RequestType);
end;

procedure TRequest.FillUpRequests(K: integer; R: OleVariant);
begin
    for var i: integer := 0 to FColumnCount do
	begin
        SetValue(K, i, R);
    end;
end;

function TRequest.GetValue(row, column: integer): OleVariant;
begin
    Result := Requests[row * FColumnCount + column];
end;

procedure TRequest.SetColumnCount(const Value: integer);
begin
  	FColumnCount := Value;
end;

procedure TRequest.SetRequestType(const Value: integer);
begin
  FRequestType := Value;
end;

procedure TRequest.SetRowCount(const Value: integer);
begin
  	FRowCount := Value;
end;

procedure TRequest.SetValue(row, column: integer; R: OleVariant);
begin
    Requests[row * FColumnCount + column] := R;
end;

end.
