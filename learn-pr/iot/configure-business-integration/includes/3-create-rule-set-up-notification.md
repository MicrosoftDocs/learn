You can use Azure IoT Central to remotely monitor your connected devices. Azure IoT Central rules enable you to monitor your devices in near real time and automatically invoke actions, such as send an email. In just a few steps, you can define a condition to monitor telemetry from your devices and configure a corresponding action.

Devices use telemetry to send numerical data from the device. A rule triggers when the selected device telemetry crosses a specified threshold.

## Create a rule in the IoT Central UI

You can open a new rule in the IoT Central UI as follows:

1. In the left pane, select **Rules**.
1. To add a new rule, select **+ New**.
1. Enter a name that identifies the rule.

With your rule open in the UI, you can set the target devices, define conditions for the rule

### Select target devices

Use the target devices section to select on what kind of devices this rule will be applied. Filters allow you to further refine what devices should be included. The filters use properties on the device template to filter down the set of devices. Filters themselves don't trigger an action.

### Use multiple conditions

Conditions are what rules trigger on. You can add multiple conditions to a rule and specify if the rule should trigger when all the conditions are true or any of the conditions are true. For example, if you are using sensors to manage the environmental conditions in a work space, you could configure a rule to trigger when the reported temperature exceeds 80° F.

You can add multiple conditions to a rule by selecting **+ Condition**. You can select whether the rule will trigger when all conditions are met or when any of the conditions are met by selecting the appropriate option from the drop down. If you're using time aggregation with multiple conditions, all the telemetry values must be aggregated.

> [!NOTE]
> Rules are evaluated based on the messages sent by a device. Consider a rule that is configured to trigger when all conditions are met. If two conditions are being evaluated, such as temp and humidity values, the message is expected to carry both temp and humidity. If the message does not include both values, the condition is evaluated to false.

### Use aggregate windowing

You can specify a time aggregation to trigger your rule based on a time window. Rule conditions evaluate aggregate time windows on telemetry data as tumbling windows. If there are any property filters in the rule, they're applied at the end of the time window.

### Configure an email action

When you create an email action, the email address must be a user ID in the application, and the user must have signed in to the application at least once. You can also specify a note to include in the email. IoT Central shows an example of what the email will look like when the rule triggers.

## Delete a rule

If you no longer need a rule, delete it by opening the rule and choosing **Delete**.

## Enable or disable a rule

Choose the rule you want to enable or disable. Toggle the **Enabled** / **Disabled** button in the rule to enable or disable the rule for all devices that are scoped in the rule.
