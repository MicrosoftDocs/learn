
You now have the knowledge and tools to model, measure, and monitor the efficiency of your Azure Cosmos DB collections. 

We've optimized the Orders collection for the online retail scenario. This database can now scale according to the needs of the business. You can apply these methods to your own scenario to make the most of the Azure Cosmos DB capacity that you've allocated.

## Clean up

It's important that you clean up any unused collections. You're charged for the configured capacity, not how much of the database is used. For this module, we made these resources available to you free of charge. But you should get into the habit of deleting resources when you're done with them.

1. Open the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).

1. Search for the sandbox resource group: <rgn>Sandbox Resource Group</rgn>.

1. Select your Azure Cosmos DB account.

1. Go to **Data Explorer**.

1. To delete the mslearn database, select the ellipsis (**...**) next to the database name.

1. Select **Delete**.

1. Enter the name of the database that you want to delete.

If you want to delete each collection individually, select the ellipsis (**...**) next to the collection and select **Delete**.

## Resources

To learn more about Azure Cosmos DB, see the following resources:

- [Azure Cosmos DB documentation](https://docs.microsoft.com/azure/cosmos-db/): This is the official Microsoft documentation for Azure Cosmos DB.
- [Azure Cosmos DB calculator](https://www.documentdb.com/capacityplanner#): This tool calculates Request Units for different workloads. This information is useful for estimating the volume of your JSON payload.
- [Azure Cosmos DB benchmark code](https://github.com/Azure/azure-cosmos-dotnet-v2/tree/master/samples/documentdb-benchmark): The utility code that you used in this module is based on this code.
