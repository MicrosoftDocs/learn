Azure Arc provides a wide range of capabilities for managing a large number of Linux systems. For example, you can onboard your Linux machines at scale using automation tools such as Red Hat Ansible. Once your Linux systems are onboarded to Azure Arc, you'll be able to utilize tools such as Azure Policy to help enforce standards and compliance and Azure Automanage to simplify the ongoing management of your Linux VMs.

## Ansible support for Linux machine onboarding

Azure Arc supports Red Hat Ansible IT automation, allowing you to onboard Ansible-managed Linux nodes at scale using Ansible playbooks. To do so, you'll need to download, modify, and then run the appropriate Ansible playbook. Once the playbook is run and the Linux machines are onboarded, you can verify their connection to Azure and manage them using the Azure portal, just as you would other Azure resources.

## Azure Policy

Azure Policy can help you enforce organizational standards and access the compliance of all your Arc-enabled Linux machines. Through its compliance dashboard, Azure Policy provides an aggregated view of your Linux environment, allowing you to evaluate its overall state. Azure Policy also helps to bring your Linux resources to compliance through bulk remediation for existing resources and automatic remediation for new resources.

Common use cases for Azure Policy include implementing governance for resource consistency, regulatory compliance, security, cost, and management. Policy definitions for these common use cases are already available in your Azure environment as built-ins to help you get started.

## Azure Automanage best practices

Azure Automanage offers a unified solution to simply the management of your Arc-enabled Linux resources. With point-and-click simplicity, you can automate operations and apply consistent best practices across the entire lifecycle of your Linux machines. 

When you use Automanage best practices profiles, a number of Azure services are automatically downloaded to your Linux VMs, including:

- **Machines Insights Monitoring** monitors the health of your Arc-enabled Linux VMs, including their running processes and dependencies on other resources.
- **Backup** provides independent and isolated backups to guard against unintended destruction of the data on your Linux VMs.
- **Update Management** manages operating system updates for your Linux machines. 
- **Change Tracking and Inventory** combines change tracking and inventory functions to allow you to track Linux machine changes.

See [Azure Automanage for Machines Best Practices](https://learn.microsoft.com/en-us/azure/automanage/automanage-linux) for a complete list and explanation of these services.

### Azure Automanage Machine Configuration

Azure Automanage Machine Configuration provides native capability to audit or configure operating system settings as code for your Arc-enabled Linux machines. It can be used directly per-machine, or at-scale orchestrated by Azure Policy.

Configuration resources in Azure are designed as an extension resource. You can imagine each configuration as an additional set of properties for the machine. Configurations can include settings such as:

- Operating system settings
- Application configuration or presence
- Environment settings

Configurations are distinct from policy definitions. Machine configuration utilizes Azure Policy to dynamically assign configurations to machines. You can also assign configurations to machines manually, or by using other Azure services such as Automanage.
