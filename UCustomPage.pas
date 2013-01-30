unit UCustomPage;

interface

uses
  GrymCore_TLB, UGrymBaseControl, AxCtrls;

type
  TCustomPage = class(TGrymBaseControl, ICustomPage)
  private
    FCanRemove: Boolean;
    FControl: TActiveForm;
  public
    constructor Create(ID, Caption: string; Form: TActiveForm;
      CanRemove: Boolean = False; Description: string = '');
    function CanRemove(out pVal: WordBool): HResult; stdcall;
    function Get_Control(out pVal: IUnknown): HResult; stdcall;
  end;

implementation

uses
  SysUtils;

{ TCustomPage }

function TCustomPage.CanRemove(out pVal: WordBool): HResult;
begin
  try
    pVal := Self.FCanRemove;
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

constructor TCustomPage.Create(ID, Caption: string; Form: TActiveForm;
  CanRemove: Boolean; Description: string);
begin
  inherited Create(ID, Caption, Description);
  Self.FCanRemove := CanRemove;
  Self.FControl := Form;
end;

function TCustomPage.Get_Control(out pVal: IInterface): HResult;
begin
  try
    pVal := Self.FControl as IInterface;
    Result := S_OK;
  except
    ShowException(ExceptObject, ExceptAddr);
    Result := S_FALSE;
  end;
end;

end.
