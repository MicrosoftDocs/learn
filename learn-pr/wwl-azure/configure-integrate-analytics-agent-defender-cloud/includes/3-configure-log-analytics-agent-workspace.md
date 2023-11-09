## Primary scenarios

Use the Log Analytics agent if you need to:

 -  Collect logs and performance data from Azure virtual machines or hybrid machines hosted outside of Azure.<br>
 -  Send data to a Log Analytics workspace to take advantage of features supported by Azure Monitor Logs, such as log queries.
 -  Use VM insights, which allow you to monitor your machines at scale and monitor their processes and dependencies on other resources and external processes.
 -  Manage the security of your machines by using Microsoft Defender for Cloud or Microsoft Sentinel.
 -  Use Azure Automation Update Management, Azure Automation State Configuration, or Azure Automation Change Tracking and Inventory to deliver comprehensive management of your Azure and non-Azure machines.
 -  Use different solutions to monitor a particular service or application.

## Azure virtual machine

 -  Use VM insights to install the agent for a single machine using the Azure portal or for multiple machines at scale. This installs the Log Analytics agent and Dependency agent.
 -  Log Analytics VM extension for Windows or Linux can be installed with the Azure portal, Azure CLI, Azure PowerShell, or an Azure Resource Manager template.
 -  Microsoft Defender for Cloud can provision the Log Analytics agent on all supported Azure VMs and any new ones that are created if you enable it to monitor for security vulnerabilities and threats.
 -  Install for individual Azure virtual machines manually from the Azure portal.
 -  Connect the machine to a workspace from the Virtual machines (deprecated) option in the Log Analytics workspaces menu in the Azure portal.

## Windows virtual machine on-premises or in another cloud

 -  Use Azure Arc-enabled servers to deploy and manage the Log Analytics VM extension. Review the deployment options to understand the different deployment methods available for the extension on machines registered with Azure Arc-enabled servers.
 -  Manually install the agent from the command line.
 -  Automate the installation with Azure Automation DSC.
 -  Use a Resource Manager template with Azure Stack.

## Linux virtual machine on-premises or in another cloud

 -  Use Azure Arc-enabled servers to deploy and manage the Log Analytics VM extension. Review the deployment options to understand the different deployment methods available for the extension on machines registered with Azure Arc-enabled servers.
 -  Manually install the agent calling a wrapper-script hosted on GitHub.
 -  Integrate System Center Operations Manager with Azure Monitor to forward collected data from Windows computers reporting to a management group.

## Data collected

The following table lists the types of data you can configure a Log Analytics workspace to collect from all connected agents.

:::image type="content" source="../media/log-analytics-agent-data-collected-example-8a3e8e34.jpg" alt-text="Screenshot showing Log Analytics data collected details.":::


## Windows security event options for the Log Analytics agent

When you select a data collection tier in Microsoft Defender for Cloud, the security events of the selected tier are stored in your Log Analytics workspace so that you can investigate, search, and audit the events in your workspace. The Log Analytics agent also collects and analyzes the security events required for Defender for Cloud’s threat protection.

### Requirements<br>

The enhanced security protections of Defender for Cloud are required for storing Windows security event data.

### What event types are stored for "Common" and "Minimal"?

The Common and Minimal event sets were designed to address typical scenarios based on customer and industry standards for the unfiltered frequency of each event and their usage.

 -  **Minimal** \- This set is intended to cover only events that might indicate a successful breach and important events with low volume. Most of the data volume of this set is successful user logon (event ID 4624), failed user logon events (event ID 4625), and process creation events (event ID 4688). Sign out events are important for auditing only and have relatively high volume, so they aren't included in this event set.
 -  **Common** \- This set is intended to provide a full user audit trail, including events with low volume. For example, this set contains both user logon events (event ID 4624) and user log off events (event ID 4634). We include auditing actions like security group changes, key domain controller Kerberos operations, and other events that are recommended by industry organizations.
