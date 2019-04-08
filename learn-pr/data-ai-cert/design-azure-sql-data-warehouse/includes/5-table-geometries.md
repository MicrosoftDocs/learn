Azure SQL Data Warehouse uses Azure Storage to keep user data safe. Because data is stored and managed by Azure Storage, SQL Data Warehouse charges separately for storage consumption. The data is sharded into distributions to optimize system performance. When you define the table, you can choose which sharding pattern to use to distribute the data. SQL Data Warehouse supports these sharding patterns:

- Hash
- Round-robin
- Replicated

You can use the following strategies to determine which pattern is most suitable for your scenario:

| Type | Great fit for... | Watch out if... |
|------|------------------|-----------------|
| **Replicated** | ✅ Small-dimension tables in a star schema with less than 2GB of storage after compression (~5x compression). | ⛔ Many write transactions are on the table (insert/update/delete).<br> ⛔ You change DWU provisioning frequently.<br> ⛔ You use only 2-3 columns, but your table has many columns.<br> ⛔ You index a replicated table.|
| **Round-robin (default)** | ✅ Temporary/Staging table<br> ✅ No obvious joining key or good candidate column. | ⛔ Performance is slow due to data movement. |
| **Hash** | ✅ Fact tables.<br> ✅ Large-dimension tables. | ⛔ The distribution key can't be updated. |

Here are some tips that can help you choose a strategy:

- Start with round-robin, but aspire to a hash-distribution strategy to take advantage of a massively parallel processing (MPP) architecture.
- Make sure that common hash keys have the same data format.
- Don't distribute on `varchar` format.
- Use a common hash key between dimension tables and the associated fact table to allow join operations to be hash-distributed.
- Use `sys.dm_pdw_request_steps` to analyze data movements behind queries and monitor how long broadcast and shuffle operations take. This is helpful when you review your distribution strategy.

## Hash-distributed tables

A hash-distributed table can deliver the highest query performance for joins and aggregations on large tables.

To shard data into a hash-distributed table, SQL Data Warehouse uses a hash function to assign each row to one distribution deterministically. In the table definition, one of the columns is designated the distribution column. The hash function uses the values in the distribution column to assign each row to a distribution.

Here's an example of a `CREATE TABLE` statement that defines a hash distribution:

```sql
CREATE TABLE [dbo].[EquityTimeSeriesData](
    [Date] [varchar](30) ,
    [BookId] [decimal](38, 0) ,
    [P&L] [decimal](31, 7) ,
    [VaRLower] [decimal](31, 7) 
) 
WITH
(
    CLUSTERED COLUMNSTORE INDEX
,    DISTRIBUTION = HASH([P&L])
)
;
```

## Round-robin distributed tables

A round-robin table is the most straightforward table you can use to create and deliver fast performance in a staging table for loads.

A round-robin distributed table distributes data evenly across the table but without additional optimization. A distribution is first chosen at random. Then, buffers of rows are assigned to distributions sequentially. Loading data into a round-robin table is quick, but query performance often is better in hash-distributed tables. Joins on round-robin tables require reshuffling data and this takes more time.

Here's an example of a `CREATE TABLE` statement that defines a round-robin distribution:

```sql
CREATE TABLE [dbo].[Dates](
    [Date] [datetime2](3) ,
    [DateKey] [decimal](38, 0) ,
    ..
    ..
    [WeekDay] [nvarchar](100) ,
    [Day Of Month] [decimal](38, 0) 
)

WITH
(
    CLUSTERED COLUMNSTORE INDEX
,    DISTRIBUTION = ROUND_ROBIN
)
;
```

## Replicated tables

A replicated table provides the fastest query performance for small tables.

A table that is replicated caches a full copy on each compute node. Consequently, replicating a table removes the need to transfer data among compute nodes before a join or aggregation. Replicated tables work best in small tables. Extra storage is required, and additional overhead is incurred when writing data, which make large tables impractical.

Here's an example of a `CREATE TABLE` statement that defines a replicated distribution:

```sql
CREATE TABLE [dbo].[BusinessHierarchies](
    [BookId] [nvarchar](250)  ,
    [Division] [nvarchar](100) ,
    [Cluster] [nvarchar](100) ,
    [Desk] [nvarchar](100) ,
    [Book] [nvarchar](100) ,
    [Volcker] [nvarchar](100) ,
    [Region] [nvarchar](100) 
) 
WITH
(
    CLUSTERED COLUMNSTORE INDEX
,    DISTRIBUTION = REPLICATE
)
;
```