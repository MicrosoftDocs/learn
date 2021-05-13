
Azure VMware Solution is a VMware validated solution with on-going certification and testing of enhancements and upgrades. Microsoft manages and maintains the infrastructure and software, allowing you to focus on developing and running workloads that are critical to your business.



## Discover Azure VMware Solution

Every company is in a different place when it comes to its digital transformation journey and use of the cloud.  In partnership with VMware, Microsoft has created the Azure VMware Solution (AVS). AVS enables organizations to efficiently move existing VMware apps to Azure.

Azure VMware Solution (AVS) provides you with a dedicated, private cloud in Azure. The VMware vSphere clusters are built from bare-metal Azure hosts. These clusters are deployed and managed through the Azure portal, CLI, or PowerShell. All provisioned private clouds have standard supported versions of VMware vCenter Server, vSAN, vSphere, and NSX-T included and fully licensed. You can migrate workloads from your on-premises environments, deploy new virtual machines (VMs), and connect workloads directly to Azure services.

The diagram below illustrates the relationship between private clouds and networks in Azure, Azure services, and on-premises environments. Network access from AVS to Azure services or networks provides reliable, high-speed integration of Azure service endpoints. ExpressRoute Global Reach connects your on-premises environment to your Azure VMware Solution private cloud, providing a unified experience for users and customers accessing AVS-based workloads.


:::image type="icon" source="../media/2-avs-simple-overview.png" border="false" alt-text="Diagram that shows the relationship of an on-premises VMware environment, AVS, and all Azure services that AVS can connect to.":::

With the Azure VMware Solution, you run your VMware estate or a single app on dedicated Azure infrastructure. AVS becomes a platform by which VMware workloads easily be modernized through integration with Azure services such as :
- Azure Active Directory
- Azure AI
- Analytics 
- Azure Monitor


AVS provides value to customers in six  core pillars:

**Unified Azure experience** Single portal interface on Azure with no connection to any third-party services. Allows customers to take advantage of a consistent Azure experience and benefits from the continual improvements to that experience over time. You can use all of your existing investments in VMware:
- Training
- Process management
- Change management
- Tooling

**Azure Native Integration** 

**Single Point of Support** Azure VMware Solution is Microsoft developed, operated, and supported. Microsoft is the first and only contact and coordinates support with VMware as required

**Unified Licensing and Consumption** Avoid licensing complexity by working with a single vendor for licensing and resource consumption. Track  your VMware licensing directly with resource nodes as they are deployed and decommissioned.

**Azure Hybrid Use Benefits** Maximize the value of existing Windows Server and SQL Server licenses. Save up to 80% with AHUB and Azure Reserved Instances


### Familiar and consistent VMware tools and technology
Create operational consistency for admins as you continue to use VMware for resources running on Azure infrastructure including vSphere Client and NSX-T Manager. The Azure portal is used for deployment and several management operations. 

Access to vSphere, VMware HCX, and NSX-T are enabled during the Private Cloud deployment process. Credentials are registered in Azure connect to the private cluster hosts.

### Continuity of Operations
Azure VMware Solution provides application high availability and modernization with well-managed Azure Infrastructure designed for end-to-end High Availability. The Azure VMware Solution has built in redundancy with no single point of failure. 

With AVS, you can deploy VMware resources on Azure for a primary or secondary on-demand recovery site to provide business continuity for your existing on-premises datacenter resources.

### Seamless integration for Azure infrastructure resources 
The Azure VMware Solution provides a fast path to adopt the cloud without the added pain of having to reformat existing assets to work in the new cloud environment. AVS removes that challenge by making it possible to run your VMware estate on Azure as if it were on-premises.

For example, easily scale and manage your infrastructure as your business needs it through the Azure portal. Add new nodes as required to increase compute and storage during peak times. Delete nodes seasonally when infrastructure demands are lower.

Node min and maximums configuration:

- Min 3 nodes per cluster
- Max 16 nodes in a vSphere cluster
- Max 64 nodes to an Azure Private Cloud instance

Connect to Azure services endpoints easily and natively. Azure VMware Solution can integrate with native Azure services such as:

- **Azure Active Directory**: Use Azure Active Directory as the VMware vCenter SSO identity source

- **Log Analytics workspace**: Log Analytics workspace is a unique environment to store log data. Each workspace has its own data repository and configuration. Data sources and solutions are configured to store their data in a specific workspace. Once AVS is deployed into your subscription, Azure Monitor logs are generated automatically. Azure Monitor logs can provide the following data:

    - Collect logs on each of your VMs.
    - Download and install the MMA agent on Linux and Windows VMs.
    - Enable the Azure diagnostics extension.
    - Create and run new queries.
    - Run the same queries you usually run on your VMs

- **Azure Security Center**: Azure Security Center is a unified infrastructure security management system. It strengthens security of data centers, and provides advanced threat protection across hybrid workloads in the cloud or on premises.

- **Azure Sentinel**: Azure Sentinel is a cloud-native, security information event management (SIEM) solution. It provides security analytics, alert detection, and automated threat response across an environment.

- **Integrate Azure NetApp Files with Azure VMware Solution**. Azure NetApp Files shares can be mounted from VMs that are created in the Azure VMware Solution environment. Azure NetApp Files supports Server Message Block (SMB) and Network File System (NFS) protocols. This support means the volumes can be mounted on the Linux client and can be mapped on Windows client. 

- **Back up VMware VMs with Azure Backup Server**. Using Azure Backup Server (MABS) back-up VMware VMs running on VMware ESXi hosts/vCenter Server to Azure.

- **Monitor and manage Azure VMware Solution VMs**. Microsoft Azure native tools allow you to monitor and manage your virtual machines (VMs) in the Azure environment. Yet they also allow you to monitor and manage your VMs on Azure VMware Solution and your on-premises VMs.

- **Protect web apps on Azure VMware Solution with Azure Application Gateway**. Azure Application Gateway is a layer 7 web traffic load balancer that lets you manage traffic to your web applications

- **Deploy Traffic Manager to balance Azure VMware Solution workloads**. The integration balances application workloads across multiple endpoints

## Ways that the Azure VMware Solution is different than running VMware on-premises
