
In the previous units, remember you need to explore Azure native monitoring tools for resources deployed in Azure. To further your knowledge, you'll need to know how to use, adjust, and create log queries.

In this unit, you'll:

1. Take an existing query, run the query, and analyze the visualizations.
1. Adjust the existing query and analyze the visualizations.

## Build a query using the query pane

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), search for and select **Log Analytics workspaces**.

1. Under **General**, select **Logs**. The Queries page should open. If it doesn't, from the top left of the logs editor, select **Queries**.

    :::image type="content" source="../media/4-queries-logs-pane.png" alt-text="Screen shot showing where to select Queries from within the logs pane." lightbox="../media/4-queries-logs-pane.png":::

1. Clear the **Log Analytics workspaces** filter at the top.

    :::image type="content" source="../media/5-clear-log-analytics-filter.png" alt-text="Screen shot of clearing Log Analytics workspaces filter.":::

1. Select **Virtual Machine Scale Sets** on the far left, underneath **All Queries**.

    :::image type="content" source="../media/5-virtual-machine-scale-set-queries.png" alt-text="Screen shot of Virtual Machine Scale Set queries.":::

1. Select the **Chart CPU usage trends by computer** query.

     :::image type="content" source="../media/5-cpu-usage-trends.png" alt-text="Screenshot showing what query to select." lightbox="../media/5-cpu-usage-trends.png":::

1. Select **Run**.

1. Examine the query in the editor after it runs and read through the comments that indicate what the query extracts. 

1. Review the visualization. This query takes data from the InsightsMetrics table, looks at all data ingested over the last hour underneath the Processor Namespace, and summarizes CPU averages for both virtual machines in an easy to read visualization.

    :::image type="content" source="../media/5-cpu-trends-timechart.png" alt-text="Screenshot showing utilization percentage for the processor namespace." lightbox="../media/5-cpu-trends-timechart.png":::

## Adjust existing query and analyze results

Let's take the existing query you just used and edit a few pieces to build a different data visualization.

1. Change line 8 from **summarize avg(val)** to **summarize arg_max(TimeGenerated, *)**.

1. Select **Run**. 

1. Review the visualization. This revised query takes data from the InsightsMetrics table, looks at all data ingested over the last hour underneath the Processor Namespace, and uses arg_max, which is an aggregation function that returns the latest data over the course of the past hour.
    :::image type="content" source="../media/5-cpu-trends-arg-max.png" alt-text="Screenshot showing arg_max operator vs. average." lightbox="../media/5-cpu-trends-arg-max.png":::

    Each of these visualizations can be pinned to a dashboard by selecting **Pin to dashboard** at the top and then specify the following details:

    - Create a new dashboard or add to an existing dashboard.
    - If existing, deploy the new visualization to the right shared or private dashboard.
    - If new, determine if the dashboard will be a private or shared dashboard.
    - If new, name the dashboard.
    - If new, specify where the dashboard will be deployed.