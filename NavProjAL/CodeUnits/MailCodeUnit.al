codeunit 50210 "Mail Codeunit"
{
    trigger OnRun()
    var
    begin

        mailWithSalesOverview(Format(1296), 'dnisp@live.dk', 'test', 'test');

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
        headers: Record "Sales Header";
        headersOfToday: Record "Sales Header" temporary;
        day: Date;
    begin
        day := DMY2Date(27, 1, 2022);
        headers.SetRange("Posting Date", day, day + 1);

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

    procedure mailWithSalesOverview(salesHeaderNo_P: Code[20]; sellToEmail: Text[20]; subject_P: Text; body_P: Text)
    var
        fileManager: Codeunit "File Management";
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
        lines: Record "Sales Line";
        docType: Enum "Sales Document Type";
    begin
        lines.Reset();
        lines.SetRange(lines."Document Type", docType::Order);
        lines.SetRange(lines."Document No.", salesHeaderNo_P);
        report.SetTableView(lines);
        fileName := 'Order_overview_' + Format(Today) + '.pdf';
        if not SmtpMailSetup.Get() then
            exit;
        HTMLFormatted := true;

        Recipients.Add(sellToEmail);

        Subject := subject_P;
        Body := body_P;

        if (report.SaveAsPdf(fileName)) then begin
            fileManager.BLOBImportFromServerFile(tempPdf, fileName);
            tempPdf.CreateInStream(inStreamer);

            Mail.CreateMessage('Business Central', SmtpMailSetup."User ID", Recipients, Subject, Body, HTMLFormatted);
            Mail.AddAttachmentStream(inStreamer, fileName);

        end;

        if not Mail.Send() then
            Message(Mail.GetLastSendMailErrorText());
    end;

}