In this module and throughout the activities, you learned how to deploy and configure Azure SQL. In the next module, you'll dive into security for Azure SQL.  

## Learn more

### Pre-deployment planning and Migration to Azure

To learn more about how to migrate to Azure SQL, you should review datamigration.microsoft.com, which has custom guidance on how to migrate based on your source and target database. Additionally, you should consider accessing the various resources and support available through the Azure Migrate Program (AMP) at azure.com/amp.  

One specific call out related to pre-deployment planning is around determining which service tier and size is best for your workload. The Data Migration Assistant tool (DMA) has a [SKU Recommender](https://docs.microsoft.com/sql/dma/dma-sku-recommend-sql-db?view=sql-server-ver15) that can help you determine the number of vCores and size.  

Additionally, while the hands-on exercises focused on Azure SQL Database, here is guidance on [how to migrate to Azure SQL Managed Instance](https://docs.microsoft.com/azure/sql-database/sql-database-managed-instance-migrate) specifically, and [here is a Quickstart](https://docs.microsoft.com/azure/sql-database/sql-database-managed-instance-get-started) if you'd like to try out your new deploy and configure toolbox in Azure SQL Managed Instance. There is also additional guidance on [Azure SQL Instance pools](https://docs.microsoft.com/azure/sql-database/sql-database-instance-pools-how-to#create-an-instance-pool).

### Deploy, Verify, and Configure

Two common command-line tools for deploying, verifying, and configuring Azure SQL include the [Azure CLI](https://docs.microsoft.com/cli/azure/?view=azure-cli-latest) and the [Azure PowerShell](https://docs.microsoft.com/powershell/azure) modules. The links included will provide references and explanations around the capabilities. You can also access both of these tools through the [Azure Cloud Shell](https://docs.microsoft.com/azure/cloud-shell/overview), which is an integrated terminal that supports bash and PowerShell in the Azure portal.

#### Data max size

For more information about the difference between data space used, data space allocated, and data max size, refer to this [explanation in the documentation](https://docs.microsoft.com/azure/sql-database/sql-database-file-space-management#understanding-types-of-storage-space-for-a-database).

#### Connectivity to Azure SQL

More information on connectivity for Azure SQL Database can be found [here](https://docs.microsoft.com/azure/sql-database/sql-database-connectivity-architecture) and for Azure SQL Managed Instance [here](https://docs.microsoft.com/azure/sql-database/sql-database-managed-instance-connectivity-architecture). There will also be more on this topic in upcoming sections/modules.  

#### Azure marketplace terms

Similar to the EULA for SQL Server, there exists [Azure Marketplace terms](https://go.microsoft.com/fwlink/?linkid=2045624) which must be accepted before deploying Azure SQL.

