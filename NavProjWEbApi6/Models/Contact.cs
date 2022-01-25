namespace Models
{
    public class Contact
    {
        public string Name{get;set;}
        public string Name2 { get; set; }
        public string Address { get; set; }
        public string Address2 { get; set; }
        public string City { get; set; }
        public string Phone { get; set; }
        public string CurrencyCode {get;set;}
        public string LanguageCode { get; set; }
        public string CountryCode { get; set; }
        public string PostCode { get; set; }
        public string Email { get; set; }
        public string Type { get; set; }="Person";
        }
}