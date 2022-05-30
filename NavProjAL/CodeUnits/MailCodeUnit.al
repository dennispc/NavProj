codeunit 50210 "Mail Codeunit"
{
    trigger OnRun()
    begin
        mailWithSalesOverview(Format(1282), 'dnisp@live.dk', 'test', 'testing')
    end;

    procedure mail(toEmail_P: Text; subject_P: Text; body_P: Text)

    var
        FileManage: Codeunit "File Management";
        SmtpMailSetup: Record "SMTP Mail Setup";
        Mail: Codeunit "SMTP Mail";
        Recipients: List of [Text];
        Subject: Text;
        Body: Text;
        CRLF: Text[2];
        HTMLFormatted: Boolean;
        inStreamer: InStream;
    begin

        if not SmtpMailSetup.Get() then
            exit;

        HTMLFormatted := true;

        Recipients.Add(toEmail_P);

        Subject := subject_P;
        Body := body_P;

        Mail.CreateMessage('Business Central', SmtpMailSetup."User ID", Recipients, Subject, Body, HTMLFormatted);

        if not Mail.Send() then
            Message(Mail.GetLastSendMailErrorText());

    end;

    procedure mailWithSalesReport(toEmail_P: Text)

    var
        SmtpMailSetup: Record "SMTP Mail Setup";
        Mail: Codeunit "SMTP Mail";
        Recipients: List of [Text];
        Subject: Text;
        Body: Text;
        CRLF: Text[2];
        HTMLFormatted: Boolean;
        tempPdf: Codeunit "Temp Blob";
        inStreamer: InStream;
        report: Report "Sales 24h Overview";
        fileName: Text;
        fileManager: Codeunit "File Management";
        headersOfToday: Record "Sales Header";
        day: Date;
    begin
        day := DMY2Date(27, 1, 2022);
        headersOfToday.SetFilter("Order Date", format(day));
        report.SetTableView(headersOfToday);
        fileName := 'sales_report_' + Format(Today) + '.pdf';
        if not SmtpMailSetup.Get() then
            exit;
        HTMLFormatted := true;

        Recipients.Add(toEmail_P);

        Subject := 'Sales Report ' + Format(Today);
        Body := 'Attatched is the weekly overview of sales orders';

        if (report.SaveAsPdf(fileName)) then begin
            fileManager.BLOBImportFromServerFile(tempPdf, fileName);
            tempPdf.CreateInStream(inStreamer);

            Mail.CreateMessage('Business Central', SmtpMailSetup."User ID", Recipients, Subject, Body, HTMLFormatted);
            Mail.AddAttachmentStream(inStreamer, fileName);

            if not Mail.Send() then
                Message(Mail.GetLastSendMailErrorText());
        end
        else
            Message('No sales today, try again later.')
    end;

    procedure mailWithSalesOverview(salesHeaderNo_P: Code[20]; toEmail_P: Text; subject_P: Text; body_P: Text)
    var
        SmtpMailSetup: Record "SMTP Mail Setup";
        Mail: Codeunit "SMTP Mail";
        Recipients: List of [Text];
        Subject: Text;
        Body: Text;
        CRLF: Text[2];
        HTMLFormatted: Boolean;
        tempPdf: Codeunit "Temp Blob";
        inStreamer: InStream;
        report: Report "Sales Order Overview";
        fileName: Text;
        fileManager: Codeunit "File Management";
        lines: Record "Sales Line";
        docType: Enum "Sales Document Type";
    begin
        lines.SetFilter("Document No.", salesHeaderNo_P);

        lines.find('-');
        report.SetTableView(lines);
        fileName := 'Order_overview_' + Format(Today) + '.pdf';
        if not SmtpMailSetup.Get() then
            exit;
        HTMLFormatted := true;

        Recipients.Add(toEmail_P);

        Subject := subject_P;
        Body := body_P;

        if (report.SaveAsPdf(fileName)) then begin
            fileManager.BLOBImportFromServerFile(tempPdf, fileName);
            tempPdf.CreateInStream(inStreamer);

            Mail.CreateMessage('Business Central', SmtpMailSetup."User ID", Recipients, Subject, Body, HTMLFormatted);
            Mail.AddAttachmentStream(inStreamer, fileName);

            if not Mail.Send() then
                Message(Mail.GetLastSendMailErrorText());
        end
    end;

}