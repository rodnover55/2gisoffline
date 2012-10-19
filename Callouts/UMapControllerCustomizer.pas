unit UMapControllerCustomizer;

interface

uses
  GrymCore_TLB, UCustomizerActionsList, UCustomizerBuilderXML, UFeature;

type
  TMapControllerCustomizer = class(TInterfacedObject, IMapInfoActionsCustomizer)
  protected
    FActions: TCustomizerBuilderXML;

    function GetXML(const Feature: TFeature): string; virtual;
  public
    constructor Create(Actions: TCustomizerBuilderXML);
    function MakeActions(const pFeature: IFeature; out pVal: WideString)
      : HResult; stdcall;
    function Get_Images(out pVal: IRasterSet): HResult; stdcall;
    function OnAction(const pFeature: IFeature; const bsAction: WideString
      ; out pDone: WordBool): HResult; stdcall;
  end;

implementation

uses
  SysUtils;

{ TMapControllerCustomizer }

constructor TMapControllerCustomizer.Create(Actions: TCustomizerBuilderXML);
begin
  inherited Create;
  Self.FActions := Actions;
end;

function TMapControllerCustomizer.GetXML(const Feature: TFeature): string;
begin
  Result := Self.FActions.GetXML(Feature);
end;

function TMapControllerCustomizer.Get_Images(out pVal: IRasterSet): HResult;
begin
  try
    pVal := nil;
    Result := S_FALSE;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TMapControllerCustomizer.MakeActions(const pFeature: IFeature;
  out pVal: WideString): HResult;
begin
  try
    Result := S_OK;
    pVal := Self.GetXML(TFeature.Create(pFeature));
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TMapControllerCustomizer.OnAction(const pFeature: IFeature;
  const bsAction: WideString; out pDone: WordBool): HResult;
begin
  try
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

end.
