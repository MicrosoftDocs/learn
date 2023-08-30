Your Azure applications and infrastructure might use several resources and services, like virtual machines (VMs), databases, web hosting services, and payment gateways. In this unit, you learn about the key Azure Monitor features that monitor the health, behavior, and performance of your Azure applications, networks, and infrastructure.

Azure Monitor provides two types of data that are essential for understanding application and resource behavior and performance: Azure Monitor Metrics and Azure Monitor Logs.

## Azure Monitor Metrics

Metrics are quantitative measurements that show snapshots of application or resource performance. Metrics are typically numeric values that you can measure over time.

Metrics can monitor various aspects of an application or resource, such as resource utilization, response times, error rates, and throughput. Common examples of metrics include CPU usage, memory usage, network latency, and transaction rates.

A list of resource-specific metrics is automatically available for each resource type in your Azure subscription. You can use the Azure Monitor Metrics Explorer to interactively analyze the data in your metrics database and chart the values of multiple metrics over time.

To see the metrics for any resource in the Azure portal, select **Metrics** under **Monitoring** in the left navigation on that resource's page. Then select the metric you need from the **Metric** dropdown. You can pin the charts to a dashboard to view them with other visualizations.

For example, the following **Requests** metric line chart shows the sum aggregation of requests for the **Contoso-web-sales** application.

:::image type="content" source="../media/web-app-metrics.png" alt-text="Screenshot of the Monitoring option selected in the Azure portal for a web app, showing chart of requests for the web app." lightbox="../media/web-app-metrics.png":::

Azure Monitor Metrics can collect several types of metrics, including:

- **Azure platform metrics.** Azure Monitor starts collecting metrics data from Azure resources as soon as they're added to a subscription. A list of resource-specific metrics is automatically available for each Azure resource type.
- **Custom metrics**. Azure Monitor can also collect metrics from other sources, including applications and agents running on VMs. You can send custom metrics to Azure Monitor via the Azure Monitor Agent, other agents and extensions, or directly to the Azure Monitor REST API.
- **Prometheus metrics**. Azure Monitor managed service for Prometheus collects metrics from Azure Kubernetes Service (AKS) or other Kubernetes clusters. Prometheus metrics share some characteristics with platform and custom metrics, but have different features to support open-source analysis and alerting tools like PromQL and Grafana.

Metrics are well-suited for real-time monitoring. You can use metrics to trigger alerts when defined thresholds are reached.

## Azure Monitor Logs

Logs are textual records of events, actions, and messages that occur in a resource or application. While metrics are numeric, logs can include the following data:

- **Text:** Human-readable text entries that provide context, details, and descriptions of events.
- **Unstructured data:** Log entries in various formats that don't fit neatly into predefined numerical values.
- **Contextual information:** Insights into the context surrounding an event, which is invaluable for root cause analysis.

Logs can capture information about errors, warnings, user actions, and application state changes. Logs provide detailed narratives of events in a given context, making them crucial for troubleshooting, debugging, and understanding event sequences that lead to issues. Logs are essential for retrospective analysis of issues, helping to reconstruct the chain of events that led up to a problem.

You can use Azure Monitor Logs to collect and organize the log and performance data from all the resources that Azure Monitor monitors. To collect and analyze all your data, you set up a workspace called a Log Analytics workspace. You configure your resources to send their data to that workspace.

Once you configure the workspace and start logging data, you can use Azure Monitor Logs to explore and analyze the data. You can work with log queries and their results interactively in the Log Analytics user interface.

You can use Azure Monitor Log queries in the following scenarios:

- Use a basic query to answer a common question.
- Do complex data analysis to identify critical patterns in your monitoring data.
- Use queries in alert rules to be proactively notified of issues.
- Visualize query results in a workbook or dashboard.

