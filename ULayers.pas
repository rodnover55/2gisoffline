unit ULayers;

interface

uses
  UInterfaceWrapper, GrymCore_TLB, ULayer;

type
  TLayers = class(TInterfaceWrapper<ILayerCollection>)
  public
    procedure AddLayer(Layer: ILayer);
    procedure RemoveLayer(Layer: ILayer);
  end;

implementation

uses
  ComObj;

{ TLayers }

procedure TLayers.AddLayer(Layer: ILayer);
begin
  OleCheck(Self.GetInterface.AddLayer(Layer));
end;

procedure TLayers.RemoveLayer(Layer: ILayer);
begin
  OleCheck(Self.GetInterface.RemoveLayer(Layer));
end;

end.
