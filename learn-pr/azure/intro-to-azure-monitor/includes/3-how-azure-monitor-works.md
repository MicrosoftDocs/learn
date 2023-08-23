Your application might use several resources and services, like virtual machines (VMs), databases, web hosting services, and a payment gateway. In this unit, you learn about three key Azure Monitor features that are essential for understanding the health, behavior, and performance of all your Azure applications, resources, networks, and infrastructure.

Azure Monitor Metrics and Azure Monitor Logs provide two types of data that are essential for understanding all application and resource behavior and performance. Application Insights provides application performance monitoring (APM).

## Azure Monitor Metrics

Metrics are quantitative measurements that provide snapshots of application or resource performance. Metrics are typically numeric values that you can measure over time.

Metrics can monitor various aspects of an application or resource, such as resource utilization, response times, error rates, and throughput. Common examples of metrics include CPU usage, memory usage, network latency, and transaction rates.

Metrics are well-suited for real-time monitoring, and you can use metrics to trigger alerts when defined thresholds are reached.

Azure Monitor Metrics collects multiple types of metrics, including:

- Metrics from Azure resources.
- Custom metrics from various sources, including applications and agents running on VMs.
- Prometheus metrics collected from Kubernetes clusters, such as Azure Kubernetes Service (AKS) clusters. These metrics use industry standard tools, such as PromQL and Grafana, for analyzing and alerting.

Give examples of resources [maybe even just screenshots of the three types of metrics above]

You can use Metrics Explorer to interactively analyze the data in your metric database and chart the values of multiple metrics over time. Pin the charts to a dashboard to view them with other visualizations.
 
[See Get started with Azure Monitor metrics explorer - Azure Monitor | Microsoft Learn]

## Azure Monitor Logs

Logs are textual records of events, actions, and messages that occur in a resource or application. While metrics are numeric, logs can include the following data:

- **Text:** Human-readable text entries that provide context, details, and descriptions of events.
- **Unstructured data:** Log entries in various formats that don't fit neatly into predefined numerical values.
- **Contextual information:** Insights into the context surrounding an event, which is invaluable for root cause analysis.

Logs can capture information about errors, warnings, user actions, and application state changes. Logs provide detailed narratives of events in a given context, making them crucial for troubleshooting, debugging, and understanding event sequences that lead to issues. Logs are essential for retrospective analysis of issues, helping to reconstruct the chain of events that led up to a problem.

You can use Azure Monitor Logs to collect and organize the log and performance data from all the resources that Azure Monitor monitors. To collect and analyze all your data, you set up a workspace called a Log Analytics workspace, and configure your resources to send their data to that workspace.

Once you configure the workspace and start logging data, you can use Azure Monitor Logs to explore and analyze the data. You can work with log queries and their results interactively by using the Log Analytics user interface.

You can use Azure Monitor Log queries in the following scenarios:

- Use a simple query to answer a common question.
- Do complex data analysis to identify critical patterns in your monitoring data.
- Use queries in alert rules to be proactively notified of issues.
- Visualize query results in a workbook or dashboard.

## Application Insights

The Application Insights feature of Azure Monitor can provide application performance monitoring (APM) from app development, through test, and into production. You can *proactively* monitor to see how well an application is performing, and *reactively* review application execution data to find the cause of an incident.

Along with collecting metrics and telemetry data that describe application activities and health, you can use Application Insights to collect and store application *trace logging* data. The log trace is associated with other telemetry to give a detailed view of activity. To add trace logging to existing applications, you only need to provide a destination for the logs. You seldom need to change the logging framework.

Application Insights supports distributed tracing, which is also known as distributed component correlation. This feature allows searching for and visualizing the end-to-end flow of a specific execution or transaction. The ability to trace activity from end to end is important for applications built as distributed components or microservices.

Application Insights also has the following features and abilities:

- **Live metrics** observe activity from your deployed application in real time with no effect on the host environment.
- **Availability monitoring**, also known as *synthetic transaction monitoring*, probes the external endpoints of your applications to test overall availability and responsiveness over time.
- **Usage monitoring** helps you understand which features are popular with users and how users interact and use your application.
- **Smart detection** detects failures and anomalies automatically through proactive telemetry analysis.
- **Application Map** is a high-level, top-down view of your application architecture with at-a-glance visual references to component health and responsiveness.

