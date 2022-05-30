page 50121 "Contact Api"
{
    PageType = API;
    Caption = 'Contact Api';
    APIPublisher = 'dp';
    APIGroup = 'WooCommerce';
    APIVersion = 'v0.1';
    EntityName = 'ContactApi';
    EntitySetName = 'ContactsApi';
    SourceTable = Contact;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Name; Rec.Name) { }
                field(Name2; Rec."Name 2") { }
                field(Address; Rec.Address) { }
                field(Address2; Rec."Address 2") { }
                field(City; Rec.City) { }
                field(Phone; Rec."Phone No.") { }
                field(CurrencyCode; Rec."Currency Code") { }
                field("LanguageCode"; Rec."Language Code") { }
                field(CountryCode; Rec."Country/Region Code") { }
                field(PostCode; Rec."Post Code") { }
                field(Email; Rec."E-Mail") { }
                field(Type; Rec.Type) { }
            }
        }
    }
}