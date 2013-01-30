unit UBaseViewFrame;

interface

uses
  UInterfaceWrapper, GrymCore_TLB, URibbonBar, UMap, UCustomPageCollection;

type
  TBaseViewFrame = class(TInterfaceWrapper<IBaseViewFrame>)
  private
    FMainRibbonBar: TRibbonBar;
    FMap: TMap;
    FCustomPageCollection: TCustomPageCollection;
  public
    destructor Destroy; override;
    function GetMainRibbonBar: TRibbonBar;
    function GetMap: TMap;

    function GetCustomPageCollection: TCustomPageCollection;
  end;

implementation

uses
  SysUtils, ComObj;

{ TBaseViewFrame }

destructor TBaseViewFrame.Destroy;
begin
  FreeAndNil(Self.FMainRibbonBar);
  FreeAndNil(Self.FMap);
  FreeAndNil(Self.FCustomPageCollection);
  inherited;
end;

function TBaseViewFrame.GetCustomPageCollection: TCustomPageCollection;
var
  pCustomPageCollection: ICustomPageCollection;
begin
  if not Assigned(Self.FCustomPageCollection) then
  begin
    OleCheck(Self.GetInterface.Get_CustomPageCollection(pCustomPageCollection));
    Self.FCustomPageCollection := TCustomPageCollection.Create(pCustomPageCollection);
  end;
  Result := Self.FCustomPageCollection;
end;

function TBaseViewFrame.GetMainRibbonBar: TRibbonBar;
var
  pMainRibbonBar: IRibbonBar;
begin
  if not Assigned(Self.FMainRibbonBar) then
  begin
    OleCheck(Self.GetInterface.Get_MainRibbonBar(pMainRibbonBar));
    Self.FMainRibbonBar := TRibbonBar.Create(pMainRibbonBar);
  end;

  Result := Self.FMainRibbonBar;
end;

function TBaseViewFrame.GetMap: TMap;
var
  pMap: IMap;
begin
  if not Assigned(Self.FMap) then
  begin
    OleCheck(Self.GetInterface.Get_Map(pMap));
    Self.FMap := TMap.Create(pMap);
  end;

  Result := Self.FMap;
end;

end.
