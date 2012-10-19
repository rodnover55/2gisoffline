unit UMapDevice;

interface

uses
  UInterfaceWrapper, GrymCore_TLB, Windows, UMapPoint, UDevPoint, UDevRect;
//
type
  TMapDevice = class(TInterfaceWrapper<IMapDevice>)
  public
    function GetDC: HDC;
    function DeviceRect: TDevRect;
    function MapToDevice(Point: TMapPoint): TDevPoint;
    function DeviceToMap(Point: TDevPoint): TMapPoint;
    function Scale: Integer;

    function IsOutside(Point: TDevPoint): Boolean;
  end;

implementation

uses
  ComObj, ActiveX;
{ TMapDevice }

function TMapDevice.DeviceRect: TDevRect;
var
  pDevRect: IDevRect;
begin
  OleCheck(Self.GetInterface.Get_DeviceRect(pDevRect));
  Result := TDevRect.Create(pDevRect);
end;

function TMapDevice.DeviceToMap(Point: TDevPoint): TMapPoint;
var
  Pnt: IMapPoint;
  Pnt2: TDevPoint;
  Pnt3: IDevPoint;
begin
  OleCheck(Self.GetInterface.DeviceToMap(Point, Pnt));
  Result := TMapPoint.Create(Pnt);
end;

function TMapDevice.GetDC: HDC;
var
  DC: OLE_HANDLE;
begin
  OleCheck(Self.GetInterface.Get_SafeDC(DC));

  Result := DC;
end;

function TMapDevice.IsOutside(Point: TDevPoint): Boolean;
var
  DevRect: TDevRect;
begin
  DevRect := Self.DeviceRect;
  Result := (Point.X < DevRect.Left) or (Point.X > DevRect.Right)
    or (Point.X < DevRect.Bottom) or (Point.X > DevRect.Top);
end;

function TMapDevice.MapToDevice(Point: TMapPoint): TDevPoint;
var
  Pnt: IDevPoint;
begin
  OleCheck(Self.GetInterface.MapToDevice(Point, Pnt));
  Result := TDevPoint.Create(Pnt);
end;

function TMapDevice.Scale: Integer;
begin
  OleCheck(Self.GetInterface.Get_Scale(Result));
end;

end.
