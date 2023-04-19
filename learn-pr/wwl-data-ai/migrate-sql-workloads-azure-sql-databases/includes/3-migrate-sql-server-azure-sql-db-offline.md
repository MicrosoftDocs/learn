If you can afford to take the database offline while you migrate to Azure, you have a choice of techniques you can use to migrate the schema and data.

In your bicycle manufacturing company, the HR database is considered business-critical but is rarely used at weekends. You've planned to execute an offline migration between Friday evening and Monday morning, but you want to assess the best migration method.

In this unit, the focus is on the tools and methods for migrating SQL Server databases to Azure SQL Database offline.

> [!NOTE]
> It's assumed that all pre-migration checks have been done with the Data Migration Assistant and the Database Experimentation Assistant. This process ensures that feature and compatibility issues are addressed, and workloads have been simulated.

## Migrate using the Data Migration Assistant

You use the Data Migration Assistant to help migrate your SQL Server workload to a single or a pooled Azure SQL database, if your organization can tolerate downtime. Here are the five steps required to do this work:

1. Use the Data Migration Assistant to assess the database for compatibility issues.
1. Use the compatibility report to prepare the fixes required in a Transact-SQL script.
1. Make a copy of the database that's transactionally consistent.
1. Deploy the Transact-SQL script with the fixes to the copy of the database.
1. Migrate the database copy to a new Azure SQL database by using the Data Migration Assistant.

During migration, there are several best practices you can employ for importing the database into Azure SQL Database, including:

- Choose the highest service tier and compute size that your budget allows to maximize the transfer performance. To save on cost, you can scale down after the migration completes.
- Minimize the distance between your BACPAC file and the destination data center.
- Disable autostatistics during migration.
- Partition tables and indexes.
- Drop indexed views and recreate them when finished.
- Remove rarely queried historical data to another database and migrate it to a separate Azure SQL database. You can then query this historical data using elastic queries.
- After migration, update of all the statistics in the database.

## Migrate to Azure SQL Database using BACPAC

You can import a SQL Server database into an Azure SQL database using a BACPAC file. Import the data from a BACPAC file stored in Azure Blob Storage (standard storage only) or from local storage in an on-premises location. To maximize import speed by providing more and faster resources, scale your database to a higher service tier and compute size during the import process. You can scale down after the import is successful.

### Import from a BACPAC file in the Azure portal

The Azure portal only supports creating a single database in Azure SQL Database, and only from a BACPAC file in Azure Blob Storage.

1. To import from a BACPAC file into a new single database using the Azure portal, open the appropriate database server page and then, on the toolbar, select **Import database**.
1. Select the storage account and container for the BACPAC file, and then select the BACPAC file from which to import.
1. Specify the new database size (usually the same as the origin) and provide the destination SQL Server credentials.
1. Select **OK**.
1. To monitor an import's progress, open the database server page and, under **Settings**, select **Import/Export history**. When successful, the import has a **Completed** status.

You could also use SqlPackage to import a BACPAC file as it's more performant than using the Azure portal method. The following SqlPackage command imports the `AdventureWorks2019` database from local storage to an Azure SQL Database server called `mynewserver20230103`. It creates a new database called `myMigratedDatabase` with a Premium service tier and a P6 Service Objective. Change these values as appropriate for your environment.

```console
SqlPackage.exe /a:import /tcs:"Data Source=mynewserver20230103.database.windows.net;Initial Catalog=myMigratedDatabase;User Id=<your_server_admin_account_user_id>;Password=<your_server_admin_account_password>" /sf:AdventureWorks2019.bacpac /p:DatabaseEdition=Premium /p:DatabaseServiceObjective=P6
```

## Streamline migrations with the Azure Database Migration Service

The Azure Database Migration Service (DMS) is fully managed and designed to enable seamless migrations from multiple database sources to Azure Data platforms, with minimal downtime. This service streamlines the tasks required to move existing third-party and SQL Server databases to Azure. DMS is a free service that supports migrations of different databases to Azure database offerings. DMS can migrate MySQL, PostgreSQL, and MariaDB databases to Azure Database for MySQL/PostgreSQL/MariaDB, and it also supports SQL Server migrations, including Azure SQL Managed Instance.

The service uses the Data Migration Assistant to generate assessment reports that provide recommendations to guide you through the changes needed before a migration. You do any remediation that's required. When you're ready to begin migration, Azure Database Migration Service does all of the required steps. You can fire and forget your migration projects, safe in the knowledge that the process uses best practices determined by Microsoft.

Before using the Data Migration Assistant, you must register a resource provider in Azure, and create an Azure Database Migration Service instance.

### Migrate using the Azure Database Migration Service

To use the Azure Database Migration Service to migrate a database to Azure SQL Database, complete the following steps:

1. Create a migration project
1. Specify source details
1. Specify target details
1. Select source databases
1. Configure migration settings
1. Review the migration summary
1. Run and monitor the migration
1. Complete migration cutover

After the full database backup is restored on the target instance of Azure SQL Database, the database is available to do a migration cutover.
