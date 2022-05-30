tableextension 50167 MyExtension extends "Sales line"
{
    fields
    {
        field(50167; "units sold within date"; Decimal)
        {
            CalcFormula = sum("Sales Line".Quantity Where("No." = Field("No.")));
            FieldClass = FlowField;
        }
    }
}