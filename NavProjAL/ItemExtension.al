pageextension 50167 MyExtension extends "Item Card"
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