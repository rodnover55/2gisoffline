unit URTTIAttributes;

interface
uses
  Rtti;

type
  RTTIAttributes = class
    class function Get<T: TCustomAttribute>(Obj: TRttiObject): T; static;
  end;

implementation

{ RTTIAttributes }

class function RTTIAttributes.Get<T>(Obj: TRttiObject): T;
var
 Attr: TCustomAttribute;
begin
  for Attr in Obj.GetAttributes do
  begin
    if Attr is T then
    begin
      Exit(T(Attr));
    end;
 end;
 Result := nil;
end;

end.
