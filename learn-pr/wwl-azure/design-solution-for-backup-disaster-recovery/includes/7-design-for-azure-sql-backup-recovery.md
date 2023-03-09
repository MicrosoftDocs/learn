Azure Architects understand that database recoverability is an essential component of a backup and restore solution. A robust plan includes automated backup for Azure SQL Database and Azure SQL Managed Instance. Database backups should enable database restoration to a specific point in time within the configured retention period.

### Things to know about Azure SQL backup and recovery

Let's take a look at how backups are created and recovered for SQL databases and SQL managed instances.

- Azure SQL Database and Azure SQL Managed Instance use SQL Server technology to create three types of backup.

   | Backup | Frequency | Description | 
   | --- | --- | --- |
   | **Full** | Once per week | [Full backups](/sql/relational-databases/backup-restore/full-database-backups-sql-server) store everything in your database and also your transaction logs. Full backups are useful when you're upgrading your infrastructure or performing data migration. When you implement LTR, you can restore a full backup to create a new database. | 
   | **Differential** | Every 12 to 24 hours | [Differential backups](/sql/relational-databases/backup-restore/differential-backups-sql-server) store everything that's changed in your database since the time of the last full backup. You can quickly recover a database to a recent version, such as yesterday, by restoring from a differential backup. This option is helpful if your database experiences unexpected incorrect changes. |
   | **Transaction log**| Every 5 to 10 minutes | [Transaction log backups](/sql/relational-databases/backup-restore/transaction-log-backups-sql-server) store the contents of the database transaction logs. The frequency of transaction log backups is based on your compute size and the amount of database activity. If the most recent transaction log fails or is corrupt, you can fall back to the previous transaction log backup. Transactional backups enable administrators to restore up to a specific time, which includes the moment before data was mistakenly deleted. |

- When you restore your database, the service determines which specific backups to restore. The restore process can include recovery of a combination of backup types.

- SQL Database _automatic backups_ support a long retention period for your backups. Database backups can remain available to restore for up to 35 days.

- If you're required to keep your backups for more than 35 days, implement _long-term retention_ (LTR). You can store Azure SQL Database **full** backups in read-access geo-redundant storage (RA-GRS) blobs for up to 10 years. 

### Things to consider when using automated backups

The following scenarios highlight some best use cases for automated backup of your SQL databases. As you review these cases, consider how automated backups for SQL database can benefit the Tailwind Traders BCDR solution.

- **Consider restore to point in time**. Create automated backups so you can [restore an existing database to a specified point in time in the past](/azure/azure-sql/database/recovery-using-backups#point-in-time-restore) within your defined retention period. This operation creates a new database on the same server as the original database. A different name is assigned to the restored database to avoid overwriting the original database. After the restore completes, you can delete the original database.

- **Consider restore deleted database**. Implement automated backups to enable [recovery of a deleted database to the point in time that it was deleted](/azure/azure-sql/database/recovery-using-backups#deleted-database-restore). You can also restore a deleted database to any point in time within the retention period. The deleted database can be restored only on the same server or managed instance where the original database was created.

- **Consider restore to region**. Configure automated backup for your SQL database so you can [restore your database to another geographic region](/azure/azure-sql/database/recovery-using-backups#geo-restore). Geo-restore allows you to recover from a geographic disaster when you can't access your database or backups in the primary region. The operation creates a new database on any existing server or managed instance, in any Azure region.

- **Consider restore to old version**. Recover older data, such as previous versions of a database by implementing a long retention policy for your backups (up to 35 days). Automated backup lets you [restore a database from a specific long-term backup](/azure/azure-sql/database/long-term-retention-overview) of a single database or pooled database.

- **Consider long-term retention**. Satisfy data protection regulations in your local jurisdiction that might require backup retention for several years. Use LTR and store your full backups in RA-GRS blobs for up to 10 years. If you need access to any backup in LTR, you can restore it as a new database by using either the Azure portal or PowerShell.