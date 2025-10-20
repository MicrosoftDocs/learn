A streaming table is a Delta table that includes support for streaming and incremental data processing. Unlike traditional tables, a streaming table is designed to continuously accept data as it arrives. It's updated by flows within a pipeline and is useful for scenarios where new data must be ingested or transformed on an ongoing basis.

Streaming tables are especially useful for data ingestion because they process each input row only once, which matches most ingestion workloads. They're capable of handling large volumes of append-only data efficiently. They're also valuable in low-latency transformations because they can process data over rows and windows of time, manage high volumes of input, and deliver results with minimal delay.

## How Streaming tables work

When a streaming table is updated, the flows associated with it read new information from the streaming source and append it to the table. The table is defined in the pipeline’s source code, and only that pipeline has the authority to update it. If a streaming table is created outside of a pipeline in Databricks SQL, the system automatically generates a hidden pipeline to manage its updates.

In practice, multiple flows can append data to the same streaming table. Conceptually, you can imagine a streaming table as the central destination in an ETL process where flows continuously supply new data.

## Create streaming tables

In SQL, you can define a streaming table with Lakeflow Declarative Pipelines as follows:

```sql
CREATE OR REFRESH STREAMING TABLE customers_bronze
AS SELECT * FROM STREAM read_files(
  "/volumes/path/to/files",
  format => "json"
);
```

## Append-only behavior

Streaming tables are designed to work with append-only data sources. Once a row has been appended to the table, it isn't reprocessed even if the query defining the table changes. For example, if the original query transforms names to lowercase and is later modified to transform them to uppercase, the rows that were already appended remain in lowercase. Only new rows arriving after the change are processed with the updated logic. If you need to update all rows with the new transformation, you must trigger a full refresh of the pipeline.

## Low-latency streaming

Streaming tables are optimized for low-latency workloads through checkpoint management. They operate best when working with bounded streams. A naturally bounded stream occurs when the data source has a clear start and end, such as a directory of files that isn't updated after an initial batch. Another way to bound a stream is by applying a watermark. A watermark in Spark Structured Streaming specifies how long the system should wait for late-arriving data before it closes a window of time. Without a watermark, an unbounded stream could accumulate state indefinitely, leading to pipeline failures caused by memory pressure.

## Stream-snapshot joins

Streaming tables also support joins between a live stream and a static snapshot of a dimension table. In this scenario, the dimension table is treated as a snapshot at the moment the stream starts. Any changes to the dimension after the stream begins aren't reflected in the join unless the dimension table is explicitly refreshed. This approach is often acceptable in use cases where the fact table is extremely large compared to the dimension table, and a small discrepancy is tolerable.

## Limitations of Streaming Tables

Streaming tables have the following limitations:

- **Limited evolution**: Changing queries only affects new rows; old rows remain unchanged unless full refresh is triggered.

- **State management**: Requires bounded or watermarked streams to avoid failures.

- **Joins don't recompute**: Joins don’t update when dimension tables change. For always-correct joins, use materialized views.