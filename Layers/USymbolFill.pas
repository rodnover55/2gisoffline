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
