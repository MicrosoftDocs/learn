Indexes are data structures that accelerate data retrieval by creating optimized lookup paths to table rows. Without indexes, the database engine must scan every row in a table to find matching records, a full table scan that becomes prohibitively slow as tables grow.

An index works like a book's index: instead of reading every page to find an article, you consult the index to jump directly to relevant pages. The database uses indexes similarly, converting potentially millions of row comparisons into a handful of efficient lookups.

However, indexes consume storage space and slow down `INSERT`, `UPDATE`, and `DELETE` operations because the database must maintain the index structure alongside the data. This trade-off makes index selection a critical design decision that directly impacts both query performance and write throughput.

Different index types serve different purposes.

## Use rowstore indexes

Designing efficient indexes is key to achieving good database and application performance. A lack of indexes, over-indexing, or poorly designed indexes are top sources of database performance problems.

Rowstore indexes organize data in row format, storing all columns of a row together on the same page, which makes them optimal for transactional workloads that retrieve complete records or perform frequent updates.

[*A clustered index*](/sql/relational-databases/indexes/clustered-and-nonclustered-indexes-described?azure-portal=true#clustered) sorts and stores the data rows in the table based on their key values. These key values are the columns included in the index definition. There can be only one clustered index per table, because the data rows themselves can be stored in only one order.

[*A nonclustered index*](/sql/relational-databases/indexes/clustered-and-nonclustered-indexes-described?azure-portal=true#nonclustered) has a structure separate from the data rows. A nonclustered index contains the nonclustered index key values and each key value entry has a pointer to the data row that contains the key value. You can create multiple nonclustered indexes on a table or indexed view.

```sql
-- Create clustered index on primary key (defines physical row order)
CREATE CLUSTERED INDEX IX_Product_ProductID 
ON Product(ProductID);

-- Create non-clustered index on frequently searched column
CREATE NONCLUSTERED INDEX IX_Product_Category 
ON Product(Category) 
INCLUDE (ProductName, Price);
```

Clustered indexes are best when you need efficient range queries, stable and narrow keys, or a natural sort order such as identity columns or date fields because they define the physical row order and optimize scans over ordered data.

Nonclustered indexes are ideal when you need fast lookups for specific predicates, joins, or sorting patterns that don't align with the clustered key, or when you want to cover a query by including extra columns to avoid key lookups.

Choosing between them depends on how you access the data: use a clustered index for the primary access path and nonclustered indexes to support alternate, highly selective, or frequently queried patterns while balancing the cost they introduce on write operations.

## Understand columnstore indexes

Traditional rowstore indexes store data row-by-row, which is perfect for transactional systems that retrieve individual records. But analytical queries that scan millions of rows to calculate aggregates (`SUM`, `AVG`, `COUNT`) waste time reading columns they don't need. Columnstore indexes aim to solve this by storing data column-by-column, reading only the columns required for your query.

### Understand columnstore architecture

A columnstore index organizes data into **rowgroups**, each containing up to 1,048,576 rows. Within each rowgroup, the engine stores each column separately as a **column segment** and compresses it independently. This architecture enables the query optimizer to read only the columns needed for a query, skipping irrelevant data entirely.

When you insert data, small batches first go to a **deltastore**—a temporary rowstore structure using a B+ tree index. Once a delta rowgroup accumulates enough rows (at least 102,400), a background process called the **tuple-mover** compresses it into the columnstore. Rows that arrive through bulk loads of 102,400 or more rows bypass the deltastore and compress directly into the columnstore.

The following table describes the recommendation for columnstore indexes:

| Scenario | Recommendation | Reason |
| -------- | -------------- | ------ |
| **Data warehouse fact tables** | Use columnstore | Tables with millions+ rows used for analytics benefit from columnar storage and compression |
| **Reporting databases** | Use columnstore | Read-heavy workloads with aggregate queries perform faster with column-oriented access |
| **Historical data** | Use columnstore | Archived data that you rarely update but frequently analyze achieves high compression ratios |
| **Small tables (<1 million rows)** | Avoid columnstore | Overhead outweighs benefits; rowgroups need sufficient rows for effective compression |
| **High-frequency updates/deletes** | Avoid columnstore | Modifications mark rows as deleted rather than updating in place, causing fragmentation |
| **Single-row lookups** | Avoid columnstore | Rowstore indexes are faster for retrieving individual records |

### Use Clustered Columnstore Index (CCI)

A Clustered Columnstore Index (CCI) is a type of columnstore index that becomes the primary storage structure for the entire table, replacing any existing clustered rowstore index. Unlike a nonclustered columnstore index (NCCI), which creates a secondary columnar copy alongside the rowstore table, a CCI stores all table data exclusively in columnar format.

This means the table has no traditional row-based storage—the engine compresses and stores every column separately. Both CCI and NCCI use the same columnar compression and batch processing optimizations, but use a CCI when analytics is the primary workload and you don't need row-level transactional access patterns. In contrast, an NCCI allows you to maintain rowstore indexes for transactional queries while providing a columnar structure for analytical queries on the same table.

You can create a clustered columnstore index by using the `CREATE CLUSTERED COLUMNSTORE INDEX` statement. Here's an example:

```sql
-- Create clustered columnstore index (replaces clustered rowstore)
CREATE CLUSTERED COLUMNSTORE INDEX CCI_SalesHistory
ON SalesHistory;

-- Rebuild to improve compression
ALTER INDEX CCI_SalesHistory ON SalesHistory REBUILD;
```

### Use Nonclustered Columnstore Index (NCCI)

A Nonclustered Columnstore Index (NCCI) creates a separate columnar copy of selected columns alongside the existing rowstore table, allowing the same table to serve both transactional and analytical workloads efficiently. The table maintains its original clustered rowstore index for fast single-row lookups and updates, while the NCCI provides optimized column-based access for analytical queries. The query optimizer automatically chooses between the rowstore and columnstore structures based on the query pattern.

You can create a nonclustered columnstore index by using the `CREATE NONCLUSTERED COLUMNSTORE INDEX` statement. Here's an example:

```sql
-- Create non-clustered columnstore for analytics
CREATE NONCLUSTERED COLUMNSTORE INDEX NCCI_Product_Analytics
ON Product(Price, StockQuantity, Category, ProductName);
```

### Monitor columnstore indexes

You can monitor the health and performance of your columnstore indexes by querying the [`sys.dm_db_column_store_row_group_physical_stats`](/sql/relational-databases/system-dynamic-management-views/sys-dm-db-column-store-row-group-physical-stats-transact-sql?azure-portal=true) dynamic management view.

The following query shows rowgroup statistics including state, row counts, deleted rows, and storage size. Open rowgroups are still accepting inserts in the deltastore, closed rowgroups are waiting for the tuple-mover to compress them, and compressed rowgroups store data in columnar format. High deleted row counts or many small rowgroups indicate fragmentation that you can resolve with `ALTER INDEX REORGANIZE`.

```sql
-- Check columnstore health
SELECT 
    object_name(object_id) AS TableName,
    state_desc,
    total_rows,
    deleted_rows,
    size_in_bytes / 1024 / 1024 AS SizeMB
FROM sys.dm_db_column_store_row_group_physical_stats
WHERE object_id = OBJECT_ID('SalesHistory');
```

Index selection directly impacts both query performance and writes throughput. Design indexes carefully during initial development to avoid costly rebuilds and performance issues in production.
