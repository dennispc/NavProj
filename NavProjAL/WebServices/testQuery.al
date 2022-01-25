query 50170 testquery
{
    QueryType = API;
    APIPublisher = 'PublisherName';
    APIGroup = 'GroupName';
    APIVersion = 'v0.0';
    EntityName = 'EntityNameasd';
    EntitySetName = 'EntitySetNameasd';

    elements
    {
        dataitem(DataItemName; "Sales Header")
        {
            column(DocumentNo; "No.")
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