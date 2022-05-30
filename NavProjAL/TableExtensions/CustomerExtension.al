tableextension 50122 "Customer Extension" extends Customer
{
    fields
    {
        // Add changes to table fields here
    }

    trigger OnInsert()
    var
        MailCodeunit: Codeunit "Mail Mgt";
    begin
        MailCodeunit.Mail(Rec."E-Mail",
        'Welcome ' + Rec.Name + ' ' + Rec."Name 2",
        '<b>Hi,' + Rec.Name + ' ' + Rec."Name 2" + '</b>' +
        '<br> Your account has been created.' +
        '<br><br> Best regards, ' +
        '<br> WooCommerce'
        );

    end;
}