page 50166 "Woo Sales Card"
{
    PageType = Document;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Sales Line";
    Caption = 'DailySales';
    //SourceTableTemporary = true;

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
                    sales: Record "Sales Line";
                    Buffer: Record "Business Chart Buffer" temporary;
                    topFiveSales: Record "Sales Line" temporary;
                    day: Date;
                    index: Integer;
                    i: Integer;
                    list: List of [Text];
                begin
                    sales.Reset();
                    sales.SetCurrentKey(Quantity, "No.");
                    sales.SetAscending(Quantity, false);
                    day := DMY2Date(27, 1, 2022);

                    sales.SetRange(sales."Posting Date", day, day + 6);

                    Buffer.Initialize();
                    Buffer.AddMeasure('Sales', 1, Buffer."Data Type"::Decimal, Buffer."Chart Type"::Column);
                    Buffer.SetXAxis('No.', Buffer."Data Type"::String);

                    if sales.FindSet(false, false) then begin
                        repeat
                            sales.CalcFields(sales."Posting Date");
                            Buffer.AddColumn(Format(sales."No.") + ',' + Format(sales."Posting Date"));
                            Buffer.SetValueByIndex(0, index, sales.Quantity);
                            index += 1;
                            if index = 5 then break;
                        until sales.Next() = 0;
                    end;
                    Buffer.Update(CurrPage.Chart);
                end;

                trigger DataPointClicked(point: JsonObject)
                var
                    str: Text;
                    strToken: JsonToken;

                    item: Record Item;
                    itempage: page "Item Card";
                begin
                    point.Get('XValueString', strToken);
                    strToken.WriteTo(str);
                    str := str.split(',').get(1).replace('"', '');
                    item.SetFilter(item."No.", str);
                    if item.FindSet() then begin
                        itempage.SetRecord(item);
                        itempage.Run();
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

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        myInt: Integer;
        lines: Record "Sales Line";
        ControlVariable: Integer;
        day: Date;
        list: List of [Text];
    begin
        day := DMY2Date(27, 1, 2022);
        Rec.SetRange("Posting Date", day, day + 6);

        Rec.SetCurrentKey(Quantity, "No.");
        Rec.SetAscending(Rec.Quantity, false);
    end;

}