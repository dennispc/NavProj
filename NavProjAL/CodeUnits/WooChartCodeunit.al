codeunit 50165 "Woo chart Codeunit"
{
    //trigger OnRun()
    //var
    //    lines: Record "Sales line";
    //    day: Date;
    //    daytime: DateTime;
    //    match: Boolean;
    //    charts: Record "Woo Chart Setup";
    //begin
    //    charts.DeleteAll();
    //    day := DMY2Date(28, 1, 2022);
    //    lines.Reset();
    //    lines.SetRange("Posting Date", day);
    //    if lines.FindSet() then begin
    //        repeat
    //            lines.Find('-');
    //            charts.Reset();
    //            charts.SetRange(ItemId, charts.ItemId);
    //            if charts.FindSet() then begin
    //                charts.Find('-');
    //                charts."Qty Sold" += lines.Amount;
    //            end
    //            else begin
    //                charts.Init();
    //                charts."Day Sold" := lines."Posting Date";
    //                charts.ItemId := lines."No.";
    //                charts."Qty Sold" := lines.Amount;
    //                charts.Insert();
    //            end;
    //        until lines.Next() = 0;
    //    end;
    //end;

    procedure get(sales: Record "Sales Line" temporary)
    var
        orgSalesLine: Record "Sales Line";
        day: Date;
    begin
        day := DMY2Date(29, 1, 2022);
        orgSalesLine.Reset();
        orgSalesLine.SetRange("Posting Date", day);
        repeat
            orgSalesLine.Find('-');
            sales.Reset();
            sales.SetFilter("No.", orgSalesLine."No.");
            if not sales.FindSet() then begin
                sales.Init();
                sales."No." := orgSalesLine."No.";
                sales.Quantity := orgSalesLine.Quantity;
                sales."Unit Cost" := orgSalesLine."Unit Cost";
                sales."Posting Date" := orgSalesLine."Posting Date";
                sales.insert();
            end
            else begin
                sales.Quantity += orgSalesLine.Quantity;
            end;
        until orgSalesLine.Next() = 0;
    end;


    var
        myInt: Integer;
}