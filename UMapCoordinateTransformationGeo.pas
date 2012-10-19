unit UMapCoordinateTransformationGeo;

interface

uses
  UInterfaceWrapper, GrymCore_TLB, UMapPoint;

type
  TMapCoordinateTransformationGeo
    = class(TInterfaceWrapper<IMapCoordinateTransformationGeo>)
  public
    function LocalToGeo(Point: TMapPoint): TMapPoint;
    function GeoToLocal(Point: TMapPoint): TMapPoint;
  end;

implementation

uses
  ComObj;

{ TMapCoordinateTransformationGeo }

function TMapCoordinateTransformationGeo.GeoToLocal(
  Point: TMapPoint): TMapPoint;
var
  OutPoint: IMapPoint;
begin
  OleCheck(Self.GetInterface.GeoToLocal(Point, OutPoint));
  Result := TMapPoint.Create(OutPoint);
end;

function TMapCoordinateTransformationGeo.LocalToGeo(
  Point: TMapPoint): TMapPoint;
var
  OutPoint: IMapPoint;
begin
  OleCheck(Self.GetInterface.LocalToGeo(Point, OutPoint));
  Result := TMapPoint.Create(OutPoint);
end;

end.
