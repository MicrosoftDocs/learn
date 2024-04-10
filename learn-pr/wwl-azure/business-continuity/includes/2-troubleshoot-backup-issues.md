## Review backup status in the Azure portal

The Azure Backup Center is a one-stop location to manage Azure backups including:

- Azure VM backup

- SQL in Azure VM backup

- SAP HANA in Azure VM backup

- Azure Files backup

- Azure Blobs backup

- Azure Managed Disks backup

- Azure Database for PostgreSQL Server backup

For information about supported scenarios, see the  [Support matrix for Backup center](/azure/backup/backup-center-support-matrix).

In the Azure portal, search for Backup center in the Search bar. You can then pin the Backup center to your dashboard. Use the filter options to view the specific jobs you are interested in. You can filter on the following parameters:

- Datasource subscription, resource group, location, tag, or type

- Vault

- Protection status

Use the Backup jobs menu to review the job status. You can review the time the backup started, the duration, the job operation, and its status. You can also display the backup instance associated with the job, the subscription, resource group, and location.

Select an item in the grid to get more details. Right-click an item to go to the resource and take any necessary actions.

### Review and respond to backup alerts

From the Backup center left menu, under Monitoring + reporting, select Alerts (preview).

By default, the summary displays open alerts in the last 24 hours. You can also filter by a range of parameters:

- Datasource subscription

- Datasource resource group

- Datasource location

- Datasource type

- Vault

- Severity (0 = critical, 1 = error, 2 = warning, 3 = informational, and 4 = verbose)

- State (New, acknowledged, closed)

- Type (Security alert, configured alert)

- Signal type (metric or log)

- Time range (24 hours, week, two weeks, 30 days, or custom)

    :::image type="content" source="../media/2-backup-reports.png" alt-text="Screenshot that shows Backup Report." lightbox="../media/2-backup-reports.png":::

### Alerts by email notification

You can get email notifications when alerts are triggered by creating an alert processing rule.

- From the Azure portal, go to the Backup center.

- From the left menu, select Alerts (Preview).

- From the top menu, select Alert processing rule (preview).

- From the top menu, select Create.

- In the Scope section, select Select scope to display the Select Scope pane.

- Select the resource you want the alert processing rule applied to by either selecting from the drop-down list, or by typing to filter the resources. The matching resources are then displayed. Use the check boxes to select the resources you want the alert processing rule to apply to.

- Alternatively, you can apply the rule for all resources within a subscription. When the Select Scope pane is displayed, select the check box next to the correct subscription.

- In the Filter section, you can apply one or more filters. For example, select Severity to generate notifications for alerts of a certain severity.

- Under Rule Settings, create an action group (or use an existing one). An action group is the destination to which the alert notification should be sent, such as an email address.

- On the Basics tab, select the name of the action group, the subscription, and resource group under which it should be created.

- On the Notifications tab, select Email/SMS message/Push/Voice and enter the recipient’s details.

- Test the action group. A test email is sent to the specified email addresses.

- Select Review + Create, and then Create to save the action group.

- Select Create to save the action rule.

### Review and interpret backup logs

To review and interpret backup logs, select the Backup Reports menu in the Backup center. When configured, Azure Backup Reports allow you to audit your backups and restores, analyze trends, and track and forecast usage.

Configure diagnostics settings for a Recovery Services vault by going to the vault and selecting Diagnostics settings. Select + Add Diagnostic Setting for the metrics you want to collect. Under Destination details, select the destinations that you want to stream them to. This includes Log Analytics workspace as an option.

The following views are available from the tabs:

- Overview – select specific subscriptions and workspaces, and links to more information.

- Summary – a high-level overview of your backup estate.

- Backup Items – cloud storage consumed at a backup item level.

- Usage – key billing parameters for your backups.

- Jobs – view long-running trends on jobs, such as the number of failed jobs per day, and the top causes of job failure. 

- Policies – information on active policies, such as the number of associated items, and the total cloud storage consumed by items backed up under a given policy. 

- Optimize – potential cost optimization opportunities for your backups. 

- Policy adherence – success of backups per day for every backup instance.

    :::image type="content" source="../media/2-backup-center.png" alt-text="Screenshot of Backup Center.":::

## Troubleshooting backups with Microsoft Azure Recovery Services (MARS)

> [!NOTE] 
> Microsoft documentation refers to both the backup agent and MARS interchangeably: both refer to the same service name (cbengine). In this module, it is referred to as Microsoft Azure Recovery Services (MARS).

Microsoft Azure Recovery Services is also known as the backup agent. This is the Azure service that is used to back up data. The MARS agent can run on:

- On-premises Windows machines.

- Azure VMs running Windows. The MARS agent runs side by side with the Azure VM backup extension. The agent backs up specific files and folders on the VM.

- A Microsoft Azure Backup Server (MABS) or a System Center Data Protection Manager (DPM) server.

Use the MARS agent to back up files, folders, and Windows machines either on-premises or in the cloud. Data is backed up to an Azure Recovery Services Vault.

To troubleshoot with the MARS agent, first check basic issues, and then more advanced issues.

### Step 1: Basic troubleshooting

Check that:

- You have network connectivity between the MARS backup agent and Azure.

- The MARS agent is running. You might need to restart it and ensure the MARS agent is ready.

- There is 5%-10% free space in the scratch folder.

- Antivirus software or any other process is not interfering with the backup.

- Any warning messages have been reviewed.

### Step 2: Troubleshoot versions and other steps

- For offline backups, ensure Azure PowerShell 3.7.0 is installed on both computers.

