KQL databases in eventhouses are optimized for large volumes of real-time data. To get the best results, there are some good practices you should bear in mind.

Tables based on streams of real-time data can become large. Minimizing the data returned by a query can help optimize performance and prevent errors due to exceeded data limits.

## Filter columns

Use the **project** keyword to retrieve only the columns you need. For example, the following query returns only four columns of data:

```kql
Automotive
| project trip_id, vendor_id, pickup_datetime, fare_amount
```

## Filter rows

Use the **where** keyword to filter the rows returned based on specific criteria. For example, the following query returns data only for trips that occurred in the current month:

```kql
Automotive
| where getmonth(pickup_datetime) == getmonth(now())
  and getyear(pickup_datetime) == getyear(now())
| project trip_id, vendor_id, pickup_datetime, fare_amount
```

Note the use of the `getmonth` and `getyear` functions in this example. Given that real-time data usually involves a temporal (time-based) element, KQL provides strong support for filtering based on time. For example, the following query uses the **ago** function to restrict results to only the events that occurred in the last 30 minutes.

```kql
Automotive
| where pickup_datetime > ago(30min)
| project trip_id, vendor_id, pickup_datetime, fare_amount
```

When the data is being perpetually loaded from a streaming source (for example, by an eventstream), you can use the **ingestion_time** function to filter based on when the data was loaded into the table, even if the data doesn't include a time-based value on which to filter. For example, the following query retrieves the events that have been loaded into the table in the past hour.

```kql
Automotive
| where ingestion_time() > ago(1h)
| project trip_id, vendor_id, pickup_datetime, fare_amount
```

## Summarize data

Sometimes, you don't need to retrieve data at the individual event level. Instead, you can summarize the data to help you analyze patterns - often based on time intervals.

For example, the following query retrieves the average fare collected by each taxi vendor each hour in the events ingested within the last day.

```kql
Automotive
| where ingestion_time() > ago(1d)
| summarize average_fare = avg(fare_amount) by vendor_id, pickup_hour = hourofday(pickup_datetime)
| project pickup_hour, vendor_id, average_fare
| sort by pickup_hour
```
