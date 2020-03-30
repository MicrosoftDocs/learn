As an IoT admin, you need to get familiar with the left-hand menu for your IoT Hub. In this unit, we examine a number of the most-commonly used of these menu items. We don't examine them all, as many won't make sense until you've specific resources that will show up when you select these entries. No need to try to learn everything at once, the purpose of this unit is to identify the menu items most valuable to you when you begin your adventure into IoT hub administration.

## Explore the left-hand IoT hub menu

This section will help you build up a _todo_ list of other Learn modules relevant to you.

Start by clicking on the **Overview** menu entry.

### Overview

The overview contains some useful data, if you scroll to the bottom of the page you'll see two charts. By default, the **Telemetry data sent**, and the **Successful twin reads from back end** metrics are displayed here. These charts are a good place to go to when verifying the telemetry from a device is being received.

[![Screenshot showing the default charts in the IoT hub overview](../media/iot-admin-overview.png)](../media/iot-admin-overview.png#lightbox)

The overview, however, is not the most useful of the menu entries, as we'll see as we explore the menu. You can click on **Activity log**, though you may not understand what and why the entries are there. Logs often contain too much information! Also, click on **Diagnose and solve problems**. This page is a resource to go to if issues arise. No guarantee it will have the information you need, but it might.

[![Screenshot showing the troubleshooting options for an IoT hub](../media/iot-admin-common-problems.png)](../media/iot-admin-common-problems.png#lightbox)

Next, locate the **Settings section**.

### Settings

The important entry here is **Shared access policies**. You have already used this entry to extract the primary key for your hub. This entry is used to get the keys for all the policies that have been defined for the hub. You can create custom policies if needed. The default list of policies is shown in the following image, each having its own set of keys.

[![Screenshot showing the default list of hub access policies](../media/iot-admin-policies.png)](../media/iot-admin-policies.png#lightbox)

Another useful entry is **Properties**. Click on this entry to bring up a range of strings that apply to your hub, including name, region, subscription, and so on. This entry is just a good point of reference, something to check if you get an unexpected error, for example. Note too, that you can copy any of the strings using the icon to the right.

[![Screenshot showing the hub properties page](../media/iot-admin-properties.png)](../media/iot-admin-properties.png#lightbox)

Now, locate the **Explorers** section.

### Explorers

The **IoT devices** entry, which you've already used, is one of the most important entries in the left-hand menu. When you start adding multiple devices to a hub, you'll see how helpful this entry is in administering remote devices. One of the main uses of this entry is to locate the _device_ connection strings and keys. Device keys are distinct from the _service_ keys for the hub itself.

For more experience with devices, consider adding the following two Learn modules to your todo list:
- [Remotely monitor and control devices with Azure IoT Hub](https://docs.microsoft.com/learn/modules/remotely-monitor-devices-with-azure-iot-hub/)
- [Automate IoT devices management with Azure IoT Hub](https://docs.microsoft.com/learn/modules/automate-iot-devices-management-with-azure-iot-hub/)

Next, locate the **Security** section.

### Security

Click on the **Overview** menu entry for this section. There will be nothing dramatic in this example, but you can see where to go to, for security recommendations, when you've a production hub running.

[![Screenshot showing the hub security overview](../media/iot-admin-security.png)](../media/iot-admin-security.png#lightbox)

If securing devices is important to your scenarios, add the following module to your todo list: 
[Automatically provision IoT devices securely and at scale with the Device Provisioning Service](https://docs.microsoft.com/learn/modules/securely-provision-iot-devices-at-scale-with-device-provisioning-service/).

Finally, locate the **Monitoring** section.

### Monitoring

You have already used **Metrics**, in the previous unit. Perhaps the next-most useful entry is **Alerts**. Alerts fire when certain conditions, usually errors or warnings, are met.

To get some more detailed experience with metrics, and to set up some alerts, add the following module to your todo list:
[Manage your Azure IoT Hub with alerts and metrics](https://docs.microsoft.com/learn/modules/manage-azure-iot-hub-with-metrics-alerts/).

### Next steps

Perhaps you've created a todo list of one or two Learn modules, to investigate further at a later date! Learning one step at a time is a good way to go with IoT hub. You have completed this module, almost. Let's finish with a summary and short knowledge check.
