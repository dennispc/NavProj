codeunit 50101 SalesLine
{
    trigger OnRun()
    begin
    end;

    procedure addItem(item: Text)
    var
        input: JsonObject;
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
    begin
        input.ReadFrom(item);
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

        NewLine.Insert(true);
        header.SetFilter("No.", DocumentNo);
        if header.FindSet() then begin
            repeat
                header.CalcFields(Amount, "Amount Including VAT");
            until header.Next = 0;
        end;

        if TransferExtendedText.SalesCheckIfAnyExtText(NewLine, false) then begin
            TransferExtendedText.InsertSalesExtTextRetLast(NewLine, LastLine);

        end;
    end;

}