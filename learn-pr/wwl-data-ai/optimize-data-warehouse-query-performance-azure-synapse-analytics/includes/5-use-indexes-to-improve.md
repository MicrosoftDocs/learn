When a table is created, by default the data structure has no indexes and is called a heap. A well-designed indexing strategy can reduce disk I/O operations and consume less system resources therefore improving query performance, especially when using filtering, scans, and joins in a query.

Dedicated SQL Pools have the following indexing options available:

## Clustered columnstore index (CCI)

Dedicated SQL Pools create a clustered columnstore index when no index options are specified on a table and allows for the use of adaptive caching. Clustered columnstore indexes offer both the highest level of data compression and the best overall query performance. Clustered columnstore indexes will generally outperform clustered rowstore indexes or heap tables and are usually the best choice for large tables.

Columnstore works on segments of 1,048,576 rows that get compressed and optimized by column. This segmentation further helps to filter out and reduce the data accessed through using metadata stored which summarizes the range and values within each segment during query optimization.

As CCIs organize data into segments, we want as much saturation of data within the segment as possible which as can be seen above is measured by the number of rows in a compressed row group. to optimize segment quality, target at least 100K rows per compressed row group and performance will continue to see gains until it reaches its current maximum size.

Using a view like the one listed below can help identify the average rows per row group and identify any suboptimal CCIs. The last column in this provided DDL can be used to rebuild those suboptimal indexes.

```SQL
CREATE VIEW dbo.vColumnstoreDensity
AS
SELECT
        GETDATE()                                                               AS [execution_date]
,       DB_Name()                                                               AS [database_name]
,       s.name                                                                  AS [schema_name]
,       t.name                                                                  AS [table_name]
,    COUNT(DISTINCT rg.[partition_number])                    AS [table_partition_count]
,       SUM(rg.[total_rows])                                                    AS [row_count_total]
,       SUM(rg.[total_rows])/COUNT(DISTINCT rg.[distribution_id])               AS [row_count_per_distribution_MAX]
,    CEILING    ((SUM(rg.[total_rows])*1.0/COUNT(DISTINCT rg.[distribution_id]))/1048576) AS [rowgroup_per_distribution_MAX]
,       SUM(CASE WHEN rg.[State] = 0 THEN 1                   ELSE 0    END)    AS [INVISIBLE_rowgroup_count]
,       SUM(CASE WHEN rg.[State] = 0 THEN rg.[total_rows]     ELSE 0    END)    AS [INVISIBLE_rowgroup_rows]
,       MIN(CASE WHEN rg.[State] = 0 THEN rg.[total_rows]     ELSE NULL END)    AS [INVISIBLE_rowgroup_rows_MIN]
,       MAX(CASE WHEN rg.[State] = 0 THEN rg.[total_rows]     ELSE NULL END)    AS [INVISIBLE_rowgroup_rows_MAX]
,       AVG(CASE WHEN rg.[State] = 0 THEN rg.[total_rows]     ELSE NULL END)    AS [INVISIBLE_rowgroup_rows_AVG]
,       SUM(CASE WHEN rg.[State] = 1 THEN 1                   ELSE 0    END)    AS [OPEN_rowgroup_count]
,       SUM(CASE WHEN rg.[State] = 1 THEN rg.[total_rows]     ELSE 0    END)    AS [OPEN_rowgroup_rows]
,       MIN(CASE WHEN rg.[State] = 1 THEN rg.[total_rows]     ELSE NULL END)    AS [OPEN_rowgroup_rows_MIN]
,       MAX(CASE WHEN rg.[State] = 1 THEN rg.[total_rows]     ELSE NULL END)    AS [OPEN_rowgroup_rows_MAX]
,       AVG(CASE WHEN rg.[State] = 1 THEN rg.[total_rows]     ELSE NULL END)    AS [OPEN_rowgroup_rows_AVG]
,       SUM(CASE WHEN rg.[State] = 2 THEN 1                   ELSE 0    END)    AS [CLOSED_rowgroup_count]
,       SUM(CASE WHEN rg.[State] = 2 THEN rg.[total_rows]     ELSE 0    END)    AS [CLOSED_rowgroup_rows]
,       MIN(CASE WHEN rg.[State] = 2 THEN rg.[total_rows]     ELSE NULL END)    AS [CLOSED_rowgroup_rows_MIN]
,       MAX(CASE WHEN rg.[State] = 2 THEN rg.[total_rows]     ELSE NULL END)    AS [CLOSED_rowgroup_rows_MAX]
,       AVG(CASE WHEN rg.[State] = 2 THEN rg.[total_rows]     ELSE NULL END)    AS [CLOSED_rowgroup_rows_AVG]
,       SUM(CASE WHEN rg.[State] = 3 THEN 1                   ELSE 0    END)    AS [COMPRESSED_rowgroup_count]
,       SUM(CASE WHEN rg.[State] = 3 THEN rg.[total_rows]     ELSE 0    END)    AS [COMPRESSED_rowgroup_rows]
,       SUM(CASE WHEN rg.[State] = 3 THEN rg.[deleted_rows]   ELSE 0    END)    AS [COMPRESSED_rowgroup_rows_DELETED]
,       MIN(CASE WHEN rg.[State] = 3 THEN rg.[total_rows]     ELSE NULL END)    AS [COMPRESSED_rowgroup_rows_MIN]
,       MAX(CASE WHEN rg.[State] = 3 THEN rg.[total_rows]     ELSE NULL END)    AS [COMPRESSED_rowgroup_rows_MAX]
,       AVG(CASE WHEN rg.[State] = 3 THEN rg.[total_rows]     ELSE NULL END)    AS [COMPRESSED_rowgroup_rows_AVG]
,       'ALTER INDEX ALL ON ' + s.name + '.' + t.NAME + ' REBUILD;'             AS [Rebuild_Index_SQL]
FROM    sys.[pdw_nodes_column_store_row_groups] rg
JOIN    sys.[pdw_nodes_tables] nt                   ON  rg.[object_id]          = nt.[object_id]
                                                    AND rg.[pdw_node_id]        = nt.[pdw_node_id]
                                                    AND rg.[distribution_id]    = nt.[distribution_id]
JOIN    sys.[pdw_table_mappings] mp                 ON  nt.[name]               = mp.[physical_name]
JOIN    sys.[tables] t                              ON  mp.[object_id]          = t.[object_id]
JOIN    sys.[schemas] s                             ON t.[schema_id]            = s.[schema_id]
GROUP BY
        s.[name]
,       t.[name];


```
Once the view is created, run the following query to identify tables with row groups with less than 100K rows. Once these are resolved, increase the threshold to look for additional opportunities for optimal segment quality.

