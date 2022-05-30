table 50168 "Sales Line SubTable"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Id; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "No."; Code[20])
        {

        }
        field(10; "Day Sold"; Date)
        {

        }
        field(20; Quantity; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Sales Line".Quantity Where("No." = Field("No.")));
        }
        field(21; "Unit Cost"; Decimal)
        {
            TableRelation = "Sales Line"."Unit Cost" Where("No." = Field("No."));
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