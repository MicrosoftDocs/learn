You have several possibilities to back up SQL Server by using:

- **Performing conventional SQL Server backups onto direct attached Azure disks**. This approach has the advantage that you have the backups available swiftly for system refreshes and buildup of new systems as copies of existing SAP systems. It's also well known and applied in many cases in on-premises scenarios. On the other hand, it still requires implementing a longer-term backup solution. You must either use Azure Backup Services or another third-party backup/recovery tool that includes access and retention management for your backups.
- **SQL Server backup to URL**. Starting with SQL Server 2012 CU4, the native SQL Server backup can designate an Azure Storage URL as its destination.
- **Automated Backup v2 for Azure Virtual Machines**. This solution uses SQL Server IaaS Agent Extension to automatically configures Managed Backup to Azure Storage for all existing and new databases on an Azure Virtual Machine running SQL Server 2016/2017 Standard, Enterprise, or Developer editions.
- **SQL Server Backup in Azure Virtual Machines**. This solution uses AzureBackupWindowsWorkload virtual machine extension, which uses the SQL native APIs to backup your SQL databases into Azure Site Recovery vault.
- **File-snapshot backups for database files in Azure Blob Storage**. This method only works when your SQL Server data and log files are located on Azure blob storage. Using Azure snapshots, SQL Server File-Snapshot Backups provide nearly instantaneous backups and restores for database files stored using the Azure Blob storage service. This capability enables you to simplify your backup and restore policies, and it supports point in time restore. This feature is available in SQL Server 2016 or later.

## SQL Server backup to URL

Creating a Microsoft Azure Storage account within your Azure subscription is the first step in this process. SQL Server can either use the Microsoft Azure storage account name and its access key value to authenticate and write and read blobs to the Microsoft Azure Blob storage service or use a Shared Access Signature token generated on specific containers granting it read and write rights. The SQL Server Credential stores this authentication information and is used during the backup or restore operations.

There are two types of blobs that can be stored in the Microsoft Azure Blob storage service: block and page blobs. SQL Server backup can use either blob type depending upon the Transact-SQL syntax used: If the storage key is used in the credential, page blob is used; if the Shared Access Signature is used, block blob is used.

Backup to block blob is only available in SQL Server 2016 or later version. We recommend you to back up to block blob instead of page blob if you're running SQL Server 2016 or a later version. The main reasons are:

- Shared Access Signature is a safer way to authorize blob access compared to storage key.
- You can back up to multiple block blobs to get better backup and restore performance and support larger database backup.
- Block blob is cheaper than page blob.

When you back up to block blob, the maximum size of the backup is about 12.8 TB.

### Limitations

- Back up to premium storage isn't supported.
- SQL Server limits the maximum backup size supported using a page blob to 1 TB. The maximum backup size supported using block blobs is limited to approximately 200 GB (50,000 blocks \* 4 MB MAXTRANSFERSIZE). Block blobs support striping to support substantially larger backup sizes (up to 12.8 TB).
- You can issue backup or restore statements by using TSQL, SMO, PowerShell cmdlets, SQL Server Management Studio Backup or Restore wizard.
- Creating a logical device name isn't supported. So, adding URL as a backup device using sp\_dumpdevice or through SQL Server Management Studio isn't supported.
- Appending to existing backup blobs isn't supported. Backups to an existing blob can only be overwritten by using the WITH FORMAT option. However, when using file-snapshot backups (using the WITH FILE\_SNAPSHOT argument), the WITH FORMAT argument isn't permitted to avoid leaving orphaned file-snapshots that were created with the original file-snapshot backup.
- Back up to multiple blobs in a single backup operation is only supported using block blobs and using a Shared Access Signature (SAS) token rather than the storage account key for the SQL Credential.
- Specifying BLOCKSIZE isn't supported for page blobs.
- Specifying MAXTRANSFERSIZE isn't supported for page blobs.
- Specifying backupset options - RETAINDAYS and EXPIREDATE aren't supported.
- SQL Server has a maximum limit of 259 characters for a backup device name. The BACKUP TO URL consumes 36 characters for the required elements used to specify the URL - 'https://.blob.core.windows.net//.bak', leaving 223 characters for account, container, and blob names put together.

> [!NOTE]
> The latest version of SAP Software Provisioning Manager (SWPM) available at the time of authoring doesn't support creating data files directly on Azure Blobs. However, if the target SAP database is created before running SAPinst, the installer detects the database and installs it normally. Effectively, to use this approach, it's necessary to create the target SAP database with data files on blobs before running SAPinst.

## Automated Backup v2 for Azure Virtual Machines

Automated Backup provides an automatic backup service for SQL Server Standard and Enterprise editions running in a Windows virtual machine in Azure. This service is provided by the SQL Server IaaS Agent Extension, which is automatically installed on SQL Server Windows virtual machine images in the Azure portal. If you deploy your own OS images with SQL Server installed, you need to install the virtual machine extensions separately. More details about the capabilities of this method can be found at:

- [Automated Backup for SQL Server 2014 Virtual Machines (Resource Manager)](/azure/azure-sql/virtual-machines/windows/automated-backup-sql-2014)
- [Automated Backup v2 for Azure Virtual Machines (Resource Manager)](/azure/azure-sql/virtual-machines/windows/automated-backup)

The theoretical backup size limit is 12 TB. Since multiple blobs are written to in parallel, you can expect a throughput of larger than 100 MB/sec.

## SQL Server backup in Azure Virtual Machines

This backup method relies on SQL Server VSS/VDI interface to stream backups to a target location (the same as third-party backup tools). In this case, the target location is Azure Recovery Service vault. A more detailed description of this backup method, which adds numerous advantages of central backup configurations, monitoring, and administration is available in [About SQL Server Backup in Azure Virtual Machines](/azure/backup/backup-azure-sql-database)

## Third-party backup solutions

For several SAP customers, there was no possibility to start over and introduce complete new backup solutions for the part of their SAP landscape that was running on Azure. As a result, the existing backup solutions needed to be used and extended into Azure. Extending existing backup solutions into Azure usually worked well with most of the main vendors in this space.
