using Models;

namespace NavProjWEbApi6.Models
{
    public class Order
    {
        public int id{get;set;}
        public int customer_id{get;set;}
        public string first_name{get;set;}
        public string last_name{get;set;}
        public string company{get;set;}
        public string region{get;set;}
        public string address_1{get;set;}
        public string address_2{get;set;}
        public string postcode{get;set;}
        public string city{get;set;}
        public string state{get;set;}
        public string phone{get;set;}
        public string email{get;set;}
        public string[] line_items{get;set;}

        public ODataOrder ToOdata(){
            return new ODataOrder{
                id=id,
                companyname=company,
                email=email,
                firstname=first_name,
                lastname=last_name,
                phone=phone,
                postcode=postcode,
                streetaddress=address_1 + address_2,
                region=state
                /*,lines=line_items.ToString()*/
                };
            }
        }
    }

