Fabrikam Residences has onboarded its machines to Azure Arc-enabled servers. Unlike Azure VMs where Guest Configuration is deployed as a VM extension, Azure Arc-enabled servers have the Guest Configuration service as part of the Connected Machine Agent. In this Unit, you’ll learn about Guest Configuration and how it fits into Azure Arc-enabled servers. 

## Overview of Guest Configuration

Azure Policy's Guest Configuration feature provides native capability to audit or configure operating system settings as code, both for machines running in Azure and Arc-enabled machines. While Guest Configuration is deployed as a VM extension to Azure VM’s, the Guest Configuration agent is embedded in the Connected Machine Agent for Azure Arc-enabled servers. By default, Arc-enabled servers can rely on the Guest Configuration service to provide in-guest policy and Guest Configuration functionality to Azure Arc-enabled servers. 

Guest Configuration can be used for both configuration management and compliance of resources. Configuration settings include operating system settings, application configuration or presence, and environment settings. From a compliance lens, you can audit or deploy settings to all machines in scope either reactively to existing machines or proactively to new machines as they are deployed. 

## Built-in Azure Policy Guest Configuration

There are dozens of built-in Azure Policies for Arc-enabled servers that leverage Guest Configuration. Some examples of Azure Policy Guest Configuration for Arc-enabled servers include: 

- Configure time zone on Windows machines. 
- Windows machines should have the specified Group Policy settings in the category 'Windows Firewall Properties' for the firewall state, connections, rule management, and notifications. 
- Windows machines should meet the requirements for 'Security Options - User Account Control'

## Guest Configuration in disconnected scenarios

For disconnected machines, Azure Arc-enabled servers have the following Azure Policy guest configuration behavior: 

- An Azure Policy assignment that targets disconnected machines is unaffected.
- Guest assignment is stored locally for 14 days. Within the 14-day period, if the Connected Machine agent reconnects to the service, policy assignments are reapplied.
- Assignments are deleted after 14 days and are not reassigned to the machine after the 14-day period.

## Azure Policy Guest Configuration Pricing

Billing is based on the number of servers registered with the service that have one or more Guest Configurations assigned to them. Billing is pro-rated hourly. Offline machines, such as machines that are disconnected or powered-off for the entire hour, are not billed. Azure Arc resources managed by guest configuration are excluded from billing in the following scenarios.

- Azure Automation: Guest Configuration assignments are not billed if the machine is already managed by the state configuration or change tracking features offered by Azure Automation.
- Microsoft Defender for Cloud: Azure Policy assignment of the Azure Security Benchmark initiative creates configuration assignment. Azure Policy assignment of a built-in policy initiative in the "Regulatory Compliance" category creates configuration assignment. Azure Policy assignment of a custom policy initiative created in Microsoft Defender for Cloud creates configuration assignment.
- Azure Stack HCI: Azure benefits on your Azure Stack HCI cluster, can be used so that Guest Configuration assignments can be used at no additional fee for both virtual machines hosted by Azure Stack HCI and nodes in an Azure Stack HCI cluster.
- Azure Security Baselines and non-Guest Configuration Azure Policies do not trigger pricing.

Azure Policy Guest Configuration (including Azure Automation change tracking, inventory, and state configuration) costs $6/server/month for Azure Arc-enabled servers. There is no charge to assign Azure Policy Guest Configuration to Azure VMs. 
