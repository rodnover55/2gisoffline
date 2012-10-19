unit UMapPoint;

interface

uses
  GrymCore_TLB, UGrymBaseTypes;

type
  TMapPoint = class(TInterfacedObject, IMapPoint)
  public
    type
      TCoordinate = TGrymMapCoordinate;
  private
    FX: TCoordinate;
    FY: TCoordinate;
  public
    constructor Create(MapPoint: IMapPoint); overload;
    constructor Create(X: TCoordinate; Y: TCoordinate); overload;

    function Get_X(out pVal: Double): HResult; stdcall;
    function Set_X(pVal: Double): HResult; stdcall;
    function Get_Y(out pVal: Double): HResult; stdcall;
    function Set_Y(pVal: Double): HResult; stdcall;
    function Set_(nX: Double; nY: Double): HResult; stdcall;

    function GetX: TCoordinate;
    function GetY: TCoordinate;

    property X: TCoordinate read FX write FX;
    property Y: TCoordinate read FY write FY;

    function GetInterface: IMapPoint;
  end;

implementation

uses
  ComObj, SysUtils, UGrymPlugin;

{ TMapPoint }

constructor TMapPoint.Create(MapPoint: IMapPoint);
begin
  inherited Create;

  OleCheck(MapPoint.Get_X(Self.FX));
  OleCheck(MapPoint.Get_Y(Self.FY));
end;

constructor TMapPoint.Create(X, Y: TCoordinate);
begin
  inherited Create;

  Self.FX := X;
  Self.FY := Y;
end;

function TMapPoint.GetInterface: IMapPoint;
begin
  OleCheck(TGrymPlugin.GetInstance.BaseViewThread.GetFactory.GetInterface.CreateMapPoint(Self.FX, Self.FY, Result));
end;

function TMapPoint.GetX: Double;
begin
  Result := Self.FX;
end;

function TMapPoint.GetY: Double;
begin
  Result := Self.FY;
end;

function TMapPoint.Get_X(out pVal: Double): HResult;
begin
  try
    Result := S_OK;
    pVal := Self.FX;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TMapPoint.Get_Y(out pVal: Double): HResult;
begin
  try
    Result := S_OK;
    pVal := Self.FY;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TMapPoint.Set_(nX, nY: Double): HResult;
begin
  try
    Result := S_OK;
    Self.FX := nX;
    Self.FY := nY;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TMapPoint.Set_X(pVal: Double): HResult;
begin
  try
    Result := S_OK;
    Self.FX := pVal;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TMapPoint.Set_Y(pVal: Double): HResult;
begin
  try
    Result := S_OK;
    Self.FY := pVal;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

end.
