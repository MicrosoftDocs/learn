Creating an Azure Storage account within your Azure subscription is the first step in this process. SQL Server can either use the Azure storage account name and its access key value to authenticate and write and read blobs to the Microsoft Azure Blob storage service or use a Shared Access Signature token granting read and write permissions to individual containers. The SQL Server Credential stores this authentication information and uses it during the backup or restore operations.

To implement SQL Server Backup to URL, you can use the following methods:

- **Back Up Task in SQL Server Management Studio**: You can back up a database to URL through the Back Up task in SQL Server Management Studio using a SQL Server Credential.
- **SQL Server Backup to URL Using Maintenance Plan Wizard**: The Maintenance Plan Wizard in SQL Server Management Studio includes URL as one of the destination options, and other supporting objects required to back up to Azure storage like the SQL Credential.
- **Transact-SQL, PowerShell, or C\#**: These options must be used to create a striped backup set, a SQL Server file-snapshot backup, or a SQL credential using Shared Access token.

## SQL Server Automated Backup v2 for Azure Virtual Machines

Automated Backup v2 automatically configures Managed Backup to Microsoft Azure for all existing and new databases on an Azure Virtual Machine running SQL Server 2016/2017 Standard, Enterprise, or Developer editions. This enables you to configure regular database backups that utilize Azure blob storage. Automated Backup v2 depends on the SQL Server IaaS Agent Extension.

Automated Backup v2 works with SQL Server 2016 or higher. If you're using SQL Server 2014, you can use Automated Backup v1 to back up your databases.

### Database configuration

- Target databases must use the full recovery model. For more information about the impact of the full recovery model on backups, see Backup Under the Full Recovery Model.
- System databases don't have to use full recovery model. However, if you require log backups to be taken for Model or MSDB, you must use the full recovery model.
- Target databases must be on either the default SQL Server instance, or a named instance installed by following the procedure described in [Frequently asked questions for SQL Server on Azure Virtual Machines](/azure/azure-sql/virtual-machines/windows/frequently-asked-questions-faq).

You can use the Azure portal or Az PowerShell module to configure Automated Backup v2 during provisioning or existing SQL Server 2016/2017 virtual machines.

## SQL Server backup in Azure Virtual Machines (to Recovery Services Vault)

