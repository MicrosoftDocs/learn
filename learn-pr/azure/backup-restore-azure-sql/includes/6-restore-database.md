Testing and validating the restore capability and procedures is a critical piece of a recovery strategy. By testing the restore process, you validate that your backups are successful. You also familiarize yourself with the process and options available when recovering a database. This helps to ensure a quick and successful recovery of data when needed.

Here, you'll learn how to restore an Azure SQL Server database from automated database backups.

## What you can restore

Automated backups in Azure SQL Database copy databases to blobs in read-access geo-redundant storage (RA-GRS) accounts on the schedule you specify. If you want to restore one of these backups, you must create a new database to contain the restored data. You cannot restore a database over an existing database. You can create this database on same server where the backup was taken or on another server with these options:

- Create a new database on the same SQL Database server recovered to a specified point in time within the retention period.
- Create a database on the same SQL Database server recovered to the deletion time for a deleted database.
- Create a new database on any SQL Database server in the same region recovered to the point of the most recent backups.
- Create a new database on any SQL Database server in any other region recovered to the point of the most recent replicated backups.

## How restore works

To complete a restore, Azure copies the database from the storage account to the Azure SQL Database server that you specify. In a point-in-time restore, SQL Database follows that by applying transaction logs to the restored database, up to the time you chose. The length of this process varies widely and depends on the database size, the transaction logs, network bandwidth, and the number of concurrent restore operations. Most restore operations complete in less than 12 hours but the only way to know how long your restore operation takes is to perform a practice restore. It's good practice to perform trial restores occasionally to time them and to ensure your complete backup and restore strategy works as you expect.

### Executing a point-in-time restore

You can perform database restores by using the Azure portal, PowerShell, or the Azure CLI. If you are performing a point-in-time restore on the original SQL Database server, you can choose:

- **Database replacement**. If you want to replace the original database with the restored one, make sure you specify the same compute size and service tier as the original. Then rename the original database and give the restored database the original name by using T-SQL `ALTER DATABASE` commands.
- **Data recovery**. If you want to retrieve data from the restored database to mitigate an error, you don't need to rename the original and restored databases. Instead, use T-SQL commands to extract the data you need from the restored database and insert it into the original database.

Both these options begin with the restoration of a database backup from storage. To recover in the Azure portal, click the **Restore** button on the database overview page, then specify the time to restore to.

In PowerShell, use the `Restore-AzSqlDatabase` cmdlet to execute restorations. In Azure CLI, use the `az sql db restore` command.

### Executing a deleted database restore

If a database has been mistakenly deleted, you can restore it from backup to the deletion time by using the Azure portal or PowerShell.

In the portal, go to the database server's **Overview** page and then, in the **Operations** area, click **Deleted databases**. You can specify a point in time up to the deletion time, and then click **OK** to recover.

### Executing a geo-restore

Azure SQL Database automatically replicates backed-up databases to datacenters in other regions. If the database in the original region is unavailable, for example because of a datacenter outage, you can restore from one of these replicated backup copies up to the point in time when the backup was made. The latest backup may not have fully replicated to your region so you may lose some recent changes.

To execute a geo-restore in the Azure portal, add a new database to an Azure SQL Database server. Then in the **Select source** drop-down list, select **Backup**, and choose the backup to restore from.