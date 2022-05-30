pageextension 50160 "Woo Menu Item" extends "Order Processor Role Center"
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
                RunObject = page "Amazon Page";

                ApplicationArea = All;
            }
            action("Fraud")
            {
                RunObject = codeunit "Fraud Mgt";

                ApplicationArea = All;
            }

            action("Order Confirmation test")
            {
                RunObject = codeunit "Mail Mgt";

                ApplicationArea = all;
            }
        }
    }
}