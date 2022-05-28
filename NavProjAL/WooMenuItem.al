pageextension 50183 WooMenuItem extends "Order Processor Role Center"
{
    actions
    {
        addafter(Action61)
        {
            action("WooCommerce")
            {
                RunObject = page "WooPage";
                ApplicationArea = All;
            }
        }
    }
}