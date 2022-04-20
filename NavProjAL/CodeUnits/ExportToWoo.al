codeunit 50156 "Export Product"
{

    procedure exportToWoocommerce(product: Record Product)
    var
        client: HttpClient;
        content: HttpContent;
        response: HttpResponseMessage;
        request: HttpRequestMessage;
        header: HttpHeaders;
        json: JsonObject;
        jsonText: Text;
        result: Boolean;
        responseText: Text;
        requestURI: Text;
    begin
        json.AsToken().WriteTo(jsonText);
        content.WriteFrom(jsonText);
        Message(jsonText);
        content.GetHeaders(header);
        header.Clear();
        header.Add('Content-Type', 'application/json');
        request.Content := content;
        requestURI := 'https://localhost/wordpress/wp-json/wc/v3/products';
        requestURI += '?name=' + product.Name;
        requestURI += '?id=' + Format(product.id);
        requestURI += '?paragraph=' + product.Paragraph;
        requestURI += '?price=' + Format(product.Price);
        request.SetRequestUri(requestURI);
        request.Method := 'POST';
        client.Send(request, response);
        response.Content().ReadAs(responseText);
        Message(responseText);
    end;
}