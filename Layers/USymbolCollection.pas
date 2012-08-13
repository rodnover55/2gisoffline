unit USymbolCollection;

interface

uses
  Generics.Collections, USymbol, GrymCore_TLB;

type
  TSymbolsList = TList<TSymbol>;
  TSymbolCollection = class(TSymbolsList)
  private
    AllObjectList: TSymbolsList;
  public
    destructor Destroy; override;
    function QueryShapes(const pRect: IMapRect): Integer;
    function GetObjects: TSymbolsList;
  end;

implementation

uses
  SysUtils;

{ TSymbolCollection }

destructor TSymbolCollection.Destroy;
begin
  FreeAndNil(Self.AllObjectList);
  inherited;
end;

function TSymbolCollection.GetObjects: TSymbolsList;
var
  S: TSymbol;
  I: Integer;
begin
  if not Assigned(Self.AllObjectList) then
  begin
    Self.AllObjectList := TSymbolsList.Create;
  end;

  Self.AllObjectList.Clear;
  for I := 0 to Self.Count - 1 do
  begin
    S := Self.Items[I];
    S.FillObjects(Self.AllObjectList);
  end;
  Result := Self.AllObjectList;
end;

function TSymbolCollection.QueryShapes(const pRect: IMapRect): Integer;
begin
  Result := Self.Count;
end;

end.
