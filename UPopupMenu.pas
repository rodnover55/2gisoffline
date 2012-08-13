unit UPopupMenu;

interface

uses
  UInterfaceWrapper, GrymCore_TLB;
type
  TPopupMenu = class(TInterfaceWrapper<IPopupMenu>)
  public
    procedure AddControl(Control: IUnknown);
  end;

implementation

uses
  ComObj;

{ TPopupMenu }

procedure TPopupMenu.AddControl(Control: IInterface);
var
  pControlSet: IControlSet;
begin
  OleCheck(Self.GetInterface.QueryInterface(IID_IControlSet, pControlSet));
  OleCheck(pControlSet.AddControl(Control));
end;

end.
