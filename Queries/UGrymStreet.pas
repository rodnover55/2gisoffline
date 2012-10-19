unit UGrymStreet;

interface


uses
  UDataFieldAttributes;

type
  TGrymStreet = class
  [DataField('type', 512)]
    TypeRow: string;
  [DataField('name', 512)]
    Name: string;
  end;

implementation

end.
