using System.Net;
using System.Text.Json;
using Microsoft.AspNetCore.Mvc;
using Models;
using NavProjWEbApi6.Models;

namespace NavProjWEbApi6.Controllers;

[ApiController]
[Route("[controller]")]
public class OrderController : ControllerBase
{
    private readonly IHttpClientFactory httpClientFactory;
    private readonly IConfiguration config;
        public OrderController(IHttpClientFactory _httpClientFactory, IConfiguration _config){
        httpClientFactory = _httpClientFactory;
        config=_config;
    }


    [HttpPost]
    public async Task<ActionResult> Post([FromBody] Order order)
    {
        Uri address = new Uri(@"http://desktop-78qcrn9:7048/BC170/ODataV4/Company('CRONUS%20UK%20Ltd.')/SalesOrder");

        var credentialsCache = new CredentialCache();
            credentialsCache.Add(address, "NTLM", new NetworkCredential(config["windows-email"], config["windows-pass"]));
            var handler = new HttpClientHandler() { Credentials = credentialsCache, PreAuthenticate = true };
        var httpClient= new HttpClient(handler);
        using var httpResponseMessage=
            await httpClient.PostAsJsonAsync(address,order.ToSalesOrder(),new JsonSerializerOptions{PropertyNamingPolicy=null,PropertyNameCaseInsensitive=true});
        var result = await httpResponseMessage.Content.ReadFromJsonAsync<Object>();
        Console.WriteLine(httpResponseMessage);
        await PostOrderLines(new Encap(order,result));
        return Ok();
    }

    public async Task<ActionResult> PostOrderLines(Encap encap){
        Uri address = new Uri(@"http://desktop-78qcrn9:7048/BC170/ODataV4/Company('CRONUS%20UK%20Ltd.')/SalesLineApi");
        var credentialsCache = new CredentialCache();
            credentialsCache.Add(address, "NTLM", new NetworkCredential(config["windows-email"], config["windows-pass"]));
        var handler = new HttpClientHandler() { Credentials = credentialsCache, PreAuthenticate = true };
        HttpClient httpClient= new HttpClient(handler);
        foreach(Item item in encap.order.lineItems){
            item.OrderId=encap.order.id.ToString();
            item.DocumentNo=JsonSerializer.Deserialize<SalesHeader>(encap.obj.ToString()).No;
            using var httpResponseMessage2=
            await httpClient.PostAsJsonAsync(address,item.ToOdataItem(),new JsonSerializerOptions{PropertyNamingPolicy=null,PropertyNameCaseInsensitive=true});
            Console.WriteLine(httpResponseMessage2);
        }
        return Ok();
    }
    public class Encap{
        public Encap(Order _order, Object _obj){
            order=_order;
            obj=_obj;
            Console.WriteLine(obj.ToString());
        }
        public Order order { get; set; }
        public Object? obj { get; set; }
    }
}
