tableextension 50112 MyExtension extends Contact
{
    fields
    {
        // Add changes to table fields here
    }

    var
        myInt: Integer;


    trigger OnInsert()
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
    begin

        if not SmtpMailSetup.Get() then
            exit;

        HTMLFormatted := true;

        Recipients.Add(Rec."E-Mail");

        Subject := 'Welcome';

        Body := '<b>Hi,</b> <br> Your account has been created. <br><br> Best regards, <br> WooCommerce';

        Mail.CreateMessage('Business Central', SmtpMailSetup."User ID", Recipients, Subject, Body, HTMLFormatted);

        ///FileManage.BLOBImportFromServerFile(tempD, 'C:\Excel\TestBuffer.csv');

        tempD.CreateInStream(inStreamer);

        //mail.AddAttachmentStream(inStreamer, 'TestBuffer.csv');

        if not Mail.Send() then
            Message(Mail.GetLastSendMailErrorText());

    end;
}