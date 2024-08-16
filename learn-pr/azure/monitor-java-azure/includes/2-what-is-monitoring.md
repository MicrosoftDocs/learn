In this unit, we look at monitoring Java application concepts.

## Why Monitoring?

In any environment, it's important to track the way in which people use your system, trace resource usage, and generally monitor your system's health and performance. You can use this information as a diagnostic aid to detect and correct issues, and also to help spot potential problems and prevent them from occurring.

## Monitoring forms

Monitoring generally takes on four forms:

- **Logs**: Permanent, immutable records of events stored in a consistent, tabular format, if not in a full database. An *event* might be indicative of one of many conditions, including:

  - A change in a monitored component's status (for example, from "busy" to "available").
  - Completing a task or sequence of instructions.
  - A milestone in the progression of data through a network, or the availability of units in a network.
  - An error, which in this context is a behavior that the system or application hasn't been programmed to handle or mitigate.

- **Metrics** : Values that represent the relative health, stability, and availability of a service or application or the infrastructure that hosts it.

- **Traces** : Records of the paths of execution for programs and services, especially in a highly distributed system, indicating the sequence of instructions that might have triggered—either directly or indirectly—an event.

- **Alerts**: Alerts proactively notify you when issues are found with your infrastructure or application. They allow you to identify and address issues before the users of your system notice them.

## Azure Monitoring Platforms

Azure provides **Azure Monitor**, which includes a set of services that developers and administrators can use to collect, analyze, and act upon telemetry about the performance of applications and the infrastructure that hosts them.

**Log Analytics** is a tool in the Azure portal to edit and run log queries from data Azure Monitor Logs collects, and to interactively analyze their results. You can use Log Analytics queries to retrieve records matching particular criteria, identify trends, analyze patterns, and provide various insights into your data.

**Application Insights**, a feature of Azure Monitor, is an extensible Application Performance Management (APM) service for developers and DevOps professionals. It automatically detects performance anomalies, and includes analytics tools to help you diagnose issues and to understand what users actually do with your app.

**Azure Monitor alerts**: Monitoring data might also be sent to other locations to support certain scenarios, and some resources might write to other locations before they can be collected into Logs or Metrics.

- Metric alerts provide an alert trigger when a specified threshold is exceeded. For example, a metric alert can notify you when CPU usage is greater than 95 percent.
- Log alerts are based on data written to log files. For example, a log alert can notify you when a web server has returned many 404 or 500 responses.

You can monitor Azure applications, services, and infrastructure using any monitoring systems of your choice, such as Elastic Stack, Splunk, New Relic, Dynatrace, and App Dynamics. In this module, though, we'll focus on Azure Monitor, Log Analytics, and Application Insights.
