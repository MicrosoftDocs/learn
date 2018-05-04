## Create an Azure Cosmos DB instance

Create an instance of Cosmos DB to house all of the metadata for each image that's uploaded to your web application.

1. In the left pane, select **All services**.
2. In the filter at the top, enter *cosmos*.
3. Select **Azure Cosmos DB**.
4. Select **Add**.
5. For **ID**, enter a unique ID (for example, *myCosmosDB*).
6. For API, select *Azure Table*.
7. Select the resource group that you created in the previous lab, *serverlessRG*.
8. For **Location**, verify that the location is the same as that of your storage account.
9. Select **Create**.

That's it! Now you have an Azure Cosmos DB instance.