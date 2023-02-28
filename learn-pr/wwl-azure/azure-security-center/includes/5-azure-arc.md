
Today, companies struggle to control and govern increasingly complex environments that extend across data centers, multiple clouds, and edge. Each environment and cloud possesses its own set of management tools, and new DevOps and IT operations (ITOps) operational models can be hard to implement across resources.

Azure Arc simplifies governance and management by delivering a consistent multi-cloud and on-premises management platform.

Azure Arc provides a centralized, unified way to:

 -  Manage your entire environment together by projecting your existing non-Azure and/or on-premises resources into Azure Resource Manager.
 -  Manage virtual machines, Kubernetes clusters, and databases as if they are running in Azure.
 -  Use familiar Azure services and management capabilities, regardless of where they live.
 -  Continue using traditional IT operations (ITOps) while introducing DevOps practices to support new cloud-native patterns in your environment.
 -  Configure custom locations as an abstraction layer on top of Azure Arc-enabled Kubernetes clusters and cluster extensions.

:::image type="content" source="../media/azure-arc-deployment-concept-5c19420b.png" alt-text="Screenshot showing Azure arc deployment concept.":::


Currently, Azure Arc allows you to manage the following resource types **hosted outside of Azure**:

 -  **Servers**: Manage Windows and Linux physical servers and virtual machines hosted outside of Azure.
 -  **Kubernetes clusters**: Attach and configure Kubernetes clusters running anywhere with multiple supported distributions.
 -  **Azure data services**: Run Azure data services on-premises, at the edge, and in public clouds using Kubernetes and the infrastructure of your choice. SQL Managed Instance and PostgreSQL (preview) services are currently available.
 -  **SQL Server**: Extend Azure services to SQL Server instances hosted outside of Azure.
 -  **Virtual machines (preview)**: Provision, resize, delete, and manage virtual machines based on VMware vSphere or Azure Stack hyper-converged infrastructure (HCI) and enable VM self-service through role-based access.

## Key features and benefits

Some of the key scenarios that Azure Arc supports are:

Implement consistent inventory, management, governance, and security for servers across your environment.

 -  Configure Azure VM extensions to use Azure management services to monitor, secure, and update your servers.
 -  Manage and govern Kubernetes clusters at scale.
 -  Use GitOps to deploy configuration across one or more clusters from Git repositories.
 -  Zero-touch compliance and configuration for Kubernetes clusters using Azure Policy.
 -  Run Azure data services on any Kubernetes environment as if it runs in Azure (specifically Azure SQL Managed Instance and Azure Database for PostgreSQL server, with benefits such as upgrades, updates, security, and monitoring). Use elastic scale and apply updates without any application downtime, even without continuous connection to Azure.
 -  Create custom locations on top of your Azure Arc-enabled Kubernetes clusters, using them as target locations for deploying Azure services instances. Deploy your Azure service cluster extensions for Azure Arc-enabled data services, App services on Azure Arc (including web, function, and logic apps) and Event Grid on Kubernetes.
 -  Perform virtual machine lifecycle and management operations for VMware vSphere and Azure Stack HCI environments.
 -  A unified experience viewing your Azure Arc-enabled resources, whether you are using the Azure portal, the Azure CLI, Azure PowerShell, or Azure REST API.
