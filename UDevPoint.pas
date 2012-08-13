unit UDevPoint;

interface

uses
  UInterfaceWrapper, GrymCore_TLB;

type
  TDevPoint = class(TInterfaceWrapper<IDevPoint>)
  public
    function GetX: Integer;
    function GetY: Integer;
  end;

implementation

uses
  ComObj;
{ TDevPoint }

function TDevPoint.GetX: Integer;
begin
  OleCheck(Self.GetInterface.Get_X(Result));
end;

function TDevPoint.GetY: Integer;
begin
  OleCheck(Self.GetInterface.Get_Y(Result));
end;

end.
