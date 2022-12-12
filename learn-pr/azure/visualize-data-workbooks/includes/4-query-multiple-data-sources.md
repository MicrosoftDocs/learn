
Using workbooks, you can write queries that extract data from different types of data sources. Each data source and result set support visualizations that are most useful for that data. Although different data sources return data sets with different structures, workbooks are able to interpret the data and use to create readable charts and visualizations so that you can analyze the data.

In this tutorial,
- We are going to query **Azure Resource Health** to easily see service issues affecting your resources. We will group the resources that are experiencing issues and those that are not so that you can easily see what needs intervention.
- We are going to use **Azure Monitor Metrics** which use numeric data collected at regular intervals to measure a specific aspect of a system at a particular time. We will create a chart that displays important metrics, such as CPU usage, failed requests, or available memory.

We will display the results using chart and  graph visualizations. We will also use the options for rendering the visualizations to make them easily readable and user-friendly.
Keep in mind that these are just two examples of data sources you can include in your workbooks.

## Azure resource health
Workbooks support getting Azure resource health and combining it with other data sources to create rich, interactive health reports. When you use an Azure resource health data source, you can use the health filter dropdowns to select the subset of resource issues for your analytic needs.

![Screenshot that shows an alerts query that shows the health filter lists.](./media/workbooks-data-sources/resource-health.png)

## Azure Monitor metrics
Azure resources emit [metrics](../essentials/data-platform-metrics.md). The metrics control that allows you to specify the target resources, the desired metrics, and their aggregation. You can then plot this data in charts or grids.

![Screenshot that shows workbook metrics charts of CPU utilization.](./media/workbooks-data-sources/metrics-graph.png)

![Screenshot that shows a workbook metrics interface.](./media/workbooks-data-sources/metrics.png)

- We are going to query **Azure Resource Health** to easily see service issues affecting your resources. We will group the resources that are experiencing issues and those that are not so that you can easily see what needs intervention.
- We are going to use **Azure Monitor Metrics** which use numeric data collected at regular intervals to measure a specific aspect of a system at a particular time. We will create a chart that displays important metrics, such as CPU usage, failed requests, or available memory.
