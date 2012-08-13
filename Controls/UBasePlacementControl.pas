unit UBasePlacementControl;

interface

uses
  UInterfaceWrapper;

type
  TBasePlacementControl<T: class> = class
    FPlacement: string;
    FControl: T;
  public
    constructor Create(Control: T; Placement: string);
    function GetControl: T;
    function GetPlacement: string;

    property Control: T read GetControl;
    property Placement: string read GetPlacement;
  end;

implementation

uses
  SysUtils;

{ TBasePlacementControl<T> }

constructor TBasePlacementControl<T>.Create(Control: T; Placement: string);
begin
  Self.FControl := Control;
  Self.FPlacement := Placement;
end;

function TBasePlacementControl<T>.GetControl: T;
begin
  Result := Self.FControl;
end;

function TBasePlacementControl<T>.GetPlacement: string;
begin
  Result := Self.FPlacement;
end;

end.
