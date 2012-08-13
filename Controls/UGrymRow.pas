unit UGrymRow;

interface

uses
  Generics.Collections;

type
  TGrymRow = class
    Controls: TList<IUnknown>;
  public
    constructor Create;
    destructor Destroy; override;

    function Add(Control: IUnknown): Integer;
    procedure Insert(Index: Integer; Control: IUnknown);
    procedure Delete(Index: Integer);

    function GetEnumerator: TEnumerator<IUnknown>;
  end;

implementation

uses
  SysUtils;

{ TGrymRow }

function TGrymRow.Add(Control: IInterface): Integer;
begin
  Result := Self.Controls.Add(Control);
end;

constructor TGrymRow.Create;
begin
  inherited;

  Self.Controls := TList<IUnknown>.Create;
end;

procedure TGrymRow.Delete(Index: Integer);
begin
  Self.Controls.Delete(Index);
end;

destructor TGrymRow.Destroy;
begin
  FreeAndNil(Self.Controls);
  inherited;
end;

function TGrymRow.GetEnumerator: TEnumerator<IUnknown>;
begin
  Result := Self.Controls.GetEnumerator;
end;

procedure TGrymRow.Insert(Index: Integer; Control: IInterface);
begin
  Self.Controls.Insert(Index, Control);
end;

end.
