unit UMapInfoController;

interface

uses
  GrymCore_TLB, UGrymBaseControl, UCalloutTab, UFeature;

type
  TMapInfoController = class(TGrymBaseControl, IMapInfoController)
  private
    FIsRegistered: Boolean;
  protected
    function InnerCheck(const Feature: TFeature): Boolean; virtual;
    procedure InnerFill(const Feature: TFeature; const Tab: TCalloutTab); virtual;
    procedure InnerClick(const Tab: TCalloutTab;
      const bsActionID: WideString); virtual;
  public
    constructor Create(ID: string; Caption: string; Description: string = '');
    destructor Destroy; override;
    procedure AddController;
    procedure RemoveController;

    function Check(const pFeature: IFeature; out pVal: WordBool):
      HResult; stdcall;
    function Get_Title(out pVal: WideString): HResult; stdcall;
    function Fill(const pFeature: IFeature; const pTab: ICalloutTab):
      HResult; stdcall;
    function OnTabAction(const pTab: ICalloutTab; const bsActionID: WideString):
      HResult; stdcall;
  end;

implementation

uses
  SysUtils, UGrymPlugin;

{ TMapInfoController }

procedure TMapInfoController.AddController;
begin
  if not Self.FIsRegistered then
  begin
    TGrymPlugin.GetInstance.BaseViewThread.GetFrame.GetMap
      .MapInfoControllers.AddController(Self);
    Self.FIsRegistered := True;
  end;
end;

function TMapInfoController.Check(const pFeature: IFeature;
  out pVal: WordBool): HResult;
var
  Feature: TFeature;
begin
  try
    Result := S_OK;
    Feature := TFeature.Create(pFeature);

    try
      pVal := Self.InnerCheck(Feature);
    finally
      FreeAndNil(Feature);
    end;

  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

constructor TMapInfoController.Create(ID, Caption, Description: string);
begin
  inherited;
  Self.FIsRegistered := False;
end;

destructor TMapInfoController.Destroy;
begin
  Self.RemoveController;
  inherited;
end;

function TMapInfoController.Fill(const pFeature: IFeature;
  const pTab: ICalloutTab): HResult;
var
  Tab: TCalloutTab;
  Feature: TFeature;
begin
  try
    Result := S_OK;

    Tab := TCalloutTab.Create(pTab);

    try
      Feature := TFeature.Create(pFeature);
      Self.InnerFill(Feature, Tab);
    finally
      FreeAndNil(Feature);
      FreeAndNil(Tab);
    end;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TMapInfoController.Get_Title(out pVal: WideString): HResult;
begin
  try
    pVal := Self.Caption;
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TMapInfoController.InnerCheck(const Feature: TFeature): Boolean;
begin
  Result := False;
end;

procedure TMapInfoController.InnerClick(const Tab: TCalloutTab;
  const bsActionID: WideString);
begin
end;

procedure TMapInfoController.InnerFill(const Feature: TFeature;
  const Tab: TCalloutTab);
begin
end;

function TMapInfoController.OnTabAction(const pTab: ICalloutTab;
  const bsActionID: WideString): HResult;
var
  Tab: TCalloutTab;
begin
  try
    Result := S_OK;
    Tab := TCalloutTab.Create(pTab);

    try
      Self.InnerClick(Tab, bsActionID);
    finally
      FreeAndNil(Tab);
    end;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

procedure TMapInfoController.RemoveController;
begin
  if Self.FIsRegistered then
  begin
    TGrymPlugin.GetInstance.BaseViewThread.GetFrame.GetMap
      .MapInfoControllers.RemoveController(Self);
    Self.FIsRegistered := False;
  end;
end;

end.
