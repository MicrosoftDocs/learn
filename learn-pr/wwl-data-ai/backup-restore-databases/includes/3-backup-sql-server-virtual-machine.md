Azure Backup offers the capability to back up virtual machines (VMs) that host SQL Server. These backups contain not only the SQL Server databases but also all other contents within the VM, allowing for a complete restoration if needed. Although this approach may not be suitable for every scenario, it provides a robust safeguard against issues such as ransomware attacks.

VM-level backups are SQL Server-aware, also known as application-aware, ensuring the creation of application-consistent backups. This means that restoring a VM-level backup won't disrupt SQL Server functionality. When using this option, the SQL Server log indicates that the I/O has been momentarily frozen and then resumed upon completion.

Combining SQL Server backups with snapshots can potentially cause issues. If snapshot delays cause backup failures, set following value on the `[HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\BCDRAGENT]` key:

**"USEVSSCOPYBACKUP"**="TRUE"

## Use local disks or a network share for backup files

As with on premises SQL Server instances, databases can be backed up to disks attached to the VM or to network shares (including the file share in Azure called Azure Files) that SQL Server has access to. If you're backing up to disks local to the VM, ensure that they aren't written to the ephemeral storage that is erased upon shutdown or restart. You might also want to make sure that the backups are copied to a second location so as not to create a single point of failure.

## Backup databases to and restore from URL

Another option is to configure backup to URL for the SQL Server instance installed in the VM. Unlike backups made on premises, backup and restore from URL for an IaaS VM is effectively a local option.

Back up to URL requires an Azure storage account and uses the Azure blob storage service. Inside the storage account, there are containers, and the blobs are stored there. Unlike a path on your local disk, the path to a backup file looks something like `https://ACCOUNTNAME.blob.core.windows.net/ContainerName/MyDatabase.bak`. You can include more folder names under your container for easier identification of backups (for example, FULL, DIFF, LOG).

To back up to or restore from a URL, authentication must be established between the SQL Server instance and Azure. Remember that inside of an Azure VM, SQL Server doesn't know it's running on Azure. A SQL Server Credential can be composed of the Azure storage account name and access key authentication or a Shared Access Signature. If the former is used, the backup is stored as a page blob and if the latter, it's stored as a block blob. Starting with SQL Server 2016, only block blob is available so you should use a Shared Access Signature. From a cost perspective, block blobs are also cheaper, and Shared Access Signature tokens offer better security control.

Restoring from a URL is as simple as restoring from disk or a network share. In the SQL Server Management Studio UI, select URL from the backup media type in the Wizard. If using Transact-SQL, instead of using FROM DISK, you would use FROM URL with the appropriate location and backup file name. Here are some sample statements:

The following statement would back up a transaction log.

```tsql
BACKUP LOG contoso 
TO URL = 'https://myacc.blob.core.windows.net/mycontainer/contoso202003271200.trn' 
```

The following statement would restore a full database backup without recovering it, so that a differential or transaction log backups could be applied.

```tsql
RESTORE DATABASE contoso 
FROM URL = 'https://myacc.blob.core.windows.net/mycontainer/contoso20200327.bak' 
WITH NORECOVERY
```

## Automated backups using the SQL Server resource provider

Any IaaS VM that has SQL Server installed can use the SQL Server resource provider. One of its options is the ability to configure automated backups so Azure takes care of backing up SQL Server databases. It requires the use of a storage account.

One benefit of implementing backups this way is that you can manage retention times for the backups. Another benefit is that you can ensure RPO due to the ability to take database and transaction log backups all in one easy-to-configure place. The following image shows an example of what configuring an automated backup looks like in the Azure portal.

:::image type="content" source="../media/module-77-high-availability-final-15.png" alt-text="Configuring automated backups for SQL Server in a VM in the Azure portal":::

The automated backup option is currently only available for Windows Server-based SQL Server installations.

> [!IMPORTANT]
> You choose one method of backing up databases with IaaS-based SQL Server deployments. For example, if you use automated backups, especially with transaction log backups, don't also configure those at the instance level inside the VM. You could cause problems with the log chain with restoring a database if things are uncoordinated, because each log backup clears the log and you must have an entire unbroken chain of log backups in order to do a log restore. For example, if transaction log backups happen inside the guest and at the Azure level, you may have to piece together the backups to do a restore.

While the backups can be automated, restores can't be. You would need to configure and use the restore from URL functionality within SQL Server.