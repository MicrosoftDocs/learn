Create an instance of Cosmos DB to house all the metadata for each image that's uploaded to your web application.

1. Sign in to the [Azure portal](http://portal.azure.com).
2. In the left pane, select **All services**.
3. In the filter at the top, enter *cosmos*.
4. Select **Azure Cosmos DB**.
5. Select **Add**.
6. For **ID**, enter a unique ID (for example, *myCosmosDB*).
7. For API, select *Azure Table*.
8. Select the resource group that you created in the previous lab, *serverlessRG*.
9. For **Location**, verify that the location is the same as that of your storage account.
10. Select **Create**.

That's it! Now you have an Azure Cosmos DB instance.