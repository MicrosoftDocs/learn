
Using workbooks, you can write queries that extract data from different types of data sources. Each data source and result set support visualizations that are most useful for that data. Although different data sources return data sets with different structures, workbooks are able to interpret the data, and create charts and visualizations to help you analyze the data.

In this tutorial,
- We're going to query **Azure Resource Health** to easily see service issues affecting your resources. We'll group the resources that are experiencing issues and the resources that aren't experiencing issues, so that you can easily see what needs intervention.
- We're going to use **Azure Monitor Metrics** which use numeric data collected at regular intervals to measure a specific aspect of a system at a particular time. We'll create a chart that displays important metrics, such as CPU usage, failed requests, or available memory.

We'll display the results using chart and  graph visualizations. We'll also use the options for rendering the visualizations to make them easily readable and user-friendly.
Keep in mind that the data sources in this tutorial are just two examples of data sources you can include in your workbooks.

## Azure resource health
Workbooks support getting Azure resource health and combining it with other data sources to create rich, interactive health reports. When you use an Azure resource health data source, you can use the health filter dropdowns to select the subset of resource issues for your analytic needs.

:::image type="content" source="../media/resource-health.png" alt-text="Screenshot that shows an alerts query that shows the health filter lists.":::

## Azure Monitor metrics
Azure resources emit metrics. Using the Workbooks metrics control, you can specify the target resources, the desired metrics, and their aggregation. You can then plot the data in charts or grids.

:::image type="content" source="../media/metrics.png" alt-text="Screenshot that shows a workbook metrics interface.":::

:::image type="content" source="../media/metrics-graph.png" alt-text="Screenshot that shows workbook metrics charts of CPU utilization.":::

