Each company is in a different place in its digital transformation journey and use of the cloud. In partnership with VMware, Microsoft has created Azure VMware Solution. It's a service that enables organizations to move VMware-based enterprise workloads from on-premises to Azure, deploy new virtual machines (VMs), and connect workloads directly to other Azure services.

Azure VMware Solution combines VMware's Software-Defined Data Center (SDDC) software with the Azure global cloud service. It's a VMware-validated solution with ongoing certification and testing of enhancements and upgrades. 

Azure VMware Solution is managed by Microsoft to meet performance, availability, security, and compliance requirements. Microsoft provides the following components to run Azure VMware Solution at scale in Azure:

- Management systems
- Networking services
- Operating platform
- Back-end infrastructure operations 

The VMware vSphere clusters are built from bare-metal Azure hosts. These clusters are deployed and managed through the Azure portal, the Azure CLI, or PowerShell. All provisioned private clouds have standard supported versions of VMware vCenter Server, vSAN, vSphere, and NSX-T included and fully licensed. If you choose the service for your company, you can gain elasticity with the ability to add and remove capacity (compute and storage resources) on demand.

The following diagram illustrates the relationship between private clouds and networks in Azure, Azure services, and on-premises environments.

:::image type="icon" source="../media/2-overview.png" border="false" alt-text="Diagram of Azure VMware Solution that shows the relationship between cloud and on-premises.":::

### Key features
Azure VMware Solution provides a comprehensive VMware environment in Azure. It enables your organization to:

- **Use existing VMware investments**: There's no need to reskill and learn new tools because the underlying products are the standard VMware vSphere and vCenter products. You can manage your VMware environments without the need to retrain staff or refactor the underlying hypervisors. 

- **Create operational consistency for admins**: Operational consistency is created for admins because you continue to use VMware for resources running on Azure, including vSphere Client and NSX-T Manager. Admins have direct access to VMware vSphere interfaces. The Azure portal is used only for deployment and management operations.

- **Maintain operational consistency for the business**: The service can reduce change management and maintain operational consistency for the business. You can use all of your organization's existing investments in:
  - Training
  - Process management
  - Change management
  - Tooling

   You can accelerate migration and minimize downtime by using the latest HCX Enterprise functionality for large-scale, live migration from on-premises to Azure.

- **Have a single point of support**: Azure VMware Solution is Microsoft developed, operated, and supported. Microsoft is the first and only contact and coordinates support with VMware as required.

- **Avoid licensing complexity**: You work with a single vendor for licensing and resource consumption. You can track VMware licensing directly with resource nodes as they're deployed and decommissioned.

- **Maximize the value of existing Windows Server and SQL Server licenses**: You can use Azure Hybrid Benefit for both Windows Server and SQL Server to bring existing licenses to Azure and reduce costs.

### Integration with native Azure services

Azure VMware Solution gives customers options for migrating their VMware environment to the cloud at their own pace. Admins use a single Azure portal interface with no connection to any third-party services. They develop cloud skills over time as they become familiar with Azure.

Native Azure tools and services like the following ones allow you to monitor and manage VMs in the Azure environment. You can use those same tools and services to monitor and manage VMs on Azure VMware Solution and on-premises VMs.

:::image type="icon" source="../media/2-integration-overview.png" border="false" alt-text="Diagram that shows some of the integration services available for Azure VMware Solution.":::

|Integration  |Description  |
|---------|---------|
|**Log Analytics workspace**     | A Log Analytics workspace in Azure Monitor is a unique environment to store log data. Each workspace has its own data repository and configuration. Data sources and solutions are configured to store their data in a specific workspace. After the solution is deployed into a subscription, Azure Monitor logs are generated automatically.        |
|**Microsoft Defender for Cloud**     | Microsoft Defender for Cloud is a unified security management system for infrastructure. It strengthens the security of datacenters, and it provides advanced threat protection across hybrid workloads in the cloud or on-premises.        |
|**Microsoft Sentinel**    |  Microsoft Sentinel is a cloud-native security information and event management (SIEM) solution. It provides security analytics, alert detection, and automated threat response across an environment.       |
|**Azure NetApp Files**    | Azure NetApp Files shares can be mounted from VMs that are created in the Azure VMware Solution environment. Azure NetApp Files supports Server Message Block (SMB) and Network File System (NFS) protocols. This support means the volumes can be mounted on the Linux client and can be mapped on a Windows client.   |
|**Azure Backup Server**     |   You can use Azure Backup Server to back up VMware VMs running on VMware ESXi hosts or vCenter Server to Azure.      |
|**Azure Application Gateway**    | You can help protect web apps on Azure VMware Solution by using Azure Application Gateway. It's a layer-7 load balancer that enables the management of traffic to web applications.    |
|**Azure Traffic Manager**    |  You can deploy Traffic Manager to balance Azure VMware Solution workloads. The integration balances application workloads across multiple endpoints.       |

### Continuity of operations
Azure VMware Solution provides infrastructure high availability and modernization with well-managed Azure infrastructure designed for end-to-end high availability. The service has built-in redundancy with no single point of failure. 

With Azure VMware Solution, you can deploy VMware resources on Azure for a primary or secondary on-demand recovery site to provide business continuity for on-premises datacenter resources.

### Billing
Azure VMware Solution can be billed and charged in the following three ways. Customers have the flexibility to change billing based on their business needs.

|Hourly (pay as you go)  |1-Year Reserved Instance  |3-Year Reserved Instance  |
|---------|---------|---------|
|On demand     | Reserved capacity for one year       |  Reserved capacity for three years       |
| Typically used for bursting <br><br> Initial deployments    | Used for major projects <br><br> Known usage patterns     |  Used with datacenter exit scenarios <br><br> Long-term business strategy      |
|    |         |         |
