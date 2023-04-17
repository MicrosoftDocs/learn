<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: briefly summarize the key skill this unit will teach

    Heading: none

    Example: "Organizations often have multiple storage accounts to let them implement different sets of requirements."

    [Learning-unit introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=main#rule-use-the-standard-learning-unit-introduction-format)
-->
## Memory Grant Feedback
Prior to SQL Server 2022, memory grant feedback was based on the most recent execution for a specific query. This could result in some cases of different feedback adjustments which could lead to the query processor to disable memory grant feedback for a specific query. In SQL Server 2022, memory grant feedback uses a percentile method to look at memory grants over several executions before using a memory grant feedback.

Additionally, prior to SQL Server 2022, memory grant feedback was only stored in a cached plan in memory. If the cache plan was evicted, memory grant feedback would have to be recalculated on new query executions. In SQL Server 2022, if the Query Store. is enabled memory grant feedback will be persisted in the Query Store. You can view memory grant feedback persistence from the sys.query_store_plan_feedback catalog view.



<!-- 2. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario that will be solved by the content in this unit

    Heading: none, combine this with the topic sentence into a single paragraph

    Example: "In the shoe-company scenario, we will use a Twitter trigger to launch our app when tweets containing our product name are available."
-->
### Batch mode memory grant feedback

A query's execution plan includes the minimum required memory needed for execution and the ideal memory grant size to have all rows fit in memory. Performance suffers when memory grant sizes are incorrectly sized. Excessive grants result in wasted memory and reduced concurrency. Insufficient memory grants cause expensive spills to disk. By addressing repeating workloads, batch mode memory grant feedback recalculates the actual memory required for a query and then updates the grant value for the cached plan. When an identical query statement is executed, the query uses the revised memory grant size, reducing excessive memory grants that impact concurrency and fixing underestimated memory grants that cause expensive spills to disk.

The following graph shows one example of using batch mode adaptive memory grant feedback. For the first execution of the query, duration was 88 seconds due to high spills:

```sql
DECLARE @EndTime datetime = '2016-09-22 00:00:00.000';
DECLARE @StartTime datetime = '2016-09-15 00:00:00.000';

SELECT TOP 10 hash_unique_bigint_id
FROM dbo.TelemetryDS
WHERE Timestamp BETWEEN @StartTime AND @EndTime
GROUP BY hash_unique_bigint_id
ORDER BY MAX(max_elapsed_time_microsec) DESC;
```
![spills1](../media/mgf/mgf2/2_aqpgraphhighspills.png)

With memory grant feedback enabled, for the second execution, duration is 1 second (down from 88 seconds), spills are removed entirely, and the grant is higher:

![granted](../media/mgf/mgf2/3_aqpgraphnospills.png)

<!-- 3. Prose table-of-contents --------------------------------------------------------------------

    Goal: State concisely what's covered in this unit

    Heading: none, combine this with the topic sentence into a single paragraph

    Example: "Here, you will learn the policy factors that are controlled by a storage account so you can decide how many accounts you need."
-->
#### Memory grant feedback sizing

For an excessive memory grant condition, if the granted memory is more than two times the size of the actual used memory, memory grant feedback will recalculate the memory grant and update the cached plan. Plans with memory grants under 1 MB won't be recalculated for overages.

For an insufficiently sized memory grant condition that result in a spill to disk for batch mode operators, memory grant feedback will trigger a recalculation of the memory grant. Spill events are reported to memory grant feedback and can be surfaced via the `spilling_report_to_memory_grant_feedback` extended event. This event returns the node ID from the plan and spilled data size of that node.

The adjusted memory grant shows up in the actual (post-execution) plan via the `GrantedMemory` property.

You can see this property in the root operator of the graphical showplan or in the showplan XML output:

```xml
<MemoryGrantInfo SerialRequiredMemory="1024" SerialDesiredMemory="10336" RequiredMemory="1024" DesiredMemory="10336" RequestedMemory="10336" GrantWaitTime="0" GrantedMemory="10336" MaxUsedMemory="9920" MaxQueryMemory="725864" />
```

To have your workloads automatically eligible for this improvement, enable compatibility level 140 for the database.

Example:

```sql
ALTER DATABASE [WideWorldImportersDW] SET COMPATIBILITY_LEVEL = 140;
```

<!-- 4. Visual element (highly recommended) ----------------------------------------------------------------

    Goal: Visual element, like an image, table, list, code sample, or blockquote. Ideally, you'll provide an image that illustrates the customer problem the unit will solve; it can use the scenario to do this or stay generic (i.e. not address the scenario).

    Heading: none
-->
#### Row mode memory grant feedback

Row mode memory grant feedback expands on the batch mode memory grant feedback feature by adjusting memory grant sizes for both batch and row mode operators.

To enable row mode memory grant feedback enable database compatibility level 150 or higher for the database you're connected to when executing the query.

```sql
ALTER DATABASE [<database name>] SET COMPATIBILITY_LEVEL = 150;
```
As with batch mode memory grant feedback, row mode memory grant feedback activity is visible via the memory_grant_updated_by_feedback XEvent. We're also introducing two new query execution plan attributes for better visibility into the current state of a memory grant feedback operation for both row and batch mode.

Memory grant feedback doesn't require the Query Store, however, the persistence improvements introduced in SQL Server 2022 require the Query Store to be enabled for the database and in a "read write" state. 

Starting with row mode memory grant feedback, two new query plan attributes is shown for actual post-execution plans: IsMemoryGrantFeedbackAdjusted and LastRequestedMemory, which are added to the MemoryGrantInfo query plan XML element.

 - The LastRequestedMemory attribute shows the granted memory in Kilobytes (KB) from the prior query execution.
 - The IsMemoryGrantFeedbackAdjusted attribute allows you to check the state of memory grant feedback for the statement within an actual query execution plan.

<!-- 5. Chunked content-------------------------------------------------------------------------------------

    Goal: Provide all the information the learner needs to perform this sub-task.

    Structure: Break the content into 'chunks' where each chunk has three things:
        1. An H2 or H3 heading describing the goal of the chunk
        2. 1-3 paragraphs of text
        3. Visual like an image, table, list, code sample, or blockquote.

    [Learning-unit structural guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-structure-learning-content?branch=main)
-->

<!-- Pattern for simple chunks (repeat as needed) -->


<!-- Pattern for complex chunks (repeat as needed) -->


<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->