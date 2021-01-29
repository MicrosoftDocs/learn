Materialized views are prewritten queries with joins and filters whose definition is saved and the results persisted to a dedicated SQL pool. They are not supported in by serverless SQL pools.

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
