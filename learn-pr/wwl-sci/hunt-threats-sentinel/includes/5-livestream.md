You can use the hunting livestream to test queries against live events as they occur. Livestream provides interactive sessions that can notify you when Microsoft Sentinel finds matching events for your query.

A livestream is always based on a query. Typically, you use the query to narrow down streaming log events, so only the events that are related to your threat-hunting efforts appear. You can use a livestream to:

- Test new queries against live events.
- Generate notifications for threats.
- Launch investigations.

Livestream queries refresh every 30 seconds and generate Azure notifications of any new results from the query.

## Create a livestream

To create a livestream from the **Hunting** page in Microsoft Sentinel, select the **Livestream** tab and then select **New livestream** from the toolbar.  

>[!NOTE]
>Livestream queries run continuously against your live environment, so you can't use time parameters in a livestream query.

:::image type="content" source="../media/5-new-livestream.png" alt-text="Screenshot that shows the livestream creation page in Microsoft Sentinel." :::

## View a livestream

On the new **Livestream** page, specify a name for the livestream session and the query that provides results for the session. Notifications for livestream events appear in your Azure portal notifications.

## Manage a livestream

You can play the livestream to review results or save the livestream for later reference. Saved livestream sessions can be viewed from the **Livestream** tab on the **Hunting** page. You can also elevate events from a livestream session to an alert by selecting the events and then selecting **Elevate to alert** from the command bar.

You might use a livestream to track baseline activities for Azure resource deletion, and identify other Azure resources that should be tracked. For example, the following query returns any Azure Activity events that recorded a deleted resource:

```kusto
  AzureActivity
  | where OperationName has 'delete'
  | where ActivityStatus == 'Accepted'
  | extend AccountCustomEntity = Caller
  | extend IPCustomEntity = CallerIpAddress
```

## Use a livestream query to create an analytics rule

If the query returns significant results, you can select **Create analytics rule** from the command bar to create an analytics rule based on the query. After the rule refines the query to identify the specific resources, it can generate alerts or incidents when the resources are deleted.

Choose the best response for the following question, then select **Check your answers**.
