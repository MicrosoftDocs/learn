You can use Azure IoT Central to remotely monitor your connected devices. Azure IoT Central rules enable you to monitor your devices in near real time and automatically invoke actions, such as send an email. In just a few steps, you can define a condition to monitor telemetry from your devices and configure a corresponding action. This article explains how to create rules to monitor telemetry sent by the device.

Devices use telemetry to send numerical data from the device. A rule triggers when the selected device telemetry crosses a specified threshold.

## Create a rule

To create a telemetry rule, the device template must have at least one telemetry measurement defined.

1.  In the left pane, select Rules.
2.  To add a new rule, select **+**.
3.  Enter a name that identifies the rule, and the press Enter.
4.  Select a device template. By default, the rule automatically applies to all the devices associated with the device template. To filter for a subset of the devices, select **+ Filter** and use device properties to identify the devices. To disable the rule, toggle the Enabled/Disabled button in the rule header.

### Configure the rule conditions

Conditions define the criteria that the rule monitors. For example, if you are using sensors to manage the environmental conditions in a work space, you could configure a rule to fire when the reported temperature exceeds 80° F.

1.  Select a telemetry property from the Telemetry dropdown. For example, for an environmental sensor, you might choose telemetry for temperature values.
2.  Specify the conditional operator and value that you want associated with the telemetry data. For example, you might choose **Is greater than** as the **Operator** and enter **80** as the **Value**.
3.  Optionally, you can set a Time aggregation. When you select a time aggregation, you must also select an aggregation type, such as average or sum from the aggregation drop-down. Without aggregation, the rule triggers for each telemetry data point that meets the condition. For example, if the rule is configured to trigger when temperature is above 80 then the rule triggers almost instantly when the device reports temperature &gt; 80. With aggregation, the rule triggers if the aggregate value of the telemetry data points in the time window meets the condition. For example, if the rule is configured to trigger when temperature is above 80, time aggregation is set to 10 minutes, and the aggregation type is average, then the rule triggers when the device reports an average temperature &gt; 80, calculated over a 10-minute interval.

You can add multiple conditions to a rule by selecting **+ Condition**. You can select whether the rule will trigger when all conditions are met or when any of the conditions are met by selecting the appropriate option from the drop down. If you're using time aggregation with multiple conditions, all the telemetry values must be aggregated.

> [!NOTE]
> Rules are evaluated based on the messages sent by a device. Consider a rule that is configured to trigger when all conditions are met. If two conditions are being evaluated, such as temp and humidity values, the message is expected to carry both temp and humidity. If the message does not include both values, the condition is evaluated to false.

### Configure actions

After you define the condition, you set up the actions to take when the rule fires. Actions are invoked when all the conditions specified in the rule evaluate to true. Rules can be used to trigger up to five different actions. The available actions are: Email, Webhook, Azure Monitor Action Groups, Azure Logic Apps, and Microsoft Power Automate. For example, you could configure an email action for a rule as follows:

1.  Select **+ Email** in the **Actions** section.
2.  Enter a display name for the action, specify a recipient email address, and provide a message for the body of the email. For example, following along with the temperature scenario from above:
    
     -  Specify "Temperature warning" as the **Display name** for the action.
     -  Specify an email address that you can monitor during testing in the **To** field.
     -  Specify "You should check the device!" to appear in the body of the email in the **Note** field.
3.  To save the action, choose **Done**. You can add multiple actions to a rule.
4.  To save the rule, choose **Save**. The rule goes live within a few minutes and starts monitoring telemetry being sent to your application. When the condition specified in the rule is met, the rule triggers the configured email action.

## Delete a rule

If you no longer need a rule, delete it by opening the rule and choosing **Delete**.

## Enable or disable a rule

Choose the rule you want to enable or disable. Toggle the Enabled / Disabled button in the rule to enable or disable the rule for all devices that are scoped in the rule.

## Enable or disable a rule for a device

Choose the rule you want to enable or disable. Add a filter in the **Scopes** section to include or exclude a certain device in the device template.
