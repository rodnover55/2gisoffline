unit UBaseSenderController;

interface

uses
  UBaseController;

type
  TBaseSenderController<T: class> = class(TBaseController)
    FSender: T;
  public
    constructor Create(Sender: T);
  end;

implementation

{ TBaseSenderController<T> }

constructor TBaseSenderController<T>.Create(Sender: T);
begin
  Self.FSender := Sender;
end;

end.
