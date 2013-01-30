unit UBaseKeeper;

interface

uses
  Generics.Collections;

type
  TBaseKeeper<T: class; Y: class> = class
  private
    type TTypeCollection = TObjectDictionary<Y, T>;

    class var FInstance: TTypeCollection;
    class procedure Init;
  public
    destructor Destroy; override;

    class procedure AddInstance(Key: Y; Value: T); overload;
    class function Exists(Key: Y): Boolean;
    class function GetInstance(Value: Y): T; overload;
  end;

implementation

uses
  SysUtils;

{ TBaseKeeper<T, Y> }

class function TBaseKeeper<T, Y>.GetInstance(Value: Y): T;
begin
  if TBaseKeeper<T, Y>.Exists(Value) then
  begin
    Result := TBaseKeeper<T, Y>.FInstance[Value];
  end
  else
  begin
    Result := nil;
  end;
end;

class procedure TBaseKeeper<T, Y>.Init;
begin
  if not Assigned(TBaseKeeper<T, Y>.FInstance) then
  begin
    TBaseKeeper<T, Y>.FInstance := TTypeCollection.Create;
  end;
end;

class procedure TBaseKeeper<T, Y>.AddInstance(Key: Y; Value: T);
begin
  if not TBaseKeeper<T, Y>.Exists(Key) then
  begin
    TBaseKeeper<T, Y>.FInstance.Add(Key, Value);
  end;
end;

destructor TBaseKeeper<T, Y>.Destroy;
begin
  FreeAndNil(TBaseKeeper<T, Y>.FInstance);
  inherited;
end;

class function TBaseKeeper<T, Y>.Exists(Key: Y): Boolean;
begin
  TBaseKeeper<T, Y>.Init;

  Result := TBaseKeeper<T, Y>.FInstance.ContainsKey(Key);
end;

end.
