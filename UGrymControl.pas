unit UGrymControl;

interface

uses
  UInterfaceWrapper, GrymCore_TLB;

type
  TGrymControl = class(TInterfaceWrapper<IGrymControl>)
  public
    procedure SetWidth(Width: Integer);
    procedure SetHeight(Height: Integer);
  end;

implementation

uses
  ComObj;
{ TGrymControl }

procedure TGrymControl.SetHeight(Height: Integer);
begin
  OleCheck(Self.GetInterface.Set_Height(Height));
end;

procedure TGrymControl.SetWidth(Width: Integer);
begin
  OleCheck(Self.GetInterface.Set_Width(Width));
end;

end.
