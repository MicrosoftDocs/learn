Woodgrove Bank tasked you with optimizing data ingestion and improving query performance for the distributed tables in their Azure Cosmos DB for PostgeSQL database. You were asked to provide methods of loading both historical and current data. Using standard PostgreSQL INSERT commands, you optimized the ingestion of transaction events from the contactless payment app. You accomplished this optimization by batching multiple rows into a single INSERT statement to minimize the number of queries against the database. The `COPY` command allowed you to bulk load their historical data into distributed tables efficiently.

You then explored how to query data from distributed tables, learning about how to effectively write join and aggregation queries. You also examined various server parameters you can use to tune a cluster to achieve the best performance.

In this module, you learned about how to efficiently load and query distributed tables in an Azure Cosmos DB for PostgreSQL database. You also learned about sharding and query-data movement when working with distributed data.

Now that you've completed this module, you should be able to:

- Efficiently ingest data into distributed tables.
- Execute queries against distributed data.
- View how data is distributed across nodes in a cluster.
- Monitor and manage distributed tables.

## Clean up

It's important that you clean up any unused resources. You're charged for the configured capacity, not how much the database is used. If you didn't delete your resource group at the end of Unit 9, follow these instructions:

1. Open a web browser and navigate to the [Azure portal](https://portal.azure.com/).
1. In the left-hand navigation menu, select **Resource Groups**, and then select the resource group you created as part of the exercise in Unit 3.
1. In the **Overview** pane, select **Delete resource group**.
1. Enter the name of the resource group you created to confirm and then select **Delete**.
1. Select **Delete** again to confirm deletion.

## Use these resources to discover more

> [!TIP]
> To open a hyperlink, right-click and choose **Open in new tab or window**. That way, you can see the resource and easily return to the module.

- [Azure Cosmos DB for PostgreSQL documentation](/azure/postgresql/hyperscale/)
- [Run distributed queries in Azure Cosmos DB for PostgreSQL](/azure/postgresql/hyperscale/quickstart-run-queries)
