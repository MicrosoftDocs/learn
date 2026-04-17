Partitioning decisions are nearly permanent. A poorly chosen partition key makes performance worse than an unpartitioned table, and repartitioning a multi-terabyte table requires rebuilding it entirely with hours of downtime. The partition key and index alignment you choose during design determine whether partitioning improves your system or creates maintenance nightmares you can't easily undo.

[Table partitioning](/sql/relational-databases/partitions/partitioned-tables-and-indexes?azure-portal=true) divides large tables into smaller, more manageable pieces (partitions) while keeping them as a single logical table. Your application sees one table, but the database engine manages multiple physical segments that can be independently maintained, archived, or queried.

## Understand partitioning concepts

Partitioning involves several key components: a *partition function* that defines how data is divided, a *partition scheme* that maps partitions to filegroups, and the *partitioning column* that determines which partition each row belongs to. Understanding these concepts helps you design an effective partitioning strategy.

### Evaluate performance and operational benefits

Partitioning provides query performance improvements through partition elimination where queries filter by partition key access only relevant partitions (one month instead of 120 months), parallel processing where multiple partitions are processed simultaneously across CPU cores, faster statistics calculated per partition instead of the entire table, and index seeks where smaller partitions mean shallower B-trees.

Operational benefits include granular maintenance where you rebuild indexes on the current partition while older partitions remain online, fast archival by switching old partitions to archive tables in seconds through metadata operations, improved availability from maintaining partitions independently, and tiered storage by moving older partitions to cheaper, slower storage.

For example, imagine a financial services company with a 1.2-TB transactions table where queries filtering by date (90% of queries) scan the entire table. After implementing monthly partitioning, query performance improves 10-20x through partition elimination, index rebuilds go from 6 hours to 20 minutes per partition, archiving old data reduces from four-hour locks to seconds using partition switching, and storage costs decrease 40% by moving older partitions to cheaper storage.

### Understand when to use partitioning

The following table shows when partitioning helps versus when it adds unnecessary complexity:

| Scenario | Use partitioning? | Why |
| -------- | ----------------- | --- |
| Queries filter on a specific column (date, region) 80%+ of the time | Yes | Partition elimination accesses only relevant partitions |
| Regular archival of old data (monthly, quarterly) | Yes | Switch partitions out in seconds instead of `DELETE` operations |
| Need to rebuild indexes on recent data only | Yes | Rebuild current partition while older partitions stay online |
| Large tables (multi-TB) with tiered storage needs | Yes | Move older partitions to cheaper storage |
| Most queries scan the full table or filter on various columns | No | All partitions scanned—worse performance than unpartitioned |
| Single-row lookups or small range scans are common | No | Partitioning adds overhead without benefits |
| No clear column aligns with query patterns | No | Can't choose an effective partition key |

### Create partitioning components

The following example shows the three components: partition function, partition scheme, and partitioned table:

```sql
-- Create partition function based on date ranges
-- Use RANGE RIGHT for datetime columns to keep same-day values together
CREATE PARTITION FUNCTION PF_OrderDate (DATETIME2)
    AS RANGE RIGHT FOR VALUES 
    ('2024-01-01', '2024-04-01', '2024-07-01', '2024-10-01');

-- Create partition scheme mapping to a single filegroup (recommended)
-- Use multiple filegroups only for tiered storage or independent backups
CREATE PARTITION SCHEME PS_OrderDate
    AS PARTITION PF_OrderDate ALL TO ([PRIMARY]);

-- Create partitioned table
-- Include partition column in primary key for clustered index alignment
CREATE TABLE Orders (
    OrderID INT NOT NULL,
    OrderDate DATETIME2 NOT NULL,
    CustomerID INT,
    Amount DECIMAL(10,2),
    CONSTRAINT PK_Orders PRIMARY KEY (OrderID, OrderDate)
) ON PS_OrderDate(OrderDate);
```

This example creates quarterly partitions for an *Orders* table. The partition function defines four boundary values (January, April, July, October) creating five partitions: one for data before 2024, and four for each quarter of 2024. The partition scheme maps all partitions to the PRIMARY filegroup. The *Orders* table uses the *OrderDate* column as the partition key, which must be included in the primary key for proper index alignment.

## Choose partitioning strategies

The partition key is your most important decision. Choose poorly, and partitioning hurts more than helps. The ideal partition key appears in the `WHERE` clause of most queries, creates reasonably balanced partitions, and aligns with your maintenance patterns.

The following key selection criteria help you choose the right partition key:

- **Query patterns**: 80%+ of queries filter by this column
- **Data distribution**: Even distribution across partitions (no single partition with 90% of data)
- **Maintenance alignment**: Matches archival/purge patterns (date columns for time-based archival)
- **Stability**: Value doesn't change after INSERT (avoid partitioning on updateable columns)

### Understand range partitioning

Range partitioning divides data based on value ranges—most commonly dates. Each partition contains a specific range (January data, February data, etc.). This is the most widely used strategy.

Here's where range partitioning works best:

- Time-series data (orders, logs, transactions)
- Sequential data (invoice numbers, order IDs)
- Numeric ranges (salary bands, price tiers)

The following table shows common partition patterns:

| Pattern | When to Use |
| ------- | ----------- |
| Daily | High-volume systems, short retention |
| Weekly | Medium volume, 6-12 month retention |
| Monthly | Most common, balances partition count and size |
| Quarterly | Lower volume, multi-year retention |
| Yearly | Archive scenarios, long-term historical data |

