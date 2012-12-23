unit UGrymBaseControl;

interface

uses
  GrymCore_TLB;

type
  TGrymBaseControl = class(TInterfacedObject, IControlPlacement
    , IControlAppearance)
  private
    function GetCaption: string;
  protected
    FCaption: string;
    FID: string;
    FDescription: string;
    FRaster: IRaster;

    FPlacement: string;

    FMinWidth: Integer;
    FMaxWidth: Integer;
    FHeightInRow: Integer;
  public
    constructor Create(ID: string; Caption: string; Description: string = '');

    procedure SetPlacement(Value: string);
    function GetPlacement: string;
    function SetIcon(Raster: IRaster): TGrymBaseControl; virtual;

    function SetSize(Min: Integer): TGrymBaseControl; overload;
    function SetSize(Min: Integer; Max: Integer): TGrymBaseControl; overload;
    function SetSize(Min: Integer; Height: Integer; Max: Integer)
      : TGrymBaseControl; overload;

  // IControlPlacement
    function Get_PlacementCode(out pVal: WideString): HResult; stdcall;
  // IControlAppearance
    function Get_Tag(out pVal: WideString): HResult; stdcall;
    function Get_Caption(out pVal: WideString): HResult; stdcall;
    function Get_Description(out pVal: WideString): HResult; stdcall;
    function Get_Icon(out pVal: IUnknown): HResult; stdcall;

    function GetMinWidth: Integer;
    function GetMaxWidth: Integer;
    function GetHeightInRow: Integer;

    property Caption: string read GetCaption;
    property ID: string read FID;
  end;

implementation

uses
  SysUtils, Windows;

{ TGrymBaseControl }

constructor TGrymBaseControl.Create(ID, Caption, Description: string);
begin
  Self.FID := ID;
  Self.FCaption := Caption;
  Self.FDescription := Description;

  Self.FMinWidth := 0;
  Self.FMaxWidth := 0;
  Self.FHeightInRow := 0;
end;

function TGrymBaseControl.GetCaption: string;
begin
  Result := Self.FCaption;
end;

function TGrymBaseControl.GetHeightInRow: Integer;
begin
  Result := Self.FHeightInRow;
end;

function TGrymBaseControl.GetMaxWidth: Integer;
begin
  Result := Self.FMaxWidth;
end;

function TGrymBaseControl.GetMinWidth: Integer;
begin
  Result := Self.FMinWidth
end;

function TGrymBaseControl.GetPlacement: string;
begin
  Result := Self.FPlacement;
end;

function TGrymBaseControl.Get_Caption(out pVal: WideString): HResult;
begin
  try
    pVal := Self.Caption;
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TGrymBaseControl.Get_Description(out pVal: WideString): HResult;
begin
  try
    pVal := Self.FDescription;

    if Self.FDescription = EmptyStr then
    begin
      Result := E_NOTIMPL;
    end
    else
    begin
      Result := S_OK;
    end;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TGrymBaseControl.Get_Icon(out pVal: IInterface): HResult;
begin
  try
    pVal := Self.FRaster;
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TGrymBaseControl.Get_PlacementCode(out pVal: WideString): HResult;
begin
  try
    pVal := Self.GetPlacement;
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TGrymBaseControl.Get_Tag(out pVal: WideString): HResult;
begin
  try
    pVal := Self.FID;
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TGrymBaseControl.SetIcon(Raster: IRaster): TGrymBaseControl;
begin
  Self.FRaster := Raster;
  Result := Self;
end;

procedure TGrymBaseControl.SetPlacement(Value: string);
begin
  Self.FPlacement := Value;
end;

function TGrymBaseControl.SetSize(Min: Integer): TGrymBaseControl;
begin
  Result := Self.SetSize(Min, Min);
end;

function TGrymBaseControl.SetSize(Min, Max: Integer): TGrymBaseControl;
begin
  Self.FMinWidth := Min;
  Self.FMaxWidth := Max;

  Result := Self;
end;

function TGrymBaseControl.SetSize(Min, Height, Max: Integer): TGrymBaseControl;
begin
  Self.FMinWidth := Min;
  Self.FMaxWidth := Max;
  Self.FHeightInRow := Height;

  Result := Self;
end;

end.
