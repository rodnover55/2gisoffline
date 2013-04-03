unit UMapTools;

interface

uses
  UInterfaceWrapper, GrymCore_TLB, UGrymBaseTool, UGrymToolRadius;

type
  TMapTools = class(TInterfaceWrapper<IMapTools>)
  public
    procedure AddTool(Tool: TGrymBaseTool);
    procedure SetCurrentTool(Tool: TGrymBaseTool);
    function GetRadiusTool: TGrymToolRadius;
    procedure SetDefaultTool;

    function IsCurrentTool(Tool: IToolBase): Boolean;
    function FindTool(Tag: string): IToolBase;
  end;

implementation

uses
  ComObj;

{ TMapTools }

procedure TMapTools.AddTool(Tool: TGrymBaseTool);
begin
  OleCheck(Self.GetInterface.AddTool(Tool));
end;

function TMapTools.FindTool(Tag: string): IToolBase;
begin
  OleCheck(Self.GetInterface.FindTool(Tag, Result));
end;

function TMapTools.GetRadiusTool: TGrymToolRadius;
begin
  Result := TGrymToolRadius.Create(Self
      .FindTool('RADIUS_TOOL') as IGrymToolRadius);
end;

function TMapTools.IsCurrentTool(Tool: IToolBase): Boolean;
var
  CurrentTool: IToolBase;
begin
  OleCheck(Self.GetInterface.Get_CurrentTool(CurrentTool));

  Result := (Tool = CurrentTool);
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
