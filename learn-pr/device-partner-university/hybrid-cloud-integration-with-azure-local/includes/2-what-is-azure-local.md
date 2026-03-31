Azure Local is Microsoft’s unified hyperconverged infrastructure (HCI) solution, purpose-built to empower organizations to run virtualized workloads, containers, and modern cloud services directly on-premises or at the edge. By seamlessly integrating with Microsoft Azure, Azure Local enables organizations to extend their capabilities beyond the boundaries of local data centers, all while maintaining control over data residency, compliance, and operational efficiency.

## Platform overview and hybrid delivery

Azure Local brings together virtualized workloads, containers, and cloud services on validated hardware, delivering cloud-like efficiencies while ensuring data remains on-premises. This is especially valuable for organizations facing stringent data residency requirements due to legal, privacy, or internal policy constraints.

Azure Local supports a broad spectrum of workloads, including:

- Windows virtual machines
- Linux virtual machines
- Azure Virtual Desktop
- AI/ML applications

All of these are managed within a unified platform.

To support compliance and lifecycle management, Azure Local includes extended security updates for Windows Server workloads migrated to the platform, at no additional cost. The solution is designed to operate in both connected and disconnected scenarios, making it ideal for edge deployments and regulated industries.

Azure Local extends on-premises environments into the cloud, enabling unified management of hosts, virtual machines, containers, and Azure resources through the Azure portal and Azure Arc. Organizations benefit from a range of management capabilities, including:

- Monitoring clusters
- Managing extensions and policies
- Deploying self-service workloads using Azure Arc–enabled nodes
- Receiving consistent feature and security updates
- Unified billing through an Azure subscription (billed per physical core)
- Access to a comprehensive catalog of validated hardware options

>[!IMPORTANT]
> Ensure all hardware meets Azure Local requirements for compatibility and support. Visit [Architecture Best Practices for Azure Local](/azure/well-architected/service-guides/azure-local) for more details.

## Hybrid integration and management

Azure Local is designed to simplify hybrid cloud integration, offering built-in connectivity to Microsoft Azure services. Organizations benefit from a variety of cloud capabilities, such as:

- Centralized monitoring
- Backup
- Disaster recovery
- Policy enforcement

Native integration eliminates the need for additional agents or complex scripts, streamlining deployment and reducing administrative overhead.

Centralized management of on-premises clusters is achieved through Azure services, including:

- Azure Monitor for performance and health
- Azure Security Center for advanced threat protection
- Azure Policy for governance

Azure Resource Manager (ARM) represents each on-premises cluster as a resource in the Azure portal, allowing administrators to manage hybrid environments within a unified interface.

Azure Local supports Azure-based management capabilities that help IT administrators organize, monitor, and secure their hybrid infrastructure using familiar Azure tools and services. Key resource organization features include:

- Tags for labeling clusters based on attributes such as department, environment, or project
- Resource groups for logical organization and collective management of related resources
- A centralized management interface offering a comprehensive view of all clusters, regardless of physical location
- Azure Identity and Access Management (IAM) for fine-grained access control

>[!CAUTION]
> Without proper tagging and grouping, resources can become difficult to manage and audit. Learn more at [Define your tagging strategy](/azure/cloud-adoption-framework/ready/azure-best-practices/resource-tagging).

Azure Local integrates seamlessly with existing environments and supports popular third-party solutions using familiar management tools. IT teams can take advantage of:

- Windows Admin Center’s graphical interface for deployment and management
- Automation with Windows PowerShell
- Infrastructure-as-code tools like Bicep and Azure CLI
- Azure Update Manager for orchestrating updates and monitoring health across all Azure Local nodes

| **Tool/Interface** | **Use Case** | **Typical User** |
| :---: | :---: | :---: |
| Azure portal | Centralized management, monitoring, policy | Cloud/Hybrid Admin |
| Azure Arc | Hybrid resource onboarding, governance | Cloud/Hybrid Admin |
| Windows Admin Center | Local deployment, configuration, monitoring | On-premises IT Admin |
| PowerShell | Automation, scripting, advanced management | IT Pro/DevOps |
| Azure CLI/Bicep | Infrastructure as code, automation | DevOps/Cloud Engineer |
| Azure Update Manager | Orchestrating updates, compliance reporting | IT Admin |

-

## User scenario

You use Azure Arc to connect your on-premises clusters to Azure, enabling centralized monitoring, backup, disaster recovery, and policy enforcement. You organize resources with tags and resource groups, and automate updates using Azure Update Manager. Windows Admin Center and PowerShell streamline your day-to-day operations.

:::image type="content" border="true" source="../media/azure-arc-diagram.png" alt-text="A diagram showing Azure Local clusters managed via Azure Arc, with centralized operations, automated updates, and direct management tools.":::
