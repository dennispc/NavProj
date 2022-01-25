using Models;
using Newtonsoft.Json;

namespace NavProjWEbApi6.Models
{
    public class Order
    {
        public int id{get;set;}
        public int customer_id{get;set;}
        public dynamic billing{get;set;}
        public dynamic shipping{get;set;}
        public dynamic line_items{get;set;}
        public string date_created{get;set;}
        public string status{get;set;}
        public string currency{get;set;}
        public bool prices_include_tax{get;set;}
        public List<Item> lineItems{get=>JsonConvert.DeserializeObject<List<Item>>(line_items.ToString());}
        
        private Billing billingString{get=>JsonConvert.DeserializeObject<Billing>(billing.ToString());}
        private Shipping shippingString{get=>JsonConvert.DeserializeObject<Shipping>(shipping.ToString());}

        public SalesOrder ToSalesOrder(){
            return new SalesOrder{
                Sell_to_Customer_No=$"{customer_id.ToString()}",
                Document_Date=DateTime.Now.AddMonths(-3).ToString("yyyy-MM-dd"),
                Posting_Date=DateTime.Now.AddMonths(-3).ToString("yyyy-MM-dd"),
                Order_Date=DateTime.Now.AddMonths(-3).ToString("yyyy-MM-dd"),
                Due_Date=DateTime.Now.AddDays(3).AddMonths(-3).ToString("yyyy-MM-dd"),
                Requested_Delivery_Date=DateTime.Now.AddDays(1).AddMonths(-3).ToString("yyyy-MM-dd"),
                Promised_Delivery_Date=DateTime.Now.AddDays(1).AddMonths(-3).ToString("yyyy-MM-dd"),
                Currency_Code=currency,
                Prices_Including_VAT=prices_include_tax,
                //Sell_to_Address=billingString.address_1,
                //Sell_to_Address_2=billingString.address_2,
                //Sell_to_City=billingString.city,
                //Sell_to_County=billingString.state,
                //Sell_to_Post_Code=billingString.postcode,
                //Sell_to_Contact_No=$"{customer_id.ToString()}",
                //Sell_to_Phone_No=billingString.phone,
                //SellToMobilePhoneNo=billingString.phone,
                //Sell_to_E_Mail=billingString.email,
                //Sell_to_Contact=$"{billingString.first_name} {billingString.last_name}",
                //Salesperson_Code="WooCommerce",
                //Assigned_User_ID=customer_id.ToString(),
                //Job_Queue_Status=status,
                //Ship_to_Address=billingString.address_1,
                //Ship_to_Address_2=billingString.address_2,
                //Ship_to_City=billingString.city,
                //Ship_to_County=billingString.state,
                //Ship_to_Post_Code=billingString.postcode,
                //Ship_to_Contact=$"{billingString.first_name} {billingString.last_name}",
                //Bill_to_Address=billingString.address_1,
                //Bill_to_Address_2=billingString.address_2,
                //Bill_to_City=billingString.city,
                //Bill_to_County=billingString.state,
                //Bill_to_Post_Code=billingString.postcode,
                //Bill_to_Contact_No=$"{customer_id.ToString()}",
                //Bill_to_Contact=$"{billingString.first_name} {billingString.last_name}",
      
            };
        }
        }
    }

