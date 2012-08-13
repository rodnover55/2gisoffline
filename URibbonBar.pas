unit URibbonBar;

interface

uses
  UInterfaceWrapper, GrymCore_TLB, UGrymControlTab, UBasePlacementControl;

type
  TRibbonBar = class(TInterfaceWrapper<IRibbonBar>)
  public
    function CreateTab(Tab: TBasePlacementControl<TGrymControlTab>): IRibbonTab;
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

end.
