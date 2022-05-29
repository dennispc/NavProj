pageextension 50142 SalesOrderExt extends "Sales Order List"
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
                    mailCodeunit: Codeunit "Mail Codeunit";
                begin
                    mailCodeunit.mailWithSalesReport('dnisp@live.dk');
                end;
            }
        }
    }

    var
        myInt: Integer;
}