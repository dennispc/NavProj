using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Models
{
    public class SalesOrder
    {
            public string Document_Type{get;set;}="Order";
            public string Sell_to_Customer_No{get;set;}
            public string Posting_Description{get=>$"Order from {Sell_to_Customer_No}";}
            public string Document_Date{get;set;}//"2022-01-13",
            public string Posting_Date{get;set;} //"2022-01-28",
            public string Order_Date{get;set;}// "2022-01-13",
            public string Due_Date{get;set;} //2022-01-31",
            public string Requested_Delivery_Date{get;set;}// "0001-01-01",
            public string Promised_Delivery_Date{get;set;}// "0001-01-01",
            //public string Status{get;set;}="Released";
            public string Currency_Code{get;set;}
            public bool Prices_Including_VAT{get;set;}
            public string Shipment_Method_Code{get;set;}
            public string Shipping_Agent_Code{get;set;}
            public string Shipping_Agent_Service_Code{get;set;}
            public string Package_Tracking_No{get;set;}
            public string Location_Code{get;set;}
            public string Shipment_Date{get;set;}//2022-01-13",
            public string Shipping_Advice{get;set;}
            public string Outbound_Whse_Handling_Time{get;set;}
            public string Shipping_Time{get;set;}
            public bool Late_Order_Shipping{get;set;}
            public bool Combine_Shipments{get;set;}
            public string Transaction_Specification{get;set;}
            public string Transaction_Type{get;set;}
            public string Transport_Method{get;set;}
            public string Exit_Point{get;set;}
            public string Area{get;set;}
            public bool Compress_Prepayment{get;set;}=true;
            public string Prepmt_Payment_Terms_Code{get;set;}
            public string Prepayment_Due_Date{get;set;}//2022-01-31",
            public string Prepmt_Payment_Discount_Percent{get;set;}
            public string Prepmt_Pmt_Discount_Date{get;set;}//2022-01-13",
            //public string Sell_to_Customer_Name{get;set;}
            //public int Quote_No{get;set;}
            //public string Sell_to_Address{get;set;}
            //public string Sell_to_Address_2{get;set;}
            //public string Sell_to_City{get;set;}
            //public string Sell_to_County{get;set;}
            //public string Sell_to_Post_Code{get;set;}
            //public string Sell_to_Country_Region_Code{get;set;}
            //public string Sell_to_Contact_No{get;set;}
            //public string Sell_to_Phone_No{get;set;}
            //public string SellToMobilePhoneNo{get;set;}
            //public string Sell_to_E_Mail{get;set;}
            //public string Sell_to_Contact{get;set;}
            //public string External_Document_No{get;set;}
            //public string Your_Reference{get;set;}
            //public string Salesperson_Code{get;set;}
            //public string Campaign_No{get;set;}
            //public string Opportunity_No{get;set;}
            //public string Responsibility_Center{get;set;}
            //public string Assigned_User_ID{get;set;}
            //public string Job_Queue_Status{get;set;}
            //public string WorkDescription{get;set;}
            //public string VAT_Bus_Posting_Group{get;set;}
            //public string Payment_Terms_Code{get;set;}
            //public string Payment_Method_Code{get;set;}
            //public bool EU_3_Party_Trade{get;set;}
            //public string SelectedPayments {get;set;}
            //public string Shortcut_Dimension_1_Code{get;set;}
            //public string Shortcut_Dimension_2_Code{get;set;}
            //public string payment_Discount_Percent{get;set;}
            //public string mt_Discount_Date{get;set;} //2022-01-13",
            //public int Direct_Debit_Mandate_ID{get;set;}
            //public string ShippingOptions{get;set;}="Sell-to Address";
            //public string Ship_to_Code{get;set;}
            //public string Ship_to_Name{get;set;}
            //public string Ship_to_Address{get;set;}
            //public string Ship_to_Address_2{get;set;}
            //public string Ship_to_City{get;set;}
            //public string Ship_to_County{get;set;}
            //public string Ship_to_Post_Code{get;set;}
            //public string Ship_to_Country_Region_Code{get;set;}
            //public string Ship_to_Contact{get;set;}
            //public string BillToOptions{get;set;}="Customer";
            //public string Bill_to_Name{get;set;}
            //public string Bill_to_Address{get;set;}
            //public string Bill_to_Address_2{get;set;}
            //public string Bill_to_City{get;set;}
            //public string Bill_to_County{get;set;}
            //public string Bill_to_Post_Code{get;set;}
            //public string Bill_to_Country_Region_Code{get;set;}
            //public string Bill_to_Contact_No{get;set;}
            //public string Bill_to_Contact {get;set;}
            //public string BillToContactPhoneNo{get;set;}
            //public string BillToContactMobilePhoneNo{get;set;}
            //public string BillToContactEmail{get;set;}
            //public string Prepayment_Percent{get;set;}="0.0";
            //public string Date_Filter{get;set;}="..01/01/22";
        
    }
}