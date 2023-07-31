## Azure Migrate

[Azure Migrate](/azure/migrate/migrate-services-overview) is a lift and shift migration strategy that can be used to move the entire physical or virtual SQL Server from its current location to an instance of SQL Server on Azure Virtual Machine, without making any changes to the operating system or SQL Server version. During the migration, the source server remains online and continues to service requests while data is synchronized between the source and destination servers, allowing for a nearly seamless migration.

## Transactional replication

Use [transactional replication](/sql/relational-databases/replication/transactional/transactional-replication) when you need to minimize downtime and don't have an Always On on-premises deployment. You can configure your on-premises SQL Server databases that you wish to migrate as the publisher and configure your SQL Server on Azure Virtual Machine as a push subscriber to the SQL Server instance. 

There are three basic steps required to use this migration:

1. **Set up distribution**: Responsible for distributing articles in the replication topology. Articles are a database object. For example, a table that is included in the _Publication_
1. **Create publication**: A collection of one or more articles from the database being replicated
1. **Create subscription**: A request from a *Subscriber* for a *Publication* from a *Publisher*

Once you complete the test and the database appears on the subscriber instance in the Azure Virtual Machine, you can direct the connections to the subscriber database. Stop and delete the replication once the data has been successfully migrated.

## Log shipping

Log shipping is a database replication technique used in SQL Server to maintain a standby copy of a database on a secondary server. It enables continuous backup of transaction log files from the primary (source) database to one or more secondary (destination) servers. 

The primary database remains fully operational and serves as the source of transaction log backups. The transaction log backups are then automatically copied to the secondary server(s) and restored, keeping the secondary databases in sync with the primary.

When used in a migration scenario, it offers minimal interruption during failover and requires less setup than establishing an Always On availability group.

To learn more about log shipping, see [Log Shipping Tables and Stored Procedures](/sql/database-engine/log-shipping/log-shipping-tables-and-stored-procedures)

## Detach and attach a database

Another offline method that can be used to migrate your databases is detaching and then attaching databases from a URL. You can detach your database and log files and transfer them to an Azure Storage account. Then attach the database from the blob URL on your Azure VM. 

This method is useful if you want the physical database files to be stored in Azure Storage. You might use this option for your larger databases. You can transfer the database and log files either through [Azure Data Explorer](/azure/data-explorer/data-explorer-overview) or the [AzCopy command-line utility](/azure/storage/common/storage-use-azcopy-v10).

## Convert to a VM, upload to a URL, and deploy as a new VM

Use this method to migrate all system and user databases in an on-premises SQL Server instance to Azure Virtual Machine. You should use this approach when bringing your own SQL Server license, migrating a database that you run on an older version of SQL Server, or when migrating system and user databases together as part of the migration of database dependent on other user databases and/or system databases.

## Import Export Wizard/BACPAC

You can choose to migrate a SQL Server database to SQL Server on Azure Virtual Machine with a **.bacpac** file for the import process. This **.bacpac** file allows you to import the data from either Azure Blob storage or local storage in an on-premises location. A **.bacpac** file is a compressed file containing the metadata and data from the database.

For optimal scale and performance in production environments, it's  recommended to use the [SQLPackage](/sql/tools/sqlpackage/sqlpackage) utility. Running multiple SqlPackage commands in parallel for subsets of tables can significantly accelerate import/export operations.

## SQL Server data files on Azure Storage

Although this isn't a full migration approach, but rather a hybrid one, storing [SQL Server data files on Azure Storage](/sql/relational-databases/databases/sql-server-data-files-in-microsoft-azure) enables organizations to seamlessly integrate on-premises and cloud services. It can serve as a long-term strategy that allows organizations to balance their business needs and use the benefits of both on-premises and cloud solutions.

Hosting on-premises SQL Server data files on Azure provides several benefits for organizations looking to migrate their data to the cloud. It simplifies the migration process by allowing for an incremental migration without requiring any application changes or new hardware.

## Bulk copy

The [bcp utility](/sql/relational-databases/import-export/import-and-export-bulk-data-by-using-the-bcp-utility-sql-server) allows bulk exporting of data from a SQL Server table into a data file and vice versa. It supports generating format files for future bulk-import or bulk-export operations. The utility is versatile, enabling data transfer between SQL Server and other programs or databases. 

Understanding the schema and data types of the table is essential for using the bcp command effectively, unless a pre-existing format file is available.

## Azure Data Factory	

You can use [Azure Data Factory](/azure/data-factory/quickstart-get-started) for data migration rather than entire database migration. Azure Data Factory can migrate and transform data from source SQL Server databases. It's commonly used for merging data from multiple sources into Azure SQL Managed Instance, especially for business intelligence workloads. However, it can also be used to move data from or to SQL Server running on Azure Virtual Machine. To achieve this, data movement pipelines are created in Azure Data Factory to transfer data from the source to the destination. 

## The Windows Import/Export Service

Use the [Windows Import/Export Service](/azure/import-export/storage-import-export-service) method to transfer large amounts of data to Azure Blob storage when uploading over the network isn't feasible. With this service, you send one or more hard drives containing that data to an Azure data center, where your data is uploaded to your storage account.