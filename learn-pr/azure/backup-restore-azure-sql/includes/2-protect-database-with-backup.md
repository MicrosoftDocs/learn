If the data that you keep in Azure SQL Database is critical, you must think carefully about how to back it up to ensure that you can restore it reliably and quickly if a problem arises.

The retail organization that you work for uses Azure SQL Database to underpin its enterprise resource planning (ERP) system. The company uses this system for all its accounting, customer relationship management, sales management, and corporate governance procedures. If this data were to be lost, the business would suffer huge losses and might even have to cease operations. The board has given you responsibility for the protection of this data. You want to be sure that if a disaster happened, you could restore all the data up to the failure within three hours.

Here, you will learn about Azure SQL Database backups and how to use them effectively.

## Azure SQL Database backups storage

SQL Database automatically creates database backups. The backups are kept for between 7 and 35 days. The retention time depends on the purchasing model and the service tier you chose when you created your database. When the backups are complete, they are stored as blobs in a Read-Access Geo Redundant Storage (RA-GRS) account in your Azure subscription. To ensure protection against a data center outage, they are replicated to a paired data center.

Azure SQL Database uses SQL Server technology to make these types of backups:

- **Full backups**: In a full backup, everything in the database and the transaction logs is backed up. SQL Database makes a full backup once a week.
- **Differential backups**: In a differential backup, everything that changed since the last full backup is backed up. SQL Database makes a differential backup every 12 hours.
- **Transactional backups**: In a transactional backup, the contents of the transaction logs are backed up. SQL Database makes a transaction log backup every five to 10 minutes. Transactional backups enable administrators to restore up to a specific point in time, which includes the moment before data was mistakenly deleted.

These backups can be used to restore an existing database, restore a deleted database up to the point in time when it was deleted, restore the database to an alternative location or region, and to restore a database from a long-term backup using Long Term Retention (LTR). When a failure occurs, you may lose changes from up to five minutes ago, if the live transaction logs are lost. If the transaction logs are intact, you can restore up to the moment that the failure occurred. 

## Backups and service tiers

The default backup retention period is set to seven days when you create a database. Later, you can change that period to a duration from zero to 35 days. When a database is created using the Data Transaction Unit (DTU) based purchasing model, the default retention period for that database depends on the service tier:

| Service tier  | Default retention period  |
|---------------|---------------------------|
| Basic         | One week                  |
| Standard      | Five weeks                |
| Premium       | Five weeks                |

## How often do backups happen?

There are backups for point-in-time restore and there are backups for Long Term Retention (LTR).

Point-in-time restore is fully supported by SQL databases. They automatically create full backups, differential backups, and transaction log backups. The first full backup is scheduled as soon as the database is created. It usually completes within 30 minutes but may take longer if the database is of significant size. Following the first full backup, all further backups are scheduled automatically and managed silently in the background. The exact timing of all database backups is determined by the SQL Database service as it balances the overall system workload. You cannot change or disable the backup jobs.

Backups for LTR offer full backups that are kept up to 10 years in Azure Blob Storage accounts. You can configure the LTR policy to perform automatic weekly full backups. The storage of LTR backups depends on the frequency chosen and the retention period being used.

## Storage costs

Microsoft provides Azure Backup services to create all-encompassing backups with a predictable pricing system that lets you easily keep track of any Azure data backup costs. Pricing for Azure Backup for SQL Server is based on paying for both instance costs (the data getting protected) and storage costs each month.

Seven days of automated backups of your databases are copied to RA-GRS Standard blob storage by default. The storage is used by weekly full backups, daily differential backups, and transaction log backups copied every 5 minutes. The size of the transaction log depends on the rate of change of the database. A minimum storage amount equal to 100% of database size is provided at no extra charge. Additional consumption of backup storage will be charged in GB/month.

## Benefits of using Azure Backups

Azure backup realizes the following benefits:

- You can reduce your infrastructure costs, because there are minimal upfront costs and minimal operational expenses.
- You can use a range of enterprise-level features to ensure your data is backed up, secure, and stored in a separate location from your database.
- You can store three copies of your data in three different locations in the primary Azure data center, and another three copies in an alternative remote Azure data center. This arrangement protects against all but the most severe of disasters.
- Your data is encrypted before it leaves the source database, whether it's in transit or held in the Azure backup vault.
