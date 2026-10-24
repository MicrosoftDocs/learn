Tailwind Manufacturing needs a consistent way to collect monitoring data from its distributed servers. In this unit, you learn how Azure Arc-enabled servers use VM extensions to deploy and manage Azure Monitor Agent. This agent collects the guest operating system data that supports performance analysis and alerting across your hybrid environment.

## Overview of extension management

Virtual machine (VM) extensions are small applications that provide post-deployment configuration and automation tasks on Azure VMs. For example, if a virtual machine requires software installation, antivirus protection, or the ability to run scripts, you can use a VM extension.

With Azure Arc-enabled servers, you can deploy, remove, and update Azure VM extensions on non-Azure Windows and Linux servers, simplifying the management of your hybrid machines through their lifecycle. These VM extensions can be managed using Azure portal, Azure CLI, Azure PowerShell, or Azure Resource Manager templates.

## Overview of observability agent VM extensions

Use Azure Monitor Agent (AMA) to collect monitoring data from supported Windows and Linux Azure Arc-enabled servers. AMA is separate from the Azure Connected Machine agent. The two agents have different responsibilities:

| Component | Responsibility |
| --- | --- |
| Azure Connected Machine agent | Connects the server to Azure Arc and provides the extension service that installs, updates, and removes VM extensions. Install and connect it before deploying monitoring extensions. |
| Azure Monitor Agent | Runs as an extension on the Arc-enabled server and collects the monitoring data specified by associated data collection rules. |

A data collection rule (DCR) defines the data to collect and its destinations. A DCR association connects that configuration to a machine. Keep the Connected Machine agent installed when you deploy AMA; AMA doesn't replace it.

## Deploy Azure Monitor Agent

Choose a deployment method appropriate for your environment:

- Deploy the AMA extension to individual machines through the Azure portal, PowerShell, Azure CLI, or an Azure Resource Manager template. Create and associate the required DCR separately when using extension-only installation.
- Use Azure Policy to deploy AMA and the required DCR associations across a fleet. Review the initiative's scope and configuration, and remediate existing noncompliant resources where required.
- Use Azure Automation runbooks when you need a scripted deployment schedule. The runbook must deploy the supported extension and configure the required DCR associations.

For the performance-monitoring exercise in this module, use the VM insights onboarding procedure in the next unit to configure AMA and logs-based performance collection.

For details, see AMA deployment options for Arc-enabled servers, Connected Machine agent components, and AMA support and migration guidance in the Summary unit's More Info section.
