Partitioning a table with 2 billion rows spanning 10 years transforms query performance, but only if you choose the right partition key and strategy. A partition key that doesn't align with query patterns means every query scans all partitions, making performance worse than an unpartitioned table. Partitioning on a frequently updated column causes constant partition movement and fragmentation. Non-aligned indexes prevent fast partition switching, eliminating the operational benefits that justify partitioning complexity. You cannot easily change partition strategies after implementation, and repartitioning a multi-terabyte table means rebuilding it entirely, often requiring application downtime measured in hours or days. The partitioning decisions you make during design, including which column to partition on, RANGE LEFT versus RIGHT boundaries, and aligned versus non-aligned indexes, determine whether partitioning improves your system or creates maintenance nightmares that cannot be easily undone.

[Table and index partitioning](https://learn.microsoft.com/sql/relational-databases/partitions/partitioned-tables-and-indexes?azure-portal=true) divides large tables into smaller, more manageable pieces (partitions) while keeping them as a single logical table. Your application sees one table, but the database engine manages multiple physical segments that can be independently maintained, archived, or queried.

For example, a financial services company had a 1.2TB transactions table where queries filtering by date (90% of queries) scanned the entire table. After implementing monthly partitioning, query performance improved 10-20x through partition elimination, index rebuilds went from 6 hours to 20 minutes per partition, archiving old data reduced from 4-hour locks to seconds using partition switching, and storage costs decreased 40% by moving older partitions to cheaper storage.

## Understand partitioning concepts

Partitioning involves several key components: a partition function that defines how data is divided, a partition scheme that maps partitions to filegroups, and the partitioning column that determines which partition each row belongs to. Understanding these concepts helps you design an effective partitioning strategy.

### Evaluate performance and operational benefits

Partitioning provides query performance improvements through partition elimination where queries filter by partition key access only relevant partitions (1 month instead of 120 months), parallel processing where multiple partitions are processed simultaneously across CPU cores, faster statistics calculated per partition instead of the entire table, and index seeks where smaller partitions mean shallower B-trees.

Operational benefits include granular maintenance where you rebuild indexes on the current partition while older partitions remain online, fast archival by switching old partitions to archive tables in seconds through metadata operations, improved availability from maintaining partitions independently, and tiered storage by moving older partitions to cheaper, slower storage.

### Understand when to use partitioning

Partitioning works best for specific scenarios:

- Large tables where you need to transfer or access subsets of data quickly
- Queries that frequently filter on the partitioning column (enabling partition elimination)
- Regular data archival requirements where you can switch partitions out
- Tables where you want to rebuild indexes on specific partitions without affecting others
- Scenarios requiring tiered storage where older partitions move to cheaper storage

### Avoid partitioning when unnecessary

Partitioning adds complexity that might not be justified:

- No clear partitioning column that aligns with query patterns
- Most queries don't filter on the partitioning column (all partitions get scanned)
- Single-row seeks or small range scans are common (partitioning adds overhead)
- The table already performs adequately without partitioning

### Create partitioning schemes

Partitioning distributes data across multiple filegroups or partitions:

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

## Partitioning strategies

**Choosing the right partitioning strategy:**

The partition key is your most critical decision. Choose poorly, and partitioning hurts more than helps. The ideal partition key appears in the WHERE clause of most queries, creates reasonably balanced partitions, and aligns with your maintenance patterns.

**Key selection criteria:**

- **Query patterns**: 80%+ of queries filter by this column
- **Data distribution**: Even distribution across partitions (no single partition with 90% of data)
- **Maintenance alignment**: Matches archival/purge patterns (date columns for time-based archival)
- **Stability**: Value doesn't change after INSERT (avoid partitioning on updateable columns)

### Use range partitioning

Range partitioning divides data based on value ranges—most commonly dates. Each partition contains a range of values (January data, February data, etc.). This is the most widely used partitioning strategy, especially for time-series data.

Range partitioning works best for time-series data like orders, logs, and transactions (90% of partitioning scenarios), sequential data like invoice numbers or order IDs that increase over time, numeric ranges such as salary bands or price tiers, and growing datasets where data is continuously added with newer values.

Common partition patterns include daily partitions for high-volume systems with millions of rows per day and short retention, weekly partitions for medium volume with 6-12 month retention, monthly partitions as the most common approach balancing partition count and size, quarterly partitions for lower volume with multi-year retention, and yearly partitions for archive scenarios with long-term historical data.

For example, an e-commerce platform partitions orders monthly where current month queries hit one partition for fast performance, quarterly reports access 3 partitions, and year-end analysis uses 12 partitions but still benefits from elimination of older years.

You can create range partitions by defining boundaries in the partition function. Here's an example:

```sql
-- Partition sales data by quarter using RANGE RIGHT
CREATE PARTITION FUNCTION PF_SalesDate (DATE)
    AS RANGE RIGHT FOR VALUES 
    ('2024-01-01', '2024-04-01', '2024-07-01', '2024-10-01');

CREATE PARTITION SCHEME PS_SalesDate
    AS PARTITION PF_SalesDate ALL TO ([PRIMARY]);

CREATE TABLE SalesData (
    SalesID INT NOT NULL,
    SaleDate DATE NOT NULL,
    Region NVARCHAR(50),
    Revenue DECIMAL(12,2),
    CONSTRAINT PK_SalesData PRIMARY KEY (SalesID, SaleDate)
) ON PS_SalesDate(SaleDate);
```

### Partition by categorical values

You can use RANGE partitioning with string or categorical values like regions. The partition function places values based on sort order. This approach works for geographic distribution, multi-tenant systems, or departmental data where queries frequently filter by category.

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

When you partition a table, indexes can be aligned (partitioned the same way) or non-aligned (different partitioning or not partitioned). When creating a nonclustered index on a partitioned table without specifying a partition scheme, the index is placed in the same partition scheme as the underlying table by default. This choice impacts query performance, maintenance operations, and partition switching capabilities.

### Understand aligned versus non-aligned indexes

Aligned indexes are partitioned using the same partition function as the base table where each index partition corresponds to a table partition. This enables fast partition switching measured in seconds versus hours, simplifies maintenance by rebuilding one partition's table and indexes together, and improves partition elimination in queries.

Non-aligned indexes are partitioned differently or not partitioned. Creating and rebuilding non-aligned indexes on tables with more than 1,000 partitions isn't supported and might cause degraded performance or excessive memory consumption. Non-aligned indexes also cannot use fast partition switching.

Use aligned index partitioning when the index and table share the same partition key, you need partition switching for archival, you want to rebuild indexes partition-by-partition, or query patterns align with the partition key.

For example, a logistics company has Orders partitioned by OrderDate and creates a non-clustered index on CustomerID. By partitioning this index using the same OrderDate scheme (aligned), they can archive old months by switching partitions in seconds, rebuild current month's indexes during business hours, and drop old partitions without locking the entire table.

You can create partitioned indexes using the same partition scheme as the base table. Here's an example:

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

After creating partitioned tables, you need to manage them over time. Common operations include querying partition metadata, adding new partitions as data grows, and removing old partitions during archival. These operations use the `$PARTITION` function and `ALTER PARTITION FUNCTION` statement.

### Query partition information

You can view partition information by using the $PARTITION function. Here's an example:

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

### Archive and remove partition

You can merge partitions to archive old data by using `ALTER PARTITION FUNCTION` with `MERGE RANGE`. Here's an example:

```sql
-- Merge partitions to archive old data
ALTER PARTITION FUNCTION PF_OrderDate()
    MERGE RANGE ('2023-12-31');
```

## Apply partitioning best practices

Following best practices helps you avoid common partitioning mistakes that are difficult to correct after implementation. These guidelines cover partition key selection, index alignment, and monitoring.

### 1. Choose appropriate partition key

You can choose date columns for time-series data partitioning. Here's an example:

```sql
-- Good: Date partition for time-series data using RANGE RIGHT
CREATE PARTITION FUNCTION PF_ByMonth (DATE)
    AS RANGE RIGHT FOR VALUES 
    ('2024-02-01', '2024-03-01', '2024-04-01');
```

### 2. Align table and index partitions

You can ensure both table and indexes use the same partition scheme for optimal performance. Here's an example:

```sql
-- Both table and index use same partition scheme
CREATE TABLE Events (
    EventID INT NOT NULL,
    EventDate DATE NOT NULL,
    EventType NVARCHAR(50),
    CONSTRAINT PK_Events PRIMARY KEY (EventID, EventDate)
) ON PS_EventDate(EventDate);

CREATE NONCLUSTERED INDEX IX_Events_Type
    ON Events(EventType)
    ON PS_EventDate(EventDate);
```

### 3. Monitor partition performance

You can check partition statistics to monitor data distribution. Here's an example:

```sql
-- Check partition row distribution
SELECT 
    $PARTITION.PF_OrderDate(OrderDate) AS PartitionNumber,
    MIN(OrderDate) AS MinDate,
    MAX(OrderDate) AS MaxDate,
    COUNT(*) AS RowsInPartition
FROM Orders
GROUP BY $PARTITION.PF_OrderDate(OrderDate)
ORDER BY PartitionNumber;
```

## Evaluate when to use partitioning

Partitioning solves specific performance and operational problems, but it adds complexity that becomes permanent once implemented. Use partitioning when you need to transfer or access subsets of data quickly, queries often filter on the partition key, regular archival or purging is needed, you want to improve concurrency by enabling lock escalation at the partition level (using the `LOCK_ESCALATION` option), or maintenance operations target specific partitions. Avoid partitioning when no clear partitioning column exists, queries span many partitions, or single-row seeks and small range scans are common (partitioning adds overhead for these patterns).

The partition key you choose determines whether partitioning improves or degrades performance. A poorly chosen key means queries hit all partitions, making performance worse than unpartitioned tables. Partition boundaries aligned with query patterns enable partition elimination. Non-aligned indexes prevent fast partition switching. These decisions cannot be easily changed—repartitioning a multi-terabyte table requires rebuilding it entirely. Design your partitioning strategy during initial schema design based on proven query patterns and operational requirements, not as a reactive fix to performance problems. Partitioning implemented correctly transforms large table management; implemented poorly, it creates operational complexity without performance benefits.
