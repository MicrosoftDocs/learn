Woodgrove Bank tasked you with extending the capabilities of their Azure Cosmos DB for PostgreSQL database using PostgreSQL extensions. They asked for the ability to create scheduled jobs and functionality that would allow them to store geospatial data. They also needed the ability to ingest file data directly from an Azure Storage account.

Using various extensions, you updated their database to provide the requested capabilities. In this module, you learned about the Citus extension for PostgreSQL and how it enables the distributed capabilities that provide Azure Cosmos DB for PostgreSQL with its high performance and scalability features. You also used extensions to enhance and extend the functionality of Azure Cosmos DB for PostgreSQL, including using the `pg_azure_storage` extension for bulk loading historical data from a blob storage account.

Now that you've completed this module, you should be able to:

- Install different extensions available in Azure Cosmos DB for PostgreSQL.
- Extend the functionality of an Azure Cosmos DB for PostgreSQL database using extensions.

## Clean up

It's essential that you clean up any unused resources. You're charged for the configured capacity, not how much the database is used. If you didn't delete your resource group in Unit 6, follow these instructions:

1. Open a web browser and navigate to the [Azure portal](https://portal.azure.com/).
1. In the left-hand navigation menu, select **Resource Groups**, and then select the resource group you created as part of the exercise in Unit 3.
1. In the **Overview** pane, select **Delete resource group**.
1. Enter the name of the resource group you created to confirm and then select **Delete**.
1. Select **Delete** again to confirm deletion.

## Use these resources to discover more

> [!TIP]
> To open a hyperlink, right-click and choose **Open in new tab or window**. That way, you can see the resource and quickly return to the module.

- [Azure Cosmos DB for PostgreSQL documentation](/azure/postgresql/hyperscale/overview)
- [Supported extensions in Azure Cosmos DB for PostgreSQL](/azure/postgresql/hyperscale/reference-extensions)
- [Citus extension for PostgreSQL](https://github.com/citusdata/citus)
