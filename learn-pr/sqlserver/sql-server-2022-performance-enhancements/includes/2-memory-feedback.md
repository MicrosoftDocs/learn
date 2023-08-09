---
ms.custom:
  - build-2023
---
Prior to SQL Server 2022, memory grant feedback was based on the most recent execution for a specific query, and could result in some cases of different feedback adjustments that could lead to the query processor disabling memory grant feedback for a specific query. In SQL Server 2022, memory grant feedback uses a percentile method to look at memory grants over several executions before using a memory grant feedback.

Additionally, prior to SQL Server 2022, memory grant feedback was only stored in a cached plan in memory. If the cache plan was evicted, memory grant feedback would have to be recalculated on new query executions. In SQL Server 2022, if the Query Store is enabled, memory grant feedback is persisted in the Query Store. You can view memory grant feedback persistence using the **sys.query_store_plan_feedback** catalog view.

## Batch mode memory grant feedback

A query's execution plan includes the minimum required memory needed for execution and the ideal memory grant size to have all rows fit in memory. Performance suffers when memory grant sizes are incorrectly sized. Excessive grants result in wasted memory and reduced concurrency. Insufficient memory grants cause expensive spills to disk. By addressing repeating workloads, batch mode memory grant feedback recalculates the actual memory required for a query and then updates the grant value for the cached plan. When an identical query statement is executed, the query uses the revised memory grant size, reducing excessive memory grants that affect concurrency and fixing underestimated memory grants that cause expensive spills to disk.

The following graph shows one example of using batch mode adaptive memory grant feedback. For the first execution of the query, the duration was 88 seconds due to high spills:

```sql
DECLARE @EndTime datetime = '2016-09-22 00:00:00.000';
DECLARE @StartTime datetime = '2016-09-15 00:00:00.000';

SELECT TOP 10 hash_unique_bigint_id
FROM dbo.TelemetryDS
WHERE Timestamp BETWEEN @StartTime AND @EndTime
GROUP BY hash_unique_bigint_id
ORDER BY MAX(max_elapsed_time_microsec) DESC;
```

:::image type="content" source="../media/memory-grant-high-spills.png" alt-text="Screenshot of a batch mode adaptive memory grant feedback query execution with high spills.":::

With memory grant feedback enabled for the second execution, the duration is 1 second (down from 88 seconds). The spills are removed entirely, and the grant is higher:

:::image type="content" source="../media/memory-grant-no-spills.png" alt-text="Screenshot of a batch mode adaptive memory grant feedback query execution with no spills.":::

## Memory grant feedback sizing

For an excessive memory grant condition, if the granted memory is more than two times the size of the actual used memory, memory grant feedback recalculates the memory grant and update the cached plan. Plans with memory grants under 1 MB won't be recalculated for overages.

For an insufficiently sized memory grant condition that result in a spill to disk for batch mode operators, memory grant feedback triggers a recalculation of the memory grant. Spill events are reported to memory grant feedback and can be surfaced using the `spilling_report_to_memory_grant_feedback` extended event. This event returns the node ID from the plan and the spilled data size of that node.

The adjusted memory grant shows up in the actual (post-execution) plan in the `GrantedMemory` property.

You can see this property in the root operator of the graphical `showplan` or in the `showplan` XML output:

```xml
<MemoryGrantInfo SerialRequiredMemory="1024" SerialDesiredMemory="10336" RequiredMemory="1024" DesiredMemory="10336" RequestedMemory="10336" GrantWaitTime="0" GrantedMemory="10336" MaxUsedMemory="9920" MaxQueryMemory="725864" />
```

To have your workloads automatically eligible for this improvement, enable compatibility level 140 for the database.

```sql
ALTER DATABASE [WideWorldImportersDW] SET COMPATIBILITY_LEVEL = 140;
```

## Row mode memory grant feedback

Row mode memory grant feedback expands on the batch mode memory grant feedback feature by adjusting memory grant sizes for both batch and row mode operators.

To enable row mode memory grant feedback, enable database compatibility level 150 or higher for the database you're connected to when executing the query.

```sql
ALTER DATABASE [<database name>] SET COMPATIBILITY_LEVEL = 150;
```

As with batch mode memory grant feedback, row mode memory grant feedback activity is visible using the `memory_grant_updated_by_feedback` extended event.

Memory grant feedback doesn't require the Query Store. However, the persistence improvements introduced in SQL Server 2022 require the Query Store to be enabled for the database and in a `read write` state.

Starting with row mode memory grant feedback, two new query plan attributes is shown for actual post-execution plans: `IsMemoryGrantFeedbackAdjusted` and `LastRequestedMemory`, which are added to the `MemoryGrantInfo` query plan XML element.

- The `LastRequestedMemory` attribute shows the granted memory in kilobytes (KB) from the prior query execution.
- The `IsMemoryGrantFeedbackAdjusted` attribute allows you to check the state of memory grant feedback for the statement within an actual query execution plan.
