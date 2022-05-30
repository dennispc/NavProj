pageextension 50161 WooMenuItem extends "Order Processor Role Center"
{
    actions
    {
        addafter(Action61)
        {
            action("WooCommerce")
            {
                RunObject = page "Woo Sales Card";

                ApplicationArea = All;
            }
            action("Amazon")
            {
                RunObject = page "Amazon page";

                ApplicationArea = All;
            }
            action("Fraud")
            {
                RunObject = codeunit FraudCodeunit;

                ApplicationArea = All;
            }

            action("Order Confirmation test")
            {
                RunObject = codeunit "Mail Codeunit";

                ApplicationArea = all;
            }
        }
    }
}