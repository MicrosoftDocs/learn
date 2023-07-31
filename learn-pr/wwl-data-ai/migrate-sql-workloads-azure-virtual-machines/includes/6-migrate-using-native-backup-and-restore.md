Migrating using a backup and restore is the simplest method of migration that is well understood by SQL Server professionals. 

Microsoft Azure Blob Storage supports two types of blobs: block and page blobs. For SQL Server 2016 and later versions, block blobs are preferred. The choice between block and page blobs depends on the type of credentials used - Shared Access Signature for block blob and storage key for page blob. 

Back up to block blob offers advantages such as safer authorization, improved backup performance, and support for larger database backups compared to page blob.

If you choose to perform a full database backup to a file, you can transfer the on-premises backup files to an Azure VM either through [Azure Data Explorer](/azure/data-explorer/data-explorer-overview) or the [AzCopy command-line utility](/azure/storage/common/storage-use-azcopy-v10).

## Backup and restore with Azure Blob Storage in SQL Server

Back up to URL requires an Azure storage account and uses the Azure blob storage service. Inside the storage account there are containers, and the blobs are stored there. Unlike a path on your local disk, the path to a backup file looks something like `https://{AccountName}.blob.core.windows.net/{ContainerName}/MyDatabase.bak`. You can add extra folder names under your container for easier identification of backups (for example, FULL, DIFF, LOG). 

To back up to or restore from a URL, authentication must be established between the SQL Server instance and Azure. Remember that inside of an Azure VM, SQL Server doesn't know it's running on Azure. 

You can create a SQL Server credential using either the Azure storage account name and access key authentication or a Shared Access Signature. If the former is used, the backup is stored as a page blob and if the latter, it's stored as a block blob. Starting with SQL Server 2016, only block blob is available so you should use Shared Access Signature. For larger databases, you can back up to multiple block blobs.

>[!TIP]
> Compressed database backups are recommended for larger databases. Compressing a backup reduces device I/O, which usually increases backup speed.

Restoring from a URL is as simple as restoring from disk or a network share. In the SQL Server Management Studio, select URL from the backup media type in the Wizard. If using Transact-SQL, instead of using `FROM DISK`, you would use `FROM URL` with the appropriate location and backup file name(s).

> [!NOTE]
> Striped backup sets are supported and are recommended for performance. Furthermore, stripe backups if they're smaller than 200 GB to avoid the block limit.

Run the following statement to back up a transaction log.

```sql
BACKUP LOG contoso 
TO URL = 'https://myacc.blob.core.windows.net/mycontainer/contoso202003271200.trn' 
```

Run the following statement to restore a full database backup without recovering it, so that a differential or transaction log backups can be applied.

```sql
RESTORE DATABASE contoso 
FROM URL = 'https://myacc.blob.core.windows.net/mycontainer/contoso20200327.bak' 
WITH NORECOVERY
```
