unit UGrymGraphic;

interface

uses
  GrymCore_TLB, UMapDevice;

type
  TGrymGraphic = class(TInterfacedObject, IGraphicBase, IGraphicCustom)
  protected
    FID: string;
    procedure InnerDraw(const Device: TMapDevice); virtual;
  public
    constructor Create(Tag: string);
    function Get_Tag(out pVal: WideString): HResult; stdcall;
    function Set_Tag(const pVal: WideString): HResult; stdcall;
    function OnRemove: HResult; stdcall;
    function Draw(const pDevice: IMapDevice): HResult; stdcall;
    function GetBoundRect(const pDevice: IMapDevice; out ppDevExt: IDevRect): HResult; stdcall;
    function IsMapPointInside(const pPos: IMapPoint; out pVal: WordBool): HResult; stdcall;
  end;

implementation

uses
  SysUtils;

{ TGrymGraphic }

constructor TGrymGraphic.Create(Tag: string);
begin
  Self.FID := Tag;
end;

function TGrymGraphic.Draw(const pDevice: IMapDevice): HResult;
begin
  try
    Result := S_OK;
    Self.InnerDraw(TMapDevice.Create(pDevice));
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TGrymGraphic.GetBoundRect(const pDevice: IMapDevice;
  out ppDevExt: IDevRect): HResult;
begin
  try
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TGrymGraphic.Get_Tag(out pVal: WideString): HResult;
begin
  try
    Result := S_OK;
    pVal := Self.FID;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

procedure TGrymGraphic.InnerDraw(const Device: TMapDevice);
begin
end;

function TGrymGraphic.IsMapPointInside(const pPos: IMapPoint;
  out pVal: WordBool): HResult;
begin
  try
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TGrymGraphic.OnRemove: HResult;
begin
  try
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

function TGrymGraphic.Set_Tag(const pVal: WideString): HResult;
begin
  try
    Result := S_OK;
    Self.FID := pVal;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

end.
