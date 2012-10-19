unit UMapRect;

interface

uses
  GrymCore_TLB, UGrymBaseTypes, UMapPoint;

type
  TMapRect = class(TInterfacedObject, IMapRect)
  public
    type
      TCoordinate = TGrymMapCoordinate;
  private
    function GetHeight: TCoordinate;
    function GetWidth: TCoordinate;
    function GetMax: TMapPoint;
    function GetMin: TMapPoint;
  protected
    FLeft: TCoordinate;
    FRight: TCoordinate;
    FTop: TCoordinate;
    FBottom: TCoordinate;
  public
    constructor Create(MapRect: IMapRect); overload;
    constructor Create(Left, Bottom, Right, Top: TCoordinate); overload;
    constructor Create(Min, Max: TMapPoint); overload;

    function Get_Min(out pVal: IMapPoint): HResult; stdcall;
    function Get_Max(out pVal: IMapPoint): HResult; stdcall;
    function Get_MinX(out pVal: Double): HResult; stdcall;
    function Set_MinX(pVal: Double): HResult; stdcall;
    function Get_MinY(out pVal: Double): HResult; stdcall;
    function Set_MinY(pVal: Double): HResult; stdcall;
    function Get_MaxX(out pVal: Double): HResult; stdcall;
    function Set_MaxX(pVal: Double): HResult; stdcall;
    function Get_MaxY(out pVal: Double): HResult; stdcall;
    function Set_MaxY(pVal: Double): HResult; stdcall;
    function Get_Width(out pVal: Double): HResult; stdcall;
    function Get_Height(out pVal: Double): HResult; stdcall;
    function Set_(nMinX: Double; nMinY: Double; nMaxX: Double; nMaxY: Double): HResult; stdcall;

    property Height: TCoordinate read GetHeight;
    property Width: TCoordinate read GetWidth;

    property Min: TMapPoint read GetMin;
    property Max: TMapPoint read GetMax;

    property Left: TCoordinate read FLeft;
    property Right: TCoordinate read FRight;
    property Top: TCoordinate read FTop;
    property Bottom: TCoordinate read FBottom;
  end;

implementation

uses
  SysUtils, ComObj;

{ TMapRect }

constructor TMapRect.Create(MapRect: IMapRect);
begin
  inherited Create;

  OleCheck(MapRect.Get_MinX(Self.FLeft));
  OleCheck(MapRect.Get_MinY(Self.FBottom));
  OleCheck(MapRect.Get_MaxX(Self.FRight));
  OleCheck(MapRect.Get_MaxY(Self.FTop));
end;

constructor TMapRect.Create(Left, Bottom, Right, Top: TCoordinate);
begin
  inherited Create;

  Self.FLeft := Left;
  Self.FRight := Right;
  Self.FTop := Top;
  Self.FBottom := Bottom;
end;

constructor TMapRect.Create(Min, Max: TMapPoint);
begin
  inherited Create;

  Self.FLeft := Min.X;
  Self.FRight := Max.X;
  Self.FTop := Max.Y;
  Self.FBottom := Min.Y;
end;

function TMapRect.GetHeight: TCoordinate;
begin
  Result := Abs(Self.FTop - Self.FBottom);
end;

function TMapRect.GetMax: TMapPoint;
begin
  Result := TMapPoint.Create(Self.Right, Self.Top);
end;

function TMapRect.GetMin: TMapPoint;
begin
  Result := TMapPoint.Create(Self.Left, Self.Bottom);
end;

function TMapRect.GetWidth: TCoordinate;
begin
  Result := Abs(Self.FTop - Self.FBottom);
end;

function TMapRect.Get_Height(out pVal: Double): HResult;
begin
  try
    Result := S_OK;
    pVal := Self.Height;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;


function TMapRect.Get_Max(out pVal: IMapPoint): HResult;
begin
  try
    Result := S_OK;
    pVal := Self.Max;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TMapRect.Get_MaxX(out pVal: Double): HResult;
begin
  try
    Result := S_OK;
    pVal := Self.FRight;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TMapRect.Get_MaxY(out pVal: Double): HResult;
begin
  try
    Result := S_OK;
    pVal := Self.FTop;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TMapRect.Get_Min(out pVal: IMapPoint): HResult;
begin
  try
    Result := S_OK;
    pVal := Self.Min;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TMapRect.Get_MinX(out pVal: Double): HResult;
begin
  try
    Result := S_OK;
    pVal := Self.FLeft;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TMapRect.Get_MinY(out pVal: Double): HResult;
begin
  try
    Result := S_OK;
    pVal := Self.FBottom;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TMapRect.Get_Width(out pVal: Double): HResult;
begin
  try
    Result := S_OK;
    pVal := Self.Width;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TMapRect.Set_(nMinX, nMinY, nMaxX, nMaxY: Double): HResult;
begin
  try
    Result := S_OK;
    Self.FLeft := nMinX;
    Self.FBottom := nMinY;
    Self.FRight := nMaxX;
    Self.FTop := nMaxY;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TMapRect.Set_MaxX(pVal: Double): HResult;
begin
  try
    Result := S_OK;
    Self.FRight := pVal;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TMapRect.Set_MaxY(pVal: Double): HResult;
begin
  try
    Result := S_OK;
    Self.FTop := pVal;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TMapRect.Set_MinX(pVal: Double): HResult;
begin
  try
    Result := S_OK;
    Self.FLeft := pVal;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TMapRect.Set_MinY(pVal: Double): HResult;
begin
  try
    Result := S_OK;
    Self.FBottom := pVal;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

end.
