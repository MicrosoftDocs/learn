Azure Monitor is a tool for collecting and analysing telemetry allowing maximum performance and availability on your cloud and on on-premises resources and applications. Its purpose is to show you how your applications are performing as well as identifying any issues regarding them.

## How Log data is collected by Azure Monitor

The following diagram gives a high-level view of Azure Monitor. At the center of the diagram are the data stores for metrics and logs, which are the two fundamental types of data use by Azure Monitor. On the left are the sources of monitoring data that populate these data stores. On the right are the different functions that Azure Monitor performs with this collected data such as analysis, alerting, and streaming to external systems.

![Screenshot of the Azure Monitor.](../media/2-azure-monitor.png)

All data collected by Azure Monitor fits into one of two fundamental types, metrics and logs. Activity Logs record when resources are created or modified. Metrics tell you how the resource is performing and the resources that it's consuming

Logs contain different types of data which is then organized into records with different sets of properties for each type. The Logs can include numeric values such as Azure Monitor Metrics but the majority include text data rather than numeric.

The most common type of log entry is an event, collected sporadically, which means irregular intervals. An application or service with include enough information to provide enough context are the ones who create the events. Metric data can be stored in Logs to combine them with other monitoring data for other data analysis.

To retrieve, consolidate and analyse data, data in Azure Monitor Logs retrieves it using a log query written with the Kusto query language. Log queries can be tested in the Azure Portal so you can work with them interactively.

Logs are events that occur within the system they provide information to provide complete context of the issue being identified and are valuable for identifying root case of issues. They can contain different kinds of data with a timestamp. Azure Data Explorer store the Logs in Azure Monitor on a Log Analytical workspace. It provides an analysis engine and rich query language. The Logs are used to show enough context of the issue being identified and are very useful for identifying the root case of the any problems.

## Metrics

Metrics are numerical values that describe some aspect of a system at a particular point in time. They are lightweight and capable of supporting near real-time scenarios. They are collected at regular intervals and are useful for alerting due to their frequent sampling. With a variety of algorithms, metrics can be compared to other metrics to observe analysis and trends over time.

Metrics are stored in a time-series database which is most effective for analyzing time stamped data. This makes metrics particularly suited for alerting and fast detection of issues. They can tell you about system performance but if they needed can be combined with logs
to identify the root cause of issues.

Azure Monitor uses a version of the **Kusto** query language used by **Azure Data Explorer** to retrieve and analyze log data in a variety of ways. You'll typically start with basic queries and then progress to use more advanced functions as your requirements become more complex.

The operations team can consolidate their data by visualizing monitoring data such as charts and tables which are effective tools for summarizing data nd presenting it to different audiences.
The use of Azure Dashboards allow you to combine different kinds of data, including both logs and metrics, into a single paine in the Azure portal. For example you may wish to create a dashboard that combines tiles that show a graph of metrics, a table of activity logs, charts from Application Insights and the output of a log query.

## Quick quiz

- content: "What data does Azure Monitor collect?"
    choices:
  - content: "To help monitor database performance."
      isCorrect: true
      explanation: "In the Azure portal, you can monitor an individual databases utilization by selecting your database and clicking the Monitoring chart. This brings up a Metric window that you can change by clicking the Edit chart button"
    - content: "Azure Monitor can collects tiers of data monitoring from a variety of sources."
      isCorrect: true
      explanation: "Azure Monitor helps you understand how your applications are performing and proactively identifies issues affecting them and the resources they depend on"
    - content: "Authentication and Authorization."
      isCorrect: false
      explanation: "Azure Monitor can collect information regarding application monitoring, performance and functionality."

  - content: "What two fundamental types of data are collected by Azure Monitor?"
    choices:
    - content: "Logs and Metrics"
      isCorrect: True
      explanation: "All data collected by Azure Monitor fits into one of two fundamental types, metrics and logs. Metrics are numerical values that describe some aspect of a system at a particular point in time. Logs contain different kinds of data organized into records, such as events"
    - content: "Username and password"
      isCorrect: false
      explanation: "Azure Monitor collects and aggregates data from a variety of sources into a common data platform where it can be used for analysis."
    - content: "Email notifications and Errors"
      isCorrect: false
      explanation: "Use Azure Monitor to send an Email Notifications for Azure Security Center Alerts. Azure Security Center allows you to provide a security contact that will receive email notifications for Security Alerts."
