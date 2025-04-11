System Monitor (Sysmon) is a Windows system service, and device driver that remains resident across system reboots to monitor and log system activity to the Windows event log once installed on a system. It provides detailed information about process creations, network connections, and changes to file creation time. By collecting the events it generates using Windows Event Collection or SIEM agents and then analyzing them, you can identify malicious or anomalous activity and understand how intruders and malware operate on your network.

 > [!NOTE]
 > Installing and configuring Sysmon is out of the scope of this training. For more information on Sysmon, see [Sysinternals Sysmon](/sysinternals/downloads/sysmon).

After connecting the Sysmon agent to the windows machine, you install the *Windows Forwarded Events* Content hub solution which includes the *Windows Forwarded Events* data connector. The data connector allows you to stream all Windows Event Forwarding (WEF) logs from the Windows Servers connected to your Microsoft Sentinel workspace using Azure Monitor Agent (AMA). In the data connector configuration, you create *Data collection rules* (DCRs) to collect metrics and logs from the client operating system. Perform the following steps to create a DCR and enable Microsoft Sentinel to query the logs:

## Install the solution

Start by installing the solution that contains the data connector.

1. For Microsoft Sentinel in the Azure portal, under **Content management**, select **Content hub**. For Microsoft Sentinel in the Defender portal, select **Microsoft Sentinel** > **Content management** > **Content hub**.

1. Search for and select **Windows Forwarded Events**.

1. On the details pane, select **Install**.

## Configure the data connector

After the solution is installed, connect the data connector.

1. In the Microsoft Sentinel navigation menu expand **Configuration**,  and select **Data connectors**.

1. Select the **Windows Forwarded Events** Data connector.

1. Select **+Create data collections rule**.

:::image type="content" source="../media/windows-forwarded-events.png" lightbox="../media/windows-forwarded-events.png" alt-text="Screenshot that shows the Basics tab for a new data collection rule.":::

1. Fill in the following fields of the *Basic* tab:

| Setting | Description |
|:---|:---|
| **Rule Name** | A name for the DCR. The name should be something descriptive that helps you identify the rule. |
| **Subscription** | The subscription to store the DCR. The subscription doesn't need to be the same subscription as the virtual machines. |
| **Resource group** | A resource group to store the DCR. The resource group doesn't need to be the same resource group as the virtual machines. |

1. Select **Next:Resources >**.

1. In the *Resources* tab, expand the **Scope** column, and expand the Microsoft Azure subscription.

1. Expand the resource group or groups, and select the virtual machines you want to connect to Microsoft Sentinel.

1. Select the **Next: Collect >** button, and select **Custom** radio button.

1. As an example, you can enter the following events log location (XPath format) to collect Sysmon events:

 ```xml
 Microsoft-Windows-Sysmon/Operational!*
 ```

1. Select the **Add** button to add the Sysmon events log location.

1. Select the **Next: Review + create >** button, after validation passes, select **Create**.

:::image type="content" source="../media/sysmon-log-location.png" alt-text="Screenshot of Log Analytics Sysmon configuration." lightbox="../media/sysmon-log-location.png":::

 > [!NOTE]
 > At the end of this process, the Azure Monitor Agent is installed on any selected machines that don't already have the agent.

1. After the DCR is created, select the **Refresh** button to see the rule. You can also edit or delete existing rules from the **Configuration** section of the connector page.

This connector can use the Advanced Security Information Model (ASIM). Microsoft recommends that you use the ASIM normalization. For more information on ASIM, see [Advanced Security Information Model (ASIM)](/azure/sentinel/normalization).

1. On the **Windows Forwarded Events** connector page, **Configuration** section, select the **Deploy** button.

1. Fill-in the required fields of the **Custom deployment** ARM template, and select **Review + create**.

1. When validation passes, select **Create**.
