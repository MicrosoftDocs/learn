Now that you know what Azure VMware Solution is and what it can do, let's see how it works on Azure.

## Shared support

On-premises VMware vSphere environments require the customer to support all the hardware and software for running the platform. Azure VMware Solution doesn't. Microsoft maintains the platform for the customer. Let's look at what the customer manages and what Microsoft manages.

For the following table: Microsoft manages = **Blue**, Customer manages = **Grey**

:::image type="icon" source="../media/3-azure-vmware-solution-responsibility-matrix.png" border="false" alt-text="Diagram that shows the shared support matrix for Azure VMware Solution.":::

In partnership with VMware, Microsoft covers the life-cycle management of VMware software (ESXi, vCenter Server, and vSAN). Microsoft also works with VMware for the life-cycle management of NSX appliances and bootstrapping the network configuration. Including, creating the Tier-0 gateway and enabling north/south routing.

The customer is responsible for the NSX SDN configuration:

- Network segments
- Distributed firewall rules
- Tier 1 gateways
- Load balancers

## Monitoring and remediation

Azure VMware Solution continuously monitors the health of both the underlying components and the VMware solution components. If Azure VMware Solution detects failure, it repairs the failed components. When Azure VMware Solution detects a degradation or failure on an Azure VMware Solution node, it triggers the host remediation process.

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

Each private cloud can have multiple clusters managed by the same vCenter Server and NSX Manager. Private clouds are installed and managed from within an Azure subscription. The number of private clouds within a subscription is scalable.

For each private cloud created, there's one vSphere cluster by default. You can add, delete, and scale clusters by using the Azure portal or by using the API. Microsoft offers node configurations based on core, memory, and storage requirements. Choose the type of node that's appropriate for your region; the most common choice is AV36P. 

Minimum and maximum node configurations are:

- Minimum of three nodes in a cluster
- Maximum of 16 nodes in a cluster
- Maximum of 12 clusters in an Azure VMware Solution private cloud
- Maximum of 96 nodes in an Azure VMware Solution private cloud

The following table shows the CPU, memory, disk, and network specifications of the available AVS Hosts:

| Host Type | CPU   | RAM   | vSAN Cache Tier | vSAN Capacity |
| :---     | :---  | :---:  | :---            | :---          |
| AV36      | Dual Intel Xeon Gold 6140 CPUs, 18 cores/CUP @ 2.3 GHz. Total 36 physical cores. | 576 GB | 3.2 TB (NVMe) | 15.20 TB (SSD)|
| AV36P      | Dual Intel Xeon Gold 6240 CPUs, 18 cores/CPU @ 2.6 GHz / 3.9 GHz Turbo. Total 36 physical cores. | 768 GB | 1.5 TB (Intel Cache) | 19.20 TB (NVMe)|
| AV52      | Dual Intel Xeon Platinum 8270 CPUs, 26 cores/CPU @ 2.7 GHz / 4.0 GHz Turbo. Total 52 physical cores. | 1,536 GB | 1.5 TB (Intel Cache) | 38.40 TB (NVMe)|
| AV64*      | Dual Intel Xeon Platinum 8370C CPUs, 32 cores/CPU @ 2.8 GHz / 3.5 GHz Turbo. Total 64 physical cores. | 1,024 GB | 3.84 TB (NVMe) | 15.36 TB (NVMe)|

(*) An Azure VMware Solution private cloud deployed with AV36, AV36P, or AV52 is required prior to adding AV64 hosts. 

You use vSphere and NSX Manager to manage most aspects of cluster configuration or operation. All local storage for each host in a cluster is under the control of vSAN. Each ESXi host in the solution is configured with four 25-Gbps NICs, two NICs provisioned for ESXi system traffic, and two NICs provisioned for workload traffic.

The VMware software versions used in new deployments of private cloud clusters in Azure VMware Solution are:

| Software                     |    Version   |
| :---                         |     :---     |
| VMware vCenter Server        |    7.0 U3o   |
| ESXi                         |    7.0 U3o   |
| vSAN                         |    7.0 U3    |
| vSAN on-disk format          |    15        |
| HCX                          |    4.8.2     |
| VMware NSX                   |    4.1.1     |

NSX-T is the only supported version of NSX. When new clusters are added to an existing private cloud, the currently running software version is applied. 

## Interconnectivity in Azure

The private cloud environment for Azure VMware Solution can be accessible from on-premises and Azure-based resources. The following services deliver the interconnectivity:

- Azure ExpressRoute
- VPN connections
- Azure Virtual WAN
- Azure ExpressRoute Gateway

The following diagram shows the ExpressRoute and ExpressRoute Global Reach interconnectivity method for Azure VMware Solution.

:::image type="icon" source="../media/3-networking-overview.png" border="false" alt-text="Diagram of Azure VMware Solution using ExpressRoute and ExpressRoute Global Reach.":::

These services require you to enable specific network address ranges and firewall ports. 

You can use an existing ExpressRoute gateway to connect to Azure VMware Solution if it doesn't exceed the limit of four ExpressRoute circuits per virtual network. To access Azure VMware Solution from on-premises via ExpressRoute, use ExpressRoute Global Reach as the preferred option. If it's unavailable or unsuitable due to specific network or security requirements, consider alternate options.

ExpressRoute Global Reach is used to connect private clouds to on-premises environments. The connection requires a virtual network with an ExpressRoute circuit to on-premises in your subscription.
There are two options for interconnectivity in the private cloud for Azure VMware Solution:

