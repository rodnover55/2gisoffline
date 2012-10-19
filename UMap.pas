unit UMap;

interface

uses
  UInterfaceWrapper, GrymCore_TLB, ULayers, UMapTools, UMapPoint, UPopupMenu
    , UDevPoint, UMapCoordinateTransformationGeo, UMapRect, UGrymGraphic
      , UMapCoordinateTransformationUTM, UMapInfoControllers, UCallout;

type
  TMap = class(TInterfaceWrapper<IMap>)
    FLayers: TLayers;
    FTools: TMapTools;
    FPopupMenu: TPopupMenu;
    FCoordinateTransformationGEO: TMapCoordinateTransformationGeo;
    FCoordinateTransformationUTM: TMapCoordinateTransformationUTM;
    FMapInfoControllers: TMapInfoControllers;
  public
    destructor Destroy; override;

  // IMap
    function GetLayers: TLayers;
    function GetTools: TMapTools;
    function ContextMenu: TPopupMenu;
    function Handle: THandle;
    function CoordinateTransformationGEO: TMapCoordinateTransformationGeo;
    function CoordinateTransformationUTM: TMapCoordinateTransformationUTM;
    function FullExtend: TMapRect;

    function MapInfoControllers: TMapInfoControllers;
  // IDeviceMap
    function DeviceToMap(Pnt: TDevPoint): TMapPoint;
    function MapToDevice(Pnt: TMapPoint): TDevPoint;
    procedure Invalidate(Full: Boolean = False);
  // IMapGraphics
    procedure AddGraphic(Graphic: IGraphicBase);
    procedure RemoveGraphic(Graphic: IGraphicBase);
    function CreateCallout(Point: TMapPoint; AutoClose: Boolean = True
      ; Vector: TDevPoint = nil; pSize: IDevSize = nil): TCallout;
    function GraphicByTag(Tag: string): IGraphicBase;
  end;

implementation

uses
  SysUtils, ComObj;

{ TMap }

procedure TMap.AddGraphic(Graphic: IGraphicBase);
begin
  OleCheck((Self.GetInterface as IMapGraphics).AddGraphic(Graphic));
end;

function TMap.ContextMenu: TPopupMenu;
var
  pPopupMenu: IPopupMenu;
begin
  if not Assigned(Self.FPopupMenu) then
  begin
    OleCheck(Self.GetInterface.Get_ContextMenu(pPopupMenu));
    Self.FPopupMenu := TPopupMenu.Create(pPopupMenu);
  end;

  Result := Self.FPopupMenu;
end;

function TMap.CoordinateTransformationGEO: TMapCoordinateTransformationGeo;
var
  Transformation: IUnknown;
  TransformationGEO: IMapCoordinateTransformationGeo;
begin
  if not Assigned(Self.FCoordinateTransformationGEO) then
  begin
    OleCheck(Self.GetInterface.Get_CoordinateTransformation(Transformation));
    Transformation.QueryInterface(IID_IMapCoordinateTransformationGeo
      , TransformationGEO);
    Self.FCoordinateTransformationGEO
      := TMapCoordinateTransformationGeo.Create(TransformationGEO);
  end;

  Result := Self.FCoordinateTransformationGEO;
end;

function TMap.CoordinateTransformationUTM: TMapCoordinateTransformationUTM;
var
  Transformation: IUnknown;
  TransformationUTM: IMapCoordinateTransformationUTM;
begin
  if not Assigned(Self.FCoordinateTransformationUTM) then
  begin
    OleCheck(Self.GetInterface.Get_CoordinateTransformation(Transformation));
    Transformation.QueryInterface(IID_IMapCoordinateTransformationUTM
      , TransformationUTM);
    Self.FCoordinateTransformationUTM
      := TMapCoordinateTransformationUTM.Create(TransformationUTM);
  end;

  Result := Self.FCoordinateTransformationUTM;
end;

function TMap.CreateCallout(Point: TMapPoint; AutoClose: Boolean;
  Vector: TDevPoint; pSize: IDevSize): TCallout;
var
  Callout: ICallout;
begin
  OleCheck((Self.GetInterface as IMapGraphics).CreateCallout(Point, AutoClose
    , Vector, pSize, Callout));

  Result := TCallout.Create(Callout);
end;

destructor TMap.Destroy;
begin
  FreeAndNil(Self.FTools);
  FreeAndNil(Self.FLayers);
  FreeAndNil(Self.FPopupMenu);
  FreeAndNil(Self.FCoordinateTransformationGEO);
  FreeAndNil(Self.FCoordinateTransformationUTM);
  inherited;
end;

function TMap.DeviceToMap(Pnt: TDevPoint): TMapPoint;
var
  MapPoint: IMapPoint;
begin
  OleCheck((Self.GetInterface as IMapDevice).DeviceToMap(Pnt, MapPoint));
  Result := TMapPoint.Create(MapPoint);
end;

function TMap.FullExtend: TMapRect;
var
  MapRect: IMapRect;
begin
  OleCheck(Self.GetInterface.Get_FullExtent(MapRect));
  Result := TMapRect.Create(MapRect);
end;

function TMap.GetLayers: TLayers;
var
  pLayers: ILayerCollection;
begin
  if not Assigned(Self.FLayers) then
  begin
    OleCheck(Self.GetInterface.Get_Layers(pLayers));
    Self.FLayers := TLayers.Create(pLayers);
  end;

  Result := Self.FLayers;
end;

function TMap.GetTools: TMapTools;
var
  pTools: IMapTools;
begin
  if not Assigned(Self.FTools) then
  begin
    OleCheck(Self.GetInterface.Get_Tools(pTools));
    Self.FTools := TMapTools.Create(pTools);
  end;

  Result := Self.FTools;
end;

function TMap.GraphicByTag(Tag: string): IGraphicBase;
var
  Res: HRESULT;
begin
  Res := (Self.GetInterface as IMapGraphics).Get_GraphicByTag(Tag, Result);

  if Res = S_FALSE  then
  begin
    Result := nil
  end
  else if Res <> S_OK then
  begin
    OleCheck(Res);
  end;
end;

function TMap.Handle: THandle;
begin
  OleCheck(Self.GetInterface.Get_HWindow(Result));
end;

procedure TMap.Invalidate(Full: Boolean);
begin
  OleCheck(Self.GetInterface.Invalidate(Full));
end;

function TMap.MapInfoControllers: TMapInfoControllers;
var
  pMapInfoControllers: IMapInfoControllers;
begin
  if not Assigned(Self.FMapInfoControllers) then
  begin
    OleCheck(Self.GetInterface.Get_MapInfoControllers(pMapInfoControllers));
    Self.FMapInfoControllers := TMapInfoControllers.Create(pMapInfoControllers);
  end;

  Result := Self.FMapInfoControllers;
end;

function TMap.MapToDevice(Pnt: TMapPoint): TDevPoint;
var
  DevPoint: IDevPoint;
begin
  OleCheck((Self.GetInterface as IMapDevice).MapToDevice(Pnt, DevPoint));
  Result := TDevPoint.Create(DevPoint);
end;

procedure TMap.RemoveGraphic(Graphic: IGraphicBase);
begin
  OleCheck((Self.GetInterface as IMapGraphics).RemoveGraphic(Graphic));
end;

end.
