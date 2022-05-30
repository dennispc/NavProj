codeunit 50190 FraudCodeunit
{

    trigger OnRun()
    var
        day: Date;
    begin
        day := DMY2Date(27, 01, 22);
        RunFraudCheck(day);
    end;

    procedure RunFraudCheck(day_v: Date)
    var
        salesHeaders: Record "Sales Header";
        suspiciousCustomers: Record Customer temporary;
        customers: Record Customer;
        count: Integer;
        address: Text;
        report: Report "Customer - List";
        filter: Text;
        list: List of [Text];
        path: Text;
    begin
        salesHeaders.SetCurrentKey(salesHeaders."Sell-to Address", salesHeaders."No.");
        salesHeaders.SetAscending(salesHeaders."Sell-to Address", true);
        salesHeaders.SetFilter(salesHeaders."Posting Date", format(day_v));

        if salesHeaders.FindSet() then begin
            count := 1;
            address := salesHeaders."Sell-to Address";
            repeat
                if address = salesHeaders."Sell-to Address" then begin
                    count += 1;
                end;
                if (count > 5) then begin
                    if not list.Contains(salesHeaders."Sell-to Customer No.") then begin
                        filter += '|' + salesHeaders."Sell-to Customer No.";
                        list.Add(salesHeaders."Sell-to Customer No.");
                    end;
                    count := 1;
                end;
                address := salesHeaders."Sell-to Address";
            until salesHeaders.Next() = 0;
        end;
        if filter.trim() = '' then begin
            Message('No addresses with more than file lines of sales in a day.');
            exit;
        end;
        customers.SetFilter(customers."No.", filter.Substring(2));
        suspiciousCustomers.Copy(customers);
        suspiciousCustomers.Insert();

        path := 'fraud' + Format(day_v) + '.pdf';

        report.SetTableView(suspiciousCustomers);
        report.SaveAsPdf(path);
        Download(path, '', 'C:\Users\dp\Documents\NavProj\NavProjAL\fraud', '', path);
    end;


}