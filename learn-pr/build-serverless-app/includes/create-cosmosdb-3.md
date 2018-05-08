Create an instance of Cosmos DB to house all of the metadata for each image that is uploaded to your web application.

1. Sign in to the Azure portal at [http://portal.azure.com](http://portal.azure.com)
2. Select **All services** from the left context menu
3. In the filter at the top enter `cosmos`
4. Select **Azure Cosmos DB**
5. Select **Add**
6. Enter an unique ID: **my-cosmos-db**
7. Select the API: **Azure Table**
8. Select the resource group you created in the previous lab `serverlessRG`
9. Verify that the location is the same as your storage account
10. Select **Create**

That's it! Now you have an Azure Cosmos DB instance.