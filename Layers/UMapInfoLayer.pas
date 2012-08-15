unit UMapInfoLayer;

interface

uses
  GrymCore_TLB, UGrymBaseControl;

type
  TMapInfoLayer = class(TGrymBaseControl, IMapInfoLayerBlock
    , IMapInfoLayerBlockProp)
  private
    FVisible: Boolean;
    FFiller: IMapInfoLayerFiller;

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
    procedure AddByID(ID: Integer); overload;
    procedure AddByID(ID: Integer; Raster: IRaster); overload;
    constructor Create(ID: string; Caption: string; Description: string = '');
  // IMapInfoLayerBlock
    function SetFiller(const pVal: IMapInfoLayerFiller): HResult; stdcall;
    function Get_MapInfoController(out pVal: IMapInfoController): HResult; stdcall;
    function Get_VisibleState(out pVal: WordBool): HResult; stdcall;
    function Set_VisibleState(pVal: WordBool): HResult; stdcall;
  // IMapInfoLayerBlockProp
    function CheckVisible(lScale: Integer; nType: DeviceType; out pVal: WordBool): HResult; stdcall;
  end;

implementation

uses
  SysUtils, ComObj;

{ TMapInfoLayer }

procedure TMapInfoLayer.AddByID(ID: Integer);
begin
  OleCheck(Self.FFiller.AddByID(ID));
end;

procedure TMapInfoLayer.AddByID(ID: Integer; Raster: IRaster);
begin
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

constructor TMapInfoLayer.Create(ID, Caption, Description: string);
begin
  inherited;
  Self.FVisible := True;
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

function TMapInfoLayer.SetFiller(const pVal: IMapInfoLayerFiller): HResult;
begin
  try
    Self.FFiller := pVal;
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
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
