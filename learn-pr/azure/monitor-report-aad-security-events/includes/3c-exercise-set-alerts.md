In this exercise, you create a Log Analytics workspace in your Azure sandbox by using the Azure portal. You then direct the audit and sign-in log files to your workspace. Next, you download and install the prebuilt user sign-in and audit log views from GitHub.

> [!NOTE]
> This exercise is optional. If you don't have an Azure account, you can read through the following instructions to understand how to use Log Analytics and dashboards.
>
> If you want to complete this exercise but you don't have an Azure subscription or prefer not to use your own account, you can create a [free account](https://azure.microsoft.com/free/?azure-portal=true) before you begin.

## Create alerts from your activity log data

Alerts are similar to queries, but they run automatically in response to specific events. You can set a threshold against the result set, and if it's met, trigger an alert to let you know about it.

1. In the Azure portal, go to your Log Analytics workspace.

1. In the left menu under **Monitoring**, select **Alerts**, and then select **Create alert rule**.

1. Scope is automatically set to your Log Analytics workspace, so select the **Condition** tab.

1. In the **Select a signal** pane, for **Signal type**, select **Activity Log**.

1. In **Signal name**, select a name that matches the activity logs you want to monitor.

1. Select values for the settings for the alert logic. The alert logic is defined by the condition and the evaluation time. The alert fires when this condition is true. Provide a threshold value for your alert rule and modify the operator and aggregation type to define the logic you need. You can accept the default time granularity or modify it to your requirements. Frequency of evaluation defines how often the alert logic is evaluated. Aggregation granularity defines the time interval over which the collected values are aggregated.

1. You can add more conditions, and then select **Next: Actions >**.

1. On the **Actions** tab, if you haven't already created an action group that you want to use, select **Create action group**. Select a subscription and resource group for the action group and give it an action group name that appears in the portal and a display name that appears in email and SMS notifications.

1. Select **Next: Notifications >**.

1. Select a notification type and enter a name for the notification. Enter the details to continue to set up the action group.

1. You can optionally set up actions and tags. Then, select **Review + create**.

1. Review the action group information, and then select **Create**.

1. In **Create an alert rule**, on the **Details** tab, select a subscription and resource group for the alert rule. Enter an alert rule name and optionally enter a description of the alert rule.

1. You can optionally set tags for the alert rule. Then, select **Review + create**.

1. Review the action group information, and then select **Create**.

## View alert rules

When an alert fires, it will send any notifications in its action groups. You can also view the alert in the Azure portal.

In the left menu, select **Alerts**. Any open alerts for the resources are included in the view.

To view alerts that have that severity, select a severity. To view only open alerts, select **Alert state** and clear the **Closed** option.

To view details about an alert, select the name of the alert.

