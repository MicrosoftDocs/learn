<!--
From design doc outline:

overview
logical architecture

Git workflow reminder from Learn training:

https://review.docs.microsoft.com/learn/modules/github-workflow/3-add-update-content?branch=master&pivots=addcontentbash

Writing resources:

- Tips for writing unit content: https://review.docs.microsoft.com/learn-docs/docs/unit-writing-learning-content?branch=master#tips-for-writing-unit-content

- Writing principles job aid: https://review.docs.microsoft.com/help/contribute/writing-principles-voice-job-aid?branch=master

- Use Acrolinx as you're writing content. You must have overall score of 80 to get PRs merged: https://review.docs.microsoft.com/help/contribute/contribute-get-started-setup-acrolinx-vscode?branch=master

-->
## Discover Azure VMware Solution

Every company is in a different place when it comes to its digital transformation journey and use of the cloud.  In partnership with VMware, Microsoft has created the Azure VMware Solution (AVS). AVS enables organizations to efficiently move existing VMware apps to Azure.

With the Azure VMware Solution, you run your VMware estate or a single app on dedicated Azure infrastructure. AVS becomes a platform by which VMware workloads easily be modernized through integration with Azure services such as Azure Active Directory, Azure AI, and Analytics enabling new, intelligent experiences. 

AVS provides value to customers in six  core pillars:

**Unified Azure experience** Single portal interface on Azure with no connection to any third-party services. Allows customers to take advantage of a consistent Azure experience and benefits from the continual improvements to that experience over time

**Use Existing VMware investments. You can use all of your existing investments in VMware:
- Training
- Process management
- Change management
- Tooling

**Azure Native Integration** Connect to Azure services endpoints easily and natively. For example, use Azure Active Directory as the VMware vCenter SSO identity source

**Single Point of Support** Azure VMware Solution is Microsoft developed, operated, and supported. Microsoft is the first and only contact and coordinates support with VMware as required

**Unified Licensing and Consumption** Avoid licensing complexity by working with a single vendor for licensing and resource consumption. Track  your VMware licensing directly with resource nodes as they are deployed and decommissioned.

**Azure Hybrid Use Benefits** Maximize the value of existing Windows Server and SQL Server licenses. Save up to 80% with AHUB and Azure Reserved Instances

## What is Azure VMware Solution

Azure VMware Solution is a VMware validated solution with on-going certification and testing of enhancements and upgrades. Microsoft manages and maintains the infrastructure and software, allowing you to focus on developing and running workloads that are critical to your business.

Azure VMware Solution (AVS) provides you with a dedicated, private cloud in Azure. The VMware vSphere clusters are built from bare-metal Azure hosts. These clusters are deployed and managed through the Azure portal, CLI, or PowerShell. All provisioned private clouds have standard supported versions of VMware vCenter Server, vSAN, vSphere, and NSX-T included and fully licensed. You can migrate workloads from your on-premises environments, deploy new virtual machines (VMs), and connect workloads directly to Azure services.

The diagram above illustrates the relationship between private clouds and networks in Azure, Azure services, and on-premises environments. Network access from AVS to Azure services or networks provides reliable, high-speed integration of Azure service endpoints. ExpressRoute Global Reach connects your on-premises environment to your Azure VMware Solution private cloud, providing a unified experience for users and customers accessing AVS-based workloads.

## Logical Architecture - Private clouds, clusters, hosts, and storage

Private clouds contain vSAN clusters built with dedicated, bare-metal Azure hosts. Each private cloud can have multiple clusters managed by the same vCenter server and NSX-T Manager. Private clouds are installed and managed from within an Azure subscription. The number of private clouds within a subscription is scalable. Initially, there's a limit of one private cloud per subscription.

For each private cloud created, there is one vSAN cluster by default. You can add, delete, and scale clusters using the Azure portal or through the API. The minimum initial deployment is three hosts and can scale up to a maximum of 16 hosts per cluster. Multiple clusters can be deployed into different Azure regions. Hosts used to build or scale clusters come from an isolated pool of hosts. 

The high-end hosts have 576-GB RAM and dual Intel 18 core, 2.3-GHz processors. The HE hosts have two vSAN diskgroups with 15.36 TB (SSD) of raw vSAN capacity tier and a 3.2 TB (NVMe) vSAN cache tier. You use vSphere and NSX-T Manager to manage most aspects of cluster configuration or operation. All local storage of each host in a cluster is under the control of vSAN. Each ESXi host in AVS is configured with four 25-Gbps NICs, two NICs provisioned for ESXi system traffic, and two NICs provisioned for workload traffic

The VMware software versions used in new deployments of Azure VMware Solution private clouds clusters are:

| Software   | Version |
| :---------- | :------------------ |
| VCSA / vSphere / ESXi | 6.7 U3l|
| ESXi | 6.7 U3l |
| vSAN | 6.7 U3l |
| NSX-T | 4.0 |
NOTE: NSX-T is the only supported version of NSX. New clusters added to an existing private cloud, the currently running software version is applied

## Private cloud networking
The Azure VMware Solution private cloud environment can be accessible from on-premises and Azure-based resources.  The following services deliver the connectivity:

- Azure ExpressRoute
- VPN connections
- Azure Virtual WAN

These services require specific network address ranges and firewall ports for enabling the services. 

You can use an existing ExpressRoute Gateway to connect to Azure VMware Solution as long as it doesn't exceed the limit of four ExpressRoute circuits per virtual network. To access Azure VMware Solution from on-premises through ExpressRoute. You must have ExpressRoute Global Reach since the ExpressRoute Gateway doesn't provide transitive routing between its connected circuits. 

ExpressRoute Global Reach is used to connect private clouds to on-premises environments. The connection requires a virtual network with an ExpressRoute circuit to on-premises in your subscription.
There are two ways to interconnectivity in the Azure VMware Solution private cloud:

- Basic Azure-only interconnectivity lets you manage and use your private cloud with only a single virtual network in Azure. This implementation is best suited for Azure VMware Solution evaluations or implementations that don't require access from on-premises environments.

- Full on-premises to private cloud interconnectivity extends the basic Azure-only implementation to include interconnectivity between on-premises and Azure VMware Solution private clouds.

During the deployment of a private cloud the private networks for management, provisioning, and vMotion get created. These private networks will be used to access vCenter and NSX-T Manager and virtual machine vMotion or deployment.


## Private cloud storage

Azure VMware Solution uses native, cluster-wide storage with VMware vSAN. All local storage from each host in a cluster is used in a vSAN datastore and data-at-rest encryption enabled by default.

Local storage in each cluster host is used as part of a vSAN datastore. All diskgroups use an NVMe cache tier of 1.6 TB with the raw, per host, SSD-based capacity of 15.4 TB. Local storage in cluster hosts is used in cluster-wide vSAN datastore. All datastores are created as part of a private cloud deployment and are available for use immediately.

You can use Azure storage services in workloads running in your private cloud. The Azure storage services include:
- Storage Accounts 
- Table Storage
- Blob Storage


