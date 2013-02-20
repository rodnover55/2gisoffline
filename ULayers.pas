unit ULayers;

interface

uses
  UInterfaceWrapper, GrymCore_TLB, ULayer, UMapInfoLayer, UGrymBaseControl;

// TODO: Объединить слои в один массив.
type
  TLayers = class(TInterfaceWrapper<ILayerCollection>)
  private
    FMapInfoLayer: IMapInfoLayer;

    class var MaxIDPlacement: Integer;

    procedure SetPlacement(Layer: TGrymBaseControl);
  public
    function GetMapInfoLayer: IMapInfoLayer;

    procedure AddLayer(Layer: TLayer);
    procedure RemoveLayer(Layer: TLayer);

    procedure AddMapInfoLayer(Layer: TMapInfoLayer);
    procedure RemoveMapInfoLayer(Layer: TMapInfoLayer);

    function FindLayer(Tag: string): ILayer;
    function GetBuildings: ILayer;
  end;

implementation

uses
  ComObj, SysUtils;

{ TLayers }

procedure TLayers.AddLayer(Layer: TLayer);
begin
  Self.SetPlacement(Layer);
  OleCheck(Self.GetInterface.AddLayer(Layer));
end;

procedure TLayers.AddMapInfoLayer(Layer: TMapInfoLayer);
begin
  Self.SetPlacement(Layer);
  OleCheck(Self.GetMapInfoLayer.Register(Layer as IMapInfoLayerBlock));
end;

function TLayers.FindLayer(Tag: string): ILayer;
begin
  OleCheck(Self.GetInterface.FindLayer(Tag, Result));
end;

function TLayers.GetBuildings: ILayer;
begin
  Result := Self.FindLayer('Grym_Map_UMLRHOUS');
end;

function TLayers.GetMapInfoLayer: IMapInfoLayer;
var
  GrymLayer: ILayer;
begin
  if not Assigned(Self.FMapInfoLayer) then
  begin
    GrymLayer := Self.GetBuildings;
    OleCheck(Self.GetInterface.Get_MapInfoLayer(GrymLayer as IGrymLayer
      , Self.FMapInfoLayer));
  end;
  Result := Self.FMapInfoLayer;
end;

procedure TLayers.RemoveLayer(Layer: TLayer);
begin
  OleCheck(Self.GetInterface.RemoveLayer(Layer));
end;

procedure TLayers.RemoveMapInfoLayer(Layer: TMapInfoLayer);
begin
  OleCheck(Self.GetMapInfoLayer.Unregister(Layer as IMapInfoLayerBlock));
end;

procedure TLayers.SetPlacement(Layer: TGrymBaseControl);
begin
  if Layer.GetPlacement = EmptyStr then
  begin
    Inc(TLayers.MaxIDPlacement);
    Layer.SetPlacement(Format('1105%4d:0', [TLayers.MaxIDPlacement]));
  end;
end;

end.

