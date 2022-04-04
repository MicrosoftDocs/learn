Most applications use a database to store the data used by an application. It's important that you know how to migrate databases to Azure to properly support Tailwind Traders' move to the cloud.

### What is the Azure Database Migration Service?

The Azure Database Migration Service is part of Azure Migrate. You can use the Database Migration Service to migrate your on-premises databases. This includes:

- Azure VMs running SQL Server

- Azure SQL Database (Database Migration Assistant)

- SQL Managed Instances

- Cosmos DB

- Azure DB for MySQL

- Azure DB for PostgreSQL

The Database Migration Service is a fully managed service. The migration service provides two different ways to migrate SQL Server databases:

- Online migration: An online migration uses a continuous synchronization of live data, allowing a cut over to the Azure replica database at any time. Online migration minimizes downtime. 

- Offline migration: An offline migration requires shutting down the server at the start of the migration, which means downtime for the service.


### Overview of database migration

When you begin the migration process, it‘s the [Data Migration Assistant](/sql/dma/dma-overview?azure-portal=true) that guides you through the process. This process consists of three main elements:

1. Assess the databases you want to migrate

2. Migrate the schema: Separate the schema from the databases, and then recreate the schema in the target Azure SQL Database instances

3. Copy the databases data to the target instances and then verify the migrated databases

### Prerequisites

Both online and offline migrations have the same prerequisite tasks:

- Download the Data Migration Assistant.

- Create an Azure Virtual Network instance.

- Configure the network security group.

- Configure the Windows Firewall.

- Configure credentials.

- Provision your target database in Azure.

Size the target database appropriately for the migrated workload. 

### 1. Assess the on-premises databases

After you've verified all the prerequisites are met, you're ready to begin the migration. This starts with the assessment of your on-premises environment.

You'll use the Data Migration Assistant to conduct the assessment. The assessment generates a report after completion, including a set of recommendations and alternative approaches that could be taken for the migration.

You'll be able to review any compatibility issues between the source and destination databases that could cause the migration to fail. Address the issues in the report, running it as many times as you need to make sure that the issues have been fixed.

The following screenshot displays a typical Data Migration Assistant report.

:::image type="content" source="../media/data-migration-supported-features.png" alt-text="Azure SQL database supported and unsupported features.":::


### 2. Migrate the schema by using the Data Migration Assistant

Each database has a schema that represents its entire structure. The schema defines the rules for how the data is organized and the relationships between data elements.

You migrate the schema before you migrate all the data in the database. Doing so:

- Creates an empty structure on the new Azure SQL database. This structure matches that of the on-premises source database.

- Validates connectivity before you do the full data migration.The Data Migration Assistant creates and runs a script to take the required actions.

When the script is complete, check the target server to make sure the database has been configured correctly.

### 3. Migrate your data with Database Migration Service

After you've conducted your assessment, and created the schema, you can migrate the data.

When these steps are complete, your schema and data have been migrated to the Azure SQL Database instance. You can then shut down and decommission your on-premises databases and servers.
