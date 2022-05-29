tableextension 50123 CustomerExtension extends Customer
{
    fields
    {
        // Add changes to table fields here
    }

    var
        myInt: Integer;


    trigger OnInsert()
    var
        mailCodeunit: Codeunit "Mail Codeunit";
    begin
        mailCodeunit.mail(Rec."E-Mail",
        'Welcome ' + Rec.Name + ' ' + Rec."Name 2",
        '<b>Hi,' + Rec.Name + ' ' + Rec."Name 2" + '</b>' +
        '<br> Your account has been created.' +
        '<br><br> Best regards, ' +
        '<br> WooCommerce'
        );

    end;
}