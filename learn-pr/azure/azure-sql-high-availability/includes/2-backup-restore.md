In large or small organizations, accidents and incidents can happen. That's why you always need to have a plan for how to restore your systems if they're disrupted. In SQL Server, if you want to restore a database to a point in time, you can do that only if you're running in the full recovery model. In the bulk-logged recovery model, you're more likely to have to recover the database to the end of the transaction log backup.

One of the benefits of Azure SQL is that Azure can take care of all of this for you. Because Azure SQL manages your backups and runs in the full recovery model, it can restore your database to any point in time. You can even restore a deleted database within the configured retention policy. Microsoft also automatically encrypts your backups if TDE is enabled on the logical server or instance.

By default, a full database backup is taken once a week. Log backups are taken every 5-10 minutes, and differential backups every 12-24 hours. The backup files are stored in Azure Storage in read-access geo-redundant storage (RA-GRS) by default. However, you can choose to alternatively have your backups in zone-redundant storage (ZRS) or locally redundant storage (LRS). On an ongoing basis, the Azure SQL engineering team automatically tests the restore of automated backups of databases placed in logical servers and elastic database pools. For migrations to Azure SQL Managed Instance, an automatic initial backup with checksum of databases restored with the native RESTORE command or the Azure Database Migration Service occurs. And in Azure SQL Managed Instance, you can optionally take a native copy-only backup and store it in Azure Blob storage.

## Create a backup strategy for Azure SQL Managed Instance and Azure SQL Database

Azure SQL takes care of the heavy lifting, but it's still important to understand how backups are stored and processed and what your options for retention and restoring are. Ultimately, you're still responsible for the overall strategy for point-in-time restore, long-term retention, and geo-restore.

### Point in time restore (PITR)

In Azure SQL Database and Azure SQL Managed Instance, you can perform a self-service restore. You can choose the exact point in time to which you want to restore and start the process by using the Azure portal, the PowerShell/Azure CLI, or REST APIs. Point-in-time restore (PITR) will create a new database (with a different name) in the same logical server. If you need to replace the original database with the PITR database, you have to rename both the original and the new database to return to a working condition. You won't need to update connection strings.

Retention for PITR varies between 1 and 35 days. By default, the retention period (for all service tiers and deployment options) is seven days. In most deployment options and service tiers, you can configure the policy to be between 1 and 35 days, depending on your scenario's requirements. For example, you might need only one day for a test database, but you might choose the maximum of 35 days for a mission-critical database.

### Long-term retention (LTR)

If 35 days isn't long enough to meet your organization's needs or compliance requirements, you can choose long-term retention (LTR). This option allows you to automatically create full database backups that are stored in RA-GRS, ZRS, or LRS storage for up to 10 years. For Azure SQL Database, LTR is generally available. For Azure SQL Managed Instance, LTR is available in a limited public preview.

### Geo-restore

If there's a catastrophic event, your organization needs to be able to recover. Your backups are automatically stored in RA-GRS (unless you opt for ZRS or LRS) meaning your backups will be stored in the paired region. So if an entire region goes down and your databases or managed instances are in that region, you're protected. You can do a geo-restore to any other region from the most recent geo-replicated backup. This backup can be a bit behind the primary because it takes time to replicate the Azure blob to another region. You can easily perform a geo-restore by using the Azure portal, the PowerShell/Azure CLI, or REST APIs.
