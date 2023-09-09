

An alert rule monitors your data and captures a signal that indicates something is happening on the specified resource. The alert rule captures the signal and checks to see if the signal meets the criteria of the condition. If the conditions are met, an alert is triggered, which initiates the associated action group and updates the state of the alert.

You create an alert rule by combining:

- The resources to be monitored.
- The signal or data from the resource.
- Conditions.

You then define these elements for the alert actions:

- Action groups
- Alert processing rules

Alerts triggered by these alert rules contain a payload that uses the common alert schema.

## Create an alert rule

To create a new alert rule from the portal home page:

1. In the portal, select **Monitor > Alerts**.
1. Open the **+ Create** menu and select **Alert rule**.
1. On the **Select a resource** pane, set the scope for your alert rule. You can filter by subscription, resource type, or resource location. Select **Apply**. Select **Next: Condition** at the bottom of the page.
1. On the **Condition** tab, when you select the Signal name field, the most commonly used signals are displayed in the drop-down list. Select one of these popular signals or select **See all signals** if you want to choose a different signal for the condition. If you chose to **See all signals** in the previous step, use the **Select a signal pane** to search for the signal name or filter the list of signals. Filter by:
	- **Signal type**.  The type of alert rule you're creating.
	- **Signal source**. The service sending the signal. The list is prepopulated based on the type of alert rule you selected.
1. The next step depends on the type of alert that you are creating:
	- **Metric alert**. Provide time range and time series, a threshold, operator, aggregation, and when to evaluate. 
	- **Log alert**. Write a query that returns the log events for which you want to create an alert. The condition tab will be populated based on your log query. Select threshold values to trigger the alert. 
	- **Activity log alert**. Select the chart period and values for the event level, status, and event initiated by related to the activity.
	- **Resource health alert**. Provide details for the Event status, Current resource status, Previous resource status and reason type fields.
	- Service health alert. Provide details for the following fields: Azure services, Azure regions, event types.
1. On the **Actions** tab, select or create the required action groups.
1. On the **Alert Rule Details** page, specify the subscription and resource group that will host the alert. Also provide an alert name, description and severity.

## Manage alert rules

You manage alert rules from the Alerts page in the Azure portal.

:::image type="content" source="../media/monitor-alerts.png" alt-text="Screenshot of the Alerts page in Azure Monitor, displaying a list of all current alerts." border="true":::

You can filter the list of Alert rules using the available filters:

- Subscription
- Alert condition
- Severity
- User response
- Monitor service
- Signal type
- Resource group
- Target resource type
- Resource name
- Suppression status

If you select a single alert rule, you can edit, disable, duplicate, or delete the rule in the alert rule pane. If you select multiple alert rules, you can enable or disable the selected rules. Selecting multiple rules can be useful when you want to perform maintenance on specific resources.
