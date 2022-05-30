pageextension 50141 "Sales Order List Extension" extends "Sales Order List"
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
                    MailCodeunit: Codeunit "Mail Mgt";
                begin
                    MailCodeunit.MailWithSalesReport('dnisp@live.dk');
                end;
            }
        }
    }
}