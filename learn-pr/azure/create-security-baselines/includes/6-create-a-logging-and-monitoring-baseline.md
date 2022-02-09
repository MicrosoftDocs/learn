Logging and monitoring are a critical requirement when trying to identify, detect, and mitigate security threats. A proper logging policy can ensure you can determine when a security violation has occurred. Also, the policy can potentially identify the culprit responsible. Azure Activity logs provide data about both external access to a resource and diagnostic logs, which provide information about the operation of that specific resource.

> [!NOTE]
> An Azure activity log is a subscription log that provides insight into subscription-level events that have occurred in Azure. Using the activity log, you can determine the what, the who, and the when for any write operations taken on the resources in your subscription.

## Logging policy recommendations

See the following security recommendations to set logging and monitoring policies on your Azure subscriptions. Each recommendation includes a procedure to follow in the Azure portal. Perform each procedure with your own subscription using your own resources to validate the security policy. Keep in mind that **Level 2** options might restrict some features or activity, so carefully consider which security options you decide to enforce.

### Ensure that a diagnostic setting exists - Level 1

The Azure Activity Log provides insight into subscription-level events that have occurred in Azure. This log includes a range of data, from Azure Resource Manager operational data to updates on Service Health events. The Activity Log was previously known as Audit Logs or Operational Logs, since the Administrative category reports control-plane events for your subscriptions.
There's a single Activity Log for each Azure subscription. It provides data about the operations on a resource from the outside. Diagnostic Logs are emitted by a resource and provide information about the operation of that resource. You must enable diagnostic settings for each resource.

1. Sign in to the [Azure portal](https://portal.azure.com).

1. On the Azure **home** page, in the top search bar, search for and select *Monitor*. The **Monitor | Overview** pane displays.

1. In the left menu pane, select **Activity log**. The **Monitor | Activity log** pane displays.

1. Ensure that a **Diagnostic setting** is set. Select **Export activity logs**.

1. If there are no settings, select your subscription, and then select **Add Diagnostic setting**.

    :::image type="content" source="../media/6-create-a-logging-and-monitoring-baseline/azure-monitor-diagnostic-settings-add-setting.png" alt-text="Screenshot that shows the Diagnostic settings pane and 'Add diagnostic setting' selected.":::

1. Enter a name for your diagnostic setting, and then configure the log categories and destination details.

1. On the top menu bar, select **Save**.

    :::image type="content" source="../media/6-create-a-logging-and-monitoring-baseline/azure-monitor-configure-diagnostic-setting.png" alt-text="Screenshot that shows the Diagnostic setting creation pane.":::

### Create an activity log alert for "Creating a policy assignment" - Level 1

 Monitoring when a policy is created illustrates who has that privilege. This might help detect a breach or misconfiguration.

1. Sign in to the [Azure portal](https://portal.azure.com).

1. On the Azure **home** page, in the top search bar, search for and select *Monitor*. The **Monitor | Overview** pane displays.

1. In the left menu pane, select **Alerts**. The **Monitor | Alerts** pane displays.

1. On the top menu bar, select the **Create** drop-down, and then select **Alert rule**. The **Create alert rule** pane displays.

1. Select **Select scope**. The **Select a resource** pane displays.

1. Select **Policy assignment (policyAssignments)** from the **Filter by resource type** dropdown list.

1. Select **Done**.

### Create an activity log alert for "Creating, updating, or deleting a Network Security Group" - Level 1

By default, no monitoring alerts are created when NSGs are created, updated, or deleted. Changing or deleting a security group can allow internal resources to be accessed from improper sources, or for unexpected outbound network traffic.

1. Sign in to the [Azure portal](https://portal.azure.com).

1. On the Azure **home** page, in the top search bar, search for and select *Monitor*. The **Monitor | Overview** pane displays.

1. In the left menu pane, select **Alerts**. The **Monitor | Alerts** pane displays.

1. On the top menu bar, select the **Create** drop-down, and then select **Alert rule**. The **Create alert rule** pane displays.

1. Select **Select scope**. The **Select a resource** pane displays.

1. Select **Network security groups** from the **Filter by resource type** dropdown list.

1. Select **Done**.

### Create an activity log alert for "Creating or updating an SQL Server firewall rule" - Level 1

Monitoring for **Create or update SQL Server Firewall Rule** events provides insight into network access changes, and might reduce the time it takes to detect suspicious activity.

1. Sign in to the [Azure portal](https://portal.azure.com).

1. On the Azure **home** page, in the top search bar, search for and select *Monitor*. The **Monitor | Overview** pane displays.

1. In the left menu pane, select **Alerts**. The **Monitor | Alerts** pane displays.

1. On the top menu bar, select the **Create** drop-down, and then select **Alert rule**. The **Create alert rule** pane displays.

1. Select **Select scope**. The **Select a resource** pane displays.

1. Select **SQL servers** from the **Filter by resource type** dropdown list.

1. Select **Done**.

    :::image type="content" source="../media/6-sql-server.png" alt-text="Screenshot of Select SQL servers resource." lightbox="../media/6-sql-server.png#lightbox":::

    > [!TIP]
    > Remember to select **Save** if you make changes to any of the settings.
