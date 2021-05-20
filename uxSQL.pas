unit uxSQL;

interface

function ConnectSQL(Var Con: OleVariant; Base: AnsiString; Suff: string = ''): boolean;
function GetConStr_Local: string;
function GetConStr_VTK: string;

implementation

uses System.Classes, System.Win.ComObj, System.SysUtils, uxParams;

function GetConStr_Local: string;
begin
  With TStringList.Create do
  try
    LineBreak := ';';
    Values['Provider'] := 'SQLNCLI11';
    Values['Integrated Security'] := 'SSPI';
    Values['Server'] := '(localdb)\RequestsDB';
    Values['AttachDBFilename'] := 'C:\Requests_MainDB.mdf';

    Result := Text;
  finally
    Free;
  end;
end;

function GetConStr_VTK: string;
begin
  With TStringList.Create do
  try
    LineBreak := ';';
    Values['Provider'] := fParams.AsStr['sql\Prov'];
    Values['Persist Security Info'] := 'False';
    Values['Data Source'] := fParams.AsStr['sql\Serv'];
    Values['Initial Catalog'] := fParams.AsStr['sql\Base'];
    Values['User ID'] := fParams.AsStr['sql\User'];
    Values['Application Name'] := ChangeFileExt(ExtractFileName(ParamStr(0)), '');
    Values['MultipleActiveResultSets'] := 'True';
    Values['Password'] := fParams.AsStr['sql\Pass'];
    Result := Text;
  finally
    Free;
  end;
end;

function ConnectSQL(Var Con: OleVariant; base: AnsiString; Suff: string = ''): boolean;
var S: AnsiString;
begin
  try
    Con := CreateOleObject('ADODB.Connection');
    Con.CursorLocation:= 3;
    Con.CommandTimeout := 60000;
    Con.ConnectionTimeout := 10;

    if base = 'local' then
    	Con.Open(GetConStr_Local)
    else if base = 'egais' then
    	Con.Open(GetConStr_VTK);

    Result := True;
  except
    on E:Exception do
    begin
      S := E.Message;
      Result := False;
    end;
  end;
end;

end.
