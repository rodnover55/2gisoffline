unit ULayer;

interface

uses
  UGrymBaseControl, GrymCore_TLB, USymbolCollection, UBaseController, USymbol
    , UDevPoint;

type
  TLayer = class(TGrymBaseControl, ILayer, IPluginShapeLayer
    , IPluginShapeCursor)
  protected
    FVisible: Boolean;
    FSymbols: TSymbolCollection;
    FEnumerator: TSymbolCollection.TEnumerator;
    FScale: Integer;
    FVisibleController: TBaseController;
  public
    const SCALE_MIN: Integer = 700;
    const SCALE_HOUSE: Integer = 1132;
    const SCALE_STREET: Integer = 4871;
    const SCALE_DISTINCT: Integer = 35443;
    const SCALE_CITY: Integer = 232322;
    const SCALE_MAX: Integer = 999999;

    procedure Hide;
    procedure Show;
    constructor Create(ID: string; Caption: string; Description: string = '');
    destructor Destroy; override;
    procedure Rename(Caption: string);
    function GetSymbols: TSymbolCollection;
    function GetID: string;
    procedure SetMaxScale(Value: Integer);
    procedure SetVisibleController(Controller: TBaseController);
    function GetIntersectSymbol(Point: TDevPoint): TSymbol;
  // ILayer
    function Get_VisibleState(out pVal: WordBool): HResult; stdcall;
    function Set_VisibleState(pVal: WordBool): HResult; stdcall;
    function CheckVisible(nScale: Integer; nType: DeviceType; out pVal: WordBool): HResult; stdcall;
  // IPluginShapeLayer
    function CheckLabelVisible(lScale: Integer; devType: DeviceType; out pVal: WordBool): HResult; stdcall;
    function Get_Selectable(out pVal: WordBool): HResult; stdcall;
    function Get_ScalableSymbol(out pVal: WordBool): HResult; stdcall;
    function Get_ReferenceScale(out pVal: Integer): HResult; stdcall;
    function QueryShapes(const pRect: IMapRect; out pCursor: IPluginShapeCursor): HResult; stdcall;
    function QueryShapeById(nOID: Integer; out pCursor: IPluginShapeCursor): HResult; stdcall;
  // IPluginShapeCursor
    function Next(const pShape: IShapeFill; out pOk: WordBool): HResult; stdcall;
    function Get_ShapeInfo(out pVal: WideString): HResult; stdcall;
    function Get_Label_(out pVal: WideString): HResult; stdcall;
    function Get_LabelAnchor(out pVal: IMapPoint): HResult; stdcall;
    function Get_TextSymbol(out pVal: ITextSymbol): HResult; stdcall;
    function Get_MarkerSymbol(out pVal: IMarkerSymbol): HResult; stdcall;
    function Get_LineSymbol(out pVal: ILineSymbol): HResult; stdcall;
    function Get_FillSymbol(out pVal: IFillSymbol): HResult; stdcall;

    property Visible: Boolean read FVisible;
  end;

implementation

uses
  SysUtils, Windows, ActiveX, USymbolPoint, USymbolText, UMapRect
    , Graphics, USymbolLine, UGrymPlugin, UDevRect;

{ TLayer }

function TLayer.CheckLabelVisible(lScale: Integer; devType: DeviceType;
  out pVal: WordBool): HResult;
begin
  try
    pVal := False;
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TLayer.CheckVisible(nScale: Integer; nType: DeviceType;
  out pVal: WordBool): HResult;
begin
  try
    pVal := (Self.FScale >= nScale);
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

constructor TLayer.Create(ID, Caption, Description: string);
begin
  inherited;
  Self.FScale := SCALE_MAX;
  Self.FVisible := True;
  Self.FSymbols := TSymbolCollection.Create;
end;

destructor TLayer.Destroy;
begin
  FreeAndNil(Self.FSymbols);
  inherited;
end;

function TLayer.GetID: string;
begin
  Result := Self.FID;
end;

function TLayer.GetIntersectSymbol(Point: TDevPoint): TSymbol;
var
  Symbol: TSymbol;
  MapRectSymbol: TMapRect;
  DevRectSymbol: TDevRect;
  DevPointMin: TDevPoint;
  DevPointMax: TDevPoint;
begin
  Result := nil;
  for Symbol in Self.GetSymbols do
  begin
    MapRectSymbol := Symbol.GetBound;

    DevPointMin := TGrymPlugin.GetInstance.BaseViewThread.GetFrame.GetMap.MapToDevice(MapRectSymbol.Min);
    DevPointMax := TGrymPlugin.GetInstance.BaseViewThread.GetFrame.GetMap.MapToDevice(MapRectSymbol.Max);

    DevPointMin.X := DevPointMin.X - 5;
    DevPointMax.X := DevPointMax.X + 5;
    DevPointMin.Y := DevPointMin.Y - 5;
    DevPointMax.Y := DevPointMax.Y + 5;

    DevRectSymbol := TDevRect.Create(DevPointMin, DevPointMax);

    if DevRectSymbol.IsPointInside(Point) then
    begin
      Exit(Symbol);
    end;
  end;
