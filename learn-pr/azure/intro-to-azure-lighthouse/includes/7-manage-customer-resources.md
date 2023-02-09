Now you are ready to start managing Azure resources for your customers, using your Contoso credentials. 

With delegated access in place, Azure Lighthouse lets you use many of the Azure management capabilities you may already be familiar with, including Azure Backup, Azure Monitor, Azure Policy, Microsoft Defender for Cloud and more. You can query and perform tasks on your customer's delegated resources with the Azure portal, Azure PowerShell, Azure CLI, Azure REST API and with other tools like Ansible and Terraform.

Because you have visibility over all of your customer's resources at the same time, with your own credentials, you can apply actions at scale or detect which customer resources need attention or remediation, without having to switch context and control panes.

Below is an example of the Azure portal All Resources blade showing network security groups from different customer subscriptions, that have been onboarded with Azure Lighthouse:

:::image type="content" source="../media/7-all-resources.png" alt-text="Screenshot depicting the All Resources blade with customer subscriptions and network security groups.":::

## Hybrid resources with Azure Arc

Azure Lighthouse also supports resources that are on-premises or in other clouds, using Azure Arc. So, along with your customer's Azure resources, you can also view and manage their Azure Arc enabled servers and Azure Arc enabled Kubernetes. [Learn more about Azure Arc](/azure/azure-arc/).

## Resource management examples

Contoso has processes in place for managing many different aspects of their customer's Azure resources. Exploring the capabilities of Azure Arc, you find some management scenarios you already provide as part of your managed service offerings.

> [!IMPORTANT]
> Some of the following services may require licenses or incur costs from the appropriate services.  

### Backup management

With Azure Backup, you can backup and restore customer data from on-premises workloads, Azure virtual machines, Azure file shares and more. You can also access Azure Virtual Machine backup information with Backup Explorer and use Backup Reports across delegated subscriptions to track historical trends, analyze backup storage consumption and audit backups and restores. With Azure Lighthouse, the backup storage accounts remain in your customers' subscriptions, so the data does not leave their Azure tenant.

### Monitoring and alerting

Create, view, and manage activity log alerts in your customer's tenants. View Azure Monitor alerts and create alerts in customer tenants that trigger automations, such as Azure Automation runbooks or Azure Functions. You can create Log Analytics workspaces directly in your customers' subscriptions, so their logging data remains in their Azure tenant. And with Azure Service Health, you can monitor the health of your customer's resources and their Azure services.  

### Networking management

Deploy, configure and manage Azure virtual networks, virtual network interface cards and Azure Firewall. Manage connectivity services such as Azure Virtual WAN, ExpressRoute, and VPN Gateways.

### Azure Kubernetes Service management

Manage hosted Kubernetes environments and deploy and manage containerized applications. Deploy and manage clusters in customer tenants.

### Security management

Cross-tenant visibility in Microsoft Defender for Cloud lets you monitor security policies and triage and action security recommendations with secure score calculation. You can detect threats across tenants' resources, apply advanced threat protection controls, harden network security group configuration with adaptive hardening and monitor changes to important files and registry entries. With Microsoft Sentinel, you can track attacks and view incidents and security alerts across multiple tenants.

### Governance

Using Azure Policy, you can create and edit policy definitions within your customer's tenants. At scale, you can deploy policy definitions and assignments across multiple tenants.  

For a list of key scenarios that benefit from cross-tenant management at scale, visit [Cross-tenant management experiences](/azure/lighthouse/concepts/cross-tenant-management-experience#enhanced-services-and-scenarios)
