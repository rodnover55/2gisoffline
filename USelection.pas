unit USelection;

interface

uses
  UInterfaceWrapper, GrymCore_TLB, UFeature, Graphics;
type
  TSelection = class(TInterfaceWrapper<ISelection>)
  public
    procedure AddFeature(Feature: TFeature);
    function GetColor: TColor;
    procedure SetColor(Color: TColor);
  end;

implementation

uses
  SysUtils, ComObj, ActiveX;
{ TSelection }

procedure TSelection.AddFeature(Feature: TFeature);
begin
  OleCheck(Self.GetInterface.AddFeature(Feature.GetInterface));
end;

function TSelection.GetColor: TColor;
var
  Color: Cardinal;
begin
  OleCheck(Self.GetInterface.Get_Color(Color));
  Result := TColor(Color)
end;

procedure TSelection.SetColor(Color: TColor);
begin
  OleCheck(Self.GetInterface.Set_Color(OLE_COLOR(Color)));
end;

end.
