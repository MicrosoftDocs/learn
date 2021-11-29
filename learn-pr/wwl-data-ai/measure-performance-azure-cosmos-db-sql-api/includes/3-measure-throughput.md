Azure Monitor for Azure Cosmos DB provides the **Total Request Units** metric that can be used to analyze the request units consumed by the different Azure Cosmos DB operations. This metric can then be used to analyze those operations with the highest throughput.

Monitoring this metric, allows us to: 

- Identify operations that are consuming more request units than others. 
- Identify operations that are taking more cumulative request units in a given interval of time.

By identifying the operations with higher throughput, we can for example:
- Determine if these operations are insert and upserts, their index definition can be reviewed for over or under indexing-specific fields. We can then determine if we should include or exclude paths in their indexing policy.
- Modify the query to use and index with a filter clause.
- Use partition keys that will minimize the fan out of query into different partitions.
- If possible, evaluate if a smaller result set would meet the query needs.

## View the Total Request Unit metrics

To view the **Total Request Units** metric, under Azure Monitor's Metrics
1. Select the *Resource Type* **Azure Cosmos DB accounts** and **Apply** in the scope dialog.
1. Select the correct **Azure Cosmos DB account** from the drop-down list.
1. Under Metrics, select **Total Request Units** and the type of aggregation you need.
1. If needed, refine the **Time range** and **Time granularity** of the metric.

:::image type="content" source="../media/3-monitor-total-request-units.png" alt-text="Diagram that shows the options to monitor Total Request Units in Azure Cosmos DB." lightbox="../media/3-monitor-total-request-units.png":::

## Filter the Total Request Units further

By default, Azure Monitor will display the overall throughput of all Azure Cosmos DB operations the selected account does.  To better analyze the throughput, more granular filtering will be needed to find aggregate usage of the individual operation types or to further compare the usage of multiple operation types at the same time. Using the **Add filter** and **Apply splitting** options will help us with those analyses.

Azure Monitor allows us to filter further by specific **CollectionName**, **DatabaseName**, **OperationType**, **Region**, **Status**, and **StatusCode**.  For example, we could add a filter by operation type to see the usage of our different Azure Cosmos DB operations.

:::image type="content" source="../media/3-monitor-total-request-units-filter.png" alt-text="Diagram that shows the options to filter the monitoring of Total Request Units in Azure Cosmos DB." lightbox="../media/3-monitor-total-request-units-filter.png":::
