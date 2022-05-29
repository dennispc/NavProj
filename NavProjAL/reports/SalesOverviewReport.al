report 50141 "Sales 24h Overview"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = false;
    DefaultLayout = RDLC;
    RDLCLayout = 'layouts/sales_overview.rdlc';
    dataset
    {

        dataitem(DataItemName; "Sales Header")
        {
            RequestFilterFields = "Order Date";

            column(Customer; "Sell-to Customer Name")
            {

            }
            column(Amount; Amount)
            {

            }
            column(OrderNumber; "No.")
            {

            }
        }
    }

}