unit UGrymToolRadius;

interface

uses
  UInterfaceWrapper, GrymCore_TLB, UMapPoint;

type
  TGrymToolRadius = class(TInterfaceWrapper<IGrymToolRadius>)
  public
    function GetRadius: Double;
    function GetCenterPoint: TMapPoint;
  end;

implementation

uses
  ComObj;

{ TGrymToolRadius }

function TGrymToolRadius.GetCenterPoint: TMapPoint;
var
  Pnt: IMapPoint;
begin
  OleCheck(Self.GetInterface.Get_CenterPoint(Pnt));

  Result := TMapPoint.Create(Pnt);
end;

function TGrymToolRadius.GetRadius: Double;
begin
  OleCheck(Self.GetInterface.Get_Radius(Result));
end;

end.
