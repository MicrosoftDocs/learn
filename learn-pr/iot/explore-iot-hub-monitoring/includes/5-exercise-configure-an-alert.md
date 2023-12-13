Alerts are used to proactively notify you when important conditions are found in your monitoring data. They allow you to identify and address issues before the users of your system notice them.

In your asset tracking scenario, you use sensors to track the containers that are being shipped to customers. Each time a sensor is added in a shipping container, it is autoprovisioned through a Device Provisioning Service. In production, you wish to send an alert if the number of sensors in transit exceed a predetermined capacity.

However, for your upcoming proof-of-concept review, to keep things simple, you want to create an Alert that triggers when the number of containers drops below one. To trigger the Alert, you use the number of connected devices events from IoT Hub.

In this exercise, you add an alert that triggers when one or more devices are connected. You fill out several tabs and associated dialog boxes to create the alert rule.

To create an alert rule:

1. In the portal menu, select **Home**.

1. In the **Resources** tile, select your IoT hub.

1. On the left-side menu, under **Monitoring**, select **Alerts**.

1. Select **Create alert rule**.

    The **Create an alert rule** blade should now be displayed.

1. Take a moment to review the **Create an alert rule** blade.

    The blade includes tabs for: **Scope**, **Condition**, **Actions**, **Details**, **Tags**, and **Review + create**. Scope includes two fields: **Resource** and **Hierarchy**. Notice that these fields are prepopulated with properties from your IoT hub. You can edit the preselected resource if needed.

1. Select the **Condition** tab, and then select **See all signals**.

    The **Select a signal** pane should be displayed. Notice that there is a paginated table of available signals displayed. The fields above the table filter the table to help in finding the signal types.

1. For **Signal type**, ensure that **All** is selected.

    If you select **Signal type**, you'll see that there are four available options: **All**, **Log search**, **Resource health**, **Metrics**, and **Activity Log**.
    The signal types available for monitoring vary based on the selected target(s). The signal types can be metrics, log search queries or activity logs.

1. For **Signal source**, ensure that **All** is selected.

    If you select **Signal source**, you'll see that there are the following options: **All**, **Log analytics**, **Log analytics (example query)**, **Resource health**, **Platform metrics**, and **Administrative**.
    The platform service provides metrics on service utilization, whereas the activity log tracks administrative activities.

1. In the **Search by signal name** textbox, type **connected**.

1. Notice that the list of signals is immediately filtered based on your entry.

1. Under **Signal name**, select **Connected devices**, then **Apply**.

    The pane updates to display a chart **Preview** that is similar to what you created for **Metrics**. The chart displays the values associated with the selected signal. In this case, the chart displays the average number of connected devices. Since we only have one connected device, the program that is sending telemetry, the chart only shows one device.

1. To the left of the chart is the area that defines the **Alert logic**. Scroll down and take a moment to review the **Alert logic** options.

    Notice that **Threshold** has two possible selections: **Static** and **Dynamic**. Also notice that **Static** is selected and **Dynamic** is unavailable for this signal type.

    As the names suggest, static thresholds specify a constant expression for the threshold, whereas dynamic threshold detection leverages advanced machine learning (ML) to learn metrics' historical behavior, identify patterns and anomalies that indicate possible service issues. You can learn more about dynamic thresholds at [Create a metric alert with dynamic thresholds](/azure/azure-monitor/platform/alerts-dynamic-thresholds).

    You are going to create a static threshold that raises an alert whenever the average **Connected devices** signal is less than 1.

1. In the **Aggregation type** dropdown, select **Average**.

1. In the **Operator** dropdown, select **Less than**.

1. In the **Threshold value** textbox, enter **1**.

    The **Preview** chart shows you the condition under which the display refreshes based on the **Alert logic** value settings that you entered. Below the **Preview** are **Time range** and **Time series** filters. These values determine the historical time period that is aggregated using the **Aggregation type** selected previously and how often the condition is evaluated.

1. In the **Unit** dropdown, select **Count**.

1. In the **Check every** dropdown, select **1 minute**.

1. In the **Lookback period** dropdown, select **1 Minute**.

    If the **Check every** is shorter than **Lookback period**, this results in a sliding window evaluation. For example if the **Lookback period** is 5 minutes and **Check every** is 1 minute, it means that every minute, the preceding 5 minutes of values is aggregated (in this case, averaged), and then evaluated against the condition. After a minute of time has passed, once again the preceding 5 minutes of data is aggregated; this includes one minute of new data and four minutes of data that was already evaluated. Thus, we have a sliding window that moves forward a minute at a time, but is always including 4 minutes of data that was also evaluated as part of an earlier window.

    Notice that the **Condition** is now populated and a **Estimated monthly cost** is displayed.

    Next, you configure the action taken when the alert condition is met.

1. Select **Next: Actions >**.

    Notice that no action group is selected. There are options to **Select action groups** and **Create action group**.

    An action group is a collection of notification preferences defined by the owner of an Azure subscription. An action group name must be unique within the Resource Group that it is associated with. Azure Monitor and Service Health alerts use action groups to notify users that an alert has been triggered. Various alerts can use the same action group or different action groups depending on the user's requirements. You can configure up to 2,000 action groups in a subscription. You can learn more about creating and managing action groups at [Action groups](/azure/azure-monitor/platform/action-groups).

