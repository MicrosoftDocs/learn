>[!VIDEO https://learn-video.azurefd.net/vod/player?id=8c5875e6-a71b-4054-af29-2782014dd89d]

Tracking who did what, when, and to which data objects is essential for governance, security, and compliance. When you configure **audit logging** in Azure Databricks, you gain visibility into every significant action across your workspace and account. This visibility helps you meet regulatory requirements, investigate security incidents, and maintain accountability across your data platform.

Unity Catalog audit logging is **configured at the account level** and automatically applies to all workspaces within that account. This account-level configuration ensures consistent audit capture across your entire Databricks environment without requiring per-workspace setup.

In this unit, you learn how to access and query audit logs, understand what events are captured, and use these logs for common governance scenarios.

## Understand the audit log system table

Azure Databricks automatically captures audit events and stores them in the **audit log system table** located at `system.access.audit`. This table records actions across all workspaces attached to your Unity Catalog metastore, providing a **centralized view** of activity across your organization.

Consider a scenario where your security team needs to investigate unauthorized data access. Rather than searching through multiple log files, you query a single table that contains every tracked event. This centralized approach transforms compliance investigations from manual searches into straightforward SQL queries.

The audit log system table uses a consistent schema that includes the following key columns:

| Column              | Description                                                            |
| ------------------- | ---------------------------------------------------------------------- |
| `event_time`        | Timestamp when the action occurred                                     |
| `event_date`        | Calendar date of the action                                            |
| `user_identity`     | Identity of the user who initiated the action                          |
| `workspace_id`      | The Azure Databricks workspace in which the audit event took place           |
| `service_name`      | Service category (for example, `unityCatalog`, `notebook`, `clusters`) |
| `action_name`       | Specific action performed (for example, `getTable`, `createTable`)     |
| `request_params`    | Parameters included in the request                                     |
| `response`          | Response details including status codes and results                    |
| `source_ip_address` | IP address where the request originated                                |

Account-level events record `workspace_id` as `0`, while workspace-level events include the actual workspace identifier. This distinction helps you filter events by scope when investigating issues.

> [!NOTE]
> Azure Databricks retains audit logs for up to **one year** for security and fraud analysis purposes. Plan your long-term retention strategy if you need logs beyond this period.

## Identify tracked events and services

The audit log captures events across numerous services within Azure Databricks. Understanding which actions are logged helps you design effective monitoring and compliance strategies.

**Workspace-level services** log events for actions taken within a specific workspace:

- **Unity Catalog**: Table creation, deletion, updates, and permission changes
- **Notebooks**: Commands executed, notebooks created, modified, or deleted
- **Clusters**: Cluster creation, resizing, and termination
- **Jobs**: Job creation, runs, and failures
- **Databricks SQL**: Query execution, warehouse management, and alert activity
- **Accounts**: User logins, token generation, and access control changes

**Account-level services** capture events that span **multiple workspaces**:

- **Account management**: User and group management across the account
- **Billable usage**: Access to usage reports and aggregated metrics
- **Delta Sharing**: Provider and recipient actions for shared data

For example, when a user queries a table in Unity Catalog, the `unityCatalog` service logs a `getTable` action. If the same user runs a command in a notebook, the `notebook` service logs a `runCommand` action. Each service provides specific action names that describe precisely what occurred.

> [!TIP]
> For a comprehensive reference of audit log services and events, consult this article [Diagnostic log reference](/azure/databricks/admin/account-settings/audit-logs)

## Query audit logs for common scenarios

You can write SQL queries against the audit log system table to answer common governance questions. The following examples demonstrate patterns you can adapt for your organization's needs.

### Find who accessed a specific table

This query identifies users who accessed a particular table in the past seven days:

```sql
SELECT
  user_identity.email AS user_email,
  action_name AS access_type,
  event_time AS access_time
FROM system.access.audit
WHERE
  request_params.full_name_arg = 'catalog.schema.table_name'
  AND action_name IN ('getTable', 'createTable', 'deleteTable')
  AND event_date > CURRENT_DATE() - INTERVAL 7 DAYS
ORDER BY event_time DESC;
```

### Track permission changes across your metastore

This query shows all permission modifications, helping you audit access control changes:

```sql
SELECT
  event_time,
  user_identity.email AS changed_by,
  request_params.securable_type,
  request_params.securable_full_name,
  request_params.changes
FROM system.access.audit
WHERE
  service_name = 'unityCatalog'
  AND action_name = 'updatePermissions'
ORDER BY event_time DESC;
```

### Identify failed login attempts

Security investigations often require finding authentication failures. This query surfaces denied access attempts:

```sql
SELECT
  event_time,
  user_identity.email AS user_email,
  source_ip_address,
  action_name,
  response.error_message
FROM system.access.audit
WHERE
  service_name = 'accounts'
  AND response.status_code != 200
  AND event_date > CURRENT_DATE() - INTERVAL 30 DAYS
ORDER BY event_time DESC;
```

These queries form a foundation for your monitoring strategy. You can extend them to create alerts, build dashboards, or export data to external security information and event management (SIEM) platforms.

## Enable verbose audit logs

By default, Azure Databricks logs high-level events but doesn't capture the full text of commands executed in notebooks. When you need detailed visibility into exactly what code ran and when, enable **verbose audit logs**.

With verbose logging enabled, the audit log captures additional events:

| Service         | Action          | Description                                            |
| --------------- | --------------- | ------------------------------------------------------ |
| `notebook`      | `runCommand`    | Logs the full command text executed in a notebook cell |
| `jobs`          | `runCommand`    | Logs commands executed by job runs                     |
| `databrickssql` | `commandSubmit` | Logs SQL commands submitted to warehouses              |

To enable verbose audit logs:

1. Sign in to your Azure Databricks workspace as an administrator.
2. Navigate to **Admin Settings** by selecting your username and choosing **Admin Settings**.
3. Select the **Advanced** tab.
4. Locate **Verbose Audit Logs** and enable the feature.

:::image type="content" source="../media/7-verbose-audit-logs.png" alt-text="Screenshot of the Workspace admin advanced settings." lightbox="../media/7-verbose-audit-logs.png":::

When you enable or disable verbose logging, Azure Databricks logs this configuration change as an auditable event. This creates accountability for who modified the logging configuration and when.

> [!IMPORTANT]
> Verbose logs capture command text, which might include sensitive information such as query parameters or hardcoded values. Ensure your security policies account for this additional data exposure.

## Configure log delivery to external systems

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=7cd58862-808c-4bbe-affb-53786093261e]

