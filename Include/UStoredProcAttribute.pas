unit UStoredProcAttribute;

interface

uses
  UDataFieldAttributes, Rtti;

type
  EDirectionParam = (dpInput, dpOutput);
  EDirectionParamSet = set of EDirectionParam;
  StoredProcAttribute = class(DataFieldAttribute)
  private
    FStoredProcName: string;
    FDirection: EDirectionParamSet;
  public
    constructor Create(FN: string; SPN: string;
      FD: EDirectionParamSet = [dpInput]); overload;

    function IsInput: Boolean;
    function IsOutput: Boolean;

    property StoredProcName: string read FStoredProcName;
    property Direction: EDirectionParamSet read FDirection;

    class function Get(Obj: TRttiObject; SPN: string = '';
        FD: EDirectionParamSet = [dpInput, dpOutput]):
      StoredProcAttribute; static;
  end;

implementation

uses
  SysUtils;

constructor StoredProcAttribute.Create(FN, SPN: string;
  FD: EDirectionParamSet);
begin
  inherited Create(FN);

  FStoredProcName := SPN;
  FDirection := FD;
end;

class function StoredProcAttribute.Get(Obj: TRttiObject;
  SPN: string; FD: EDirectionParamSet): StoredProcAttribute;
var
 Attr: TCustomAttribute;
 F: EDirectionParam;
 PassDirection: Boolean;
begin
  for Attr in Obj.GetAttributes do
  begin
    if Attr is DataFieldAttribute then
    begin
      Result := StoredProcAttribute(Attr);

      PassDirection := False;

      for F in FD do
      begin
        if F in Result.Direction then
        begin
          PassDirection := True;
          Break;
        end;
      end;

      if PassDirection
          and ((SPN = EmptyStr) or (Result.StoredProcName = SPN)) then
        Exit;
    end;
  end;

  Result := nil;
end;

function StoredProcAttribute.IsInput: Boolean;
begin
  Result := dpInput in FDirection;
end;

function StoredProcAttribute.IsOutput: Boolean;
begin
  Result := dpOutput in FDirection;
end;

end.
