namespace NavProjWEbApi6.Models;

public class Customer
    {
        public int id{get;set;}
        public string email{get;set;}
        public string first_name{get;set;}
        public string last_name{get;set;}
        public string username{get;set;}

        public OdataCustomer ToOdata(){
            return new OdataCustomer{
            id=id.ToString(),
            email=email,
            firstname=first_name,
            lastname=last_name/*,
            username=username*/
            };
        }
    }
