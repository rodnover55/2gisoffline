unit UDataFieldAttributes;

interface

uses
  Rtti, SysUtils;

type
  DataFieldAttribute = class(TCustomAttribute)
  private
    FFieldName: string;
    FSize: Integer;
    FRequired: Boolean;
  public
    constructor Create(FN: string; Size: Integer = 0
      ; Required: Boolean = False);

    property FieldName: string read FFieldName;
    property Size: Integer read FSize;
    property Required: Boolean read FRequired;
  end;

implementation

{ DataFieldAttribute }

constructor DataFieldAttribute.Create(FN: string; Size: Integer = 0
  ; Required: Boolean = False);
begin
  Self.FFieldName := FN;
  Self.FSize := Size;
  Self.FRequired := Required;
end;

end.
