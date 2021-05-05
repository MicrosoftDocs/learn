
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

**Azure Native Integration** Connect to Azure services endpoints easily and natively. For example, use Azure Active Directory as the VMware vCenter SSO identity source

**Single Point of Support** Azure VMware Solution is Microsoft developed, operated, and supported. Microsoft is the first and only contact and coordinates support with VMware as required

**Unified Licensing and Consumption** Avoid licensing complexity by working with a single vendor for licensing and resource consumption. Track  your VMware licensing directly with resource nodes as they are deployed and decommissioned.

**Azure Hybrid Use Benefits** Maximize the value of existing Windows Server and SQL Server licenses. Save up to 80% with AHUB and Azure Reserved Instances


###  Private clouds, clusters, and hosts

Private clouds contain vSAN clusters built with dedicated, bare-metal Azure hosts. Each private cloud can have multiple clusters managed by the same vCenter server and NSX-T Manager. Private clouds are installed and managed from within an Azure subscription. The number of private clouds within a subscription is scalable. Initially, there's a limit of one private cloud per subscription.

For each private cloud created, there is one vSAN cluster by default. You can add, delete, and scale clusters using the Azure portal or through the API. The minimum initial deployment is three hosts and can scale up to a maximum of 16 hosts per cluster. Multiple clusters can be deployed into different Azure regions. Hosts used to build or scale clusters come from an isolated pool of hosts. 

The high-end hosts have 576-GB RAM and dual Intel 18 core, 2.3-GHz processors. The HE hosts have two vSAN diskgroups with 15.36 TB (SSD) of raw vSAN capacity tier and a 3.2 TB (NVMe) vSAN cache tier. You use vSphere and NSX-T Manager to manage most aspects of cluster configuration or operation. All local storage of each host in a cluster is under the control of vSAN. Each ESXi host in AVS is configured with four 25-Gbps NICs, two NICs provisioned for ESXi system traffic, and two NICs provisioned for workload traffic

The VMware software versions used in new deployments of Azure VMware Solution private clouds clusters are:

| Software | Version |
| :------- | :------ |
| VCSA/vSphere/vCenter | 6.7 Update 3 |
| ESXi | 6.7 Update 3 |
| vSAN | 6.7 Update 3 |
| NSX-T | 3.1.1 |
| HCX | 4.0 |

NOTE: NSX-T is the only supported version of NSX. New clusters added to an existing private cloud, the currently running software version is applied
