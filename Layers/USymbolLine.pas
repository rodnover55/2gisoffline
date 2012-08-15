unit USymbolLine;

interface


uses
  USymbol, GrymCore_TLB, Generics.Point, Graphics, Generics.Collections;

type
  TSymbolLine = class(TSymbol)
  private
    ListPoints: TObjectList<TSymbol>;
  protected
    FStyle: SimpleLineStyle;
    FWidth: Double;
    FColor: TColor;
    FpLineSymbol: ILineSymbol;
  public
    constructor Create(StartX: Double; StartY: Double; Style: SimpleLineStyle
      ; Width: Double; Color: TColor);
    destructor Destroy; override;
    function GetDimension: ComponentDimension; override;
    function GetLineSymbol: ILineSymbol; virtual;
    procedure ShapeFill(const pShape: IShapeFill); override;

    function GetStyle: SimpleLineStyle;
    function GetWidth: Double;
    function GetColor: TColor;

    procedure SetStyle(Style: SimpleLineStyle);
    procedure SetWidth(Width: Double);
    procedure SetColor(Color: TColor);
    procedure FillObjects(L: TList<TSymbol>); override;
  end;

implementation

uses
  Variants, USymbolPoint, SysUtils, UGrymPlugin;

{ TSymbolLine }

constructor TSymbolLine.Create(StartX, StartY: Double; Style: SimpleLineStyle;
  Width: Double; Color: TColor);
begin
  inherited Create(StartX, StartY);
  Self.FStyle := Style;
  Self.FWidth := Width;
  Self.FColor := Color;
  Self.FpLineSymbol := nil;
end;

destructor TSymbolLine.Destroy;
begin
  FreeAndNil(Self.ListPoints);
  inherited;
end;

procedure TSymbolLine.FillObjects(L: TList<TSymbol>);
var
  Point: TDoublePoint;
  S: TSymbol;
begin
  inherited;

  if not Assigned(Self.ListPoints) then
  begin
    Self.ListPoints := TObjectList<TSymbol>.Create;
  end;

  Self.ListPoints.Clear;

  for Point in Self.FPoints do
  begin
    S := TSymbolPoint.Create(Point.X, Point.Y
      , TGrymPlugin.GetInstance.BaseViewThread.GetFactory
        .GetRaster('LINE_POINT'));
    Self.ListPoints.Add(S);
    L.Add(S);
  end;
end;

function TSymbolLine.GetColor: TColor;
begin
  Result := Self.FColor;
end;

function TSymbolLine.GetDimension: ComponentDimension;
begin
  Result := ComponentDimensionLine;
end;

function TSymbolLine.GetLineSymbol: ILineSymbol;
begin
  if not Assigned(Self.FpLineSymbol) then
  begin
    Self.FpLineSymbol := TGrymPlugin.GetInstance.BaseViewThread.GetFactory
      .CreateSimpleLineSymbol(Self.FStyle, Self.FWidth, Self.FColor);
  end;

  Result := Self.FpLineSymbol;
end;

function TSymbolLine.GetStyle: SimpleLineStyle;
begin
  Result := Self.FStyle;
end;

function TSymbolLine.GetWidth: Double;
begin
  Result := Self.FWidth;
end;

procedure TSymbolLine.SetColor(Color: TColor);
begin
  Self.FColor := Color;
  Self.FpLineSymbol := nil;
end;

procedure TSymbolLine.SetStyle(Style: SimpleLineStyle);
begin
  Self.FStyle := Style;
  Self.FpLineSymbol := nil;
end;

procedure TSymbolLine.SetWidth(Width: Double);
begin
  Self.FWidth := Width;
  Self.FpLineSymbol := nil;
end;

procedure TSymbolLine.ShapeFill(const pShape: IShapeFill);
begin
  inherited;

//  pShape.AddComponent(ComponentDimensionLine, Null);
//
//  Point := Self.GetPoints[0];
//  pShape.AddPoint(Point.X, Point.Y);
end;

end.
