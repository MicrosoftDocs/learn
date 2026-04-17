The *Windows Security Events via AMA* connector lets you stream all security events from the Windows machines connected to your Microsoft Sentinel workspace using the Windows agent. This connection enables you to view dashboards, create custom alerts, and improve investigation. These events give you more insight into your organization’s network and improve your security operation capabilities.

- All Security Events - All Windows security and AppLocker events.

- Common - A standard set of events for auditing purposes. A full user audit trail is included in this set. For example, it contains both user sign-in and user sign-out events (event IDs 4624, 4634). There are also auditing actions such as security group changes, key domain controller Kerberos operations, and other types of events in line with accepted best practices.

- The Common event set can contain some types of events that aren't so common. This is because the main point of the Common set is to reduce the volume of events to a more manageable level while still maintaining full audit trail capability.

- Minimal - A small set of events that might indicate potential threats. This set doesn't contain a full audit trail. It covers only events that might indicate a successful breach and other significant events with low rates of occurrence. For example, it contains successful and failed user logons (event IDs 4624, 4625). Still, it doesn't contain sign-out information (4634), which, while important for auditing, isn't meaningful for breach detection and has a relatively high volume. Most of this set's data volume comprises sign-in events and process creation events (event ID 4688).

- Custom - Custom allows you to specify other logs or to filter events using XPath queries.

    > [!NOTE]
    > Query the *SecurityEvents* table in Microsoft Sentinel *Logs* to see the events collected by the connector.

- The *Windows Security Events via AMA* connector uses Data Collection Rules (DCRs) to define the data to collect, and installs the Azure Monitor Agent (AMA) extension on the selected machines.

:::image type="content" source="../media/security-events-connector.png" alt-text="Screenshot of the Security Events Connector Page." lightbox="../media/security-events-connector.png":::

## Connect Azure Windows Virtual Machines

To view the connector page:

1. Select **Data connectors page**.

1. Select **Windows Security Events via AMA**.

1. Then select the **Open connector page** button on the preview pane.

1. Verify that you have the appropriate permissions as described under Prerequisites.

1. In the *Configuration* section, select the **+Create data collection rule** button.

1. Enter a *Rule name*, select the appropriate *Subscription* and *Resource group* where the data collection rule (DCR) will be created.

1. Select **Next: Resources**.

1. Expand your *Subscription* under *Scope* on the *Resources* tab.

    > [!TIP]
    > You can expand the whole *Scope* hierarchy by selecting the ">" before the *Scope* column.

1. Expand the resource group, and then select Azure virtual machines.

1. Select **Next: Collect**.

1. Review the different Security Event collection option. The default is Keep *All Security Events*.

1. Select **Next: Review + create**.

1. Select **Create** to save the Data Collection Rule.

1. Wait a minute and then select **Refresh** to see the new data collection rule listed.

## Connect non-Azure Windows Machines

In this task, you add an Azure Arc connected, non-Azure Windows virtual machine to Microsoft Sentinel.  

   > [!NOTE]
   > The *Windows Security Events via AMA* data connector requires Azure Arc for non-Azure devices.

To view the connector page:

1. Select **Data connectors** page.

1. Select **Windows Security Events via AMA**.

1. Then select the **Open connector** page on the preview pane.

1. Verify that you have the appropriate permissions as described under Prerequisites.

1. In the *Configuration* section, edit the previously completed *data collection rule* by selecting the *pencil* icon.

1. Expand your *Subscription* under *Scope* on the *Resources* tab.

    > [!TIP]
    > You can expand the whole *Scope* hierarchy by selecting the ">" before the *Scope* column.

1. Expand the resource group, and then select Azure virtual machines.

    > [!IMPORTANT]
    > If you don't see any non-Azure Windows machines, open *Azure Arc* to verify the machines are connected to Azure Arc.

1. Select **Next: Collect**.

1. Review the different Security Event collection option. The default is Keep *All Security Events*.

1. Select **Next: Review + create**.

1. Select **Create** to save the Data Collection Rule.

1. Wait a minute and then select **Refresh** to see the new data collection rule listed.
