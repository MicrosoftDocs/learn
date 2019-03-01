PolyBase lets you import data from a variety of formats and sources to populate your data warehouse with all the data you need to analyze. In this module you've learned how to take data from an external source, format it, import it into blob storage and then use the built-in PolyBase tools to pull it into your Azure SQL Data warehouse. 

You can use the techniques explored in this module to populate your Azure SQL Data warehouse with whatever data you need.

## Cleanup

To avoid additional costs in your Azure account, delete the **mslearn-demodw** resource group. This will remove all of the resources we created in this module. Here's the steps you need to do.

1. Find the **mslearn-demodw** resource group - an easy way to do locate it is to select **Resource groups** in the Azure sidebar.

1. Select the resource group and either right-click on the row, or use the "..." button on the far-right side of the row to open the context menu.

1. Select **Delete resource group**.

    ![Screenshot showing the delete resource group menu](../media/8-cleanup.png)

1. Type the name of the resource group and click **Delete**. Azure will de-provision all of the resources for you.
