
PaaS is different when it comes to availability; you can only configure the options that Azure provides.

For the SQL Server-based options of Azure SQL Database and Azure SQL Managed Instance, the options are active geo-replication (Azure SQL Database only) and auto-failover groups (Azure SQL Database or Azure SQL Managed Instance).

Azure SQL Database has a service level agreement, which guarantees availability of 99.99, meaning nearly no downtime should be encountered. If a node-level problem happens such as hardware failure, a built-in failover mechanism kicks in. All transactional changes to the database are written synchronously to storage upon commit. If a node-level interruption occurs, the database server automatically creates a new node and attaches the data storage.

From an application standpoint, you need to code the necessary retry logic because all connections are dropped as part of spinning up the new node and any in flight transactions are lost. This process is considered a best practice for any cloud application, as they should be designed to handle transient failures.

Azure SQL Database and Azure SQL Managed Instance offer the option to create read replicas. These replicas can be used for activities such as reporting, which helps offload work from the primary database. Additionally, read replicas enhance availability by being located in different regions, ensuring that your data remains accessible even if one region experiences issue.

## Database availability

In Azure SQL Database and Azure SQL Managed Instance, you can't set a database state to `OFFLINE` or `EMERGENCY`. If you think about it, `OFFLINE` doesn't make sense, because you can't attach databases. Because you can't use `EMERGENCY`, you can't do emergency mode repair, but you shouldn't have to because Azure manages and maintains the service. Other capabilities, like `RESTRICTED_USER` and dedicated admin connection (DAC), are allowed in Azure SQL Database.

Accelerated Database Recovery (ADR) is built into the engine. With ADR, the transaction log is aggressively truncated and a persisted version store (PVS) is used. This technology allows you to perform a transaction rollback instantly, solving a well-known problem with long-running transactions. It also allows Azure SQL to recover databases quickly.

In Azure SQL Database and Azure SQL Managed Instance, ADR greatly increases general database availability. It's a significant factor in the SLA. For these reasons, ADR is on by default and can't be turned off.

## Database consistency

As you learned in the beginning of this module, multiple copies of your data and backups exist both locally and across regions. Regularly, backup and restore integrity checks run. Detection for *lost write* and *stale read* is also in place. You can run `DBCC CHECKDB` (no repair), and `CHECKSUM` is on by default. In the back end, automatic page repair occurs when possible, and there's data integrity error alert monitoring. If there's no impact, repair without notification occurs. If there's an impact, proactive notification is provided.

