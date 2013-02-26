unit UGrymMapBuilding;

interface

uses
  UDataFieldAttributes, GrymCore_TLB, UFeature;

type
  TGrymMapBuilding = class
  [DataField('id_row')]
    IdRow: Integer;
  [DataField('type', 512)]
    TypeRow: string;
  [DataField('post_index', 512)]
    PostIndex: string;
  [DataField('addr_count')]
    AddressCount: Integer;
  [DataField('street_1', 512)]
    Street: string;
  [DataField('number_1', 512)]
    Number: string;
  [DataField('city', 512)]
    City: string;
  [DataField('feature')]
    Feature: IFeature;
  [DataField('purpose', 512)]
    Purpose: string;
  [DataField('levels')]
    Levels: Integer;

    constructor Create(Feature: TFeature); overload;
  end;

implementation

uses
  SysUtils, URTTIAttributes, ComObj, TypInfo
    , Variants, Rtti;

{ TGrymMapBuilding }

constructor TGrymMapBuilding.Create(Feature: TFeature);
var
  ctx: TRttiContext;
  objType: TRttiType;
  Field: TRttiField;
  Prop: TRttiProperty;
  Attr: DataFieldAttribute;
  FieldRecord: Variant;
  oObj: TObject;
  pObj: Pointer;
  Intf: Pointer;
  Intf2: Pointer;
  pInterface: IInterface;
  L: ILayer;
begin
  ctx := TRttiContext.Create;

  objType := ctx.GetType(Self.ClassInfo);

  oObj := Self;
  pObj := Pointer(oObj);

  for Prop in objType.GetProperties do
  begin
    Attr := RTTIAttributes.Get<DataFieldAttribute>(Prop);

    if Assigned(Attr) then
    begin
      try
        FieldRecord := Feature.GetValue(Attr.FieldName);
        Prop.SetValue(pObj, TValue.FromVariant(FieldRecord));
      except
        on EVariantTypeCastError do
        begin
        end
        else
        begin
          raise;
        end;
      end;
    end;
  end;

  for Field in objType.GetFields do
  begin
    Attr := RTTIAttributes.Get<DataFieldAttribute>(Field);

    if Assigned(Attr) then
    begin
      try
        FieldRecord := Feature.GetValue(Attr.FieldName);

        Field.SetValue(pObj, TValue.FromVariant(FieldRecord));
      except
        on EVariantTypeCastError do
        begin
        end
        else
        begin
          raise;
        end;
      end;
    end;
  end;
end;

end.
