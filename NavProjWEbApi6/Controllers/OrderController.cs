using System.Net;
using System.Text;
using System.Text.Json;
using Microsoft.AspNetCore.Mvc;
using NavProjWEbApi6.Models;
using static System.Net.Mime.MediaTypeNames;

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
        Uri adress = new Uri(@"http://desktop-78qcrn9:7048/BC170/ODataV4/Company('CRONUS%20UK%20Ltd.')/OrderService");

        var credentialsCache = new CredentialCache();
            credentialsCache.Add(adress, "NTLM", new NetworkCredential(config["windows-email"], config["windows-pass"]));
            var handler = new HttpClientHandler() { Credentials = credentialsCache, PreAuthenticate = true };
        var httpClient= new HttpClient(handler);
        Console.WriteLine("hmm");
        using var httpResponseMessage=
            await httpClient.PostAsJsonAsync(adress,order.ToOdata());
        Console.WriteLine(httpResponseMessage);
        return Ok(httpResponseMessage);
    }
}
