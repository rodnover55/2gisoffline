unit UCustomizerTagTextAction;

interface

uses
  UCustomizerTagText;

type
  TCustomizerTagTextAction = class(TCustomizerTagText)
    FAction: string;
  public
    constructor Create(Text: string; Action: string);
    function GetXML: string; override;
  end;

implementation

uses
  SysUtils;
{ TCustomizerTagTextAction }

constructor TCustomizerTagTextAction.Create(Text, Action: string);
begin
  inherited Create(Text);
  Self.FAction := Action;
end;

function TCustomizerTagTextAction.GetXML: string;
begin
  Result := Format('<text action_code="%s">%s</text>'
    , [Self.FAction, Self.Text]);
end;

end.
