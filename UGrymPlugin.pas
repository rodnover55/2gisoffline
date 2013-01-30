unit UGrymPlugin;

interface

uses
  Windows, ActiveX, Classes, GrymCore_TLB, Dialogs, SysUtils, UBaseController
    , Generics.Collections, UGrymControlsManager, UBaseViewFrame
    , UBaseViewThread;

{$IFNDEF V_2GIS_1_4}
{$DEFINE V_2GIS_1_4}
{$ENDIF}
type
  TGrymPlugin = class(TInterfacedObject, IGrymPlugin, IGrymPluginInfo
    , IGrymPluginOptions, IDispatch, IUnknown)
  private
    pRoot: IGrym;
    fBaseViewThread: TBaseViewThread;

    FRunController: TBaseController;
    FOptionController: TBaseController;
    FRefreshController: TBaseController;

    FPoint: IConnectionPoint;
    FCookie: Integer;

    FName: string;
    FDescription: string;
    FCopyright: string;
    FTag: string;
    FLanguages: string;
    FIsRefreshInstance: Boolean;
    FRestrictedCities: TStringList;
    FIsRestricted: Boolean;

    class var
      FPlugin: TGrymPlugin;

    const PLUGIN_INFO: WideString
      = '<grym_plugin_info>'
      +   '<name>%s</name>'
      +   '<description>%s</description>'
      +   '<copyright>%s</copyright>'
      +   '<tag>%s</tag>'
      +   '<requirements>'
{$IFDEF V_2GIS_1_4}
      +     '<requirement_api>API-1.4</requirement_api>'
{$ENDIF}
      +   '</requirements>'
      +   '<supported_languages>%s</supported_languages>'
      + '</grym_plugin_info>';

    const PLUGIN_INFO_RESTRICTED: WideString
      = '<grym_plugin_info>'
      +   '<name>%s (Не загружен)</name>'
      +   '<description>Работа плагина в этом городе невозможна. %s</description>'
      +   '<copyright>%s</copyright>'
      +   '<tag>%s</tag>'
      +   '<requirements>'
{$IFDEF V_2GIS_1_4}
      +     '<requirement_api>API-1.4</requirement_api>'
{$ENDIF}
      +   '</requirements>'
      +   '<supported_languages>%s</supported_languages>'
      + '</grym_plugin_info>';

    procedure RefreshInstance;
  public
    constructor Create(Tag: string; Name: string; Languages: array of string
      ; Description: string = ''; Copyright: string = '');

    constructor Launch(BaseName: string);
    procedure FillRibbon(Manager: TGrymControlsManager);

    procedure InnerInitialize(const Root: IGrym; const BaseView: IBaseViewThread);
    procedure InnerTerminate;

    destructor Destroy; override;

    function GetRaster(Resource: WideString): IRaster; deprecated;
    function IsInit: Boolean;

    function SetRunController(Controller: TBaseController): TGrymPlugin;
    function SetOptionsController(Controller: TBaseController): TGrymPlugin;
    function SetRefreshController(Controller: TBaseController): TGrymPlugin;
    class function GetInstance: TGrymPlugin;
  // IGrymPlugin
    function Initialize(const pRoot: IGrym; const pBaseView: IBaseViewThread): HResult; stdcall;
    function Terminate: HResult; stdcall;
  // IGrymPluginInfo
    function Get_XMLInfo(out pData: WideString): HResult; stdcall;
  // IGrymPluginOptions
    function OptionDialog(out pRet: WordBool): HResult; stdcall;
  // IUnknown
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
  // IDispatch
    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo)
      : HResult; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer)
      : HResult; stdcall;

    function RestrictCity(Cities: array of string): TGrymPlugin;

    property BaseViewThread: TBaseViewThread read FBaseViewThread;
    property Name: string read FName;
  end;

implementation

uses
  ComObj, URibbonBar, UGrymControlTab, UBasePlacementControl, Forms;

constructor TGrymPlugin.Create(Tag: string; Name: string
  ; Languages: array of string; Description: string = ''
  ; Copyright: string = '');
var
  Language: string;
  LanguagesBuilder: TStringBuilder;
