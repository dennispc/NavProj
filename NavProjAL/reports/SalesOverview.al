report 50140 "Sales Overview"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = false;
    DefaultLayout = RDLC;
    RDLCLayout = 'layouts/sales_overview.rdlc';
    dataset
    {

        dataitem(DataItemName; "Sales Line")
        {
            RequestFilterFields = "No.";
            column(Posting_Date; "Posting Date") { }
            column(No_; "No.") { }
            column(Quantity; Quantity) { }
            column(Unit_Cost; "Unit Cost") { }
            column(Amount; Amount) { }
        }
    }

}