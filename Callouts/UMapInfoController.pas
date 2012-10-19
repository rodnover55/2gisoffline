unit UMapInfoController;

interface

uses
  GrymCore_TLB, UGrymBaseControl;

type
  TMapInfoController = class(TGrymBaseControl, IMapInfoController)
  public
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
  SysUtils;

{ TMapInfoController }

function TMapInfoController.Check(const pFeature: IFeature;
  out pVal: WordBool): HResult;
begin
  try
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TMapInfoController.Fill(const pFeature: IFeature;
  const pTab: ICalloutTab): HResult;
begin
  try
    Result := S_OK;
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

function TMapInfoController.OnTabAction(const pTab: ICalloutTab;
  const bsActionID: WideString): HResult;
begin
  try
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

end.
