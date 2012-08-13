unit UGrymObjectFactory2;

interface

uses
  UInterfaceWrapper, GrymCore_TLB, UGrymControl;

type
  TGrymObjectFactory2 = class(TInterfaceWrapper<IGrymObjectFactory2>)
  public
    function CreateGrymControl(TypeControl: GrymControlType): TGrymControl;
  end;

implementation

uses
  ComObj;

{ TGrymObjectFactory2 }

function TGrymObjectFactory2.CreateGrymControl(
  TypeControl: GrymControlType): TGrymControl;
var
  pControl: IGrymControl;
begin
  OleCheck(Self.GetInterface.CreateGrymControl(TypeControl, pControl));
  Result := TGrymControl.Create(pControl);
end;

end.
