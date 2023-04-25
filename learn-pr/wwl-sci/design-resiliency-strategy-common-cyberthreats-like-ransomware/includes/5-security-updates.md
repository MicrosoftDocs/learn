You can use Update Management in Azure Automation to manage operating system updates for your Windows and Linux virtual machines in Azure, physical or VMs in on-premises environments, and in other cloud environments. You can quickly assess the status of available updates and manage the process of installing required updates for your machines reporting to Update Management.

As a service provider, you may have onboarded multiple customer tenants to [Azure Lighthouse](/azure/lighthouse/overview). Update Management can be used to assess and schedule update deployments to machines in multiple subscriptions in the same Azure Active Directory (Azure AD) tenant, or across tenants using Azure Lighthouse.

Microsoft offers other capabilities to help you manage updates for your Azure VMs or Azure Virtual Machine Scale Sets that you should consider as part of your overall update management strategy.

Before deploying Update Management and enabling your machines for management, make sure that you understand the information in the following sections.

### About Update Management

The following diagram illustrates how Update Management assesses and applies security updates to all connected Windows Server and Linux servers.

![Diagram that shows the update management workflow.](../media/update-management-workflow.png)

Update Management integrates with Azure Monitor Logs to store update assessments and update deployment results as log data, from assigned Azure and non-Azure machines. To collect this data, the Automation Account and Log Analytics workspace are linked together, and the Log Analytics agent for Windows and Linux is required on the machine and configured to report to this workspace.

Update Management supports collecting information about system updates from agents in a System Center Operations Manager management group connected to the workspace. Having a machine registered for Update Management in more than one Log Analytics workspace (also referred to as multihoming) isn't supported.

The following table summarizes the supported connected sources with Update Management.

| Connected source | Supported | Description |
| --- | --- | --- |
| Windows |Yes |Update Management collects information about system updates from Windows machines with the Log Analytics agent and installation of required updates.<br> Machines need to report to Microsoft Update or Windows Server Update Services (WSUS). |
| Linux |Yes |Update Management collects information about system updates from Linux machines with the Log Analytics agent and installation of required updates on supported distributions.<br> Machines need to report to a local or remote repository. |
| Operations Manager management group |Yes |Update Management collects information about software updates from agents in a connected management group.<br/><br/>A direct connection from the Operations Manager agent to Azure Monitor logs isn't required. Log data is forwarded from the management group to the Log Analytics workspace. |

The machines assigned to Update Management report how up to date they are based on what source they are configured to synchronize with. Windows machines need to be configured to report to either [Windows Server Update Services](/windows-server/administration/windows-server-update-services/get-started/windows-server-update-services-wsus) or [Microsoft Update](https://www.update.microsoft.com/), and Linux machines need to be configured to report to a local or public repository. You can also use Update Management with Microsoft Endpoint Configuration Manager, and to learn more see [Integrate Update Management with Windows Endpoint Configuration Manager](/azure/automation/update-management/mecmintegration).

<!-- END Source: (/azure/automation/update-management/overview)
-->

## Integrate with Configuration Manager for on-premises resources

<!-- START Source: (/azure/automation/update-management/mecmintegration)
-->
Customers who have invested in Microsoft Endpoint Configuration Manager to manage PCs, servers, and mobile devices also rely on its strength and maturity in managing software updates as part of their software update management (SUM) cycle.

You can report and update managed Windows servers by creating and pre-staging software update deployments in Microsoft Endpoint Configuration Manager, and get detailed status of completed update deployments using [Update Management](/azure/automation/update-management/overview). If you use Microsoft Endpoint Configuration Manager for update compliance reporting, but not for managing update deployments with your Windows servers, you can continue reporting to Microsoft Endpoint Configuration Manager while security updates are managed with Azure Automation Update Management.

### Prerequisites

-   You must have [Azure Automation Update Management](/azure/automation/update-management/overview) added to your Automation account.
-   Windows servers currently managed by your Microsoft Endpoint Configuration Manager environment also need to report to the Log Analytics workspace that also has Update Management enabled.
-   This feature is enabled in Microsoft Endpoint Configuration Manager current branch version 1606 and higher. To integrate your Microsoft Endpoint Configuration Manager central administration site or a standalone primary site with Azure Monitor logs and import collections, review [Connect Configuration Manager to Azure Monitor logs](/azure/azure-monitor/logs/collect-sccm).
-   Windows agents must either be configured to communicate with a Windows Server Update Services (WSUS) server or have access to Microsoft Update if they don't receive security updates from Microsoft Endpoint Configuration Manager.

How you manage clients hosted in Azure IaaS with your existing Microsoft Endpoint Configuration Manager environment primarily depends on the connection you have between Azure datacenters and your infrastructure. This connection affects any design changes you may need to make to your Microsoft Endpoint Configuration Manager infrastructure and related cost to support those necessary changes.
