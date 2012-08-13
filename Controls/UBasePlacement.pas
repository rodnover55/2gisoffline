unit UBasePlacement;

interface

uses
  Generics.Collections, GrymCore_TLB, UBasePlacementControl;

type
  TBasePlacement<T: class> = class
    FPlacementControls: TObjectList<TBasePlacementControl<T>>;
    FControls: TObjectList<T>;
  protected
    procedure Fill; virtual; abstract;
  public
    constructor Create(Controls: TObjectList<T>);
    destructor Destroy; override;
    function GetEnumerator: TEnumerator<TBasePlacementControl<T>>;
  end;

implementation

uses
  SysUtils;

{ TBasePlacement<T> }

constructor TBasePlacement<T>.Create(Controls: TObjectList<T>);
begin
  inherited Create;

  Self.FPlacementControls := TObjectList<TBasePlacementControl<T>>.Create;
  Self.FControls := Controls;
  Self.Fill;
end;

destructor TBasePlacement<T>.Destroy;
begin
  FreeAndNil(Self.FPlacementControls);
  inherited;
end;

function TBasePlacement<T>.GetEnumerator: TEnumerator<TBasePlacementControl<T>>;
begin
  Result := Self.FPlacementControls.GetEnumerator;
end;

end.
