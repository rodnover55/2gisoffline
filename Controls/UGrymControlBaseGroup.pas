unit UGrymControlBaseGroup;

interface

uses
  GrymCore_TLB, UInterfaceWrapper, Generics.Collections, UGrymCol;

type
  TGrymControlBaseGroup = class(TInterfaceWrapper<IRibbonGroup>)
    FID: string;
    FCaption: string;
    Cols: TObjectList<TGrymCol>;
  protected
    procedure SetPlacements; virtual; abstract;
  public
    constructor Create(ID: string; Caption: string);
    destructor Destroy; override;

    function GetType: Integer; virtual; abstract;

    function AddColumn: TGrymCol;
    function InsertColumn(Index: Integer): TGrymCol;
    procedure DeleteColumn(Index: Integer);

    procedure Fill;

    function GetEnumerator: TEnumerator<TGrymCol>;

    property ID: string read FID;
    property Caption: string read FCaption;
  end;

implementation

uses
  SysUtils, ComObj, UGrymRow;

{ TGrymControlBaseGroup }

function TGrymControlBaseGroup.AddColumn: TGrymCol;
begin
  Result := TGrymCol.Create;
  Self.Cols.Add(Result);
end;

constructor TGrymControlBaseGroup.Create(ID, Caption: string);
begin
  inherited Create;

  Self.FID := ID;
  Self.FCaption := Caption;
  Self.Cols := TObjectList<TGrymCol>.Create;
end;

procedure TGrymControlBaseGroup.DeleteColumn(Index: Integer);
begin
  Self.Cols.Delete(Index);
end;

destructor TGrymControlBaseGroup.Destroy;
begin
  FreeAndNil(Self.Cols);
  inherited;
end;

procedure TGrymControlBaseGroup.Fill;
var
  pControlSet: IControlSet;
  Col: TGrymCol;
  Row: TGrymRow;
  Control: IUnknown;
begin
  OleCheck(Self.GetInterface.QueryInterface(IID_IControlSet, pControlSet));

  for Col in Self do
  begin
    for Row in Col do
    begin
      for Control in Row do
      begin
        OleCheck(pControlSet.AddControl(Control));
      end;
    end;
  end;
end;

// TODO: заменить на Enumerator, который возвращает контролы.
function TGrymControlBaseGroup.GetEnumerator: TEnumerator<TGrymCol>;
begin
  Self.SetPlacements;
  Result := Self.Cols.GetEnumerator;
end;

function TGrymControlBaseGroup.InsertColumn(Index: Integer): TGrymCol;
begin
  Result := TGrymCol.Create;
  Self.Cols.Insert(Index, Result);
end;

end.
