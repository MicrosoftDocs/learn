With Tailwind Manufacturing's distributed IT infrastructure, it's often difficult to get a coherent view of the entire organization's security posture. Moreover, initiatives to secure and defend resources are increasingly siloed. In this unit, you learn how to use Microsoft Defender for Cloud with Azure Arc-enabled servers. Together, they can facilitate a more comprehensive security strategy to meet the demands of your hybrid and multicloud infrastructure.

## Overview of extension management

Virtual machine (VM) extensions are small applications that provide post-deployment configuration and automation tasks on Azure VMs. For example, if a virtual machine requires software installation, anti-virus protection, or the ability to run scripts, you can use a VM extension.

With Azure Arc-enabled servers, you can deploy, remove, and update Azure VM extensions on non-Azure Windows and Linux servers, simplifying the management of your hybrid machines through their lifecycle. These VM extensions can be managed using Azure portal, Azure CLI, Azure PowerShell, or Azure Resource Manager templates.

## Overview of observability agent VM extensions

Azure Arc supports the deployment of the Azure Monitor agent, Log Analytics, and Azure Monitor Dependency as VM extensions. The following table provides a quick comparison of the observability agents supported as VM extensions for Azure Arc-enabled servers.

| Observability agents | Description |
|---|---|
| **Azure Monitor agent** | The Azure Monitor agent provides all capabilities necessary to collect guest operating system monitoring data. There are multiple legacy agents that exist due to the consolidation of Azure Monitor and Log Analytics, and each agent has unique capabilities with some overlap. We recommend that you use Azure Monitor agent because it consolidates features from all existing agents and provides more benefits. The Azure Monitor agent can send data to both Azure Monitor Logs and Azure Monitor Metrics. It uses Data Collection Rules (DCR) which provide a more scalable method of configuring data collection and destinations for each agent. |
| **Log Analytics agent** | The Log Analytics agent collects monitoring data from the guest operating system and workloads of virtual machines in Azure, other cloud providers, and on-premises machines. It sends data to a Log Analytics workspace. The Log Analytics agent is the same agent System Center Operations Manager uses, and you can multi-home agent computers to communicate with your management group and Azure Monitor simultaneously. Certain insights in Azure Monitor and other services in Azure require this agent. The Log Analytics agent for Windows is often referred to as Microsoft Monitoring Agent (MMA). The Log Analytics agent for Linux is often referred to as OMS agent. |
| **Dependency agent** | The Dependency agent collects discovered data about processes running on the machine and external process dependencies. On both the Windows and Linux versions of the Dependency Agent, data collection is done using a user-space service and a kernel driver. |

## Deploying the observability VM extensions

There are three main ways to deploy the observability agents Azure Monitor Agent, Log Analytics Agent, and Dependency Agent:

- **Directly as a VM Extension for Azure Arc-enabled servers:** Configure the extensions directly from the Azure portal, using PowerShell, the Azure CLI, or with an Azure Resource Manager (ARM) template.
- **Deploy an Azure Policy:** Use Azure Policy to deploy agents at scale to machines in your environment while maintaining configuration compliance.
- **Use Azure Automation:** The process automation operating environment in Azure Automation and its support for PowerShell and Python runbooks lets you automate the deployment of the Log Analytics agent, Azure Monitor, and Dependency Agent VM extension at-scale to machines in your environment.
