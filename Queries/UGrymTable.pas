unit UGrymTable;

interface

uses
  DB, Classes, Rtti, GrymCore_TLB;

type
// TODO: Выделить методы InternalHandleException InternalInitFieldDefs IsCursorOpen GetTypeField GetFieldData FillObject в базовый класс. От него наследовать TGrymTable и TGrymQuery
  TBaseGrymTable<T: class> = class(TDataSet)
  private
    FTable: ITable;
    FIsOpen: Boolean;
    FIdRow: Integer;
  protected
    procedure InternalHandleException; override;
    procedure InternalInitFieldDefs; override;
    function GetRecord(Buffer: TRecordBuffer; GetMode: TGetMode
      ; DoCheck: Boolean): TGetResult; override;
    procedure InternalOpen; override;
    function IsCursorOpen: Boolean; override;
    procedure InternalClose; override;

    function GetRecordCount: Integer; override;
    function GetRecNo: Integer; override;
    procedure SetRecNo(Value: Integer); override;

    function GetTypeField(Tp: TRttiType): TFieldType;
  public
    function GetFieldData(Field: TField; Buffer: Pointer): Boolean; override;
    function FillObject(Obj: T): Boolean;
    procedure OpenTable(Name: string);
  end;
  TGrymTable = TBaseGrymTable<TObject>;

implementation

uses
  SysUtils, URTTIAttributes, UDataFieldAttributes, UGrymPlugin, ComObj, TypInfo
    , Variants, UGrymMapBuilding;

{ TGrymTable }


function TBaseGrymTable<T>.FillObject(Obj: T): Boolean;
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
  L: ILayer;
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
      FieldRecord := Self.FindField(Attr.FieldName);

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
      FieldRecord := Self.FindField(Attr.FieldName);

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

function TBaseGrymTable<T>.GetFieldData(Field: TField; Buffer: Pointer): Boolean;
var
  Data: OleVariant;
  vDataRow: Variant;
  RecData: string;
  Row: IDataRow;
  Row2: IFeature;
  TypeStr: WideString;
  IdRow: Integer;
begin
  OleCheck(Self.FTable.GetRecord(Self.FIdRow, Row));

  Row.QueryInterface(IID_IFeature, Row2);

  if Field.FieldName = 'id_row' then
  begin
    Row.Get_Index(IdRow);
    Data := IdRow;
  end
  else if Field.FieldName = 'type' then
  begin
    Row.Get_type_(TypeStr);
    Data := TypeStr;
  end
  else if Field.FieldName = 'feature' then
  begin

    vDataRow := Variant(Row2 as IInterface);
  end
  else
  begin
    Row.Get_Value(Field.FieldName, Data);
  end;

  case Field.DataType of
    ftString:
    begin
      RecData := Data;
      StrLCopy(PAnsiChar(Buffer), PAnsiChar(AnsiString(RecData)), Field.Size);
    end;
    ftWideString:
    begin
      RecData := Data;
      StrLCopy(PChar(Buffer), PChar(RecData), Field.Size);
    end;
    ftInteger:
    begin
      PInteger(Buffer)^ := Data;
    end;
    ftVariant:
    begin
      PVariant(Buffer)^ := vDataRow;
    end
    else
    begin
      Assert(False, 'Unsupported field type.');
    end;
  end;
  Result := True;
end;

function TBaseGrymTable<T>.GetRecNo: Integer;
begin
  Result := Self.FIdRow;
end;

function TBaseGrymTable<T>.GetRecord(Buffer: TRecordBuffer; GetMode: TGetMode;
  DoCheck: Boolean): TGetResult;
