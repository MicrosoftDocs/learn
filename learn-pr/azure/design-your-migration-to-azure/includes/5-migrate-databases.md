The Azure Database Migration Service enables online and offline migrations from multiple database sources to Azure data platforms with minimal downtime. The service uses the Data Migration Assistant to generate assessment reports, identified tasks are then performed by the Azure Database Migration Service.

During the early stages of the migration project the IT Director requested that the current SQL cluster, which hosts several lines of business application databases, be included. With the required due diligence completed and the finer details that make up the SQL cluster have been noted, the migration can now take place.

In this unit, you'll see how to use the **Azure Database Migration Service** (DMS), which provides a way to move on-premises SQL server databases efficiently to the Azure cloud.

## Offline vs online migration

The migration service provides two different ways to migrate SQL, an offline migration or an online migration. An offline migration requires shutting down the server at the start of the migration, which means downtime for the service. An online migration uses a continuous synchronization of live data, allowing a cut over to the Azure replica database at any time. Using the online option is the best option if you need to minimizing downtime for your workload.

The Azure DMS has two pricing tiers:

1. Standard: Allows only offline migrations, there's no charge for using this tier
1. Premium: Allows for both offline and online migrations, there's no charge for the first six months, after this period you'll incur charges

## Prerequisites

Both offline and online migrations have the same prerequisite tasks, they are:

- **Download the Data Migration Assistant (DMA)** - Download and install it locally on your on-premise SQL servers
- **Create an Azure VNET** - Created for the Azure Database Migration Service using the Azure Resource Manager deployment model, it provides connectivity to the on-premises environment
- **Configure the NSG (Network Security Group)** - The NSG associated with the new VNET should allow inbound connectivity to the service via ports 443, 53, 9354, 445, and 12000
- **Configure the Windows Firewall** - Using Windows Firewall you must configure it to allow the Database Migration Service to connect over port 1433. 1434 can also be opened up if multiple named instances on dynamic ports exist on the same server
- **Configure credentials** - Add **Control Server** permissions to the credentials used to connect to the source SQL server instance. Add **Control Database** permissions to the credentials used to connect to the target Azure SQL database
- **Provision your target database in Azure**- Create the database for the target of the migration, it should be sized appropriately for the migrated workload

## Assessing the on-premises databases

Ensure all the communication ports are open, and check the connectivity between the source and destination servers before the migration tasks take place. Use the Data Migration Assistant, once installed create an **Assessment** project, give the project a name, and select the source and target servers. Connection details of the source server should be provided including credentials with permission to access it. On the database selection screen, choose the database you want to migrate.

The assessment will generate a report on completion, with a set of recommendations and alternative approaches that could be taken for the migration. You'll see any compatibility issues between the source and destination databases that could cause the migration to fail. Address the issues in the report, running it as many times as you need to ensure the issues have been fixed.

![Sample DMA Report](../media/2dma-assessment.png)

A sample Data Migration Assistant report.  

## Migrating the Schema

Each database has a schema, which represents the structure of the entire database. The schema defines the rules of how the data contained within it is organized, and the relationships between it. Before migrating all the data in the database, migrate the schema. Doing this creates the empty structure on the new Azure SQL database matching the on-premise source database. Migrating the schema also validates the connectivity before actually doing the full data migration.

To use the DMA to migrate the schema, create a new **Migration** project. Select the source server as your on-premise SQL server, and the target server to be your Azure SQL database. Set the scope of the migration to **Schema Only**. After you connect to the source database, choose the schema objects to deploy to the new Azure SQL database. The DMA will create a script to do the required actions, selecting **Deploy Schema** will run the script. Once complete check the target server to ensure the database has been configured correctly.

![Screenshot of the DMA exporting a schema](../media/dma-migrate-schema.png)

## Preparing your Azure environment

There are several steps you need to take to prepare Azure before starting the full database data migration:

- **Register the Microsoft.DataMigration resource provider** - In the Azure portal check that the **Microsoft.DataMigration** resource provider is enabled for your subscription
- **Create an instance of the Azure Database Migration Service** - Create an Azure Database Migration Service, choosing the pricing tier depending on whether you need an online or offline migration
- **Create a migration project** - Create a new migration project, choosing the type of migration you wish to perform, either offline or online
- **Specify source and target server details** - Complete the source and target server details, including the authentication information
- **Identify the databases** - Map the relevant target database on the target server to the source server
- **Run and monitor the migration** - Select the **Run migration** button to start the migration. The migration activity screen will appear, track the progress until the process shows as 'completed'
- **Check the migrated databases** - Once all the required databases have been migrated they should be checked to ensure they're working