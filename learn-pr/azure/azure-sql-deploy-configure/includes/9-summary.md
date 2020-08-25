In this module and throughout the activities, you learned how to deploy and configure Azure SQL. By learning about the pre-deployment planning guidance and best practices, you'll be more prepared going into the deployment of Azure SQL Database or Azure SQL Managed Instance. You also got hands on and learned about the deployment process using the Azure portal.

Following deployment, you dove deeper into running verification checks and configuring Azure SQL to meet your scenario's requirements. Finally, you learned how loading data into Azure SQL is similar to SQL Server, except you now have some additional options available.

After you've deployed and configured Azure SQL, you'll likely look to make sure it meets your security needs. In the next module, you'll dive into the capabilities and tasks related to Azure SQL for securing your databases and instances.

## Learn more

### Video series: Azure SQL for beginners

People learn in different ways. With that in mind, a video series related to this learning path was created with Channel 9 on YouTube. [You can access all 60+ videos here](https://aka.ms/azuresql4beginnersyt?azure-portal=true).

### Pre-deployment planning and Migration to Azure

To learn more about how to migrate to Azure SQL, you should review datamigration.microsoft.com, which has custom guidance on how to migrate based on your source and target database. Additionally, you should consider accessing the various resources and support available through the Azure Migrate Program (AMP) at azure.com/amp.  

One specific call out related to pre-deployment planning is around determining which service tier and size is best for your workload. The Data Migration Assistant tool (DMA) has a [SKU Recommender](https://docs.microsoft.com/sql/dma/dma-sku-recommend-sql-db?view=sql-server-ver15?azure-portal=true) that can help you determine the number of vCores and size. 

Additionally, while the hands-on exercises focused on Azure SQL Database, here is guidance on [how to migrate to Azure SQL Managed Instance](https://docs.microsoft.com/azure/sql-database/sql-database-managed-instance-migrate?azure-portal=true) specifically, and [here is a Quickstart](https://docs.microsoft.com/azure/sql-database/sql-database-managed-instance-get-started?azure-portal=true) if you'd like to try out your new deploy and configure toolbox in Azure SQL Managed Instance. There is also additional guidance on [Azure SQL Instance pools](https://docs.microsoft.com/azure/sql-database/sql-database-instance-pools-how-to#create-an-instance-pool?azure-portal=true).

You may also want to dive deeper into the resource limits based on service tier and configuration for [SQL Managed Instance](https://docs.microsoft.com/azure/azure-sql/managed-instance/resource-limits?azure-portal=true) and [SQL Database](https://docs.microsoft.com/azure/azure-sql/database/resource-limits-vcore-single-databases?azure-portal=true).

### Deploy, verify, and configure

Two common command-line tools for deploying, verifying, and configuring Azure SQL include the [Azure CLI](https://docs.microsoft.com/cli/azure/?view=azure-cli-latest?azure-portal=true) and the [Azure PowerShell](https://docs.microsoft.com/powershell/azure?azure-portal=true) modules. The links included will provide references and explanations around the capabilities. You can also access both of these tools through the [Azure Cloud Shell](https://docs.microsoft.com/azure/cloud-shell/overview?azure-portal=true), which is an integrated terminal that supports bash and PowerShell in the Azure portal.

#### Data max size

For more information about the difference between data space used, data space allocated, and data max size, see this [explanation in the documentation](https://docs.microsoft.com/azure/sql-database/sql-database-file-space-management#understanding-types-of-storage-space-for-a-database?azure-portal=true).

#### Connectivity to Azure SQL

More information on connectivity for Azure SQL Database can be found [here](https://docs.microsoft.com/azure/sql-database/sql-database-connectivity-architecture?azure-portal=true) and for Azure SQL Managed Instance [here](https://docs.microsoft.com/azure/sql-database/sql-database-managed-instance-connectivity-architecture?azure-portal=true). There will also be more on this topic in upcoming sections/modules.  

#### Azure Marketplace terms

Similar to the EULA for SQL Server, there exists [Azure Marketplace terms](https://go.microsoft.com/fwlink/?linkid=2045624?azure-portal=true) which must be accepted before deploying Azure SQL.

#### Resource governance

Resource governance from the Azure side is something new to consider in Azure SQL. You can [review how it works here](https://azure.microsoft.com/blog/resource-governance-in-azure-sql-database/?azure-portal=true) and a useful [blog post with more details](https://azure.microsoft.com/blog/resource-governance-in-azure-sql-database/?azure-portal=true).

#### Job management

You can learn more about the differences between SQL Server Agent in SQL Server and Azure SQL Managed Instance in the [documentation](https://docs.microsoft.com/azure/azure-sql/managed-instance/transact-sql-tsql-differences-sql-server#sql-server-agent?azure-portal=true). Additionally, you can learn about Elastic Jobs for Azure SQL Database in the [documentation](https://docs.microsoft.com/azure/azure-sql/database/elastic-jobs-overview?azure-portal=true).
