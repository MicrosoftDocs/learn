Fabrikam Residences needs to understand changes to its servers, keep operating systems updated, and automate recurring operational tasks. Azure Change Tracking and Inventory, Azure Update Manager, and Azure Automation address these different needs for Azure Arc-enabled servers.

## Track changes and inventory with Azure Monitor Agent

Azure Change Tracking and Inventory tracks installed software, files, Windows registry settings, Windows services, and Linux daemons on supported machines. Fabrikam can use inventory to identify versions of its line-of-business application before an upgrade, and change records to investigate unexpected configuration changes.

The service uses the Change Tracking extension and Azure Monitor Agent (AMA) to send data to a Log Analytics workspace. A Change Tracking data collection rule (DCR) defines the collection configuration and destination. Use Change Tracking extension version 2.20.0.0 or later, and associate only one Change Tracking DCR with a machine.

Use the policy initiative from the previous unit for onboarding at scale. To enable an individual server in the Azure portal:

1. Open the Arc-enabled machine.
1. Select **Operations** > **Change tracking**.
1. Choose **Enable change tracking and inventory feature with AMA**, and select **Enable**.

After onboarding, review the machine's change and inventory views. In the connected workspace, `ConfigurationChange` contains change records and `ConfigurationData` contains inventory records. Configure the files and registry keys you want to track; don't assume that every file or key is monitored automatically. Change Tracking and Inventory reports changes but doesn't enforce the desired configuration.

See Azure Change Tracking and Inventory overview and Change Tracking and Inventory portal onboarding quickstart in More Info in the Summary unit.

## Manage operating system updates with Azure Update Manager

Use Azure Update Manager to assess and manage updates for supported Windows and Linux Azure VMs and Azure Arc-enabled servers. You can check update compliance, install updates on demand, or schedule installations within a maintenance window.

Azure Update Manager uses the Azure VM or Azure Arc management platform and its update extensions. The extensions are installed automatically when an Update Manager operation first needs them. Update Manager doesn't require an Automation account, a Log Analytics workspace, or AMA.

Before you begin, review Update Manager supported operating systems, Update Manager supported regions, and Update Manager permissions in More Info in the Summary unit. In both support references, use the **Azure Arc-enabled servers** view for this exercise. Check connectivity to Azure Arc and the machine's configured update sources. For Arc-enabled servers, **Azure Connected Machine Resource Administrator** provides machine update permissions. Scheduling also requires permissions to create maintenance configurations and their assignments; machine permissions alone aren't sufficient.

Follow these steps to assess and schedule updates:

1. In the Azure portal, open **Azure Update Manager**, select **Machines**, and select the Arc-enabled servers to assess. Select **Check for updates** and review the assessment results.
1. For ongoing visibility, enable periodic assessment. At scale, assign **Configure periodic checking for missing system updates on Azure Arc-enabled servers** through Azure Policy. Create separate assignments for Windows and Linux, set the assessment mode to **AutomaticByPlatform**, and remediate existing machines. This checks for missing updates every 24 hours; it doesn't install them.
1. In Azure Update Manager, select **Schedule updates**. Create a maintenance configuration in the same subscription as the target machines, with **Maintenance scope** set to **Guest (Azure VM, Azure Arc-enabled VMs/servers)**. Specify the start time, time zone, maintenance window, and recurrence.
1. Select the target machines, update classifications and any inclusion or exclusion rules, and the reboot setting. Review the configuration and select **Create**. Coordinate the maintenance window and reboot behavior with the application's availability requirements.
1. After the scheduled run, review update installation history, failures, and pending reboots. Investigate failed installations rather than treating a successful assessment as proof that updates were installed.

> [!NOTE]
> The **Customer Managed Schedules** patch-orchestration prerequisite applies to Azure VMs, not Azure Arc-enabled servers. Machines must be powered on and connected for their scheduled update operations.

See Update Manager prerequisites, Periodic assessment at scale, and Scheduled patching in More Info in the Summary unit.

## Run operational tasks with Azure Automation

Azure Automation stores, schedules, and runs runbooks for repeatable operational tasks. Use an **extension-based Hybrid Runbook Worker (V2)** to execute a runbook on an Arc-enabled server or to reach resources on its local network. For example, Fabrikam can run an application health check or collect diagnostic information after a deployment.

Before deployment, have an Automation account, a connected Arc-enabled server with its system-assigned managed identity enabled, and the permissions to manage the worker group and install the extension. Check the worker's supported operating systems, network requirements, and the runtimes and modules required by your runbook.

Follow these steps to onboard a worker and run a job:

1. Open the Automation account and select **Process Automation** > **Hybrid worker groups** > **Create hybrid worker group**.
1. Enter a group name. Use **Default** credentials for Linux workers. For Windows workers, use **Default** or select **Custom** and an existing credential asset appropriate for the runbook.
1. On **Hybrid workers**, select **Add machines**, choose the Arc-enabled server, and select **Add**. Select **Review + Create**, then **Create**.
1. Wait for the extension deployment to succeed. In the group, verify that the worker's platform is **Extension based (V2)**.
1. If you selected **Custom** for a Windows worker, have a server administrator grant the account in the selected credential asset read access to `C:\ProgramData\AzureConnectedMachineAgent\Tokens` and read and execute access to `C:\Packages\Plugins\Microsoft.Azure.Automation.HybridWorker.HybridWorkerForWindows`. Complete this on each Windows Arc-enabled worker in the group before testing or starting a runbook. This step doesn't apply to Linux workers or the **Default** credential option.

   > [!IMPORTANT]
   > When User Account Control (UAC) is enabled, grant these permissions directly to the account rather than relying on group membership. An Azure Connected Machine agent update can remove the custom account's access to the Tokens folder. Recheck that access after an update and reapply the required permission if necessary. Missing permissions can cause jobs to be suspended. See Permissions for Hybrid worker credentials in More Info in the Summary unit.

1. Test and publish a runbook. When starting the published runbook, set **Run on** to **Hybrid Worker** and select the worker group, then review the job status and output.

Installing the worker doesn't grant a runbook permission to all resources. Configure the execution identity and grant only the permissions needed by the task. If a task must run on one specific server, use a worker group containing only that server; a job assigned to a group isn't broadcast to every worker in the group.

For detailed setup and execution guidance, see Deploy an extension-based worker and Run runbooks on a hybrid worker in More Info in the Summary unit.