- The operating system and MARS agent are up-to-date.

- [Unsupported drives, and files with unsupported attributes, are excluded from backup](/azure/backup/backup-support-matrix-mars-agent).

- Are manual backups working, but scheduled backups are not?

- Are all relevant clocks set to the correct time zone?

## Troubleshoot backing up Azure VMs

When configuring backups for an Azure VM, follow best practice guidelines. If you encounter problems with backing up an Azure VM, try the following:

### Step 1: Basic troubleshooting

- Is the Azure VM provisioning state ‘Running’? The backup will not run if it is in a Stopped/Deallocated/Updating state. You might see the error message: VM is not in a state that allows backups.

- Are there any pending operating system updates or does the VM need to reboot? Install system updates and reboot before retrying the backup.

- Does the Azure VM have internet connectivity?

- Is another backup service running? Two backup services cannot run at the same time. If you suspect another backup has not left a snapshot extension, [uninstall extensions](/azure/backup/backup-azure-troubleshoot-vm-backup-fails-snapshot-timeout) to force a reload, then try the backup again.

- Is antivirus software preventing the backup from running? If so, you might see the error message: antivirus configured in the VM is restricting the execution of backup extension. To resolve this issue, in the antivirus configuration, exclude the directories below:

C:\Packages\Plugins\Microsoft.Azure.RecoveryServices.VMSnapshot

C:\WindowsAzure\Logs\Plugins\Microsoft.Azure.RecoveryServices.VMSnapshot

### Step 2: Check the Azure VM Guest Agent

- Is the Azure VM Guest Agent service installed and started? Go to services.msc to check it is running then try rebooting the VM.

- Is the Microsoft Azure VM Guest Agent the latest version?

### Step 3: Check Azure VM extension health

- Are all Azure VM extensions in the ‘provisioning succeeded’ state? From the Azure portal, go to the VM, then Settings. From the Extensions menu, select Extensions status.

- Have all [extension issues](/azure/virtual-machines/extensions/overview) been resolved?

### Step 4: Check the Azure backup agent

- Is the Windows or Linux VM operating system supported? Refer to the [IaaS VM Backup Support Matrix](/azure/backup/backup-support-matrix-iaas) for supported versions.

- Is the VM agent up-to-date? Azure VMs are backed up by installing a backup agent. Check that the backup agent is installed and it’s a recent version.

- Is the Azure Backup option grayed out? Hover over the grayed-out option to find out the reason.

- Is antivirus software blocking the extension? If there are log entries in Event Viewer Application logs with the faulting application name IaaSBcdrExtension.exe then it could be the antivirus software.

- Are there entries in the Event Log? The Event Log may show backup failures from products other than Azure Backup. If Azure Backup is failing, find the corresponding error code in [Common Issues](/azure/backup/backup-azure-troubleshoot-vm-backup-fails-snapshot-timeout) to discover the solution.

For an up-to-date list of common error messages, see [Troubleshoot backup errors with Azure VMs - Azure Backup | Microsoft Learn](/azure/backup/backup-azure-vms-troubleshoot).

## Troubleshoot Azure Backup Server issues

Microsoft Azure Backup Server (MABS), also known as Azure Backup Server, is the software used to back up a range of servers and workloads. For a complete list of what can be protected with MABS, see:

- [MABS (Azure Backup Server) V3 UR1 (and later) protection matrix](/azure/backup/backup-mabs-protection-matrix)

- [Azure Backup Server V3 RTM protection matrix](/azure/backup/microsoft-azure-backup-server-protection-v3)

MABS must be installed on a dedicated, single-purpose server. The computer cannot be a domain controller, a node of a cluster, have Exchange Server running, have System Center Operations Manager running, or have the Application Server role installed. It must be a dedicated backup server.

Microsoft Azure Backup Server isn't supported on Windows Server Core or Microsoft Hyper-V Server.

Microsoft Azure Backup Server must be part of a domain. You cannot move an existing MABS machine to a new domain after deployment.

Microsoft Azure Backup Server must be registered with a Recovery Services vault, whether backup data is stored locally or in Azure.

Run through the following questions to troubleshoot Azure Backup Server issues:

- Is there network connectivity between the MARS agent and the Azure server?

- Is the MARS service running? In the Service console, start or restart the service and try the backup again.

- Is the SQL Agent service running and set to automatic in the MABS server?

- Is the MARS agent up-to-date?

- Ensure no other process or antivirus software is interfering with Azure backup.

- If Push install fails, check if DPM agent is already present. If yes, then uninstall the agent and install it again.

- Ensure .NET Framework 4.5.2 or later is installed on the server.

- Ensure the server on which you're trying to install Azure Backup Server isn't already registered with another vault.

- Configure antivirus software for MABS server.

- Check where MABs is installed, and what else is installed on that server.

- Check the backup vault credentials.

## Troubleshoot scheduled backups

There are two types of policies for scheduled backups:

- Default backup policy – the default policy backs up the VM once a day, retaining the backups for 30 days.

- Custom policy – you define whether backups run daily or weekly, and specify how long to retain the backup.

If you have problems with scheduled backups, try the following:

- The VMs must be in the same region and subscription as the recovery vault.

- If you get a message saying the recovery point is crash-consistent, check whether the VM is switched on. If the VM is not on, it will be backed up as an offline VM and the recovery point will be crash-consistent. This means that Azure gives no guarantee about the consistency of the data on the storage medium.

- [Troubleshoot scheduled backup job failures - Data Protection Manager | Microsoft Learn](/troubleshoot/system-center/dpm/troubleshoot-scheduled-backup-job-failures)