Governance in Azure is one aspect of Azure Management. This unit covers the different areas of management for deploying and maintaining your resources in Azure.

Management refers to the tasks and processes required to maintain your business applications and the resources that support them. Azure has many services and tools that work together to provide complete management. These services aren't only for resources in Azure, but also in other clouds and on-premises. Understanding the different tools and how they work together is the first step in designing a complete management environment.

The following diagram illustrates the different areas of management that are required to maintain any application or resource. These different areas can be thought of as a lifecycle. Each area is required in continuous succession over the lifespan of a resource. This resource lifecycle starts with the initial deployment, through continued operation, and finally when retired.

:::image type="content" source="../media/management-capabilities-4a4821fa-841e5b3b.png" alt-text="Diagram illustrating the different areas of the resource and application lifecycle management.":::


No single Azure service completely fills the requirements of a particular management area. Instead, each is realized by several services working together. Some services, such as Application Insights, provide targeted monitoring functionality for web applications. Others, like Azure Monitor logs, store management data for other services. This feature allows you to analyze data of different types collected by different services.

The following sections briefly describe the different management areas and provide links to detailed content on the main Azure services intended to address them.

## Monitor

Monitoring is the act of collecting and analyzing data to audit the performance, health, and availability of your resources. An effective monitoring strategy helps you understand the operation of components and to increase your uptime with notifications. Read an overview of Monitoring that covers the different services used at [Monitoring Azure applications and resources](/azure/azure-monitor/overview).

## Configure

Configure refers to the initial deployment and configuration of resources and ongoing maintenance. Automation of these tasks allows you to eliminate redundancy, minimizing your time and effort and increasing your accuracy and efficiency. [Azure Automation](/azure/automation/overview) provides the bulk of services for automating configuration tasks. While runbooks handle process automation, configuration and update management help manage configuration.

## Govern

Governance provides mechanisms and processes to maintain control over your applications and resources in Azure. It involves planning your initiatives and setting strategic priorities. Governance in Azure is primarily implemented with two services. [Azure Policy](/azure/governance/policy/overview) allows you to create, assign, and manage policy definitions to enforce rules for your resources. This feature keeps those resources in compliance with your corporate standards. [Azure Cost Management](/azure/cost-management-billing/cost-management-billing-overview) allows you to track cloud usage and expenditures for your Azure resources and other cloud providers.

## Secure

Manage the security of your resources and data. A security program involves assessing threats, collecting and analyzing data, and compliance of your applications and resources. Security monitoring and threat analysis are provided by [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction), which includes unified security management and advanced threat protection across hybrid cloud workloads. See [Introduction to Azure Security](/azure/security/fundamentals/overview) for comprehensive information and guidance on securing Azure resources.

## Protect

Protection refers to keeping your applications and data available, even with outages that are beyond your control. Protection in Azure is provided by two services. [Azure Backup](/azure/backup/backup-overview) provides backup and recovery of your data, either in the cloud or on-premises. [Azure Site Recovery](/azure/site-recovery/site-recovery-overview) provides business continuity and immediate recovery during a disaster.

## Migrate

Migration refers to transitioning workloads currently running on-premises to the Azure cloud. [Azure Migrate](/azure/migrate/migrate-services-overview) is a service that helps you assess the migration suitability of on-premises virtual machines to Azure. Azure Site Recovery migrates virtual machines [from on-premises](/azure/site-recovery/migrate-tutorial-on-premises-azure) or [from Amazon Web Services](/azure/site-recovery/migrate-tutorial-aws-azure). [Azure Database Migration Service](/azure/dms/dms-overview) assists you in migrating database sources to Azure Data platforms.
