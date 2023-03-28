Use Azure Monitor when you need to collect, analyze, and act on availability, health, and performance telemetry for your applications and infrastructure resources. IT Ops, DevOps, and developer teams can use Azure Monitor for day-to-day operations, continuous monitoring, pre-production, and development phases of the app lifecycle.

Users can take advantage of **Azure Monitor Insights** for at-scale monitoring views to track performance across multiple resources and start investigations by drilling into the details of a single resource.

Users can share reports with **Azure Monitor** workbooks and maintain operational awareness with dashboards.

Users can investigate and perform triage using custom charts in Metrics Explorer and analyze logs with queries in **Azure Monitor Logs**.

Users can be notified, take action, and scale their workloads in response to user-defined performance criteria or machine learning based thresholds.

Here, we'll discuss some examples of when you might want to use Azure Monitor to:

* View data in Azure Monitor Metrics.
* Analyze logs in Azure Monitor Logs.

## Decision criteria

Azure Monitor Metrics allows you to view time-series data in near real time and retains data for up to three months. If you want to store data for long-term evaluation up to two years and perform more complex analysis, you can use a Log Analytics Workspace to store the recorded data.

Let's look at some of the different mechanisms for monitoring and viewing your Azure resources.

| Monitoring Option | Usage |
| --- | --- |
| Metrics | Numerical values that describe some aspect of a system at a particular point in time. |
| Logs | Log data collected by Azure Monitor for analysis. |
| Visualizations | Azure Monitor has its own features for visualizing monitoring data and uses other Azure services for publishing it to different audiences. Azure dashboards allow you to combine different kinds of data into a single pane in the Azure portal. Workbooks provide a flexible canvas for data analysis and creating rich visual reports in the Azure portal. |

### Metrics

Metrics are numerical values that describe some aspect of a system at a particular point in time. They are lightweight and capable of supporting near-real-time scenarios. The metrics explorer is built into the Azure portal, allowing you to focus on a specific resource to monitor. Data is presented in a chart or graph format.

:::image type="content" source="../media/metrics.png" alt-text="Depiction of a metrics data element feeding values into a chart available in the Azure portal under the Monitoring category for many resources.":::

### Logs

You can analyze log data collected by Azure Monitor with queries to quickly retrieve, consolidate, and analyze collected data. You can create and test queries using Log Analytics in the Azure portal. You can then either directly analyze the data using different tools or save queries for use with visualizations or alert rules.

Azure Monitor uses a version of the Kusto query language that's suitable for simple log queries, but also includes advanced functionality such as aggregations, joins, and smart analytics.

:::image type="content" source="../media/logs.png" alt-text="Depiction of log data feeding into a table display in Log Analytics.":::

### Visualizations

Many times, you might find the need to report on the specific metrics that are measured. Azure Monitor provides two main visualizations in the form of Azure dashboards and workbooks. You can make use of these two features to present a visual report to management or other interested parties for ease of consuming the monitored data.

## Apply the criteria

### Should you use metrics explorer for monitoring?

Recall that Azure Metrics uses numerical data to display information about your monitored resource. You can select the **Metrics** option under the **Monitoring** category for a resource. This option presents a chart that allows you to select a parameter to track. You'll also notice various charts displayed on the **Overview** page. Selecting a chart opens it in the Metrics Explorer.

:::image type="content" source="../media/metrics-explorer.png" alt-text="Screenshot of the Metrics Explorer window showing the Data Out values in the sum aggregation.":::

### Should you use logging with your monitoring tasks?

Recall that you can analyze log data collected by Azure Monitor with queries to quickly retrieve, consolidate, and analyze collected data. While you'll need to have a Log Analytics workspace to store the log data, the ability to query this data for insights can be a great way to perform more complex and detailed analysis. It can help identify trends or to review when an event happened, and perhaps identify the root cause.

### Should you use visualizations in monitoring your resources?

The dashboards and workbooks are a great way to present the monitored data to various users in ways that are appropriate for the audience. Visualizations are also a great way to aggregate various monitored data points into a single dashboard for ease of use and comparisons.
