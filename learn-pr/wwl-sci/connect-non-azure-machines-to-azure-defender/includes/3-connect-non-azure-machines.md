Microsoft Defender for Cloud can monitor the security posture of your non-Azure computers, but first, you need to connect them to Azure.

There are several different ways you can connect your existing Windows and Linux machines to Azure Arc:

- Using Azure Arc enabled servers (recommended)
- Azure Arc-enabled VMware vSphere
- Azure Arc-enabled System Center Virtual Machine Manager (SCVMM)
- Azure Local

## Add non-Azure machines with Azure Arc

Azure Arc enabled servers is the preferred way of adding your non-Azure machines to Defender for Cloud. A machine with Azure Arc enabled servers becomes an Azure resource and appears in Defender for Cloud with recommendations like your other Azure resources. In addition, Azure Arc enabled servers provides enhanced capabilities such as the option to enable guest configuration policies on the machine, deploy the Azure Monitor agent as an extension, simplify deployment with other Azure services, and more.

### What is Azure Arc enabled servers?

Azure Arc enabled servers allows you to manage your Windows and Linux machines hosted outside of Azure, on your corporate network, or other cloud providers, just like you manage native Azure virtual machines. When a hybrid machine is connected to Azure, it becomes a connected machine and is treated as a resource in Azure. Each connected machine has a Resource ID, is included in a resource group, and benefits from standard Azure constructs such as Azure Policy and applying tags. Service providers who manage a customer's on-premises infrastructure can manage their hybrid machines just like they do today with native Azure resources, across multiple customer environments, using Azure Lighthouse with Azure Arc.

To deliver this experience with your hybrid machines hosted outside of Azure, the *Azure Connected Machine agent* needs to be installed on each machine that you plan on connecting to Azure. **This agent doesn't replace the Azure Monitor Agent**. The Azure Monitor Agent for Windows and Linux is required when you want to proactively monitor the OS and workloads running on the machine. You can then manage the machines using Automation runbooks, solutions like Update Management, or use other Azure services like Defender for Cloud.

## Onboard non-Azure machines with the Azure Connected Machine agent

Connecting machines in your hybrid environment directly with Azure can be accomplished using different methods, depending on your requirements and the tools you prefer to use.

### Onboarding methods

The following table highlights each method so you can determine which works best for your deployment. For detailed information, follow the links to view the steps for each article.

| Method | Description |
|--------|-------------|
| Interactively | Manually install the agent on a single or small number of machines by [connecting machines using a deployment script](/azure/azure-arc/servers/onboard-portal). From the Azure portal, you can generate a script and execute it on the machine to automate the install and configuration steps of the agent.|
| Interactively | [Connect machines from Windows Admin Center](/azure/azure-arc/servers/onboard-windows-admin-center) |
| Interactively | [Connect Windows Servers machines to Azure through Azure Arc Setup](/azure/azure-arc/servers/onboard-windows-server) |
| Interactively or at scale | [Connect machines using PowerShell](/azure/azure-arc/servers/onboard-powershell) |
| At scale | [Connect machines using a service principal](/azure/azure-arc/servers/onboard-service-principal) to install the agent at scale non-interactively.|
| At scale | [Connect machines by running PowerShell scripts with Configuration Manager](/azure/azure-arc/servers/onboard-configuration-manager-powershell) |
| At scale | [Connect machines with a Configuration Manager custom task sequence](/azure/azure-arc/servers/onboard-configuration-manager-custom-task) |
| At scale | [Connect Windows machines using Group Policy](/azure/azure-arc/servers/onboard-group-policy-powershell) |
| At scale | [Connect machines from Automation Update Management](/azure/azure-arc/servers/onboard-update-management-machines) to create a service principal that installs and configures the agent for multiple machines managed with Azure Automation Update Management to connect machines non-interactively. |
| At scale | [Install the Arc agent on VMware VMs at scale using Arc enabled VMware vSphere](/azure/azure-arc/vmware-vsphere/enable-guest-management-at-scale). Arc enabled VMware vSphere allows you to [connect your VMware vCenter server to Azure](/azure/azure-arc/vmware-vsphere/quick-start-connect-vcenter-to-arc-using-script), automatically discover your VMware VMs, and install the Arc agent on them. Requires VMware tools on VMs.|
| At scale | [Install the Arc agent on SCVMM VMs at scale using Arc-enabled System Center Virtual Machine Manager](/azure/azure-arc/system-center-virtual-machine-manager/enable-guest-management-at-scale). Arc-enabled System Center Virtual Machine Manager allows you to [connect your SCVMM management server to Azure](/azure/azure-arc/system-center-virtual-machine-manager/quickstart-connect-system-center-virtual-machine-manager-to-arc), automatically discover your SCVMM VMs, and install the Arc agent on them. |
| At scale | [Connect your AWS cloud through the multicloud connector enabled by Azure Arc](/azure/azure-arc/multicloud-connector/connect-to-aws) and [enable the **Arc onboarding** solution](/azure/azure-arc/multicloud-connector/onboard-multicloud-vms-arc) to autodiscover and onboard EC2 VMs. |

