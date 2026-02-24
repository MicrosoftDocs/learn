Log Replay Service (LRS) is a tool that enables custom migrations of databases from on-premises SQL Servers to SQL Managed Instance in the cloud. It uses log shipping technology and is useful in cases where more control is needed, when there's little tolerance for downtime, or when Azure Data Migration Service can't be used. 

:::image type="content" source="../media/3-log-replay-service.png" alt-text="Diagram showing how Log Replay Service (LRS) works.":::

LRS can be used directly with PowerShell, CLI cmdlets, or API, to manually build and orchestrate database migrations to SQL Managed Instance. Some of the reasons to consider using LRS include:

- More control over the database migration project
- Little tolerance for downtime on migration cutover
- Inability to install DMS executable in the environment
- Lack of file access to database backups
- Inability to open networking ports from the environment to Azure

## Understand migration types

There are two migration modes available for LRS.

| Mode | Description | Recommended for | Backup Chain Availability |
|------|-------------|-----------------|---------------------------|
| **Autocomplete** | Automatically finishes the migration when the last backup file is restored | Passive workloads | Entire backup chain must be available in advance |
| **Continuous** | Continuously scans for new backup files and restores them, allowing for data catch-up | Active workloads | Backup chain can be added during migration |

Regardless of the mode, plan to complete the migration within 30 days, as the LRS job will be automatically canceled after this time.

## Secure the migration process

To run LRS, you must have one of the following Azure role-based access control (RBAC) role: Subscription Owner, SQL Managed Instance Contributor, or a custom role with the permission `Microsoft.Sql/managedInstances/databases/*`.

An Azure Blob Storage account is required and works as an intermediary storage for backup files between your SQL Server instance and your SQL Managed Instance. To use Azure Blob storage with a firewall, another configuration is required. You must add the SQL Managed Instance subnet to the storage account's virtual network firewall rules using MI subnet delegation and the Storage service endpoint. Also, you can use either a SAS token or a managed identity to access your Azure Blob Storage account, but not both.

## Improve backup and restore performance

You can split full and differential backups into multiple files, instead of using a single file, to improve backup and restore performance. This is because multiple files can be read or written to in parallel, reducing the time it takes to complete the backup or restore operation.

Also, enabling backup compression can help improve network transfer speeds. Compressed backups are smaller in size, which means they take less time to transfer over the network. This can be especially useful when transferring large backups to or from Azure.

We strongly recommend enabling `CHECKSUM` for backups, even though it isn't required. SQL Managed Instance performs an integrity check on backups without `CHECKSUM`, which can increase the time it takes to restore the database. By enabling `CHECKSUM`, you can speed up the restore operations.
