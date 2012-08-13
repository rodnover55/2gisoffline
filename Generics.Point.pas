unit Generics.Point;

interface

type
  TPoint<T> = record
  public
    X: T;
    Y: T;

    constructor Create(X: T; Y: T);
    procedure SetPoint(X: T; Y: T);
  end;

implementation

{ TPoint<T> }

constructor TPoint<T>.Create(X, Y: T);
begin
  Self.SetPoint(X, Y);
end;

procedure TPoint<T>.SetPoint(X, Y: T);
begin
  Self.X := X;
  Self.Y := Y;
end;

end.
