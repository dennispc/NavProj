query 50163 MyQuery
{
    QueryType = Normal;

    elements
    {
        dataitem(DataItemName; "Sales Line")
        {
            column(PostingDate; "Posting Date")
            {

            }
            filter(FilterName; "Posting Date")
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