unit USymbol;

interface

uses
  GrymCore_TLB, Generics.Point, Generics.Collections, Graphics, UMapRect;

type
  TDoublePoint = TPoint<Double>;
  TDoublePoints = class (TList<TDoublePoint>)
  end;
  TSymbol = class
  protected
    FPoints: TDoublePoints;
    FText: string;
    FFont: TFont;
    FIndex: Integer;
    class var Counter: Integer;
    class function GetNextIndex: Integer;

  public
    constructor Create(StartX: Double; StartY: Double);
    function GetDimension: ComponentDimension; virtual; abstract;
    function IsPointInside(pDevice: IMapDevice; pPos: IMapPoint): Boolean
      ; virtual;
    procedure ShapeFill(const pShape: IShapeFill); virtual;

    function GetPoints: TDoublePoints;
    function GetLabel: string; virtual;
    procedure SetLabel(Text: string);

    function GetTextSymbol: ITextSymbol; virtual;
    function GetMarkerSymbol: IRasterMarkerSymbol; virtual;
    function GetLineSymbol: ILineSymbol; virtual;
    function GetFillSymbol: IFillSymbol; virtual;


    procedure GetBound(out MinX: Double; out MaxX: Double
      ; out MinY: Double; out MaxY: Double); overload;
    function GetBound: TMapRect; overload;
    procedure AddPoint(X: Double; Y: Double);
    procedure MovePoint(Index: Integer; X: Double; Y: Double);
    procedure RemoveLastPoint;
    procedure FillObjects(L: TList<TSymbol>); virtual;
  end;

implementation

uses
  Variants, UGrymPlugin;

{ TSymbol }
procedure TSymbol.AddPoint(X, Y: Double);
begin
  Self.FPoints.Add(TPoint<Double>.Create(X, Y));
end;

constructor TSymbol.Create(StartX, StartY: Double);
begin
  Self.FPoints := TDoublePoints.Create;
  Self.FPoints.Add(TPoint<Double>.Create(StartX, StartY));
  Self.FFont := TFont.Create;
  Self.FIndex := TSymbol.GetNextIndex;
end;

procedure TSymbol.GetBound(out MinX, MaxX, MinY, MaxY: Double);
var
  Point: TDoublePoint;
begin
  MinX := Self.FPoints[0].X;
  MaxX := Self.FPoints[0].X;
  MinY := Self.FPoints[0].Y;
  MaxY := Self.FPoints[0].Y;

  for Point in Self.FPoints do
  begin
    if Point.X < MinX then
    begin
      MinX := Point.X;
    end;

    if Point.Y < MinY then
    begin
      MinY := Point.Y;
    end;

    if Point.X > MaxX then
    begin
      MaxX := Point.X;
    end;

    if Point.Y > MaxY then
    begin
      MaxY := Point.Y;
    end;
  end;
end;

function TSymbol.GetBound: TMapRect;
var
  MinX: Double;
  MaxX: Double;
  MinY: Double;
  MaxY: Double;
begin
  Self.GetBound(MinX, MaxX, MinY, MaxY);

  Result := TMapRect.Create(MinX, MinY, MaxX, MaxY);
end;

function TSymbol.GetFillSymbol: IFillSymbol;
begin
  Result := nil;
end;

function TSymbol.GetLabel: string;
begin
  Result := Self.FText;
end;

function TSymbol.GetLineSymbol: ILineSymbol;
begin
  Result := nil;
end;

function TSymbol.GetMarkerSymbol: IRasterMarkerSymbol;
begin
  Result := nil;
end;

class function TSymbol.GetNextIndex: Integer;
begin
  Inc(TSymbol.Counter);
  Result := TSymbol.Counter;
end;

procedure TSymbol.FillObjects(L: TList<TSymbol>);
begin
  L.Add(Self);
end;

function TSymbol.GetPoints: TDoublePoints;
begin
  Result := Self.FPoints;
end;

// TODO: Закешировать, менять при изменении текста и шрифтов
function TSymbol.GetTextSymbol: ITextSymbol;
begin
  Result := TGrymPlugin.GetInstance.BaseViewThread
    .GetFactory.CreateTextSymbol(Self.FFont);
end;

function TSymbol.IsPointInside(pDevice: IMapDevice; pPos: IMapPoint): Boolean;
begin
  Result := False;
//  Self.GetTextSymbol.
//  OleCheck(Self.GetTextSymbol.IsPointInside(pDevice, pPos, ))
end;

procedure TSymbol.MovePoint(Index: Integer; X, Y: Double);
begin
  Self.FPoints[Index] := TPoint<Double>.Create(X, Y);
end;

procedure TSymbol.RemoveLastPoint;
begin
  if Self.FPoints.Count > 0 then
  begin
    Self.FPoints.Delete(Self.FPoints.Count - 1);
  end;
end;

procedure TSymbol.SetLabel(Text: string);
begin
  Self.FText := Text;
end;

procedure TSymbol.ShapeFill(const pShape: IShapeFill);
var
  Point: TDoublePoint;
begin
  pShape.SetOID(Self.FIndex);
  pShape.AddComponent(Self.GetDimension, EmptyParam);

  for Point in Self.GetPoints do
  begin
    pShape.AddPoint(Point.X, Point.Y);
  end;
end;

end.
