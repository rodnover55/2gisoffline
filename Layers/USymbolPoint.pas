unit USymbolPoint;

interface

uses
  USymbol, GrymCore_TLB;

type
  TSymbolPoint = class(TSymbol)
    FRaster: IRaster;
    FpMarkerSymbol: IRasterMarkerSymbol;
  public
    constructor Create(StartX: Double; StartY: Double; Raster: IRaster = nil);
    function GetDimension: ComponentDimension; override;
    function GetMarkerSymbol: IRasterMarkerSymbol; override;
  end;

implementation

uses
  ComObj, UGrymPlugin;

{$IfNDef GRYM_RESOURCES}
{$Define GRYM_RESOURCES}
{$R Resources.RES}
{$EndIf}

{ TSymbolPoint }

constructor TSymbolPoint.Create(StartX, StartY: Double; Raster: IRaster = nil);
begin
  inherited Create(StartX, StartY);
  if Assigned(Raster) then
  begin
    Self.FRaster := Raster;
  end
  else
  begin
    Self.FRaster := nil;
    Self.FRaster := TGrymPlugin.GetInstance.BaseViewThread
      .GetFactory.GetRaster('TEXT_RASTER');
  end;

  Self.FpMarkerSymbol := nil;
end;

function TSymbolPoint.GetDimension: ComponentDimension;
begin
  Result := ComponentDimensionPoint;
end;

function TSymbolPoint.GetMarkerSymbol: IRasterMarkerSymbol;
begin
  if Assigned(Self.FRaster) and not Assigned(Self.FpMarkerSymbol) then
  begin
    Self.FpMarkerSymbol := TGrymPlugin.GetInstance.BaseViewThread.GetFactory
      .CreateRasterMarkerSymbol(Self.FRaster, 1.0);
  end;

  Result := Self.FpMarkerSymbol;
end;

end.

