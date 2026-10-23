Metrics show you what happened—CPU spiked, memory usage climbed, disk I/O saturated—but they don't explain why. When your alert rule fires because a virtual machine's CPU exceeded 80% for 15 minutes, you need to investigate which processes consumed resources, whether the spike correlates with specific user activity, and if similar patterns occurred in the past. Log Analytics Workspace provides this diagnostic capability by collecting detailed event logs from your Azure resources and enabling you to search, filter, and analyze that data using Kusto Query Language (KQL).

## How Log Analytics Workspace collects diagnostic data

Log Analytics Workspace acts as a central repository for log data from across your Azure environment. Unlike metrics that capture numeric performance values at regular intervals, logs contain rich event records with timestamps, severity levels, resource identifiers, and descriptive messages explaining what occurred. Data reaches the workspace through the collection method configured for each source.

For VM guest data, install Azure Monitor Agent (AMA) and associate a data collection rule (DCR) with the VM. Configure the DCR's data sources, filters, and **Azure Monitor Logs** destination. For Windows, select the required event logs and levels. For Linux, select the required Syslog facilities and severity levels. Application logs need an appropriate supported source, such as an application's Windows event log, Syslog output, or a separately configured custom log source. Installing the agent or enabling resource diagnostic settings doesn't automatically collect every application or security event.

Resource diagnostic settings serve a different purpose: they route supported Azure resource logs to selected destinations. For example, configure diagnostic settings on a Foundry resource or storage account to send its supported resource logs to the workspace. These settings don't replace the AMA and DCR configuration for VM guest data.

Confirm that records arrive in the expected tables before building queries or alerts. Collection intervals and ingestion latency depend on the source and configuration, so don't assume a fixed delivery time for all logs. See [Collect guest logs from a VM](/azure/azure-monitor/vm/tutorial-collect-logs).

:::image type="content" source="../media/log-analytics-workspace-central-repository.png" alt-text="Diagram showing how security audits record information to the Log Analytics Workspace.":::

The value of centralized logging becomes clear when you troubleshoot issues that span multiple resources. Suppose your AI training job failed unexpectedly. You check the virtual machine logs and find an out-of-memory error at 3:17 AM. You then query your storage account logs and discover that at 3:15 AM, the dataset download operation timed out due to network throttling. Finally, you check your virtual network logs and confirm that a firewall rule change at 3:10 AM inadvertently blocked outbound traffic to the storage endpoint. Without centralized logging, you'd need to check each resource individually, manually correlating timestamps across disconnected log files. With Log Analytics Workspace, you query all three log sources simultaneously and see the complete failure sequence in one result set.

## Writing effective KQL queries for infrastructure troubleshooting

Kusto Query Language provides the syntax for searching and analyzing log data in Log Analytics Workspace. You construct queries using a pipeline approach: start with a table containing the log records you want to examine, then apply filters, aggregations, and transformations to extract meaningful insights. A basic query structure looks like this: select a table, filter rows using the `where` operator, and display results using `take` or `summarize`.

Choose the table that matches the collection path:

- `Event` contains Windows events selected by a Windows event DCR.
- `Syslog` contains Linux Syslog records selected by the collection configuration.
- `Perf` contains performance counters sent to the workspace by a performance-counter DCR. VM insights uses `InsightsMetrics` for its standard performance collection instead.
- `AzureDiagnostics` or a resource-specific table contains supported Azure resource logs sent through diagnostic settings, depending on the resource and destination mode.

For example, to investigate Windows errors, query `Event`, filter `EventLevelName` to `Error`, select the required time range, and sort by `TimeGenerated`. For resource logs collected into `AzureDiagnostics`, use that table's schema, including `Level` where available. An `AzureDiagnostics` query isn't a substitute for querying guest Windows events.

As you investigate further, you aggregate data to identify patterns rather than examining individual events. If a DCR collects CPU counters into `Perf`, calculate average CPU usage per hour over the past week. Use `summarize` with `bin(TimeGenerated, 1h)` to group readings into hourly intervals. This can reveal a recurring spike when batch processing jobs start.

## Common query patterns for operations teams

