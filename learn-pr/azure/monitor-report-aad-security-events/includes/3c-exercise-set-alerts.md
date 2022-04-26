In this exercise, you create an alert from your activity log data, and then you view a saved alert.

> [!NOTE]
> This exercise is optional. If you don't have an Azure account, you can read through the following instructions to understand how to use Log Analytics and dashboards.
>
> If you want to complete this exercise but you don't have an Azure subscription or prefer not to use your own account, you can create a [free account](https://azure.microsoft.com/free/?azure-portal=true) before you begin.

## Create an alert from your activity log data

Alerts are similar to queries, but they run automatically in response to specific events. You can set a threshold against the result set, and if it's met, trigger an alert to let you know about it.

1. In the Azure portal, go to your Log Analytics workspace.

1. In the left menu under **Monitoring**, select **Alerts**, and then select **Create alert rule**. Scope is automatically set to your Log Analytics workspace.

   :::image type="content" source="../media/alert-rule-new.png" alt-text="Screenshot that shows how to create a new alert rule.":::

1. Select the **Condition** tab.

1. In the **Select a signal** pane, for **Signal type**, select **Activity Log**.

1. In **Signal name**, for this exercise, select **All administrative operations**.

   :::image type="content" source="../media/alert-conditions.png" alt-text="Screenshot that shows selecting details for an alert condition.":::

1. Leave the default values for the settings for the alert logic, then select **Next: Actions >**, and then select **Next: Details >**.

1. On the **Details** tab, select a subscription and resource group for the alert rule. Enter an alert rule name and optionally enter a description of the alert rule. Then, select **Review + create**.

   :::image type="content" source="../media/alert-details.png" alt-text="Screenshot that shows how to enter details for a new alert rule.":::

1. Review the new alert details, and then select **Create**.

## View alert rules

Next, view the alert in your Log Analytics workspace in the Azure portal:

1. In the left menu under **Monitoring**, select **Alerts**.

1. To view alerts that have that severity, select a severity:

   :::image type="content" source="../media/alerts-severity.png" alt-text="Screenshot that shows filtering alerts by severity.":::

1. To view details about an alert, select the name of the alert:

   :::image type="content" source="../media/alert-results.png" alt-text="Screenshot that shows a summary of alerts.":::
