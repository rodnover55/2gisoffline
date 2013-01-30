unit UBaseSetActiveController;

interface

uses
  UBaseController, UGrymControlCheckedButton, UGrymBaseTool;

type
  TBaseSetActiveController<T: TGrymBaseTool; B: TGrymControlCheckedButton> = class(TBaseController)
  private
    FControl: B;
    FTool: T;
  public
    constructor Create(Control: B; Tool: T);
    procedure Execute; override;
  end;

implementation

{ TBaseSetActiveController<T, B> }

constructor TBaseSetActiveController<T, B>.Create(Control: B; Tool: T);
begin
  inherited Create;
  Self.FControl := Control;
  Self.FTool := Tool;
end;

procedure TBaseSetActiveController<T, B>.Execute;
begin
  inherited;
  Self.FControl.SetChecked(Self.FTool.GetActive);
end;

end.