begin
  inherited Create;

  Self.FName := Name;
  Self.FTag := Tag;
  Self.FDescription := Description;
  Self.FCopyright := Copyright;
  Self.FIsRefreshInstance := True;

  LanguagesBuilder := TStringBuilder.Create;

  try
    for Language in Languages do
    begin
      LanguagesBuilder.AppendFormat('<language>%s</language>', [Language]);
    end;
    Self.FLanguages := LanguagesBuilder.ToString;
  finally
    FreeAndNil(LanguagesBuilder);
  end;

  Self.pRoot := nil;
  Self.FRestrictedCities := TStringList.Create;
end;

destructor TGrymPlugin.Destroy;
begin
  FreeAndNil(Self.FRestrictedCities);
  inherited;
end;

procedure TGrymPlugin.FillRibbon(Manager: TGrymControlsManager);
begin
  Manager.Fill(Self.BaseViewThread.GetFrame.GetMainRibbonBar);
end;

function TGrymPlugin.Initialize(const pRoot: IGrym;
  const pBaseView: IBaseViewThread): HResult;
var
  pCont: IConnectionPointContainer;
begin
  Result := S_OK;
  try
    Application.ModalPopupMode := TPopupMode.pmAuto;
    Self.InnerInitialize(pRoot, pBaseView);


    OleCheck(Self.BaseViewThread.GetFrame.GetInterface
      .QueryInterface(IConnectionPointContainer, pCont));

    if Assigned(pCont) then
    begin
{$WARN SYMBOL_PLATFORM OFF}
      pCont.FindConnectionPoint(_IBaseViewFrameEvents, Self.FPoint);
{$WARN SYMBOL_PLATFORM ON}
      if Assigned(Self.FPoint) then
      begin
        FPoint.Advise(Self as IUnknown, Self.FCookie);
      end;
    end;

    try
      Self.RefreshInstance;

      if not Self.FIsRestricted and Assigned(Self.FRunController) then
      begin
        Self.FRunController.Execute;
      end;
    except
      on E: EArgumentNilException do
      begin
        ShowException(ExceptObject, ExceptAddr);
        Result := E_INVALIDARG;
      end
      else
      begin
        raise;
      end;
    end;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := E_FAIL;
  end;
end;

procedure TGrymPlugin.InnerInitialize(const Root: IGrym
  ; const BaseView: IBaseViewThread);
begin
  Self.pRoot := Root;
  Self.fBaseViewThread := TBaseViewThread.Create(BaseView);

  Self.FIsRestricted := (Self.FRestrictedCities.Count > 0) and
    (Self.FRestrictedCities.IndexOf(Self.BaseViewThread.GetBaseReference.GetName) = -1);
end;

function TGrymPlugin.Terminate: HResult; stdcall;
begin
  try
    FreeAndNil(Self.FOptionController);
    FreeAndNil(Self.FRunController);
    FreeAndNil(Self.FRefreshController);

    Self.InnerTerminate;

    if Assigned(Self.FPoint) then
    begin
      Self.FPoint.Unadvise(Self.FCookie);
      Self.FPoint := nil;
    end;

    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := E_FAIL;
  end;
end;

function TGrymPlugin.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HResult;
begin
  try
    case DispID of
      1:
      begin
        Self.RefreshInstance;
        Result := S_OK;
      end;
      else
      begin
        Result := E_NOTIMPL;
      end;
    end;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TGrymPlugin.IsInit: Boolean;
begin
  Result := Self.FIsRestricted and Assigned(Self.pRoot) and
    Self.fBaseViewThread.IsSet;
end;

constructor TGrymPlugin.Launch(BaseName: string);
var
  pRoot: IGrym;
  pBaseView: IBaseViewThread;
  pBaseCollection: IBaseCollection;
  pBaseReference: IBaseReference;
begin
  inherited Create;

  CoInitialize(nil);

  OleCheck(CoCreateInstance(CLASS_GRYM, nil, CLSCTX_INPROC_SERVER or
      CLSCTX_LOCAL_SERVER, IID_IGrym, pRoot));

  OleCheck(pRoot.Get_BaseCollection(pBaseCollection));
  OleCheck(pBaseCollection.FindBase(BaseName, pBaseReference));
  OleCheck(pRoot.GetBaseView(pBaseReference, True, False, pBaseView));

  Self.FIsRefreshInstance := False;
  Self.InnerInitialize(pRoot, pBaseView);

  Assert(not Assigned(TGrymPlugin.FPlugin), 'Экземляр 2ГИС уже создан');
  TGrymPlugin.FPlugin := Self;
