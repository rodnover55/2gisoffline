unit UTabsPlacement;

interface

uses
  UBasePlacement;

type
  TTabsPlacement<T: class> = class(TBasePlacement<T>)
  const
    PLACEMENT_FORMAT = '1001Tabs%4d';
  protected
    procedure Fill; override;
  end;


implementation

uses
  UBasePlacementControl, SysUtils;

{ TTabsPlacement<T> }

procedure TTabsPlacement<T>.Fill;
var
  Count: Integer;
  I: Integer;
  Control: T;
begin
  inherited;

  Count := Self.FControls.Count;

  for I := 0 to Count - 1 do
  begin
    Control := Self.FControls[I];
    Self.FPlacementControls.Add(TBasePlacementControl<T>.Create(Control
      , Format(PLACEMENT_FORMAT, [I])))
  end;
end;

end.