For process-level investigation on a Windows VM, configure the DCR to collect the required process counters, such as `\Process(*)\% Processor Time`, into `Perf`. Filter `ObjectName` to `Process` and `CounterName` to `% Processor Time`, then group by `Computer` and `InstanceName` for the incident window. Without process-counter collection, overall CPU measurements don't identify which process consumes the CPU. See [Collect performance counters](/azure/azure-monitor/vm/data-collection-performance).

Security investigations require the corresponding event collection as well. A Windows event DCR that selects the Security log sends its records to `Event`. If you use Microsoft Sentinel's Windows Security Events via AMA connector, the selected events are sent to `SecurityEvent` instead. Use that table only when the corresponding collection is configured. For failed Windows logons, filter the appropriate table for `EventID` 4625 and use its schema to group the events by account. Review matching events and recent successful logons to assess the activity. See [Collect Windows events](/azure/azure-monitor/vm/data-collection-windows-events).

:::image type="content" source="../media/security-investigation-require-query-pattern.png" alt-text="Diagram showing how security investigations require different query patterns that focus on authentication events.":::

These query patterns become even more powerful when you save them as functions in Log Analytics Workspace. After you've tested and refined a query for finding errors or detecting failed logins, you save it with a friendly name like 'FindRecentErrors' or 'DetectFailedLogins'. Your team members can then execute these saved queries without understanding KQL syntax, democratizing log analysis across your operations team and reducing the time from alert notification to root cause identification.

## Integrating log queries into operational workflows

Query results inform decisions only when they're accessible at the moment you need them. During an active incident, you run ad-hoc queries in the Log Analytics query editor to explore hypothesis and narrow down root causes. Between incidents, you embed saved queries into Azure dashboards alongside metric charts, providing a single-pane-of-glass view of both performance trends and recent error events. This integration means your operations team sees elevated CPU metrics and related error log entries side by side, eliminating the need to switch between tools and mentally correlate data from different sources.

For recurring investigations, you configure alert rules that automatically run KQL queries on a schedule and trigger notifications when results meet specific criteria. You create an alert rule that executes your 'DetectFailedLogins' query every 15 minutes and fires an alert if any user account shows more than 10 failed login attempts. This transforms reactive log analysis into proactive threat detection, with your security team receiving notifications about suspicious activity within minutes rather than discovering attacks hours later during manual log reviews.

Organizations that adopt query-driven troubleshooting report 50-70% reductions in mean time to resolution (MTTR) for infrastructure incidents, because log data reveals root causes faster than trial-and-error configuration changes. For AI infrastructure teams, this translates to fewer failed training runs, reduced compute waste from debugging incorrect configurations, and faster recovery when production services experience outages.

## Additional resources

- [Log Analytics Workspace overview](/azure/azure-monitor/logs/log-analytics-workspace-overview) - Architecture, data retention policies, and workspace design best practices
- [Kusto Query Language tutorial](/azure/data-explorer/kusto/query/tutorial) - Comprehensive KQL syntax reference with examples for filtering, aggregation, and time-series analysis
- [Log Analytics query examples](/azure/azure-monitor/logs/example-queries) - Library of pre-built queries for common infrastructure monitoring and troubleshooting scenarios

## Enhancement suggestions

- Screenshot of Log Analytics Workspace query editor showing a sample KQL query in the query pane (AzureDiagnostics | where Level == 'Error' | order by TimeGenerated desc | take 100) with the Run button highlighted, and a results table below displaying columns for TimeGenerated, ResourceName, Level, and Message, with 15 error records visible
- Three-minute video tutorial demonstrating how to write and execute a KQL query in Log Analytics Workspace: navigate to the workspace from the Azure portal, open the Logs page, write a query to find recent errors, run the query, interpret the results table, and export results to CSV for further analysis
- Interactive KQL query builder where learners select a troubleshooting scenario from a dropdown (find errors, track CPU trends, detect failed logins), view a pre-filled query template, modify filter values, run the query against sample log data, and see dynamically generated results with explanatory annotations highlighting key columns and values

## Accessibility notes

For the query editor screenshot, describe the layout: query editor pane at top with editable text field, toolbar with Run button and time range selector, results pane below showing a data table. Describe table structure: four columns labeled TimeGenerated, ResourceName, Level, and Message, with 15 rows of error records. Specify that TimeGenerated shows timestamps in descending order, Level column contains the text 'Error' for all rows, and Message column displays descriptive error text.
