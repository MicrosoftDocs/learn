Rules in IoT Central serve as a customizable response tool that triggers on actively monitored events from connected devices.

## Select target devices

Use the target devices section to select on what kind of devices this rule will be applied. Filters allow you to further refine what devices should be included. The filters use properties on the device template to filter down the set of devices. Filters themselves don't trigger an action. In the following screenshot, the devices that are being targeted are of device template type **Temperature controller**. The filter states that the rule should only include temperature controllers where the **Location (State)** property equals **Washington**.

:::image type="content" source="../media/rule-filter.png" alt-text="Screenshot that shows how to configure the target devices section of an IoT Central rule to target specific devices.":::

## Use multiple conditions

Conditions are what rules trigger on. You can add multiple conditions to a rule and specify if the rule should trigger when all the conditions are true or any of the conditions are true.

In the following screenshot, the conditions check when the temperature of both thermostats in the temperature controller are greater than 70. When both of these statements are true, the rule evaluates to true and triggers an action.

:::image type="content" source="../media/rule-conditions.png" alt-text="Screenshot that shows how to add multiple conditions to a rule and specify the conditions that will trigger the rule.":::

## Use aggregate windowing

You can specify a time aggregation to trigger your rule based on a time window. Rule conditions evaluate aggregate time windows on telemetry data as tumbling windows. If there are any property filters in the rule, they're applied at the end of the time window. In the diagram below, the time window is five minutes. Every five minutes, the rule evaluates on the last five minutes of telemetry data. The data is only evaluated once in the window to which it corresponds.

:::image type="content" source="../media/m12-l03-iot-central-rules-aggregate-windowing-tumbling-window-ccfadc30.png" alt-text="Diagram that shows how rule conditions evaluate aggregate time windows on telemetry data.":::

## Use rules with IoT Edge modules

A restriction applies to rules that are applied to IoT Edge modules. Rules on telemetry from different modules aren't evaluated as valid rules. Take the following as an example. The first condition of the rule is on a temperature telemetry from Module A. The second condition of the rule is on a humidity telemetry on Module B. Since the two conditions are from different modules, the set of conditions is invalid. The rule isn't valid and will throw an error when you try to save the rule.
