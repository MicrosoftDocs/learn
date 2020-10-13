Azure Arc enabled servers expands the support to server-based resources that run outside of Azure. This means that a Windows Server or Linux server that's running in Contoso's on-premises datacenter can be registered with Azure Arc and use many of the resource management capabilities available on Azure. Contoso can also apply this capability to any server that's running Windows Server or Linux that's hosted by another cloud provider.

## What is Azure Arc enabled servers?

Using Azure Arc enabled servers allows you to start managing all your servers as if they are Azure resources in one of your resource groups. Your managed servers can be:

- Physical computers.
- VMs hosted in an on-premises datacenter.
- VMs hosted with another cloud provider.
- Running either Windows Server or a number of popular distributions of Linux.

### What can you do with Azure Arc enabled servers?

When you onboard a server, it becomes a connected machine and is represented by a corresponding Azure resource. That resource has a unique **resource ID** property. It belongs to a resource group inside a subscription, and it can benefit from Azure management features such as Azure Policy and tags.

After you connect your machines to Azure Arc enabled servers, you can perform the following configuration management tasks:

- Assign Azure Policy guest configurations using the same process you use when assigning policies to your Azure VMs.
- Monitor your connected machines' guest operating system performance.
- Use Azure Monitor for VMs to:
    - Discover application components.
    - Monitor these applications' processes and dependencies.
- Support resource-context log access for log data collected and stored in a Log Analytics workspace.
- Simplify deployment with other Azure services. For example, implement Azure Automation State Configuration and Azure Monitor Log Analytics workspace. This includes using the Custom Script Extension to:
    - Perform post-deployment configuration.
    - Software installation.

:::image type="content" source="../media/3-onboard.png" alt-text="Screenshot that depicts the Machines - Azure Arc page in the Azure portal. A single computer, ContosoVM1, is listed." border="false":::

### Onboard your servers

The first step for an administrator is to connect their servers to Azure Arc. This process is called onboarding.

> [!NOTE]
> After you onboard a server to Azure Arc, it becomes a connected machine and is treated as an Azure resource. You can manage that resource using standard Azure tools and policies.

Each of your onboarded machines is: 

- Assigned a Resource ID.
- Managed as part of a resource group inside a subscription.
- Benefits from standard Azure constructs such as applying tags or Azure Policy. 

> [!NOTE]
> Third-party service providers that currently manage their customers' on-premises infrastructure can also manage their customers' hybrid machines with Azure Arc, just as they do with native Azure resources.

To onboard a server, you must install the Azure Connected Machine agent. This installation connects your machines to Azure Arc enabled servers. The Azure Connected Machine agent currently supports the following versions of the Windows and Linux operating systems:

- Windows Server 2012 R2 and later, including Server Core installations
- Ubuntu 16.04 and 18.04 (x64)
- CentOS Linux 7 (x64)
- SUSE Linux Enterprise Server 15 (x64)
- Red Hat Enterprise Linux 7 (x64)
- Amazon Linux 2 (x64)

The Azure Connected Machine agent sends a heartbeat message to the Azure Arc service every five minutes. If the Azure Arc service stops receiving heartbeat messages from the connected machine, it considers the machine to be offline. The machine is then marked as **Disconnected** until heartbeats resume, at which time the machine is marked as **Connected**.

### Manage and configure servers

After you onboard a server computer, you can use Azure Arc to manage and configure that device. The following table describes several current options. More options will be available soon.

| Option                  | Description                                       |
| -------------------------- | ------------------------------------------------------------ |
|Overview | You can review basic information about the server, including status, location, subscription, computer name, operating system, and tags. |
| Activity log| You can review a list of activities that were performed on the server and who performed them. |
|Access control | You can review and manage access to Azure resources for users, groups, service principals, and managed identities at this scope by creating role assignments. |
|Tags | Tags are name/value pairs that enable you to categorize resources. |
|Policies | You can add, configure, and remove policies for the server. |
|Update Management |This option enables you to maintain consistent control and compliance of the server. |
|Change Tracking and Inventory |You can review change tracking and inventory configuration for the server. Change Tracking and Inventory helps enable consistent control and compliance of your resources.|
| Insights | You can use Azure Monitor to review host CPU, disk, and the online/offline state of your Azure Arc servers. |
| Logs| You can run queries on logs to gather information about the server. |
|Extensions |You can add and remove extensions for the server. Extensions are small apps that provide post-deployment configuration and automation tasks on servers. For example, Contoso could use an extension if a server needs new software, or if IT staff need to run a script on a server. |

Azure Arc enabled servers allows you to deploy extensions to Windows and Linux servers that aren't hosted on Azure, which can help simplify management of those computers. The following table describes the extensions that you can add to Azure Arc-onboarded servers.

| Extension                  | Additional information                                       |
| -------------------------- | ------------------------------------------------------------ |
| CustomScriptExtension      | Downloads and runs scripts on servers                       |
| DSC                        | Uploads and applies a PowerShell DSC configuration on servers |
| Log Analytics agent        | Installs the Log Analytics agent on servers and enrolls VMs into an existing Log Analytics workspace |
| Microsoft Dependency Agent | Installs the Dependency Agent to enable Azure Monitor Insights on servers |
