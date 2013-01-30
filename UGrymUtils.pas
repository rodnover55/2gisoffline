unit UGrymUtils;

interface

uses
  UMapPoint;

procedure ShowCallout(Point: TMapPoint; Text: string; Tag: string = '');
procedure CloseCallout(Tag: string);

implementation

uses
  UGrymPlugin, UCallout, GrymCore_TLB, SysUtils, UGrymGraphic, UCalloutTab;

procedure CloseCallout(Tag: string);
var
  Graphic: IGraphicBase;
begin
  Graphic := TGrymPlugin.GetInstance.BaseViewThread.GetFrame
    .GetMap.GraphicByTag(Tag);

  if Assigned(Graphic) then
  begin
    TGrymPlugin.GetInstance.BaseViewThread.GetFrame
      .GetMap.RemoveGraphic(Graphic);
  end;
end;

procedure ShowCallout(Point: TMapPoint; Text: string; Tag: string = '');
var
  Callout: TCallout;
  Tab: TCalloutTab;
begin

  if Tag <> EmptyStr then
  begin
    CloseCallout(Tag);
  end;

  Callout := TGrymPlugin.GetInstance.BaseViewThread.GetFrame
    .GetMap.CreateCallout(Point);

  Callout.AddCloseButton;

  if Tag <> EmptyStr then
  begin
    Callout.SetTag(Tag);
  end;

  Tab := Callout.AddTab(' ');

  Tab.Body := Text;
  Tab.SetHTML;

  TGrymPlugin.GetInstance.BaseViewThread.GetFrame.GetMap
    .AddGraphic(Callout.GetInterface);
end;

end.
