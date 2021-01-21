
Remember from the previous units that you need to explore Azure native monitoring tools for resources deployed in Azure. To further your knowledge, you'll need to know how to use, edit, and create log queries.

In this unit, you'll:

1. Take an existing query, run the query, and analyze the visualizations.
1. Edit the existing query, run the query, and analyze the visualizations.

## Build a query by using the query pane

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), search for and select **Log Analytics Workspace**. Select **Create**.

1. Under **General**, select **Logs**. The **Queries** page should open. If it doesn't, in the upper-right corner of the logs editor, select **Queries**.

    :::image type="content" source="../media/4-queries-logs-pane.png" alt-text="Screenshot showing where to select Queries from within the log editor pane." lightbox="../media/4-queries-logs-pane.png":::

1. Clear the **Log Analytics workspaces** filter at the top.

    :::image type="content" source="../media/5-clear-log-analytics-filter.png" alt-text="Screenshot of where to clear Log Analytics workspaces filter." lightbox="../media/5-clear-log-analytics-filter.png":::

1. Select **Virtual Machine Scale Sets** on the far left, under **All Queries**.

    :::image type="content" source="../media/5-virtual-machine-scale-set-queries.png" alt-text="Screenshot of Virtual Machine Scale Set queries." lightbox="../media/5-virtual-machine-scale-set-queries.png":::

1. Select the **Chart CPU usage trends by computer** query.

     :::image type="content" source="../media/5-cpu-usage-trends.png" alt-text="Screenshot showing what query to select for charting CPU trends." lightbox="../media/5-cpu-usage-trends.png":::

1. Select **Run**.

1. Examine the query in the editor after it runs. Read through the comments that indicate what the query extracts.

1. Review the visualization. This query:
    1. Takes data from the InsightsMetrics table.
    1. Looks at all data values ingested over the last hour underneath the Processor namespace.
    1. Returns the rounded average value in 5-minute intervals for both machines.

    :::image type="content" source="../media/5-cpu-trends-timechart.png" alt-text="Screenshot showing average value for CPU usage trends." lightbox="../media/5-cpu-trends-timechart.png":::

## Edit the existing query and analyze the results

Let's take the query you just used and make an edit to build a different data visualization.

1. Change line 8 from **summarize avg(Val)** to **summarize max(Val)**.

1. Select **Run**.

1. Review the visualization. This edited query:
    1. Takes data from the InsightsMetrics table.
    1. Looks at all data values ingested over the last hour underneath the Processor namespace.
    1. Returns the rounded maximum value in 5-minute intervals for both machines.
    :::image type="content" source="../media/5-cpu-trends-max.png" alt-text="Screenshot showing maximum value for CPU usage trends." lightbox="../media/5-cpu-trends-max.png":::

    Each of these visualizations can be pinned to a dashboard by selecting **Pin to dashboard** at the top. Then specify the following details:

    - Create a new dashboard, or add to an existing dashboard.
    - If existing, deploy the new visualization to the appropriate shared or private dashboard.
    - If new, determine if the dashboard will be a private or shared dashboard.
    - If new, name the dashboard.
    - If new, specify where the dashboard will be deployed.
