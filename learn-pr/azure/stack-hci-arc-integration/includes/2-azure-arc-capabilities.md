Azure Arc serves as the core component that facilitates integration of non-Azure resources with Azure, helping companies like Contoso to bridge the gap between the administrative models of on-premises and cloud services. In this unit, you'll learn about the basic characteristics of Azure Arc and the range of scenarios it supports.

## What is Azure Arc?

The business-technology landscape continuously evolves and becomes increasingly complex, with multiple applications running on different hardware across on-premises datacenters, multiple public and private clouds, and the edge. Managing these disparate environments at scale, enhancing security across an entire organization so that it cannot be compromised, and enabling developer agility and innovation are critical for businesses to succeed and thrive. Microsoft Azure provides tools and solutions that help customers like Contoso innovate their hybrid environments in the secure manner and with a minimized management overhead.

Azure Arc is an example of such a solution. It consists of a set of technologies that you can use to simplify administration of complex, distributed, hybrid environments. It provides a centralized, scalable, consistent multicloud and on-premises governance and management platform. It facilitates adoption of DevOps practices such as desired state configuration and automation, delivers built-in monitoring and security, and promotes the cloud-first strategy, regardless of where your resources are located. At the same time, Azure Arc still allows you to continue using traditional ITOps tools and practices as you transition to the DevOps model to fully benefit from cloud native architectural and operational patterns.

:::image type="content" source="../media/2-arc-overview.png" alt-text="Diagram showing an administrator using Azure management tools via Azure Arc to connect and manage resources in Multicloud, Edge, and On-premises scenarios." border="false":::

:::image type="content" source="../media/2-arc-management.png" alt-text="Diagram of Azure management tools being used to manage both Azure hosted resources and through Azure Arc resources located elsewhere." border="false":::

## What types of resources support Azure Arc?

Azure Arc supports Azure integration in several distinct scenarios for different types of resources residing outside of Azure via the following offerings:

- **Azure Arc-enabled servers**: Physical and virtual machines (VM) running Windows or Linux operating system.
- **Azure Arc-enabled SQL Server**: SQL Server instances running on Azure Arc-enabled servers.
- **Azure Arc-enabled Kubernetes**: A wide range of Kubernetes distributions.
- **Azure Stack HCI**: Physical clusters with virtualized workloads and containerized workloads.
- **Azure Kubernetes Service on Azure Stack HCI**: Azure Kubernetes Service (AKS) running on Azure Stack HCI clusters.
- **Azure Arc-enabled data services**: Azure SQL Managed Instance running on Azure Arc-enabled Kubernetes or Azure Kubernetes Service on Azure Stack HCI.

> [!NOTE]
> Verify that the Azure Arc features you intend to use in your production environment are generally available.

## How to enable Azure Arc

In each of the Azure Arc-enabled scenarios, Azure Arc leverages locally installed agents to establish a logical connection between the local resource and Azure. By establishing this connection, a non-Azure resource automatically becomes a hybrid Azure resource with its own identity, represented by an Azure Resource Manager resource ID. Azure Resource Manager serves as the management interface that allows you to create, modify, and delete Azure resources. Once you Arc-enable a non-Azure resource, you can use Azure Resource Manager to manage and monitor its configuration and operations.

With Azure Arc-enabled servers, the connection to Azure relies on the Connected Machine agent. You have the option to install it on individual Windows or Linux servers manually or by running a script available from the Azure portal. This requires that you authenticate to your Azure subscription interactively for each installation. If an Arc-enabled server is hosting a SQL Server instance, you can also register it with Azure Arc using the Azure portal and a registration script to implement Azure Arc-enabled SQL Server. In enterprise environments, you'll likely perform installations at scale by using a script or PowerShell Desired State Configuration-based installation with authentication via an Azure Active Directory (Azure AD) service principal.

:::image type="content" source="../media/2-generate-script.png" alt-text="Screenshot that depicts the Select a method blade of the Azure Arc Machines node. Two options are available: Add machines using an interactive script and Add machines at scale." border="false":::

In case of Azure Stack HCI clusters, the Azure Arc agent is already included as part of the operating system of cluster nodes, so there's no need to install it. You activate it by registering your Azure Stack HCI cluster with Azure Arc, which automatically enables Azure monitoring, support, and billing.

For Kubernetes and AKS clusters, connecting to Azure requires a deployment of several agents as containers within a designated cluster namespace. The agents are responsible for maintaining connectivity to Azure, collecting Azure Arc logs and metrics, and processing configuration requests. To streamline the process of Azure Arc integration, you can use Windows Admin Center or script the deployment steps.

