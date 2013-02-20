unit USymbolFill;

interface

uses
  USymbolLine, GrymCore_TLB, Graphics;

type
  TSymbolFill = class(TSymbolLine)
  private
    FpFillSymbol: IFillSymbol;
    FFillStyle: SimpleFillStyle;
    FBackground: TColor;
    FForeground: TColor;
  public
    constructor Create(StartX: Double; StartY: Double; Style: SimpleLineStyle
      ; Width: Double; Color: TColor; Foreground: TColor); overload;
    constructor Create(StartX: Double; StartY: Double; Style: SimpleLineStyle
      ; Width: Double; Color: TColor); overload;
    constructor Create(Symbol: TSymbolLine; Foreground: TColor); overload;

    function GetDimension: ComponentDimension; override;

    function GetFillSymbol: IFillSymbol; override;

    property Foreground: TColor read FForeground write FForeground;
  end;

implementation

uses
  UGrymPlugin;

{ TSymbolFill }

constructor TSymbolFill.Create(StartX, StartY: Double; Style: SimpleFillStyle;
  Width: Double; Color: TColor);
begin
  Self.Create(StartX, StartY, Style, Width, Color, Color);
end;

constructor TSymbolFill.Create(StartX, StartY: Double; Style: SimpleFillStyle;
  Width: Double; Color, Foreground: TColor);
begin
  inherited Create(StartX, StartY, SimpleLineStyleSolid, Width, Color);


  Self.FFillStyle := Style;
  Self.FForeground := Foreground;
  Self.FBackground := Foreground;
end;

constructor TSymbolFill.Create(Symbol: TSymbolLine; Foreground: TColor);
var
  I: Integer;
begin
  inherited Create(Symbol.GetPoints[0].X, Symbol.GetPoints[0].Y
    , SimpleLineStyleSolid, Symbol.GetWidth, Symbol.GetColor);


  for I := 1 to Symbol.GetPoints.Count - 1 do
  begin
    Self.AddPoint(Symbol.GetPoints[I].X, Symbol.GetPoints[I].Y);
  end;

  Self.FFillStyle := Symbol.GetStyle;
  Self.FForeground := Foreground;
  Self.FBackground := Foreground;
end;

function TSymbolFill.GetDimension: ComponentDimension;
begin
  Result := ComponentDimensionPolygon;
end;

function TSymbolFill.GetFillSymbol: IFillSymbol;
begin
  if not Assigned(Self.FpFillSymbol) then
  begin
    Self.FpFillSymbol := TGrymPlugin.GetInstance.BaseViewThread.GetFactory
      .CreateSimpleFillSymbol(Self.FFillStyle, Self.FForeground, Self.FBackground
        , Self.GetLineSymbol);
  end;

  Result := Self.FpFillSymbol;
end;

end.
