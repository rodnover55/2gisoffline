unit UCustomizerActionsList;

interface

uses
  Generics.Collections, UCustomizerAction, GrymCore_TLB, UCustomizerBuilderXML
    , UFeature;

type
  TCustomizerActionsList = class(TCustomizerBuilderXML)
    FPlacement: Integer;
    FActions: TObjectList<TCustomizerAction>;
  protected
    function GetActionsXML: string;
    procedure ClearPlacement;
    function GetNextPlacement: string;
  public
    constructor Create;
    destructor Destroy; override;
    function GetXML(const pFeature: TFeature): string; override;

    property Actions: TObjectList<TCustomizerAction> read FActions;
  end;

implementation

uses
  SysUtils;
{ TCustomizerActionsList }

procedure TCustomizerActionsList.ClearPlacement;
begin
  Self.FPlacement := 1000;
end;

constructor TCustomizerActionsList.Create;
begin
  inherited;

  Self.FActions := TObjectList<TCustomizerAction>.Create;
end;

destructor TCustomizerActionsList.Destroy;
begin
  FreeAndNil(Self.FActions);
  inherited;
end;

function TCustomizerActionsList.GetActionsXML: string;
var
  SB: TStringBuilder;
  Action: TCustomizerAction;
begin
  SB := TStringBuilder.Create;

  try
    Self.ClearPlacement;
    for Action in Self.FActions do
    begin
      Action.Placement := GetNextPlacement;
      SB.AppendLine(Action.GetXML);
    end;

    Result := SB.ToString;
  finally
    FreeAndNil(SB);
  end;


end;

function TCustomizerActionsList.GetNextPlacement: string;
begin
  Self.FPlacement := Self.FPlacement + 1;
  Result := IntToStr(Self.FPlacement);
end;

function TCustomizerActionsList.GetXML(const pFeature: TFeature): string;
var
  SB: TStringBuilder;
begin
  SB := TStringBuilder.Create;

  try
    SB.AppendLine('<action_list>');
    SB.AppendLine(Self.GetActionsXML);
    SB.AppendLine('</action_list>');

    Result := SB.ToString;
  finally
    FreeAndNil(SB);
  end;
end;

end.
