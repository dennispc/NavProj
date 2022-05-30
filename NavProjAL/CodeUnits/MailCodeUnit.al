codeunit 50210 "Mail Codeunit"
{
    trigger OnRun()
    begin

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

}