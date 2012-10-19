unit UCallout;

interface

uses
  UInterfaceWrapper, GrymCore_TLB, UCalloutTab;

type
  TCallout = class(TInterfaceWrapper<ICallout>)
  public
    function AddTab(Title: string): TCalloutTab;
    procedure SetTag(Tag: string);
    function AddStandartButton(Button: CalloutStandardButtonType): Integer;
    function AddCloseButton: Integer;
  end;

implementation

uses
  ComObj;
{ TCallout }

function TCallout.AddCloseButton: Integer;
begin
  Result := Self.AddStandartButton(CalloutStandardButtonTypeClose);
end;

function TCallout.AddStandartButton(Button: CalloutStandardButtonType): Integer;
begin
  OleCheck(Self.GetInterface.AddStandardButton(Button, Result));
end;

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
