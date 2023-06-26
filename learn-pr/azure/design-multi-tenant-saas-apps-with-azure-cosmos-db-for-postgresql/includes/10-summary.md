Tailspin Toys asked you to create a solution to improve performance and resource utilization in the database that's associated with the company's multitenant SaaS application. By migrating to a multi-node Azure Cosmos DB for PostgreSQL instance, you horizontally scaled the database and isolated larger tenants to meet this goal. By distributing the Tailspin Toys database across nodes in a multi-node Azure Cosmos DB for PostgreSQL cluster, you position the Tailspin Toys multitenant SaaS application for future growth.

In this module, you learned how to efficiently migrate a single-node database for a multitenant SaaS application to a multi-node instance with minimal application disruption. You also examined how to prepare and distribute tables to work effectively in a multi-node cluster and how to use monitoring to identify "noisy" tenants and isolate them in dedicated nodes in the cluster.

You prepared tables in a single-node database for distribution and transitioned from a single-node database to a multi-node cluster in Azure Cosmos DB for PostgreSQL. By using the multi-node cluster, you distributed multitenant tables across nodes, while ensuring that the changes resulted in minimal application impact. You also monitored utilization of a multitenant database by using multiple built-in views and functions in Azure Cosmos DB for PostgreSQL.

## Clean up resources

To ensure that you aren't charged for the configured capacity of the resources that you created for the exercises in this training module, it's essential that you clean up any provisioned resources. If you didn't delete your resource group in the final exercise, follow these instructions:

1. Open a web browser and go to the [Azure portal](https://portal.azure.com/).
1. On the left menu, select **Resource Groups**, and then select the **learn-cosmosdb-postgresql** resource group that you created in the first exercise.
1. On **Overview**, select **Delete resource group**.
1. To confirm the deletion, enter the name of the resource group that you created, and then select **Delete**.

## Learn more

- [Azure Cosmos DB for PostgreSQL documentation](/azure/cosmos-db/postgresql/introduction?azure-portal=true)
- [Model multitenant SaaS apps](/azure/cosmos-db/postgresql/quickstart-build-scalable-apps-model-multi-tenant?azure-portal=true)
- [Characteristics of multitenant SaaS applications](/azure/cosmos-db/postgresql/quickstart-build-scalable-apps-classify#characteristics-of-multi-tenant-saas?azure-portal=true)
- [Pick an initial cluster size for a multitenant SaaS database](/azure/cosmos-db/postgresql/howto-scale-initial#multi-tenant-saas?azure-portal=true)
- [How to choose shard count for a multitenant SaaS database](/azure/cosmos-db/postgresql/howto-shard-count#multi-tenant-saas-use-case?azure-portal=true)
- [Monitor and tune Azure Cosmos DB for PostgreSQL](/azure/cosmos-db/postgresql/concepts-monitoring?azure-portal=true)
- [How to view metrics in Azure Cosmos DB for PostgreSQL](/azure/cosmos-db/postgresql/howto-monitoring?azure-portal=true)
- [Tenant isolation in Azure Cosmos DB for PostgreSQL](https://docs.citusdata.com/en/v11.1/admin_guide/cluster_management.html#tenant-isolation?azure-portal=true)
- [Isolate a tenant in a new shard](/azure/cosmos-db/postgresql/reference-functions#isolate_tenant_to_new_shard?azure-portal=true)
- [Rebalance tenant shards to new nodes](/azure/cosmos-db/postgresql/howto-scale-rebalance?azure-portal=true)
- [Horizontally scale an Azure Cosmos DB for PostgreSQL database](/azure/cosmos-db/postgresql/howto-scale-grow?azure-portal=true)
