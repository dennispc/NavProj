page 50150 "Woo Sales Card"
{
    PageType = Document;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Sales Line";
    Caption = 'DailySales';

    /*
The customer wants a chart, which can show:
The five most sold products for the last week and on which day they were sold. The product name must be
shown as a tooltip. If the user clicks on the chart item, then drill down and show the product on the item
card.
    */

    layout
    {
        area(Content)
        {
            usercontrol(Chart; "Microsoft.Dynamics.Nav.Client.BusinessChart")
            {
                ApplicationArea = all;
                trigger AddInReady()
                var
                    Sales: Record "Sales Line";
                    Buffer: Record "Business Chart Buffer" temporary;
                    TopFiveSales: Record "Sales Line" temporary;
                    Day: Date;
                    Index: Integer;
                    ListOfSales: List of [Text];
                begin
                    Sales.Reset();
                    Sales.SetCurrentKey(Quantity, "No.");
                    Sales.SetAscending(Quantity, false);
                    Day := DMY2Date(27, 1, 2022);

                    Sales.SetRange(Sales."Posting Date", Day, Day + 6);

                    Buffer.Initialize();
                    Buffer.AddMeasure('Sales', 1, Buffer."Data Type"::Decimal, Buffer."Chart Type"::Column);
                    Buffer.SetXAxis('No.', Buffer."Data Type"::String);

                    if Sales.FindSet(false, false) then begin
                        repeat
                            Sales.CalcFields(Sales."Posting Date");
                            Buffer.AddColumn(Format(Sales."No.") + ',' + Format(Sales."Posting Date"));
                            Buffer.SetValueByIndex(0, Index, Sales.Quantity);
                            Index += 1;
                            if Index = 5 then break;
                        until Sales.Next() = 0;
                    end;
                    Buffer.Update(CurrPage.Chart);
                end;

                trigger DataPointClicked(point: JsonObject)
                var
                    ClickedItem: Text;
                    ClickedItemToken: JsonToken;
                    Item: Record Item;
                    ItemCard: page "Item Card";
                begin
                    point.Get('XValueString', ClickedItemToken);
                    ClickedItemToken.WriteTo(ClickedItem);
                    ClickedItem := ClickedItem.split(',').get(1).replace('"', '');
                    Item.SetFilter(Item."No.", ClickedItem);
                    if Item.FindSet() then begin
                        ItemCard.SetRecord(Item);
                        ItemCard.Run();
                    end;
                end;
            }

            repeater(GroupName)
            {
                field(ItemId; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Qty Sold"; Rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Day sold"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
            }

        }
        area(Factboxes)
        {

        }
    }

    trigger OnOpenPage()
    var
        SalesLines: Record "Sales Line";
        Day: Date;
    begin
        Day := DMY2Date(27, 1, 2022);
        Rec.SetRange("Posting Date", Day, Day + 6);
        Rec.SetCurrentKey(Quantity, "No.");
        Rec.SetAscending(Rec.Quantity, false);
    end;
}