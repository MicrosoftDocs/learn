You now know about the high availability and disaster recovery architectures in Azure SQL Managed Instance and Azure SQL Database. If you have some background working with SQL Server, you might be aware of how database availability and consistency can be managed. In this unit, you'll learn about performing those tasks in Azure SQL.

## Database availability

In Azure SQL Database and Azure SQL Managed Instance, you can't set a database state to `OFFLINE` or `EMERGENCY`. If you think about it, `OFFLINE` doesn't make sense, because you can't attach databases. Because you can't use `EMERGENCY`, you can't do emergency mode repair. But you shouldn't have to because Azure manages and maintains the service. Other capabilities, like `RESTRICTED_USER` and dedicated admin connection (DAC), are allowed in Azure SQL Database.

Accelerated Database Recovery (ADR) is built into the engine. With ADR, the transaction log is aggressively truncated and a persisted version store (PVS) is used. This technology allows you to perform a transaction rollback instantly, solving a well-known problem with long running transactions. It also allows Azure SQL to recover databases quickly.

In Azure SQL Database and Azure SQL Managed Instance, ADR greatly increases general database availability. It's a significant factor in the SLA. For these reasons, ADR is on by default and can't be turned off.

## Database consistency

As you learned in the beginning of this module, multiple copies of your data and backups exist both locally and across regions. On a regular basis, backup and restore integrity checks run. Detection for *lost write* and *stale read* is also in place. You can run `DBCC CHECKDB` (no repair), and `CHECKSUM` is on by default. In the back end, automatic page repair will occur when possible, and there's data integrity error alert monitoring. If there's no impact, repair without notification occurs. If there is an impact, proactive notification is provided.
