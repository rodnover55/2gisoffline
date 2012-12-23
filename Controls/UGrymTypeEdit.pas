unit UGrymTypeEdit;

interface

uses
  UGrymBaseControl, GrymCore_TLB, UGrymControl;

type
  TGrymTypeEdit = class(TGrymBaseControl, IContainerControl)
  private
    FWidth: Integer;
    FHeight: Integer;
    Control: TGrymControl;
    FInterface: IGrymControlEdit;
    FReadOnly: Boolean;
  public
    constructor Create(ID: string; Caption: string; Description: string = '');
  // IContainerControl
    function Get_InternalControl(out pVal: IUnknown): HResult; stdcall;
  end;

implementation

uses
  SysUtils, UGrymPlugin, ComObj;
{ TGrymTypeEdit }

constructor TGrymTypeEdit.Create(ID, Caption, Description: string);
begin
  inherited;
  Self.FWidth := 0;
  Self.FHeight := 0;
  Self.FReadOnly := False;
end;

function TGrymTypeEdit.Get_InternalControl(out pVal: IInterface): HResult;
begin
  try
    FreeAndNil(Self.Control);
    Self.Control := TGrymPlugin.GetInstance.BaseViewThread.GetFactory
      .GetFactory2.CreateGrymControl(GrymControlTypeEdit);

    try
      if Self.FWidth > 0 then
      begin
        Control.SetWidth(Self.FWidth);
      end;

      if Self.FHeight > 0 then
      begin
        Control.SetHeight(Self.FHeight);
      end;

      Self.FInterface := Self.Control.GetInterface as IGrymControlEdit;
      OleCheck(Self.FInterface.Set_ReadOnly(Self.FReadOnly));

      if Caption <> EmptyStr then
      begin
        Self.Control.SetStyle(GrymControlStyleCaption);
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

end.
