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
            index += 1
        until index = counts;
        mailCodeunit.mailWithSalesOverview(
            DocumentNo,
            header."Sell-to E-Mail",
            'Order ' + OrderId + ' Received',
            'Hello ' + header."Sell-to Customer Name" + ' ' + header."Sell-to Customer Name 2" + '<br>' +
            'We are sending you this email, to inform you, that your order (OrderNo ' + OrderId +
            ') has been received.<br>' +
            '<br>' +
            'Best regards, <br>' +
            'WooCommerce'

        );
    end;

}