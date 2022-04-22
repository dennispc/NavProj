page 50160 WooOderPage
{
    PageType = API;
    Caption = 'apiPageName';
    APIPublisher = 'publisherName2';
    APIGroup = 'groupName';
    APIVersion = 'v0.0';
    EntityName = 'entityName';
    EntitySetName = 'entitySetName';
    SourceTable = WooOrder;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(id; Rec.id) { }
                field(firstname; Rec.firstname) { }
                field(lastname; Rec.lastname) { }
                field(companyname; Rec.companyname) { }
                field(region; Rec.region) { }
                field(streetaddress; Rec.street_address) { }
                field(postcode; Rec.postcode) { }
                field(town; Rec.town) { }
                field(phone; Rec.phone) { }
                field(email; Rec.email) { }
                field(lines; Rec.lines) { }
                field(datecreated; Rec.datecreated) { }

            }
        }
    }
}