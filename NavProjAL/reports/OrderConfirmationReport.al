report 50133 "Sales Order Overview"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = false;
    DefaultLayout = RDLC;
    RDLCLayout = 'layouts/salesOrderOverview.rdlc';

    dataset
    {
        dataitem(Lines; "Sales Line")
        {
            column(Document_No_; "Document No.")
            {

            }
            column(Item_code; "No.")
            {

            }
            column(Description; Description)
            {

            }
            column(Unit_Cost; "Unit Price")
            {

            }
            column(Quantity; Quantity)
            {

            }
            column(Total; Amount)
            {

            }

        }
    }

    var
        myInt: Integer;
}