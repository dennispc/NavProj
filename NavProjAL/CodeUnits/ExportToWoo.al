codeunit 50156 "Export Product"
{

    procedure exportToWoocommerce(product: Record Product)
    var
        client: HttpClient;
        content: HttpContent;
        response: HttpResponseMessage;
        request: HttpRequestMessage;
        header: HttpHeaders;
        header2: HttpHeaders;
        json: JsonObject;
        jsonText: Text;
        result: Boolean;
        responseText: Text;
        requestURI: Text;
    begin
        json.Add('name', product.Name);
        json.Add('price', product.Price);

        json.AsToken().WriteTo(jsonText);
        content.GetHeaders(header);
        content.WriteFrom(jsonText);
        header.Clear();
        header.Add('Content-Type', 'application/json');
        request.Content := content;
        request.GetHeaders(header2);
        header2.Add('Authorization', 'Basic Y2tfMmEyNTVkMWU0MDNmYmRkZjRiYTI1YWEyMDFjOGYzYWNhYzJmMTZlMzpjc19iZWZiNDJhM2QzYWQ2NGQ5Y2JiZGFlMzE3NDUyZTIyZWZlZmQ5YTY3');
        requestURI := 'https://localhost/wordpress/wp-json/wc/v2/products';
        request.SetRequestUri(requestURI);
        request.Method := 'POST';
        client.Send(request, response);
        response.Content().ReadAs(responseText);
        Message(responseText);
    end;
}