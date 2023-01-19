Now that you know what Azure VMware Solution is and what it can do, let's see how it's set up and how it works on Azure.  

## Shared support
On-premises VMware environments require the customer to support all the hardware and software for running the platform. Azure VMware Solution does not. Microsoft maintains the platform for the customer. Let's take a look what the customer manages and what Microsoft manages.

:::image type="icon" source="../media/3-azure-vmware-solution-responsibility-matrix.png" border="false" alt-text="Diagram that shows the shared support matrix for Azure VMware Solution.":::

In partnership with VMware, Microsoft covers the life-cycle management of VMware software (ESXi, vCenter, and vSAN). Microsoft also works with VMware for the life-cycle management of NSX-T appliances and bootstrapping the network configuration, such as creating the Tier 0 gateway and enabling north/south routing. 

The customer is responsible for NSX-T SDN configuration:
- Network segments
- Distributed firewall rules
- Tier 1 gateways
- Load balancers

## Monitoring and remediation 

Azure VMware Solution continuously monitors the health of both the underlay and the VMware components. If Azure VMware Solution detects a failure, it takes action to repair the failed components. When Azure VMware Solution detects a degradation or failure on an Azure VMware Solution node, it triggers the host remediation process.

Host remediation involves replacing the faulty node with a new healthy node in the cluster. Then, when possible, the faulty host is placed in VMware vSphere maintenance mode. VMware vMotion moves the VMs off the faulty host to other available servers in the cluster, potentially allowing zero downtime for live migration of workloads. If the faulty host can't be placed in maintenance mode, the host is removed from the cluster.

Azure VMware Solution monitors the following conditions on the host:

- Processor status
- Memory status
- Connection and power state
- Hardware fan status
- Network connectivity loss
- Hardware system board status
- Errors occurring on the disks of a vSAN host
- Hardware voltage
- Hardware temperature status
- Hardware power status
- Storage status
- Connection failure

## Private clouds, clusters, and hosts in Azure

Azure VMware Solution provides private clouds that contain vSphere clusters. Those clusters are built from dedicated bare-metal Azure hosts. 

Each private cloud can have multiple clusters managed by the same vCenter server and NSX-T Manager. Private clouds are installed and managed from within an Azure subscription. The number of private clouds within a subscription is scalable. Initially, there's a limit of one private cloud per subscription.

For each private cloud created, there is one vSphere cluster by default. You can add, delete, and scale clusters by using the Azure portal or by using the API. Microsoft offers node configurations based on core, memory, and storage requirements. Choose the type of node that's appropriate for your region; the most common choice is AV36. 

Minimum and maximum node configurations are:

- Minimum of 3 nodes in a cluster
- Maximum of 16 nodes in a cluster
- Maximum of 12 clusters in an Azure private cloud
- Maximum of 96 nodes in an Azure private cloud

Each of the high-end hosts has 576 GB of RAM and dual Intel 18-core, 2.3-GHz processors. The high-end hosts have two vSAN disk groups with a 15.36-TB (SSD) raw vSAN capacity tier and a 3.2 TB (NVMe) vSAN cache tier.

You use vSphere and NSX-T Manager to manage most aspects of cluster configuration or operation. All local storage for each host in a cluster is under the control of vSAN. Each ESXi host in the solution is configured with four 25-Gbps NICs, two NICs provisioned for ESXi system traffic, and two NICs provisioned for workload traffic.

The VMware software versions used in new deployments of private-cloud clusters in Azure VMware Solution are:

| Software                     |    Version   |
| :---                         |     :---:    |
| VMware vCenter Server        |    7.0 U3c   |
| ESXi                         |    7.0 U3c   |
| vSAN                         |    7.0 U3c   |
| vSAN on-disk format          |    10        |
| HCX                          |    4.4.2     |
| VMware NSX-T Data Center <br />**NOTE:** VMware NSX-T Data Center is the only supported version of NSX Data Center.               |      3.1.2     |

NSX-T is the only supported version of NSX. When new clusters are added to an existing private cloud, the currently running software version is applied. 

After Azure VMware Solution is deployed into your subscription, Azure Monitor logs are automatically generated. You can use Azure Monitor logs to monitor VM patterns inside Azure VMware Solution.

## Interconnectivity in Azure

The private-cloud environment for Azure VMware Solution can be accessible from on-premises and Azure-based resources. The following services deliver the interconnectivity:

- Azure ExpressRoute
- VPN connections
- Azure Virtual WAN

The following diagram shows the ExpressRoute and ExpressRoute Global Reach interconnectivity method for Azure VMware Solution.

:::image type="icon" source="../media/3-networking-overview.png" border="false" alt-text="Diagram of Azure VMware Solution using ExpressRoute and ExpressRoute Global Reach.":::

These services require you to enable specific network address ranges and firewall ports. 

