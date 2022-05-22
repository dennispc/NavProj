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
            await httpClient.PostAsJsonAsync(address,order.ToSalesOrder(),new JsonSerializerOptions{PropertyNameCaseInsensitive=true});
        var result = await httpResponseMessage.Content.ReadFromJsonAsync<Object>();
        //Console.WriteLine(httpResponseMessage);

        //@"http://desktop-78qcrn9:7048/BC170/ODataV4/Company('CRONUS%20UK%20Ltd.')/SalesLineApi"
        address = new Uri(@"http://desktop-78qcrn9:7048/BC170/ODataV4/SalesLineCodeUnit_addItem?company=CRONUS UK Ltd.");
        credentialsCache = new CredentialCache();
            credentialsCache.Add(address, "NTLM", new NetworkCredential(config["windows-email"], config["windows-pass"]));
        handler = new HttpClientHandler() { Credentials = credentialsCache, PreAuthenticate = true };
        httpClient= new HttpClient(handler);
        int DocumnetNo=int.Parse(JsonSerializer.Deserialize<SalesHeader>(result.ToString()).No);
        string OrderId=order.id.ToString();
        foreach(Item item in order.lineItems){
            item.OrderId=OrderId;
            item.DocumentNo=DocumnetNo;
            string str = JsonSerializer.Serialize(item.ToOdataItem());
            Encap encap = new Encap{item=str};
            //Console.WriteLine(JsonSerializer.Serialize(encap));
            using var httpResponseMessage2=
            await httpClient.PostAsJsonAsync(address,encap,new JsonSerializerOptions{PropertyNameCaseInsensitive=true});
            //result = await httpResponseMessage2.Content.ReadFromJsonAsync<Object>();
            //Console.WriteLine(httpResponseMessage2);

        }
        return Ok(StatusCodes.Status201Created);
    }
    public class Encap{
        public string item{get;set;}
    }
}
