table 50159 WooOrder
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; id; Integer) { }
        field(2; firstname; Text[200]) { }
        field(3; lastname; Text[200]) { }
        field(4; companyname; Text[200]) { }
        field(5; region; Text[200]) { }
        field(6; street_address; Text[200]) { }
        field(7; postcode; Text[200]) { }
        field(8; town; Text[200]) { }
        field(9; phone; Text[100]) { }
        field(10; email; Text[200]) { }
        field(11; NavId; Integer)
        {
            AutoIncrement = true;
        }
        field(12; lines; Text[1000]) { }
    }

    keys
    {
        key(PK; NavId)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}