- **Basic Azure-only interconnectivity** lets you manage and use your private cloud with only a single virtual network in Azure. This implementation is best suited for Azure VMware Solution evaluations or implementations that don't require access from on-premises environments.

- **Full interconnectivity between on-premises and private cloud** extends the basic Azure-only implementation to include interconnectivity between on-premises environments and Azure VMware Solution private clouds.

During the deployment of a private cloud, private networks for management, provisioning, and vMotion are created. These private networks are used to access vCenter Server and NSX-T Manager, virtual machine vMotion, or virtual machine deployment.

### Private cloud storage 

Azure VMware Solution uses native, fully configured, all-flash VMware vSAN storage that's local to the cluster. All local storage from each host in a cluster is used in a VMware vSAN datastore, and data-at-rest encryption is enabled by default.

vSAN original storage architecture uses a unit of resources known as a disk group. Each disk group consists of a cache and capacity tier. All disk groups use an NVMe or Intel cache, as described in the following table. The size of the cache and capacity tiers vary, depending on the Azure VMware Solution host type. Two disk groups are created on each node of the vSphere cluster. Each disk group contains one cache disk and three capacity disks. All datastores are created as part of a private-cloud deployment and are available for use immediately.

| Host Type | vSAN Cache tier (TB, raw) | vSAN Capacity tier (TB, raw) |
| :---      | :---                      | :--- |                      
| AV36      | 3.2 (NVMe)                | 15.20 (SSD)   |
| AV36P     | 1.5 (Intel Cache)         | 19.20 (NVMe)  |
| AV52      | 1.5 (Intel Cache)         | 38.40 (NVMe)  |
| AV64      | 3.84 (NVMe)               | 15.36 (NVMe)  |


A policy is created on the vSphere cluster and applied to the vSAN datastore. It determines how the VM storage objects are provisioned and allocated within the vSAN datastore to guarantee the required level of service. To maintain the service-level agreement, 25 percent spare capacity must be maintained on the vSAN datastore.  In addition, the applicable FTT (failure-to-tolerate) policy needs to be applied, to maintain the service-level agreement for Azure VMware Solution. That changes, based on cluster size.  

You can use Azure storage services in workloads that are running in your private cloud. The following diagram shows some of the available storage services that you can use with Azure VMware Solution.

:::image type="icon" source="../media/3-storage-overview.png" border="false" alt-text="Diagram that shows Azure VMware Solution and the available Azure Storage services. Including Azure Blob Storage, Azure Files, Azure File Sync, and Azure NetApp Files.":::

## Security and compliance

Azure VMware Solution private clouds use vSphere role-based access control for access and security. You can configure Users and Groups in Active Directory with the CloudAdmin Role using LDAP or LDAPS.

In Azure VMware Solution, vCenter Server has a built-in local user called *cloudadmin* that's assigned to the **cloudAdmin** role. The cloudAdmin role has vCenter Server permissions that differ from the administrator permissions in other VMware cloud solutions:

- The local CloudAdmin user doesn't have the permission to add an identity source, like an on-premises Lightweight Directory Access Protocol (LDAP) or Secure LDAP (LDAPS) server to vCenter Server. It is possible to use Run commands to add an identity source and assign the CloudAdmin role to users and groups.

- In an Azure VMware Solution deployment, the administrator doesn't have access to the administrator user account. The administrator can assign Active Directory users and groups to the CloudAdmin role on vCenter Server.

- The private cloud user doesn't have access to, and can't configure, specific management components that Microsoft supports and manages. Examples of these components are clusters, hosts, datastores, and distributed virtual switches.

Azure VMware Solution provides security for vSAN storage datastores by using data-at-rest encryption and turning it on by default. The encryption is based on Key Management Service (KMS) and supports vCenter Server operations for key management. Keys are stored encrypted and wrapped by an Azure Key Vault master key. When a host is removed from a cluster, data on SSDs is invalidated immediately. The following diagram illustrates the relationship of the encryption keys to Azure VMware Solution.

:::image type="icon" source="../media/3-security-overview.png" border="false" alt-text="Diagram that shows the flow of encryption keys in Azure VMware Solution.":::

## Steps for deploying Azure VMware Solution

The following table outlines the steps that an organization takes to get started with using Azure VMware Solution.

|Milestone |Steps  |
|---------|---------|
|Plan   |  Plan the deployment of Azure VMware Solution: <br> - Assess workloads <br> - Determine sizing <br> - Identify the host <br> - Request a quote <br> - Determine networking and connectivity      |
|Deploy     | Deploy and configure Azure VMware Solution: <br>- Register the Microsoft.AVS resource provider <br>- Create an Azure VMware Solution private cloud <br>- Connect to Azure Virtual Network with ExpressRoute  <br>- Validate the connection<br>    |
|Connect to on-premises     |  Create an ExpressRoute authorization key in the on-premises ExpressRoute circuit: <br>- Peer the private cloud to on-premises  <br> - Verify on-premises network connectivity <br> Other connectivity options are also available.    |
|Deploy and configure VMware HCX     |  Deploy and configure VMware HCX: <br>- Enable the HCX service add-on <br>- Download the VMware HCX Connector OVA <br>- Deploy the on-premises VMware HCX OVA (VMware HCX Connector)<br>-  Activate the VMware HCX Connector <br>- Pair your on-premises VMware HCX Connector with your Azure VMware Solution HCX Cloud Manager <br>- Configure the interconnect (network profile, compute profile, and service mesh) <br>- Complete setup by checking the appliance status and validating that migration is possible     |
