unit UGrym;

interface

uses
  UInterfaceWrapper, GrymCore_TLB;

type
  TGrym = class(TInterfaceWrapper<IGrym>)
  public
    function GetIssueDate: TDateTime;
  end;

implementation

uses
  SysUtils, ComObj;

{ TGrym }

function TGrym.GetIssueDate: TDateTime;
begin
  OleCheck(Self.GetInterface.Get_IssueDate(Result));
end;

end.
