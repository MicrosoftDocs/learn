Tailwind Traders has connected its servers to Azure Arc and wants to collect their security events in Microsoft Sentinel. First, create or select a Log Analytics workspace and enable Sentinel. Then configure the appropriate Azure Monitor Agent (AMA) connector and data collection rule (DCR) for each operating system.

Reference links for this unit are in the summary's **More info** section.

## Before you begin

Use Arc-enabled servers with a healthy Connected Machine agent connection. Check that the operating system is supported by both Azure Arc and AMA, and allow the outbound connections required by both agents. AMA on Arc-enabled servers uses the machine's system-assigned managed identity.

Confirm that your Azure permissions cover the following tasks. These are permission requirements, not a requirement to stack every example role when an existing scoped role already grants the necessary actions.

| Task | Documented permission or role |
| --- | --- |
| Enable Sentinel on the workspace | Contributor permissions on the subscription containing the workspace. |
| Install Content hub solutions | Microsoft Sentinel Contributor at the workspace resource-group scope. |
| Configure connectors | Read and write access to the workspace and the connector's required resources. |
| Create and associate DCRs | Monitoring Contributor or equivalent permissions at the relevant scopes. |
| Install AMA on Arc-enabled machines | Azure Connected Machine Resource Administrator or equivalent permissions for those machines. |

See *Microsoft Sentinel prerequisites*, *Microsoft Sentinel roles for specific tasks*, and *Azure Monitor Agent requirements*. Use a supported Log Analytics workspace and review *Microsoft Sentinel workspace requirements* and *Microsoft Sentinel pricing* before collecting data.

> [!NOTE]
> As of October 26, 2026, Microsoft Sentinel is still supported in the Azure portal. Microsoft has announced that this support ends after March 31, 2027. New or already-onboarded customers might be redirected to the Microsoft Defender portal. If redirected, follow *Onboard Microsoft Sentinel to the Defender portal*, then use that portal's Content hub and Data connectors for the following collection steps. Check *What's new in Microsoft Sentinel* for the latest transition date.

## Create a workspace and enable Sentinel

If Sentinel is already enabled on the intended workspace, skip to connector configuration. Otherwise, follow these steps:

1. In the Azure portal, search for **Microsoft Sentinel** and select **Create**.
1. Select an existing eligible workspace, or select **Create a new workspace**.
1. For a new workspace, specify the subscription, resource group, workspace name, and a supported region. Select **Review + Create**, then **Create**, and wait for deployment to finish.
1. Return to **Microsoft Sentinel** > **Create**, select the intended workspace, and select **Add**.

Creating the workspace doesn't by itself enable Sentinel, and enabling Sentinel doesn't by itself configure server event collection. Data is stored within each workspace; authorized users can also perform cross-workspace queries.

## Collect Windows security events

To collect Windows security events from your Arc-enabled servers:

1. Open the Sentinel workspace. In **Content hub**, find and install the **Windows Security Events** solution.
1. Open **Configuration** > **Data connectors**, select **Windows Security Events via AMA**, and open its connector page.
1. Select **Add data collection rule**. Enter the rule name, subscription, and resource group. Create the DCR in the same Azure region as the destination workspace.
1. Add the Windows Arc-enabled server resources to the rule.
1. Select the event set that meets your needs: **All**, **Common**, **Minimal**, or **Custom**. For this connector, All covers the Security log and supported AppLocker channels, not every Windows event log. Ensure the server's audit policy generates the events you intend to collect.
1. Review and create the rule. This portal workflow installs AMA on selected machines where it's missing and creates the machine associations. Confirm that deployment succeeds.
1. Confirm that the rule's destination is the intended Sentinel workspace and that the Security Event data flow is configured. This connector sends records to `SecurityEvent`; a generic Windows-events DCR can instead send records to `Event`.

