unit UFeature;

interface

uses
  UInterfaceWrapper, GrymCore_TLB, UMapPoint;

type
  TFeature = class(TInterfaceWrapper<IFeature>)
  public
    function CenterPoint: TMapPoint;
    function GetID: Integer;
    function GetType: string;
    function GetValue(Name: string): Variant;

    function IsMapBuilding: Boolean;
  end;

implementation

uses
  ComObj;
{ TFeature }

function TFeature.CenterPoint: TMapPoint;
var
  pMapPoint: IMapPoint;
begin
  OleCheck(Self.GetInterface.Get_CenterPoint(pMapPoint));
  Result := TMapPoint.Create(pMapPoint);
end;

function TFeature.GetID: Integer;
begin
  OleCheck((Self.GetInterface as IDataRow).Get_Index(Result));
end;

function TFeature.GetType: string;
var
  Str: WideString;
begin
  OleCheck((Self.GetInterface as IDataRow).Get_type_(Str));
  Result := Str;
end;

function TFeature.GetValue(Name: string): Variant;
var
  Value: OleVariant;
  IntVal: Integer;
begin
  OleCheck((Self.GetInterface as IDataRow).Get_Value(Name, Value));
  if TVarData(Value).VType <> 22 then
  begin
    Result := Value;
  end
  else
  begin
    IntVal := Value;
    Result := IntVal;
  end;
end;

function TFeature.IsMapBuilding: Boolean;
begin
  Result := (Self.GetType = 'grym_map_building');
end;

end.
