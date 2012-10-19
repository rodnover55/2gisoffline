unit UMapControllerCustomization;

interface

uses
  UInterfaceWrapper, GrymCore_TLB, UMapControllerCustomizer;

type
  TMapControllerCustomization = class(TInterfaceWrapper<IObjectCustomization>)
  public
    procedure RegisterCustomizer(Customizer: TMapControllerCustomizer);
    procedure UnregisterCustomizer(Customizer: TMapControllerCustomizer);
  end;

implementation

uses
  ComObj;

{ TMapControllerCustomization }

procedure TMapControllerCustomization.RegisterCustomizer(
  Customizer: TMapControllerCustomizer);
begin
  OleCheck(Self.GetInterface.RegisterCustomizer(Customizer));
end;

procedure TMapControllerCustomization.UnregisterCustomizer(
  Customizer: TMapControllerCustomizer);
begin
  OleCheck(Self.GetInterface.UnregisterCustomizer(Customizer));
end;

end.
