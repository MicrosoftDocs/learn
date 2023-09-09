
Azure Monitor for VMs enables you to monitor Virtual Machines that are hosted in Azure or server operating systems connected through Azure Arc. Azure Monitor for VMs supports the following operating systems:

- Windows Server 2012 R2 and later
- Windows Server 2008 R2 SP1 and later
- Ubuntu 14.04 LTS and later
- SUSE Linux Enterprise Server 12 SP2 and later
- Red Hat Enterprise Linux 6.7 and later

To collect logs and performance data from the guest operating system of the virtual machine, though, you must install the Azure Monitor Agent and have deployed a Log Analytics workspace. 

## Azure Monitor Agent

Azure Monitor Agent (AMA) collects monitoring data from the guest operating system of Azure and hybrid virtual machines and delivers it to Azure Monitor for use by features, insights, and other services, such as Microsoft Sentinel and Microsoft Defender for Cloud. Azure Monitor Agent replaces all of Azure Monitor's legacy monitoring agents including:
 
- Log Analytics Agent: Sends data to a Log Analytics workspace and supports monitoring solutions. This is fully consolidated into Azure Monitor agent.
- Telegraf agent: Sends data to Azure Monitor Metrics (Linux only). Only basic Telegraf plugins are supported today in Azure Monitor agent.
- Diagnostics extension: Sends data to Azure Monitor Metrics (Windows only), Azure Event Hubs, and Azure Storage. This is not consolidated yet.

## Installing the Azure Monitor Agent

Azure Monitor Agent is implemented as an Azure VM extension. The following prerequisites must be met prior to installing Azure Monitor Agent.

- Permissions: For methods other than using the Azure portal, you must have the following role assignments to install the agent:

    - Virtual Machine Contributor
    - Azure Connected Machine Resource Administrator
    - Any role that includes the action Microsoft.Resources/deployments/* (for example, Log Analytics Contributor.)
<!-- -->
- Non-Azure: To install the agent on physical servers and virtual machines hosted outside of Azure (that is, on-premises) or in other clouds, you must install the Azure Arc Connected Machine agent.
- Authentication: Managed identity must be enabled on Azure virtual machines. Both user-assigned and system-assigned managed identities are supported.
- Networking: If you use network firewalls, the Azure Resource Manager service tag must be enabled on the virtual network for the virtual machine. The virtual machine must also have access to the following HTTPS endpoints:

    - `global.handler.control.monitor.azure.com`
    - <virtual-machine-region-name>.handler.control.monitor.azure.com (example: `westus.handler.control.monitor.azure.com`)
    - <log-analytics-workspace-id>.ods.opinsights.azure.com (example: `12345a01-b1cd-1234-e1f2-1234567g8h99.ods.opinsights.azure.com`)

It is important to note that once the agent is installed that Azure Monitor Agents don’t function without being associated with data collection rules. Those can be created manually or through using VM Insights. 

You can install Azure Monitor Agent on Azure virtual machines using the **az vm extension set –name AzureMonitorWindowsAgent** or **az vm extension set AzureMonitorLinuxAgent** commands.

For example, to install Azure Monitor Agent using the system-assigned managed identity on a Windows Server IaaS VM use the command:

`az vm extension set --name AzureMonitorWindowsAgent --publisher Microsoft.Azure.Monitor --ids <vm-resource-id> --enable-auto-upgrade true`

To install Azure Monitor Agent using the system-assigned managed identity on a Linux IaaS VM use the command:

`az vm extension set --name AzureMonitorLinuxAgent --publisher Microsoft.Azure.Monitor --ids <vm-resource-id> --enable-auto-upgrade true`

Creating a data collection rule through the Azure portal automatically deploys the Azure Monitor Agent on an IaaS VM if it is not already deployed.

Microsoft recommends you enable Automatic Extension Upgrade when deploying the Azure Monitor Agent. You can enable Azure Policy to automatically deploy the Azure Monitor Agent and associate it with a data collection rule each time you deploy a new IaaS VM.