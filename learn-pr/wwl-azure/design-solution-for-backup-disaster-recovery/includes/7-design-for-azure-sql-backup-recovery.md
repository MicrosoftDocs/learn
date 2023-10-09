It's essential that you can recover your SQL database data. You should consider automated backups of your Azure SQL Database and Azure SQL Managed Instances. Database backups enable database restoration to a specified point in time and within a configured retention period.

### Describe automated backups

Both SQL Database and SQL Managed Instance use SQL Server technology to create [full backups](/sql/relational-databases/backup-restore/full-database-backups-sql-server) every week, [differential backups](/sql/relational-databases/backup-restore/differential-backups-sql-server) every 12-24 hours, and [transaction log backups](/sql/relational-databases/backup-restore/transaction-log-backups-sql-server) every 5 to 10 minutes. The frequency of transaction log backups is based on the compute size and the amount of database activity. When you restore a database, the service determines which full, differential, and transaction log backups need to be restored.

- **Full backups**: In a full backup, everything in the database and the transaction logs is backed up. SQL Database makes a full backup once a week.

- **Differential backups**: In a differential backup, everything that changed since the last full backup is backed up. SQL Database makes a differential backup every 12 - 24 hours.

- **Transactional backups**: In a transactional backup, the contents of the transaction logs are backed up. If the latest transaction log has failed or is corrupted, the option is to fall back to the previous transaction log backup. Transactional backups enable administrators to restore up to a specific time, which includes the moment before data was mistakenly deleted. Transaction log backups every five to 10 minutes.

### Describe backup usage cases

You can use the automated backups in several ways. 

- [Restore an existing database to a point in time in the past](/azure/azure-sql/database/recovery-using-backups) within the retention period. This operation creates a new database on the same server as the original database but uses a different name to avoid overwriting the original database. After the restore completes, you can delete the original database. 

- [Restore a deleted database to the time of deletion](/azure/azure-sql/database/recovery-using-backups) or to any point in time within the retention period. The deleted database can be restored only on the same server or managed instance where the original database was created. 

- [Restore a database to another geographic region](/azure/azure-sql/database/recovery-using-backups). Geo-restore allows you to recover from a geographic disaster when you cannot access your database or backups in the primary region. It creates a new database on any existing server or managed instance, in any Azure region.

- [Restore a database from a specific long-term backup](/azure/azure-sql/database/long-term-retention-overview) of a single database or pooled database. If the database has been configured with a long-term retention policy you can restore an old version of the database.

 

### Long-term backup retention policies

Azure SQL Database automatic backups remain available to restore for up to 35 days. This period is enough for the purposes of day-to-day administration. But sometimes you might need to retain data for longer periods. For example, data protection regulations in your local jurisdiction might require you to keep backups for several years.

For these requirements, use the long-term retention (LTR) feature. This way, you can store Azure SQL Database backups in read-access geo-redundant storage (RA-GRS) blobs for up to 10 years. If you need access to any backup in LTR, you can restore it as a new database by using either the Azure portal or PowerShell.