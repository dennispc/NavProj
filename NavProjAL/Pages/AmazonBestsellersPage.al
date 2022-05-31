page 50180 "Amazon Page"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            usercontrol(ControlName; AmazonEmbed)
            {
                ApplicationArea = all;

                trigger Ready()
                begin

                    CurrPage.ControlName.EmbedHomePage();

                end;
            }
        }
    }
}