For the full procedure and event-selection guidance, see *Collect Windows security events* and *Windows security event sets*. A DCR selects events to collect; it doesn't enable missing Windows audit policies. Use the *Windows audit-policy guidance* to configure and test the audit subcategories required by your selected events.

## Collect Linux Syslog events

To collect local Syslog events from your Linux Arc-enabled servers:

1. In the Sentinel workspace's **Content hub**, install the **Syslog** solution.
1. Open **Configuration** > **Data connectors**, select **Syslog via AMA**, and open its connector page.
1. Create a DCR, specify its name and resource group, and add the Linux Arc-enabled servers. Create the rule in the destination workspace's region.
1. Select the Syslog facilities and minimum severity levels needed for your scenario. A selected level includes messages at that level and more severe levels.
1. Review and create the rule. Confirm AMA installation, the machine association, and the intended Sentinel workspace destination.
1. Confirm that the server has a supported Syslog daemon and that AMA's local Syslog forwarding configuration is active. Ensure that the server actually generates messages matching the selected facilities and severity levels.

This procedure collects the Linux server's own events. A Linux server receiving events from other devices is a separate log-forwarder scenario that also requires source-device configuration, a listener, and network controls. Follow *Configure Syslog and CEF ingestion* for that scenario. Don't open a remote Syslog listener merely to collect local server events.

## Verify collection

Check that the appropriate **AzureMonitorWindowsAgent** or **AzureMonitorLinuxAgent** extension has provisioned successfully on each selected Arc resource. Open **Logs** for the destination workspace and run:

```kusto
Heartbeat
| where Category == "Azure Monitor Agent"
| where TimeGenerated > ago(15m)
| summarize LastHeartbeat = max(TimeGenerated)
    by _ResourceId, Computer, OSType
```

A recent heartbeat establishes that AMA is reporting to this workspace. It doesn't prove that the desired security events are being collected.

For Windows, run:

```kusto
SecurityEvent
| where TimeGenerated > ago(1h)
| summarize Events = count(), LastSeen = max(TimeGenerated)
    by _ResourceId, Computer, EventID
| order by LastSeen desc
```

For Linux, run:

```kusto
Syslog
| where TimeGenerated > ago(1h)
| summarize Events = count(), LastSeen = max(TimeGenerated)
    by _ResourceId, Computer, Facility, SeverityLevel
| order by LastSeen desc
```

Compare the returned `_ResourceId` values with the resource IDs of every Arc-enabled server associated with the rules, and compare the event types with the intended collection scope. For this local-server collection scenario, use the Arc resource ID to distinguish machines that report the same computer name. A grouped query can't show a server that sent no records during the selected window. Treat missing expected resource IDs or records with an empty resource ID as incomplete verification and investigate them. Generate an approved test event that matches the selected filters if normal activity hasn't produced one. Allow for collection latency; the Syslog connector guidance allows up to 20 minutes for its test data.

> [!NOTE]
> These queries verify collection of each server's own events. For a separate Syslog-forwarder scenario, distinguish the collection resource from the originating device by inspecting fields such as `CollectorHostName`, `HostName`, and `Computer`; don't assume the forwarder's Arc resource ID identifies every sending device. See *Standard log columns* and the *Syslog table schema*.

An empty result, or a table that hasn't yet been created by first ingestion, isn't proof that the source has no security activity. Check source audit/Syslog configuration, DCR filters and machine associations, extension health, the destination workspace, and outbound connectivity. See *Verify AMA installation* and the troubleshooting guidance in the connector documentation.

## Use the collected data

After confirming ingestion, enable and configure the analytics rules and workbooks you need from the installed solution. Data ingestion alone doesn't create all required detections or incidents.

Avoid overlapping DCRs that collect the same events to the same destination. Keep collection scoped to the intended machines and event types to control duplicate records and ingestion costs. If the exercise creates temporary collection resources, remove only those exercise-specific associations and rules after approval; don't delete a shared workspace or production data.
