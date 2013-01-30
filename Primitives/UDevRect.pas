unit UDevRect;

interface
uses
  GrymCore_TLB, UGrymBaseTypes, UDevPoint;

type
  TDevRect = class(TInterfacedObject, IDevRect)
  public
    type
      TCoordinate = TGrymDevCoordinate;
  private
    function GetHeight: TCoordinate;
    function GetWidth: TCoordinate;
    function GetMax: TDevPoint;
    function GetMin: TDevPoint;
  protected
    FLeft: TCoordinate;
    FRight: TCoordinate;
    FTop: TCoordinate;
    FBottom: TCoordinate;
  public
    constructor Create(DevRect: IDevRect); overload;
    constructor Create(Left, Bottom, Right, Top: TCoordinate); overload;
    constructor Create(Min, Max: TDevPoint); overload;
    function IsPointInside(Point: TDevPoint): Boolean;

    function Get_Min(out pVal: IDevPoint): HResult; stdcall;
    function Get_Max(out pVal: IDevPoint): HResult; stdcall;
    function Get_MinX(out pVal: Integer): HResult; stdcall;
    function Set_MinX(pVal: Integer): HResult; stdcall;
    function Get_MinY(out pVal: Integer): HResult; stdcall;
    function Set_MinY(pVal: Integer): HResult; stdcall;
    function Get_MaxX(out pVal: Integer): HResult; stdcall;
    function Set_MaxX(pVal: Integer): HResult; stdcall;
    function Get_MaxY(out pVal: Integer): HResult; stdcall;
    function Set_MaxY(pVal: Integer): HResult; stdcall;
    function Get_Width(out pVal: Integer): HResult; stdcall;
    function Get_Height(out pVal: Integer): HResult; stdcall;
    function Set_(nMinX: Integer; nMinY: Integer; nMaxX: Integer; nMaxY: Integer): HResult; stdcall;

    property Height: TCoordinate read GetHeight;
    property Width: TCoordinate read GetWidth;

    property Min: TDevPoint read GetMin;
    property Max: TDevPoint read GetMax;

    property Left: TCoordinate read FLeft;
    property Right: TCoordinate read FRight;
    property Top: TCoordinate read FTop;
    property Bottom: TCoordinate read FBottom;
  end;

implementation

uses
  ComObj, SysUtils;
{ TMapRect }

constructor TDevRect.Create(DevRect: IDevRect);
begin
  inherited Create;

  OleCheck(DevRect.Get_MinX(Self.FLeft));
  OleCheck(DevRect.Get_MinY(Self.FBottom));
  OleCheck(DevRect.Get_MaxX(Self.FRight));
  OleCheck(DevRect.Get_MaxY(Self.FTop));
end;

constructor TDevRect.Create(Left, Bottom, Right, Top: TCoordinate);
begin
  inherited Create;

  Self.FLeft := Left;
  Self.FRight := Right;
  Self.FTop := Top;
  Self.FBottom := Bottom;
end;

constructor TDevRect.Create(Min, Max: TDevPoint);
begin
  inherited Create;

  Self.FLeft := Min.X;
  Self.FRight := Max.X;
  Self.FTop := Max.Y;
  Self.FBottom := Min.Y;
end;

function TDevRect.GetHeight: TCoordinate;
begin
  Result := Abs(Self.FTop - Self.FBottom);
end;

function TDevRect.GetMax: TDevPoint;
begin
  Result := TDevPoint.Create(Self.Right, Self.Top);
end;

function TDevRect.GetMin: TDevPoint;
begin
  Result := TDevPoint.Create(Self.Left, Self.Bottom);
end;

function TDevRect.GetWidth: TCoordinate;
begin
  Result := Abs(Self.FTop - Self.FBottom);
end;

function TDevRect.Get_Height(out pVal: Integer): HResult;
begin
  try
    Result := S_OK;
    pVal := Self.Height;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TDevRect.Get_Max(out pVal: IDevPoint): HResult;
begin
  try
    Result := S_OK;
    pVal := Self.Max;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TDevRect.Get_MaxX(out pVal: Integer): HResult;
begin
  try
    Result := S_OK;
    pVal := Self.FRight;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TDevRect.Get_MaxY(out pVal: Integer): HResult;
begin
  try
    Result := S_OK;
    pVal := Self.FTop;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TDevRect.Get_Min(out pVal: IDevPoint): HResult;
begin
  try
    Result := S_OK;
    pVal := Self.Min;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TDevRect.Get_MinX(out pVal: Integer): HResult;
begin
  try
    Result := S_OK;
    pVal := Self.FLeft;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TDevRect.Get_MinY(out pVal: Integer): HResult;
begin
  try
    Result := S_OK;
    pVal := Self.FBottom;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TDevRect.Get_Width(out pVal: Integer): HResult;
begin
  try
    Result := S_OK;
    pVal := Self.Width;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TDevRect.IsPointInside(Point: TDevPoint): Boolean;
begin
  Result := (Point.X >= Self.Left) and (Point.X <= Self.Right)
    and (Point.Y >= Self.Bottom) and (Point.Y <= Self.Top);
end;

function TDevRect.Set_(nMinX, nMinY, nMaxX, nMaxY: Integer): HResult;
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

function TDevRect.Set_MaxX(pVal: Integer): HResult;
begin
  try
    Result := S_OK;
    Self.FRight := pVal;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TDevRect.Set_MaxY(pVal: Integer): HResult;
begin
  try
    Result := S_OK;
    Self.FTop := pVal;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TDevRect.Set_MinX(pVal: Integer): HResult;
begin
  try
    Result := S_OK;
    Self.FLeft := pVal;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TDevRect.Set_MinY(pVal: Integer): HResult;
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
