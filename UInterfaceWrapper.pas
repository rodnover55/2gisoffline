unit UInterfaceWrapper;

interface

type
  TInterfaceWrapper<I: IUnknown> = class(TInterfacedObject)
    PInterface: I;
  public
    constructor Create(P: I); overload;
    constructor Create; overload;
    destructor Destroy; override;
    procedure SetInterface(PI: I);
    function GetInterface: I;
    function IsSet: Boolean;
  end;

implementation

{ TInterfaceWrapper<I> }

constructor TInterfaceWrapper<I>.Create(P: I);
begin
  Self.PInterface := P;
end;

constructor TInterfaceWrapper<I>.Create;
begin
  Self.Create(nil);
end;

destructor TInterfaceWrapper<I>.Destroy;
begin
  Self.PInterface := nil;
  inherited;
end;

function TInterfaceWrapper<I>.GetInterface: I;
begin
  Result := Self.PInterface;
end;

function TInterfaceWrapper<I>.IsSet: Boolean;
begin
  Result := Assigned(Self.PInterface);
end;

procedure TInterfaceWrapper<I>.SetInterface(PI: I);
begin
  Self.PInterface := PI;
end;

end.
