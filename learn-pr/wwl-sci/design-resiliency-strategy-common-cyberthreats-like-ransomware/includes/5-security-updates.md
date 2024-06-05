Update Manager is a unified service to help manage and govern updates for all your machines. You can monitor Windows and Linux update compliance across your deployments in Azure, on-premises, and on other cloud platforms from a single dashboard. You can also use Update Manager to make real-time updates or schedule them within a defined maintenance window.

You can use Update Manager in Azure to:

- Oversee update compliance for your entire fleet of machines in Azure, on-premises, and in other cloud environments.
- Instantly deploy critical updates to help secure your machines.
- Use flexible patching options such as [automatic virtual machine (VM) guest patching](/azure/virtual-machines/automatic-vm-guest-patching) in Azure, [hotpatching](/azure/automanage/automanage-hotpatch), and customer-defined maintenance schedules.

We also offer other capabilities to help you manage updates for your Azure VMs that you should consider as part of your overall update management strategy. To learn more about the options that are available, see the Azure VM [update options](/azure/virtual-machines/updates-maintenance-overview).

Before you enable your machines for Update Manager, make sure that you understand the information in the following sections.

## Key benefits

Update Manager has been redesigned and doesn't depend on Azure Automation or Azure Monitor Logs, as required by the [Azure Automation Update Management feature](/azure/automation/update-management/overview). Update Manager offers many new features and provides enhanced functionality over the original version available with Azure Automation. Some of those benefits are listed here:

- Provides native experience with zero on-boarding.
    - Built as native functionality on Azure compute and the Azure Arc for Servers platform for ease of use.
    - No dependency on Log Analytics and Azure Automation.
    - Azure Policy support.
    - Global availability in all Azure compute and Azure Arc regions.
- Works with Azure roles and identity.
    - Granular access control at the per-resource level instead of access control at the level of the Azure Automation account and Log Analytics workspace.
    - Update Manager now has Azure Resource Manager-based operations. It allows role-based access control and roles based on Azure Resource Manager in Azure.
- Offers enhanced flexibility.
    - Ability to take immediate action either by installing updates immediately or scheduling them for a later date.
    - Check updates automatically or on demand.
    - Helps secure machines with new ways of patching, such as [automatic VM guest patching](/azure/virtual-machines/automatic-vm-guest-patching) in Azure, [hotpatching](/azure/automanage/automanage-hotpatch), or custom maintenance schedules.
    - Sync patch cycles in relation to "patch Tuesday," the unofficial term for Microsoft's scheduled security fix release on every second Tuesday of each month.

The following diagram illustrates how Update Manager assesses and applies updates to all Azure machines and Azure Arc-enabled servers for both Windows and Linux.

![Diagram that shows the Update Manager workflow.](../media/update-management-center-overview.png)

To support management of your Azure VM or non-Azure machine, Update Manager relies on a new [Azure extension](/azure/virtual-machines/extensions/overview) designed to provide all the functionality required to interact with the operating system to manage the assessment and application of updates. This extension is automatically installed when you initiate any Update Manager operations, such as **Check for updates**, **Install one-time update**, and **Periodic Assessment** on your machine. The extension supports deployment to Azure VMs or Azure Arc-enabled servers by using the extension framework. The Update Manager extension is installed and managed by using:

- [Azure VM Windows agent](/azure/virtual-machines/extensions/agent-windows) or the [Azure VM Linux agent](/azure/virtual-machines/extensions/agent-linux) for Azure VMs.
- [Azure Arc-enabled servers agent](/azure/azure-arc/servers/agent-overview) for non-Azure Linux and Windows machines or physical servers.

 Update Manager manages the extension agent installation and configuration. Manual intervention isn't required as long as the Azure VM agent or Azure Arc-enabled server agent is functional. The Update Manager extension runs code locally on the machine to interact with the operating system, and it includes:

- Retrieving the assessment information about status of system updates for it specified by the Windows Update client or Linux package manager.
- Initiating the download and installation of approved updates with the Windows Update client or Linux package manager.

All assessment information and update installation results are reported to Update Manager from the extension and is available for analysis with [Azure Resource Graph](/azure/governance/resource-graph/overview). You can view up to the last seven days of assessment data, and up to the last 30 days of update installation results.

The machines assigned to Update Manager report how up to date they are based on what source they're configured to synchronize with. You can configure [Windows Update Agent (WUA)](/windows/win32/wua_sdk/updating-the-windows-update-agent) on Windows machines to report to [Windows Server Update Services](/windows-server/administration/windows-server-update-services/get-started/windows-server-update-services-wsus) or Microsoft Update, which is by default. You can configure Linux machines to report to a local or public YUM or APT package repository. If the Windows Update Agent is configured to report to WSUS, depending on when WSUS last synchronized with Microsoft Update, the results in Update Manager might differ from what Microsoft Update shows. This behavior is the same for Linux machines that are configured to report to a local repository instead of a public package repository.

You can manage your Azure VMs or Azure Arc-enabled servers directly or at scale with Update Manager.
