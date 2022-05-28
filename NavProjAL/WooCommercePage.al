page 50190 WooPage
{
    Caption = 'WooPage';
    PageType = Document;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = WooCustomer;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(Name; "First Name")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}