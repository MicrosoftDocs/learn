Fabrikam Residences onboarded its machines to Azure Arc-enabled servers. Unlike Azure VMs where Guest Configuration is deployed as a virtual machine (VM) extension, Azure Arc-enabled servers have the Guest Configuration service as part of the Connected Machine Agent. In this Unit, you learn about Guest Configuration and how it fits into Azure Arc-enabled servers. 

## Overview of Guest Configuration

Azure Policy's Guest Configuration feature provides native capability to audit or configure operating system settings as code, both for machines running in Azure and Arc-enabled machines. While Guest Configuration is deployed as a VM extension to Azure Virtual Machines, the Guest Configuration agent is embedded in the Connected Machine Agent for Azure Arc-enabled servers. By default, Arc-enabled servers can rely on the Guest Configuration service to provide in-guest policy and Guest Configuration functionality to Azure Arc-enabled servers.

Guest Configuration can be used for both configuration management and compliance of resources. Configuration settings include operating system settings, application configuration or presence, and environment settings. From a compliance point of view, you can audit or deploy settings to all machines in scope. You can do so reactively, to your existing machines. Or, proactively to new machines as you deploy them.

## Built-in Azure Policy Guest Configuration

There are dozens of built-in Azure Policies for Arc-enabled servers that use Guest Configuration. Some examples of Azure Policy Guest Configuration for Arc-enabled servers include:

- Configuring the time zone on Windows machines.
- Specifying the Group Policy settings in the **Windows Firewall Properties** category for the firewall state, connections, rule management, and notifications, on Windows machines.
- Meeting the requirements for **Security Options - User Account Control** on Windows machines.

## Guest Configuration in disconnected scenarios

For disconnected machines, Azure Arc-enabled servers have the following Azure Policy guest configuration behavior:

- An Azure Policy assignment that targets disconnected machines is unaffected.
- Guest assignment is stored locally for 14 days. Within the 14-day period, if the Connected Machine agent reconnects to the service, policy assignments are reapplied.
- Assignments are deleted after 14 days and aren't reassigned to the machine after the 14-day period.

## Azure Policy Guest Configuration Pricing

Billing is based on the number of servers registered with the service that have one or more Guest Configurations assigned to them. Billing is pro-rated hourly. Offline machines, such as machines that are disconnected or powered-off for the entire hour, aren't billed. Azure Arc resources managed by guest configuration are excluded from billing in the following scenarios.

- Azure Automation: Guest Configuration assignments aren't billed if the state configuration or change tracking features offered by Azure Automation already manage the machine.
- Microsoft Defender for Cloud: Azure Policy assignment of the Azure Security Benchmark initiative creates configuration assignment. Azure Policy assignment of a built-in policy initiative in the "Regulatory Compliance" category creates configuration assignment. Azure Policy assignment of a custom policy initiative created in Microsoft Defender for Cloud creates configuration assignment.
- Azure Stack HCI: You can use Azure benefits on your Azure Stack HCI cluster so that the Guest Configuration assignments are used at no extra fee. You can use these benefits for virtual machines hosted by Azure Stack HCI and nodes in an Azure Stack HCI cluster.
- Azure Security Baselines and non-Guest Configuration Azure Policies don't trigger pricing.

Azure Policy Guest Configuration, including Azure Automation change tracking, inventory, and state configuration, costs $6/server/month for Azure Arc-enabled servers. There's no charge to assign Azure Policy Guest Configuration to Azure VMs.
