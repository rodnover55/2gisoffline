unit UCustomPageCollection;

interface

uses
  UInterfaceWrapper, GrymCore_TLB, UCustomPage;

type
  TCustomPageCollection = class(TInterfaceWrapper<ICustomPageCollection>)
  public
    procedure AddPage(const Page: ICustomPage);
    procedure RemovePage(const Page: TCustomPage);
    procedure ActivatePage(const Page: TCustomPage);
  end;

implementation

uses
  ComObj;

{ TCustomPageCollection }

procedure TCustomPageCollection.ActivatePage(const Page: TCustomPage);
begin
  OleCheck(Self.GetInterface.ActivatePage(Page));
end;

procedure TCustomPageCollection.AddPage(const Page: ICustomPage);
begin
  OleCheck(Self.GetInterface.AddPage(Page));
end;

procedure TCustomPageCollection.RemovePage(const Page: TCustomPage);
begin
  OleCheck(Self.GetInterface.RemovePage(Page));
end;

end.