While the audit log system table provides direct access within Databricks, many organizations route logs to external systems for centralized monitoring. Azure Databricks integrates with Azure diagnostic settings to deliver logs to multiple destinations, each optimized for different use cases:

- **Azure Log Analytics**: Provides near-real-time ingestion (typically within 15 minutes), centralized storage, and powerful querying using Kusto Query Language (KQL). This makes it ideal for fast analysis, interactive investigations, and building custom dashboards for auditing Unity Catalog access events.
- **Azure Storage accounts**: Offers low-cost, long-term archival and batch analysis. Best suited for compliance scenarios where logs are accessed infrequently but must be retained for extended periods.
- **Azure Event Hubs**: Enables real-time streaming to downstream consumers and processing systems. Ideal when you need to integrate audit logs with existing event-driven architectures or SIEM platforms.

Platform administrators configure log delivery at the account level through the Azure portal. When building monitoring solutions, account for typical ingestion latency of approximately **15 minutes** in your alerting thresholds.

:::image type="content" source="../media/7-diagnostic-setting.png" alt-text="Screenshot of Azure portal, showing diagnostic setting for Azure Databricks." lightbox="../media/7-diagnostic-setting.png":::

The combination of the system table for interactive queries and external delivery for operational monitoring provides comprehensive coverage. You can use the system table for ad-hoc investigations while relying on your SIEM platform for continuous security monitoring.

Understanding audit logging capabilities positions you to support compliance requirements and respond quickly to security incidents. With the audit log system table, you have a powerful tool for tracking activity, investigating issues, and demonstrating governance controls to stakeholders.
