Tailspin Toys tasked you with creating a solution for improving performance and resource utilization in the database associated with their multi-tenant SaaS application. By migrating to a multi-node Azure Cosmos DB for PostgreSQL database, you horizontally scaled the database and isolated larger tenants to meet this goal. By distributing Tailspin Toys' database across nodes in a multi-node Azure Cosmos DB for PostgreSQL database, you position their multi-tenant SaaS application for future growth.

In this module, you learned how to efficiently migrate a single-node database for a multi-tenant SaaS application to a multi-node instance with minimal application disruption. You also examined how to prepare and distribute tables to work effectively in a multi-node database and how to use monitoring to identify "noisy" tenants and isolate them onto dedicated nodes in the cluster.

In this module, you prepared tables in a single-node database for distribution and transitioned from a single-node to a multi-node database in Azure Cosmos DB for PostgreSQL. Using the multi-node database, you distributed multi-tenant tables across nodes, while ensuring the changes resulted in minimal application impact. You also monitored utilization of a multi-tenant database using multiple built-in views and functions in Azure Cosmos DB for PostgreSQL.

## Clean up

To ensure you aren't charged for the configured capacity of the resources you created for the exercises in this module, it's essential that you clean up any provisioned resources. If you didn't delete your resource group in Unit 8 - Exercise - Monitoring and Tenant Isolation, follow these instructions:

1. Open a web browser and navigate to the [Azure portal](https://portal.azure.com/).
2. In the left-hand navigation menu, select **Resource Groups**, and then select the `learn-cosmosdb-postgresql` resource group you created as part of the exercise in Unit 3.
3. In the **Overview** pane, select **Delete resource group**.
4. Enter the name of the resource group you created to confirm and then select **Delete**.

## References

> [!TIP]
>
> To open a hyperlink, right-click and choose **Open in new tab or window**. That way, you can see the resource and quickly return to the module.

- [Azure Cosmos DB for PostgreSQL documentation](/azure/cosmos-db/postgresql/introduction)
- [Model multi-tenant SaaS apps](/azure/cosmos-db/postgresql/quickstart-build-scalable-apps-model-multi-tenant)
- [Characteristics of multi-tenant SaaS applications](/azure/cosmos-db/postgresql/quickstart-build-scalable-apps-classify#characteristics-of-multi-tenant-saas)
- [Pick an initial cluster size for multi-tenant SaaS database](/azure/cosmos-db/postgresql/howto-scale-initial#multi-tenant-saas)
- [How to choose shard count for a multi-tenant SaaS database](/azure/cosmos-db/postgresql/howto-shard-count#multi-tenant-saas-use-case)
- [Monitor and tune Azure Cosmos DB for PostgreSQL](/azure/cosmos-db/postgresql/concepts-monitoring)
- [How to view metrics in Azure Cosmos DB for PostgreSQL](/azure/cosmos-db/postgresql/howto-monitoring)
- [Tenant isolation in Azure Cosmos DB for PostgreSQL](https://docs.citusdata.com/en/v11.1/admin_guide/cluster_management.html#tenant-isolation)
- [Isolate tenant to new shard](/azure/cosmos-db/postgresql/reference-functions#isolate_tenant_to_new_shard)
- [Rebalance tenant shards to new nodes](/azure/cosmos-db/postgresql/howto-scale-rebalance)]
- [Horizontally scale an Azure Cosmos DB for PostgreSQL database](/azure/cosmos-db/postgresql/howto-scale-grow)]
