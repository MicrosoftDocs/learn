As part of the architecture of Azure SQL Migration extension for Azure Data Studio, Azure Database Migration Service orchestrates the database migration activities initiated through the Azure SQL Migration extension and tracks their progress.

There are two modes of migration to SQL Server on Azure Virtual Machine using Azure SQL Migration extension for Azure Data Studio:

- **Online migration mode:** The source SQL Server database remains accessible for both read and write operations while database backups are continuously restored on the target SQL Server on Azure Virtual Machine. Therefore, application downtime is limited to the cutover duration at the end of the migration.

- **Offline migration mode:** The source SQL Server database shouldn't be used for write activity while database backup files are restored on the target instance of SQL Server to Azure Virtual Machines. Application downtime remains throughout the duration of the migration process until it's completed.

>[!IMPORTANT]
> When migrating a database with Azure SQL Migration extension for Azure Data Studio, ensure that the provided database name(s) do not already exist on the target SQL Server on Azure Virtual Machine. Overwriting a database is not currently supported.

## Backups

The Azure SQL Migration extension for Azure Data Studio doesn't perform or initiate any database backups. Instead, it relies on existing database backup files for the migration process. To minimize potential issues when migrating based on large backups, it's recommended to use [compressed backups](/sql/relational-databases/backup-restore/backup-compression-sql-server).

There are two ways of storing your database backups for migration:

### Network share

You need to download and install the [self-hosted integration runtime](https://www.microsoft.com/download/details.aspx?id=39717) on a machine with access to the source SQL Server and backup files if your backups are on an on-premises network share.

During the migration, the migration wizard provides the download link and authentication keys to download and install your self-hosted integration runtime.

For optimal performance, consider up to 10 concurrent database migrations per self-hosted integration runtime, and scale out to multiple nodes or instances if needed. Also, enable auto-update to stay up-to-date with new features, bug fixes, and enhancements. This ensures that the integration runtime stays up-to-date with the latest improvements and fixes, leading to better performance, enhanced functionality, and stability during database migrations. 

>[!IMPORTANT]
> Database Migration Service does not allow the use of an existing self-hosted integration runtime created in Azure Data Factory for database migrations.

### Azure Storage blob container

When uploading your source database backups to the blob container, ensure that the backup files from different source databases are stored in separate folders. Only the root of the container and folders at most one level deep are supported.
