

After loading new data into the data warehouse, it's a good idea to rebuild the table clustered columnstore indexes and update statistics on commonly queried columns.

### Rebuild indexes

The following example rebuilds all indexes on the **DimProduct** table.

```sql

ALTER INDEX ALL ON dbo.DimProduct REBUILD

```

### Update statistics

The following example creates statistics on the **ProductCategory** column of the **DimProduct** table:

```sql

CREATE STATISTICS productcategory_stats
ON dbo.DimProduct(ProductCategory);

```

> [!TIP]
> For more information, see the [Indexes on dedicated SQL pool tables in Azure Synapse Analytics](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-index) and [Table statistics for dedicated SQL pool in Azure Synapse Analytics](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-statistics) articles in the Azure Synapse Analytics documentation.

