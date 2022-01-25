codeunit 50156 "Export Item To WooCommerce"
{

    procedure exportToWoocommerce(item: Record Item)
    var
        client: HttpClient;
        content: HttpContent;
        response: HttpResponseMessage;
        httpRequest: HttpRequestMessage;
        contentHeader: HttpHeaders;
        requestHeader: HttpHeaders;
        itemAsJson: JsonObject;
        itemJsonAsText: Text;
        responseText: Text;
        imageStream: InStream;
        imageText: Text;
        resJson: JsonObject;
        idJson: JsonToken;
        id: Text;
    begin
        itemAsJson.Add('name', item.Description);
        itemAsJson.Add('price', Format(item."Unit Price"));
        itemAsJson.Add('regular_price', Format(item."Unit Price"));
        itemAsJson.Add('description', item.Description);
        itemAsJson.Add('sku', item."No.");
        //item.Picture.ImportStream(imageStream, 'itemImage');
        //imageStream.ReadText(imageText);
        //json.Add('image', imageText);

        itemAsJson.AsToken().WriteTo(itemJsonAsText);
        content.WriteFrom(itemJsonAsText);
        content.GetHeaders(contentHeader);
        contentHeader.Clear();
        contentHeader.Add('Content-Type', 'application/json');
        httpRequest.Content := content;

        httpRequest.GetHeaders(requestHeader);
        requestHeader.Add('Authorization', 'Basic Y2tfMmEyNTVkMWU0MDNmYmRkZjRiYTI1YWEyMDFjOGYzYWNhYzJmMTZlMzpjc19iZWZiNDJhM2QzYWQ2NGQ5Y2JiZGFlMzE3NDUyZTIyZWZlZmQ5YTY3');

        httpRequest.SetRequestUri('https://localhost/wordpress/wp-json/wc/v2/products');
        httpRequest.Method := 'POST';
        if (client.Send(httpRequest, response)) then begin
            response.Content().ReadAs(responseText);
            resJson.ReadFrom(responseText);
            if (resJson.Get('id', idJson)) then begin
                idJson.WriteTo(id);
                item."No. 2" := id;
            end;
        end;

        Message(responseText);
    end;
}