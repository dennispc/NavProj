page 50161 WooOrderList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = WooOrder;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Id; Rec.id) { }
                field(firstname; Rec.firstname) { }
                field(lastname; Rec.lastname) { }
                field(companyname; Rec.companyname) { }
                field(region; Rec.region) { }
                field(street_address; Rec.street_address) { }
                field(postcode; Rec.postcode) { }
                field(town; Rec.town) { }
                field(phone; Rec.phone) { }
                field(email; Rec.email) { }
                field(NavId; Rec.NavId) { }
                field(lines; Rec.lines) { }
                field(dateCreated; Rec.datecreated) { }
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
                begin

                end;
            }
        }
    }
}