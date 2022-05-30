codeunit 50110 "Item Export Mgt"
{

    procedure ExportToWoocommerce(NewItem: Record Item)
    var
        Client: HttpClient;
        Content: HttpContent;
        Response: HttpResponseMessage;
        HttpRequest: HttpRequestMessage;
        ContentHeader: HttpHeaders;
        RequestHeader: HttpHeaders;
        ItemAsJson: JsonObject;
        ItemJsonAsText: Text;
        ResponseText: Text;
        ImageStream: InStream;
        ImageText: Text;
        ResultJson: JsonObject;
        IdJson: JsonToken;
        Id: Text;
    begin
        ItemAsJson.Add('name', NewItem.Description);
        ItemAsJson.Add('price', Format(NewItem."Unit Price"));
        ItemAsJson.Add('regular_price', Format(NewItem."Unit Price"));
        ItemAsJson.Add('description', NewItem.Description);
        ItemAsJson.Add('sku', NewItem."No.");
        //item.Picture.ImportStream(imageStream, 'itemImage');
        //imageStream.ReadText(imageText);
        //json.Add('image', imageText);

        ItemAsJson.AsToken().WriteTo(ItemJsonAsText);
        Content.WriteFrom(ItemJsonAsText);
        Content.GetHeaders(ContentHeader);
        ContentHeader.Clear();
        ContentHeader.Add('Content-Type', 'application/json');
        HttpRequest.Content := Content;

        HttpRequest.GetHeaders(RequestHeader);
        RequestHeader.Add('Authorization', 'Basic Y2tfMmEyNTVkMWU0MDNmYmRkZjRiYTI1YWEyMDFjOGYzYWNhYzJmMTZlMzpjc19iZWZiNDJhM2QzYWQ2NGQ5Y2JiZGFlMzE3NDUyZTIyZWZlZmQ5YTY3');

        HttpRequest.SetRequestUri('https://localhost/wordpress/wp-json/wc/v2/products');
        HttpRequest.Method := 'POST';
        if (Client.Send(HttpRequest, Response)) then begin
            Response.Content().ReadAs(ResponseText);
            ResultJson.ReadFrom(ResponseText);
            if (ResultJson.Get('id', IdJson)) then begin
                IdJson.WriteTo(Id);
                NewItem."No. 2" := Id;
            end;
        end;

        Message(ResponseText);
    end;
}