
When you've created and saved your query, you can run the Azure Stream Analytics job to start processing events from the input(s) and writing results to the output(s). Once started, the job runs perpetually until stopped, continuously processing new events as they arrive.

## Working with output data

Once the job is running, you can work with the output data in whatever destination you configured.

### Querying data in a relational database

If you used an Azure SQL Database output, the table is populated with results as the job runs. You can query the table using standard T-SQL at any time; the results always reflect the latest data ingested at the time the query is executed.

For example, the following query reads sensor readings from a table named **SensorReadings** and calculates the average value per sensor:

```sql
SELECT SensorID, AVG(ReadingValue) AS AverageReading
FROM SensorReadings
GROUP BY SensorID
```

### Querying data in a data lake

If you used a Blob storage/ADLS Gen2 output, files accumulate in the storage container according to your configured folder pattern and file format. You can query those files using any analytics platform that supports reading from Azure Data Lake Storage Gen2, such as Apache Spark:

```python
df = spark.read.load(
    'abfss://data@datalake.dfs.core.windows.net/sensors/*',
    format='parquet'
)
display(df)
```

## Monitoring the job

You can monitor a running Stream Analytics job in the Azure portal. The job overview page displays key metrics including:

- **Input events** — the number of events received from input sources.
- **Output events** — the number of events written to outputs.
- **Runtime errors** — errors encountered during query execution.
- **Watermark delay** — the latency between event time and the time the event is processed.

> [!NOTE]
> For more information about monitoring and troubleshooting Stream Analytics jobs, see [Monitor Azure Stream Analytics jobs](/azure/stream-analytics/monitor-azure-stream-analytics?azure-portal=true) in the Azure Stream Analytics documentation.
