unit UGroupsPlacement;

interface

uses
  UBasePlacement;

type
  TGroupsPlacement<T: class> = class(TBasePlacement<T>)
  const
    PLACEMENT_FORMAT = '1001Groups%4d';
  protected
    procedure Fill; override;
  end;


implementation

uses
  UBasePlacementControl, SysUtils;

{ TGroupPlacement<T> }

procedure TGroupsPlacement<T>.Fill;
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
