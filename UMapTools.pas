unit UMapTools;

interface

uses
  UInterfaceWrapper, GrymCore_TLB, UGrymBaseTool;

type
  TMapTools = class(TInterfaceWrapper<IMapTools>)
  public
    procedure AddTool(Tool: TGrymBaseTool);
    procedure SetCurrentTool(Tool: TGrymBaseTool);
    procedure SetDefaultTool;
  end;

implementation

uses
  ComObj;

{ TMapTools }

procedure TMapTools.AddTool(Tool: TGrymBaseTool);
begin
  OleCheck(Self.GetInterface.AddTool(Tool));
end;

procedure TMapTools.SetCurrentTool(Tool: TGrymBaseTool);
begin
  OleCheck(Self.GetInterface._Set_CurrentTool(Tool));
end;

procedure TMapTools.SetDefaultTool;
begin
  OleCheck(Self.GetInterface.SetDefaultTool);
end;

end.
