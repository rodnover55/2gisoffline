unit UDevPoint;

interface

uses
  GrymCore_TLB, UGrymBaseTypes;

type
  TDevPoint = class(TInterfacedObject, IDevPoint)
  public
    type
      TCoordinate = TGrymDevCoordinate;
  private
    FX: TCoordinate;
    FY: TCoordinate;
  public
    constructor Create(DevPoint: IDevPoint); overload;
    constructor Create(X: TCoordinate; Y: TCoordinate); overload;

    function Get_X(out pVal: Integer): HResult; stdcall;
    function Set_X(pVal: Integer): HResult; stdcall;
    function Get_Y(out pVal: Integer): HResult; stdcall;
    function Set_Y(pVal: Integer): HResult; stdcall;
    function Set_(nX: Integer; nY: Integer): HResult; stdcall;

    function GetX: TCoordinate;
    function GetY: TCoordinate;

    property X: TCoordinate read FX write FX;
    property Y: TCoordinate read FY write FY;
  end;

implementation

uses
  ComObj, SysUtils;
{ TDevPoint }

constructor TDevPoint.Create(DevPoint: IDevPoint);
begin
  inherited Create;
  Self.FX := -1;
  Self.FY := -1;
  OleCheck(DevPoint.Get_X(Self.FX));
  OleCheck(DevPoint.Get_Y(Self.FY));
end;

constructor TDevPoint.Create(X, Y: TCoordinate);
begin
  inherited Create;

  Self.FX := X;
  Self.FY := Y;
end;

function TDevPoint.GetX: Integer;
begin
  Result := Self.FX;
end;

function TDevPoint.GetY: Integer;
begin
  Result := Self.FY;
end;

function TDevPoint.Get_X(out pVal: Integer): HResult;
begin
  try
    Result := S_OK;
    pVal := Self.FX;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TDevPoint.Get_Y(out pVal: Integer): HResult;
begin
  try
    Result := S_OK;
    pVal := Self.FY;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TDevPoint.Set_(nX, nY: Integer): HResult;
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

function TDevPoint.Set_X(pVal: Integer): HResult;
begin
  try
    Result := S_OK;
    Self.FX := pVal;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TDevPoint.Set_Y(pVal: Integer): HResult;
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
