unit USymbolText;

interface

uses
  USymbolPoint, GrymCore_TLB, Graphics;

type
  TSymbolText = class(TSymbolPoint)
  public
    constructor Create(StartX: Double; StartY: Double; Text: string
      ; Font: TFont);
  end;

implementation

{ TSymbolText }

constructor TSymbolText.Create(StartX, StartY: Double; Text: string;
  Font: TFont);
begin
  inherited Create(StartX, StartY);

  Self.FText := Text;
  Self.FFont.Assign(Font);
end;

end.
