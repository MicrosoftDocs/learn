Tailwind Manufacturing is interested in setting up a system of alerts to respond to operational and connectivity signals from its Azure Arc-enabled servers. In this unit, you learn how Azure Monitor supports smart and scalable alerting through rules. Then, you create a log search alert for low free disk space on an Azure Arc-enabled server.

## Overview of Azure Monitor alerts and alert rules

Alerts proactively notify you when issues are found with your infrastructure or application by using your monitoring data in Azure Monitor. They allow you to identify and address issues before your system's users notice them. The core components of Azure Monitor alerts include alert rules, action groups, and monitor conditions.

Alert rules are separated from alerts and the actions taken when an alert fires. The alert rule captures the target and criteria for alerting. Key attributes of an alert include:

- **Target resource** defines the scope and signals available for alerting. A target can be any Azure resource. Azure Arc-enabled servers can be targets for Azure Monitor Alerts.

- **Signal** is the monitoring data evaluated by an alert rule, such as metrics, logs, or activity log events. Application Insights can also supply telemetry for alerts. For an Arc-enabled server, examples include collected guest CPU utilization data or Azure Monitor Agent heartbeat records. A CPU utilization threshold belongs to the rule's condition, not to the signal.

- **Criteria** specifies the condition applied to a signal for a target resource. For example, trigger an alert when the monitored CPU utilization exceeds a threshold of 70%.

- **Alert name, Alert description,** and **Severity** are configured by the user. Severity ranges from 0 to 4, where Severity 0 is *Critical*, Severity 1 is *Error*, Severity 2 is *Warning*, Severity 3 is *Informational*, and Severity 4 is *Verbose*.

- **Action** selects an action group for notifications and automated responses. Action types include an Automation runbook, Azure Function, Logic App, Secure Webhook, and Webhook. For supported ServiceNow ITOM or BMC Helix scenarios, use the Secure Webhook integration, including its Microsoft Entra authentication and target-system configuration. For other service-management systems or payload formats, use an appropriate webhook endpoint, Azure Logic Apps, or Azure Functions to adapt the alert data to the target API.

The default **Alerts** page provides a summary of alerts that are created within a particular time range. You can also manage the state of an alert to specify its stage in the resolution process. When all of the criteria specified in the alert rule are met, an alert is created or fired, and it has a status of *New*. You can change the status when you acknowledge an alert and when you close it. All state changes are stored in the history of the alert.

Use Azure Resource Graph to query alert instances across your subscription and summarize them by properties such as severity and alert state. To reduce notification noise during planned maintenance, use alert processing rules to suppress action groups for matching fired alerts within a selected scope and schedule. The alerts still fire and remain available for investigation; suppression changes action-group execution, not the underlying alert condition.

Azure Monitor’s robust alert management and resource framework can be extended to reporting of hybrid and multicloud machines through Azure Arc-enabled servers.

## Create a log search alert for low free disk space

This example creates a log search alert when an individual disk on an Azure Arc-enabled server averages less than 10 percent free space over 15 minutes. It monitors free disk capacity, not disk busy time. The threshold is an example; choose one appropriate for your workload.

Before you begin, complete the logs-based VM insights configuration earlier in this module. Identify its Log Analytics workspace and copy the full Azure resource ID of the Arc-enabled server. Confirm that current InsightsMetrics data is arriving. You need workspace query access and permission to create the alert rule in its resource group. You also need read permission on any existing action group you attach. Creating or changing an action group requires appropriate write permissions; testing it requires a test-capable role. For an existing group, Contributor scoped to that action-group resource is one supported option. If you can't test the group yourself, arrange for an authorized action-group administrator to perform the notification test with you. Ingestion, retention, alert evaluation, and alert dimensions can incur charges.

### Prepare a notification action group

Before creating the alert rule, prepare a saved action group and confirm that its notification reaches the intended recipient. Testing sends real notifications, so coordinate with the recipients.

