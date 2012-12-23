unit UGrymObjectFactory;

interface

uses
  UInterfaceWrapper, GrymCore_TLB, UGrymObjectFactory2, USymbolPoint, Graphics
    , UMapPoint, UDevPoint, Classes;

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
    function CreateRasterFromPicture(Picture: Graphics.TGraphic): IRaster;
    function CreateRasterFromStream(Stream: TCustomMemoryStream): IRaster;
    function GetRaster(Resource: string): IRaster;
    function CreateDevPoint(X: Integer; Y: Integer): TDevPoint;
    function CreateMapPoint(X: Double; Y: Double): TMapPoint;
  end;

implementation

uses
  SysUtils, ComObj, ActiveX, Windows, pngimage;

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

function TGrymObjectFactory.CreateRasterFromPicture(Picture: Graphics.TGraphic): IRaster;
var
  Png: TPngImage;
  Stream: TMemoryStream;
begin
  Stream := TMemoryStream.Create;

  try
    Png := TPngImage.Create;
    Png.Assign(Picture);
    Png.SaveToStream(Stream);
    Result := Self.CreateRasterFromStream(Stream);
  finally
    FreeAndNil(Png);
    FreeAndNil(Stream);
  end;
end;

function TGrymObjectFactory.CreateRasterFromStream(
  Stream: TCustomMemoryStream): IRaster;
var
  SA: SAFEARRAY;
begin
  ZeroMemory(@sa, sizeof(sa));
  sa.cDims := 1;
  sa.cbElements := 1;
  sa.pvData := Stream.Memory;
  sa.rgsabound[0].cElements := Stream.Size;
  OleCheck(Self.GetInterface.CreateRasterFromMemory(@sa, Result));
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

function TGrymObjectFactory.GetRaster(Resource: string): IRaster;
var
  RS: TResourceStream;
begin
  RS := TResourceStream.Create(HInstance, Resource, RT_RCDATA);
  try
    Result := Self.CreateRasterFromStream(RS);
  finally
    FreeAndNil(RS);
  end;
end;

end.
