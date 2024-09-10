Our marketing team needed to gauge customer response to our new shoe. We wanted to monitor social media, determine customer reaction, and route the data to a database or to customer service based on sentiment.

The Azure Logic Apps integration platform lets us automate this business process by creating a logic app workflow. We mapped each step in our workflow to available components. Our workflow used the X trigger to detect mentions of our product and launch the subsequent steps, based on the tweet sentiment. The Azure AI services action let us analyze whether the tweets were positive or negative. A control action helped us decide where to route the tweet based on sentiment. Finally, we used actions to insert a row in SQL Server and send an Outlook email.

Imagine the work necessary to build this app from scratch. We'd have to write code to access each of the services' APIs. We'd need a polling infrastructure to monitor X, and trigger our logic app workflow when new tweets were available. After all the code was ready, we'd need servers to host the app.

Azure Logic Apps made creating this monitoring app easy. Connectors did the hard work of integrating systems that were never designed to work together. Building the app took us less than an hour, and we didn't have to write any code or set up any servers. We can now analyze every tweet about our product and our business analytics can use the data to shape future products.

## Clean up

Resources that you leave running can cost you money, so it's a good idea to delete the resources you created for this module. To delete your resources:

### Delete the resource group

1. In the Azure portal, select the portal menu on the left side of the screen.
1. Select **Resource groups** in the menu.
1. In the list of resource groups, find and select the resource group you created for this module.
1. At the top of the screen, select **Delete resource group**.
1. Enter the resource group name, then select **Delete**.
1. Select **Delete** again to confirm deletion.

By deleting the resource group, you also delete all the resources contained in it.

### Delete the SQL server

1. In the Azure portal, search for and select **SQL Servers**.
1. In the list, select the SQL Server we created for this exercise (it's named *mslearn-exercise-sqlserver-xxxxxx*, with the x's replaced with a random string).
1. At the top of the overview page, select **Delete**. If you don't see the **Delete** button, select the ellipses (**...**) and select **Delete**.
1. Select **Skip feedback**, then type the server name into the box and select **Delete**.

By deleting the SQL server, you also delete the SQL database you created for this module.
