unit UGrymObjectFactory;

interface

uses
  UInterfaceWrapper, GrymCore_TLB, UGrymObjectFactory2, USymbolPoint, Graphics
    , UMapPoint, UDevPoint;

type
  TGrymObjectFactory = class(TInterfaceWrapper<IGrymObjectFactory>)
    FFactory2: TGrymObjectFactory2;
  public
    destructor Destroy; override;
    function GetFactory2: TGrymObjectFactory2;
//    function CreateSimpleFillSymbol
    function CreateRasterMarkerSymbol(Raster: IRaster
      ; Scale: Double): IRasterMarkerSymbol;
    function CreateTextSymbol(Font: TFont): ITextSymbol;
    function CreateSimpleLineSymbol(Style: SimpleLineStyle; Width: Double
      ; Color: TColor): ISimpleLineSymbol;
    function CreateRasterFromFile(FileName: string): IRaster;
    function CreateDevPoint(X: Integer; Y: Integer): TDevPoint;
    function CreateMapPoint(X: Double; Y: Double): TMapPoint;
  end;

implementation

uses
  SysUtils, ComObj, ActiveX, Windows;

{ TGrymObjectFactory }

function TGrymObjectFactory.CreateDevPoint(X, Y: Integer): TDevPoint;
var
  Point: IDevPoint;
begin
  OleCheck(Self.GetInterface.CreateDevPoint(X, Y, Point));
  Result := TDevPoint.Create(Point);
end;

function TGrymObjectFactory.CreateMapPoint(X, Y: Double): TMapPoint;
var
  Point: IMapPoint;
begin
  OleCheck(Self.GetInterface.CreateMapPoint(X, Y, Point));
  Result := TMapPoint.Create(Point);
end;

function TGrymObjectFactory.CreateRasterFromFile(FileName: string): IRaster;
begin
  OleCheck(Self.GetInterface.CreateRasterFromFile(FileName, Result));
end;

function TGrymObjectFactory.CreateRasterMarkerSymbol(Raster: IRaster;
  Scale: Double): IRasterMarkerSymbol;
begin
  OleCheck(Self.GetInterface.CreateRasterMarkerSymbol(Raster, Scale, Result));
end;

function TGrymObjectFactory.CreateSimpleLineSymbol(Style: SimpleLineStyle;
  Width: Double; Color: TColor): ISimpleLineSymbol;
begin
  OleCheck(Self.GetInterface.CreateSimpleLineSymbol(Style, Width, Color
    , Result));
end;

function TGrymObjectFactory.CreateTextSymbol(Font: TFont): ITextSymbol;
var
  pFont: IFont;
  Color: Cardinal;
  fd: tagFONTDESC;
begin
  ZeroMemory(@fd, sizeof(fd));
  fd.cbSizeofstruct := sizeof(fd);
  fd.lpstrName := PWideChar(Font.Name);
  PInt64(@fd.cySize)^ := Font.Size * 10000;
  if fsBold in Font.Style then
  begin
    fd.sWeight := FW_BOLD;
  end
  else
  begin
    fd.sWeight := FW_NORMAL;
  end;
  fd.sCharset := Font.Charset;
  fd.fItalic := fsItalic in Font.Style;
  fd.fUnderline := fsUnderline in Font.Style;
  fd.fStrikethrough := fsStrikeOut in Font.Style;

  OleCreateFontIndirect(fd, IFont, pFont);
  Color := Font.Color;
  OleCheck(Self.GetInterface.CreateTextSymbol(pFont, Color, Result));
end;

destructor TGrymObjectFactory.Destroy;
begin
  FreeAndNil(Self.FFactory2);
  inherited;
end;

function TGrymObjectFactory.GetFactory2: TGrymObjectFactory2;
begin
  if not Assigned(Self.FFactory2) then
  begin
    Self.FFactory2
      := TGrymObjectFactory2.Create(Self.PInterface as IGrymObjectFactory2);
  end;

  Result := Self.FFactory2;
end;

end.
