Real-time data ingestion allows you to process events as they occur rather than waiting for batch intervals. When your organization needs to capture IoT sensor readings, clickstream data, or financial transactions as they happen, Spark Structured Streaming provides the foundation for continuous data ingestion into your lakehouse.

In this unit, you learn how to configure Structured Streaming jobs that read from streaming sources and write to Unity Catalog tables.

## Understand the Structured Streaming model

Structured Streaming treats incoming data as an unbounded table that grows continuously as new data arrives. You use the same DataFrame API you already know, but instead of `spark.read`, you use `spark.readStream` to create a streaming DataFrame that processes data incrementally.

Consider a scenario where sensor data arrives continuously from manufacturing equipment. Rather than scheduling hourly batch jobs to ingest this data, you can configure a streaming job that processes each reading within seconds of its arrival. The streaming engine tracks which records have been processed using **checkpoints**, so if the job restarts, it resumes from where it left off without reprocessing or missing data.

The fundamental pattern for streaming ingestion involves three steps:

1. **Configure the source** using `spark.readStream` with connection details
2. **Apply transformations** to shape the data as needed
3. **Write to a sink** using `writeStream` with a checkpoint location

## Connect to Kafka and Event Hubs

Azure Event Hubs provides an Apache Kafka-compatible endpoint, which means you can use the same Kafka connector for both services. This unified approach simplifies your code when working with different message buses.

The following example reads messages from a Kafka topic:

```python
df_stream = (spark.readStream
    .format("kafka")
    .option("kafka.bootstrap.servers", "broker-server:9092")
    .option("subscribe", "sensor-readings")
    .option("startingOffsets", "latest")
    .load())
```

For Azure Event Hubs, you connect through its Kafka-compatible interface. The key difference is the authentication configuration, which uses SASL with your Event Hubs connection string:

```python
eh_namespace = "your-namespace"
eh_name = "your-eventhub"
connection_string = dbutils.secrets.get(scope="eventhubs", key="connection-string")

kafka_options = {
    "kafka.bootstrap.servers": f"{eh_namespace}.servicebus.windows.net:9093",
    "subscribe": eh_name,
    "kafka.sasl.mechanism": "PLAIN",
    "kafka.security.protocol": "SASL_SSL",
    "kafka.sasl.jaas.config": f'kafkashaded.org.apache.kafka.common.security.plain.PlainLoginModule required username="$ConnectionString" password="{connection_string}";'
}

df_stream = (spark.readStream
    .format("kafka")
    .options(**kafka_options)
    .load())
```

When reading from Kafka or Event Hubs, you receive a standard schema with `key`, `value`, `topic`, `partition`, `offset`, and `timestamp` columns. The `key` and `value` columns contain binary data, so you typically cast them to string and parse the content:

```python
from pyspark.sql.functions import col, from_json
from pyspark.sql.types import StructType, StringType, DoubleType

schema = StructType() \
    .add("device_id", StringType()) \
    .add("temperature", DoubleType()) \
    .add("timestamp", StringType())

parsed_df = (df_stream
    .select(col("value").cast("string").alias("json_value"))
    .select(from_json(col("json_value"), schema).alias("data"))
    .select("data.*"))
```

## Configure checkpoint locations

Checkpoints are the mechanism that makes Structured Streaming fault-tolerant. The checkpoint directory stores the offset information that tracks exactly which records have been processed. If your streaming job stops unexpectedly, it can restart and continue from the last committed checkpoint.

> [!IMPORTANT]
> Each streaming query must have its own unique checkpoint location. Sharing checkpoints between different queries causes data processing errors.

When you start a streaming write, specify the checkpoint location:

```python
checkpoint_path = "/checkpoints/sensor-ingestion"

query = (parsed_df.writeStream
    .format("delta")
    .option("checkpointLocation", checkpoint_path)
    .toTable("catalog.schema.sensor_readings"))
```

Store your checkpoints in a reliable, durable location like Azure Data Lake Storage. The checkpoint files are small but critical for recovery, so configure your storage location with appropriate backup and retention policies.

## Write streaming data to Unity Catalog tables

Writing to Unity Catalog tables uses Delta Lake format, which supports both streaming writes and ACID transactions. The `writeStream` API mirrors the batch `write` API but includes options for continuous processing:

```python
(parsed_df.writeStream
    .format("delta")
    .outputMode("append")
    .option("checkpointLocation", "/checkpoints/my-stream")
    .toTable("bronze.iot.sensor_readings"))
```

The **output mode** determines how results are written:

- **append**: New rows are added to the table. Use this mode for most ingestion workloads.
- **update**: Changed rows are updated. Use with aggregations that produce updates.
- **complete**: All rows are rewritten. Use with aggregations that require complete recalculation.

For ingestion scenarios where you're appending raw data, the default `append` mode is appropriate.

## Control processing with triggers

Triggers determine when and how frequently the streaming engine processes data. Databricks supports several trigger options:

| Trigger | Behavior |
|---------|----------|
| Default (no trigger) | Processes the next batch as soon as the previous batch completes |
| `processingTime="10 seconds"` | Processes in fixed intervals |
| `availableNow=True` | Processes all available data, then stops |
| `once=True` | Processes one micro-batch, then stops (deprecated) |

For continuous ingestion that runs indefinitely, omit the trigger option or use a processing time interval. For incremental batch patterns where you want to process all available data on a schedule, use `availableNow`:

```python
(parsed_df.writeStream
    .format("delta")
    .option("checkpointLocation", checkpoint_path)
    .trigger(availableNow=True)
    .toTable("catalog.schema.table_name"))
```

The `availableNow` trigger processes all unprocessed data since the last checkpoint, then terminates. You can schedule this pattern using Databricks Jobs to run at regular intervals, combining the efficiency of streaming (only processing new data) with the predictability of scheduled batch jobs.

## Monitor streaming queries

Active streaming queries appear in the Spark UI under the **Structured Streaming** tab. You can also access query status programmatically:

```python
query = parsed_df.writeStream.format("delta").option("checkpointLocation", checkpoint_path).toTable("my_table")

# Check if the query is still running
print(query.isActive)

# Get the current status
print(query.status)

# View recent progress
print(query.recentProgress)
```

Use the `awaitTermination()` method to block execution until the stream completes or fails. For production workloads, implement error handling to capture and respond to streaming failures:

```python
try:
    query.awaitTermination()
except Exception as e:
    print(f"Stream failed: {e}")
```

In production environments, configure monitoring and alerts to detect when streaming jobs fall behind or encounter errors. Streaming metrics include lag information that helps you understand whether your processing keeps pace with incoming data.
