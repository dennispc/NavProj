page 50157 WooCustomerAPI
{
    PageType = API;
    Caption = 'apiPageName';
    APIPublisher = 'publisherName';
    APIGroup = 'groupName';
    APIVersion = 'v0.1';
    EntityName = 'entityName';
    EntitySetName = 'entitySetName';
    SourceTable = WooCustomer;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(id; Rec.Id)
                {

                }
                field(email; Rec.Email)
                {

                }
                field(firstname; Rec."First Name")
                {

                }
                field(lastname; Rec."Last Name")
                {

                }
                field(username; Rec.Username)
                {

                }
            }
        }
    }
}