unit UDataSetFiller;

interface

uses
  DB, pFIBStoredProc;

type
  TDataSetFiller<T: class> = class
  public
    class procedure FillObject(DataSet: TDataSet; Obj: T);
    class function ExecProcedure(DataSet: TpFIBStoredProc; Obj: T): Boolean;
    class procedure FillStoredProcParams(DataSet: TpFIBStoredProc; Obj: T);
    class procedure ReturnStoredProcParams(DataSet: TpFIBStoredProc; Obj: T);
  end;

implementation

uses
  Rtti, UDataFieldAttributes, URTTIAttributes, TypInfo, Variants, UStoredProcAttribute;

{ TDataSetFiller<T> }

class function TDataSetFiller<T>.ExecProcedure(DataSet: TpFIBStoredProc;
  Obj: T): Boolean;
begin
  TDataSetFiller<T>.FillStoredProcParams(DataSet, Obj);

  try
    DataSet.ExecProc;
    TDataSetFiller<T>.ReturnStoredProcParams(DataSet, Obj);
    Result := True;
  finally
    DataSet.Close;
  end;
end;

class procedure TDataSetFiller<T>.FillObject(DataSet: TDataSet; Obj: T);
var
  ctx: TRttiContext;
  objType: TRttiType;
  Field: TRttiField;
  Prop: TRttiProperty;
  Attr: DataFieldAttribute;
  FieldRecord: TField;
  oObj: TObject;
  pObj: Pointer;
  Intf: Pointer;
  Intf2: Pointer;
  pInterface: IInterface;
begin
  ctx := TRttiContext.Create;

  objType := ctx.GetType(Obj.ClassInfo);

  oObj := Obj;
  pObj := Pointer(oObj);

  for Prop in objType.GetProperties do
  begin
    Attr := RTTIAttributes.Get<DataFieldAttribute>(Prop);

    if Assigned(Attr) then
    begin
      FieldRecord := DataSet.FindField(Attr.FieldName);

      if Assigned(FieldRecord) then
      begin
        if Prop.PropertyType = ctx.GetType(TypeInfo(Boolean)) then
        begin
          Prop.SetValue(pObj, TValue.From<Boolean>(FieldRecord.AsBoolean))
        end
        else
        begin
          Prop.SetValue(pObj, TValue.FromVariant(FieldRecord.Value));
        end;
      end;
    end;
  end;

  for Field in objType.GetFields do
  begin
    Attr := RTTIAttributes.Get<DataFieldAttribute>(Field);

    if Assigned(Attr) then
    begin
      FieldRecord := DataSet.FindField(Attr.FieldName);

      if Assigned(FieldRecord) then
      begin
        if Field.FieldType = ctx.GetType(TypeInfo(Boolean)) then
        begin
          Field.SetValue(pObj, TValue.From<Boolean>(FieldRecord.AsBoolean))
        end
        else if Field.FieldType.TypeKind = tkInterface then
        begin
          Intf := PByte(pObj) + Field.Offset;
          VarSupports(FieldRecord.Value
            , GetTypeData(Field.FieldType.Handle).Guid
              , pInterface);
          PPointer(Intf)^  := Pointer(pInterface);
          pInterface._AddRef;
        end
        else
        begin
          Field.SetValue(pObj, TValue.FromVariant(FieldRecord.Value));
        end;
      end;
    end;
  end;
end;

class procedure TDataSetFiller<T>.FillStoredProcParams(
  DataSet: TpFIBStoredProc; Obj: T);
var
  ctx: TRttiContext;
  objType: TRttiType;
  Field: TRttiField;
  Prop: TRttiProperty;
  Attr: StoredProcAttribute;
  ParamIndex: Integer;
  oObj: TObject;
  pObj: Pointer;
begin
  ctx := TRttiContext.Create;

  try
    objType := ctx.GetType(Obj.ClassInfo);

    oObj := Obj;
    pObj := Pointer(oObj);

    for Prop in objType.GetProperties do
    begin
      Attr := StoredProcAttribute.Get(Prop, DataSet.StoredProcName, [dpInput]);

      // явл€етс€ ли параметр входным
      if Assigned(Attr) then
        if Attr.IsInput and DataSet.ParamExist(Attr.FieldName, ParamIndex) then
          if Prop.PropertyType = ctx.GetType(TypeInfo(Boolean)) then
            DataSet.SetParamValue(ParamIndex, Prop.GetValue(pObj).AsBoolean)
          else
            DataSet.SetParamValue(ParamIndex, Prop.GetValue(pObj).AsVariant)
    end;

    for Field in objType.GetFields do
    begin
      Attr := StoredProcAttribute.Get(Field, DataSet.StoredProcName, [dpInput]);

      // явл€етс€ ли параметр входным
      if Assigned(Attr) then
      begin
        if Attr.IsInput and DataSet.ParamExist(Attr.FieldName, ParamIndex) then
        begin
          if Field.FieldType = ctx.GetType(TypeInfo(Boolean)) then
          begin
            DataSet.SetParamValue(ParamIndex, Field.GetValue(pObj).AsBoolean)
          end
          else
          begin
            DataSet.SetParamValue(ParamIndex, Field.GetValue(pObj).AsVariant)
          end;
        end;
      end;
    end;
  finally
    ctx.Free;
  end;
end;

class procedure TDataSetFiller<T>.ReturnStoredProcParams(
  DataSet: TpFIBStoredProc; Obj: T);
var
  ctx: TRttiContext;
  objType: TRttiType;
  Field: TRttiField;
  Prop: TRttiProperty;
  Attr: StoredProcAttribute;
  ParamIndex: Integer;
  oObj: TObject;
  pObj: Pointer;
begin
  ctx := TRttiContext.Create;

  try
    objType := ctx.GetType(Obj.ClassInfo);

    oObj := Obj;
    pObj := Pointer(oObj);

    for Prop in objType.GetProperties do
    begin
      Attr := StoredProcAttribute.Get(Prop, DataSet.StoredProcName, [dpOutput]);

      // явл€етс€ ли параметр выходным
      if Assigned(Attr) then
        if Attr.IsOutput and DataSet.FieldExist(Attr.FieldName, ParamIndex) then
          if Prop.PropertyType = ctx.GetType(TypeInfo(Boolean)) then
            Prop.SetValue(pObj,
              TValue.From<Boolean>(DataSet.Fields[ParamIndex].AsBoolean))
          else
            Prop.SetValue(pObj,
              TValue.FromVariant(DataSet.Fields[ParamIndex].Value));
    end;

    for Field in objType.GetFields do
    begin
      Attr := StoredProcAttribute.Get(Field, DataSet.StoredProcName,
        [dpOutput]);

      // явл€етс€ ли параметр выходным
      if Assigned(Attr) then
        if Attr.IsOutput and DataSet.FieldExist(Attr.FieldName, ParamIndex) then
          if Field.FieldType = ctx.GetType(TypeInfo(Boolean)) then
            Field.SetValue(pObj,
              TValue.From<Boolean>(DataSet.Fields[ParamIndex].AsBoolean))
          else
            Field.SetValue(pObj,
              TValue.FromVariant(DataSet.Fields[ParamIndex].Value));
    end;
  finally
    ctx.Free;
  end;
end;

end.
