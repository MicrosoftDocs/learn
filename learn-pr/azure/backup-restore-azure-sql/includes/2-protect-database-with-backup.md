The retail organization for which you work uses Azure SQL Database to store the relational data for its enterprise resource planning (ERP) system. The company uses this system for all its accounting, customer relationship management, sales management, and corporate governance procedures. If you can help prevent the organization from losing this data, you can prevent the business from potentially suffering huge losses and possibly having to cease operations.

The board has given you responsibility for the protection of this data. You want to be sure that if a disaster happens, you can restore all the data up to the failure within three hours.

Let's learn about Azure SQL Database backups and how to use them effectively.

## Storage for Azure SQL Database backups

SQL Database automatically creates database backups and keeps them for seven to 35 days. The retention time depends on the purchasing model and the service tier that you choose when you create your database. When the backups are complete, SQL Database stores them as blobs in a read-access geo-redundant storage (RA-GRS) account in your Azure subscription. SQL Database replicates the RA-GRS accounts to a paired region, giving you protection from service issues in any one region.

Azure SQL Database uses SQL Server technology to make these types of backups:

- **Full backups**: In a full backup, SQL Database backs up everything in the database and the transaction logs. SQL Database makes a full backup once a week.
- **Differential backups**: In a differential backup, SQL Database backs up everything that changed since the last full backup. SQL Database makes a differential backup every 12 hours.
- **Transactional backups**: In a transactional backup, SQL Database backs up the contents of the transaction logs. If the latest transaction log fails or becomes corrupted, the option is to fall back to the previous transaction log backup, assuming retention is following the guidelines here: [Automated backups in Azure SQL Database](/azure/azure-sql/database/automated-backups-overview?tabs=single-database). Transactional backups allow administrators to restore up to a specific time, which includes the moment before data was mistakenly deleted.

You can use these backups to:

- Restore an existing database.
- Restore a deleted database up to the time when the deletion occurred.
- Restore the database to an alternative location or region.
- Restore a database from a long-term backup by using long-term retention (LTR).

When a failure occurs, you might lose changes from up to five minutes ago if you lose the live transaction logs. If the transaction logs are intact, you can restore up to the moment that the failure occurred.

## Backups and service tiers

When you create a database, the default backup retention period is seven days. Later, you can change that period to a duration from zero to 35 days. When you create a database by using the purchasing model based on Data Transaction Units (DTUs), the default retention period for that database depends on the service tier:

| Service tier  | Default retention period  |
|---------------|---------------------------|
| Basic         | One week                  |
| Standard      | Five weeks                |
| Premium       | Five weeks                |

## How often do backups happen?

There are backups for point-in-time restore, and there are backups for long-term retention (LTR).

SQL databases fully support point-in-time restore. They automatically create full backups, differential backups, and transaction-log backups. SQL Database service schedules the first full backup as soon as you create the database. It usually finishes within 30 minutes, but it might take longer if the database is of significant size.

After the first full backup, SQL Database service schedules all further backups automatically and manages them silently in the background. The service determines the exact timing of all database backups, because it balances the overall system workload. You can't change or disable the backup jobs.

SQL Database service keeps full backups for LTR for up to 10 years in Azure Blob storage accounts. You can configure the LTR policy to perform automatic weekly full backups. LTR backup storage depends on the frequency and the retention period that you choose.

## Storage costs

Microsoft provides Azure backup services to create all-encompassing backups with a predictable pricing system that lets you easily keep track of any Azure data backup costs. SQL Server backup pricing is based on paying for both instance costs (the data getting protected) and storage costs each month.

By default, Azure backup copies seven days of your automated database backups to RA-GRS standard blob storage. Azure uses this storage for weekly full backups, daily differential backups, and transaction log backups that it copies every five minutes. The size of the transaction log depends on the rate of change of the database.

Azure backups provide a minimum storage amount equal to 100 percent of database size at no extra charge. Extra consumption of backup storage is charged in gigabytes per month.

## Benefits of using Azure backups

Azure backups offer the following benefits:

- You can reduce your infrastructure costs, because there are minimal upfront costs and minimal operational expenses.
- You can use a range of features to back up your data, secure it, and store it in a separate location from your database.
- You can store three copies of your data in three different locations in the primary Azure datacenter. You can store another three copies in an alternative remote Azure datacenter. This arrangement protects against all but the most severe disasters.
- Your data is encrypted before it leaves the source database, whether it's in transit or held in the Azure backup vault.
