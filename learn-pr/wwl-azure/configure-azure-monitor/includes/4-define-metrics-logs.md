All data collected by Azure Monitor fits into one of two fundamental types, [metrics and logs](/azure/azure-monitor/platform/data-collection):

**Metrics** are numerical values that describe some aspect of a system at a particular point in time. Metrics are lightweight and capable of supporting near real-time scenarios.

**Logs** contain different kinds of data organized into records with different sets of properties for each type. Data like events and traces are stored as logs along with performance data so all the data can be combined for analysis.

### Things to know about Azure Monitor metrics

Let's examine how to work with Azure Monitor metrics in the Azure portal.

- For many Azure resources, the metrics data collected by Azure Monitor is displayed on the **Overview** page for the resource in the Azure portal. Consider the overview for an Azure virtual machine that has several charts that show performance metrics.

- You can use Azure Monitor **metrics explorer** to view the metrics for your Azure services and resources.

- In the Azure portal, select any graph for a resource to open the associated metrics data in metrics explorer. The tool lets you chart the values of multiple metrics over time. You can work with the charts interactively or pin them to a dashboard to view them with other visualizations.

:::image type="content" source="../media/monitor-data-platform-7dbebda9.png" alt-text="Illustration that depicts Azure Monitor metrics data graphs providing information to Metric Analytics in the Azure portal." border="false":::

### Things to know about Azure Monitor Logs

You can also work with Azure Monitor Logs (Log Analytics) in the Azure portal. Let's review the details.

- In the Azure portal, log data collected by Azure Monitor is stored in Log Analytics.

- Log Analytics includes a [rich query language](/azure/azure-monitor/log-query/log-query-overview) to help you quickly retrieve, consolidate, and analyze your collected data.

- You can work with Log Analytics to create and test queries. Use the query results to directly analyze the data, save your queries, visualize the data, and create alert rules.

- Azure Monitor uses a version of the [Data Explorer](/azure/kusto/query/) query language. The language is suitable for simple log queries, but also includes advanced functionality like aggregations, joins, and smart analytics. You can quickly learn the query language by completing several available lessons. Particular guidance is provided for users familiar with SQL and Splunk.

:::image type="content" source="../media/log-data-32e50eae.png" alt-text="Illustration that depicts an Azure Monitor Logs database providing information to Log Analytics in the Azure portal." border="false":::