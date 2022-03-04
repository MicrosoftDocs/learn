System Monitor (Sysmon) is a Windows system service, and device driver that remains resident across system reboots to monitor and log system activity to the Windows event log once installed on a system. It provides detailed information about process creations, network connections, and changes to file creation time. By collecting the events it generates using Windows Event Collection or SIEM agents and then analyzing them, you can identify malicious or anomalous activity and understand how intruders and malware operate on your network.

Installing and configuring Sysmon is out of the scope of this training.  Because Sysmon is a telemetry tool that many organizations use, it is essential to know how to configure the Log Analytics Agent and Workspace to collect the Sysmon events.

After connecting the Sysmon agent to the windows machine perform the following to enable Microsoft Sentinel to query the logs:

1. Go to your Azure portal.

1. Select **Log Analytics workspaces** from Azure services.

1. Select your Log Analytics workspace for Sentinel.

1. In the Settings area select **Agents configuration**.

1. On the Windows event logs tab select **+ Add windows event log**.

1. In the **Add windows event log** search box, enter: *Microsoft-Windows-Sysmon/Operational* .  Sysmon is not in the list by default.

1. Then select the **Apply** button

This connection can also be made from within Sentinel under **Settings > Agents Configuration**.  Once configured, the Sysmon events will be available in the Event table.  

:::image type="content" source="../media/sysmon.png" alt-text="Sysmon configuration" lightbox="../media/sysmon.png":::

