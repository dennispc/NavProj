pageextension 50181 SalesOrderExt extends "Sales Order List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter(Action12)
        {

            action("Send report to admin")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    mailCodeunit: Codeunit MyCodeunit;
                begin
                    mailCodeunit.mailWithSalesReport('dnisp@live.dk');
                end;
            }
        }
    }

    var
        myInt: Integer;
}