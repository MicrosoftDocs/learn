Notebooks in Azure Databricks provide a flexible, code-driven approach for ingesting data from various sources. When graphical tools don't meet your requirements, or when you need custom logic for data transformation, notebooks give you complete control over the ingestion process. You can use Python (PySpark), SQL, Scala, or R to connect to data sources, apply transformations, and load data into Unity Catalog tables.

In this unit, you learn how to ingest data using notebooks for both batch and streaming scenarios.

## Ingest batch data with DataFrames

DataFrames are the foundation for batch data ingestion in Databricks. A DataFrame is a distributed collection of data organized into named columns, similar to a table in a relational database. You use the `spark.read` API to load data from various sources into a DataFrame.

The following example reads a CSV file into a DataFrame:

```python
df = (spark.read
    .format("csv")
    .option("header", "true")
    .option("inferSchema", "true")
    .load("/Volumes/catalog/schema/volume/data.csv"))
```

The `format()` method specifies the file type, while `option()` methods configure how the data is parsed. The `header` option tells Spark to use the first row as column names, and `inferSchema` automatically detects data types.

### Read from different file formats

Azure Databricks supports multiple file formats. You can adjust the format and options based on your data source:

```python
# Read JSON files
df_json = spark.read.format("json").load("/path/to/data.json")

# Read Parquet files (columnar format, efficient for analytics)
df_parquet = spark.read.format("parquet").load("/path/to/data.parquet")

# Read XML files (requires rowTag option)
df_xml = (spark.read
    .format("xml")
    .option("rowTag", "record")
    .load("/path/to/data.xml"))
```

> [!NOTE]
> The `rowTag` option specifies which XML element represents a row. For example, given this XML structure:
>
> ```xml
> <data>
>   <record><id>1</id><name>Alice</name></record>
>   <record><id>2</id><name>Bob</name></record>
> </data>
> ```
>
> Setting `rowTag` to `"record"` tells Spark to treat each `<record>` element as a single row in the DataFrame.

Parquet files store data in a columnar format, which improves query performance for analytical workloads. JSON files support nested structures and are common for API responses. XML files require the `rowTag` option to specify which element maps to each row.

### Connect to external databases

For data stored in relational databases, use JDBC connections to read directly from the source:

```python
df_jdbc = (spark.read
    .format("jdbc")
    .option("url", "jdbc:sqlserver://server.database.windows.net:1433;database=mydb")
    .option("dbtable", "schema.tablename")
    .option("user", dbutils.secrets.get(scope="jdbc", key="username"))
    .option("password", dbutils.secrets.get(scope="jdbc", key="password"))
    .load())
```

Store credentials in Databricks secrets rather than hardcoding them in notebooks. You can also push queries down to the database by using a subquery in the `dbtable` option:

```python
pushdown_query = "(SELECT id, name, amount FROM orders WHERE order_date > '2024-01-01') AS filtered_orders"
df = spark.read.format("jdbc").option("dbtable", pushdown_query).load()
```

### Write data to Unity Catalog tables

After loading and transforming your data, write it to a Unity Catalog table. Azure Databricks uses Delta Lake format by default, which provides ACID transactions and versioning:

```python
df.write.mode("overwrite").saveAsTable("catalog.schema.table_name")
```

The `mode()` option controls how existing data is handled:

- **overwrite**: Replaces the table contents entirely
- **append**: Adds rows to the existing table
- **ignore**: Does nothing if the table already exists
- **error**: Throws an exception if the table exists (default)

## Ingest streaming data with Structured Streaming

Structured Streaming enables you to process data continuously as it arrives. Instead of `spark.read`, you use `spark.readStream` to create a streaming DataFrame that processes new data incrementally.

The following example reads streaming data from Kafka:

```python
df_stream = (spark.readStream
    .format("kafka")
    .option("kafka.bootstrap.servers", "broker:9092")
    .option("subscribe", "topic-name")
    .option("startingOffsets", "latest")
    .load())
```

The `startingOffsets` option determines where to begin reading when starting a new query. Use `latest` for new data only or `earliest` to read from the beginning of the topic. Once you configure a checkpoint location in the write stream, subsequent runs automatically resume from the last processed offset, ignoring `startingOffsets`.

### Process file-based streams

You can also stream from file sources as new files arrive in a directory:

```python
df_file_stream = (spark.readStream
    .format("csv")
    .option("header", "true")
    .schema(defined_schema)
    .load("/Volumes/catalog/schema/volume/incoming/"))
```

For streaming file sources, you should define the schema explicitly rather than using `inferSchema`. Schema inference isn't supported for streaming sources because it requires reading the entire dataset.

### Write streaming data to tables

Use `writeStream` to persist streaming data to Unity Catalog tables:

```python
(df_stream
    .writeStream
    .format("delta")
    .outputMode("append")
    .option("checkpointLocation", "/checkpoints/my-stream")
    .toTable("catalog.schema.streaming_table"))
```

The output mode determines which records are written:

- **append**: Only new rows are written (default for most operations)
- **update**: Changed rows are written
- **complete**: All rows are rewritten (used with aggregations)

The checkpoint location stores progress information, allowing the stream to resume from where it stopped if interrupted.

## Handle semi-structured data

When working with semi-structured data like JSON, the VARIANT data type provides flexibility for storing and querying nested structures:

```python
from pyspark.sql.functions import parse_json, variant_get, col

df = spark.read.text("/path/to/data.json")
df_variant = df.select(parse_json(col("value")).alias("data"))
```

You can then query specific fields using the `variant_get` function or SQL syntax:

```python
df_variant.select(variant_get(col("data"), "$.customer.name", "string")).display()
```

This approach works well when the JSON schema varies between records or evolves over time.