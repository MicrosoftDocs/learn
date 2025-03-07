In Azure Monitor, you can create your own alerts in a Log Analytics workspace. In the workspace, you use Azure action groups to select your preferred notification mechanism.

> [!IMPORTANT]
> For information on the cost of creating this query, see [Azure Monitor pricing](https://azure.microsoft.com/pricing/details/monitor/).

Open the **Logs** section of the Log Analytics workspace and create a query for your own logs. When you select **New alert rule**, the Azure Monitor alert-creation page opens.

:::image type="content" source="../media/custom-alert.png" alt-text="Screenshot that shows how to create an alert in a Log Analytics workspace.":::

Here, the resource is already marked as the Log Analytics workspace, and action group integration is provided:

:::image type="content" source="../media/inked-log-analytics-azure-backup-create-alert.png" alt-text="Screenshot that shows the Log Analytics alert-creation page.":::

## Set an alert condition

The defining characteristic of an alert is its triggering condition. Select **Condition** to automatically load the Kusto query on the **Logs** page. Here you can edit the condition to match your requirements.

:::image type="content" source="../media/log-analytics-azure-backup-alert-logic.png" alt-text="Screenshot that shows how to set up an alert condition.":::

If necessary, you can edit the Kusto query. Choose a threshold, period, and frequency. The threshold determines when the alert is raised. The period is the window of time in which the query runs. For example, if the threshold is greater than 0, the period is 5 minutes, and the frequency is 5 minutes, then the rule runs the query every 5 minutes, reviewing the previous 5 minutes. If the number of results is greater than 0, you're notified through the selected action group.

> [!NOTE]
> To run the alert rule once a day for all events and logs that were generated that day, change the value of both **period** and **frequency** to **1440**, that is, 24 hours.

## Create an alert action group

Use an action group to specify a notification channel. To see the available notification mechanisms, under **Action groups**, select **Create new**.

:::image type="content" source="../media/log-analytics-azure-backup-action-group.png" alt-text="Screenshot that shows the available notification mechanisms in the Add action group pane.":::

:::image type="content" source="../media/create-action-group.png" alt-text="Screenshot that shows creating an action group." lightbox="../media/create-action-group.png":::

You can satisfy all alerting and monitoring requirements by using Log Analytics alone, or you can use Log Analytics to supplement built-in notifications.
