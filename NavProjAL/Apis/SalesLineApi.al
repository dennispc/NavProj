page 50131 SalesLineApi
{
    PageType = API;
    Caption = 'Sales Line Api';
    APIPublisher = 'publisherName';
    APIGroup = 'groupName';
    APIVersion = 'v0.0';
    EntityName = 'SalesLine';
    EntitySetName = 'SalesLineApi';
    SourceTable = "Sales Line";
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(OrderId; Rec."No.") { }
                field(LineNo; Rec."Line No.") { }
                field(LineAmount; Rec."Line Amount") { }
                field(ItemNo; Rec."Item Reference No.") { }
                field(Quantity; Rec.Quantity) { }
                field(DocumentNo; Rec."Document No.") { }
                field(DocumentType; Rec."Document Type") { }
            }
        }
    }
}