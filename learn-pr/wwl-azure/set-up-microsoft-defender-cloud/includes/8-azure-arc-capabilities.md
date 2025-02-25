Currently, Azure Arc allows you to manage the following resource types hosted outside of Azure:

 -  **Servers**: Manage Windows and Linux physical servers and virtual machines hosted outside of Azure.
 -  **Kubernetes clusters**: Attach and configure Kubernetes clusters running anywhere with multiple supported distributions.
 -  **Azure data services**: Run Azure data services on-premises, at the edge, and in public clouds using Kubernetes and the infrastructure of your choice. SQL Managed Instance and PostgreSQL server (preview) services are currently available.
 -  **SQL Server**: Extend Azure services to SQL Server instances hosted outside of Azure.
 -  **Virtual machines (preview)**: Provision, resize, delete, and manage virtual machines based on VMware vSphere or Azure Stack **hyper-converged infrastructure (HCI)** and enable VM self-service through role-based access

:::image type="content" source="../media/azure-arc-features-capabilities-ba7744ce.jpg" alt-text="Diagram showing Azure Arc features and capabilities.":::


## Key features and benefits

Some of the key scenarios that Azure Arc supports are:

 -  Implement consistent inventory, management, governance, and security for servers across your environment.
 -  Configure Azure VM extensions to use Azure management services to monitor, secure, and update your servers.
 -  Manage and govern Kubernetes clusters at scale.
 -  Use GitOps to deploy configuration across one or more clusters from Git repositories.
 -  Zero-touch compliance and configuration for Kubernetes clusters using Azure Policy.
 -  Run Azure data services on any Kubernetes environment as if it runs in Azure (specifically Azure SQL Managed Instance and Azure Database for PostgreSQL server, with benefits such as upgrades, updates, security, and monitoring). Use elastic scale and apply updates without any application downtime, even without continuous connection to Azure.
 -  Create custom locations on top of your Azure Arc-enabled Kubernetes clusters, using them as target locations for deploying Azure services instances. Deploy your Azure service cluster extensions for Azure Arc-enabled data services, App services on Azure Arc (including web, function, and logic apps), and Event Grid on Kubernetes.
 -  Perform virtual machine lifecycle and management operations for VMware vSphere and Azure Stack **hyper-converged infrastructure (HCI)** environments.
 -  A unified experience viewing your Azure Arc-enabled resources, whether you are using the Azure portal, the Azure CLI, Azure PowerShell, or Azure REST API.
