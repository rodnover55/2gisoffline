unit UMapInfoControllers;

interface

uses
  UInterfaceWrapper, GrymCore_TLB, UMapInfoController;

type
  TMapInfoControllers = class(TInterfaceWrapper<IMapInfoControllers>)
  public
    procedure AddController(Controller: TMapInfoController);
    procedure RemoveController(Controller: TMapInfoController);
    function FindMapInfoController(Tag: string): IMapInfoController;
    function GetMapInfoDefault: IMapInfoController;
  end;

implementation

uses
  ComObj;

{ TMapInfoControllers }

procedure TMapInfoControllers.AddController(Controller: TMapInfoController);
begin
  OleCheck(Self.GetInterface.AddController(Controller));
end;

function TMapInfoControllers.FindMapInfoController(
  Tag: string): IMapInfoController;
begin
  OleCheck((Self.GetInterface as IMapInfoControllers2)
    .FindMapInfoController(Tag, Result));
end;

function TMapInfoControllers.GetMapInfoDefault: IMapInfoController;
begin
  Result := Self.FindMapInfoController('Grym.MapInfo.Default');
end;

procedure TMapInfoControllers.RemoveController(Controller: TMapInfoController);
begin
  OleCheck(Self.GetInterface.RemoveController(Controller));
end;

end.
