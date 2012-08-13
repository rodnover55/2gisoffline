unit UBaseReference;

interface

uses
  UInterfaceWrapper, GrymCore_TLB;

type
  TBaseReference = class(TInterfaceWrapper<IBaseReference>)
  public
    function GetName: string;
  end;

implementation

uses
  ComObj;

{ TBaseReference }

function TBaseReference.GetName: string;
var
  Name: WideString;
begin
  OleCheck(Self.GetInterface.Get_Name(Name));
  Result := Name;
end;

end.
