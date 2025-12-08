When clusters run longer than needed or consume more resources than necessary, costs can escalate quickly. As a data engineer, you're responsible for **monitoring cluster usage** and taking action to balance **performance requirements** with **cost efficiency**.

## Understand the impact of cluster consumption

Unmonitored clusters present real financial risks. A single **idle cluster** running overnight or over a weekend can generate significant unexpected charges. These costs compound when multiple teams work across shared workspaces without visibility into resource usage patterns.

At the same time, **under-provisioned clusters** create their own problems. Jobs take longer to complete, users experience delays, and critical workflows miss their deadlines. The goal isn't simply to minimize costs—it's to **match resources precisely to workload requirements**.

Monitoring cluster consumption helps you **identify waste** before it impacts budgets and **spot performance bottlenecks** before they affect business operations. Regular monitoring also establishes **baselines** that help you plan capacity and justify infrastructure decisions.

## Monitor compute metrics

Azure Databricks provides a **native metrics interface** for all-purpose and job compute resources. You access these metrics by selecting **Compute** in the sidebar, choosing your compute resource, and selecting the **Metrics** tab.

The metrics interface displays three categories of data:

**Hardware metrics** show how physical resources are used. **CPU utilization** reveals whether your cluster is working hard or sitting idle. **Memory utilization** indicates whether you need to scale up or can reduce instance sizes. **Network throughput** helps identify data transfer bottlenecks.

**Spark metrics** focus on job execution patterns. **Active tasks** show current parallelism levels. Failed and completed task counts reveal job health. **Shuffle read and write metrics** expose data movement between stages that can indicate performance issues.

**GPU metrics** (available on Databricks Runtime ML 13.3 and later) track specialized compute utilization when running machine learning workloads.

You can filter metrics by time range using the date picker, viewing data from the past 30 days. Select individual nodes from the Compute dropdown to investigate specific worker performance, or view aggregated metrics across all nodes to understand overall cluster behavior.

> [!NOTE]
> Serverless compute for notebooks and jobs uses query insights instead of the metrics UI. The monitoring approach differs, but the goal remains the same: understanding resource consumption.

## Monitor SQL warehouse performance

SQL warehouses have their own monitoring interface optimized for query analytics. Select a SQL warehouse and then select the **Monitoring** tab to view performance data.

**Live statistics** at the top of the page show warehouse status, running queries, queued queries, and current cluster count. These metrics update in real-time and help you quickly assess whether the warehouse is keeping up with demand.

The **peak query count** chart displays the maximum number of concurrent queries—both running and queued—during your selected time frame. Spikes in this chart often indicate periods where the warehouse struggled to keep up with demand.

The **running clusters** chart shows how many clusters were allocated over time. If you've enabled **autoscaling**, you'll see this number fluctuate based on query load. Clusters that remain at maximum capacity for extended periods suggest you might need to increase the maximum cluster count.

The **query history** table lists individual queries with their start time, duration, and the user who ran them. Use filters to find **long-running queries** or identify users whose queries consume disproportionate resources.

## Configure auto-termination and autoscaling

Monitoring reveals patterns; configuration changes act on those patterns. Two key settings help you manage cluster consumption automatically.

**Auto-termination** shuts down idle clusters after a specified period of inactivity. For development environments, **30-60 minutes** is typically appropriate. The cluster terminates when no commands have run for the specified duration, preventing costs from accumulating overnight or over weekends.

To configure auto-termination, enable the setting during cluster creation or edit an existing cluster. Enter the number of minutes of inactivity before termination. Keep in mind that a cluster is considered inactive only when all commands—including Spark jobs, Structured Streaming, and JDBC calls—have finished executing.

**Autoscaling** dynamically adjusts the number of worker nodes based on workload demand. Configure **minimum and maximum node counts** based on your workload analysis. The cluster adds workers during intensive processing and removes them during lighter periods, reducing costs by **20-40%** compared to fixed-size clusters.

> [!IMPORTANT]
> Auto-termination doesn't monitor DStreams activity. If you run DStream workloads, either disable auto-termination or migrate to Structured Streaming.

## Track costs with budgets and system tables

Beyond real-time monitoring, you need visibility into actual spending. Azure Databricks provides several tools for cost tracking.

**Budgets** let you set financial targets and track spending across your account. Configure **email notifications** when spending approaches or exceeds your budget limits. You can apply filters to track spending by team, project, or workspace.

**System tables**, specifically `system.billing.usage`, provide detailed usage data you can query directly. Join this table with `compute.clusters` to identify which cluster owners consume the most **Databricks Units (DBUs)**. Use **custom tags** to attribute costs to specific business units or projects.

**Tags** propagate from clusters and workspaces to billing records, enabling accurate **chargeback**. Apply tags consistently from the start—you can't add tags retroactively to historical usage. Common tags include business unit, project, and environment (development, staging, production).

> [!NOTE]
> You need **account admin permissions** to create and manage budgets. Workspace admins can view budgets but typically cannot create them.

The following example queries help you analyze usage patterns:

**Daily DBU consumption trend** - See how your compute usage changes day by day. This helps you spot unusual spikes or identify patterns like higher usage on certain weekdays.

```sql
SELECT
  usage_date,
  sum(usage_quantity) as DBUs_Consumed
FROM system.billing.usage
WHERE sku_name = "STANDARD_ALL_PURPOSE_COMPUTE"
GROUP BY usage_date
ORDER BY usage_date ASC
```

**Which jobs consumed the most DBUs** - Find out which scheduled jobs are your biggest cost drivers. Use this to prioritize optimization efforts on the most expensive workloads.

```sql
SELECT
  usage_metadata.job_id as job_id,
  sum(usage_quantity) as total_dbus
FROM system.billing.usage
WHERE usage_metadata.job_id IS NOT NULL
GROUP BY job_id
ORDER BY total_dbus DESC
```

**Attribute costs to cluster owners** - Identify which team members or service accounts are responsible for the most resource consumption. This supports chargeback discussions and helps teams understand their footprint.

```sql
SELECT
  c.owned_by,
  sum(u.usage_quantity) as total_dbus
FROM system.billing.usage u
JOIN system.compute.clusters c
  ON u.usage_metadata.cluster_id = c.cluster_id
WHERE u.usage_metadata.cluster_id IS NOT NULL
GROUP BY c.owned_by
ORDER BY total_dbus DESC
```

**Usage by custom tag** - Break down costs by project, department, or any other tag you've applied to your resources. This is essential for accurate cost allocation across business units.

```sql
SELECT
  sku_name,
  usage_unit,
  sum(usage_quantity) as total_usage
FROM system.billing.usage
WHERE custom_tags['project'] = 'sales-analytics'
GROUP BY sku_name, usage_unit
```

Reviewing monthly cost reports helps you catch anomalies early. Investigate unexpected increases before they become significant budget problems.
