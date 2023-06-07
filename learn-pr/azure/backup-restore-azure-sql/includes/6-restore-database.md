Testing and validating the restore capability and procedures is a critical piece of a recovery strategy. By testing the restore process, you validate that your backups are successful. You also familiarize yourself with the process and options available for recovering a database. This familiarization helps to ensure a quick and successful recovery of data when needed.

Let's learn how to restore an Azure SQL Server database from automated database backups.

## What you can restore

Automated backups in Azure SQL Database copy databases to blobs in read-access geo-redundant storage (RA-GRS) accounts on the schedule that you specify. If you want to restore one of these backups, you must create a new database to contain the restored data. You can't restore a database over an existing database.

You can create the new database on the same server where Azure SQL Database took the backup or on another server with these options:

- Create a new database on the same SQL Database server recovered to a specified point in time within the retention period.
- Create a database on the same SQL Database server recovered to the deletion time for a deleted database.
- Create a new database on any SQL Database server in the same region recovered to the point of the most recent backups.
- Create a new database on any SQL Database server in any other region recovered to the point of the most recent replicated backups.

## How restore works

To complete a restore, Azure copies the database from the storage account to the Azure SQL Database server that you specify. In a point-in-time restore, SQL Database follows that by applying transaction logs to the restored database, up to the time you chose.

The length of this process varies widely. It depends on the database size, the transaction logs, network bandwidth, and the number of concurrent restore operations. Most restore operations finish in less than 12 hours.

The only way to know how long your restore operation takes is to perform a trial restore. It's a good idea to perform trial restores occasionally to time them and to ensure your complete backup and restore strategy works as you expect.

### Perform a point-in-time restore

You can perform database restores by using the Azure portal, PowerShell, or the Azure CLI. If you're performing a point-in-time restore on the original SQL Database server, you can choose:

- **Database replacement**: If you want to replace the original database with the restored one, make sure you specify the same compute size and service tier as the original. Then, rename the original database and give the restored database the original name by using T-SQL `ALTER DATABASE` commands.
- **Data recovery**: If you want to retrieve data from the restored database to mitigate an error, you don't need to rename the original and restored databases. Instead, use T-SQL commands to extract the data that you need from the restored database. Then, insert the data into the original database.

Both of these options begin with the restoration of a database backup from storage. To recover in the Azure portal, select the **Restore** button on the database overview page, and then specify the time to which to restore.

In PowerShell, use the `Restore-AzSqlDatabase` cmdlet to execute restorations. In the Azure CLI, use the `az sql db restore` command.

### Restore a deleted database

If you mistakenly delete a database, you can restore it from backup to the deletion time by using the Azure portal or PowerShell.

In the portal, go to the database server's **Overview** page. Then, in the **Operations** area, select **Deleted databases**. You can specify a point in time up to the deletion, then select **OK** to recover.

### Perform a geo-restore

Azure SQL Database automatically replicates backed-up databases to datacenters in other regions. If the database in the original region is unavailable—for example, because of a datacenter outage—you can restore from one of these replicated backup copies. You can restore up to the point in time when Azure SQL Database made the backup. The latest backup might not have fully replicated to your region, so you might lose some recent changes.

To perform a geo-restore in the Azure portal, add a new database to an Azure SQL Database server, then select **Backup** in the **Select source** drop-down list and choose the backup from which to restore.
