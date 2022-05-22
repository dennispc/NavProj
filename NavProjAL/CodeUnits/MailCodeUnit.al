codeunit 50264 MyCodeunit
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
        tempD: Codeunit "Temp Blob";
        asd: Report MyReport;
    begin

        if not SmtpMailSetup.Get() then
            exit;

        HTMLFormatted := true;

        Recipients.Add(toEmail_P);

        Subject := subject_P;

        Body := body_P;
        Mail.CreateMessage('Business Central', SmtpMailSetup."User ID", Recipients, Subject, Body, HTMLFormatted);

        ///FileManage.BLOBImportFromServerFile(tempD, 'C:\Excel\TestBuffer.csv');

        tempD.CreateInStream(inStreamer);

        //mail.AddAttachmentStream(inStreamer, 'TestBuffer.csv');

        if not Mail.Send() then
            Message(Mail.GetLastSendMailErrorText());

    end;

    var
        myInt: Integer;
}