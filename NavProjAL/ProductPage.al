page 50155 "Product Page"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Product;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(ID; Rec.ID)
                {
                }
                field(Name; Rec.Name)
                {
                }
                field(Paragraph; Rec.Paragraph)
                {
                }
                field(Price; Rec.Price)
                {
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Export to WooCommerce")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    table: Record Product temporary;
                    exp: Codeunit "Export Product";
                begin
                    table.ID := Rec.ID;
                    table.Name := Rec.Name;
                    table.Paragraph := Rec.Paragraph;
                    table.Price := Rec.Price;
                    exp.exportToWoocommerce(table);
                end;
            }
        }
    }

    var
        myInt: Integer;
}