1. Under **Actions**, select **Select action groups**.

    The **Add action groups** pane is displayed. If there are existing action groups available within the selected subscription, they are listed here. Notice that you can change the subscription and filter the list. In this exercise, you create a new action group.

1. Close the **Select action groups** pane, and then select **Create action group**.

    The **Create an action group** blade is displayed.

1. On the **Basics** tab, under **Subscription**, ensure that **Concierge Subscription** is selected.

1. In the **Resource group** dropdown, ensure that **<rgn>[sandbox resource group name]</rgn>** is selected.

    Action groups are usually shared across a subscription and would likely be centrally managed by the Azure subscription owner. As such they are more likely to be included in a common resource group rather than in a project specific resource group.

1. In the **Region** dropdown, select **Global**.

    Global requests from clients can be processed by action group services in any region. If one region of the action group service is down, the traffic is automatically routed and processed in other regions. As a global service, an action group helps provide a disaster recovery solution. Regional requests rely on availability zone redundancy to meet privacy requirements and offer a similar disaster recovery solution.

    The next area, **Instance details** is used to specify the full and display names for the group.

1. For **Action group name**, enter **Guided Project Email Action Group**.

    > [!NOTE]
    > An action group name must be unique within the Resource Group it is associated with.

1. For **Display name**, enter **GPEmailAG**.

    > [!NOTE]
    > The display name is used in place of a full action group name when notifications are sent using this group and is limited to a max of 12 characters.

1. Select **Next: Notifications >** to view the action group notification fields.

1. In the **Notification Type** dropdown, select **Email/SMS message/Push/Voice**.

1. For notification **Name**, enter **GPNotifications**.

1. In the **Email/SMS message/Push/Voice** pane, configure the following:

    1. Select **Email**, and then enter an email address that you have easy access to.

    1. Select **SMS**, and then enter the **Country code** and the **Phone number** for the phone that you wish to use to receive the SMS alert.

    1. Skip **Azure mobile app notification** and **Voice**.

    1. Under **Enable the common alert schema**, select **Yes**.

    There are many benefits to using the common alert schema. The common alert schema is a single extensible and unified alert payload that can be used across all the alert services in Azure Monitor. With the common alert schema, you can receive alert notifications with a consistent schema. You can learn more about the Common alert schema at [Common alert schema](/azure/azure-monitor/platform/alerts-common-schema).

1. At the bottom of the **Email/SMS message/Push/Voice** pane, to save the action configuration, select **OK**.

    The notification row should now show that Email and SMS message are selected. The **Edit details** icon can be selected if further changes are required.

1. Select **Next: Actions >**, to view the action group action fields.

    1. Open the **Action type** dropdown, and then review the available options.

        At this point, we could add multiple actions if we needed to launch some business integration via **WebHook** or an **Azure Function**. For this exercise, a simple notification is enough. Close the **Action type** dropdown without selecting anything.

    1. At the bottom of the **Add action group** blade, to validate this action group, select **Review + create**.

    1. Once the validation is complete, select **Create**.

    A few things happen at the same time. First, **Add action group** pane closes, leaving you on the **Create an alert rule** blade, with the new action group added to the list of **Action group name**.

    Then, in quick succession, you should receive both an SMS notification and an email, both of which inform you that you have been added to the **GPEmailAG** action group. In the SMS message, you can reply to the message to stop receiving future notifications. You can learn more about the options at [Action groups](/azure/azure-monitor/platform/alerts-sms-behavior). In the email, you have links that you can select to view the details on action groups and, towards the bottom of the email (in a smaller font) you can see the option to unsubscribe.

1. Select **Next: Details >** to advance to Alert rule details.

    1. In the **Subscription** field, select **Concierge Subscription**.

    1. In the **Resource group** dropdown, ensure that **<rgn>[sandbox resource group name]</rgn>** is selected.

    1. In the **Severity** field, ensure that **3 - Informational** is selected.

        In our scenario, this alert is informational and not indicative of any critical failure, therefore severity level 3 is the correct choice.

        > [!NOTE]
        > The severity level option range between **0 - Critical** and **4 - Verbose**.

    1. In the **Alert rule name** field, enter **Connected Devices Less than 1**.

        The name should be descriptive enough to identify the alert.

    1. In the **Alert rule description** field, enter **This alert is raised when the number of devices connected to your IoT hub is less than 1.**

        The description field is optional, but recommended.

    1. Select **Advanced options**.

    1. For the **Enable upon creation** field, ensure that the checkbox is selected (checked).

        It can take up to 10 minutes for a metric alert rule to become active.

    1. For the **Automatically resolve alerts** field, ensure that the checkbox is selected (checked).

        This ensures an alert is resolved should the condition no longer be met, and a new alert is not fired until the alert is resolved.

1. At the bottom of the blade, select **Review + create**, then select **Create**.

## Verify your work

The **Alerts** blade of your IoT Hub should now be displayed with alert filters and counts.

A message in the middle at the bottom of the display should show that there are no alerts found.

You can go back and edit or create new **Alert rules** or **Action groups** using the buttons near the top of the display.