You can use an existing ExpressRoute gateway to connect to Azure VMware Solution, as long as it doesn't exceed the limit of four ExpressRoute circuits per virtual network. To access Azure VMware Solution from on-premises through ExpressRoute, you must have ExpressRoute Global Reach.

ExpressRoute Global Reach is used to connect private clouds to on-premises environments. The connection requires a virtual network with an ExpressRoute circuit to on-premises in your subscription.
There are two options for interconnectivity in the private cloud for Azure VMware Solution:

- **Basic Azure-only interconnectivity** lets you manage and use your private cloud with only a single virtual network in Azure. This implementation is best suited for Azure VMware Solution evaluations or implementations that don't require access from on-premises environments.

- **Full interconnectivity between on-premises and private cloud** extends the basic Azure-only implementation to include interconnectivity between on-premises environments and Azure VMware Solution private clouds.

During the deployment of a private cloud, the private networks for management, provisioning, and vMotion are created. These private networks will be used to access vCenter and NSX-T Manager and virtual machine vMotion or deployment.

### Private-cloud storage 

Azure VMware Solution uses native, fully configured, all-flash vSAN storage that's local to the cluster. All local storage from each host in a cluster is used in a vSAN datastore, and data-at-rest encryption is enabled by default. Deduplication and compression are enabled on the vSAN datastore by default.

All disk groups use an NVMe cache tier of 1.6 TB with the raw SSD-based capacity of 15.4 TB per host. Two disk groups are created on each node of the vSphere cluster. Each disk group contains one cache disk and three capacity disks. All datastores are created as part of a private-cloud deployment and are available for use immediately.

A policy is created on the vSphere cluster and applied to the vSAN datastore. It determines how the VM storage objects are provisioned and allocated within the datastore to guarantee the required level of service. To maintain the service-level agreement, 25 percent spare capacity must be maintained on the vSAN datastore. 

You can use Azure storage services in workloads that are running in your private cloud. The following diagram shows the available storage services that you can use with Azure VMware Solution.

:::image type="icon" source="../media/3-storage-overview.png" border="false" alt-text="Diagram that shows Azure VMware Solution and the available Azure Storage services, including Azure Blob Storage, Azure Files, Azure File Sync, and Azure NetApp Files.":::

## Security and compliance
Azure VMware Solution private clouds use vSphere role-based access control for access and security. You can configure Users and Groups in Active Directory with the CLoudAdmin Role using LDAP or LDAPS 

In Azure VMware Solution, vCenter has a built-in local user called cloudadmin that's assigned to the cloudAdmin role. The cloudAdmin role has vCenter privileges that differ from the privileges in other VMware cloud solutions:

- The local cloudadmin user can link an identity source so that Active Directory administrators can grant permission to users of Azure VMware Solution.

- In an Azure VMware Solution deployment, the administrator doesn't have access to the administrator user account. The admin can, however, assign Active Directory users and groups to the cloudAdmin role on vCenter.

- The private-cloud user doesn't have access to, and can't configure, specific management components that Microsoft supports and manages. Examples of these components are clusters, hosts, datastores, and distributed virtual switches.

Azure VMware Solution provides security for vSAN storage datastores by using data-at-rest encryption that's turned on by default. The encryption is based on Key Management Service (KMS) and supports vCenter operations for key management. Keys are stored encrypted and wrapped by an Azure Key Vault master key. When a host is removed from a cluster, data on SSDs is invalidated immediately. The following diagram illustrates the relationship of the encryption keys to Azure VMware Solution.

:::image type="icon" source="../media/3-security-overview.png" border="false" alt-text="Diagram that shows the flow of encryption keys in Azure VMware Solution.":::

## Steps for deploying Azure VMware Solution

The following table outlines the steps that an organization takes to get started with using Azure VMware Solution.

|Milestone |Steps  |
|---------|---------|
|Plan   |  Plan the deployment of Azure VMware Solution: <br> - Assess <br>- Request a quota <br>- Identify the host <br>- Determine sizing and connectivity      |
|Deploy     | Deploy and configure Azure VMware Solution: <br>- Register the Microsoft.AVS resource provider <br>- Create an Azure VMware Solution private cloud <br>- Connect to Azure Virtual Network with ExpressRoute  <br>- Validate the connection<br>    |
|Connect to on-premises     |  - Create an ExpressRoute authorization key in the on-premises ExpressRoute circuit <br>- Peer the private cloud to on-premises  <br> - Verify on-premises network connectivity    |
|Deploy and configure VMware HCX     |  Deploy and configure VMware HCX: <br>- Download the VMware HCX Connector OVA <br>- Deploy the on-premises VMware HCX OVA (VMware HCX Connector)<br>-  Activate the VMware HCX Connector <br>- Pair your on-premises VMware HCX Connector with your Azure VMware Solution HCX Cloud Manager <br>- Configure the interconnect (network profile, compute profile, and service mesh) <br>- Complete setup by checking the appliance status and validating that migration is possible     |

