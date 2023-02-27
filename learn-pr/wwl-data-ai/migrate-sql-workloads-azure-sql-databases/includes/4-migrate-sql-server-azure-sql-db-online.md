If you need a database to remain available to users throughout the migration process, you can use transactional replication to move the data.

In your bicycle manufacturer, warehouses run on a 24 hour, 7 days a week basis, and there are no periods of inactivity. Your board of directors wants to be sure that the part stock database is constantly available, even during the migration to Azure SQL Database.

Here, you'll learn how to use transactional replication to perform an online database migration.

## What is transactional replication?

Where the source system is business-critical and must remain online throughout the migration, transactional replication uses an initial snapshot to copy the data to the Azure SQL database. The source and target systems are kept in sync until the final cutover takes place. Configuration of transactional replication is done through SQL Server Management Studio, or by executing Transact-SQL statements on the publisher. Transactional replication requires the following components:

- **Publisher:** a database instance that hosts the data to be replicated (source).
- **Subscriber(s):** a database instance that receives the data being replicated by the *Publisher* (target(s)).
- **Distributor:** a database instance that stores the replication changes made at the *Publisher* (source) that are required at the *Subscriber(s)* (target(s)).
- **Article:** a database object; for example, a table that's included in the *Publication*.
- **Publication:** a collection of one or more articles from the database being replicated.
- **Subscription:** a request from a *Subscriber* for a *Publication* from a *Publisher*.

The publisher and distributor must be at least the following version and update:

- SQL Server 2017 (14.x)
- SQL Server 2016 (13.x)
- SQL Server 2014 (12.x) SP1 CU3
- SQL Server 2014 (12.x) RTM CU10
- SQL Server 2012 (11.x) CU8 or SP3

## Transactional replication considerations

- Replicated tables must have a primary key
- Transactional replication can't be configured from the Azure portal
- Using the latest version of SQL Server management tools is recommended

Here are the roles that can be used with Azure SQL Database:

| Role | Single and pooled databases | SQL Managed Instance databases |
| --- | --- | --- |
| Publisher | No | Yes |
| Distributor | No | Yes |
| Pull subscriber | No | Yes |
| Push subscriber | Yes | Yes |

When synchronization is complete and you're ready to migrate, change the connection string of your applications to point them to your Azure SQL database. After transactional replication drains any changes left on your source database, and all your applications point to Azure SQL Database, you can uninstall transactional replication. Your Azure SQL database is now your production system.

> [!NOTE]  
> A pull subscription isn't supported when the distributor is a managed instance database and the subscriber is not.
