After loading new data into the data warehouse, it's a good idea to rebuild the table indexes and update statistics on commonly queried columns.

## Rebuild indexes

The following example rebuilds all indexes on the **DimProduct** table.

```sql
ALTER INDEX ALL ON dbo.DimProduct REBUILD
```

> [!TIP]
> For more information about rebuilding indexes, see the [Indexes on dedicated SQL pool tables in Azure Synapse Analytics](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-index?azure-portal=true) article in the Azure Synapse Analytics documentation.

## Update statistics

The following example creates statistics on the **ProductCategory** column of the **DimProduct** table:

```sql
CREATE STATISTICS productcategory_stats
ON dbo.DimProduct(ProductCategory);
```

> [!TIP]
> For more information about updating statistics, see the [Table statistics for dedicated SQL pool in Azure Synapse Analytics](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-statistics?azure-portal=true) article in the Azure Synapse Analytics documentation.