```SQL
SELECT    *
FROM    [dbo].[vColumnstoreDensity]
WHERE    COMPRESSED_rowgroup_rows_AVG < 100000
        OR INVISIBLE_rowgroup_rows_AVG < 100000;
```
How to your results and what to look for in the resulting row groups analysis.

| Column | How to use the results |
| ----------- | ----------- |
| [table_partition_count] | If the table is partitioned, then you may expect to see higher Open row group counts. Each partition in the distribution could in theory have an open row group associated with it. Factor this into your analysis. A small table that has been partitioned could be optimized by removing the partitioning altogether as this would improve compression. |
| [row_count_total] | Total row count for the table. For example, you can use this value to calculate percentage of rows in the compressed state. |
| [row_count_per_distribution_MAX] | If all rows are evenly distributed this value would be the target number of rows per distribution. Compare this value with the compressed_rowgroup_count. |
| [COMPRESSED_rowgroup_rows] | Total number of rows in columnstore format for the table. |
| [COMPRESSED_rowgroup_rows_AVG] | If the average number of rows is significantly less than the maximum # of rows for a row group, then consider using CTAS or ALTER INDEX REBUILD to recompress the data |
| [COMPRESSED_rowgroup_count] | Number of row groups in columnstore format. If this number is very high in relation to the table, it's an indicator that the columnstore density is low. |
| [COMPRESSED_rowgroup_rows_DELETED] | Rows are logically deleted in columnstore format. If the number is high relative to table size, consider recreating the partition or rebuilding the index as this removes them physically. |
| [COMPRESSED_rowgroup_rows_MIN] | Use this with the AVG and MAX columns to understand the range of values for the row groups in your columnstore. A low number over the load threshold (102,400 per partition aligned distribution) suggests that optimizations are available in the data load |
| [COMPRESSED_rowgroup_rows_MAX] | Same as above |
| [OPEN_rowgroup_count] | Open row groups are normal. One would reasonably expect one OPEN row group per table distribution (60). Excessive numbers suggest data loading across partitions. Double check the partitioning strategy to make sure it's sound |
| [OPEN_rowgroup_rows] | Each row group can have 1,048,576 rows in it as a maximum. Use this value to see how full the open row groups are currently |
| [OPEN_rowgroup_rows_MIN] | Open groups indicate that data is either being trickle loaded into the table or that the previous load spilled over remaining rows into this row group. Use the MIN, MAX, AVG columns to see how much data is sat in OPEN row groups. For small tables, it could be 100% of all the data! In which case ALTER INDEX REBUILD to force the data to columnstore. |
| [OPEN_rowgroup_rows_MAX] | See above |
| [OPEN_rowgroup_rows_AVG] | See above |
| [CLOSED_rowgroup_rows] | Look at the closed row group rows as a sanity check. |
| [CLOSED_rowgroup_count] | The number of closed row groups should be low if any are seen at all. Closed row groups can be converted to compressed row groups using the ALTER INDEX ... REORGANIZE command. However, this isn't normally required. Closed groups are automatically converted to columnstore row groups by the background "tuple mover" process. |
| [CLOSED_rowgroup_rows_MIN] | Closed row groups should have a very high fill rate. If the fill rate for a closed row group is low, then further analysis of the columnstore is required. |
| [CLOSED_rowgroup_rows_MAX] | See above |
| [CLOSED_rowgroup_rows_AVG] | See above |
| [Rebuild_Index_SQL] | SQL to rebuild columnstore index for a table |


### Considerations for when clustered columnstore indexes may not be a good option 

1. Columnstore tables don't support varchar(max), nvarchar(max), and varbinary(max). Consider heap or clustered index instead.
2. Columnstore tables may be less efficient for transient data. Consider heap and perhaps even temporary tables.
3. Small tables with less than 60 million rows. Consider heap tables.

## Clustered index

Clustered Rowstore Indexes define how the table itself is stored, ordered by the columns used for the Index. There can be only one clustered index on a table.

Clustered indexes are best for queries and joins that require ranges of data to be scanned, preferably in the same order that the index is defined.

## Non-clustered index

A non-clustered index can be defined on a table or view with a clustered index or on a heap. Each index row in the non-clustered index contains the non-clustered key value and a row locator. This is a data structure separate/additional to the table or heap. You can create multiple non-clustered indexes on a table.

Non clustered indexes are best used when used for the columns in a join, group by statement or where clauses that return an exact match or few rows.

## Indexes best practices ##

