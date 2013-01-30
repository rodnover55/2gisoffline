unit UBaseActivateToolController;

interface

uses
  UBaseController, UGrymBaseTool;

type
  TBaseActivateToolController<T: TGrymBaseTool> = class(TBaseController)
  private
    FTool: T;
  public
    constructor Create(Tool: T);
    procedure Execute; override;
  end;

implementation

uses
  UGrymPlugin;

{ TCoordGridActivateController<T> }

constructor TBaseActivateToolController<T>.Create(Tool: T);
begin
  inherited Create;
  Self.FTool := Tool;
end;

procedure TBaseActivateToolController<T>.Execute;
begin
  if not Self.FTool.GetActive then
  begin
    TGrymPlugin.GetInstance.BaseViewThread.GetFrame.GetMap
      .GetTools.SetCurrentTool(Self.FTool);
  end
  else
  begin
    TGrymPlugin.GetInstance.BaseViewThread.GetFrame.GetMap
      .GetTools.SetDefaultTool;
  end;
end;

end.
