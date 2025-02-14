Postgres uses a process-based connection model. Establishing a connection involves the operating system, and the allocation of a small amount of memory. Each SQL query is executed using a current connection.

## Connection states

A connection could be in one of four states:

- **active** - active connections, which are currently running queries.
- **idle** - open connections that aren't in use.
- **idle in transaction** - a connection waiting, not doing any work. Use **pg_stat_activity** to understand what a connection is doing, and how long it's at this state.
- **idle in transaction (aborted)** - connections that were previously **idle in transaction** but are now aborted.

The process-based connection model makes it expensive to maintain many idle connections.

## Maximum connections

PostgreSQL limits the maximum number of concurrent connections to the server at any one time using a server parameter called **max_connections**. In Azure Database for PostgreSQL, the default depends on your compute tier. The allowed value is between 25 and 5000.

An on-premises implementation of PostgreSQL reserves some connections for the super user to maintain the integrity of the database. This reservation would typically be 15% of the **max_connections** value.

Azure Database for PostgreSQL is a managed solution and automatically reserves three connections to monitor a flexible server.

> [!NOTE]
> There is no server parameter to manage **superuser_reserved_connections** in Azure Database for PostgreSQL.

## Connection pooling

Client applications that frequently open and close connections can experience connection latency, resulting in lower transactions per second, and overall higher application latency.

Azure Database for PostgreSQL recommends connection pooling instead of frequently opening and closing connections. Connection pooling reuses existing connections, rather than closing and recreating connections. This process reduces connection latency and allows higher database transactions per second for databases on the server.

Connection pooling establishes a fixed set of connections when the server is started, and these connections are then maintained. Connection pooling also helps reduce the memory fragmentation caused by new connections constantly being created on the server.

[`PGBouncer`](http://www.pgbouncer.org/) is a connection pooling solution that is built into Azure Database for PostgreSQL. To enable pgBouncer:

1. In the Azure portal, navigate to your Azure Database for PostgreSQL server.
1. From the left menu, select **Server Parameters**.
1. In the search bar, search for **PgBouncer**.
1. Set the **pgbouncer.enabled** setting to true to enable PgBouncer. This setting doesn't require a restart of the server.
1. Set **pgbouncer.default_pool_size** to the number of connections per user/database pair that you require. The default is 50.
1. Set the **pgBouncer.pool_mode** parameter to TRANSACTION.

> [!NOTE]
> PgBouncer is supported on General Purpose and Memory Optimized compute tiers in both public access and private access networking. PgBouncer is not supported on the Burstable compute tier. When the compute tier is changed from General Purpose or Memory Optimized to Burstable, the PGBouncer capability is lost.
