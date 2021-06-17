
The Azure VMware Solution (AVS) is an Azure service to redeploy and extend your VMware-based enterprise workloads to Azure. AVS is a VMware validated solution with on-going certification and testing of enhancements and upgrades.

Microsoft provides the following services to run AVS at scale in Azure:
- management systems
- networking services 
- operating platform 
- backend infrastructure operations 

## Move your VMware workloads to Azure

Every company is in a different place when it comes to its digital transformation journey and use of the cloud.  In partnership with VMware, Microsoft has created the Azure VMware Solution (AVS). Azure VMware Solution combines VMware's Software-Defined Data Center (SDDC) software with Microsoft's Azure global cloud service. Gain continuity, scale, and fast provisioning for your VMware workloads on the global Azure infrastructure.

Azure VMware Solution is managed by Microsoft to meet performance, availability, security, and compliance requirements. Allowing you to focus on developing and running workloads that are critical to your business.

AVS enables organizations to efficiently move existing VMware workloads to Azure. You can migrate workloads from your on-premises environments, deploy new virtual machines (VMs), and connect workloads directly to Azure services. 

The VMware vSphere clusters are built from bare-metal Azure hosts. These clusters are deployed and managed through the Azure portal, CLI, or PowerShell. All provisioned private clouds have standard supported versions of VMware vCenter Server, vSAN, vSphere, and NSX-T included and fully licensed. Gain elasticity with the ability to seamlessly add and remove capacity (compute and storage resources) on demand.

The diagram below illustrates the relationship between private clouds and networks in Azure, Azure services, and on-premises environments.

:::image type="icon" source="../media/2-avs-overview.png" border="false" alt-text="Diagram of Azure VMware Solution relationship between cloud and on-premises.":::

### Key features of Azure VMware Solution
Azure VMware Solution provides a comprehensive VMware environment in Azure. Migrating to AVS include the following key features listed below.

**Use your existing VMware investments:** No need to reskill and learn new tools because the underlying product is the standard VMware vSphere and vCenter products. Manage your VMware environments without the need to retrain staff or refactor the underlying hypervisors. 

**Create operational consistency for admins:** Operational consistency is created for admins as you continue to use VMware for resources running on Azure, including vSphere Client and NSX-T Manager. Admins have direct administrative access to VMware vSphere interfaces. The Azure portal is used only for deployment and management operations.

**Maintain operational consistency for the business:** Reduce change management and maintain operational consistency for the business. You can use all of your existing investments:
- Training
- Process management
- Change management
- Tooling

Accelerate migration and minimize downtime using the latest HCX Enterprise functionality for large scale, live migration from on-premises to Azure.

**Single Point of Support :** Azure VMware Solution is Microsoft developed, operated, and supported. Microsoft is the first and only contact and coordinates support with VMware as required.

### Unique benefits of Azure VMware Solution
Benefits that are unique to migrating to AVS include the following benefits:

**Unified Licensing and Consumption :** Avoid licensing complexity by working with a single vendor for licensing and resource consumption. Track your VMware licensing directly with resource nodes as they're deployed and decommissioned.

**Azure Hybrid Use Benefits :** Maximize the value of existing Windows Server and SQL Server licenses. Use Azure Hybrid Benefit (AHUB) for both Windows Server and SQL Server. AHUB allows you to bring your existing licenses to Azure and greatly reduce costs. Save up to 80% with AHUB and Azure Reserved Instances.

**Free Extended Security Updates**: Get Extended Security Updates at no extra charge for three years on all your Windows Server 2008/R2 and SQL Server 2008/R2 workloads on Azure VMware Solutions.

### Integration with native Azure services

Azure VMware Solution gives customers options when migrating to the cloud. Modernize applications running on VMware overtime through integration to Azure native management, security, and services. Admins develop cloud skills overtime as they become familiar with Azure.

AVS allows the business to move to the cloud at the pace they're comfortable with. Admins get a seamless Azure experience with a single Azure portal interface with no connection to any third-party services.

Once your VMware environment is on Azure, all Azure services can be accessed. Some of the integrations you could use within your AVS environment are described below.

:::image type="icon" source="../media/2-avs-integration-overview.png" border="false" alt-text="Diagram showing some of the integration services available for Azure VMware Solution.":::


|Integration  |Description  |
|---------|---------|
|**Azure Active Directory**     |   Use Azure Active Directory as the VMware vCenter SSO identity source.      |
|**Log Analytics workspace**     | Log Analytics workspace is a unique environment to store log data. Each workspace has its own data repository and configuration. Data sources and solutions are configured to store their data in a specific workspace. Once AVS is deployed into your subscription, Azure Monitor logs are generated automatically.        |
|**Azure Security Center**     | Azure Security Center is a unified infrastructure security management system. It strengthens security of data centers, and provides advanced threat protection across hybrid workloads in the cloud or on premises.        |
|**Azure Sentinel**    |  Azure Sentinel is a cloud-native, security information event management (SIEM) solution. It provides security analytics, alert detection, and automated threat response across an environment.       |
|**Azure NetApp Files**    | Azure NetApp Files shares can be mounted from VMs that are created in the Azure VMware Solution environment. Azure NetApp Files supports Server Message Block (SMB) and Network File System (NFS) protocols. This support means the volumes can be mounted on the Linux client and can be mapped on Windows client.   |
|**Azure Backup Server**     |   Use Azure Backup Server to back up VMware VMs running on VMware ESXi hosts/vCenter Server to Azure.      |
|**Monitor and manage VMs**     | Microsoft Azure native tools allow you to monitor and manage your virtual machines (VMs) in the Azure environment. Yet they also allow you to monitor and manage your VMs on Azure VMware Solution and your on-premises VMs.        |
|**Azure Application Gateway**    | Protect web apps on Azure VMware Solution with Azure Application Gateway. Azure Application Gateway is a layer 7 web traffic load balancer that lets you manage traffic to your web applications.    |
|**Azure Traffic Manager**    |  Deploy Traffic Manager to balance Azure VMware Solution workloads. The integration balances application workloads across multiple endpoints       |

As the Azure VMware Solution continues to advance and mature, more Azure integrations will be added to the offering.

### Continuity of operations
Azure VMware Solution provides application high availability and modernization with well-managed Azure infrastructure designed for end-to-end high availability. The Azure VMware Solution has built in redundancy with no single point of failure. 

With AVS, you can deploy VMware resources on Azure for a primary or secondary on-demand recovery site to provide business continuity for your existing on-premises datacenter resources.

### Billing
There are three different ways that AVS can be billed and charged. Customers have the flexibility to change billing based on their business needs.

|Hourly (PAYG)  |1-Year Reserved Instance  |3-Year Reserved Instance  |
|---------|---------|---------|
|On demand     | Reserved capacity for 1 year       |  Reserved capacity for 3 years       |
| Typically used for bursting <br><br> Initial deployments    | Used for major projects <br><br> Known usage patterns     |  Used with datacenter exit scenarios <br><br> Long-term business strategy      |
|    |         |         |

