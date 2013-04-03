unit UGrymMapBuildingsTable;

interface

uses
  UGrymTable, UGrymMapBuilding, UFeature;

type
  TGrymMapBuildingsTable = class(TBaseGrymTable<TGrymMapBuilding>)
  public
    function GetFeatureByID(ID: Integer): TFeature;
  end;

implementation

uses
  SysUtils;
{ TGrymMapBuildingsTable }

function TGrymMapBuildingsTable.GetFeatureByID(ID: Integer): TFeature;
var
  OldID: Integer;
  Building: TGrymMapBuilding;
begin
  OldID := Self.GetRecNo;

  try
    Building := TGrymMapBuilding.Create;
    Self.SetRecNo(ID);
    Self.FillObject(Building);

    Result := TFeature.Create(Building.Feature);
  finally
    Self.SetRecNo(OldID);
    FreeAndNil(Building);
  end;
end;

end.
