query 50156 MyQuery
{
    QueryType = API;
    APIPublisher = 'PublisherName';
    APIGroup = 'GroupName';
    APIVersion = 'v0.0';
    EntityName = 'EntityName';
    EntitySetName = 'EntitySetName';

    elements
    {
        dataitem(DataItemName; WooCustomer)
        {
            column(Id; Id)
            {

            }
            column(Email; Email)
            {

            }
            column("FirstName"; "First Name")
            {

            }
            column("LastName"; "Last Name")
            {

            }
            column(Username; Username)
            {

            }
        }
    }

    var
        myInt: Integer;

    trigger OnBeforeOpen()
    begin

    end;
}