## What are the key benefits of Azure Arc?

A number of Azure Arc benefits are independent of the resource type, because they reflect the capabilities of Azure Resource Manager. These benefits include:

- The ability to organize all resources by using Azure management groups, subscriptions, resource groups, and tags.
- A single, comprehensive inventory of organizational assets across multiclouds and on-premises, including support for searching and indexing by using Azure Resource Graph.
- A consolidated view of Azure and Azure Arc enabled resources via the Azure portal, Azure CLI, Azure PowerShell, and Azure REST API.
- Delegation of permissions on the management plane by using Azure Role Based Access Control (RBAC).
- Support for the resource context access to Log Analytics data. Resource context allows you to restrict the scope of access to Log Analytics data based on the permissions to the corresponding Azure resource. Because each Azure Arc enabled server, cluster, or data service exists as an Azure resource, you can control access to its Log Analytics logs by relying on RBAC permissions assigned to that resource.
- Integration with Azure Monitor. You can use Azure Monitor to help monitor and manage your server resources. Azure Monitor is a core component of the Microsoft strategy to extend comprehensive, cloud-based monitoring functionality beyond Azure to on-premises datacenters and to Microsoft and other cloud providers.

There are also resource type-specific benefits, such as:

- **Azure Arc-enabled servers**

  - The ability to apply Azure VM extensions to automate configuration of Azure and non-Azure Windows and Linux servers in the consistent manner.
  - Support for Azure Policy guest configuration. Azure Policy supports auditing Azure Arc enabled servers in the same way as their Azure-resident counterparts. This allows you to use the same approach to evaluate whether configurations of all servers in your environment comply with organizational standards.

- **Azure Arc-enabled SQL Server**

  - Support for Advanced data security using Microsoft Defender for Cloud and Microsoft Sentinel.
  - The ability to perform SQL Environment health checks using the on-demand SQL Assessment feature, which also provides best practices recommendations.

- **Azure Arc-enabled Kubernetes Service (AKS) on Azure Stack HCI**

  - Enforcement of runtime policies by using Azure Policy for Kubernetes and centralized reporting of the corresponding policy compliance. This allows you, for example, to enforce HTTPS ingress in a Kubernetes cluster or ensure that containers listen only on allowed ports.
  - Support for automated updates to cluster configuration by using GitOps. GitOps is the practice of automatic deployment of code residing in a Git repository. In this scenario, that code describes the desired state of Kubernetes configuration. You have the option to enforce specific GitOps-based configurations by using Azure Policy, which also provide centralized reporting of the corresponding policy compliance.
  - Automatic upgrades and updates without any service downtime. Azure Arc-enabled Kubernetes Service receives updates on a frequent basis including servicing patches and new features, which mirror the update management model of their Azure counterparts.
  - Support for automatic scaling. Azure Arc-enabled Kubernetes service can autoscale dynamically to limits dependent on the capacity of your infrastructure.

- **Azure Arc-enabled data services**

  - Automatic upgrades and updates without any service downtime. Azure Arc-enabled data services receive updates on a frequent basis including servicing patches and new features, which mirror the update management model of their Azure counterparts.
  - Support for automatic scaling. Azure Arc-enabled data services can autoscale dynamically to limits dependent on the capacity of your infrastructure.

## Additional reading

You can learn more by visiting the following webpages:

- [What is Azure Resource Manager?](/azure/azure-resource-manager/management/overview/?azure-portal=true)
- [Azure Arc overview](/azure/azure-arc/overview/?azure-portal=true)
- [What is Azure Arc enabled servers?](/azure/azure-arc/servers/overview/?azure-portal=true)
- [Register Azure Stack HCI with Azure](/azure-stack/hci/deploy/register-with-azure/?azure-portal=true)
- [Azure Arc enabled SQL Server](/sql/sql-server/azure-arc/overview?azure-portal=true)
- [What is Azure Arc enabled Kubernetes?](/azure/azure-arc/kubernetes/overview/?azure-portal=true)
- [What is on-premises Kubernetes with Azure Kubernetes Service on Azure Stack HCI and Windows Server?](/azure/aks/hybrid/overview)
- [What are Azure Arc enabled data services (preview)?](/azure/azure-arc/data/overview/?azure-portal=true)

Choose the best response for each of the following questions, then select **Check your answers**.
