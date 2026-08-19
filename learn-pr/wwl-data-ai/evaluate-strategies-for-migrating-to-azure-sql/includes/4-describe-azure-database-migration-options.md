Many organizations are migrating their database platform to Azure SQL to reduce licensing costs. Migrating to Azure SQL platform is made easier by the Azure Database Migration Service (DMS). DMS supports both homogenous (for example, MySQL in a Virtual Machine to Azure SQL Database) and heterogenous sources (for example, Oracle in a Virtual Machine to Azure Database for PostgreSQL) migrations.

There are several tools available to help with the migration process. This next section looks at some of the options and methods for migration.

## Azure Database Migration Service

[Azure Database Migration Service](/azure/dms/dms-overview) helps you simplify, guide, and automate your database migration to Azure. DMS migrates your data, schema, and objects from multiple sources to the cloud at scale.

For online migrations to Azure SQL Managed Instance or SQL Server on Azure Virtual Machines, Azure Database Migration Service provides a highly resilient and self-healing migration service with reliable outcomes and near-zero downtime. Migrations to Azure SQL Database are supported as offline migrations. Below are highlighted the main steps involved:

1. Fully load your on-premises database to Azure SQL. 
2. Continuously sync new database transactions to the Azure target. 
3. Cut over to the target Azure service when prepared. You can stop the replication, and switch the connection strings in your application to Azure SQL.

## Azure Migrate

Azure Migrate provides a centralized location to assess and migrate on-premises servers, infrastructure, applications, and data to Azure. It will provide discoverability and proper assessments of your servers regardless of whether they are physical or VMWare/Hyper-V virtual machines.

Azure Migrate will also help to ensure that you select the appropriate size of virtual machine so that workloads will have enough resources available. In addition, the tool will provide a cost estimation so that you can budget accordingly.

In order to utilize the Azure Migrate tool, you must deploy a light-weight appliance, which can be deployed on a virtual or physical machine. Once the on-premises servers are discovered, the appliance will continually send metadata about each server (along with performance metrics) to Azure Migrate, which resides in the cloud.

:::image type="content" source="../media/module-04-plan-implement-final-01.png" alt-text="Azure Migrate portal options":::

As shown above, the Azure Migrate experience can be kicked off from the portal to begin your migration process. The service consists of a unified migration platform, which provides a single portal to track your entire migration to Azure.

For broader infrastructure inventory and Windows operating system upgrade planning, you can also use the Microsoft Assessment and Planning (MAP) Toolkit. However, for SQL Server discovery, sizing, and migration planning to Azure, Azure Migrate is the recommended tool.

## SQL migration component in SSMS

The SQL migration component in SQL Server Management Studio (SSMS) is the recommended lightweight tool to assess your SQL Server estate and migrate to Azure SQL. It replaces the retired Data Migration Assistant (DMA) and Database Experimentation Assistant (DEA) tools.

To use the component, right-click a SQL Server instance in the SSMS Object Explorer and select **Migrate SQL Server**. The component supports two modes:

- **Standalone mode**, for SQL Server instances that aren't Azure Arc-enabled.
- **Azure Arc-enabled mode**, which uses precomputed assessments from the Azure Arc migration readiness experience.

The SQL migration component provides:

- **Azure migration readiness assessment**, which produces an HTML report with target platform recommendations (Azure SQL Database, Azure SQL Managed Instance, or SQL Server on Azure VM) and any blocking issues.
- **Upgrade assessment**, which checks compatibility with a target SQL Server version and identifies breaking changes, behavior changes, and deprecated features (the scenario previously covered by DEA).
- **Data migration options**, including the Managed Instance link for near-zero downtime migrations, Azure Database Migration Service for large-scale migrations, and native backup and restore.

For more information, see [Migrate SQL Server to Azure SQL by using SSMS](/ssms/migrate/migrate-sql-server-azure-sql).

> [!NOTE]
> Data Migration Assistant (DMA) was retired on July 16, 2025, and Database Experimentation Assistant (DEA) was retired on December 15, 2024. Use the SQL migration component in SSMS for lightweight assessment and migration, and Azure Database Migration Service for large-scale migrations.

## Additional migration options supported

There are a number of different approaches to migrating databases to Azure SQL. These solutions were not designed primarily for performing migrations, but they can be used for that purpose. The technique you use for physically migrating your data will depend on the amount of downtime you can sustain during the migration process.

- [**Log Replay Service**](/azure/azure-sql/managed-instance/log-replay-service-overview?azure-portal=true). It's an online migration option to Azure SQL Managed Instance, and used when you need more control of your database migration project.

- [**Managed Instance link**](/azure/azure-sql/managed-instance/managed-instance-link-feature-overview?azure-portal=true). The Managed Instance link, using distributed availability groups, securely extends your data estate by replicating data almost instantly (online) from a hosted SQL Server instance to Azure SQL Managed Instance. With SQL Server 2022 and later, you can also replicate and fail back in the other direction, from Azure SQL Managed Instance to SQL Server.

- [**Native backup and restore**](/azure/azure-sql/managed-instance/restore-sample-database-quickstart?azure-portal=true). Backup and restore are a simple migration method favored by many SQL Server professionals. It's the easiest migration option for customers who can provide full database backups to Azure Storage.

- [**Transactional replication**](/sql/relational-databases/replication/transactional/transactional-replication?azure-portal=true). Transactional replication is a way to move data between continuously connected database servers. It’s best to be used for online or offline migration of large and complex databases.

Learn more about the [tools used to migrate SQL databases to Azure](/sql/tools/overview-sql-tools?#migration-and-other-tools).
