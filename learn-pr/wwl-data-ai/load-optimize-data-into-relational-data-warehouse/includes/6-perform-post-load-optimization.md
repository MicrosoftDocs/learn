

## Post-load optimization

After loading new data into the data warehouse, it's a good idea to rebuild the table columnstore indexes and update statistics on commonly queried columns.

The following example rebuilds all indexes on the **DimProduct** table.

```sql
ALTER INDEX ALL ON dbo.DimProduct REBUILD
```

The following example creates statistics on the **ProductCategory** column of the **DimProduct** table:

```sql
CREATE STATISTICS productcategory_stats
ON dbo.DimProduct (ProductCategory);
```

> [!NOTE]
> For more information, see the [Indexes on dedicated SQL pool tables in Azure Synapse Analytics](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-index) and [Table statistics for dedicated SQL pool in Azure Synapse Analytics](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-statistics) articles in the Azure Synapse Analytics documentation.

## Maintain a well-engineered data lake structure

Maintaining a well-engineered Data Lake structure allows you to know that the data you're loading regularly is consistent with the data requirements for your system. It's less important if your load is a once-off or exploratory rather than analytical. Some strategies include folder hierarchies based on the source system, and date/time or file format and focus.

In general, having well defined “zones” established for the data coming into the Data Lake and cleansing and transformation tasks that land the data you need in a curated and optimized state.

## Compress and optimize files

When loading large datasets, it’s best to use the compression capabilities of the file format. It ensures that less time is spent on the process of data transfers, using instead the power of Azure Synapse’ Massively Parallel Processing (MPP) compute capabilities for decompression

It's fairly standard to maintain curated source files in columnar compressed file formats such as RC, Gzip, Parquet, and ORC, which are all supported import formats.

## Split source files

One of the key architectural components within Azure Synapse Analytics dedicated SQL pools is the decoupled storage that is segmented into 60 parts. You should maintain alignment to multiples of this number as much as possible depending on the file sizes that you're loading, and the number of compute nodes you've provisioned. Since there are 60 storage segments and a maximum of 60 MPP compute nodes within the highest performance configuration of SQL Pools, a 1:1 file to compute node to storage segment may be viable for ultra-high workloads, reducing the load times to the minimum possible. 

A data warehouse that is built on a Massively Parallel Processing (MPP) system are built for processing and analyzing large datasets. As such they perform well with larger batch type loads and updates that can be distributed across the compute nodes and storage.

**Singleton** or smaller transaction batch loads should be grouped into larger batches to optimize the Synapse SQL Pools processing capabilities. To be clear, a one-off load to a small table with an INSERT statement may be the best approach, if it's a one-off. 

However, if you need to load thousands or millions of rows throughout the day, then singleton INSERTS aren't optimal against an MPP system. One way to solve this issue is to develop one process that writes the outputs of an INSERT statement to a file, and then another process to periodically load this file to take advantage of the parallelism that Azure Synapse Analytics. 

Selecting the correct table distribution can have an impact on the data load and query performance as follows:
