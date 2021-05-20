unit uxADO_cutted;

interface

function IsNull(A, B: variant): variant;
function AsVar(Rec: Olevariant; Fld: variant): OLEVariant;
function AsInt(Rec: Olevariant; Fld: variant): Int64;
function AsStr(Rec: Olevariant; Fld: variant): AnsiString;

implementation

uses System.Math, System.Variants, Winapi.ActiveX;

function AsInt(Rec: Olevariant; Fld: variant): Int64;
var V: Variant;
begin
  If Rec.EOF then
    Result := 0
  else
  begin
    V := AsVar(Rec, Fld);
    Result := isnull(V, 0);
  end;
end;

function AsVar(Rec: Olevariant; Fld: variant): OLEVariant;
var V: Int64;
begin
  If Rec.EOF then
    Result := Null
  else if VarType(Fld) in [varByte, varInteger, varShortInt] then
    Result := Rec.Fields[integer(Fld)].Value
  else
    Result := Rec.Fields[string(Fld)].Value;
  if tVarData(Result).VType = 8209 then
    tVarData(Result).VType := varUInt32
  else if tVarData(Result).VType=14 then
  begin
    if TDecimal(Result).Scale = 0 then
    begin
      Result := TDecimal(Result).Lo64 * (1 - TDecimal(Result).sign div 64);
    end
    else
      Result := RoundTo(Power10(TDecimal(Result).Lo64, -TDecimal(Result).scale), -TDecimal(Result).scale) * (1 - TDecimal(Result).sign div 64);
  end;
end;

function AsStr(Rec: Olevariant; Fld: variant): AnsiString;
begin
  If Rec.EOF then Result := '' else Result := isnull(AsVar(Rec, Fld),'');
end;

function IsNull(A, B: variant):variant;
begin
  if VarIsNull(A) then Result := B else Result := A;
end;

end.
