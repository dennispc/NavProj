page 50121 CustomerAPI
{
    PageType = API;
    Caption = 'api for customer';
    APIPublisher = 'publisherName';
    APIGroup = 'groupName';
    APIVersion = 'v0.1';
    EntityName = 'CustomerSet';
    EntitySetName = 'CustomerSetName';
    SourceTable = Customer;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(id; Rec."No.")
                {

                }
                field(email; Rec."E-Mail")
                {

                }
                field(firstname; Rec.Name)
                {

                }
                field(lastname; Rec."Name 2")
                {

                }
                field(gbc; Rec."Gen. Bus. Posting Group")
                {

                }
                field(cpg; Rec."Customer Posting Group") { }
            }
        }
    }
}