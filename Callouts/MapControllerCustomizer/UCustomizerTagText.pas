unit UCustomizerTagText;

interface

uses
  UCustomizerTag;

type
  TCustomizerTagText = class(TCustomizerTag)
  protected
    FText: string;
  public
    constructor Create(Text: string);
    function GetXML: string; override;

    property Text: string read FText;
  end;

implementation

uses
  SysUtils;

  { TCustomizerTagText }

constructor TCustomizerTagText.Create(Text: string);
begin
  Self.FText := Text;
end;

function TCustomizerTagText.GetXML: string;
begin
  Result := Format('<text>%s</text>', [Self.Text]);
end;

end.
