When your Databricks environment grows beyond a single workspace, tracking what happens across clusters, jobs, and users becomes a challenge. **Log streaming to Azure Log Analytics** solves this by centralizing all your diagnostic and audit logs in one place, enabling powerful queries, alerts, and dashboards.

In this unit, you learn how log streaming works, how to query Databricks logs in Azure Log Analytics, and how to create alerts for proactive monitoring.

## Understand the log streaming architecture

Log streaming sends **diagnostic data** from Azure Databricks to Azure Log Analytics in **near real-time**. This integration uses **Azure diagnostic settings**, which capture events from your Databricks workspace and route them to a Log Analytics workspace.

Consider a typical scenario: Your organization runs multiple Databricks workspaces across different teams. Without **centralized logging**, investigating a failed job requires connecting to each workspace individually and searching through scattered logs. With log streaming configured, you query all events from a **single interface**.

The data flow works as follows:

1. Azure Databricks generates audit and diagnostic events for actions like cluster creation, job runs, notebook execution, and permission changes.
2. Azure diagnostic settings capture these events and stream them to your configured destination.
3. Log Analytics ingests the events into **service-specific tables**.
4. You query, visualize, and alert on this data using **Kusto Query Language (KQL)**.

Platform administrators typically configure the diagnostic settings through the Azure portal. As a data engineer, you focus on using the logs for monitoring and troubleshooting.

> [!NOTE]
> Diagnostic logs require the **Azure Databricks Premium plan**. Logs typically become available in Log Analytics within **15 minutes** of the event occurring.

## Explore the Databricks log tables

Azure Log Analytics organizes Databricks logs into **purpose-specific tables**. Each table captures events from a particular service or feature, making it easier to focus your queries.

The most commonly used tables include:

| Table                    | Description                                                        |
| ------------------------ | ------------------------------------------------------------------ |
| `DatabricksClusters`     | Cluster creation, termination, resizing, and configuration changes |
| `DatabricksJobs`         | Job creation, runs, failures, and schedule modifications           |
| `DatabricksNotebook`     | Notebook execution, creation, and modification events              |
| `DatabricksSQL`          | SQL warehouse operations and query-related events                  |
| `DatabricksUnityCatalog` | Catalog, schema, and table access events                           |
| `DatabricksWorkspace`    | Workspace-level operations and administrative actions              |
| `DatabricksSecrets`      | Secret scope and secret access events                              |

Each table contains **standard columns** for event tracking:

- `TimeGenerated` - When the event occurred
- `OperationName` - The action performed
- `Identity` - The user or service principal that initiated the action
- `SourceIPAddress` - Where the request originated
- `RequestParams` - Details about the request
- `Response` - The outcome including status codes

Understanding these tables helps you target your queries efficiently. For job-related issues, start with `DatabricksJobs`. For security investigations, focus on `DatabricksSecrets` and `DatabricksUnityCatalog`.

## Query logs with Kusto Query Language

**Kusto Query Language (KQL)** enables you to search, filter, and analyze your Databricks logs. You access Log Analytics by navigating to your workspace in the Azure portal and selecting **Logs** from the sidebar.

Start with a simple query to explore recent job events:

```kusto
DatabricksJobs
| where TimeGenerated > ago(24h)
| project TimeGenerated, OperationName, Identity, SourceIPAddress
| order by TimeGenerated desc
| take 100
```

This query retrieves the most recent 100 job-related events from the past 24 hours, displaying the timestamp, operation, user, and source IP.

### Investigate failed job runs

When jobs fail, you need to **identify patterns**. The following query finds all job failures and groups them by operation:

```kusto
DatabricksJobs
| where TimeGenerated > ago(7d)
| where Response contains "error" or Response contains "failed"
| summarize FailureCount = count() by OperationName, bin(TimeGenerated, 1h)
| order by FailureCount desc
```

This query reveals which operations fail most frequently and when failures cluster together, helping you spot **systemic issues**.

### Track cluster usage patterns

Understanding cluster behavior helps optimize costs. This query shows cluster events by type:

```kusto
DatabricksClusters
| where TimeGenerated > ago(7d)
| summarize EventCount = count() by OperationName
| order by EventCount desc
```

### Monitor Unity Catalog access

For security and compliance, track who accesses sensitive data:

```kusto
DatabricksUnityCatalog
| where TimeGenerated > ago(24h)
| where OperationName has "getTable" or OperationName has "selectFromTable"
| project TimeGenerated, Identity, OperationName, RequestParams
| order by TimeGenerated desc
```

> [!TIP]
> Save frequently used queries to the **Query explorer** in Log Analytics. You can organize queries into folders and share them with your team.

## Create alerts for proactive monitoring

Queries help you investigate past events. **Alerts** notify you when specific conditions occur, enabling **proactive response**.

To create an alert from a query:

1. Run your query in Log Analytics.
2. Select **New alert rule** from the toolbar.
3. Configure the **Condition** with thresholds that match your requirements.
4. Define an **Action group** to specify who receives notifications and how.

Consider setting up alerts for these common scenarios:

**Job failures exceed threshold**: Alert when more than five job failures occur within an hour.

```kusto
DatabricksJobs
| where TimeGenerated > ago(1h)
| where Response contains "error" or Response contains "failed"
| summarize FailureCount = count()
| where FailureCount > 5
```

**Unusual access patterns**: Alert when access to sensitive Unity Catalog objects occurs outside business hours.

```kusto
DatabricksUnityCatalog
| where TimeGenerated > ago(1h)
| where hourofday(TimeGenerated) < 6 or hourofday(TimeGenerated) > 20
| summarize AccessCount = count() by Identity
| where AccessCount > 10
```

**Cluster creation spikes**: Alert when cluster creation events exceed normal patterns, which might indicate runaway automation or unauthorized activity.

**Action groups** support multiple notification methods including email, SMS, Azure mobile app, and integration with IT service management tools.

## Apply log analysis for troubleshooting

Log streaming transforms troubleshooting from **reactive investigation** to **systematic analysis**. Here are practical approaches for common scenarios:

**Diagnosing job failures**: Start with the `DatabricksJobs` table to find the failed run. Cross-reference with `DatabricksClusters` to check if the underlying cluster had issues. Review `DatabricksNotebook` logs if the job runs notebook code.

**Investigating performance issues**: Query cluster events to identify scaling patterns. Look for frequent autoscaling events that might indicate undersized initial configurations.

**Security incident response**: Use `DatabricksUnityCatalog` and `DatabricksSecrets` tables to trace data access. Correlate with `SourceIPAddress` to identify unusual access locations.

**Cost attribution**: Combine cluster and job logs with Azure cost data to understand which teams or projects drive consumption.

With logs centralized in Azure Log Analytics, you build comprehensive views of your Databricks environment. This visibility supports both day-to-day operations and long-term planning decisions.
