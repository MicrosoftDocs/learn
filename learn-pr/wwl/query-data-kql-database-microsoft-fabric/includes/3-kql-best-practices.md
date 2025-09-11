Understanding how to write efficient KQL queries is essential for getting good performance when working with Eventhouses. This unit covers key optimization techniques and explains why they matter for your queries.

## Why query optimization matters

Query performance in KQL databases depends on the amount of data processed. When you understand how KQL processes data, you can write queries that:

- **Run faster** by reducing the data scanned - For example, instead of scanning millions of rows, filter early to process only thousands
- **Use fewer resources** - For example, selecting only 3 columns instead of all 50 columns reduces processing overhead
- **Work reliably with growing data** - For example, a query that works on 1 million rows today will still perform well when your data grows to 10 million rows

The key principle is: the less data your query needs to process, the faster it runs.

## Understand key optimization techniques

### Filter data early and effectively

Filtering reduces the amount of data that subsequent operations need to process, and KQL databases use indexes and data organization techniques that make early filtering especially efficient.

**Time-based filtering** is effective because Eventhouses typically contain time-series data:

```kql
TaxiTrips
| where pickup_datetime > ago(30min)  // Filter first - uses time index
| project trip_id, vendor_id, pickup_datetime, fare_amount
| summarize avg_fare = avg(fare_amount) by vendor_id
```

**Order your filters by how much data they eliminate** - put filters that eliminate the most data first. Think of it like a funnel: start with the filter that removes the most rows, then apply more specific filters to the remaining data:

```kql
TaxiTrips
| where pickup_datetime > ago(1d)    // Time filter first - eliminates most data
| where vendor_id == "VTS"           // Specific vendor - eliminates some data  
| where fare_amount > 0              // Value filter - eliminates least data
| summarize trip_count = count()
```

### Reduce columns early

*Projecting* or selecting only the columns you need reduces resource usage. This is especially important when working with wide tables that have many columns.

```kql
TaxiTrips
| project trip_id, pickup_datetime, fare_amount  // Select columns early
| where pickup_datetime > ago(1d)                // Then filter
| summarize avg_fare = avg(fare_amount)
```

### Optimize aggregations and joins

Aggregations and joins are resource-intensive operations because they need to process and combine large amounts of data. How you structure them can significantly affect query performance.

**For aggregations, limit results when exploring data**:

```kql
TaxiTrips
| where pickup_datetime > ago(1d)
| summarize trip_count = count() by trip_id, vendor_id
| limit 1000  // Limit results for exploration
```

**For joins, put the smaller table first**. When joining tables, KQL processes the first table to match with the second table. Starting with a smaller table means fewer rows to process, making the join more efficient.

```kql
// Good: Small vendor table first
VendorInfo        
| join kind=inner TaxiTrips on vendor_id

// Avoid: Large taxi table first
TaxiTrips         
| join kind=inner VendorInfo on vendor_id
``` 
