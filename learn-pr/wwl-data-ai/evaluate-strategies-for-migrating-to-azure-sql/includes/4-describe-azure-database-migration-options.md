Many organizations are migrating their database platform to Azure SQL to reduce licensing costs. Migrating to Azure SQL platform is made easier by the Azure Database Migration Service (DMS). DMS supports both homogenous (for example, MySQL in a Virtual Machine to Azure SQL Database) and heterogenous sources (for example, Oracle in a Virtual Machine to Azure Database for PostgreSQL) migrations.

There are several tools available to help with the migration process. This next section looks at some of the options and methods for migration.

## Azure Database Migration Service

[Azure Database Migration Service](/azure/dms/dms-overview) helps you simplify, guide, and automate your database migration to Azure. DMS migrates your data, schema, and objects from multiple sources to the cloud at scale.

For online migrations to Azure SQL, Azure Database Migration Service provides a highly resilient and self-healing migration service with reliable outcomes and near-zero downtime. Below are highlighted the main steps involved:

1. Fully load your on-premises database to Azure SQL. 
2. Continuously sync new database transactions to the Azure target. 
3. Cut over to the target Azure service when prepared. You can stop the replication, and switch the connection strings in your application to Azure SQL.

### Azure SQL Migration extension for Azure Data Studio

[**Azure SQL Migration extension for Azure Data Studio**](/sql/azure-data-studio/extensions/azure-sql-migration-extension?azure-portal=true) is a tool that helps you prepare for migrating your SQL Server databases to Azure. It uses the latest version of Azure Data Migration Service to assess your readiness for migration, recommend the best Azure resources for your needs, and execute the migration. It’s ideal for small to medium-sized databases and supports online migration to SQL Managed Instance.

## Azure Migrate

Azure Migrate provides a centralized location to assess and migrate on-premises servers, infrastructure, applications, and data to Azure. It will provide discoverability and proper assessments of your servers regardless of whether they are physical or VMWare/Hyper-V virtual machines.

Azure Migrate will also help to ensure that you select the appropriate size of virtual machine so that workloads will have enough resources available. In addition, the tool will provide a cost estimation so that you can budget accordingly.

In order to utilize the Azure Migrate tool, you must deploy a light-weight appliance, which can be deployed on a virtual or physical machine. Once the on-premises servers are discovered, the appliance will continually send metadata about each server (along with performance metrics) to Azure Migrate, which resides in the cloud.

:::image type="content" source="../media/module-04-plan-implement-final-01.png" alt-text="Azure Migrate portal options":::

As shown above, the Azure Migrate experience can be kicked off from the portal to begin your migration process. The service consists of a unified migration platform, which provides a single portal to track your entire migration to Azure.

There are several other tools you can use to map your server estate and identify compatibility with your target Azure platform:

- MAP Toolkit—The Microsoft Assessment and Planning Toolkit automatically collects and provides a report containing the inventory of all SQL Servers in your network, version, and server information.

- Database Experimentation Assistant—This tool can be used to evaluate version upgrades of SQL Server by checking syntax compatibility and provides a platform to evaluate query performance on the target version.

## Data Migration Assistant

The MAP toolkit and Database Experimentation assistant can help you identify your databases and highlight any incompatibilities or potential performance issues in your database, but the Data Migration Assistant (DMA) is a comprehensive toolkit that assesses, identifies new features you can use to benefit your application, and ultimately performs the migration. This tool can be used to migrate between versions of SQL Server, from on-premises to an Azure Virtual Machine or Azure SQL Database or Azure SQL Managed Instance.

> [!NOTE]
> While the Database Migration Assistant is a useful tool available, we recommend that you use the [Azure Database Migration Service](/azure/dms/dms-overview) for large migrations and enhanced overall experience, which is available as [Azure SQL Migration extension for Azure Data Studio](/azure-data-studio/extensions/azure-sql-migration-extension), or via [Azure Portal](https://aka.ms/dmsazureportal), or through [Azure PowerShell and Azure CLI](/azure/dms/migration-dms-powershell-cli).

## Additional migration options supported

There are a number of different approaches to migrating databases to Azure SQL. These solutions were not designed primarily for performing migrations, but they can be used for that purpose. The technique you use for physically migrating your data will depend on the amount of downtime you can sustain during the migration process.

- [**Log Replay Service**](/azure/azure-sql/managed-instance/log-replay-service-overview?azure-portal=true). It's an online migration option to Azure SQL Managed Instance, and used when you need more control of your database migration project.

- [**Managed Instance link**](/azure/azure-sql/managed-instance/managed-instance-link-feature-overview?azure-portal=true). The Managed Instance link, using distributed availability groups, securely extends your data estate by replicating data almost instantly (online) between any hosted SQL Server and Azure SQL Managed Instance, and vice versa.

- [**Native backup and restore**](/azure/azure-sql/managed-instance/restore-sample-database-quickstart?azure-portal=true). Backup and restore are a simple migration method favored by many SQL Server professionals. It's the easiest migration option for customers who can provide full database backups to Azure Storage.

- [**Transactional replication**](/sql/relational-databases/replication/transactional/transactional-replication?azure-portal=true). Transactional replication is a way to move data between continuously connected database servers. It’s best to be used for online or offline migration of large and complex databases.

Learn more about the [tools used to migrate SQL databases to Azure](/sql/tools/overview-sql-tools?#migration-and-other-tools).
