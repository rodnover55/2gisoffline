unit UCalloutTab;

interface

uses
  UInterfaceWrapper, GrymCore_TLB;

type
  TCalloutTab = class(TInterfaceWrapper<ICalloutTab>)
  private
    function GetText: string;
    procedure SetText(const Value: string);
  public
    property Text: string read GetText write SetText;
  end;

implementation

uses
  ComObj;

{ TCalloutTab }

function TCalloutTab.GetText: string;
var
  Text: WideString;
begin
  OleCheck(Self.GetInterface.Get_Text(Text));
  Result := Text;
end;

procedure TCalloutTab.SetText(const Value: string);
begin
  OleCheck(Self.GetInterface.Set_Text(Value));
end;

end.
