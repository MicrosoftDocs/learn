As with any language, there are several best practices in Microsoft Fabric KQL that can improve query performance and prevent data quality issues viewed on the data consumer side. As this is a SaaS solution, more tuning of the data and storage are handled by Microsoft.

- **Reduce the amount of data being processed**: A query's performance depends directly on the amount of data it needs to process. The less data is processed, the quicker the query (and the fewer resources it consumes).

Here are some examples of KQL queries from the Trips table that follow the rules you mentioned:

This query selects only the columns needed from the Trips table and filters the data by a specific date range:

```kusto

Trips
| where ((pickup_datetime >= todatetime("2014-10-01")) and (pickup_datetime < todatetime("2014-11-01")))
| project passenger_count, trip_distance, fare_amount

```

This query applies a predicate on a string column first, then filters by a specific date range:

```kusto

Trips
| where ( payment_type == 'CRD' and (pickup_datetime >= todatetime("2014-10-01")) and (pickup_datetime < todatetime("2014-11-01")))
| project passenger_count, trip_distance, fare_amount

```

This query applies a predicate on a numeric column first, then filters by a specific date range:

```kusto

Trips
| where ( passenger_count > 2 and (pickup_datetime >= todatetime("2014-10-01")) and (pickup_datetime < todatetime("2014-11-01")))
| project payment_type, passenger_count, trip_distance, fare_amount

```

- **Avoid using redundant qualified references**: Entities such as tables and materialized views are referenced by name. For example, the table T can be referenced as simply T (the unqualified name), or by using a database qualifier (for example, database("DB").T when the table is in a database called DB). It's a best practice to avoid using name qualifications when they're redundant, for the following reasons:
    - Unqualified names are easier to identify as belonging to the database-in-scope.
    - Referencing database-in-scope entities is always at least as fast, and in some cases faster, than entities that belong to other databases (especially when those databases are in a different cluster.) Avoiding qualified names helps the reader to do the right thing.

 > [!NOTE] 
 > In most cases, KQL can identify when a fully qualified name references an entity belonging to the database-in-scope and “short-circuit” the query so that it is not regarded as a cross-cluster query. However, we recommend not relying on this when not necessary, for the reasons specified above.


- **Use the right data types**: KQL supports various data types such as strings, integers, datetimes, and booleans. Using the correct data type for each field can help improve query performance.
- **Avoid using wildcard characters**: Wildcard characters such as `*` and `?` can slow down query performance. If possible, avoid using them in your queries.
- **Use the `project` operator to limit output**: The `project` operator allows you to specify which columns to include in your query output. This can help reduce the amount of data being processed and improve query performance.
- **Use the `where` operator to filter data**: The `where` operator allows you to filter data based on specific conditions. This practice can help reduce the amount of data being processed and improve query performance.
- **Use the `summarize` operator for aggregations**: The `summarize` operator allows you to perform aggregations such as `count`, `sum`, and `avg`. This can help reduce the amount of data being processed and improve query performance.
- **Optimize your queries**: KQL is designed to handle large amounts of data, but it’s still important to optimize your queries for performance. Remember, again, to use the `where` clause to filter data before running a query, and avoid using `*` to select all columns 

Here are some other resources:

[Query data in a KQL queryset - Microsoft Fabric | Microsoft Learn.](/fabric/real-time-analytics/kusto-query-set)