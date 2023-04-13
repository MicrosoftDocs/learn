
When you've created and saved your query, you can run the Azure Stream Analytics job to process events in the input(s) and write the results to output(s). Once started, the query will run perpetually until stopped; constantly ingesting new event data into your Azure Synapse Analytics workspace (into a table in relational data warehouse or files in a data lake, depending on the output type).

## Working with ingested data

You can work with the ingested streaming data like any other data in Azure Synapse Analytics, combining it with data ingested using batch processing techniques or synchronized from operational data sources by using Azure Synapse Link.

### Querying data in a relational data warehouse

If you used an Azure Synapse Analytics output to ingest the results of your stream processing job into a table in a dedicated SQL pool, you can query the table using a SQL query, just like any other table. The results of the query will always include the latest data to be ingested at the time the query is run. Your data warehouse can include tables for streaming data as well as tables for batch ingested data, enabling you to join real-time and batch data for historical analytics.

For example, the following SQL code could be used to query a table named **factSensorReadings** that contains the results of stream processing, and combine it with a **dimDate** table containing detailed data about the dates on which readings were captured.

```sql
SELECT d.Weekday, s.SensorID, AVG(s.SensorReading) AS AverageReading
FROM factSensorReadings AS s
JOIN dimDate AS d
    ON CAST(s.ReadingTime AS DATE) = d.DateKey
GROUP BY d.Weekday, s.SensorID
```

> [!TIP]
> To Learn more about using a dedicated SQL pool to analyze data in a data warehouse, see the [Analyze data in a relational data warehouse](/training/modules/design-multidimensional-schema-to-optimize-analytical-workloads/?azure-portal=true) module on Microsoft Learn.

### Querying data in a data lake

As streaming data is ingested into files in a data lake, you can query those files by using a serverless SQL pool in Azure Synapse Analytics. For example, the following query reads all fields from all Parquet files under the **sensors** folder in the **data** file system container.

```sql
SELECT *
FROM OPENROWSET(
    BULK 'https://mydatalake.blob.core.windows.net/data/sensors/*',
    FORMAT = 'parquet') AS rows
```

> [!TIP]
> To Learn more about using serverless SQL pools to query files in a data lake, see the [Use Azure Synapse serverless SQL pool to query files in a data lake](/training/modules/query-data-lake-using-azure-synapse-serverless-sql-pools?azure-portal=true) module on Microsoft Learn. 

You can also query the data lake by using code running in an Apache Spark pool, as shown in this example:

```python
%%pyspark
df = spark.read.load('abfss://data@datalake.dfs.core.windows.net/sensors/*', format='parquet'
)
display(df)
```

> [!TIP]
> To Learn more about using Apache Spark pools to query files in a data lake, see the [Analyze data with Apache Spark in Azure Synapse Analytics](/training/modules/understand-big-data-engineering-with-apache-spark-azure-synapse-analytics/?azure-portal=true) module on Microsoft Learn.
