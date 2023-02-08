Azure Arc provides a wide range of capabilities for managing a large number of Linux systems. For example, you can onboard your Linux machines at scale using automation tools such as Red Hat Ansible. Once your Linux systems are onboarded to Azure Arc, you'll be able to utilize tools such as Azure Policy to help enforce standards and compliance and Azure Automanage to simplify the ongoing management of your Linux VMs.

## Azure Automanage best practices

Azure Automanage offers a unified solution to simply the management of your Linux resources connect to Azure Arc. With point-and-click simplicity, you can automate operations and apply consistent best practices across the entire lifecycle of your Linux machines.

When you use Automanage best practices profiles, a number of Azure services are automatically downloaded to your Linux VMs, including:

- **Machines Insights Monitoring** monitors the health of your Linux VMs, including their running processes and dependencies on other resources.
- **Update Management** manages operating system updates for your Linux machines. 
- **Change Tracking and Inventory** combines change tracking and inventory functions to allow you to track Linux machine changes.
- **Azure Automation Account/Log Analytics workspace** work together to provide a unique environment for log data from Azure Monitor and other services such as Microsoft Defender for Cloud and Microsoft Sentinel.

See [Azure Automanage for Machines Best Practices](/azure/automanage/automanage-linux) for a complete list and explanation of these services.

### Azure Automanage Machine Configuration

Azure Automanage Machine Configuration provides native capability to audit or configure operating system settings as code for your Linux machines on Azure Arc. It can be used directly per-machine, or at-scale orchestrated by Azure Policy.

Configuration resources in Azure are designed as an extension resource. You can imagine each configuration as an additional set of properties for the machine. Configurations can include settings such as:

- Operating system settings
- Application configuration or presence
- Environment settings

Configurations are distinct from policy definitions. Machine configuration utilizes Azure Policy to dynamically assign configurations to machines. You can also assign configurations to machines manually, or by using other Azure services such as Automanage.

## Azure Policy

Azure Policy can help you enforce organizational standards and access the compliance of all your Linux machines. Through its compliance dashboard, Azure Policy provides an aggregated view of your Linux environment, allowing you to evaluate its overall state. Azure Policy also helps to bring your Linux resources to compliance through bulk remediation for existing resources and automatic remediation for new resources.

Common use cases for Azure Policy include implementing governance for resource consistency, regulatory compliance, security, cost, and management. Policy definitions for these common use cases are already available in your Azure environment as built-ins to help you get started.

## Ansible Automation Platform

Azure Arc supports Red Hat Ansible IT automation for your Linux systems. Ansible Automation Platform provides an enterprise framework for building and operating IT automation at scale. Ansible Automation Platform enables users across an organization to create, share, and manage automation—from development and operations to security and network teams. IT managers can provide guidelines on how automation is applied to individual teams, and automation creators can write tasks that use existing knowledge. Ansible Automation Platform provides a more secure and stable foundation for deploying end-to-end automation.