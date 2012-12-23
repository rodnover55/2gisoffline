unit UMapInfoLayer;

interface

uses
  GrymCore_TLB, UGrymBaseControl, Generics.Collections;

type
  TMapInfoLayer = class(TGrymBaseControl, IMapInfoLayerBlock
    , IMapInfoLayerBlockProp, IChildControl)
  private
    FVisible: Boolean;
    FFiller: IMapInfoLayerFiller;
    FParent: IUnknown;
    FIDs: TList<Integer>;
    FIsRegistered: Boolean;

    type
      TEmptyMapInfoController = class(TInterfacedObject, IMapInfoController)
      // IMapInfoController
        function Check(const pFeature: IFeature; out pVal: WordBool)
          : HResult; stdcall;
        function Get_Title(out pVal: WideString): HResult; stdcall;
        function Fill(const pFeature: IFeature; const pTab: ICalloutTab)
          : HResult; stdcall;
        function OnTabAction(const pTab: ICalloutTab
          ; const bsActionID: WideString): HResult; stdcall;
      end;
    var
      MapInfoController: TEmptyMapInfoController;
  public
//    function SetIcon(Raster: IRaster): TGrymBaseControl; override;

    procedure CopyTo(Layer: TMapInfoLayer); overload;
    procedure CopyTo(List: TList<Integer>); overload;

    procedure CopyFrom(List: TList<Integer>); overload;
    procedure Hide;
    procedure Show;
    function SetParent(Parent: IUnknown): TMapInfoLayer;
    procedure AddByID(ID: Integer); overload;
    procedure AddByID(ID: Integer; Raster: IRaster); overload;
    procedure RemoveAll;
    constructor Create(ID: string; Caption: string; Description: string = '');
    destructor Destroy; override;
    procedure RegisterLayer;
    procedure UnRegisterLayer;
  // IMapInfoLayerBlock
    function SetFiller(const pVal: IMapInfoLayerFiller): HResult; stdcall;
    function Get_MapInfoController(out pVal: IMapInfoController): HResult; stdcall;
    function Get_VisibleState(out pVal: WordBool): HResult; stdcall;
    function Set_VisibleState(pVal: WordBool): HResult; stdcall;
  // IMapInfoLayerBlockProp
    function CheckVisible(lScale: Integer; nType: DeviceType
      ; out pVal: WordBool): HResult; stdcall;
  // IChildControl
    function Get_ParentControl(out pVal: IUnknown): HResult; stdcall;

    property Visible: Boolean read FVisible write FVisible;
  end;

implementation

uses
  SysUtils, ComObj, UGrymPlugin;

{ TMapInfoLayer }

procedure TMapInfoLayer.AddByID(ID: Integer);
begin
  Self.FIDs.Add(ID);
  OleCheck(Self.FFiller.AddByID(ID));
end;

procedure TMapInfoLayer.AddByID(ID: Integer; Raster: IRaster);
begin
  Self.FIDs.Add(ID);
  OleCheck((Self.FFiller as IMapInfoLayerFiller2).AddByID2(ID, Raster));
end;

function TMapInfoLayer.CheckVisible(lScale: Integer; nType: DeviceType;
  out pVal: WordBool): HResult;
begin
  try
    pVal := True;
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

procedure TMapInfoLayer.CopyFrom(List: TList<Integer>);
var
  ID: Integer;
begin
  Self.RemoveAll;

  for ID in List do
  begin
    Self.AddByID(ID);
  end;
end;

procedure TMapInfoLayer.CopyTo(List: TList<Integer>);
begin
  List.Clear;
  List.AddRange(Self.FIDs);
end;

procedure TMapInfoLayer.CopyTo(Layer: TMapInfoLayer);
var
  ID: Integer;
begin
  Layer.RemoveAll;

  for ID in Self.FIDs do
  begin
    Layer.AddByID(ID);
  end;
end;

constructor TMapInfoLayer.Create(ID, Caption, Description: string);
begin
  inherited;
  Self.FIsRegistered := False;
  Self.FIDs := TList<Integer>.Create;

  Self.FVisible := True;
end;

destructor TMapInfoLayer.Destroy;
begin
  FreeAndNil(Self.FIDs);
  inherited;
end;

function TMapInfoLayer.Get_MapInfoController(
  out pVal: IMapInfoController): HResult;
begin
  try
    if not Assigned(Self.MapInfoController) then
    begin
      Self.MapInfoController := TEmptyMapInfoController.Create;
    end;

    pVal := Self.MapInfoController;
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TMapInfoLayer.Get_ParentControl(out pVal: IInterface): HResult;
begin
  try
    pVal := Self.FParent;

    if Assigned(pVal) then
    begin
      Result := S_OK;
    end
    else
    begin
      Result := S_FALSE;
    end;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TMapInfoLayer.Get_VisibleState(out pVal: WordBool): HResult;
begin
  try
    pVal := Self.FVisible;
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

procedure TMapInfoLayer.Hide;
begin
  Self.FVisible := False;
end;

procedure TMapInfoLayer.RegisterLayer;
begin
  TGrymPlugin.GetInstance.BaseViewThread.GetFrame.GetMap.GetLayers
    .AddMapInfoLayer(Self);
  Self.FIsRegistered := True;
end;

procedure TMapInfoLayer.RemoveAll;
begin
  Self.FIDs.Clear;
  OleCheck(Self.FFiller.RemoveAll);
end;

function TMapInfoLayer.SetFiller(const pVal: IMapInfoLayerFiller): HResult;
var
  ID: Integer;
begin
  try
    Self.FFiller := pVal;

    for ID in Self.FIDs do
    begin
      OleCheck(Self.FFiller.AddByID(ID));
    end;

    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

//function TMapInfoLayer.SetIcon(Raster: IRaster): TGrymBaseControl;
//var
//  pSelf: TMapInfoLayer;
//begin
//  inherited;
//
//  if Self.FIsRegistered then
//  begin
//    Self._AddRef;
//    Self.UnRegisterLayer;
//    Self.RegisterLayer;
//  end;
//end;

function TMapInfoLayer.SetParent(Parent: IInterface): TMapInfoLayer;
begin
  Self.FParent := Parent;
  Result := Self;
end;

function TMapInfoLayer.Set_VisibleState(pVal: WordBool): HResult;
begin
  try
    Result := S_OK;
    Self.FVisible := pVal;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

procedure TMapInfoLayer.Show;
begin
  Self.FVisible := True;
end;

procedure TMapInfoLayer.UnRegisterLayer;
begin
  TGrymPlugin.GetInstance.BaseViewThread.GetFrame.GetMap.GetLayers
    .RemoveMapInfoLayer(Self);
  Self.FFiller := nil;
  Self.FIsRegistered := False;
end;

{ TMapInfoLayer.TEmptyMapInfoController }

function TMapInfoLayer.TEmptyMapInfoController.Check(const pFeature: IFeature;
  out pVal: WordBool): HResult;
begin
  try
    Result := S_OK;
    pVal := False;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TMapInfoLayer.TEmptyMapInfoController.Fill(const pFeature: IFeature;
  const pTab: ICalloutTab): HResult;
begin
  try
    Result := E_NOTIMPL;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TMapInfoLayer.TEmptyMapInfoController.Get_Title(
  out pVal: WideString): HResult;
begin
  try
    Result := E_NOTIMPL;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TMapInfoLayer.TEmptyMapInfoController.OnTabAction(
  const pTab: ICalloutTab; const bsActionID: WideString): HResult;
begin
  try
    Result := E_NOTIMPL;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

end.
