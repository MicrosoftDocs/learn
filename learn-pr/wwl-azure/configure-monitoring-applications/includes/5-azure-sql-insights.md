Azure SQL Database and Azure SQL Managed Instance provide metrics, resource logs, and query-level monitoring to help you identify performance problems. SQL Insights retired on December 31, 2024, and is no longer supported, so use current monitoring and tuning tools instead.

## Monitor metrics and resource logs

You can quickly monitor various Azure SQL related resource metrics in the Azure portal in the Metrics view. These metrics enable you to see if a database is approaching the limits of CPU, memory, IO, or storage resources. High DTU, CPU or IO utilization may indicate that your workload needs more resources. It might also indicate that queries need to be optimized.

Configure Azure Monitor metric alerts to notify you when resource usage crosses a threshold. Use diagnostic settings to send supported metrics and resource logs to a Log Analytics workspace, Azure Storage, or Azure Event Hubs. In a Log Analytics workspace, you can query the exported data and analyze it alongside other application and infrastructure logs. Azure SQL Analytics also consumes diagnostic telemetry sent to Log Analytics.

The `SQLInsights` resource log category contains performance diagnostics from Intelligent Insights (preview). This log category is separate from the retired SQL Insights monitoring solution.

Use [Query Store](/sql/relational-databases/performance/monitoring-performance-by-using-the-query-store) to examine query performance and execution plan history. Dynamic management views provide additional information about current database activity and resource consumption.

For supported metrics and diagnostic settings, see [Monitor and tune Azure SQL](/azure/azure-sql/database/monitor-tune-overview) and [Configure streaming export of diagnostic telemetry](/azure/azure-sql/database/metrics-diagnostic-telemetry-logging-streaming-export-configure).

## Monitor multiple resources with database watcher (preview)

Database watcher is a managed monitoring solution for Azure SQL Database and Azure SQL Managed Instance. It collects workload performance, configuration, and health data from databases, elastic pools, and SQL managed instances. Azure portal dashboards provide views of the monitored estate and individual resources.

To configure database watcher, create a watcher resource, select a data store, and add the SQL resources to monitor as targets. Grant the watcher access to the targets, and start data collection. Unlike the retired SQL Insights solution, database watcher doesn't require you to host monitoring agents on dedicated virtual machines.

Database watcher stores monitoring data in Azure Data Explorer or Real-Time Analytics in Microsoft Fabric, rather than in a Log Analytics workspace. You can analyze the collected data with Kusto Query Language (KQL) or T-SQL and configure retention in the data store.

Database watcher is in preview and doesn't support SQL Server on Azure VMs. For those workloads, consider VM insights and Azure Monitor data collection rules for VM monitoring, together with SQL Server monitoring tools for database performance.

For capabilities and setup guidance, see [Monitor Azure SQL workloads with database watcher (preview)](/azure/azure-sql/database-watcher-overview).

## Database advisors

Azure SQL Database provides several Database Advisors to provide intelligent performance tuning recommendations and automatic tuning options to improve performance.

The Query Performance Insight page shows you details about the queries responsible for the most CPU and IO usage for single and pooled databases.

- Query Performance Insight is available in the Azure portal in the Overview pane of your Azure SQL Database under "Intelligent Performance." Use the automatically collected information to identify queries and begin optimizing your workload performance.
- You can also configure automatic tuning to implement these recommendations automatically, such as forcing a query execution plan to prevent regression, or creating and dropping nonclustered indexes based on workload patterns. Automatic tuning is also available in the Azure portal in the Overview pane of your Azure SQL Database under "Intelligent Performance."
