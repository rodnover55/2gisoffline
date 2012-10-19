unit URibbonBar;

interface

uses
  UInterfaceWrapper, GrymCore_TLB, UGrymControlTab, UBasePlacementControl;

type
  TRibbonBar = class(TInterfaceWrapper<IRibbonBar>)
  public
    function CreateTab(Tab: TBasePlacementControl<TGrymControlTab>): IRibbonTab;
    function GetTab(Tag: string): TGrymControlTab;
    function GetToolTab: TGrymControlTab;
  end;

implementation

uses
  ComObj;
{ TRibbonBar }

function TRibbonBar.CreateTab(Tab: TBasePlacementControl<TGrymControlTab>): IRibbonTab;
var
  Control: TGrymControlTab;
begin
  Control := Tab.Control;
  OleCheck(Self.GetInterface.CreateTab(Control.ID, Tab.Placement
    , Control.Caption, Result));
  Control.SetInterface(Result);
// Добавляем группы
  Control.Fill;
end;

function TRibbonBar.GetTab(Tag: string): TGrymControlTab;
var
  pRibbonTab: IRibbonTab;
begin
  OleCheck(Self.GetInterface.Get_Tab(Tag, pRibbonTab));
  Result := TGrymControlTab.Create(pRibbonTab);
end;

function TRibbonBar.GetToolTab: TGrymControlTab;
begin
  Result := Self.GetTab('Grym.ToolsTab');
end;

end.
