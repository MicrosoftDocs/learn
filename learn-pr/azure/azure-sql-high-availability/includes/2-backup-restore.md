In all organizations, big or small, accidents can happen. That's why you always have to have a plan for how you will restore to where you need to be. In SQL Server, ideally, you want choose to [restore to a point in time](https://docs.microsoft.com/sql/relational-databases/backup-restore/restore-a-sql-server-database-to-a-point-in-time-full-recovery-model?view=sql-server-ver15), but you can only do that if you are running in full recovery model. Under the bulk-logged recovery model, it's more likely that you'll have to recover the database to the end of the transaction log backup.

One of the benefits of Azure SQL is that Azure can take care of all of this for you. Since Azure SQL manages your backups and runs in full recovery model, it can restore you to any point in time (you can even [restore a deleted database](https://docs.microsoft.com/azure/sql-database/sql-database-recovery-using-backups#deleted-database-restore)).

## Creating a backup strategy with Azure SQL Managed Instance and Azure SQL Database

Even though Azure SQL takes care of the heavy lifting for you, it's still important to understand how the backups are stored and processed and what your options for retention and restoring are. Ultimately, you're still responsible for the overall strategy when it comes to backups, long term retention, and geo-restore.

### Automated backups and Point in Time Restore (PITR)

TODO

### Long term retention (LTR)

TODO

### Geo-restore

TODO

In the next exercise, you'll see how a common error can be recovered using point in time restore (PITR).
