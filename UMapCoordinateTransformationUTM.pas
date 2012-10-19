unit UMapCoordinateTransformationUTM;

interface

uses
  UInterfaceWrapper, GrymCore_TLB, UMapPoint;

type
  TMapCoordinateTransformationUTM
    = class(TInterfaceWrapper<IMapCoordinateTransformationUTM>)
  public
    function LocalToUTM(Point: TMapPoint): TMapPoint;
    function UTMToLocal(Point: TMapPoint): TMapPoint;
  end;

implementation

uses
  ComObj;

{ TMapCoordinateTransformationUTM }

function TMapCoordinateTransformationUTM.LocalToUTM(
  Point: TMapPoint): TMapPoint;
var
  OutPoint: IMapPoint;
begin
  OleCheck(Self.GetInterface.LocalToUTM(Point, OutPoint));
  Result := TMapPoint.Create(OutPoint);
end;

function TMapCoordinateTransformationUTM.UTMToLocal(
  Point: TMapPoint): TMapPoint;
var
  OutPoint: IMapPoint;
begin
  OleCheck(Self.GetInterface.UTMToLocal(Point, OutPoint));
  Result := TMapPoint.Create(OutPoint);
end;

end.
