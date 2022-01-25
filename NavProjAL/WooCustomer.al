table 50156 WooCustomer
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Id; Integer)
        {

        }
        field(2; Email; Text[200])
        {

        }
        field(3; "First Name"; Text[200])
        {

        }
        field(4; "Last Name"; Text[200])
        {

        }
        field(5; Username; Text[200])
        {

        }
    }

    keys
    {
        key(PK; Id)
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