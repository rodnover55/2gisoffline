unit UGrymDatabase;

interface

uses
  UInterfaceWrapper, GrymCore_TLB;
type
  TGrymDatabase = class(TInterfaceWrapper<IDatabase>)
  private
    FQueryMapBuilding: IQuery;
  public
    function QueryMapBuildingID(City: string; Street: string; Number: string)
      : Integer;
  end;

implementation

uses
  ComObj;

{ TGrymDatabase }

function TGrymDatabase.QueryMapBuildingID(City, Street,
  Number: string): Integer;
var
  Building: IDataRow;
begin
  if not Assigned(Self.FQueryMapBuilding) then
  begin
    OleCheck(Self.GetInterface.CreateQuery('map_building'
      , Self.FQueryMapBuilding));
  end;

  OleCheck(Self.FQueryMapBuilding.AddCriterion('city', Variant(City)));
  OleCheck(Self.FQueryMapBuilding.AddCriterion('street', Variant(Street)));
  OleCheck(Self.FQueryMapBuilding.AddCriterion('number', Variant(Number)));
  OleCheck(Self.FQueryMapBuilding.Execute);

  Result := -1;
  if Self.FQueryMapBuilding.Fetch(Building) = S_OK then
  begin
    OleCheck(Building.Get_Index(Result));
  end;
end;

end.
