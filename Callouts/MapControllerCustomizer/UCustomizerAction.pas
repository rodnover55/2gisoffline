unit UCustomizerAction;

interface

uses
  Generics.Collections, UCustomizerTag;

type
  TCustomizerAction = class(TObjectList<TCustomizerTag>)
    FPlacement: string;
  protected
    function GetTagsXML: string;
  public
    function GetXML: string; virtual;

    property Placement: string read FPlacement write FPlacement ;
  end;

implementation

uses
  SysUtils;

  { TCustomizerAction }

function TCustomizerAction.GetTagsXML: string;
var
  SB: TStringBuilder;
  Tag: TCustomizerTag;
begin
  SB := TStringBuilder.Create;

  try
    for Tag in Self do
    begin
      SB.AppendLine(Tag.GetXML);
    end;

    Result := SB.ToString;
  finally
    FreeAndNil(SB);
  end;
end;

function TCustomizerAction.GetXML: string;
var
  SB: TStringBuilder;
begin
  SB := TStringBuilder.Create;

  try
    SB.AppendFormat('<action_item placement_code="%s">', [Self.Placement])
      .AppendLine;
    SB.AppendLine(Self.GetTagsXML);
    SB.AppendLine('</action_item>');

    Result := SB.ToString;
  finally
    FreeAndNil(SB);
  end;
end;

end.