For example, an e-commerce platform partitioning orders monthly enables current month queries to hit one partition, quarterly reports to access 3 partitions, and year-end analysis to use 12 partitions while eliminating older years.

You can create range partitions by defining boundaries in the partition function:

```sql
-- RANGE RIGHT creates 5 partitions: <100000, 100000-199999, 200000-299999, 300000-399999, >=400000
CREATE PARTITION FUNCTION PF_InvoiceNumber (INT)
    AS RANGE RIGHT FOR VALUES 
    (100000, 200000, 300000, 400000);
```

### Partition by categorical values

You can use `RANGE` partitioning with string or categorical values like regions. The partition function places values based on sort order. This approach works for geographic distribution, multitenant systems, or departmental data where queries frequently filter by category.

The following example partitions data by region:

```sql
-- Partition by region
CREATE PARTITION FUNCTION PF_Region (NVARCHAR(50))
    AS RANGE LEFT FOR VALUES ('East', 'North', 'South', 'West');

CREATE PARTITION SCHEME PS_Region
    AS PARTITION PF_Region ALL TO ([PRIMARY]);

CREATE TABLE RegionalData (
    DataID INT NOT NULL,
    Region NVARCHAR(50) NOT NULL,
    Value DECIMAL(10,2),
    CONSTRAINT PK_RegionalData PRIMARY KEY (DataID, Region)
) ON PS_Region(Region);
```

## Implement index partitioning

When you partition a table, indexes can be aligned or nonaligned. Aligned indexes use the same partition scheme as the table, while nonaligned indexes use different partitioning or no partitioning. By default, nonclustered indexes on partitioned tables inherit the table's partition scheme.

### Understand aligned versus nonaligned indexes

**Aligned indexes** use the same partition function as the table. Each index partition matches a table partition, enabling fast partition switching, simplified maintenance, and better partition elimination.

**Nonaligned indexes** use different partitioning or no partitioning. They can't use partition switching and aren't supported on tables with more than 1,000 partitions.

Use aligned indexes when you need partition switching for archival, want to rebuild specific partitions independently, or when query patterns filter on the partition key.

For example, imagine an *Orders* table partitioned by *OrderDate* with a nonclustered index on *CustomerID*. Using aligned partitioning with the same *OrderDate* scheme allows archiving old months by switching partitions, rebuilding current indexes independently, and dropping old partitions without affecting the entire table.

You can create partitioned indexes using the same partition scheme as the base table:

```sql
-- Create partitioned non-clustered index
CREATE NONCLUSTERED INDEX IX_Orders_Customer
    ON Orders(CustomerID)
    ON PS_OrderDate(OrderDate);

-- Create partitioned columnstore index
CREATE NONCLUSTERED COLUMNSTORE INDEX IX_SalesData_CS
    ON SalesData(Revenue, Region)
    ON PS_SalesDate(SaleDate);
```

## Manage partition operations

After creating partitioned tables, you need to manage them over time. Common operations include querying partition metadata, adding new partitions as data grows, and removing old partitions during archival. These operations use the [`$PARTITION`](/sql/t-sql/functions/partition-transact-sql?azure-portal=true) function and [`ALTER PARTITION FUNCTION`](/sql/t-sql/statements/alter-partition-function-transact-sql?azure-portal=true) statement.

### Query partition information

You can view partition information by using the `$PARTITION` function. Here's an example:

```sql
-- View partition information
SELECT 
    $PARTITION.PF_OrderDate(OrderDate) AS PartitionNumber,
    MIN(OrderDate) AS MinDate,
    MAX(OrderDate) AS MaxDate,
    COUNT(*) AS RowCount
FROM Orders
GROUP BY $PARTITION.PF_OrderDate(OrderDate)
ORDER BY PartitionNumber;
```

### Add new partition boundary

You can split partitions to add new boundary values by using `ALTER PARTITION FUNCTION`. Here's an example:

```sql
-- Split partition to add new boundary
ALTER PARTITION FUNCTION PF_OrderDate()
    SPLIT RANGE ('2024-11-01');
```

This statement adds a new boundary value (November 1, 2024) to the partition function, splitting an existing partition into two partitions. The partition containing dates from October through December now becomes two partitions: one for October and another for November through December.

### Archive and remove partition

You can merge partitions to archive old data by using `ALTER PARTITION FUNCTION` with `MERGE RANGE`. Here's an example:

```sql
-- Merge partitions to archive old data
ALTER PARTITION FUNCTION PF_OrderDate()
    MERGE RANGE ('2023-12-31');
```

## Apply partitioning best practices

Following best practices helps you avoid common partitioning mistakes that are difficult to correct after implementation:

- **Align indexes with table partitions**: Use the same partition scheme for tables and indexes to enable partition switching and maintenance
- **Monitor data distribution**: Check partition statistics regularly to identify imbalanced partitions and verify partition elimination
- **Automate partition management**: Schedule jobs to add new partitions before reaching boundaries and archive old partitions
- **Avoid over-partitioning**: Target millions of rows per partition, not thousands—too many partitions create overhead
- **Include partition key in primary key**: Required for clustered index alignment on the partition scheme

Partitioning requires careful planning. The partition key and index alignment you choose determine whether you gain performance or create complexity. When implemented correctly, partitioning transforms large table management through faster queries, efficient archival, and simplified maintenance.