> [!NOTE]
> The Azure Arc Setup feature only applies to Windows Server 2022 and later. It was released in the [Cumulative Update of 10/10/2023](https://support.microsoft.com/topic/october-10-2023-kb5031364-os-build-20348-2031-7f1d69e7-c468-4566-887a-1902af791bbc).

## Supported cloud operations

With Azure Arc-enabled servers, you can perform many operational functions, just as you would with native Azure virtual machines. Below are some of the key supported actions for connected machines.

* **Govern**:
  * Assign [Azure machine configurations](/azure/governance/machine-configuration/overview) to audit settings inside the machine. To understand the cost of using Azure Machine Configuration policies with Arc-enabled servers, see Azure Policy [pricing guide](https://azure.microsoft.com/pricing/details/azure-policy/).
* **Protect**:
  * Protect non-Azure servers with [Microsoft Defender for Endpoint](/microsoft-365/security/defender-endpoint), included through [Microsoft Defender for Cloud](/azure/security-center/defender-for-servers-introduction), for threat detection, for vulnerability management, and to proactively monitor for potential security threats. Microsoft Defender for Cloud presents the alerts and remediation suggestions from the threats detected.
  * Use [Microsoft Sentinel](scenario-onboard-azure-sentinel.md) to collect security-related events and correlate them with other data sources.
* **Configure**:
  * Use [Azure Automation](/azure/automation/extension-based-hybrid-runbook-worker-install?tabs=windows) for frequent and time-consuming management tasks using PowerShell and Python [runbooks](/azure/automation/automation-runbook-execution). Assess configuration changes for installed software, Microsoft services, Windows registry and files, and Linux daemons using the Azure Monitor agent for [change tracking and inventory](/azure/automation/change-tracking/overview-monitoring-agent?tabs=win-az-vm).
  * Use [Azure Update Manager](/azure/update-manager/overview) to manage operating system updates for your Windows and Linux servers. Automate onboarding and configuration of a set of Azure services when you use [Azure Automanage](/azure/automanage/automanage-arc).
  * Perform post-deployment configuration and automation tasks using supported [Arc-enabled servers VM extensions](manage-vm-extensions.md) for your non-Azure Windows or Linux machine.
* **Monitor**:
  * Monitor operating system performance and discover application components to monitor processes and dependencies with other resources using [VM insights](/azure/azure-monitor/vm/vminsights-overview).
  * Collect other log data, such as performance data and events, from the operating system or workloads running on the machine with the [Azure Monitor Agent](/azure/azure-monitor/agents/azure-monitor-agent-overview). This data is stored in a [Log Analytics workspace](/azure/azure-monitor/logs/log-analytics-workspace-overview).

Log data collected and stored in a Log Analytics workspace from the hybrid machine contains properties specific to the machine, such as a Resource ID, to support [resource-context](/azure/azure-monitor/logs/manage-access#access-mode) log access.

Watch this video to learn more about Azure monitoring, security, and update services across hybrid and multicloud environments.

> [!VIDEO https://www.youtube.com/embed/mJnmXBrU1ao]
