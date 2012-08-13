unit UGrymControlCheckedButton;

interface

uses
  UGrymControlButton;

type
  TGrymControlCheckedButton = class(TGrymControlButton)
    FChecked: Boolean;
  public
    constructor Create(ID: string; Caption: string; Description: string = '');
    procedure SetChecked(IsChecked: Boolean);
    function GetChecked: Boolean; override;
  end;

implementation

{ TGrymControlCheckedButton }

constructor TGrymControlCheckedButton.Create(ID, Caption, Description: string);
begin
  inherited;
  Self.FChecked := False;
end;

function TGrymControlCheckedButton.GetChecked: Boolean;
begin
  Result := Self.FChecked;
end;

procedure TGrymControlCheckedButton.SetChecked(IsChecked: Boolean);
begin
  Self.FChecked := IsChecked;
end;

end.
