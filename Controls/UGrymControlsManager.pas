unit UGrymControlsManager;

interface

uses
  UGrymControlTab, Generics.Collections, UTabsPlacement, UBasePlacementControl
    , URibbonBar;

type
  TGrymTabsList = TObjectList<TGrymControlTab>;

  TGrymControlsManager = class
    Tabs: TGrymTabsList;
    FPlacementManager: TTabsPlacement<TGrymControlTab>;
  public
    constructor Create;
    destructor Destroy; override;

    function Add(Tab: TGrymControlTab): Integer;
    procedure Insert(Index: Integer; Tab: TGrymControlTab);
    procedure Delete(Index: Integer);
    function GetEnumerator: TEnumerator<TBasePlacementControl<TGrymControlTab>>;
    procedure Fill(Ribbon: TRibbonBar);
  end;

implementation

uses
  SysUtils;

{ TGrymControlsManager }

function TGrymControlsManager.Add(Tab: TGrymControlTab): Integer;
begin
  Result := Self.Tabs.Add(Tab);
end;

constructor TGrymControlsManager.Create;
begin
  Self.Tabs := TGrymTabsList.Create;
end;

procedure TGrymControlsManager.Delete(Index: Integer);
begin
  Self.Tabs.Delete(Index);
end;

destructor TGrymControlsManager.Destroy;
begin
  FreeAndNil(Self.FPlacementManager);
  FreeAndNil(Self.Tabs);
  inherited;
end;

procedure TGrymControlsManager.Fill(Ribbon: TRibbonBar);
var
  TabPlacementControl: TBasePlacementControl<TGrymControlTab>;
begin
  for TabPlacementControl in Self do
  begin
    Ribbon.CreateTab(TabPlacementControl);
  end;
end;

function TGrymControlsManager.GetEnumerator: TEnumerator<TBasePlacementControl<TGrymControlTab>>;
begin
  FreeAndNil(Self.FPlacementManager);

  Self.FPlacementManager := TTabsPlacement<TGrymControlTab>.Create(Self.Tabs);
  Result := Self.FPlacementManager.GetEnumerator;
end;

procedure TGrymControlsManager.Insert(Index: Integer; Tab: TGrymControlTab);
begin
  Self.Tabs.Insert(Index, Tab);
end;

end.
