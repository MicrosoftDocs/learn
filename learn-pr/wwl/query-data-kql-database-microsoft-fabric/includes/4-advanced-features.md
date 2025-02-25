While you can often achieve your analytical goals by querying tables and using built-in functions and operators, KQL provides some advanced features that you can use to create new objects that encapsulate data or logic that you frequently need to use.

## Materialized views

A materialized view is a summary of data from a source table or another materialized view. The view encapsulates a **summarize** statement.

For example, the following statement creates a materialized view that contains the number of trips for each vendor each day.

```kql
.create materialized-view TripsByVendor on table Automotive
{
    Automotive
    | summarize trips = count() by vendor_id, pickup_date = format_datetime(pickup_datetime, "yyyy-MM-dd")
}
```

Running this statement creates a materialized view, but doesn't immediately populate it with the data in the existing table. The view will be populated as new data is ingested into the source table. To ingest existing data, you can use an asynchronous operation to create the materialized view with the *backfill* option, like this:

```kql
.create async materialized-view with (backfill=true)
TripsByVendor on table Automotive
{
    Automotive
    | summarize trips = count() by vendor_id, pickup_date = format_datetime(pickup_datetime, "yyyy-MM-dd")
}
```

After creating and populating the materialized view, you can query it just like a table.

```kql
TripsByVendor
| project pickup_date, vendor_id, trips
| sort by pickup_date desc
```

Materialized views are listed in the **Materialized views** folder for the KQL database where you defined them in the eventhouse page.

## Stored functions

KQL includes the ability to encapsulate a query as a function, making it easier to repeat common queries. You can also specify parameters for a function, so you can repeat the same query with variable values.

To create a function, use the **.create-or-alter function** KQL command. For example, the following function retrieves the trip ID and pickup time for trips with at least the specified number of passengers:

```kql
.create-or-alter function trips_by_min_passenger_count(num_passengers:long)
{
    Automotive
    | where passenger_count >= num_passengers 
    | project trip_id, pickup_datetime
}
```

To call the function, use it like a table. In this example, the **trips_by_min_passenger_count** function is used to find 10 trips with at least three passengers:

```kql
trips_by_min_passenger_count (3)
| take 10
```
