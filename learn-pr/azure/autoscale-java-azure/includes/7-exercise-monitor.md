In this exercise, you'll use log analytics to query autoscaling events for your sample application.

## Monitor the application's autoscale with Log Analytics

You can validate the evaluations and scale actions better using Log Analytics. In your sample application, we've routed your autoscale logs to Azure Monitor Logs (Log Analytics) through a Log Analytics workspace you created with your sample application setup.

> [!IMPORTANT]
> The Log data ingestion time in Azure Monitor can take up to 15 minutes. If you don't find data in Log Analytics, it may take additional time to ingest Azure Spring Apps log data.

## Understanding autoscale events

In the autoscale setting screen, go to the **Run history** tab to see the most recent scale actions.

:::image type="content" source="../media/activity-log.png" alt-text="Screenshot of the autoscale log in the Azure portal." lightbox="../media/activity-log.png":::

The tab also shows the change in Observed Capacity over time. To find more details about all autoscale actions including operations such as update/delete autoscale settings, view the activity log and filter by autoscale operations.

Next, we'll use log analytics to dig deeper into the autoscale events.

## Use Log Analytics to troubleshoot scale events

1. In the Azure portal, open the Log Analytics workspace in your resource group. This step will set the initial scope to a Log Analytics workspace, so that your query will select from all data in that workspace. If you select Logs from an Azure resource's menu, the scope is set to only records from that resource.
1. On the left menu, select **Logs**.

The left side of the screen includes the **Tables** tab, where you can inspect the tables that are available in the current scope.

Expand the Log Management solution and locate the **AutoscaleEvaluationsLog** table. You can expand the table to view its schema, or hover over its name to show more information about it.

:::image type="content" source="../media/log-analytics.png" alt-text="Screenshot of the Log Analytics menu in the Azure portal." lightbox="../media/log-analytics.png":::

## Write a Kusto query

Let's write a query by using the **AutoscaleEvaluationsLog** table. Double-click its name to add it to the query window. You can also type directly in the window. You can even get IntelliSense that will help complete the names of tables in the current scope and Kusto Query Language (KQL) commands.

This query is the simplest query that we can write. It just returns all the records in a table. Run it by selecting the **Run** button or by pressing <kbd>Shift + Enter</kbd> on your keyboard with the cursor positioned anywhere in the query text.

```Kusto
AutoscaleEvaluationsLog
```

The number of records that the query has returned appears in the lower-right corner. For more exercises on KQL autoscale queries, see the Summary unit at the end of this module.
