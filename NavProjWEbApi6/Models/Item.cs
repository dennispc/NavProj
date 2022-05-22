namespace Models
{
    public class Item
    {
        public int id{get;set;}
        public int quantity{get;set;}
        public int DocumentNo { get; set; }
        public string sku{get;set;}
        public string OrderId{get;set;}
        public ODataItem ToOdataItem(){
            return new ODataItem{
                LineNo=id,
                ItemNo=sku,
                Quantity=quantity,
                OrderId=OrderId,
                DocumentNo=DocumentNo
            };
        }
    }
}