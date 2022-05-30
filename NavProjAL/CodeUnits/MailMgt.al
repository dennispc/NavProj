codeunit 50200 "Mail Mgt"
{
    trigger OnRun()
    var
    begin

        MailWithSalesOverview(Format(1296), 'dnisp@live.dk', 'test', 'test');

    end;

    procedure Mail(ToEmail_P: Text; Subject_P: Text; Body_P: Text)

    var
        FileManager: Codeunit "File Management";
        SmtpMailSetup: Record "SMTP Mail Setup";
        Mail: Codeunit "SMTP Mail";
        Recipients: List of [Text];
        Subject: Text;
        Body: Text;
        CRLF: Text[2];
        HTMLFormatted: Boolean;
        InStreamer: InStream;
    begin

        if not SmtpMailSetup.Get() then
            exit;

        HTMLFormatted := true;

        Recipients.Add(ToEmail_P);

        Subject := Subject_P;
        Body := Body_P;

        Mail.CreateMessage('Business Central', SmtpMailSetup."User ID", Recipients, Subject, Body, HTMLFormatted);

        if not Mail.Send() then
            Message(Mail.GetLastSendMailErrorText());

    end;

    procedure MailWithSalesReport(ToEmail_P: Text)

    var
        SmtpMailSetup: Record "SMTP Mail Setup";
        Mail: Codeunit "SMTP Mail";
        Recipients: List of [Text];
        Subject: Text;
        Body: Text;
        CRLF: Text[2];
        HTMLFormatted: Boolean;
        TemporaryPdf: Codeunit "Temp Blob";
        InStreamer: InStream;
        SalesReport: Report "Sales Overview";
        FileName: Text;
        FileManager: Codeunit "File Management";
        SalesLines: Record "Sales Line";
        Day: Date;
    begin
        Day := DMY2Date(27, 1, 2022);
        SalesLines.SetRange("Posting Date", Day, Day + 1);
        SalesLines.SetCurrentKey(Amount);
        SalesLines.SetAscending(Amount, false);
        SalesReport.SetTableView(SalesLines);
        FileName := 'sales_report_' + Format(Today) + '.pdf';
        if not SmtpMailSetup.Get() then
            exit;
        HTMLFormatted := true;

        Recipients.Add(ToEmail_P);

        Subject := 'Sales Report ' + Format(Today);
        Body := 'Attatched is the weekly overview of sales orders';

        if (SalesReport.SaveAsPdf(FileName)) then begin
            FileManager.BLOBImportFromServerFile(TemporaryPdf, FileName);
            TemporaryPdf.CreateInStream(InStreamer);

            Mail.CreateMessage('Business Central', SmtpMailSetup."User ID", Recipients, Subject, Body, HTMLFormatted);
            Mail.AddAttachmentStream(InStreamer, FileName);

            if not Mail.Send() then
                Message(Mail.GetLastSendMailErrorText());
        end
        else
            Message('No sales today, try again later.')
    end;

    procedure MailWithSalesOverview(SalesHeaderNo_P: Code[20]; SellToEmail: Text[20]; Subject_P: Text; Body_P: Text)
    var
        FileManager: Codeunit "File Management";
        SmtpMailSetup: Record "SMTP Mail Setup";
        Mail: Codeunit "SMTP Mail";
        Recipients: List of [Text];
        Subject: Text;
        Body: Text;
        CRLF: Text[2];
        HTMLFormatted: Boolean;
        TempPdf: Codeunit "Temp Blob";
        InStreamer: InStream;
        OrderReport: Report "Sales Confirmation";
        FileName: Text;
        SalesLines: Record "Sales Line";
        DocumentType: Enum "Sales Document Type";
    begin
        SalesLines.Reset();
        SalesLines.SetRange(SalesLines."Document Type", DocumentType::Order);
        SalesLines.SetRange(SalesLines."Document No.", SalesHeaderNo_P);
        OrderReport.SetTableView(SalesLines);
        FileName := 'Order_overview_' + Format(Today) + '.pdf';
        if not SmtpMailSetup.Get() then
            exit;
        HTMLFormatted := true;

        Recipients.Add(SellToEmail);

        Subject := Subject_P;
        Body := Body_P;

        if (OrderReport.SaveAsPdf(FileName)) then begin
            FileManager.BLOBImportFromServerFile(TempPdf, FileName);
            TempPdf.CreateInStream(InStreamer);

            Mail.CreateMessage('Business Central', SmtpMailSetup."User ID", Recipients, Subject, Body, HTMLFormatted);
            Mail.AddAttachmentStream(InStreamer, FileName);

        end;

        if not Mail.Send() then
            Message(Mail.GetLastSendMailErrorText());
    end;

}