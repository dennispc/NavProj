tableextension 50167 "Sales Line Extemsion" extends "Sales line"
{
    fields
    {
        field(50167; "Total sold"; Decimal)
        {
            CalcFormula = sum("Sales Line".Quantity Where("No." = Field("No.")));
            FieldClass = FlowField;
        }
    }
}