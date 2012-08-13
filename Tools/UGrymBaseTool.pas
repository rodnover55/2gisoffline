unit UGrymBaseTool;

interface

uses
  GrymCore_TLB, ActiveX, UBaseController;

type
  TGrymBaseTool = class(TInterfacedObject, IToolBase, ITool)
    FID: string;
    FActive: Boolean;
    FActiveEvent: TBaseController;
  protected
  // virtual events
    procedure ClickEvent(X: Integer; Y: Integer); virtual;
    function MouseMoveEvent(nShift, nX, nY: Integer): Boolean; virtual;
    function DoubleClickEvent(nButton: MouseButton
      ; nShift, nX, nY: Integer): Boolean; virtual;
    function MouseDownEvent(nButton: MouseButton
      ; nShift, nX, nY: Integer): Boolean; virtual;
    function MouseUpEvent(nButton: MouseButton
      ; nShift, nX, nY: Integer): Boolean; virtual;
    function ActivateEvent(IsActivate: Boolean): Boolean; virtual;
  public
    constructor Create(ID: string);
    destructor Destroy; override;

    function SetActiveEvent(Controller: TBaseController): TGrymBaseTool;
    function GetActive: Boolean;

  // IToolBase
    function Get_Tag(out pVal: WideString): HResult; stdcall;
  // ITool
    function Get_Cursor(out pCursor: OLE_HANDLE): HResult; stdcall;
    function Activate(bActivate: WordBool; out pOk: WordBool): HResult; stdcall;
    function OnKeyDown(nChar: Integer; nShift: Integer
      ; out pHandled: WordBool): HResult; stdcall;
    function OnKeyUp(nChar: Integer; nShift: Integer
      ; out pHandled: WordBool): HResult; stdcall;
    function OnMouseDown(nButton: MouseButton; nShift: Integer
      ; nX: Integer; nY: Integer; out pHandled: WordBool): HResult; stdcall;
    function OnMouseDblClk(nButton: MouseButton; nShift: Integer
      ; nX: Integer; nY: Integer; out pHandled: WordBool): HResult; stdcall;
    function OnMouseUp(nButton: MouseButton; nShift: Integer; nX: Integer
      ; nY: Integer; out pHandled: WordBool): HResult; stdcall;
    function OnMouseMove(nShift: Integer; nX: Integer; nY: Integer
      ; out pHandled: WordBool): HResult; stdcall;
    function OnClick(nX: Integer; nY: Integer): HResult; stdcall;
    function OnDraw(const pDevice: IMapDevice): HResult; stdcall;
  end;

implementation

uses
  SysUtils;

{ TGrymBaseTool }

function TGrymBaseTool.Activate(bActivate: WordBool;
  out pOk: WordBool): HResult;
begin
  try
    pOk := Self.ActivateEvent(bActivate);
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TGrymBaseTool.ActivateEvent(IsActivate: Boolean): Boolean;
begin
  Self.FActive := IsActivate;

  if Assigned(Self.FActiveEvent) then
  begin
    Self.FActiveEvent.Execute;
  end;

  Result := True;
end;

procedure TGrymBaseTool.ClickEvent(X, Y: Integer);
begin
end;

constructor TGrymBaseTool.Create(ID: string);
begin
  inherited Create;
  Self.FActive := False;
  Self.FID := ID;
  Self.FActiveEvent := nil;
end;

destructor TGrymBaseTool.Destroy;
begin
  FreeAndNil(Self.FActiveEvent);

  inherited;
end;

function TGrymBaseTool.DoubleClickEvent(nButton: MouseButton; nShift, nX,
  nY: Integer): Boolean;
begin
  Result := False;
end;

function TGrymBaseTool.GetActive: Boolean;
begin
  Result := Self.FActive;
end;

function TGrymBaseTool.Get_Cursor(out pCursor: OLE_HANDLE): HResult;
begin
  try
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TGrymBaseTool.Get_Tag(out pVal: WideString): HResult;
begin
  try
    pVal := Self.FID;
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TGrymBaseTool.MouseDownEvent(nButton: MouseButton; nShift, nX,
  nY: Integer): Boolean;
begin
  Result := False;
end;

function TGrymBaseTool.MouseMoveEvent(nShift, nX, nY: Integer): Boolean;
begin
  Result := False;
end;

function TGrymBaseTool.MouseUpEvent(nButton: MouseButton; nShift, nX,
  nY: Integer): Boolean;
begin
  Result := False;
end;

function TGrymBaseTool.OnClick(nX, nY: Integer): HResult;
begin
  try
    Self.ClickEvent(nX, nY);
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TGrymBaseTool.OnDraw(const pDevice: IMapDevice): HResult;
begin
  try
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TGrymBaseTool.OnKeyDown(nChar, nShift: Integer;
  out pHandled: WordBool): HResult;
begin
  try
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TGrymBaseTool.OnKeyUp(nChar, nShift: Integer;
  out pHandled: WordBool): HResult;
begin
  try
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TGrymBaseTool.OnMouseDblClk(nButton: MouseButton; nShift, nX,
  nY: Integer; out pHandled: WordBool): HResult;
begin
  try
    pHandled := Self.DoubleClickEvent(nButton, nShift, nX, nY);
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TGrymBaseTool.OnMouseDown(nButton: MouseButton; nShift, nX,
  nY: Integer; out pHandled: WordBool): HResult;
begin
  try
    pHandled := Self.MouseDownEvent(nButton, nShift, nX, nY);
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TGrymBaseTool.OnMouseMove(nShift, nX, nY: Integer;
  out pHandled: WordBool): HResult;
begin
  try
    pHandled := Self.MouseMoveEvent(nShift, nX, nY);
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TGrymBaseTool.OnMouseUp(nButton: MouseButton; nShift, nX, nY: Integer;
  out pHandled: WordBool): HResult;
begin
  try
    pHandled := Self.MouseUpEvent(nButton, nShift, nX, nY);
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TGrymBaseTool.SetActiveEvent(
  Controller: TBaseController): TGrymBaseTool;
begin
  Self.FActiveEvent := Controller;
  Result := Self;
end;

end.
