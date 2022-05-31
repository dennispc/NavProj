pageextension 50111 "Item Extension" extends "Item List"
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
                    exp: Codeunit "Item Export Mgt";
                begin
                    exp.ExportToWoocommerce(Rec);
                    Rec."Is in Woocommerce" := true;
                end;
            }
        }
    }

    var
        myInt: Integer;
}