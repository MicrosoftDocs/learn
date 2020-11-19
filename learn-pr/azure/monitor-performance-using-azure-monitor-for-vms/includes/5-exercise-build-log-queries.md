
In the previous units, remember you need to explore Azure native monitoring tools for resources deployed in Azure. To further your knowledge, you'll need to know how to use, adjust, and create log queries.

In this unit, you'll:

1. Take an existing query, run the query, and analyze the visualizations.
1. Adjust the existing query and analyze the visualizations.

## Build a query using the query pane

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), search for and select **Log Analytics workspaces**.

1. Under **General**, select **Logs**.

1. If you're reusing queries or storing them in source control, you'll want to let an engineer or administrator know how to use the query. Commenting out a helpful description is done by using // before guiding how to use the query.

    :::image type="content" source="../media/5-commenting-on-query.png" alt-text="Showcasing how to comment out text that helps guide engineers or administrators who may reuse the query.":::

1. Select **Queries** from the upper left of the logs editor to use an example query.

    :::image type="content" source="../media/4-queries-logs-pane.png" alt-text="Screen shot showing where to select Queries from within the logs pane." lightbox="../media/4-queries-logs-pane.png":::

1. Ensure you remove the **Log Analytics workspaces** filter at the top and select **Virtual Machine Scale Sets** on the far left, underneath **All Queries**.

1. Select the **Chart CPU usage trends by computer** query.

     :::image type="content" source="../media/5-cpu-usage-trends.png" alt-text="Screenshot showing what query to select." lightbox="../media/5-cpu-usage-trends.png":::

1. Select **Run**.

1. Examine the query in the editor after it runs and read through the comments that indicate what the query extracts.

1. The query will look like this:

    ```kusto
    // Chart CPU usage trends by computer 
    // Calculate CPU usage patterns over the last hour, chart by percentiles.
    InsightsMetrics
    | where TimeGenerated > ago(1h)
    | where Origin == "vm.azm.ms"
    | where Namespace == "Processor"
    | where Name == "UtilizationPercentage"
    | summarize avg(Val) by bin(TimeGenerated, 5m), Computer //split up by computer
    | render timechart
    ```

1. You'll see a timechart visualization of average CPU usage over the course of the past hour.

    :::image type="content" source="../media/5-cpu-trends-timechart.png" alt-text="Screenshot showing utilization percentage for the processor namespace." lightbox="../media/5-cpu-trends-timechart.png":::

1. As the screenshot highlights, this query takes data from the InsightsMetrics table, looks at all data ingested over the last hour underneath the Processor Namespace, and summarizes the results in an easy to read visualization.

## Adjust existing query and analyze results

1. Let's take the existing query you just used and edit a few pieces to build a different data visualization. Instead of **summarize avg(val)**, change that to **summarize arg_max(TimeGenerated, *)**.

1. From there, leave everything else the same. The visualization and query will will look like this:
        :::image type="content" source="../media/5-cpu-trends-arg-max.png" alt-text="Screenshot showing arg_max operator vs. average." lightbox="../media/5-cpu-trends-arg-max.png":::

    ```kusto
    // Chart CPU usage trends by computer 
    // Calculate CPU usage patterns over the last hour, chart by percentiles.
    InsightsMetrics
    | where TimeGenerated > ago(1h)
    | where Origin == "vm.azm.ms"
    | where Namespace == "Processor"
    | where Name == "UtilizationPercentage"
    | summarize arg_max(TimeGenerated, *) by bin(TimeGenerated, 5m), Computer //split up by computer
    | render timechart
    ```
    :::image type="content" source="../media/5-cpu-trends-arg-max.png" alt-text="Screenshot showing arg_max operator vs. average." lightbox="../media/5-cpu-trends-arg-max.png":::

1. The difference between these two queries is the first query takes average CPU readings over the course of 1 hour and the second query uses arg_max, which is an aggregation function that returns the latest data over the course of the past hour.

1. Each of these visualizations can be pinned to a dashboard by selecting **Pin to dashboard** at the top and then specify the following details:

    - Create a new dashboard or add to an existing dashboard.
    - If existing, deploy the new visualization to the right shared or private dashboard.
    - If new, determine if the dashboard will be a private or shared dashboard.
    - If new, name the dashboard.
    - If new, specify where the dashboard will be deployed.