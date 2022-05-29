pageextension 50161 WooMenuItem extends "Order Processor Role Center"
{
    actions
    {
        addafter(Action61)
        {
            action("WooCommerce")
            {
                RunObject = page "Woo Page";
                ApplicationArea = All;
            }
        }
    }
}