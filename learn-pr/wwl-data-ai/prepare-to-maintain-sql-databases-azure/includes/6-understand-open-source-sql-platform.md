
Microsoft offers the most popular open-source SQL database platforms on Azure, such as MySQL, MariaDB, and PostgreSQL. The architecture and features are similar to that of the Azure SQL Database, but running different database engines. An extra benefit of these solutions is that they also integrate with other services like Azure Web Apps.
 
## Network connectivity

Similar to SQL Database, there is a firewall that can be set for specific IP address or range of IP addresses, or you can configure a virtual network endpoint to allow connections from an Azure Virtual Network.

## Query Store

The query store feature is available on Azure Database for PostgreSQL, MySQL and MariaDB. The query store keeps track of both query and wait statistics, and implementation is slightly different compared to SQL Database and SQL Managed Instance offerings.

[!div class="mx-imgBorder"]
> [![Query Performance Insight in Azure Portal for PostgreSQL](../media/prepare_to_maintain_sql_databases_azure_05.png)](../media/../media/prepare_to_maintain_sql_databases_azure_05.png#lightbox)

The image above shows the Query Performance Insight dashboard in the Azure portal for PostgreSQL, and offers a quick way to identify expensive queries for your database.

Alternatively, you can query data in query store as follow:
```sql
# On Azure Database for PostgreSQL.
SELECT * FROM query_store.qs_view;

# On Azure Database for MySQL and MariaDB.
SELECT * FROM mysql.query_store;
```

Or this query for wait statistics:
```sql
# On Azure Database for PostgreSQL.
SELECT * FROM query_store.pgms_wait_sampling_view;

# On Azure Database for MySQL and MariaDB.
SELECT * FROM mysql.query_store_wait_stats;
```