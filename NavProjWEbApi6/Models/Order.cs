using Models;
using Newtonsoft.Json;

namespace NavProjWEbApi6.Models
{
    public class Order
    {
        public int id{get;set;}
        public int customer_id{get;set;}
        public dynamic billing{get;set;}
        public dynamic line_items{get;set;}
        public string date_created{get;set;}
        private Item[] lineItems{get=>JsonConvert.DeserializeObject<Item[]>(line_items.ToString());}
        private string lineItemsString(){
            string res = "";
            for(int i=0 ; i < lineItems.Count();i++)
            {
                var item = lineItems[i];
                res+=$"{item.product_id},{item.quantity}";
                if(i<lineItems.Count()-1)
                {
                    res+=",";
                } 
            }
            return res;
        }
        private Billing jsonString{get=>JsonConvert.DeserializeObject<Billing>(billing.ToString());}

        public ODataOrder ToOdata(){
            return new ODataOrder{
                id=id,
                companyname=jsonString.company,
                email=jsonString.email,
                firstname=jsonString.first_name,
                lastname=jsonString.last_name,
                phone=jsonString.phone,
                postcode=jsonString.postcode,
                streetaddress=jsonString.address_1 + jsonString.address_2,
                region=jsonString.state,
                datecreated=date_created,
                lines=lineItemsString()
                };
            }
        }
    }

