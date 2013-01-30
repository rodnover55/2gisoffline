unit UGrymKeeper;

interface

uses
  UGrymPlugin, UBaseKeeper;

type
  TGrymKeeper<T: class> = class(TBaseKeeper<T, TGrymPlugin>)
    class function GetInstance: T; overload;
  end;

implementation

{ TGrymKeeper<T> }

class function TGrymKeeper<T>.GetInstance: T;
begin
  Result := TGrymKeeper<T>.GetInstance(TGrymPlugin.GetInstance);
end;

end.
