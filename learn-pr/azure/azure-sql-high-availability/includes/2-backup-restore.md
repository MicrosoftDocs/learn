In organizations large or small, accidents and incidents can happen. That's why you always have to have a plan for how you will restore your systems if they are disrupted. In SQL Server, if you want to choose to restore to a point in time, but you can only do that if you are running in full recovery model. Under the bulk-logged recovery model, it's more likely that you'll have to recover the database to the end of the transaction log backup.

One of the benefits of Azure SQL is that Azure can take care of all of this for you. Since Azure SQL manages your backups and runs in full recovery model, it can restore you to any point in time. You can even restore a deleted database. We also automatically encrypt your backups if you enable TDE on the logical server or instance.

By default, a full database backup is taken once a week, with log backups every 5-10 minutes, and differential backups every 12 hours. These backup files are stored in Azure Storage on read-access geo-redundant storage (RA-GRS). On an ongoing basis, the Azure SQL engineering team automatically tests the restore of automated databases backups of databases placed in logical servers and Elastic pools. For migrating to Azure SQL Managed Instance, an automatic initial backup with CHECKSUM of databases restored with the native RESTORE command or the Azure Database Migration Service is completed. Additionally, in Azure SQL Managed Instance, you can take a native COPY_ONLY backup and store it in Azure Blob storage.

## Creating a backup strategy with Azure SQL Managed Instance and Azure SQL Database

Even though Azure SQL takes care of the heavy lifting for you, it's still important to understand how the backups are stored and processed and what your options for retention and restoring are. Ultimately, you're still responsible for the overall strategy when it comes to point in time restore, long-term retention, and geo-restore.

### Point in time restore (PITR)

In Azure SQL Database and Azure SQL Managed Instance, you have the opportunity to conduct a self-service restore. You can select the exact point in time that you would like to restore and initiate it using the Azure portal, PowerShell/Azure CLI, or REST APIs. Point in time restore (PITR) will create a new database (different name) in the same logical server. If you need to replace the original database with the PITR database, you will have to rename both the original and the new database to get back to a working condition. No updates to connection strings will be needed.

As far as retention for PITR goes, it varies between 1 and 35 days. By default, the retention period (for all service tiers and deployment options) is seven days. In most deployment options and service tiers, you can configure the policy to be 1 to 35 days, depending on your scenario's requirements. For example, for a test database you may only need one day, but for a mission critical database, you may select the max of 35 days.

### Long-term retention (LTR)

If 35 days are not enough to meet your organization's needs or compliance, you can opt for long-term retention (LTR). This capability enables you to automatically create full database backups that are stored in RA-GRS storage for up to 10 years. For Azure SQL Database, LTR is generally available, and for Azure SQL Managed Instance, LTR is available in a limited public preview.

### Geo-restore

If there is a catastrophic event, your organization needs to be able to recover. Since your backups are automatically stored in RA-GRS storage, if an entire region went down and your databases or managed instances were in that region, you're protected. You can do a geo-restore to any other region from the most recent geo-replicated backup. This backup can be a bit behind from the primary, as it takes time to replicate the Azure blob to another region. You can easily perform a geo-restore using the Azure portal, PowerShell/Azure CLI, or REST APIs.
