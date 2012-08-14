unit ULayers;

interface

uses
  UInterfaceWrapper, GrymCore_TLB, ULayer, UMapInfoLayer;

// TODO: Объединить слои в один массив.
type
  TLayers = class(TInterfaceWrapper<ILayerCollection>)
  private
    FMapInfoLayer: IMapInfoLayer;

    class var MaxIDPlacement: Integer;

    function GetMapInfoLayer: IMapInfoLayer;
  public
    constructor Create(P: ILayerCollection); overload;
    constructor Create; overload;

    destructor Destroy; override;
    procedure AddLayer(Layer: ILayer);
    procedure RemoveLayer(Layer: ILayer);

    procedure AddMapInfoLayer(Layer: TMapInfoLayer);
    procedure RemoveMapInfoLayer(Layer: TMapInfoLayer);

    function FindLayer(Tag: string): ILayer;
  end;

implementation

uses
  ComObj, SysUtils;

{ TLayers }

procedure TLayers.AddLayer(Layer: ILayer);
begin
  OleCheck(Self.GetInterface.AddLayer(Layer));
end;

procedure TLayers.AddMapInfoLayer(Layer: TMapInfoLayer);
begin
  if Layer.GetPlacement = EmptyStr then
  begin
    Inc(TLayers.MaxIDPlacement);
    Layer.SetPlacement(Format('1105%4d:0', [TLayers.MaxIDPlacement]));
  end;

  OleCheck(Self.GetMapInfoLayer.Register(Layer));
end;

constructor TLayers.Create(P: ILayerCollection);
begin
  inherited;
end;

constructor TLayers.Create;
begin
  inherited;
end;

destructor TLayers.Destroy;
begin
  inherited;
end;

function TLayers.FindLayer(Tag: string): ILayer;
begin
  OleCheck(Self.GetInterface.FindLayer(Tag, Result));
end;

function TLayers.GetMapInfoLayer: IMapInfoLayer;
var
  GrymLayer: ILayer;
begin
  if not Assigned(Self.FMapInfoLayer) then
  begin
    GrymLayer := Self.FindLayer('Grym_Map_UMLRHOUS');
    OleCheck(Self.GetInterface.Get_MapInfoLayer(GrymLayer as IGrymLayer
      , Self.FMapInfoLayer));
  end;
  Result := Self.FMapInfoLayer;
end;

procedure TLayers.RemoveLayer(Layer: ILayer);
begin
  OleCheck(Self.GetInterface.RemoveLayer(Layer));
end;

procedure TLayers.RemoveMapInfoLayer(Layer: TMapInfoLayer);
begin
  OleCheck(Self.GetMapInfoLayer.Unregister(Layer));
end;

end.
