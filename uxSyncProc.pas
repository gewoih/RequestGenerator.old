unit uxSyncProc;

interface

implementation

procedure TForm1.SyncProc;
var
    fcon_thread, R:	OleVariant;
    K, temp_id:		Integer;
	N:				PVirtualNode;
begin
  try
  	RequestsTree.BeginUpdate;
  	fSect.Enter;
  	ConnectSQL(fcon_thread);

  	N := Nil;
    try
    	R := fcon_thread.Execute('select * from Requests where vers > ''' + fThread.FLast + '''');
        if R.Eof then Exit;

        while not R.EOF do
        begin
        	temp_id := AsInt(R, 'request_number');
            K := -1;

            N := RequestsTree.GetFirst;
            while Assigned(N) do
            begin
                if (Requests[N.RowIndex, 2] = temp_id.ToString) then
                begin
                    K := N.RowIndex;
                    break;
                end;
                N := N.NextSibling;
            end;

            if K < 0 then // Значит появилась новая запись
            begin
                K := Length(Requests);
                SetLength(Requests, K + 1);
                N := RequestsTree.AddChild(Nil, pointer(K));
            end;

            if fThread.FLast < AsStr(R, 'vers') then
                fThread.FLast := AsStr(R, 'vers');

            FillUpRequests(K, R);
            R.MoveNext;
        end;
    finally
        fSect.Leave;
        fcon_thread.Close;
        RequestsTree.EndUpdate;
        RequestsTree.Invalidate;
    end;
  except
    K := K;
  end;
end;

procedure txSyncThread.Execute;
begin
  inherited;
  CoInitializeEx(nil, 0);
  repeat
    try
      try
        Synchronize(Self, SyncProc);
      except
      end;
    finally
      Sleep(5000);
    end;
  until Terminated;
  CoUninitialize;
end;

end.
