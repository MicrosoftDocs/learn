Dashboards and workbooks provide visibility into application health, but they require someone to be watching. Alert rules proactively notify your team when telemetry indicates a problem, ensuring that failures and performance degradation are detected even when no one is actively monitoring. This unit covers how developers configure Azure Monitor alert rules to detect application issues, set up action groups for notifications, and use smart detection for automatic anomaly identification.

## Understand the alert rule structure

Every Azure Monitor alert rule consists of four components that work together to detect problems and trigger responses. Understanding these components helps you design alert rules that balance sensitivity with noise reduction.

The four components are:

- **Scope:** The Azure resource or resources that the alert rule monitors. For application telemetry, the scope is typically an Application Insights resource or a Log Analytics workspace.
- **Condition:** The signal and threshold logic that determines when the alert fires. The condition specifies what data to evaluate and what constitutes a problem.
- **Action group:** The collection of notifications and automated actions that execute when the alert fires. Action groups are reusable across multiple alert rules.
- **Severity:** A classification from 0 (Critical) to 4 (Verbose) that indicates the urgency of the alert.

Azure Monitor supports two primary alert types for application telemetry. Metric alerts evaluate resource metrics at regular intervals and work well for straightforward threshold monitoring, such as detecting when CPU usage exceeds 80 percent or when request rates drop below a minimum. Log search alerts run KQL queries at a configured frequency and evaluate the results against a threshold. Log search alerts provide more flexibility because you can use any KQL query to define the detection logic, including queries that join across tables, calculate percentiles, or aggregate data by custom dimensions. For AI application monitoring, log search alerts are the more common choice because they let you express complex conditions that metric alerts can't capture.

Alert severity levels communicate the urgency of each alert to responders. Severity 0 (Critical) signals production-impacting failures that require immediate response, such as a complete service outage. Severity 1 (Error) signals significant problems that affect functionality. Severity 2 (Warning) signals potential issues that need attention before they escalate. Severity 3 (Informational) tracks notable events that don't require immediate action. Severity 4 (Verbose) provides detailed diagnostic information. Assigning appropriate severity levels helps on-call teams prioritize their response when multiple alerts fire simultaneously.

## Create log search alert rules

Log search alerts run a KQL query at a defined frequency and evaluate the results against a condition. The evaluation determines whether the query returns rows that indicate a problem, and if the condition is met, the alert fires and triggers the associated action group.

The key configuration options for log search alerts are evaluation frequency, aggregation granularity, and the threshold condition. The evaluation frequency controls how often the query runs, with options ranging from one minute to 24 hours. The aggregation granularity (window size) defines the time window that each evaluation covers. The threshold condition specifies whether the alert fires based on the number of returned rows or a calculated numeric value. You can also configure the number of violations required before the alert fires, which prevents single transient spikes from generating noise.

The following KQL query detects a high failure rate by counting failed requests per service and returning rows only for services that exceed 10 failures:

```kusto
requests
| where success == false
| summarize failedCount = count() by cloud_RoleName
| where failedCount > 10
```

To configure this query as a log search alert, you set the aggregation granularity to five minutes, the evaluation frequency to five minutes, and the measure to table rows. The threshold is set to greater than zero, meaning the alert fires if the query returns any rows. Each returned row represents a service that exceeded 10 failures in the five-minute window, providing immediate context about which services are affected.

For latency monitoring, a different threshold approach detects when response times exceed acceptable levels. The following query calculates the 95th-percentile response time per service and returns rows for services where that percentile exceeds three seconds:

```kusto
requests
| summarize p95Duration = percentile(duration, 95) by cloud_RoleName
| where p95Duration > 3000
```

Using percentile-based thresholds instead of average-based thresholds produces more actionable alerts. An average response time might remain within acceptable limits even when a significant percentage of users experiences slow responses. The 95th percentile captures the experience of the slowest five percent of requests, which often represents the users most likely to encounter problems.

## Configure action groups for notifications

Action groups define what happens when an alert fires. Each action group is a reusable collection of notification preferences and automated actions that you can attach to multiple alert rules. A single alert rule can reference up to five action groups, allowing you to send different types of notifications to different teams from the same alert.

Action groups support several notification types. Email notifications send an alert summary with a link to the fired alert in the Azure portal. SMS notifications deliver a short message to a phone number, which is useful for critical alerts that need immediate attention outside of working hours. Azure mobile app push notifications appear on devices with the Azure mobile app installed. Voice call notifications deliver an automated call to a phone number for the highest-severity alerts.

Beyond notifications, action groups support automated actions that trigger workflows in response to alerts. You can configure an Azure Function to execute remediation logic, a Logic App to create a ticket in an external system, a webhook to call a third-party incident management service, an Automation Runbook to execute a scripted recovery procedure, or an Event Hub to stream alert data into an event processing pipeline. These automated actions enable teams to respond to common problems without manual intervention.

When designing action groups, consider creating separate groups for different severity levels. A critical action group might include SMS and voice call notifications for the on-call engineer plus a webhook to an incident management system. A warning action group might include only email notifications to the team distribution list. This separation ensures that critical alerts get immediate attention while less urgent alerts don't create notification fatigue. Test action groups using the portal's test feature before relying on them in production to verify that notifications reach the intended recipients.

## Use smart detection for anomaly identification

Azure Monitor smart detection uses machine learning to identify unusual patterns in application telemetry without requiring manual threshold configuration. Smart detection learns the normal behavior of your application over a baseline period and alerts when it detects significant deviations. This approach complements manual alert rules by catching unexpected problems that developers wouldn't anticipate when setting static thresholds.

Failure anomaly detection monitors the rate of failed requests and compares the current rate to the historical baseline. When smart detection identifies an abnormal rise in failures, it fires an alert that includes a cluster analysis showing the characteristic patterns of the anomalous failures. The analysis identifies affected users, correlated exceptions, and related dependencies, providing investigation context that goes beyond a simple "failure rate exceeded threshold" notification. This contextual information helps developers immediately focus on the root cause rather than spending time gathering diagnostic data.

Performance anomaly detection identifies response time degradation, dependency duration slowdowns, and abnormal exception volume increases. Smart detection recognizes gradual degradation patterns that might not trigger a fixed threshold alert because the values never exceed a specific number. Instead, it detects that performance is worse than its historical norm, which is often the earliest signal of an emerging problem.

Smart detection and manual alert rules serve different purposes and work best when used together. Smart detection is ideal for catching unexpected problems that developers wouldn't anticipate with static thresholds, such as a new type of exception that suddenly appears or a dependency that gradually degrades over weeks. Manual log search alerts are better for enforcing specific SLA thresholds or business rules, such as "the 95th-percentile response time must stay below three seconds" or "fewer than one percent of requests should fail." Using both approaches together provides comprehensive coverage: manual alerts enforce known operational boundaries while smart detection watches for novel problems.

## Additional resources

- [Azure Monitor alerts overview](/azure/azure-monitor/alerts/alerts-overview)
- [Create a log search alert rule](/azure/azure-monitor/alerts/alerts-create-log-alert-rule)
- [Action groups](/azure/azure-monitor/alerts/action-groups)
- [Smart detection in Application Insights](/azure/azure-monitor/alerts/proactive-diagnostics)
