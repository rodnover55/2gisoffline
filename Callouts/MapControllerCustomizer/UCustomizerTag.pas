unit UCustomizerTag;

interface

type
  TCustomizerTag = class
  public
    function GetXML: string; virtual; abstract;
  end;

implementation

{ TCustomizerTag }

end.
