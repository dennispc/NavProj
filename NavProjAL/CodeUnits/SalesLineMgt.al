codeunit 50131 "Sales Line Mgt"
{
    trigger OnRun()
    begin
    end;

    procedure addItem(item: Text)
    var
        InputArray: JsonArray;
        ArrayItem: JsonObject;
        ItemToken: JsonToken;

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
        SalesHeader: Record "Sales Header";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        Index: Integer;
        AmountOfItems: Integer;
        MailCodeunit: Codeunit "Mail Mgt";
        Orderpage: Page "Sales Order";
        DocType: Enum "Sales Document Type";
        Customer: Record Customer;
    begin
        InputArray.ReadFrom(item);
        Index := 0;
        AmountOfItems := InputArray.Count;

        repeat
            InputArray.Get(Index, ItemToken);
            ArrayItem := ItemToken.AsObject();
            NewLine.Init();
            ArrayItem.Get('DocumentNo', DocumentNoToken);
            DocumentNoToken.WriteTo(DocumentNoText);
            Evaluate(DocumentNo, DocumentNoText);
            NewLine."Document No." := DocumentNo;

            NewLine.Type := NewLine.Type::Item;

            ArrayItem.Get('ItemNo', ItemNoToken);
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


            ArrayItem.Get('LineNo', LineNoToken);
            LineNoToken.WriteTo(LineNoText);
            Evaluate(LineNo, LineNoText.Replace('"', ''));
            NewLine."Line No." := LineNo;

            NewLine."Document Type" := DocumentType::Order;

            ArrayItem.Get('OrderId', OrderIdToken);
            OrderIdToken.WriteTo(OrderIdText);
            Evaluate(OrderId, OrderIdText.Replace('"', ''));
            NewLine."Item Reference No." := OrderId;

            ArrayItem.Get('Quantity', QuantityToken);
            QuantityToken.WriteTo(QuantityText);
            Evaluate(Quantity, QuantityText);
            NewLine.Quantity := Quantity;

            NewLine.UpdateAmounts();
            NewLine.Insert(true);

            if TransferExtendedText.SalesCheckIfAnyExtText(NewLine, false) then begin
                TransferExtendedText.InsertSalesExtTextRetLast(NewLine, LastLine);
            end;
            Index += 1;
        until Index = AmountOfItems;
        SalesHeader.Reset();
        if (SalesHeader.get(DocType::Order, DocumentNo)) then begin
            MailCodeunit.Mail(
                SalesHeader."Sell-to E-Mail",
                'Order ' + OrderId + ' Received',
                'Hello ' + SalesHeader."Sell-to Customer Name" + ' ' + SalesHeader."Sell-to Customer Name 2" + '<br>' +
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
}