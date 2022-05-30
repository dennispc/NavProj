pageextension 50170 "Item Page Extension" extends "Item Card"
{
    layout
    {
        addbefore("Shelf No.")
        {
            field("Is in Physical store"; Rec."Is in Physical store")
            {
                ApplicationArea = all;
                Editable = true;
            }
            field("Is in Woocommerce"; Rec."Is in Woocommerce")
            {
                ApplicationArea = all;
                Editable = true;
            }
        }
    }

    actions
    {
        addlast(ItemActionGroup)
        {
            action("Export to Woocommerce")
            {
                caption = 'Export to Woocommerce';
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                trigger OnAction()
                var
                    ExportCodeunit: Codeunit "Item Export Mgt";
                begin
                    ExportCodeunit.ExportToWoocommerce(Rec);
                    Rec."Is in Woocommerce" := true;
                end;
            }

        }
    }

    var
        myInt: Integer;
}