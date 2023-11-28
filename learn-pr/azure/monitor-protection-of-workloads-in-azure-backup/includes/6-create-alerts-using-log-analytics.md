In Azure Monitor, you can create your own alerts in a Log Analytics workspace. In the workspace, you use *Azure action groups* to select your preferred notification mechanism.

> [!IMPORTANT]
> For information on the cost of creating this query, see [Azure Monitor pricing](https://azure.microsoft.com/pricing/details/monitor/).

Open the **Logs** section of the Log Analytics workspace and create a query for your own Logs. When you select **New Alert Rule**, the Azure Monitor alert-creation page opens, as shown in the following image.

:::image type="content" source="../media/custom-alert.png" alt-text="Screenshot shows how to Create an alert in a Log Analytics workspace.":::

Here the resource is already marked as the Log Analytics workspace, and action group integration is provided.

:::image type="content" source="../media/inked-la-azure-backup-create-alert.png" alt-text="Screenshot shows the Log Analytics alert-creation page.":::

## Alert condition

The defining characteristic of an alert is its triggering condition. Select **Condition** to automatically load the Kusto query on the **Logs** page as shown in the following screenshot. Here you can edit the condition to suit your needs.

:::image type="content" source="../media/la-azure-backup-alert-logic.png" alt-text="Screenshot shows how to set up an alert condition.":::

If necessary, you can edit the Kusto query. Choose a threshold, period, and frequency. The threshold determines when the alert will be raised. The period is the window of time in which the query is run. For example, if the threshold is greater than 0, the period is 5 minutes, and the frequency is 5 minutes, then the rule runs the query every 5 minutes, reviewing the previous 5 minutes. If the number of results is greater than 0, you're notified through the selected action group.

> [!NOTE]
> To run the alert rule once a day, across all the events/logs that were created on the given day, change the value of both 'period' and 'frequency' to 1440, that is, 24 hours.

## Alert action groups

Use an action group to specify a notification channel. To see the available notification mechanisms, under **Action groups**, select **Create New**.

:::image type="content" source="../media/la-azure-backup-action-group.png" alt-text="Screenshot shows the available notification mechanisms in the Add action group window.":::

:::image type="content" source="../media/create-action-group.png" alt-text="Screenshot shows the creation of action group." lightbox="../media/create-action-group.png":::

You can satisfy all alerting and monitoring requirements from Log Analytics alone, or you can use Log Analytics to supplement built-in notifications.


 






