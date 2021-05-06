Azure Synapse Analytics uses Azure Storage to store data. Because the data is stored and managed by Azure Storage, Azure Synapse Analytics charges separately for the storage consumption. The data itself is sharded into distributions to optimize the performance of the system. You can choose which sharding pattern to use to distribute the data when you define the table. Azure Synapse Analytics supports these sharding patterns:

- Hash
- Round Robin
- Replicate

> [!VIDEO https://channel9.msdn.com/Shows/Learn-Azure/Table-Geometries/player?format=ny]

You can use the following strategies to determine which pattern is most suitable for your scenario.

| Type | Great fit for... | Watch out if... |
|------|------------------|-----------------|
| **Replicated** | ✅ Small-dimension tables in a star schema with less than 2GB of storage after compression (~5x compression). | ⛔ Many write transactions are on the table (insert/update/delete).<br> ⛔ You change DWU provisioning frequently.<br> ⛔ You use only 2-3 columns, but your table has many columns.<br> ⛔ You index a replicated table.|
| **Round-robin (default)** | ✅ Temporary/Staging table<br> ✅ No obvious joining key or good candidate column. | ⛔ Performance is slow due to data movement. |
| **Hash** | ✅ Fact tables.<br> ✅ Large-dimension tables. | ⛔ The distribution key can't be updated. |

Here are some tips that can help you choose a strategy:

- Start with Round Robin, but aspire to a Hash distribution strategy to take advantage of a massively parallel architecture.
- Make sure that common hash keys have the same data format.
- Do not distribute on *varchar* format.
- Dimension tables with a common hash key to a fact table with many join operations can be hash distributed.
- Use *sys.dm_pdw_request_steps* to analyze data movements behind queries, monitor the time broadcast and shuffle operations take. This is helpful to review your distribution strategy.

## Hash-distributed tables

A hash-distributed table can deliver the highest query performance for joins and aggregations on large tables.

To shard data into a hash-distributed table, Azure Synapse Analytics uses a hash function to assign each row to one distribution deterministically. In the table definition, one of the columns is designated as the distribution column. The hash function uses the values in the distribution column to assign each row to a distribution.

The following example shows a create table statement that defines a hash distribution.

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

A round-robin table is the most straightforward table to create and deliver fast performance when used as a staging table for loads.

A round-robin distributed table distributes data evenly across the nodes, but without any further optimization. A distribution is first chosen at random, and then buffers of rows are assigned to distributions sequentially. It is quick to load data into a round-robin table, but query performance can often be better with hash distributed tables. Joins on round-robin tables require reshuffling data, and this takes additional time.

The following example shows a create table statement that defines a round robin distribution.

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

A table that is replicated caches a full copy on each compute node. Consequently, replicating a table removes the need to transfer data among compute nodes before a join or aggregation. Extra storage is required, and there are additional overheads that are incurred when writing data which make large tables impractical.

The following example shows a create table statement that defines a replicate distribution.

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