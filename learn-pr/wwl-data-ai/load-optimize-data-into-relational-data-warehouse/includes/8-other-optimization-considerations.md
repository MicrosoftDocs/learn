
##Materialized Views
Materialized views are prewritten queries with joins and filters whose definition is saved and the results persisted to a dedicated SQL pool. They are not supported by default in serverless SQL pools.

Materialized views results in increased performance since the data within the view can be fetched without having to resolve the underlying query to base tables. You can also further filter and supplement other queries as if it is a table also. In addition, you also can define a different table distribution within the materialized view definition that is different from the table on which it is based.

As a result, you can use Materialized Views to improve the performance of either complex or slow queries. As the data in the underlying base tables change, the data in the materialized view will automatically update without user interaction.

There are several restrictions that you must be aware of before defining a materialized view:

- The SELECT list in the materialized view definition needs to meet at least one of these two criteria:
    - The SELECT list contains an aggregate function.
    - GROUP BY is used in the Materialized view definition and all columns in GROUP BY are included in the SELECT list. Up to 32 columns can be used in the GROUP BY clause.

-	Supported aggregations include MAX, MIN, AVG, COUNT, COUNT_BIG, SUM, VAR, STDEV.

-	Only the hash and round_robin table distribution is supported in the definition.

-	Only CLUSTERED COLUMNSTORE INDEX is supported by materialized view.

The following is an example of creating a materialized view named myview, using a hash distribution selecting two columns from a table and grouping by them.

```sql
create materialized view mview 
with(distribution=hash(col1)) 
as select col1, col2 from dbo.table group by col1, col2;
```
##Read-committed snapshots
Whilst Azure Synapse Analytics is used for the storage of data for analytical purposes, SQL Pools do support the use of transactions and adhere to the ACID (Atomicity, Consistency, Isolation, and Durability) transaction principles associated with relational database management systems.

As such, locking, and blocking mechanisms are put in place to maintain transactional integrity while providing adequate workload concurrency. These blocking aspects may significantly delay the completion of queries. The isolation level of the transactional support is defaulted to READ UNCOMMITTED. You can change it to READ COMMITTED SNAPSHOT ISOLATION by turning ON the READ_COMMITTED_SNAPSHOT database option for a user database when connected to the master database.

Once enabled, all transactions in this database are executed under READ COMMITTED SNAPSHOT ISOLATION and setting READ UNCOMMITTED on session level will not be honored. 

If you experience delays in the completion of queries, the Read Committed Snapshot Isolation level should be employed to alleviate this. Read Committed Snapshot, makes a copy of the rows that are being referenced in a query if it is being updated, so that the data is consistent. The version of the data being used remains only for the duration of the query and any dependant queries, which are faster for query completion at the expense of space needed to storer multiple versions of the data during workloads.

To enable READ COMMITTED SNAPSHOT ISOLATION,  run this command when connecting to the MASTER database.

```sql
ALTER DATABASE MyDatabase
SET READ_COMMITTED_SNAPSHOT ON
```

##Result caching
Enable result-set caching when you expect results from queries to return the same values.

This option stores a copy of the result set on the control node so that queries do not need to pull data from the storage subsystem or compute nodes. The capacity for the result set cache is 1 TB and the data within the result-set cache is expired and purged after 48 hours of not being accessed.

Azure Synapse SQL automatically caches query results in the user database for repetitive use. Result-set caching allows subsequent query executions to get results directly from the persisted cache so recomputation is not needed. Result set caching improves query performance and reduces compute resource usage.

To enable result set caching, run this command when connecting to the MASTER database.

```sql
ALTER DATABASE [database_name]
SET RESULT_SET_CACHING ON;
```
