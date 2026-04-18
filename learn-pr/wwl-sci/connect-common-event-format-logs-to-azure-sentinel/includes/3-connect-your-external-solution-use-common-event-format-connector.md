You need to designate and configure a Linux machine to forward logs from your security solution to your Microsoft Sentinel workspace. This machine can be physical or virtual in your on-premises environment, an Azure VM, or a VM in another cloud.

The **Common Event Format (CEF) via AMA** connector uses a **Data Collection Rule (DCR)** to configure the **Azure Monitor Agent (AMA)** on your Linux forwarder. AMA handles both agent installation and log forwarding — no manual script installation is required.

When configured, AMA on the Linux forwarder:

- Listens for CEF messages from the built-in Linux Syslog daemon on TCP port 514
- Forwards CEF messages to your Microsoft Sentinel workspace, where they're parsed and enriched

## Set up the CEF via AMA connector

To configure the connector:

1. In the Microsoft Sentinel portal, select **Data connectors**.

1. Search for and select **Common Event Format (CEF) via AMA**.

1. Select **Open connector page** on the details pane.

1. Under **Configuration**, select **+Create data collection rule**.

1. On the **Basic** tab, enter a name for the data collection rule, then select your subscription and resource group.

1. On the **Resources** tab, select the Linux machine you designated as the log forwarder.

1. On the **Collect** tab, confirm the CEF facility and log level settings.

1. Select **Review + create**, then select **Create**. AMA is automatically installed on the Linux forwarder if it isn't already present.

1. Configure each network appliance to forward its syslog events to your Linux forwarder on UDP or TCP port 514.

:::image type="content" source="../media/common-event-format-connector.png" alt-text="Screenshot of the Common Event Format via AMA connector page in Microsoft Sentinel." lightbox="../media/common-event-format-connector.png":::

## Use the same machine to forward both plain Syslog and CEF messages

If you plan to use this log forwarder machine to forward both plain Syslog messages and CEF messages, edit the Syslog configuration file on each source machine that sends logs in CEF format. Remove the facilities used to send CEF messages to avoid duplicate events in the Syslog and CommonSecurityLog tables.

