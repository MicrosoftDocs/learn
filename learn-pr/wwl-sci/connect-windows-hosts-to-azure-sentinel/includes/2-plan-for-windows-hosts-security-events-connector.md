The Security Events connector lets you stream all security events from your Windows systems (servers and workstations, physical and virtual) to your Azure Sentinel workspace. This enables you to view Windows security events in your dashboards, use them to create custom alerts, and rely on them to improve your investigations, giving you more insight into your organization's network and expanding your security operations capabilities. You can select which events to stream from among the following sets:

- All events - All Windows security and AppLocker events.

- Common - A standard set of events for auditing purposes. A full user audit trail is included in this set. For example, it contains both user sign-in and user sign-out events (event IDs 4624, 4634). There are also auditing actions such as security group changes, key domain controller Kerberos operations, and other types of events in line with accepted best practices.

- The Common event set may contain some types of events that aren't so common. This is because the main point of the Common set is to reduce the volume of events to a more manageable level while still maintaining full audit trail capability.

- Minimal - A small set of events that might indicate potential threats. This set does not contain a full audit trail. It covers only events that might indicate a successful breach and other significant events with low rates of occurrence. For example, it contains successful and failed user logons (event IDs 4624, 4625). Still, it doesn't contain sign-out information (4634), which, while important for auditing, is not meaningful for breach detection and has a relatively high volume. Most of this set's data volume comprises sign-in events and process creation events (event ID 4688).

- None - No security or AppLocker events. (This setting is used to disable the connector.)

:::image type="content" source="../media/security-events-connector.png" alt-text="Security Events Connector Page." lightbox="../media/security-events-connector.png":::

## Connect Azure Windows Virtual Machines

To view the connector page:

1. Select **Data connectors page**.

1. Select **Security Events**.

1. Then select the **Open connector** page on the preview pane.

1. Verify that you have the appropriate permissions as described under Prerequisites.

1. Select **Install agent on Azure Windows Virtual Machine**, and then on the link that appears below.

1. For each virtual machine that you want to connect, select its name in the list that appears on the right, and then select **Connect**.

1. Select which event set ([All, Common, or Minimal](https://docs.microsoft.com/azure/sentinel/connect-windows-security-events?azure-portal=true)) you want to stream.

1. Select **Update**.

## Connect non-Azure Windows Machines

To view the connector page:

1. Select **Data connectors** page.

1. Select **Security Events**.

1. Then select the **Open connector** page on the preview pane.

1. Verify that you have the appropriate permissions as described under Prerequisites.

1. Select **Install agent on non-Azure Windows Machine**, and then on the link that appears below.

1. Select the appropriate download links that appear on the right, under Windows Computers.

1. Using the downloaded executable file, install the agent on the Windows systems of your choice, and configure it using the Workspace ID and Keys that appear below the download links mentioned above.

1. Select which event set (All, Common, or Minimal) you want to stream.

1. Select **Update**.

:::image type="content" source="../media/agent-download.png" alt-text="Log Analytics agent download." lightbox="../media/agent-download.png":::
