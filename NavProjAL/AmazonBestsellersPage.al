page 50180 "Amazon page"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            usercontrol(ControlName; MyControlAddIn)
            {
                ApplicationArea = all;

                trigger Ready()
                begin

                    CurrPage.ControlName.embedHomePage();

                end;


            }
        }


    }

}