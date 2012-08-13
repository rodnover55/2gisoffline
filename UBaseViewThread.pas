unit UBaseViewThread;

interface

uses
  UInterfaceWrapper, GrymCore_TLB, UBaseViewFrame, UGrymObjectFactory
    , UBaseReference;

type
  TBaseViewThread = class(TInterfaceWrapper<IBaseViewThread>)
    FFrame: TBaseViewFrame;
    FFactory: TGrymObjectFactory;
    FBaseReference: TBaseReference;
  public
    destructor Destroy; override;
    function GetFrame: TBaseViewFrame;
    function GetFactory: TGrymObjectFactory;
    function GetBaseReference: TBaseReference;
  end;

implementation

uses
  SysUtils, ComObj;

{ TBaseViewThread }

destructor TBaseViewThread.Destroy;
begin
  FreeAndNil(Self.FFrame);
  FreeAndNil(Self.FFactory);
  FreeAndNil(Self.FBaseReference);
  inherited;
end;

function TBaseViewThread.GetBaseReference: TBaseReference;
var
  BaseReference: IBaseReference;
begin
  if not Assigned(Self.FBaseReference) then
  begin
    OleCheck(Self.GetInterface.Get_BaseReference(BaseReference));
    Self.FBaseReference := TBaseReference.Create(BaseReference);
  end;
  Result := Self.FBaseReference;
end;

function TBaseViewThread.GetFactory: TGrymObjectFactory;
var
  pFactory: IGrymObjectFactory;
begin
  if not Assigned(Self.FFactory) then
  begin
    OleCheck(Self.GetInterface.Get_Factory(pFactory));
    Self.FFactory := TGrymObjectFactory.Create(pFactory);
  end;

  Result := Self.FFactory;
end;

function TBaseViewThread.GetFrame: TBaseViewFrame;
var
  pBaseViewFrame: IBaseViewFrame;
begin
  if not Assigned(Self.FFrame) then
  begin
    OleCheck(Self.GetInterface.Get_Frame(pBaseViewFrame));
    Self.FFrame := TBaseViewFrame.Create(pBaseViewFrame);
  end;

  Result := Self.FFrame;
end;

end.
