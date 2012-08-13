unit UGrymCol;

interface

uses
  Generics.Collections, UGrymRow;

type
  TGrymCol = class
    Rows: TObjectList<TGrymRow>;
  public
    constructor Create;
    destructor Destroy; override;

    function AddRow: TGrymRow;
    function InsertRow(Index: Integer): TGrymRow;
    procedure DeleteRow(Index: Integer);

    function GetEnumerator: TEnumerator<TGrymRow>;
  end;

implementation

uses
  SysUtils;

{ TGrymCol }

function TGrymCol.AddRow: TGrymRow;
begin
  Result := TGrymRow.Create;
  Self.Rows.Add(Result);
end;

constructor TGrymCol.Create;
begin
  Self.Rows := TObjectList<TGrymRow>.Create;
end;

procedure TGrymCol.DeleteRow(Index: Integer);
begin
  Self.Rows.Delete(Index);
end;

destructor TGrymCol.Destroy;
begin
  FreeAndNil(Self.Rows);
  inherited;
end;

function TGrymCol.GetEnumerator: TEnumerator<TGrymRow>;
begin
  Result := Self.Rows.GetEnumerator;
end;

function TGrymCol.InsertRow(Index: Integer): TGrymRow;
begin
  Result := TGrymRow.Create;
  Self.Rows.Insert(Index, Result);
end;

end.
