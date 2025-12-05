Raw streaming data rarely arrives in the exact format needed for analysis or action. Transformations allow you to clean, enrich, and reshape data before routing it to destinations, ensuring each endpoint receives data optimized for its specific purpose.

Common transformation scenarios include:

- **Data quality**: Filter out invalid or incomplete data before processing
- **Content-based routing**: Route different data subsets to appropriate destinations based on the actual data values or content
- **Data enrichment**: Add calculated fields, rename columns for clarity, or convert data types for downstream compatibility
- **Aggregation and summarization**: Calculate running totals, averages, or counts over time windows for dashboard displays
- **Format standardization**: Ensure consistent data structure across multiple data sources before combining streams

## Transform event data

The eventstream canvas gives you a way to create event data processing workflows. Eventstream provide several no-code transformations that you can drag onto the canvas:

- **Filter**: Filter events based on the value of a field in the input. Keep only events that meet specific conditions. For example: temperature > 80°, status = "error", customer type = "premium".
- **Manage fields**: This transformation allows you to add, remove, change data type, or rename fields coming in from an input or another transformation. Add calculated fields, remove unnecessary columns, rename fields, or change data types to match destination requirements.
- **Aggregate**: Use the aggregate transformation to calculate an aggregation (Sum, Minimum, Maximum, or Average) every time a new event occurs over a period of time. This operation also lets you rename calculated columns, and filter the aggregation based on other dimensions in your data. You can have one or more aggregations in the same transformation.
- **Group by**: Calculate aggregations across events within time windows, for example, hourly sales totals, or daily temperature averages. This transformation supports various time windows including *tumbling windows* (fixed intervals) and *sliding windows* (overlapping intervals).
- **Union**: Use the union transformation to connect two or more nodes in the event canvas and add events with shared fields (with the same name and data type) into one table. Fields that don't match are dropped and not included in the output.
- **Join**: Combine data from two streams based on a matching condition between them.
- **Expand**: Use this array transformation to create a new row for each value within an array.

## Create transformation workflows

Transformations can be used together to create data processing pipelines. For example, if you had a stream of equipment temperature readings, you could start by using **filter** to remove sensor errors from incoming IoT data. Next, you might use **manage fields** to add a calculated "priority" column based on temperature thresholds. Then **group by** could calculate hourly averages by location. Finally, you'd route the processed data to appropriate destinations: temperature data to Fabric Activator for rule evaluation and hourly summaries to a Lakehouse for historical analysis.