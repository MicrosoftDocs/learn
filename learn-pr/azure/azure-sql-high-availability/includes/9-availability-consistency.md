You now know about the high availability and disaster recovery architectures in Azure SQL Managed Instance and Azure SQL Database. Potentially coming from a SQL Server background, you're aware of how database availability and consistency can be managed, so in this unit you'll learn about how it compares to Azure SQL.

## Database availability

In both Azure SQL Database and Azure SQL Managed Instance, you cannot set a database state to `OFFLINE` and `EMERGENCY`. If you think about it, `OFFLINE` doesn't make sense, since you cannot attach databases, and `EMERGENCY` being restricted means you cannot do emergency mode repair, but you shouldn't have to, since Azure manages and maintains the service. However, other capabilities such as `RESTRICTED_USER` and Dedicated Admin Connection (DAC) are allowed in Azure SQL Database.

Accelerated Database Recovery (ADR) is a capability built in to the engine. With ADR, the transaction log is aggressively truncated and a Persisted Version Store (PVS) is used. This technology allows you to perform a transaction rollback instantly, solving a well-known issue with long running transactions. It also means Azure SQL can recover databases quickly.

In Azure SQL Database and Azure SQL Managed Instance, ADR greatly increases the general database availability, and is a big factor in the SLA. For these reasons, ADR is on by default and it cannot be turned off.

## Database consistency

As you learned in the beginning of the module, multiple copies of your data and backups exist both locally and across regions. On a regular basis, backup and restore integrity checks are performed. Detection for *lost write* and *stale read* is also in place. As a user, you can execute `DBCC CHECKDB` (no repair) and `CHECKSUM` is on by default. In the backend, Auto Page Repair will occur when possible, and there is data integrity error alert monitoring. If there is no impact, repair without notification will occur, but if there is any impact proactive notification will be provided.
