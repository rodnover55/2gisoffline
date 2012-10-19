unit UGrymControlTab;

interface

uses
  UInterfaceWrapper, GrymCore_TLB, Generics.Collections, UGrymControlBaseGroup
    , UBasePlacementControl, UGroupsPlacement;

type
  TGrymGroupList = TObjectList<TGrymControlBaseGroup>;

  TGrymControlTab = class(TInterfaceWrapper<IRibbonTab>)
    FID: string;
    FCaption: string;
    FPlacementManager: TGroupsPlacement<TGrymControlBaseGroup>;
    Groups: TGrymGroupList;

    function CreateGroup(
      Group: TBasePlacementControl<TGrymControlBaseGroup>): IRibbonGroup;
    procedure Init(ID: string; Caption: string);
  public
    constructor Create(P: IRibbonTab); overload;
    constructor Create(ID: string; Caption: string); overload;
    destructor Destroy; override;

    function GetEnumerator: TEnumerator
      <TBasePlacementControl<TGrymControlBaseGroup>>;

    procedure Fill;


    function Add(Group: TGrymControlBaseGroup): Integer;
    procedure Insert(Index: Integer; Group: TGrymControlBaseGroup);
    procedure Delete(Index: Integer);

    property ID: string read FID;
    property Caption: string read FCaption;
  end;

implementation

uses
  SysUtils;

  { TGrymControlTab }

function TGrymControlTab.Add(Group: TGrymControlBaseGroup): Integer;
begin
  Result := Self.Groups.Add(Group);
end;

constructor TGrymControlTab.Create(ID: string; Caption: string);
begin
  inherited Create;
  Self.Init(ID, Caption);
end;

constructor TGrymControlTab.Create(P: IRibbonTab);
begin
  inherited;
  Self.Init('', '');
end;

function TGrymControlTab.CreateGroup(
  Group: TBasePlacementControl<TGrymControlBaseGroup>): IRibbonGroup;
var
  Control: TGrymControlBaseGroup;
begin
  Control := Group.Control;
  Self.GetInterface.CreateGroup(Control.GetType, Control.ID, Group.Placement
    , Control.Caption, Result);
  Control.SetInterface(Result);
  Control.Fill;
end;

procedure TGrymControlTab.Delete(Index: Integer);
begin
   Self.Groups.Delete(Index);
end;

destructor TGrymControlTab.Destroy;
begin
  FreeAndNil(FPlacementManager);
  inherited;
end;

procedure TGrymControlTab.Fill;
var
  GroupPlacementControl: TBasePlacementControl<TGrymControlBaseGroup>;
begin
  for GroupPlacementControl in Self do
  begin
    Self.CreateGroup(GroupPlacementControl);
  end;
end;

function TGrymControlTab.GetEnumerator: TEnumerator<TBasePlacementControl<TGrymControlBaseGroup>>;
begin
  FreeAndNil(Self.FPlacementManager);

  Self.FPlacementManager := TGroupsPlacement<TGrymControlBaseGroup>
    .Create(Self.Groups);
  Result := Self.FPlacementManager.GetEnumerator;
end;

procedure TGrymControlTab.Init(ID, Caption: string);
begin
  Self.FID := ID;
  Self.FCaption := Caption;
  Self.Groups := TGrymGroupList.Create;
end;

procedure TGrymControlTab.Insert(Index: Integer; Group: TGrymControlBaseGroup);
begin
  Self.Groups.Insert(Index, Group);
end;

end.
