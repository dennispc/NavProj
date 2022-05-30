codeunit 50132 SalesLine
{
    trigger OnRun()
    begin
    end;

    procedure addItem(item: Text)
    var
        inputItems: JsonArray;
        input: JsonObject;
        inputToken: JsonToken;

        DocumentNoToken: JsonToken;
        DocumentNoText: Text;
        DocumentNo: Code[20];
        DocumentTypeToken: JsonToken;
        DocumentTypeText: Text;
        DocumentType: Enum "Sales Document Type";
        OrderIdToken: JsonToken;
        OrderIdText: Text;
        OrderId: Code[50];
        QuantityToken: JsonToken;
        Quantity: Integer;
        QuantityText: Text;
        ItemNoToken: JsonToken;
        ItemNo: Text;
        ItemNoCode: Code[20];
        LineNoToken: JsonToken;
        LineNoText: Text;
        LineNo: Integer;
        NewLine: Record "Sales Line";
        LastLine: Record "Sales Line";
        MyItem: Record Item;
        header: Record "Sales Header";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        index: Integer;
        counts: Integer;
        mailCodeunit: Codeunit "Mail Codeunit";
        orderpage: Page "Sales Order";
        docType: Enum "Sales Document Type";
        customer: Record Customer;
    begin
        inputItems.ReadFrom(item);
        index := 0;
        counts := inputItems.Count;

        repeat
            inputItems.Get(index, inputToken);
            input := inputToken.AsObject();
            NewLine.Init();
            input.Get('DocumentNo', DocumentNoToken);
            DocumentNoToken.WriteTo(DocumentNoText);
            Evaluate(DocumentNo, DocumentNoText);
            NewLine."Document No." := DocumentNo;

            NewLine.Type := NewLine.Type::Item;

            input.Get('ItemNo', ItemNoToken);
            ItemNoToken.WriteTo(ItemNo);
            Evaluate(ItemNoCode, ItemNo.Replace('"', ''));
            NewLine."No." := ItemNoCode;

            MyItem.SetFilter("No.", NewLine."No.");
            if MyItem.FindSet then
                repeat
                    NewLine.Description := MyItem.Description;
                    NewLine."Description 2" := MyItem."Description 2";
                    NewLine."Unit Price" := MyItem."Unit Price";
                    NewLine."Unit of Measure Code" := MyItem."Base Unit of Measure";
                until MyItem.Next = 0;


            input.Get('LineNo', LineNoToken);
            LineNoToken.WriteTo(LineNoText);
            Evaluate(LineNo, LineNoText.Replace('"', ''));
            NewLine."Line No." := LineNo;

            NewLine."Document Type" := DocumentType::Order;

            input.Get('OrderId', OrderIdToken);
            OrderIdToken.WriteTo(OrderIdText);
            Evaluate(OrderId, OrderIdText.Replace('"', ''));
            NewLine."Item Reference No." := OrderId;

            input.Get('Quantity', QuantityToken);
            QuantityToken.WriteTo(QuantityText);
            Evaluate(Quantity, QuantityText);
            NewLine.Quantity := Quantity;

            NewLine.UpdateAmounts();
            NewLine.Insert(true);

            if TransferExtendedText.SalesCheckIfAnyExtText(NewLine, false) then begin
                TransferExtendedText.InsertSalesExtTextRetLast(NewLine, LastLine);
            end;
            index += 1;
        until index = counts;
        header.Reset();
        if (header.get(docType::Order, DocumentNo)) then begin
            mailCodeunit.mail(
                header."Sell-to E-Mail",
                'Order ' + OrderId + ' Received',
                'Hello ' + header."Sell-to Customer Name" + ' ' + header."Sell-to Customer Name 2" + '<br>' +
                'We are sending you this email, to inform you, that your order (OrderNo ' + OrderId +
                ') has been received.<br><br>' +
                'Best regards, <br>' +
                'WooCommerce'
            );
            //mailWithSalesOverview(
            //    DocumentNo,
            //    header."Sell-to E-Mail",
            //    'Order ' + OrderId + ' Received',
            //    'Hello ' + header."Sell-to Customer Name" + ' ' + header."Sell-to Customer Name 2" + '<br>' +
            //    'We are sending you this email, to inform you, that your order (OrderNo ' + OrderId +
            //    ') has been received.<br><br>' +
            //    'Best regards, <br>' +
            //    'WooCommerce'
            //);
        end;
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