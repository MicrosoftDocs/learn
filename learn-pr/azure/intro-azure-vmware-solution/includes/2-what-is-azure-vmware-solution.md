
The Azure VMware Solution (AVS) is an Azure service to redeploy and extend your VMware-based enterprise workloads to Azure. We provide the management systems, networking services, operating platform and backend infrastructure operations required to run native VMware environments at scale in Azure.  AVS is a VMware validated solution with on-going certification and testing of enhancements and upgrades.

Microsoft manages and maintains the infrastructure and software. Allowing you to focus on developing and running workloads that are critical to your business.

Additionally, AVS becomes a platform by which VMware workloads easily be modernized through integration with Azure services such as Azure Active Directory, Azure AI, Azure Monitor, and Analytics enabling new, intelligent experiences. 


## Move existing VMware workloads to Azure VMware Solution

Every company is in a different place when it comes to its digital transformation journey and use of the cloud.  In partnership with VMware, Microsoft has created the Azure VMware Solution (AVS). Azure VMware Solution combines VMware's Software-Defined Data Center (SDDC) software with Microsoft's Azure global cloud service. Azure VMware Solution is managed to meet performance, availability, security, and compliance requirements. AVS enables organizations to efficiently move existing VMware apps to Azure.

The VMware vSphere clusters are built from bare-metal Azure hosts. These clusters are deployed and managed through the Azure portal, CLI, or PowerShell. All provisioned private clouds have standard supported versions of VMware vCenter Server, vSAN, vSphere, and NSX-T included and fully licensed. You can migrate workloads from your on-premises environments, deploy new virtual machines (VMs), and connect workloads directly to Azure services.

The diagram below illustrates the relationship between private clouds and networks in Azure, Azure services, and on-premises environments. Network access from AVS to Azure services or networks provides reliable, high-speed integration of Azure service endpoints. ExpressRoute Global Reach connects your on-premises environment to your Azure VMware Solution private cloud, providing a unified experience for users and customers accessing AVS-based workloads.


## Azure VMware Solution features:
These are the 6 core pillars of value that AVS provides.

**Unified Azure experience** Single portal interface on Azure with no connection to any third-party services. Allows customers to take advantage of a consistent Azure experience and benefits from the continual improvements over time. 

**Use Existing VMware Investments** Because the underlying product is the standard VMware vSphere and vCenter products. Create operational consistency for admins as you continue to use VMware for resources running on Azure infrastructure including vSphere Client and NSX-T Manager. The Azure portal is used for deployment and management operations. You can use all of your existing investments:
- Training
- Process management
- Change management
- Tooling

**Single Point of Support** Azure VMware Solution is Microsoft developed, operated, and supported. Microsoft is the first and only contact and coordinates support with VMware as required.

**Unified Licensing and Consumption** Avoid licensing complexity by working with a single vendor for licensing and resource consumption. Track your VMware licensing directly with resource nodes as they are deployed and decommissioned.

**Azure Hybrid Use Benefits** Maximize the value of existing Windows Server and SQL Server licenses. Save up to 80% with AHUB and Azure Reserved Instances.

**Azure Native Integration** Connect to Azure services endpoints easily and natively. For example, use Azure Active Directory as the VMware vCenter SSO identity source.

:::image type="icon" source="../media/2-avs-simple-overview.png" border="false" alt-text="Diagram that shows the relationship of an on-premises VMware environment, AVS, and all Azure services that AVS can connect to.":::

### Integration with Azure services
These are some of the integrations you could use within your AVS environment.


|Integration  |Description  |
|---------|---------|
|**Azure Active Directory**     |   Use Azure Active Directory as the VMware vCenter SSO identity source.      |
|**Log Analytics workspace**     | Log Analytics workspace is a unique environment to store log data. Each workspace has its own data repository and configuration. Data sources and solutions are configured to store their data in a specific workspace. Once AVS is deployed into your subscription, Azure Monitor logs are generated automatically.        |
|**Azure Security Center**     | Azure Security Center is a unified infrastructure security management system. It strengthens security of data centers, and provides advanced threat protection across hybrid workloads in the cloud or on premises.        |
|**Azure Sentinel**    |  Azure Sentinel is a cloud-native, security information event management (SIEM) solution. It provides security analytics, alert detection, and automated threat response across an environment.       |
|**Azure NetApp Files**    | Azure NetApp Files shares can be mounted from VMs that are created in the Azure VMware Solution environment. Azure NetApp Files supports Server Message Block (SMB) and Network File System (NFS) protocols. This support means the volumes can be mounted on the Linux client and can be mapped on Windows client.   |
|**Azure Backup Server**     |   Use Azure Backup Server (MABS)to back-up VMware VMs running on VMware ESXi hosts/vCenter Server to Azure.      |
|**Monitor and manage Azure VMware Solution VMs**     | Microsoft Azure native tools allow you to monitor and manage your virtual machines (VMs) in the Azure environment. Yet they also allow you to monitor and manage your VMs on Azure VMware Solution and your on-premises VMs.        |
|**Azure Application Gateway**    | Protect web apps on Azure VMware Solution with Azure Application Gateway. Azure Application Gateway is a layer 7 web traffic load balancer that lets you manage traffic to your web applications.    |
|**Azure Traffic Manager**    |  Deploy Traffic Manager to balance Azure VMware Solution workloads. The integration balances application workloads across multiple endpoints       |


### Continuity of Operations
Azure VMware Solution provides application high availability and modernization with well-managed Azure Infrastructure designed for end-to-end High Availability. The Azure VMware Solution has built in redundancy with no single point of failure. 

With AVS, you can deploy VMware resources on Azure for a primary or secondary on-demand recovery site to provide business continuity for your existing on-premises datacenter resources.

### Billing 

We offer node configurations based on core, memory, and storage requirements. You can choose the type of node that best fits the needs of your organization. A minimum of three nodes are required to deploy Azure VMware Solutions.

Customers are charged hourly each time they provision a node. You can also choose to buy reserved instances for Azure VMware Solution for one- or three-year periods rice predictability.

You can enable VMware HCX Enterprise add-on (which is currently in Preview) by submitting a support request. VMware HCX Enterprise Edition (EE) is available with Azure VMware Solution as a Preview function/service and subject to Preview service terms and conditions. Once the VMware HCX EE service goes GA, you will get a 30-day notice that billing will switch over. You will also have the option to switch off/opt-out of the service.

Also, you can take advantage of Azure Hybrid Benefit, allowing you to run your Windows Server and SQL Server workloads both on-premises and in the cloud. For all your Windows Server 2008/R2 and SQL Server 2008/R2 workloads on Azure VMware Solutions, you get Extended Security Updates at no extra charge for three years. If these workloads were deployed on-premises or on other clouds, the security updates would cost you an another 75% of license price of the latest versions of Windows Server and SQL Server annually.

