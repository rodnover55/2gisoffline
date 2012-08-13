unit UGrymControlExtendedGroup;

interface

uses
  UGrymControlBaseGroup, UGrymBaseControl;

type
  TGrymControlExtendedGroup = class(TGrymControlBaseGroup)
  protected
    procedure SetPlacements; override;
    function PlacementSize(Control: TGrymBaseControl): string;
    function PlacementPosition(Col: Integer; Row: Integer; Order: Integer)
      : string;
  public
    function GetType: Integer; override;
  end;

implementation

uses
  GrymCore_TLB, UGrymCol, UGrymRow, SysUtils;

{ TGrymControlExtendedGroup }

function TGrymControlExtendedGroup.GetType: Integer;
begin
  Result := RibbonGroupTypeEx;
end;

function TGrymControlExtendedGroup.PlacementPosition(
  Col: Integer; Row: Integer; Order: Integer): string;
var
  Placement: TStringBuilder;
const
  PLACEMENT_FORMAT_COLUMN = '200%d:KH';
  PLACEMENT_FORMAT_ROW = '200%d:KH';
begin
  Placement := TStringBuilder.Create;

  try
    Placement.Append('<position ')
      .Append('column_id = "').AppendFormat(PLACEMENT_FORMAT_COLUMN, [Col])
      .Append('" ')
      .Append('row_id = "').AppendFormat(PLACEMENT_FORMAT_ROW, [Row])
      .Append('" ')
      .Append('order_in_row = "').Append(Order).Append('" ')
      .Append('/>').AppendLine;

    Result := Placement.ToString;
  finally
    FreeAndNil(Placement);
  end;
end;

function TGrymControlExtendedGroup.PlacementSize(
  Control: TGrymBaseControl): string;
var
  Placement: TStringBuilder;
  Min: Integer;
  Max: Integer;
  Height: Integer;
begin
  Placement := TStringBuilder.Create;
  try
    Min := Control.GetMinWidth;
    Max := Control.GetMaxWidth;
    Height := Control.GetHeightInRow;

    if (Min > 0) or (Max > 0) or (Height > 0) then
    begin
      Placement.Append('<size ');
    end;

    if (Min > 0) then
    begin
      Placement.Append('min_width = "').Append(Min).Append('" ');
    end;

    if (Max > 0) then
    begin
      Placement.Append('max_width = "').Append(Max).Append('" ');
    end;

    if (Height > 0) then
    begin
      Placement.Append('height_in_rows  = "').Append(Height).Append('" ');
    end;

    if (Min > 0) or (Max > 0) or (Height > 0) then
    begin
      Placement.Append('/>').AppendLine;
    end;
    Result := Placement.ToString;
  finally
     FreeAndNil(Placement);
  end;
end;

procedure TGrymControlExtendedGroup.SetPlacements;
var
  I: Integer;
  J: Integer;
  K: Integer;
  Col: TGrymCol;
  Row: TGrymRow;
  Control: TGrymBaseControl;
  Placement: TStringBuilder;
begin
  inherited;

  for I := 0 to Self.Cols.Count - 1 do
  begin
    Col := Self.Cols[I];
    for J := 0 to Col.Rows.Count - 1 do
    begin
      Row := Col.Rows[J];
      for K := 0 to Row.Controls.Count - 1 do
      begin
        Control := Row.Controls[K] as TGrymBaseControl;
        Placement := TStringBuilder.Create;
        try
          Placement.Append('<control_pos>').AppendLine
            .Append(Self.PlacementSize(Control))
            .Append(Self.PlacementPosition(I, J, K))
            .Append('</control_pos>');

          Control.SetPlacement(Placement.ToString);
        finally
          FreeAndNil(Placement);
        end;
      end;
    end;
  end;
end;

end.