SQL Server Backup in Azure Virtual Machines can be configured in the Azure portal or PowerShell (there's no support for Azure CLI). The process involves running discovery of SQL Server instances and their databases from an Azure Recovery Services vault, selecting the databases to be backed up in the discovery results, and assigning a backup policy that determines backup settings, such as frequency and retention. You also have the option of enabling Auto-Protection, which automatically backs up all existing and future databases on a SQL Server instance or Always On Availability Group.

When you run discovery on a SQL Server, Azure Backup does the following:

- Adds the AzureBackupWindowsWorkload extension.
- Creates an NT SERVICE\\AzureWLBackupPluginSvc account to discover databases on the virtual machine. This account is used for a backup and restore and requires SQL sysadmin permissions.
- Discovers databases that are running on a virtual machine, Azure Backup uses the NT AUTHORITY\\SYSTEM account. This account must be a public sign-in on SQL.

If you didn't create the SQL Server virtual machine by using an Azure Marketplace image, you need to assign to the NT SERVICE\\AzureWLBackupPluginSvc account the sysadmin role.

## SQL Server file snapshot-based backups to Azure Storage

SQL Server File-snapshot backup uses Azure snapshots to provide nearly instantaneous backups and quicker restores for database files stored using the Azure Blob storage service. This capability enables you to simplify your backup and restore policies.

You can use Azure PowerShell scripts and SQL queries to implement SQL Server data files as Azure Blobs. Using scripts, you can easily create a database in SQL Server running on-premises or in a virtual machine on Azure and set up a dedicated storage location for your data in Azure Blob Storage. You can also use the Azure portal instead of PowerShell scripts.

Regardless of the choice of the implementation method, the process involves setting up a storage account, creating SQL Server credentials, and creating a database with files stored in blobs. SQL Server needs the credentials to store the security information it uses to write to and read from the Azure blob container.

## File-backup set maintenance

- **Deleting a file-snapshot backup set**: You can't overwrite a file-snapshot backup set using the FORMAT argument. The FORMAT argument isn't permitted to avoid leaving orphaned file-snapshots that were created with the original file-snapshot backup. To delete a file-snapshot backup set, use the sys.sp\_delete\_backup system stored procedure. This stored procedure deletes the backup file and the file-snapshots that comprise the backup set. Using another method to delete a file-snapshot backup set might delete the backup file without deleting the file-snapshots in the backup set.
- **Deleting orphaned backup file-snapshot**s: You might have orphaned file-snapshots if the backup file was deleted without using the sys.sp\_delete\_backup system stored procedure or if a database or database file was dropped while the blob(s) containing the database or database file had backup file-snapshots associated with them. To identify file-snapshots that might be orphaned, use the sys.fn\_db\_backup\_file\_snapshots system function to list all file-snapshots of the database files. To identify the file-snapshots that are part of a specific file-snapshot backup set, use the RESTORE FILELISTONLY system stored procedure. You can then use the sys.sp\_delete\_backup\_file\_snapshot system stored procedure to delete an individual backup file-snapshot that was orphaned. You can find examples using this system function and these system stored procedures at the bottom of this page.

## Restore using file-snapshot backups

Because each file-snapshot backup set contains a file-snapshot of each database file, a restore process requires at most two adjacent file-snapshot backup sets. This is true regardless of whether the backup set is from a full database backup or a log backup. This is different than the restore process when using traditional streaming backup files to perform the restore process. With traditional streaming backup, the restore process requires the use of an entire chain of backup sets: the full backup, a differential backup and one or more transaction log backups. The recovery portion of the restore process remains the same regardless of whether the restore is using a file-snapshot backup or a streaming backup set.

In order to perform a RESTORE DATABASE operation to restore a database to the time of a specific file-snapshot backup set, only the specific backup set is required, plus the base blobs themselves. Because you can use a transaction log file-snapshot backup set to perform a RESTORE DATABASE operation, you'll typically use a transaction log backup set to perform this type of RESTORE DATABASE operation, and rarely use a full database backup set.

In order to perform a RESTORE DATABASE operation to restore a database to a specific point in time between the time of two adjacent transaction log backup sets, only two transaction log backup sets are required (one before and one after the point in time to which you wish to restore the database). To accomplish this, you would perform a RESTORE DATABASE operation WITH NORECOVERY using the transactional log file-snapshot backup set from the earlier point in time and perform a RESTORE LOG operation WITH RECOVERY using the transaction log file-snapshot backup set from the later point in time and using the STOPAT argument to specify the point in time at which to stop the recovery from the transaction log backup.

### Back up the database and log using a file-snapshot backup

The following example uses file-snapshot backup to back up the AdventureWorks2016 sample database to URL.

```bash
BACKUP DATABASE AdventureWorks2016

TO URL = 'https://[mystorageaccountname].blob.core.windows.net/[mycontainername]/AdventureWorks2016.bak'

WITH FILE_SNAPSHOT ;
```

### Restore from a SQL Server file-snapshot backup

The following example restores the AdventureWorks2016 database using a transaction log file-snapshot backup set and shows a recovery operation. Notice that you can restore a database from a single transactional log file-snapshot backup set.

```bash
RESTORE DATABASE AdventureWorks2016 FROM URL = 'https://[mystorageaccountname].blob.core.windows.net/[mycontainername]/AdventureWorks2016_2015_05_18_16_00_00.trn'

WITH RECOVERY, REPLACE ;
```

### Restore from a SQL Server file-snapshot backup to a point in time

The following example restores the AdventureWorks2016 to its state at a specified point in time using two transaction log file-snapshot backup sets and shows a recovery operation.

```bash
RESTORE DATABASE AdventureWorks2016 FROM URL = 'https://[mystorageaccountname].blob.core.windows.net/[mycontainername]/AdventureWorks2016_2015_05_18_16_00_00.trn'

WITH NORECOVERY,REPLACE ;

RESTORE LOG AdventureWorks2016 FROM URL = 'https://[mystorageaccountname].blob.core.windows.net/[mycontainername]/AdventureWorks2016_2015_05_18_18_00_00.trn'

WITH RECOVERY,STOPAT = 'May 18, 2015 5:35 PM' ;
```

### Delete a database file-snapshot backup set

To delete a file-snapshot backup set, use the sys.sp\_delete\_backup system stored procedure. Specify the database name to have the system verify that the specified file-snapshot backup set is indeed a backup for the database specified. If no database name is specified, the specified backup set with its file-snapshots will be deleted without such a validation.

Attempting to delete a file-snapshot backup set using another method, such as the Azure portal or the Azure Storage viewer in SQL Server Management Studio won't delete the file-snapshots in the backup set. These tools will only delete the backup file itself that contains the pointers to the file-snapshots in the file-snapshot backup set. To identify backup file-snapshots that remain after a backup file was improperly deleted, use the sys.fn\_db\_backup\_file\_snapshots system function and then use the sys.sp\_delete\_backup\_file\_snapshot system stored procedure to delete an individual backup file-snapshot.

The following example deletes the specified file-snapshot backup set, including the backup file and the file-snapshots comprising the specified backup set.

```bash
sys.sp_delete_backup 'https://[mystorageaccountname].blob.core.windows.net/[mycontainername]/AdventureWorks2016.bak', 'adventureworks2016' ;
```

### View database backup file-snapshots

To view file-snapshots of the base blob for each database file, use the sys.fn\_db\_backup\_file\_snapshots system function. This system function enables you to view all backup file-snapshots of each base blob for a database stored using the Azure Blob storage service. A primary use case for this function is to identify backup file-snapshots of a database that remain when the backup file for a file-snapshot backup set is deleted using a mechanism other than the sys.sp\_delete\_backup system stored procedure. To determine the backup file-snapshots that are part of intact backup sets and the ones that aren't part of intact backup sets, use the RESTORE FILELISTONLY system stored procedure to list the file-snapshots belonging to each backup file.

The following example returns the list of all backup file-snapshots for the specified database.

```bash
USE AdventureWorks2016

select * from sys.fn_db_backup_file_snapshots (null) ;

GO

select * from sys.fn_db_backup_file_snapshots ('AdventureWorks2016') ;
```

### Delete an individual database backup file-snapshot

To delete an individual backup file-snapshot of a database base blob, use the sys.sp\_delete\_backup\_file\_snapshot system stored procedure. A primary use case for this system stored procedure is to delete orphaned file-snapshot files that remain after a backup file was deleted using a method other than the sys.sp\_delete\_backup system stored procedure.

> [!WARNING]
> Deleting an individual file-snapshot that's part of a file-snapshot backup set will invalidate the backup set.

The following example deletes the specified backup file-snapshot. The URL for the specified backup was obtained using the sys.fn\_db\_backup\_file\_snapshots system function.

```bash
sys.sp_delete_backup_file_snapshot N'adventureworks2016', N'https://[mystorageaccountname].blob.core.windows.net/[mycontainername]/AdventureWorks2016Data.mdf?snapshot=2015-05-29T21:31:31.6502195Z' ;
```
