You can use the hunting livestream to test queries against live events, as they occur. Livestream provides interactive sessions that can notify you when matching events for your query are found.

A livestream is always based on a query. Typically, the query is used to narrow down streaming log events, so only the events that are related to your threat hunting efforts are presented. You can use a livestream to:

- Test new queries against live events.
- Generate notifications for threats.
- Launch investigations.

Livestream queries refresh every 30 seconds and generate Azure notifications of any new results from the query.

## Create a livestream

To create a livestream from the **Hunting** page in Azure Sentinel, select the **Livestream** tab and then select **New livestream** from the toolbar.  

>[!NOTE]
>Livestream queries run continuously against your live environment, so you cannot use time parameters in a livestream query.

:::image type="content" source="../media/5-new-livestream.png" alt-text="The Livestream creation page in Azure Sentinel" :::

## View a livestream

On the new **Livestream** page, specify a name for the livestream session and the query that will provide results for the session. Notifications for livestream events will appear in your Azure portal notifications.

## Manage a livestream

You can play the livestream to review results or save the livestream for later reference. Saved livestreams can be viewed from the **Livestream** tab on the **Hunting** page. You can also elevate events from a livestream session to an alert by selecting the events and then selecting **Elevate to alert** from the command bar.

You could use a livestream to track baseline activities for Azure resource deletion at Contoso and identify other Azure resources that should be tracked. For example, the following query will return any Azure Activity events that recorded a deleted resource:

```kusto
  AzureActivity
  | where OperationName has 'delete'
  | where ActivityStatus == 'Accepted'
  | extend AccountCustomEntity = Caller
  | extend IPCustomEntity = CallerIpAddress
  ```

## Use a livestream query to create an analytics rule

If the query returns significant results, you could select **Create analytics rule** from the command bar to create an analytics rule based on the query. After refining the query to identify the specific resources, this rule could generate alerts or incidents when the resources are deleted.

Choose the best response for each of the questions below. Then select “Check your answers.”
