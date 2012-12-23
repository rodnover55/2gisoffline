unit UGrymComboBox;

interface

uses
  UGrymBaseControl, GrymCore_TLB, UGrymControl, ActiveX, Generics.Collections
    , UBaseController;

// TODO: TBaseController заменить на TDispController, для передачи параметров
// интерфейсов

type
// IUnknown указывается, чтобы переопределить QueryInterface
  TControllerDispMap = TObjectDictionary<Integer, TBaseController>;
  TGrymComboBox = class(TGrymBaseControl, IContainerControl, IUnknown, IDispatch)
    FWidth: Integer;
    FHeight: Integer;
    Control: TGrymControl;
    Fixed: Boolean;
    FInterface: IGrymControlComboBox;
    FPoint: IConnectionPoint;
    FCookie: Integer;

    FControllers: TControllerDispMap;
  public
    const CONTROLLER_EDIT_CHANGE_ID: Integer = 1;
    const CONTROLLER_SEL_CHANGE_ID: Integer = 2;
    const CONTROLLER_DROP_DOWN_ID: Integer = 3;
    const CONTROLLER_CLOSE_UP_ID: Integer = 4;
    const CONTROLLER_KEY_DOWN_ID: Integer = 5;

    constructor Create(ID: string; Caption: string; Description: string = '');
    destructor Destroy; override;
  // IContainerControl
    function Get_InternalControl(out pVal: IUnknown): HResult; stdcall;
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

    function SetWidth(Width: Integer): TGrymComboBox;
    function SetHeight(Height: Integer): TGrymComboBox;
    function SetFixed(IsFixed: Boolean): TGrymComboBox;

    function AddString(Item: string; Data: Variant): Integer;
    function InsertString(Index: Integer; Item: string; Data: Variant): Integer;
    procedure DeleteString(Index: Integer);

    function Count: Integer;
    procedure Select(Index: Integer);
    function Selected: Integer;
    function GetString(Index: Integer): string;
    function GetData(Index: Integer): Variant;

    function SetController(DispID: Integer
      ; Controller: TBaseController): TGrymComboBox;

    function SetSelChangeController(Controller: TBaseController): TGrymComboBox;
    //    	[id(1)] void OnEditChanged(void);
//	[id(2)] void OnSelChanged(void);
//	[id(3)] void OnDropDown(void);
//	[id(4)] void OnCloseUp(void);
//	[id(5)] void OnKeyDown([in] LONG nChar, [in] IStatusFeedback *pHandled);

  end;

implementation

uses
  SysUtils, ComObj, Windows, UGrymPlugin;

{ TGrymComboBox }

function TGrymComboBox.AddString(Item: string; Data: Variant): Integer;
begin
  OleCheck(Self.FInterface.AddString(Item, Data, Result));
end;

function TGrymComboBox.Count: Integer;
begin
  OleCheck(Self.FInterface.Get_Count(Result));
end;

constructor TGrymComboBox.Create(ID, Caption, Description: string);
begin
  inherited;
  Self.FWidth := 0;
  Self.FHeight := 0;
  Self.Fixed := True;
  Self.FControllers := TControllerDispMap.Create;
end;

procedure TGrymComboBox.DeleteString(Index: Integer);
begin
  OleCheck(Self.FInterface.DeleteString(Index));
end;

destructor TGrymComboBox.Destroy;
begin
  if Assigned(Self.FPoint) then
  begin
    Self.FPoint.Unadvise(Self.FCookie);
    Self.FPoint := nil;
  end;

  FreeAndNil(Self.FControllers);

  inherited;
end;

function TGrymComboBox.GetData(Index: Integer): Variant;
var
  Data: OleVariant;
begin
  OleCheck(Self.FInterface.GetData(Index, Data));
  Result := Data;
end;

function TGrymComboBox.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
begin
  try
    Result := E_NOTIMPL;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TGrymComboBox.GetString(Index: Integer): string;
var
  Str: WideString;
begin
  OleCheck(Self.FInterface.GetString(Index, Str));
  Result := Str;
end;

function TGrymComboBox.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  try
    Result := E_NOTIMPL;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TGrymComboBox.GetTypeInfoCount(out Count: Integer): HResult;
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

function TGrymComboBox.Get_InternalControl(out pVal: IInterface): HResult;
var
  pCont: IConnectionPointContainer;
begin
  try
    FreeAndNil(Self.Control);
    Self.Control := TGrymPlugin.GetInstance.BaseViewThread.GetFactory
      .GetFactory2.CreateGrymControl(GrymControlTypeComboBox);
    try
      if Self.FWidth > 0 then
      begin
        Control.SetWidth(Self.FWidth);
      end;

      if Self.FHeight > 0 then
      begin
        Control.SetHeight(Self.FHeight);
      end;

      Self.FInterface := Self.Control.GetInterface as IGrymControlComboBox;

      if Self.Fixed then
      begin
        OleCheck(Self.FInterface.Set_ComboBoxStyle(ComboBoxStyleDropDownList));
      end
      else
      begin
        OleCheck(Self.FInterface.Set_ComboBoxStyle(ComboBoxStyleDropDown));
      end;

      OleCheck(Self.Control.GetInterface
        .QueryInterface(IConnectionPointContainer, pCont));

      if Assigned(pCont) then
      begin
{$WARN SYMBOL_PLATFORM OFF}
        pCont.FindConnectionPoint(_IGrymControlComboBoxEvents, Self.FPoint);
{$WARN SYMBOL_PLATFORM ON}
        if Assigned(Self.FPoint) then
        begin
          FPoint.Advise(Self as IUnknown, Self.FCookie);
        end;
      end;

      pVal := Self.Control.GetInterface;
    finally
      FreeAndNil(Control);
    end;


    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TGrymComboBox.InsertString(Index: Integer; Item: string;
  Data: Variant): Integer;
begin
  OleCheck(Self.FInterface.InsertString(Item, Index, Data, Result));
end;

function TGrymComboBox.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HResult;
begin
  try
    if Self.FControllers.ContainsKey(DispID) then
    begin
      Self.FControllers[DispID].Execute;
      Result := S_OK;
    end
    else
    begin
      Result := E_NOTIMPL;
    end;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TGrymComboBox.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  try
    if IsEqualGUID(IID, DIID__IGrymControlComboBoxEvents) then
    begin
      if GetInterface(IDispatch, Obj) then
      begin
        Result := S_OK;
      end
      else
      begin
        Result := S_FALSE;
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

function TGrymComboBox.SetHeight(Height: Integer): TGrymComboBox;
begin
  Self.FHeight := Height;
  Result := Self;
end;

function TGrymComboBox.SetSelChangeController(
  Controller: TBaseController): TGrymComboBox;
begin
  Result := Self.SetController(CONTROLLER_SEL_CHANGE_ID, Controller);
end;

procedure TGrymComboBox.Select(Index: Integer);
begin
  OleCheck(Self.FInterface.Set_CurSel(Index));
end;

function TGrymComboBox.Selected: Integer;
begin
  OleCheck(Self.FInterface.Get_CurSel(Result));
end;

function TGrymComboBox.SetController(DispID: Integer;
  Controller: TBaseController): TGrymComboBox;
begin
  Self.FControllers.AddOrSetValue(DispID, Controller);
  Result := Self;
end;

function TGrymComboBox.SetFixed(IsFixed: Boolean): TGrymComboBox;
begin
  Self.Fixed := IsFixed;
  Result := Self;
end;

function TGrymComboBox.SetWidth(Width: Integer): TGrymComboBox;
begin
  Self.FWidth := Width;
  Result := Self;
end;

end.