1. In the Azure portal, open **Monitor** > **Alerts** > **Action groups**. Select an existing approved group, or select **Create** and configure the intended notifications. Save the group and any changes before testing.
1. If you add an email address that hasn't already been verified in this tenant, have the recipient complete the one-time-passcode verification within 30 minutes of saving the group. If the passcode expires, open the action group and select **Resend**. An address already verified in the same tenant doesn't need to be verified again for each action group.
1. On the **Action groups** page, select the saved group and select **Test**. Choose a sample alert type and only the notification types you intend to test, then select **Test**. Don't include automation actions unless their execution is also intended and approved. If you lack test permissions, have the authorized action-group administrator perform this step.
1. Keep the test window open until it completes. Review the **Success** or **Failed** result and confirm delivery with the intended recipient. If the test fails, select **View details**, correct the reported problem, save any changes, and test again.

> [!NOTE]
> When email verification enforcement is active, unverified email receivers can't receive alert or test notifications. The **Email Azure Resource Manager role** notification type doesn't require one-time-passcode verification. A successful action-group test confirms the notification path; it doesn't evaluate the disk query, its threshold, or the alert rule's resource and dimension settings.

### Create the disk-space alert rule

Follow these steps to create the disk-space alert rule and connect it to the tested action group:

1. In the Azure portal, open **Monitor > Alerts**, and select **Create > Alert rule**.
1. Set the rule's scope to the Log Analytics workspace that receives this server's VM insights data.
1. On **Condition**, select **Custom log search**. Enter the following query. Replace `<arc-resource-id>`, including the angle brackets, with the server's full resource ID ending in `/providers/Microsoft.HybridCompute/machines/<machine-name>`.

   ```kusto
   InsightsMetrics
   | where TimeGenerated > ago(15m)
   | where Origin == "vm.azm.ms"
   | where Namespace == "LogicalDisk" and Name == "FreeSpacePercentage"
   | where _ResourceId =~ "<arc-resource-id>"
   | extend Disk = tostring(parse_json(Tags)["vm.azm.ms/mountId"])
   | project TimeGenerated, _ResourceId, Computer, Disk, FreeSpacePercent = Val
   ```

1. Run the query and inspect the results. Confirm that the rows belong to the intended server, the disk identifiers are populated, and recent free-space percentage samples are present. If there are no records, resolve the collection, scope, or access problem before continuing.
1. Return to the alert condition editor. Under **Measurement**, choose calculation of the numeric column `FreeSpacePercent`, **Average** aggregation, and an aggregation granularity/window of **15 minutes**. Don't use a count of table rows.
1. Use `_ResourceId` as the resource ID column so the alert identifies the affected machine. Under **Split by dimensions**, select `Disk`, include the current disk values, and select **Include all future values**. This prevents a healthy disk from masking a low-space disk through a machine-wide average.
1. Configure a static threshold with **Less than** and a value of **10**, and evaluate every **5 minutes**. The value is a percentage on a 0-100 scale: `10` means 10 percent, not `0.10`. Use one violation to trigger the alert and a 15-minute query time range.
1. Review the condition preview for each disk, and finish configuring the condition.
1. On **Actions**, select the saved action group whose notification you tested. Confirm that it's the intended group for this alert. Notification delivery doesn't prove that the query condition is correct.
1. On **Details**, select the rule's subscription, resource group, region, name, and severity. For this single-workspace example, **Identity: None** uses the permissions of the last editor, who must be able to read the workspace. If you instead select a managed identity, grant it the required workspace read access before relying on the rule.
1. Review and create the enabled rule. Verify the configured rule and its notification path in a non-production scenario before relying on it for operational monitoring.

> [!NOTE]
> For the logs-based VM insights collection used in this exercise, Linux data-disk metrics are supported only for XFS and the EXT filesystem family (EXT2, EXT3, EXT4). Performance metric collection from network shared drives isn't supported. Before relying on this alert, confirm that the query returns recent `FreeSpacePercentage` samples for each disk you intend to monitor.
>
> Missing telemetry isn't evidence of healthy disk space. This rule evaluates received disk samples; it doesn't detect every agent, network, or ingestion failure. Monitor telemetry health separately. For Azure Arc connection status, use an appropriate Resource Health alert; connection status isn't the same measurement as guest disk capacity or AMA health.

For details, see individual-disk alert queries, creating log search alerts, agent heartbeat monitoring, and Arc disconnected-server alerts in the Summary unit's More Info section.
