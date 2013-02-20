unit UCalloutTab;

interface

uses
  UInterfaceWrapper, GrymCore_TLB;

type
  TCalloutTab = class(TInterfaceWrapper<ICalloutTab>)
  private
    FStyle: string;
    FBody: string;

    function GetHTML: string;
    function GetBody: string;
    function GetStyles: string;
    procedure SetBody(const Value: string);
    procedure SetStyles(const Value: string);
  public
    procedure SetHTML;
    function GetComputedHTML: string;
    procedure SetTitleIcon(const Image: IRaster);


    property HTML: string read GetHTML;
    property Body: string read GetBody write SetBody;
    property Styles: string read GetStyles write SetStyles;
  end;

implementation

uses
  ComObj, SysUtils;

{ TCalloutTab }

function TCalloutTab.GetBody: string;
begin
  Result := Self.FBody;
end;

function TCalloutTab.GetComputedHTML: string;
var
  HTMLBuilder: TStringBuilder;
begin
  HTMLBuilder := TStringBuilder.Create;

  try
    HTMLBuilder.Append('<html>')
      .Append('<head>')
        .Append('<style type = "text/css">')
          .Append(Self.FStyle)
        .Append('</style>')
      .Append('</head>')
      .Append('<body>')
        .Append(Self.FBody)
      .Append('</body>')
    .Append('</html>');

    Result := HTMLBuilder.ToString;
  finally
    FreeAndNil(HTMLBuilder);
  end;
end;

function TCalloutTab.GetHTML: string;
var
  Text: WideString;
begin
  OleCheck(Self.GetInterface.Get_Text(Text));
  Result := Text;
end;

function TCalloutTab.GetStyles: string;
begin
  Result := Self.FStyle;
end;

procedure TCalloutTab.SetBody(const Value: string);
begin
  Self.FBody := Value;
end;

procedure TCalloutTab.SetHTML;
begin
  OleCheck(Self.GetInterface.Set_Text(Self.GetComputedHTML));
end;

procedure TCalloutTab.SetStyles(const Value: string);
begin
  Self.FStyle := Value;
end;

procedure TCalloutTab.SetTitleIcon(const Image: IRaster);
begin
  OleCheck(Self.GetInterface._Set_TitleIcon(Image));
end;

end.
