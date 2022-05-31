codeunit 50190 "Fraud Mgt"
{

    trigger OnRun()
    var
        Day: Date;
    begin
        Day := DMY2Date(27, 1, 2022);
        GetFraud(Day);
    end;

    procedure GetFraud(Day_P: Date)
    var
        Sales: Record "Sales Header";
        SuspiciousCustomer: Record Customer temporary;
        currCustomer: Record Customer;
        RepeatedAddressCount: Integer;
        Address: Text;
        CustReport: Report "Customer - List";
        textFilter: Text;
        noList: List of [Text];
        FileName: Text;
    begin
        Sales.SetCurrentKey(Sales."Sell-to Address", Sales."No.");
        Sales.SetAscending(Sales."Sell-to Address", true);
        Sales.SetFilter(Sales."Posting Date", format(Day_P));

        if Sales.FindSet() then begin
            RepeatedAddressCount := 1;
            Address := Sales."Sell-to Address";
            repeat
                if Address = Sales."Sell-to Address" then begin
                    RepeatedAddressCount += 1;
                end;
                if (RepeatedAddressCount > 5) then begin
                    if not noList.Contains(Sales."Sell-to Customer No.") then begin
                        textFilter += '|' + Sales."Sell-to Customer No.";
                        noList.Add(Sales."Sell-to Customer No.");
                    end;
                    RepeatedAddressCount := 1;
                end;
                Address := Sales."Sell-to Address";
            until Sales.Next() = 0;
        end;
        if textFilter.trim() = '' then begin
            Message('No addresses with more than file lines of sales in a day.');
            exit;
        end;
        currCustomer.SetFilter(currCustomer."No.", textFilter.Substring(2));
        SuspiciousCustomer.Copy(currCustomer);
        SuspiciousCustomer.Insert();

        FileName := 'fraud' + Format(Day_P) + '.pdf';

        CustReport.SetTableView(SuspiciousCustomer);
        CustReport.SaveAsPdf(FileName);
        Download(FileName, '', '', '', FileName);
    end;

}