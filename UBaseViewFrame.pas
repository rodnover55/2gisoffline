unit UBaseViewFrame;

interface

uses
  UInterfaceWrapper, GrymCore_TLB, URibbonBar, UMap;

type
  TBaseViewFrame = class(TInterfaceWrapper<IBaseViewFrame>)
    FMainRibbonBar: TRibbonBar;
    FMap: TMap;
  public
    destructor Destroy; override;
    function GetMainRibbonBar: TRibbonBar;
    function GetMap: TMap;
  end;

implementation

uses
  SysUtils, ComObj;

{ TBaseViewFrame }

destructor TBaseViewFrame.Destroy;
begin
  FreeAndNil(Self.FMainRibbonBar);
  FreeAndNil(Self.FMap);
  inherited;
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
