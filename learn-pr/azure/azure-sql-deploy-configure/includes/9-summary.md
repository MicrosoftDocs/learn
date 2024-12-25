In this module and throughout the activities, you learned how to deploy and configure Azure SQL. By learning about the predeployment planning guidance and best practices, you become more prepared going into the deployment of Azure SQL Database or Azure SQL Managed Instance. You also got hands on and learned about the deployment process through the Azure portal.

After deployment, you dove deeper into running verification checks and configuring Azure SQL to meet your scenario's requirements. Finally, you learned how loading data into Azure SQL is similar to the process for SQL Server, except you now have more options available.

After you've deployed and configured Azure SQL, you likely look to make sure it meets your security needs. In the next module, dive into the capabilities and tasks related to Azure SQL for securing your databases and instances.

## Learn more

### Video series: Azure SQL for beginners

People learn in different ways. With that in mind, a [video series related to this learning path](https://aka.ms/azuresql4beginnersyt?azure-portal=true) was created with Channel 9 on YouTube.

### Predeployment planning and migration to Azure

To learn more about how to migrate to Azure SQL, review the [Azure Database Migration Guide](/data-migration). It has custom guidance on how to migrate based on your source and target database. Also consider accessing the resources and support available through [Azure Innovate & Azure Migrate and Modernize](https://azure.microsoft.com/solutions/migration/migrate-modernize-innovate).  

One part of predeployment planning is determining which service tier and size are best for your workload. The Data Migration Assistant tool has a [SKU recommender](/sql/dma/dma-sku-recommend-sql-db) that can help you determine the number of vCores and the size.

The hands-on exercises focused on Azure SQL Database. If you want to try out your new deployment and configuration toolbox in Azure SQL Managed Instance, see:

- [What is Azure Database Migration Service?](/azure/dms/dms-overview?azure-portal=true)
- [Quickstart: Create an Azure SQL Managed Instance](/azure/sql-database/sql-database-managed-instance-get-started?azure-portal=true)
- [Create an instance pool (preview) - Azure SQL Managed Instance](/azure/azure-sql/managed-instance/instance-pools-configure?azure-portal=true)

You can dive deeper into the resource limits based on service tier and configuration for [SQL Managed Instance](/azure/azure-sql/managed-instance/resource-limits?azure-portal=true) and [SQL Database](/azure/azure-sql/database/resource-limits-vcore-single-databases?azure-portal=true).

### Deploy, verify, and configure

Two common command-line tools for deploying, verifying, and configuring Azure SQL are the [Azure CLI](/cli/azure/?azure-portal=true) and [Azure PowerShell](/powershell/azure?azure-portal=true). You can also access both of these tools through [Azure Cloud Shell](/azure/cloud-shell/overview?azure-portal=true), which is an integrated terminal that supports Bash and PowerShell in the Azure portal.

#### Data max size

For more information about the difference between data space used, data space allocated, and **Data max size**, see [Manage file space for databases in Azure SQL Database](/azure/azure-sql/database/file-space-manage#understanding-types-of-storage-space-for-a-database?azure-portal=true).

#### Azure Marketplace terms

Similar to the Microsoft Software License Terms (EULA) for SQL Server, you must accept [Azure Marketplace terms](/legal/marketplace/marketplace-terms) before you deploy Azure SQL.

#### Resource governance

Resource governance from the Azure side is something new to consider in Azure SQL. You can [review how it works and read a blog post with more details](https://azure.microsoft.com/blog/resource-governance-in-azure-sql-database/?azure-portal=true).

#### Job management

To learn more about the differences between SQL Server Agent in SQL Server and in Azure SQL Managed Instance, see [T-SQL differences between SQL Server and Azure SQL Managed Instance](/azure/azure-sql/managed-instance/transact-sql-tsql-differences-sql-server#sql-server-agent?azure-portal=true). To learn about elastic jobs for Azure SQL Database, see [Create, configure, and manage elastic jobs](/azure/azure-sql/database/elastic-jobs-overview?azure-portal=true).

#### Load data

For more information about using Azure Data Factory to load data into Azure SQL Managed Instance and SQL Database, see [Copy and transform data using Azure Data Factory](/azure/data-factory/connector-azure-sql-database) or [Import a bacpac file to a database in Azure SQL Database or Azure SQL Managed Instance](/azure/azure-sql/database/database-import).

## Clean up your resources

You created resources in your Azure subscription as part of this exercise. If you leave them running, they can cost you money. To remove the resources you created, you can just delete the resource group you created at in this module's first exercise. Go to the resource group in the Azure portal and select **Delete resource group** in the toolbar at the top of the Overview page. Enter the resource group's name to confirm deletion, select **Delete**, then select **Delete** again to delete your resource group and its resources.
