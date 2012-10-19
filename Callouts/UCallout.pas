unit UCallout;

interface

uses
  UInterfaceWrapper, GrymCore_TLB, UCalloutTab;

type
  TCallout = class(TInterfaceWrapper<ICallout>)
  public
    function AddTab(Title: string): TCalloutTab;
    procedure SetTag(Tag: string);
  end;

implementation

uses
  ComObj;
{ TCallout }

function TCallout.AddTab(Title: string): TCalloutTab;
var
  CalloutTab: ICalloutTab;
begin
  OleCheck(Self.GetInterface.AddTab(Title, CalloutTab));

  Result := TCalloutTab.Create(CalloutTab);
end;

procedure TCallout.SetTag(Tag: string);
begin
  OleCheck((Self.GetInterface as IGraphicBase).Set_Tag(Tag));
end;

end.
