unit UGrymDatabase;

interface

uses
  UInterfaceWrapper, GrymCore_TLB, UGrymTable, UGrymMapBuilding, UGrymStreet
    , UFeature, Generics.Collections, UGrymMapBuildingsTable;

type
  TGrymStreetsTable = TBaseGrymTable<TGrymStreet>;
  TFeatureList = TList<TFeature>;
  TFeatureObjectList = TObjectList<TFeature>;
  TGrymDatabase = class(TInterfaceWrapper<IDatabase>)
  private
  // TODO: создать TGrymQuery = class(TGrymTable) переместить запросы туда.
    FQueryMapBuilding: IQuery;
    FQuerySpatial: IQuery;
    FTableBuildings: TGrymMapBuildingsTable;
    FTableStreets: TGrymStreetsTable;
  protected
  public
    constructor Create; overload;
    constructor Create(P: IDatabase); overload;
    function QueryMapBuildingID(City: string; Street: string; Number: string)
      : Integer;

    function QueryMapBuilding(City: string; Street: string; Number: string)
      : TFeature;

    function QueryDistrictName(Feature: IFeature): string;
    function QueryMicroDistrictName(Feature: IFeature): string;

    function QuerySpatial(Layer: ILayer; Shape: IShapeFill): TFeatureObjectList;

    function GetTableBuildings: TGrymMapBuildingsTable;
    function GetTableStreets: TGrymStreetsTable;
  end;

implementation

uses
  ComObj, UGrymPlugin, SysUtils, UMapPoint;

{ TGrymDatabase }


constructor TGrymDatabase.Create;
begin
  Self.Create(nil);
end;

constructor TGrymDatabase.Create(P: IDatabase);
begin
  inherited;
  OleCheck(Self.GetInterface.CreateQuery('spatial', Self.FQuerySpatial));
end;

function TGrymDatabase.GetTableBuildings: TGrymMapBuildingsTable;
begin
  if not Assigned(Self.FTableBuildings) then
  begin
    Self.FTableBuildings := TGrymMapBuildingsTable.Create(nil);
    Self.FTableBuildings.OpenTable('grym_map_building');
  end;
  Result := Self.FTableBuildings;
end;

function TGrymDatabase.GetTableStreets: TGrymStreetsTable;
begin
  if not Assigned(Self.FTableStreets) then
  begin
    Self.FTableStreets := TGrymStreetsTable.Create(nil);
    Self.FTableStreets.OpenTable('grym_map_street');
  end;
  Result := Self.FTableStreets;
end;

function TGrymDatabase.QueryDistrictName(Feature: IFeature): string;
var
  Layer: ILayer;
  District: IDataRow;
  Data: OleVariant;
begin
  Layer := TGrymPlugin.GetInstance.BaseViewThread.GetFrame.GetMap.GetLayers
    .FindLayer('Grym_Map_UMLRADM0');

  OleCheck(Self.FQuerySpatial.AddCriterion('layer', OLEVariant(Layer)));
  OleCheck(Self.FQuerySpatial.AddCriterion('filter', OLEVariant(Feature)));
  OleCheck(Self.FQuerySpatial.Execute);

  Result := EmptyStr;

  if Self.FQuerySpatial.Fetch(District) = S_OK then
  begin
    OleCheck(District.Get_Value('name', Data));
    Result := Data;
  end;
end;

function TGrymDatabase.QueryMapBuilding(City, Street, Number: string): TFeature;
var
  Building: IDataRow;
begin
  if not Assigned(Self.FQueryMapBuilding) then
  begin
    OleCheck(Self.GetInterface.CreateQuery('map_building'
      , Self.FQueryMapBuilding));
  end;

  try
  // Исправляем ошибку 2гис, если загнать пустой параметр вылезает сообщение об ошибке
    if City = EmptyStr then
    begin
      City := TGrymPlugin.GetInstance.BaseViewThread.GetBaseReference.GetName;
    end;

    OleCheck(Self.FQueryMapBuilding.AddCriterion('city', Variant(City)));
    OleCheck(Self.FQueryMapBuilding.AddCriterion('street', Variant(Street)));
    OleCheck(Self.FQueryMapBuilding.AddCriterion('number', Variant(Number)));
    OleCheck(Self.FQueryMapBuilding.Execute);
  except
    Exit(nil);
  end;

  Result := nil;

  if Self.FQueryMapBuilding.Fetch(Building) = S_OK then
  begin
    Result := TFeature.Create(Building as IFeature);
  end
end;

function TGrymDatabase.QueryMapBuildingID(City, Street,
  Number: string): Integer;
var
  Building: IDataRow;
  Feature: TFeature;
begin
  Feature := Self.QueryMapBuilding(City, Street, Number);

  try
    if Assigned(Feature) then
    begin
      Building := Feature.GetInterface as IDataRow;
    end;
  finally
    FreeAndNil(Feature);
  end;

  Result := -1;

  if Assigned(Building) then
  begin
    OleCheck(Building.Get_Index(Result));
  end;
end;

function TGrymDatabase.QueryMicroDistrictName(Feature: IFeature): string;
var
  Layer: ILayer;
  District: IDataRow;
  Data: OleVariant;
begin
  Layer := TGrymPlugin.GetInstance.BaseViewThread.GetFrame.GetMap.GetLayers
    .FindLayer('Grym_Map_UMLRLREG');

  OleCheck(Self.FQuerySpatial.AddCriterion('layer', OLEVariant(Layer)));
  OleCheck(Self.FQuerySpatial.AddCriterion('filter', OLEVariant(Feature)));
  OleCheck(Self.FQuerySpatial.Execute);

  Result := EmptyStr;

  if Self.FQuerySpatial.Fetch(District) = S_OK then
  begin
    OleCheck(District.Get_Value('name', Data));
    Result := Data;
  end;
end;

function TGrymDatabase.QuerySpatial(Layer: ILayer;
  Shape: IShapeFill): TFeatureObjectList;
var
  List: TFeatureObjectList;
  DataRow: IDataRow;
begin
  OleCheck(Self.FQuerySpatial.AddCriterion('layer', OLEVariant(Layer)));
  OleCheck(Self.FQuerySpatial.AddCriterion('filter', OLEVariant(Shape)));
  OleCheck(Self.FQuerySpatial.Execute);

  List := TFeatureObjectList.Create;

  try
    while Self.FQuerySpatial.Fetch(DataRow) = S_OK do
    begin
      List.Add(TFeature.Create(DataRow as IFeature));
    end;
    Result := List;
  except
    FreeAndNil(List);
    raise;
  end;
end;

end.


