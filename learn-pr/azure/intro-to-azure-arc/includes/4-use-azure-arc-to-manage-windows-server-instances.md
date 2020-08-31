
After they onboard a Windows Server computer, Contoso administrators can use Azure Arc to manage and configure that device. A number of options are available, described below, and others will be available soon.

- Overview. Enables you to review basic information about the server, including status, location, subscription, computer name, operating system, and tags.
- Activity log. Enables you to review a list of activities that were performed against the server and by whom the events were performed.
- Access control. Enables you to review and manage access to Azure resources for users, groups, service principals, and managed identities at this scope by creating role assignments.
- Tags. Name/value pairs that enable you to categorize resources.
- Extensions. Enables you to add and remove extensions for the server.
- Policies. Enables you to add, configure, and remove policies for the server.
- Update management. Enables you to maintain consistent control and compliance of the server with Update Management.
- Change Tracking and Inventory. Enables you to review change tracking and inventory configuration for the server. Change Tracking and Inventory helps enable consistent control and compliance of your resources.
- Insights. Enables you to use Azure Monitor to review host CPU, disk, and the online/offline state of your Azure Arc servers.
- Logs. Enables you to run queries against logs to gather information about the server.

## Manage extensions

*Extensions* are small apps that provide post-deployment configuration and automation tasks on servers. For example, Contoso could use an extension if:

- A server needs some new software.
- IT staff need to run a script on a server.

Azure Arc for servers enables you to deploy extensions to Windows and Linux servers that aren't hosted on Azure, and this can help simplify management of those computers.

The following table describes the extensions that you can add to Azure Arc-onboarded servers.

|Extension|Additional information|
|--------------------------|------------------------------------------------------------|
|CustomScriptExtension|Downloads and runs scripts on servers. Learn more at [Custom Script Extension for Windows](https://docs.microsoft.com/azure/virtual-machines/extensions/custom-script-windows?azure-portal=true).|
|DSC|Uploads and applies a PowerShell DSC configuration on servers. Learn more at [PowerShell DSC Extension](https://docs.microsoft.com/azure/virtual-machines/extensions/dsc-windows?azure-portal=true).|
|Log Analytics agent|Installs the Log Analytics agent on servers and enrolls VMs into an existing Log Analytics workspace. Learn more at [Log Analytics virtual machine extension for Windows](https://docs.microsoft.com/azure/virtual-machines/extensions/oms-windows?azure-portal=true).|
|Microsoft Dependency Agent|Installs the Dependency Agent to enable Azure Monitor Insights on servers. Learn more at [Azure Monitor Dependency virtual machine extension for Windows](https://docs.microsoft.com/azure/virtual-machines/extensions/agent-dependency-windows?azure-portal=true).|
