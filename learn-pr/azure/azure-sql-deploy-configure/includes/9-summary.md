In this module and throughout the activities, you learned how to deploy and configure Azure SQL. By learning about the pre-deployment planning guidance and best practices, you'll be more prepared going into the deployment of Azure SQL Database or Azure SQL Managed Instance. You also got hands on and learned about the deployment process through the Azure portal.

After deployment, you dove deeper into running verification checks and configuring Azure SQL to meet your scenario's requirements. Finally, you learned how loading data into Azure SQL is similar to the process for SQL Server, except you now have more options available.

After you've deployed and configured Azure SQL, you'll likely look to make sure it meets your security needs. In the next module, you'll dive into the capabilities and tasks related to Azure SQL for securing your databases and instances.

## Learn more

### Video series: Azure SQL for beginners

People learn in different ways. With that in mind, a [video series related to this learning path](https://aka.ms/azuresql4beginnersyt?azure-portal=true) was created with Channel 9 on YouTube.

### Pre-deployment planning and migration to Azure

To learn more about how to migrate to Azure SQL, review the [Azure Database Migration Guide](/data-migration). It has custom guidance on how to migrate based on your source and target database. Also consider accessing the resources and support available through the [Azure Migration and Modernization Program](https://azure.com/ammp).  

One part of pre-deployment planning is determining which service tier and size are best for your workload. The Data Migration Assistant tool has a [SKU recommender](/sql/dma/dma-sku-recommend-sql-db) that can help you determine the number of vCores and the size. 

The hands-on exercises focused on Azure SQL Database. If you want to try out your new deployment and configuration toolbox in Azure SQL Managed Instance, see:

- [Migrate to Azure SQL Managed Instance](/azure/dms/tutorial-sql-server-managed-instance-online)
- [Quickstart: Create a managed instance](/azure/sql-database/sql-database-managed-instance-get-started?azure-portal=true)
- [Azure SQL Managed Instance pools](/azure/sql-database/sql-database-instance-pools-how-to#create-an-instance-pool?azure-portal=true)

You might also want to dive deeper into the resource limits based on service tier and configuration for [SQL Managed Instance](/azure/azure-sql/managed-instance/resource-limits?azure-portal=true) and [SQL Database](/azure/azure-sql/database/resource-limits-vcore-single-databases?azure-portal=true).

### Deploy, verify, and configure

Two common command-line tools for deploying, verifying, and configuring Azure SQL are the [Azure CLI](/cli/azure/?azure-portal=true) and [Azure PowerShell](/powershell/azure?azure-portal=true). You can also access both of these tools through [Azure Cloud Shell](/azure/cloud-shell/overview?azure-portal=true), which is an integrated terminal that supports Bash and PowerShell in the Azure portal.

#### Data max size

For more information about the difference between data space used, data space allocated, and **Data max size**, see [Manage file space for databases in Azure SQL Database](/azure/sql-database/sql-database-file-space-management#understanding-types-of-storage-space-for-a-database?azure-portal=true).

#### Connectivity to Azure SQL

You can find more information on connectivity for [Azure SQL Database](/azure/sql-database/sql-database-connectivity-architecture?azure-portal=true) and for [Azure SQL Managed Instance](/azure/sql-database/sql-database-managed-instance-connectivity-architecture?azure-portal=true). Upcoming sections and modules will also cover this topic.  

#### Azure Marketplace terms

Similar to the Microsoft Software License Terms (EULA) for SQL Server, you must accept [Azure Marketplace terms](https://azure.microsoft.com/support/legal/marketplace-terms/) before you deploy Azure SQL.

#### Resource governance

Resource governance from the Azure side is something new to consider in Azure SQL. You can [review how it works and read a blog post with more details](https://azure.microsoft.com/blog/resource-governance-in-azure-sql-database/?azure-portal=true).

#### Job management

To learn more about the differences between SQL Server Agent in SQL Server and in Azure SQL Managed Instance, see [T-SQL differences between SQL Server and Azure SQL Managed Instance](/azure/azure-sql/managed-instance/transact-sql-tsql-differences-sql-server#sql-server-agent?azure-portal=true). To learn about elastic jobs for Azure SQL Database, see [Create, configure, and manage elastic jobs](/azure/azure-sql/database/elastic-jobs-overview?azure-portal=true).

#### Load data

For more information about using Azure Data Factory to load data into Azure SQL Managed Instance and SQL Database, see [this documentation page](/azure/data-factory/connector-sql-server). Also, [here's a blog](https://techcommunity.microsoft.com/t5/datacat/turbo-boost-data-loads-from-spark-using-sql-spark-connector/ba-p/305523) detailing how to use Spark to load efficiently into Azure SQL.
