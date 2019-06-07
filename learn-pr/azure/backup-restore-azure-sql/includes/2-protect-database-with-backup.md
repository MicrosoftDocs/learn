## Azure SQL Backups

SQL Database automatically creates the database backups that are kept between 7 and 35 days and the time frame also depends on the purchasing model and the service tier. The database used SQL Server Technology to allow for complete backups every week, transaction log backups every 5-10 minutes and differential backups every 12 hours. When the backups are complete they are stored in RA-GRS storage blobs; to ensure protection against a data centre outage, they are replicated to a paired data centre.

These backups can be used to restore an existing database, restore a deleted database from when it was deleted, restore the database to an alternative location or region, geographically and also restoring a database from a long term back up using LTR (Long Term Retention).

### Default backups are set depending on each service tier

Default backup retention period is when you create a database and the retention period is seven days. After the database had been created the backup retention period can be modified from 0 to 35 days. When a database is created using the DTU based purchasing model, the default retention period for that database depends on the service tier.

- Basic service tier is one week
- Standard service tier is five weeks
- Premium service tier is five weeks.

### How often do backups happen?

There are backups for point in time restore and there are backups for long term retention. Point In Time Restore is fully supported by SQL databases, they automatically create full backup, differential backups, and transaction log backups.

The first full backup is scheduled as soon as the database is created. It completes within 30 minutes. If the database is of significant time it may take longer. Following the first full backup, all further backups are scheduled automatically and managed silently in the background. The exact timing of all database backups is determined by the SQL Database service as it balances the overall system workload. You cannot change or disable the backup jobs.

Backups for long-term retention offer full term backups for 10 years in the Azure Blob storage. The LTR policy can be enabled to allow automatic weekly full backups. Storage of those depends on the frequency chosen and the retention period being used.

### Storage costs

Microsoft provides Azure Backup services to create all-encompassing backups with a predictable pricing system that lets you easily keep track of any Azure data backup costs. Pricing for Azure Backup for SQL Server is based on paying for both instance costs (the data getting protected) and storage costs each month.

Seven days of automated backups of your databases are copied to RA-GRS Standard blob storage by default. The storage is used by weekly full backups, daily differential backups, and transaction log backups copied every 5 minutes. The size of the transaction log depends on the rate of change of the database. A minimum storage amount equal to 100% of database size is provided at no extra charge. Additional consumption of backup storage will be charged in GB/month.

### Benefits of using Azure Backups

Azure backup contains the following benefits:

- Reduction in your infrastructure costs, minimum upfront costs and minimal operational expense.
- Provide enterprise features to ensure your data is backed up, secure and most importantly, offsite.
- Azure backup stores three copies of your data in three different locations in the primary Azure data center, and another three copies in an alternative remote Azure data center. Your data is also encrypted before it leaves the source, or whether it's in transit or held in the Azure backup vault.

## Knowledge check

    - When are backups taken?
        - After a day
        - Immediately (correct answer)
        - It's a manual process
    - Where are Azure SQL backups stored?
        - Locally
        - You have to specify their location
        - In RA-GRS storage blobs (correct answer)
