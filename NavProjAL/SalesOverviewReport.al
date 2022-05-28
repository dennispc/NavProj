report 50180 "Sales 24h Overview"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = false;
    DefaultLayout = RDLC;
    RDLCLayout = './layout.rdlc';
    dataset
    {

        dataitem(DataItemName; "Sales Header")
        {
            RequestFilterFields = "Order Date";

            column(ColumnName1; "Sell-to Customer Name")
            {

            }
            column(ColumnName2; Amount)
            {

            }
            column(ColumnName3; "No.")
            {

            }
        }
    }

}