# BC/AL exam assignment

## Project – The web shop

After watching the lion’s den, you decided to put all your
IT hardware knowledge into start earning some money.
Your business idea is to start selling computer components – how hard can it be – by all means, you are a
developer!
Your goal is to keep your web frontend as slim as possible; it is merely the customer interface.
Together with some other students (2-4), you defined the following to-do list:
Use Woocommerce as the webshop frontend.
Use Dynamics as the central system.

Implement web service integration between Woocommerce and Dynamics.

✓   When a product is added to Dynamics it must be possible to export it to Woocommerce. 
50110(ItemExportMgt) + 50111(ItemExtension)

✓   When a customer is created in Woocommerce, then the customer should also be created in 
Dynamics. 
50120(CustomerApi) + 50121(ContactApi) + Api

✓   And send a welcome mail from Dynamics to the customer. 
Webhook hits ASP.net api, and uses webhook info to make new contact
50200(MailMgt) + 50122(CustomerExtension)

✓   When a customer buys products a sales order must be created in Dynamics.
50130(SalesLineApi) + 50131(SalesLineMgt) + Api
✓       Dynamics shall also mail an order confirmation to the customer.
50200(MailMgt) + 50131(SalesLineMgt)

Nice to have:
✓   Once a day, Dynamics shall mail your team, an overview of which and how many
products have been sold and summarize the turnover of the last 24 hours.
Note: since dates dont work in my student license it send an email of orders on s specific date.
50200(MailMgt) + 50140(Sales Overview) + 50141(SalesOrderListExtension)


### The WooCommerce – Dynamics BC 365 project was a success, the customer wants to buy your solution, they just want a few features.
The customer has the following requirements:
✓1.
The customer wants a chart, which can show:
The five most sold products for the last week and on which day they were sold. The product name must be
shown as a tooltip. If the user clicks on the chart item, 
*then drill down and show the product on the item card.
50150(WooSalesCard)

✓2.
Add a menu item to the existing “Sales” menu, the item must be called “WooCommerce”. See image Figur
1 New Action.
This action will show the chart described in requirement no. 1
50160(WooMenuItem)

✓3.
The customer forgot to tell you that they also have a physical shop; therefore it must be possible to see on
the “Item List” if a product is sold on the web shop, in the physical store or both
50111(ItemListExtension) + 50170(Item Page Extension)

✓4.
Add one more action to the “Sales” menu, the linked page must show the Amazon bestsellers of the
category electronics. This way it can easily be seen if there is a new product trend, which you should follow
in your shop. See Figur 2 Amazon bestsellers. The webpage must be shown “inside” Dynamics, not as an
external link.
50180(AmazonBestsellersPAge) + 50160(WooMenuItem)

✓5.
As fraud is an increasing problem for web shops, implement a solution, which detects if the same address
suddenly makes more than five purchases within 24 hours.
The solution must be a report which lists all customers with more than five purchases (Individual orders)
within the last 24 hours. The report is to be executed at 20 o’clock each day and the report is stored on the
hard drive, the filename must contain the date of execution.
50160(WooMenuItem) + 50190(FraudMgt)

Your solution and a description is to be uploaded. Notice you do not have to write a report, it is merely a
technical description of your solution.