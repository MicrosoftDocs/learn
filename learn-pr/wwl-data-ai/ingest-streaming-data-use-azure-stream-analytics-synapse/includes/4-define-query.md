
After defining the input(s) and output(s) for your Azure Stream Analytics job, you can define a *query* to process the incoming data from an input and write the results to an output.

## Selecting input fields

The simplest approach to ingesting streaming data into Azure Synapse Analytics is to capture the required field values for every event using a **SELECT...INTO** query, as shown here:

```sql
SELECT
    EventEnqueuedUtcTime AS ReadingTime,
    SensorID,
    ReadingValue
INTO
    [synapse-output]
FROM
    [streaming-input] TIMESTAMP BY EventEnqueuedUtcTime
```

> [!TIP]
> When using an **Azure Synapse Analytics** output to write the results to a table in a dedicated SQL pool, the schema of the results produced by the query must match the table into which the data is to be loaded. You can use **AS** clauses to rename fields, and cast them to alternative (compatible) data types as necessary.

## Filtering event data

In some cases, you might want to filter the data to include only specific events by adding a **WHERE** clause. For example, the following query writes data only for events with a negative **ReadingValue** field value. 

```sql
SELECT
    EventEnqueuedUtcTime AS ReadingTime,
    SensorID,
    ReadingValue
INTO
    [synapse-output]
FROM
    [streaming-input] TIMESTAMP BY EventEnqueuedUtcTime
WHERE ReadingValue < 0
```

## Aggregating events over temporal windows

A common pattern for streaming queries is to aggregate event data over temporal (time-based) intervals, or *windows*. To accomplish this, you can use a **GROUP BY** clause that includes a Window function defining the kind of window you want to define (for example, *tumbling*, *hopping*, or *sliding*).

> [!TIP]
> For more information about window functions, see [Introduction to Stream Analytics windowing functions](/azure/stream-analytics/stream-analytics-window-functions?azure-portal=true) in the Azure Stream Analytics documentation.

The following example groups streaming sensor readings into 1 minute tumbling (serial, non-overlapping) windows, recording the start and end time of each window and the maximum reading for each sensor. The **HAVING** clause filters the results to include only windows where at least one event occurred.

```sql
SELECT
    DateAdd(second, -60, System.TimeStamp) AS StartTime,
    System.TimeStamp AS EndTime,
    SensorID,
    MAX(ReadingValue) AS MaxReading
INTO
    [synapse-output]
FROM
    [streaming-input] TIMESTAMP BY EventEnqueuedUtcTime
GROUP BY SensorID, TumblingWindow(second, 60)
HAVING COUNT(*) >= 1
```

> [!TIP]
> For more information about common patters for queries, see [Common query patterns in Azure Stream Analytics](/azure/stream-analytics/stream-analytics-stream-analytics-query-patterns?azure-portal=true) in the Azure Stream Analytics documentation.
