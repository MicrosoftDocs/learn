In this module, you've learned that SQL Data Warehouse is a cloud-based Enterprise Data Warehouse (EDW) that leverages Massively Parallel Processing (MPP) to run complex queries across petabytes of data quickly. You've learned how to optimize the storage of the data using Round Robin, Hash Distribution by using replicated tables, and finally, you created a data warehouse.

## Cleanup

To avoid additional costs in your Azure account, delete the **mslearn-demodw** resource group. This will remove all of the resources we created in this module. Here's the steps you need to do.

1. Find the **mslearn-demodw** resource group - an easy way to do locate it is to select **Resource groups** in the Azure sidebar.

1. Select the resource group and either right-click on the row, or use the "..." button on the far-right side of the row to open the context menu.

1. Select **Delete resource group**.

    ![Screenshot showing the delete resource group menu](../media/7-cleanup.png)

1. Type the name of the resource group and click **Delete**. Azure will de-provision all of the resources for you.