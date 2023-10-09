
Log Analytics is a tool for Azure Monitor that's available in the Azure portal. You can use Log Analytics to edit and run log queries for the data collected in Azure Monitor Logs. Log queries help you to search for patterns and identify issues.

:::image type="content" source="../media/log-analytics-38112dc9.png" alt-text="Screenshot that shows an example of Azure Monitor Logs in the Azure portal.":::

### Things to know about Log Analytics

Let's examine some characteristics of Log Analytics in Azure Monitor.

- Log Analytics in Azure Monitor offers query features and tools that help you answer virtually any question about your monitored configuration.

- Log Analytics supports the Kusto Query Language (KQL). You can create simple or complex queries with KQL, including:
   - Search and sort by value, time, property state, and more
   - Join data from multiple tables
   - Aggregate large sets of data
   - Perform intricate operations with minimal code

- When your Azure Monitor Logs contain sufficient collected data, and you understand how to construct the appropriate query, you can use Log Analytics to complete detailed analysis and problem solving.

### Things to consider when using Log Analytics

Some features in Azure Monitor, such as insights and solutions, process log data without exposing you to the underlying queries. To use other Azure Monitor features, you need to understand how to construct queries and apply them to interactively analyze data in Azure Monitor Logs. The following business scenarios showcase the advantages of querying Azure Monitor Logs with Log Analytics.

#### Business scenario: Assess update requirements and time-to-complete

An important daily task for IT admins is to assess system update requirements and plan for configuration patches. Accurate scheduling is critical because the patching process relates to SLAs to the business and can negatively affect business functions.

In the past, administrators had to schedule a patch update with only limited knowledge of how long it might take to complete the process. With an Azure subscription, admins can access benefits of the Microsoft Azure platform. Azure collects data from all customers performing patches. Azure uses the gathered data to provide an average patching time for specific updates.

This use of "crowd-sourced" data is unique to cloud systems. It's a great example of how Log Analytics in Azure Monitor can you help meet strict SLAs for your business.

#### Business scenario: Track changes and identify access issues

Troubleshooting an operational incident is a complex process that requires access to multiple data streams. By monitoring your systems from the Azure platform, you can easily perform analysis from multiple angles. You have access to data from a wide variety of sources through a single interface for correlation of information.

By tracking changes across the Azure environment, Log Analytics in Azure Monitor can help you easily identify common issues, such as:
- Abnormal behavior from a specific account
- Users installing unapproved software
- Unexpected system reboots or shutdowns
- Evidence of security breaches
- Specific problems in loosely coupled applications