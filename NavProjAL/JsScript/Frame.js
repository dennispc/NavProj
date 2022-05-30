function createIframe()
 
{
 
var placeholder = document.getElementById('controlAddIn');
 
var webPage = document.createElement('iframe');
 
webPage.id = 'webPage';
 
webPage.height = '100%';
 
webPage.width = '100%';
 
placeholder.appendChild(webPage);
 
}
 
 
function EmbedHomePage()
 
{
 
createIframe();
 
var webPage = document.getElementById('webPage');
 
webPage.src = 'https://www.amazon.com/Best-Sellers-Electronics/zgbs/electronics/ref=zg_bs_nav_0';
 
}