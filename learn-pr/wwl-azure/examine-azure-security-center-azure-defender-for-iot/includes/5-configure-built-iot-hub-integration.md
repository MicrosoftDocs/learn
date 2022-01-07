The built-in capabilities of Azure Defender for IoT enable you to use the service without developing custom Azure Defender for IoT security agents.

If Azure Defender for IoT was previously disabled, you can re-enable it as follows:

 -  Use the Azure portal to open IoT Hub.
 -  On the left-side menu under Security, select Settings.
 -  On the Settings page, select Data Collection, and then verify that Enable Azure Defender for IoT is enabled.

### Geolocation and IP address handling

To secure your IoT solution, IP addresses of incoming and outgoing connections to and from your IoT devices, IoT Edge, and IoT Hub(s) are collected and stored by default. This information is essential to detect abnormal connectivity from suspicious IP sources. For example, when attempts are made to establish connections from an IP source of a known botnet or from an IP source outside your geolocation. Azure Defender for IoT service offers the flexibility to enable and disable collection of IP address data at any time.

To enable or disable collection of IP address data:

 -  Open your IoT Hub and then select Settings from the Security menu.
 -  On the Settings page, select Data Collection, and modify the IP data collection option as you wish.

### Log Analytics creation

When Azure Defender for IoT is turned on, a default Azure Log Analytics workspace is created to store raw security events, alerts, and recommendations for your IoT devices, IoT Edge, and IoT Hub. Each month, the first five (5) GB of data ingested per customer to the Azure Log Analytics service is free. Every GB of data ingested into your Azure Log Analytics workspace is retained at no charge for the first 31 days.

To change the workspace configuration of Log Analytics:

 -  Open your IoT Hub and then select Settings from the Security menu.
 -  On the Settings page, select Data Collection, and modify the Workspace configuration for Log Analytics as you wish.

### Customize your IoT security solution

By default, turning on the Azure Defender for IoT solution automatically secures all IoT Hubs under your Azure subscription.

In addition to automatic relationship detection, you can also pick and choose which other Azure resource groups to tag as part of your IoT solution.

Your selections allow you to add entire subscriptions, resource groups, or single resources.

After defining all of the resource relationships, Azure Defender for IoT works with Azure Security Center to provide you security recommendations and alerts for these resources.

To turn Azure Defender for IoT service on a specific IoT Hub on or off:

 -  Open your IoT Hub and then select Overview from the Security menu.
 -  Choose the Settings screen and modify the security settings of any IoT hub in your Azure subscription as you wish.

To add new resource to your IoT solution, do the following:

 -  Open your IoT Hub and then select Settings from the Security menu.
 -  On the Settings page, select Monitored Resources.
 -  Select Edit, choose the resources groups that belong to your IoT solution, and then select Add.
