unit UGrymMapBuilding;

interface

uses
  UDataFieldAttributes, GrymCore_TLB;

type
  TGrymMapBuilding = class
  [DataField('id_row')]
    IdRow: Integer;
  [DataField('type', 512)]
    TypeRow: string;
  [DataField('post_index', 512)]
    PostIndex: string;
  [DataField('addr_count')]
    AddressCount: Integer;
  [DataField('street_1', 512)]
    Street: string;
  [DataField('number_1', 512)]
    Number: string;
  [DataField('city', 512)]
    City: string;
  [DataField('feature')]
    Feature: IFeature;
  end;

implementation

end.
