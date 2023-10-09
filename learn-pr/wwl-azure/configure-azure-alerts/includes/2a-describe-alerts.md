Azure Monitor captures logs and metrics telemetry data for your infrastructure or applications so you can analyze and identify potential problems. You can configure Azure alerts to initiate responsive action and send notifications based on your telemetry data. Azure alerts help you detect and address issues to keep your applications running and prevent service disruptions for your users.

### Things to know about Azure alerts

Let's examine how to work with Azure alerts and Azure Monitor.

- In the Azure portal, you configure Azure Monitor to capture telemetry data for your Azure services, resources, and applications.

- You create alerts for your Azure configuration to work with the captured telemetry data.

- An alert consists of _alert rules_ that combine the settings and conditions you want to monitor, including:
   - Resources to monitor
   - Signals or telemetry to gather from the resources
   - Conditions to match

- An alert rule specifies _action groups_ to fulfill responsive steps when an alert triggers, such as sending notifications.

- Each alert monitors your telemetry and captures a signal about changes to your specified resource.

- The alert rule captures the signal and checks if the signal matches your condition criteria.

- When your rule conditions match your telemetry data, an alert triggers and invokes the specified action groups.

- If you're monitoring multiple resources, the system evaluates your conditions separately for each resource, and alerts trigger for each resource separately.

The following diagram demonstrates the Azure alert process.

:::image type="content" source="../media/how-azure-monitor-alerts-work.png" alt-text="Illustration that shows how Azure Monitor alerts work as described in the text." lightbox="../media/how-azure-monitor-alerts-work-expanded.png" border="false":::

### Things to consider when using Azure alerts

The Azure Monitor alerts experience offers many benefits. As you review this list, consider how you can implement alerts to improve your monitoring and diagnostics solution.

| Benefit | Description |
| --- | --- |
| **Improved notification system** | Implement action groups for all newer alerts to access notifications. Define notifications and other actions and reuse these settings for multiple alerts. |
| **Unified authoring experience** | Easily create all your alerts in one place. Follow the same process to set up alerts for metrics, logs and activity logs across Azure Monitor, Log Analytics (in the Azure portal), and Azure Application Insights.
| **Combined view for Log Analytics alerts** | Monitor Log Analytics alerts for your subscriptions in the Azure portal, along with your other monitored resources and applications. Prior to the new Azure alerts experience, Azure Monitor (Log Analytics) alerts were displayed in a separate portal. |
| **Separation of active alerts and alert rules** | Differentiate between alert rules with conditions to trigger an alert and the active (fired) alert. Separate the operational and configuration views for your alerts, alert rules, and actions.
| **Better workflow** | Take advantage of the new Azure alerts authoring experience that guides you through the process of configuring alert rules. Get help with discovering and defining the settings and conditions to trigger your alerts. |