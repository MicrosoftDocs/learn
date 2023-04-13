
To send streaming data to Power BI, your Azure Stream Analytics job uses a query that writes its results to a Power BI output. A simple query that forwards event data from an event hub directly to Power BI might look something like this:

```sql
SELECT
    EventEnqueuedUtcTime AS ReadingTime,
    SensorID,
    ReadingValue
INTO
    [powerbi-output]
FROM
    [eventhub-input] TIMESTAMP BY EventEnqueuedUtcTime
```

The results of the query determine the schema of the table in the output dataset in Power BI.

Alternatively, you might use your query to filter and/or aggregate the data, sending only relevant or summarized data to the Power BI dataset. For example, the following query calculates the maximum reading for each sensor other than sensor *0* for each consecutive minute in which an event occurs.

```sql
SELECT
    DateAdd(second, -60, System.TimeStamp) AS StartTime,
    System.TimeStamp AS EndTime,
    SensorID,
    MAX(ReadingValue) AS MaxReading
INTO
    [powerbi-output]
FROM
    [eventhub-input] TIMESTAMP BY EventEnqueuedUtcTime
WHERE SensorID <> 0
GROUP BY SensorID, TumblingWindow(second, 60)
HAVING COUNT(*) > 1
```

When working with window functions (such as the **TumblingWindow** function in the previous example), consider that Power BI is capable of handling a call every second. Additionally, streaming visualizations support packets with a maximum size of 15 KB. As a general rule, use window functions to ensure data is sent to Power BI no more frequently than every second, and minimize the fields included in the results to optimize the size of the data load.

> [!NOTE]
> For more information about Power BI output limitations, see [Power BI output from Azure Stream Analytics](/azure/stream-analytics/power-bi-output?azure-portal=true#limitations-and-best-practices) in the Azure Stream Analytics documentation.
