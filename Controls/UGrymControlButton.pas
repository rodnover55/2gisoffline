unit UGrymControlButton;

interface

uses
  GrymCore_TLB, UBaseController, UGrymBaseControl, UBaseBooleanController;

type
  TGrymControlButton = class(TGrymBaseControl, ICommandAction, ICommandState,
      IPropertySet)
  private
    FController: TBaseController;
    FAvailableController: TBaseBooleanController;
    FEnabled: Boolean;
    FCaptionBelow: Boolean;
  public
    constructor Create(ID: string; Caption: string; Description: string = '');
    destructor Destroy; override;


    function SetController(Controller: TBaseController): TGrymControlButton;
    function SetAvailableEvent(Controller
      : TBaseBooleanController): TGrymControlButton;

    function GetChecked: Boolean; virtual;
    function GetEnabled: Boolean; virtual;
    function SetEnabled(Value: Boolean): Boolean; virtual;
    property CaptionBelow: Boolean read FCaptionBelow write FCaptionBelow;
  // ICommandAction
    function OnCommand: HResult; stdcall;
  // ICommandState
    function Get_Available(out pVal: WordBool): HResult; stdcall;
    function Get_Enabled(out pVal: WordBool): HResult; stdcall;
    function Get_Checked(out pVal: WordBool): HResult; stdcall;
  // IPropertySet
    function Get_Property_(const bsPropertyName: WideString; out pVal: OleVariant): HResult; stdcall;
    function Set_Property_(const bsPropertyName: WideString; pVal: OleVariant): HResult; stdcall;
  end;

implementation

uses
  SysUtils;
{ TGrymControlButton }

constructor TGrymControlButton.Create(ID: string; Caption: string;
  Description: string = '');
begin
  inherited;
  Self.FController := nil;
  Self.FAvailableController := nil;
  Self.FEnabled := True;
  Self.FCaptionBelow := False;
end;

destructor TGrymControlButton.Destroy;
begin
  FreeAndNil(Self.FController);
  FreeAndNil(Self.FAvailableController);
  inherited;
end;

function TGrymControlButton.GetChecked: Boolean;
begin
  Result := False;
end;

function TGrymControlButton.GetEnabled: Boolean;
begin
  Result := Self.FEnabled;
end;

function TGrymControlButton.Get_Available(out pVal: WordBool): HResult;
begin
  try
    if Assigned(Self.FAvailableController) then
    begin
      pVal := Self.FAvailableController.Execute;
    end
    else
    begin
      pVal := True;
    end;
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TGrymControlButton.Get_Checked(out pVal: WordBool): HResult;
begin
  try
    pVal := Self.GetChecked;
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TGrymControlButton.Get_Enabled(out pVal: WordBool): HResult;
begin
  try
    pVal := Self.GetEnabled;
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TGrymControlButton.Get_Property_(const bsPropertyName: WideString;
  out pVal: OleVariant): HResult;
begin
  try
    if bsPropertyName = 'Grym.ButtonStyle' then
    begin
      if Assigned(Self.FRaster) and (Self.FCaption <> EmptyStr) then
      begin
        if Self.FCaptionBelow then
        begin
          pVal := GrymControlStyleIconAndCaptionBelow;
        end
        else
        begin
          pVal := GrymControlStyleIconAndCaption;
        end;
      end
      else if Self.FCaption <> EmptyStr then
      begin
        pVal := GrymControlStyleCaption
      end
      else if Assigned(Self.FRaster) then
      begin
        pVal := GrymControlStyleIcon
      end;
    end;
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TGrymControlButton.OnCommand: HResult;
begin
  try
    if Assigned(Self.FController) then
    begin
      Self.FController.Execute;
    end;
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TGrymControlButton.SetAvailableEvent(
  Controller: TBaseBooleanController): TGrymControlButton;
begin
  Self.FAvailableController := Controller;
  Result := Self;
end;

function TGrymControlButton.SetController(
  Controller: TBaseController): TGrymControlButton;
begin
  FreeAndNil(Self.FController);
  Self.FController := Controller;
  Result := Self;
end;

function TGrymControlButton.SetEnabled(Value: Boolean): Boolean;
begin
  Self.FEnabled := Value;
  Result := True;
end;

function TGrymControlButton.Set_Property_(const bsPropertyName: WideString;
  pVal: OleVariant): HResult;
begin
  try
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

end.
