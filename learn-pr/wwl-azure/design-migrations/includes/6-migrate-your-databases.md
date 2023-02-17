Most applications use a database to store the data used by the application. For your Tailwind Traders migration planning, it's important to understand how to migrate databases to Azure to properly support moving data to the cloud. For this process, we'll examine another component of Azure Migrate, the Azure Database Migration Service.

## Azure Database Migration Service

The Azure Database Migration Service is part of Azure Migrate. You can use the Database Migration Service to migrate your on-premises databases, including:

- Azure virtual machines running SQL Server
- Azure SQL Database (Database Migration Assistant)
- Azure SQL Managed Instance
- Azure Cosmos DB
- Azure Database for MySQL
- Azure Database for PostgreSQL

### Things to know about the Database Migration Service

The Azure Database Migration Service is a fully managed service. The service provides two ways to migrate structured data in SQL Server databases:

- **Online migration**: An online migration uses a continuous synchronization of live data, which allows a cut over to the Azure replica database at any time. Online migration minimizes downtime. 

- **Offline migration**: An offline migration requires shutting down the server at the start of the migration, which results in downtime for the service.

#### Migrating data in databases

When you begin a migration of structured data with the Database Migration Service, [SQL Server Data Migration Assistant (DMA)](/sql/dma/dma-overview?azure-portal=true) guides you through the process. This process consists of three primary steps:

1. **Assess databases**: DMA helps you assess the databases you want to migrate.

1. **Migrate schema**: DMA separates the schema from your databases. The schema is then recreated in the target Azure SQL Database instances.

1. **Migrate data and verify**: DMA copies the data in your databases to the target instances and then verifies the migrated databases.

### Things to consider when using the Database Migration Service

Let's examine how to use the Database Migration Service to migrate your databases to Azure and the cloud.

#### Prerequisites

For both online and offline migrations, you need to complete the following prerequisite tasks:

- Download DMA
- Create an Azure Virtual Network instance
- Configure network security groups (NSGs)
- Configure Azure Windows Firewall
- Configure credentials
- Provision your target database in Azure (size the target database appropriately for the migrated workload)

#### Step 1. Assess on-premises databases

After you verify all prerequisites are met, you're ready to begin the migration. The first step is to assess your on-premises environment with DMA.

The assessment generates a report with recommendations and alternate approaches for the migration. Review the report for compatibility issues between the source and destination databases that might cause the migration to fail. Address any issues, and then generate a new assessment report. Repeat this process until you confirm all issues are addressed.

#### Step 2. Migrate schema with DMA

Each database has a schema that represents its entire structure. The schema defines the rules for how the structured data is organized and the relationships between data elements. You migrate the schema before you migrate all the data in your database. By migrating the schema first, you accomplish two goals:

- An empty structure is created on the new Azure SQL database. This structure matches the structure of the on-premises source database.

- Connectivity is validated before you run the full data migration. DMA creates and runs a script to take the required actions.

When the script completes, check the target server to make sure the database is configured correctly.

#### Step 3. Migrate data and verify

After you complete your assessment and migrate your schema, you can migrate the structured data with the Database Migration Service.

When all migration steps are complete, your schema and structured data have been migrated to the Azure SQL Database instance. You can then safely shut down and decommission your on-premises databases and servers.