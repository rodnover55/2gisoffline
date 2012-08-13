unit UMapPoint;

interface

uses
  UInterfaceWrapper, GrymCore_TLB;

type
  TMapPoint = class(TInterfaceWrapper<IMapPoint>)
  public
    function GetX: Double;
    function GetY: Double;
  end;

implementation

uses
  ComObj;

{ TMapPoint }

function TMapPoint.GetX: Double;
begin
  OleCheck(Self.GetInterface.Get_X(Result));
end;

function TMapPoint.GetY: Double;
begin
  OleCheck(Self.GetInterface.Get_Y(Result));
end;

end.
