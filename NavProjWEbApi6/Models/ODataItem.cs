
namespace Models
{
    public class ODataItem
    {
        public int LineNo { get; set; }
        public int Quantity { get; set; }
        public int DocumentNo { get; set; }
        public string ItemNo { get; set; }
        public string OrderId { get; set; }
        public string DocumentType{get;set;}="Order";
    }
}