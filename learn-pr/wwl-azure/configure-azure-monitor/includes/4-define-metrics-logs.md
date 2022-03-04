All data collected by Azure Monitor fits into one of two fundamental types, [metrics and logs](/azure/azure-monitor/platform/data-collection).

 -  **Metrics** are numerical values that describe some aspect of a system at a particular point in time. They are lightweight and capable of supporting near real-time scenarios.
 -  **Logs** contain different kinds of data organized into records with different sets of properties for each type. Data such as events and traces are stored as logs in addition to performance data so that it can all be combined for analysis.

## Metrics

For many Azure resources, the data collected by Azure Monitor is displayed on the Overview page in the Azure portal. For example, virtual machines have several charts displaying performance metrics. Click on any of the graphs to open the data in Metric explorer in the Azure portal, which allows you to chart the values of multiple metrics over time. You can view the charts interactively or pin them to a dashboard to view them with other visualizations.

:::image type="content" source="../media/monitor-data-platform-7dbebda9.png" alt-text="Screenshot of the metric analytics page.":::


## Logs

Log data collected by Azure Monitor is stored in Log Analytics which includes a [rich query language](/azure/azure-monitor/log-query/log-query-overview) to quickly retrieve, consolidate, and analyze collected data. You can create and test queries using the Log Analytics page in the Azure portal. You can use the query results to directly analyze the data. save queries, visualize the data, or create alert rules.

Azure Monitor uses a version of the [Data Explorer](/azure/kusto/query/) query language that is suitable for simple log queries but also includes advanced functionality such as aggregations, joins, and smart analytics. You can quickly learn the query language using multiple lessons. Particular guidance is provided to users who are already familiar with SQL and Splunk.

:::image type="content" source="../media/log-data-32e50eae.png" alt-text="The logs database is shown providing information to the log analytics page.":::