begin
  Result := grOK;

  case GetMode of
    gmCurrent:
    begin
      if (Self.FIdRow < 1) and (Self.FIdRow > Self.RecordCount) then
      begin
        Result := grError;
      end;
    end;
    gmNext:
    begin
      if (Self.FIdRow >= Self.RecordCount) then
      begin
        Result := grEOF
      end
      else
      begin
        Inc(Self.FIdRow);
      end;
    end;
    gmPrior:
    begin
      if (Self.FIdRow <= 1) then
      begin
        Result := grBOF
      end
      else
      begin
        Dec(Self.FIdRow);
      end;
    end
  end;

  if (Result = grError) and DoCheck then
  begin
    DatabaseError('Error in GetRecord()');
  end;
end;

function TBaseGrymTable<T>.GetRecordCount: Integer;
begin
  OleCheck(Self.FTable.Get_RecordCount(Result));
end;

function TBaseGrymTable<T>.GetTypeField(Tp: TRttiType): TFieldType;
var
  ctx: TRttiContext;
begin
  ctx := TRttiContext.Create;

  if Tp = ctx.GetType(TypeInfo(string)) then
  begin
    Result := ftString;
  end
  else if Tp = ctx.GetType(TypeInfo(Integer)) then
  begin
    Result := ftInteger;
  end
  else if Tp = ctx.GetType(TypeInfo(WideString)) then
  begin
    Result := ftWideString;
  end
  else if Tp.TypeKind = tkInterface then
  begin
    Result := ftVariant;
  end
  else
  begin
    Result := ftUnknown;
  end;
end;

procedure TBaseGrymTable<T>.InternalClose;
begin
  Self.FIsOpen := False;
  Self.BindFields(False);

  if Self.DefaultFields then
  begin
    Self.DestroyFields;
  end;
end;

procedure TBaseGrymTable<T>.InternalHandleException;
begin
 {$IFDEF D6+}
   if Assigned(Classes.ApplicationHandleException) then
    Classes.ApplicationHandleException(Self);
 {$ENDIF}
end;

procedure TBaseGrymTable<T>.InternalInitFieldDefs;
var
  ctx: TRttiContext;
  objType: TRttiType;
  Field: TRttiField;
  Prop: TRttiProperty;
  Attr: DataFieldAttribute;
  FieldRecord: TField;
begin
  Self.FieldDefs.Clear;

  ctx := TRttiContext.Create;

  objType := ctx.GetType(TypeInfo(T));

  for Prop in objType.GetProperties do
  begin
    Attr := RTTIAttributes.Get<DataFieldAttribute>(Prop);

    if Assigned(Attr) then
    begin
      if Self.FieldDefs.IndexOf(Attr.FieldName) = -1 then
      begin
        Self.FieldDefs.Add(Attr.FieldName
          , Self.GetTypeField(Prop.PropertyType), Attr.Size, Attr.Required);
      end;
    end;
  end;

  for Field in objType.GetFields do
  begin
    Attr := RTTIAttributes.Get<DataFieldAttribute>(Field);

    if Assigned(Attr) then
    begin
      if Self.FieldDefs.IndexOf(Attr.FieldName) = -1 then
      begin
        Self.FieldDefs.Add(Attr.FieldName
          , Self.GetTypeField(Field.FieldType), Attr.Size, Attr.Required);
      end;
    end;
  end;
end;

procedure TBaseGrymTable<T>.InternalOpen;
begin
  Self.InternalInitFieldDefs;
  if Self.DefaultFields then
  begin
    Self.CreateFields;
  end;

  Self.BindFields(True);
  Self.FIsOpen := True;
end;

function TBaseGrymTable<T>.IsCursorOpen: Boolean;
begin
  Result := FIsOpen;
end;

procedure TBaseGrymTable<T>.OpenTable(Name: string);
begin
  OleCheck(TGrymPlugin.GetInstance.BaseViewThread.GetDatabase
    .GetInterface.Get_Table(Name, Self.FTable));
  Self.Open;
end;

procedure TBaseGrymTable<T>.SetRecNo(Value: Integer);
begin
  Self.FIdRow := Value;
end;

end.
