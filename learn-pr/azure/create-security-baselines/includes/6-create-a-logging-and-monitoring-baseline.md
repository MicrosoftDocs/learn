Logging and monitoring are critical requirements when you try to identify, detect, and mitigate security threats. A proper logging policy can ensure that you can determine when a security violation has occurred. The policy also can potentially identify who is responsible. Azure activity logs provide data about external access to a resource, and they provide diagnostic logs, so you have information about the operation of a specific resource.

> [!NOTE]
> An Azure activity log is a subscription log that provides insight into subscription-level events that occurred in Azure. By using the activity log, you can determine the what, who, and when for any write operations that occurred on the resources in your subscription.

## Logging policy recommendations

The following sections describe the security recommendations in CIS Microsoft Azure Foundations Security Benchmark v. 3.0.0 to set logging and monitoring policies on your Azure subscriptions. Included with each recommendation are the basic steps to complete in the Azure portal. You should complete these steps for your own subscription and by using your own resources to validate each security recommendation. Keep in mind that **Level 2** options might restrict some features or activity, so carefully consider which security options you decide to enforce.

### Ensure that a diagnostic setting exists - Level 1

The Azure activity log provides insight into subscription-level events that occurred in Azure. This log includes a range of data, from Azure Resource Manager operational data to updates on Azure Service Health events. The activity log previously was called an *audit log* or an *operational log*. The Administrative category reports control-plane events for your subscriptions.

Each Azure subscription has a single activity log. The log provides data about resource operations that originated outside Azure. 

Diagnostic logs are emitted by a resource. Diagnostic logs provide information about the operation of the resource. You must enable diagnostic settings for each resource.

1. Sign in to the [Azure portal](https://portal.azure.com). Search for and select **Monitor**.

1. In the left menu, select **Activity log**.

1. In the **Activity log** menu bar, select **Export activity logs**.

1. If no settings are shown, select your subscription, and then select **Add diagnostic setting**.

    :::image type="content" source="../media/azure-logging-monitoring/add-diagnostic-setting.png" alt-text="Screenshot that shows the Diagnostic settings pane and Add diagnostic setting selected.":::

1. Enter a name for your diagnostic setting, and then select log categories and destination details.

1. In the menu bar, select **Save**.

Here's an example of how to create a diagnostic setting:

:::image type="content" source="../media/azure-logging-monitoring/configure-diagnostic-setting.png" alt-text="Screenshot that shows the Diagnostic settings creation pane and options selected.":::

### Create an activity log alert for creating a policy assignment - Level 1

If you monitor policies that are created, you can see which users can create policies. The information might help you detect a breach or misconfiguration of your Azure resources or subscription.

1. Sign in to the [Azure portal](https://portal.azure.com). Search for and select **Monitor**.

1. In the left menu, select **Alerts**.

1. In the **Alerts** menu bar, select the **Create** dropdown, and then select **Alert rule**.

1. In the **Create an alert rule** pane, select **Select scope**.

1. In the **Select a resource** pane, in the **Filter by resource type** dropdown, select **Policy assignment (policyAssignments)**.

1. Select a resource to monitor.

1. Select **Done**.

   :::image type="content" source="../media/azure-logging-monitoring/add-alert-resource.png" alt-text="Screenshot that shows adding a monitoring alert for an Azure resource." lightbox="../media/azure-logging-monitoring/add-alert-resource.png":::

1. To finish creating the alert, complete the steps that are described in [Create an alert rule from the Azure Monitor Alerts pane](/azure/azure-monitor/alerts/alerts-activity-log#create-an-alert-rule-from-the-azure-monitor-alerts-pane).

### Create an activity log alert for creating, updating, or deleting a network security group - Level 1

By default, no monitoring alerts are created when NSGs are created, updated, or deleted. Changing or deleting a security group can allow internal resources to be accessed from improper sources or for unexpected outbound network traffic.

1. Sign in to the [Azure portal](https://portal.azure.com). Search for and select **Monitor**.

1. In the left menu, select **Alerts**.

1. In the **Alerts** menu bar, select the **Create** dropdown, and then select **Alert rule**.

1. In the **Create an alert rule** pane, select **Select scope**.

1. In the **Select a resource** pane, in the **Filter by resource type** dropdown, select **Network security groups**.

1. Select **Done**.

1. To finish creating the alert, complete the steps that are described in [Create an alert rule from the Azure Monitor Alerts pane](/azure/azure-monitor/alerts/alerts-activity-log#create-an-alert-rule-from-the-azure-monitor-alerts-pane).

### Create an activity log alert for creating or updating a SQL Server firewall rule - Level 1

Monitoring for events that create or update a SQL Server firewall rule provides insight into network access changes, and it might reduce the time it takes to detect suspicious activity.

1. Sign in to the [Azure portal](https://portal.azure.com). Search for and select **Monitor**.

1. In the left menu, select **Alerts**.

1. In the **Alerts** menu bar, select the **Create** dropdown, and then select **Alert rule**.

1. In the **Create alert rule** pane, select **Select scope**.

1. In the **Select a resource** pane, in the **Filter by resource type** dropdown, select **SQL servers**.

1. Select **Done**.

1. To finish creating the alert, complete the steps that are described in [Create an alert rule from the Azure Monitor Alerts pane](/azure/azure-monitor/alerts/alerts-activity-log#create-an-alert-rule-from-the-azure-monitor-alerts-pane).
