The Azure Database Migration Service enables online and offline migrations from multiple database sources to Azure data platforms with minimal downtime. The service uses the Data Migration Assistant to generate assessment reports, identified tasks are then performed by the Azure Database Migration Service.

During the early stages of the migration project the IT Director requests that the current SQL cluster, which hosts several line-of-business application databases, be included.

In this unit, you'll see how to use the **Data Migration Assistant (DMA)** and **Azure Database Migration Service (DMS)** together. They provide a way to move on-premises SQL server databases efficiently to Azure.

## Offline vs. online migration

The migration service provides two different ways to migrate SQL, an offline migration or an online migration. An offline migration requires shutting down the server at the start of the migration, which means downtime for the service. An online migration uses a continuous synchronization of live data, allowing a cut over to the Azure replica database at any time. Using the online option is the best option if you need to minimizing downtime for your workload.

The Azure DMS has two pricing tiers:

- Standard: Allows only offline migrations. There's no charge to use this tier.
- Premium: Allows for both offline and online migrations. There's no charge for the first six months. After this period, you'll incur charges.

### Destinations

Your relational database can be migrated to a number of different destinations in Azure:

- **Single Azure SQL DB**: Fully managed single SQL database-as-a-service.
- **Azure SQL Managed Instance**: 100% compatible with SQL Server Enterprise Edition Database Engine, but missing a minimal number of SQL Server features.
- **SQL Server on Azure VM**: IaaS running a full version of SQL Server and supports all the features of SQL Server.
- **Azure DB for MySQL**: An Azure database based on the MySQL Community Edition versions 5.6 and 5.7.
- **Azure DB for PostgresSQL**: An Azure database based on the community version of the PostgreSQL database engine.
- **Azure Cosmos DB**: Globally distributed, multi-model, fully managed database service.

As your companies database needs are simple, the fastest and cheapest option is to migrate your database workloads to a single Azure SQL DB.

## Overview of database migrations

![Database migrations](../media/5-database-migration.svg)

The **Data Migration Assistant (DMA)** will guide you through the process of migrating your database. You'll take your existing relational databases, split out the database schema, and then recreate them in the destination Azure SQL database. With the new schema in place, the data for each database can then be copied to Azure. Finally, you'll check the new databases are performing as expected.

### Prerequisites

Both offline and online migrations have the same prerequisite tasks:

- **Download the DMA** - Download and install it locally on your on-premises SQL servers.
- **Create an Azure VNET** - Created for the Azure Database Migration Service using the Azure Resource Manager deployment model. It provides connectivity to the on-premises environment.
- **Configure the NSG (Network Security Group)** - The NSG associated with the new VNET should allow inbound connectivity to the service via ports 443, 53, 9354, 445, and 12000.
- **Configure the Windows Firewall** - Using Windows Firewall, you must configure it to allow the Database Migration Service to connect over port 1433. 1434 can also be opened up, if multiple named instances on dynamic ports exist on the same server.
- **Configure credentials** - Add **Control Server** permissions to the credentials used to connect to the source SQL server instance. Add **Control Database** permissions to the credentials used to connect to the target Azure SQL database.
- **Provision your target database in Azure** - Create the database for the target of the migration. It should be sized appropriately for the migrated workload.

### Assess the on-premises databases

Ensure all the communication ports are open, and check the connectivity between the source and destination servers before the migration tasks take place. Use the Data Migration Assistant, once installed create an **Assessment** project, give the project a name, and select the source and target servers. Connection details of the source server should be provided including credentials with permission to access it. On the database selection screen, choose the database you want to migrate.

The assessment will generate a report on completion, with a set of recommendations and alternative approaches that could be taken for the migration. You'll see any compatibility issues between the source and destination databases that could cause the migration to fail. Address the issues in the report, running it as many times as you need to ensure the issues have been fixed.

A Data Migration Assistant report will look similar to the following.

![Sample DMA Report](../media/5-dma-assessment.png)  

### Migrate the schema using the DMA

Each database has a schema, which represents the structure of the entire database. The schema defines the rules of how the data contained within it is organized, and the relationships between it. Before migrating all the data in the database, migrate the schema. Doing this creates the empty structure on the new Azure SQL database matching the on-premises source database. Migrating the schema also validates the connectivity before actually doing the full data migration.

To use the DMA to migrate the schema, create a new **Migration** project. Select the source server as your on-premises SQL server, and the target server to be your Azure SQL database. Set the scope of the migration to **Schema Only**. After you connect to the source database, choose the schema objects to deploy to the new Azure SQL database. The DMA will create a script to do the required actions, selecting **Deploy Schema** will run the script. Once complete check the target server to ensure the database has been configured correctly.

![Screenshot of the DMA exporting a schema](../media/5-dma-migrate-schema.png)

### Migrate your data with DMS

In the Azure portal, follow these steps to create a DMS instance, and then run it to migrate the data in your databases:

- **Create an instance of the Azure Database Migration Service**: Create an Azure Database Migration Service. Choose the pricing tier depending on whether you need an online or offline migration.
- **Create a migration project**: Create a new migration project. Choose the type of migration you wish to perform, either offline or online.
- **Specify source and target server details**: Complete the source and target server details, including the authentication information.
- **Identify the databases**: Map the relevant target database on the target server to the source server.
- **Run and monitor the migration**: Select the **Run migration** button to start the migration. The migration activity screen will appear. Track the progress until the process shows as "completed."
- **Check the migrated databases**: After all the required databases are migrated, they should be checked to ensure they're working.

Once complete, your schema and data will be migrated to Azure SQL Database. You can then shut down and decommission your databases and servers on-premises.
