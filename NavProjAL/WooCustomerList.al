page 50158 "Woo Customer List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = WooCustomer;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Id; Rec.Id)
                {

                }
                field(Email; Rec.Email)
                {

                }
                field(FirstName; Rec."First Name")
                {

                }
                field(LastName; Rec."Last Name")
                {

                }
                field(Username; Rec.Username)
                {

                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                var
                    test: Page 42;
                begin

                end;
            }
        }
    }
}