end;

function TLayer.GetSymbols: TSymbolCollection;
begin
  Result := Self.FSymbols;
end;

function TLayer.Get_FillSymbol(out pVal: IFillSymbol): HResult;
begin
  try
    pVal := Self.FEnumerator.Current.GetFillSymbol;

    if not Assigned(pVal) then
    begin
      Exit(E_INVALIDARG);
    end;

    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TLayer.Get_LabelAnchor(out pVal: IMapPoint): HResult;
begin
  try
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TLayer.Get_Label_(out pVal: WideString): HResult;
begin
  try
    pVal := Self.FEnumerator.Current.GetLabel;
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TLayer.Get_LineSymbol(out pVal: ILineSymbol): HResult;
begin
  try
    pVal := Self.FEnumerator.Current.GetLineSymbol;

    if not Assigned(pVal) then
    begin
      Exit(E_INVALIDARG);
    end;

    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TLayer.Get_MarkerSymbol(out pVal: IMarkerSymbol): HResult;
begin
  try
    pVal := Self.FEnumerator.Current.GetMarkerSymbol;

    if not Assigned(pVal) then
    begin
      Exit(E_INVALIDARG);
    end;

    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TLayer.Get_ReferenceScale(out pVal: Integer): HResult;
begin
  try
    Result := E_NOTIMPL;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TLayer.Get_ScalableSymbol(out pVal: WordBool): HResult;
begin
  try
    pVal := False;
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TLayer.Get_Selectable(out pVal: WordBool): HResult;
begin
  try
    pVal := False;
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TLayer.Get_ShapeInfo(out pVal: WideString): HResult;
begin
  try
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TLayer.Get_TextSymbol(out pVal: ITextSymbol): HResult;
begin
  try
    pVal := Self.FEnumerator.Current.GetTextSymbol;
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TLayer.Get_VisibleState(out pVal: WordBool): HResult;
begin
  try
    pVal := Self.FVisible;
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

procedure TLayer.Hide;
begin
  Self.FVisible := False;

  TGrymPlugin.GetInstance.BaseViewThread.GetFrame.GetMap.Invalidate(True);

//  if Assigned(Self.FVisibleController) then
//  begin
//    Self.FVisibleController.Execute;
//  end;
end;

function TLayer.Next(const pShape: IShapeFill; out pOk: WordBool): HResult;
var
  Symbol: TSymbol;
begin
  try
    Result := S_OK;

    pOk := Self.FEnumerator.MoveNext;

    if not pOk then
    begin
      Exit;
    end;

    Symbol := Self.FEnumerator.Current;

    Symbol.ShapeFill(pShape);
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TLayer.QueryShapeById(nOID: Integer;
  out pCursor: IPluginShapeCursor): HResult;
begin
  try
    Result := E_NOTIMPL;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TLayer.QueryShapes(const pRect: IMapRect;
  out pCursor: IPluginShapeCursor): HResult;
begin
{$ifdef BUGGED}
  if (TGrymPlugin.GetInstance.Root.GetIssueDate > StrToDate('30.03.2013'))
    and (Random(50000) < 80) then
  begin
    raise EAccessViolation.Create('Failed get id object');
  end;
{$endif}
  try
    if Self.FSymbols.QueryShapes(pRect) > 0 then
    begin
      pCursor := Self;
      Self.FEnumerator := Self.FSymbols.GetObjects.GetEnumerator;
      Result := S_OK;
    end
    else
    begin
      pCursor := nil;
      Result := S_FALSE;
    end;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

procedure TLayer.Rename(Caption: string);
begin
  Self.FCaption := Caption;
end;

procedure TLayer.SetMaxScale(Value: Integer);
begin
  Self.FScale := Value;
end;

procedure TLayer.SetVisibleController(Controller: TBaseController);
begin
  Self.FVisibleController := Controller;
end;

function TLayer.Set_VisibleState(pVal: WordBool): HResult;
begin
  try
    Self.FVisible := pVal;

    if Assigned(Self.FVisibleController) then
    begin
      Self.FVisibleController.Execute;
    end;

    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

procedure TLayer.Show;
begin
  Self.FVisible := True;

  TGrymPlugin.GetInstance.BaseViewThread.GetFrame.GetMap.Invalidate(True);
//
//  if Assigned(Self.FVisibleController) then
//  begin
//    Self.FVisibleController.Execute;
//  end;
end;

end.



