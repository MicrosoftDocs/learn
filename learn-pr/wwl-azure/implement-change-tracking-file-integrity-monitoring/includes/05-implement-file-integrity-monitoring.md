File Integrity Monitoring in Microsoft Defender for Cloud identifies file and registry changes that might indicate potential security problems. Because cloud security is critical to Contoso management, you decide to implement and test File Integrity Monitoring.

## What is File Integrity Monitoring?

File Integrity Monitoring, also known as *change monitoring*, examines files and registries of operating system, application software, and others for changes that might indicate an attack.

> [!IMPORTANT]
> File Integrity Monitoring and Azure Change Tracking and Inventory are separate services. Current File Integrity Monitoring uses Microsoft Defender for Endpoint (MDE) and agentless scanning. It doesn't rely on the Change Tracking and Inventory agent.

File Integrity Monitoring analyzes changes and records information about the source, account, and process that initiated a change. Security administrators can use these details to determine whether a change is expected or indicates a possible attack.

You can use File Integrity Monitoring to validate the integrity of the following object types:

- Windows files
- Windows registry values
- Linux files

You access File Integrity Monitoring from Microsoft Defender for Cloud. Microsoft Defender for Cloud enables you to specify the object types that you want to monitor. Microsoft Defender for Cloud monitors files with File Integrity Monitoring enabled for activity such as:

- File and Registry creation and removal.
- File modifications (changes in file size, access control lists (ACLs), and hash of the content).
- Registry modifications (changes in size, access control lists, type, and the content).

## Understand data collection

File Integrity Monitoring uses two collection methods:

- **Microsoft Defender for Endpoint agent**: Streams change events for configured files and resources to the selected Log Analytics workspace in near real time.
- **Agentless scanning**: Collects file integrity insights on a 24-hour cadence and supports custom monitoring paths in addition to recommended resources.

Machines using the MDE collection method must run the supported Defender for Servers client. Verify the current minimum version in the [File Integrity Monitoring overview](/azure/defender-for-cloud/file-integrity-monitoring-overview#version-requirements).

## Enable File Integrity Monitoring

File Integrity Monitoring requires Defender for Servers Plan 2 on the subscription. The plan must deploy and integrate the MDE agent on protected machines. File Integrity Monitoring isn't enabled automatically when you enable Plan 2.

Use this high-level process:

1. In Microsoft Defender for Cloud, enable **Defender for Servers Plan 2** for the subscription.
2. Verify that protected machines run a supported MDE agent version.
3. Go to **Workload protections** > **File Integrity Monitoring**.
4. Select the subscription and enable File Integrity Monitoring.
5. Select an existing Log Analytics workspace or create one to store change events.
6. Review the recommended monitoring resources and configure custom rules for your environment.

> [!NOTE]
> The Log Analytics workspace stores FIM change logs. The workspace itself doesn't require a separate Microsoft Defender for Cloud Standard tier.

If a subscription uses legacy MMA- or AMA-based FIM, migrate it to the MDE-based experience. Don't install MMA for new deployments. For migration requirements and supported rule transfer, see [Migrate File Integrity Monitoring from MMA or AMA to Defender for Endpoint](/azure/defender-for-cloud/migrate-file-integrity-monitoring).

## Configure File Integrity Monitoring

After you enable File Integrity Monitoring, use its dashboard in Microsoft Defender for Cloud to review coverage, rules, and detected changes. Change records can identify:

- The affected machine, file, or registry key.
- The type and time of the change.
- The account and process associated with the change, when available.
- Whether the event came from the MDE agent or agentless scanning.

Use the workspace data and dashboard filters to investigate events. Consider the collection cadence when interpreting results: MDE events are near real time, while agentless events arrive approximately every 24 hours.

## Disable File Integrity Monitoring

If you no longer want to use File Integrity Monitoring, use the following procedure to disable it:

1. In Microsoft Defender for Cloud, go to **Workload protections** > **File Integrity Monitoring**.
2. Select the subscription.
3. Disable File Integrity Monitoring and confirm the change.

Disabling File Integrity Monitoring stops new collection. Existing records remain in the Log Analytics workspace according to its retention settings.
