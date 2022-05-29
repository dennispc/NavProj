pageextension 50111 "Item export extension" extends "Item List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addlast(Functions)
        {
            action("Export to WooCommerce")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    exp: Codeunit "Export Item To WooCommerce";
                begin
                    exp.exportToWoocommerce(Rec);
                end;
            }
        }
    }

    var
        myInt: Integer;
}