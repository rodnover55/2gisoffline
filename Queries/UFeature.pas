unit UFeature;

interface

uses
  UInterfaceWrapper, GrymCore_TLB, UMapPoint;

type
  TFeature = class(TInterfaceWrapper<IFeature>)
  public
    function CenterPoint: TMapPoint;
  end;

implementation

uses
  ComObj;
{ TFeature }

function TFeature.CenterPoint: TMapPoint;
var
  pMapPoint: IMapPoint;
begin
  OleCheck(Self.GetInterface.Get_CenterPoint(pMapPoint));
  Result := TMapPoint.Create(pMapPoint);
end;

end.
