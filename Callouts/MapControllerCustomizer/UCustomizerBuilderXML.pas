unit UCustomizerBuilderXML;

interface

uses
  GrymCore_TLB, UFeature;

type
  TCustomizerBuilderXML = class
  public
    function GetXML(const pFeature: TFeature): string; virtual; abstract;
  end;
implementation

end.