end;

function TGrymPlugin.OptionDialog(out pRet: WordBool): HResult;
begin
  try
    if Assigned(Self.FOptionController) then
    begin
      Self.FOptionController.Execute;
    end;

    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_OK;
  end;
end;

function TGrymPlugin.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  try
    if IsEqualGUID(IID, IID_IGrymPluginOptions) then
    begin
      if not Assigned(Self.FOptionController) then
      begin
        Exit(E_NOINTERFACE);
      end;
    end;
    if IsEqualGUID(IID, DIID__IBaseViewFrameEvents) then
    begin
      if GetInterface(IDispatch, Obj) then
      begin
        Result := S_OK;
      end
      else
      begin
        Result := E_NOINTERFACE;
      end;
    end
    else
    begin
      if GetInterface(IID, Obj) then
      begin
        Result := 0
      end
      else
      begin
        Result := E_NOINTERFACE;
      end;
    end;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

procedure TGrymPlugin.RefreshInstance;
begin
  if Self.FIsRefreshInstance then
  begin
    TGrymPlugin.FPlugin := Self;
  end;

  if Assigned(Self.FRefreshController) then
  begin
    Self.FRefreshController.Execute;
  end;
end;

function TGrymPlugin.RestrictCity(Cities: array of string): TGrymPlugin;
var
  City: string;
begin
  Result := Self;

  Self.FRestrictedCities.Clear;

  for City in Cities do
  begin
    Self.FRestrictedCities.Add(City);
  end;

end;

function TGrymPlugin.SetOptionsController(
  Controller: TBaseController): TGrymPlugin;
begin
  Self.FOptionController := Controller;

  Result := Self;
end;

function TGrymPlugin.SetRefreshController(
  Controller: TBaseController): TGrymPlugin;
begin
  Self.FRefreshController := Controller;
  Result := Self;
end;

function TGrymPlugin.SetRunController(Controller: TBaseController): TGrymPlugin;
begin
  Self.FRunController := Controller;
  Result := Self;
end;

procedure TGrymPlugin.InnerTerminate;
begin
  FreeAndNil(Self.fBaseViewThread);
  Self.pRoot := nil;
end;


function TGrymPlugin.GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount,
  LocaleID: Integer; DispIDs: Pointer): HResult;
begin
  try
    Result := E_NOTIMPL;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

class function TGrymPlugin.GetInstance: TGrymPlugin;
begin
  Result := TGrymPlugin.FPlugin;
end;

function TGrymPlugin.GetRaster(Resource: WideString): IRaster;
var
  SA: SAFEARRAY;
  RS: TResourceStream;
begin
  RS := TResourceStream.Create(HInstance, Resource, RT_RCDATA);
  try
    ZeroMemory(@sa, sizeof(sa));
    sa.cDims := 1;
    sa.cbElements := 1;
    sa.pvData := rs.Memory;
    sa.rgsabound[0].cElements := rs.Size;
    OleCheck(Self.BaseViewThread.GetFactory.GetInterface
      .CreateRasterFromMemory(@sa, Result));
  finally
    FreeAndNil(RS);
  end;
end;

function TGrymPlugin.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  try
    Result := E_NOTIMPL;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TGrymPlugin.GetTypeInfoCount(out Count: Integer): HResult;
begin
  try
    if Assigned(@Count) then
    begin
      Count := 0;
      Result := S_OK;
    end
    else
    begin
      Result := E_POINTER;
    end;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TGrymPlugin.Get_XMLInfo(out pData: WideString): HResult;
begin
  try
    if Assigned(@pData) then
    begin
      if Self.FIsRestricted then
      begin
        pData  := Format(PLUGIN_INFO_RESTRICTED, [Self.FName, Self.FDescription
          , Self.FCopyright, Self.FTag, Self.FLanguages]);
      end
      else
      begin
        pData  := Format(PLUGIN_INFO, [Self.FName, Self.FDescription
          , Self.FCopyright, Self.FTag, Self.FLanguages]);
      end;
      Result := S_OK;
    end
    else
    begin
      Result := E_POINTER;
    end;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := E_FAIL;
  end;
end;

end.
