Now that you understand basic KQL querying and optimization techniques, let's explore materialized views and stored functions in eventhouses.

## Understand materialized views

Materialized views are precomputed aggregations that solve a common performance challenge in KQL databases. KQL databases in eventhouses often contain millions or billions of rows from streaming data sources like IoT sensors, application logs, and other events. Running aggregation queries across these large datasets can take significant time and computing resources.

Materialized views store precomputed aggregation results and automatically update them as new data arrives. Instead of recalculating metrics from all historical data every time you query, the materialized view maintains the results and only processes the new data to update the aggregations. This provides instant results for dashboards and reports, even when working with massive datasets.

### How automatic updates work

A materialized view consists of two parts that work together to provide always-current results:

- **A materialized part**: Precomputed aggregation results from data that has already been processed
- **A delta**: New data that has arrived since the last background update

When you query a materialized view, the system automatically combines both parts at query time to give you fresh, up-to-date results. This means materialized views always return current data, regardless of when the background materialization process last ran. Meanwhile, a background process periodically moves data from the delta part into the materialized part, keeping the precomputed results current. This approach provides the speed of precomputed results with the freshness of real-time data.

### Create materialized views

A materialized view encapsulates a KQL **summarize** statement that automatically updates as new data arrives. Here's an example that tracks trip metrics by vendor and day:

```kql
.create materialized-view TripsByVendor on table TaxiTrips
{
    TaxiTrips
    | summarize trips = count(), avg_fare = avg(fare_amount), total_revenue = sum(fare_amount)
    by vendor_id, pickup_date = format_datetime(pickup_datetime, "yyyy-MM-dd")
}
```

### Query materialized views

Once created, materialized views can be queried like regular tables:

```kql
TripsByVendor
| where pickup_date >= ago(7d)
| project pickup_date, vendor_id, trips, avg_fare, total_revenue
| sort by pickup_date desc, total_revenue desc
```

## Understand stored functions

KQL includes the ability to encapsulate a query as a function, making it easier to repeat common queries. You can also specify parameters for a function, so you can repeat the same query with variable values.

Stored functions are useful in eventhouses where you have streaming data and multiple people writing queries. Instead of writing the same filtering or transformation logic repeatedly, you can define it once as a function and reuse it across different queries. Functions also help ensure that calculations are performed consistently when different team members need to apply the same logic to the data.

### Create a function

```kql
.create-or-alter function trips_by_min_passenger_count(num_passengers:long)
{
    TaxiTrips
    | where passenger_count >= num_passengers 
    | project trip_id, pickup_datetime
}
```

To call the function, use it like a table. In this example, the **trips_by_min_passenger_count** function is used to find 10 trips with at least three passengers:

```kql
trips_by_min_passenger_count(3)
| take 10
``` 