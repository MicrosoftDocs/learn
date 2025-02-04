All of the data we explored up to this point has been static data in files. However, many data analytics scenarios involve *streaming* data that must be processed in near real time. For example, you might need to capture readings emitted by internet-of-things (IoT) devices and store them in a table as they occur. Spark processes batch data and streaming data in the same way, enabling streaming data to be processed in real-time using the same API.

## Spark Structured Streaming

A typical stream processing solution involves:

- Constantly reading a stream of data from a *source*.
- Optionally, processing the data to select specific fields, aggregate and group values, or otherwise manipulating the data.
- Writing the results to a *sink*.

Spark includes native support for streaming data through *Spark Structured Streaming*, an API that is based on a boundless dataframe in which streaming data is captured for processing. A Spark Structured Streaming dataframe can read data from many different kinds of streaming source, including:

- Network ports
- Real time message brokering services such as Azure Event Hubs or Kafka
- File system locations.

> [!TIP]
> For more information about Spark Structured Streaming, see [Structured Streaming Programming Guide](https://spark.apache.org/docs/latest/structured-streaming-programming-guide.html) in the Spark documentation.

## Streaming with Delta tables

You can use a Delta table as a *source* or a *sink* for Spark Structured Streaming. For example, you could capture a stream of real time data from an IoT device and write the stream directly to a Delta table as a sink. You can then query the table to see the latest streamed data. Or you could read a Delta as a streaming source, enabling near real-time reporting as new data is added to the table.

### Using a Delta table as a streaming source

In the following PySpark example, a Delta table is created to store details of Internet sales orders:

```SQL
%%sql
CREATE TABLE orders_in
(
        OrderID INT,
        OrderDate DATE,
        Customer STRING,
        Product STRING,
        Quantity INT,
        Price DECIMAL
)
USING DELTA;
```

A hypothetical data stream of internet orders is inserted into the orders_in table:

```SQL
%%sql
INSERT INTO orders_in (OrderID, OrderDate, Customer, Product, Quantity, Price)
VALUES
    (3001, '2024-09-01', 'Yang', 'Road Bike Red', 1, 1200),
    (3002, '2024-09-01', 'Carlson', 'Mountain Bike Silver', 1, 1500),
    (3003, '2024-09-02', 'Wilson', 'Road Bike Yellow', 2, 1350),
    (3004, '2024-09-02', 'Yang', 'Road Front Wheel', 1, 115),
    (3005, '2024-09-02', 'Rai', 'Mountain Bike Black', 1, NULL);

```

To verify, you can read and display data from the input table:

```Python
# Read and display the input table
df = spark.read.format("delta").table("orders_in")

display(df)
```

The data is then loaded into a streaming DataFrame from the Delta table:

```python
# Load a streaming DataFrame from the Delta table
stream_df = spark.readStream.format("delta") \
    .option("ignoreChanges", "true") \
    .table("orders_in")

```

> [!NOTE]
> When using a Delta table as a streaming source, only *append* operations can be included in the stream. Data modifications can cause an error unless you specify the `ignoreChanges` or `ignoreDeletes` option.

You can check that the stream is streaming by using the `isStreaming` property which should return True:

```python
# Verify that the stream is streaming
stream_df.isStreaming
```

### Transform the data stream

After reading the data from the Delta table into a streaming DataFrame, you can use the Spark Structured Streaming API to process it. For example, you could count the number of orders placed every minute and send the aggregated results to a downstream process for near-real-time visualization.

In this example, any rows with NULL in the Price column are filtered and new columns are added for IsBike and Total.

```python
from pyspark.sql.functions import col, expr

transformed_df = stream_df.filter(col("Price").isNotNull()) \
    .withColumn('IsBike', expr("INSTR(Product, 'Bike') > 0").cast('int')) \
    .withColumn('Total', expr("Quantity * Price").cast('decimal'))
```

### Using a Delta table as a streaming sink

The data stream is then written to a Delta table:

```python
# Write the stream to a delta table
output_table_path = 'Tables/orders_processed'
checkpointpath = 'Files/delta/checkpoint'
deltastream = transformed_df.writeStream.format("delta").option("checkpointLocation", checkpointpath).start(output_table_path)

print("Streaming to orders_processed...")
```

> [!NOTE]
> The `checkpointLocation` option is used to write a checkpoint file that tracks the state of the stream processing. This file enables you to recover from failure at the point where stream processing left off.

After the streaming process starts, you can query the Delta Lake table to see what is in the output table. There might be a short delay before you can query the table.

```SQL
%%sql
SELECT *
    FROM orders_processed
    ORDER BY OrderID;
```

In the results of this query, order 3005 is excluded because it had NULL in the Price column. And the two columns that were added during the transformation are displayed - IsBike and Total.

|OrderID|OrderDate|Customer|Product|Quantity|Price|IsBike|Total|
|--|--|--|--|--|--|--|--|
|3001|2023-09-01|Yang|Road Bike Red|1|1200|1|1200|
|3002|2023-09-01|Carlson|Mountain Bike Silver|1|1500|1|1500|
|3003|2023-09-02|Wilson|Road Bike Yellow|2|1350|1|2700|
|3004|2023-09-02|Yang|Road Front Wheel|1|115|0|115|


When finished, stop the streaming data to avoid unnecessary processing costs using the `stop` method:

```python
# Stop the streaming data to avoid excessive processing costs
deltastream.stop()
```

> [!TIP]
> For more information about using Delta tables for streaming data, see [Table streaming reads and writes](https://docs.delta.io/latest/delta-streaming.html?azure-portal=true) in the Delta Lake documentation.