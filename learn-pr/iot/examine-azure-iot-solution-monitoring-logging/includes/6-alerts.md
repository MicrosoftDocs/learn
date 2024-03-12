Azure Monitor alerts proactively notify you when important conditions are found in your monitoring data. They allow you to identify and address issues in your system before your customers notice them.

You can access alerts by selecting **Alerts** from within the Azure portal IoT Hub **Monitoring** section.

## How alerts work

The following diagram shows an overview of how alerts work.

:::image type="content" source="../media/alerts-overview.png" alt-text="Diagram that explains Azure Monitor alerts.":::

An alert rule monitors your data and captures a signal that indicates something is happening on the specified resource. The alert rule checks to see if the signal meets the criteria of the condition.

An **alert rule** combines:

* The resources to be monitored
* The signal or data from the resource
* Conditions

An **alert** is triggered if the conditions of the alert rule are met. The alert initiates the associated action group and updates the state of the alert. If you're monitoring more than one resource, the alert rule condition is evaluated separately for each of the resources, and alerts are fired for each resource separately.

Alerts are stored for 30 days and are deleted after the 30-day retention period. You can see all alert instances for all of your Azure resources on the **Alerts** page in the Azure portal.

## Alert elements

Alerts consist of:

* **Action groups**: These groups can trigger notifications or an automated workflow to let users know that an alert is triggered. Action groups can include:

  * Notification methods, such as email, SMS, and push notifications
  * Automation runbooks
  * Azure functions
  * ITSM incidents
  * Logic apps
  * Secure webhooks
  * Webhooks
  * Event hubs
* **Alert conditions**: These conditions are set by the system. When an alert fires, the alert condition is set to **fired**. After the underlying condition that caused the alert to fire clears, the alert condition is set to **resolved**.
* **User response**: The response is set by the user and doesn't change until the user changes it.
* **Alert processing rules**: You can use alert processing rules to make modifications to triggered alerts as they're being fired. You can use alert processing rules to add or suppress action groups, apply filters, or have the rule processed on a predefined schedule.

## Types of Azure IoT Hub alerts

You can set alerts on Azure IoT Hub metrics, logs, and the activity log. Different types of alerts have benefits and drawbacks. For more information about each alert type and how to choose which alert type best suits your needs, see [Choosing the right type of alert rule](/azure/azure-monitor/alerts/alerts-types).

When you create an alert rule based on platform metrics (collected in units of count), some aggregations may not be available or usable. For more information, see [Supported aggregations](/azure/iot-hub/monitor-iot-hub-reference#supported-aggregations) in Monitoring Azure IoT Hub data reference.
