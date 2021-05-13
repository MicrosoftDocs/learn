Now that we know what Azure VMware Solutions are, let's see how it is set up and works on Azure.  

## What's managed by Microsoft and what you manage
One benefit of Azure VMware Solution is the platform is maintained for you. Microsoft is responsible for the lifecycle management of VMware software (ESXi, vCenter, and vSAN). Microsoft is also responsible for the lifecycle management of NSX-T appliances, bootstrapping the network configuration, such as creating the Tier-0 gateway and enabling North-South routing. 

You are responsible for NSX-T SDN configuration: network segments, distributed firewall rules, Tier 1 gateways, and load balancers.

## What Microsoft manages

Azure VMware Solution continuously monitors the health of both the underlay and the VMware components. When Azure VMware Solution detects a failure, it takes action to repair the failed components. When Azure VMware Solution detects a degradation or failure on an Azure VMware Solution node, it triggers the host remediation process.

Host remediation involves replacing the faulty node with a new healthy node in the cluster. Then, when possible, the faulty host is placed in VMware vSphere maintenance mode. VMware vMotion moves the VMs off the faulty host to other available servers in the cluster, potentially allowing zero downtime for live migration of workloads. If the faulty host can't be placed in maintenance mode, the host is removed from the cluster.

Azure VMware Solution monitors the following conditions on the host:

- Processor status
- Memory status
- Connection and power state
- Hardware fan status
- Network connectivity loss
- Hardware system board status
- Errors occurred on the disk(s) of a vSAN host
- Hardware voltage
- Hardware temperature status
- Hardware power status
- Storage status
- Connection failure

## Architecture Overview

Azure VMware Solution (AVS) provides you with private clouds that contain vSphere clusters, built from dedicated bare-metal Azure infrastructure. 

###  Private clouds, clusters, and hosts in Azure

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

### Interconnectivity into Azure
The Azure VMware Solution private cloud environment can be accessible from on-premises and Azure-based resources.  The following services deliver the connectivity:

- Azure ExpressRoute
- VPN connections
- Azure Virtual WAN

These services require specific network address ranges and firewall ports for enabling the services. 

You can use an existing ExpressRoute Gateway to connect to Azure VMware Solution as long as it doesn't exceed the limit of four ExpressRoute circuits per virtual network. To access Azure VMware Solution from on-premises through ExpressRoute. You must have ExpressRoute Global Reach since the ExpressRoute Gateway doesn't provide transitive routing between its connected circuits. 

ExpressRoute Global Reach is used to connect private clouds to on-premises environments. The connection requires a virtual network with an ExpressRoute circuit to on-premises in your subscription.
There are two ways to interconnectivity in the Azure VMware Solution private cloud:

- **Basic Azure-only interconnectivity** lets you manage and use your private cloud with only a single virtual network in Azure. This implementation is best suited for Azure VMware Solution evaluations or implementations that don't require access from on-premises environments.

- **Full on-premises to private cloud interconnectivity** extends the basic Azure-only implementation to include interconnectivity between on-premises and Azure VMware Solution private clouds.

During the deployment of a private cloud the private networks for management, provisioning, and vMotion get created. These private networks will be used to access vCenter and NSX-T Manager and virtual machine vMotion or deployment.


### Private cloud storage 

Azure VMware Solution uses native fully configured all-flash vSAN storage, local to the cluster. All local storage from each host in a cluster is used in a vSAN datastore and data-at-rest encryption enabled by default. De-duplication and compression are enabled on the vSAN datastore by default

All diskgroups use an NVMe cache tier of 1.6 TB with the raw, per host, SSD-based capacity of 15.4 TB. Two disk groups are created on each node of the vSphere cluster. Each disk group contains one cache disk and three capacity disks. All datastores are created as part of a private cloud deployment and are available for use immediately.

Policy is created on the vSphere cluster and applied to the vSAN datastore, determines how the VM storage objects are provisioned and allocated within the datastore to guarantee the required level of service. To maintain SLA, 25% spare capacity must be maintained on the vSAN datastore. 
You can use Azure storage services in workloads running in your private cloud. The Azure storage services include:
- Storage Accounts 
- Table Storage
- Blob Storage


### Security and compliance with Azure VMware Solutions
Azure VMware Solution private clouds use vSphere role-based access control for acesss and security. You can integrate vSphere SSO LDAP capabilities with Azure Active Directory. 

In Azure VMware Solution, vCenter has a built-in local user called cloudadmin and assigned to the CloudAdmin role.  The CloudAdmin role has vCenter privileges that differ from other VMware cloud solutions.

- The local cloudadmin user is used to set up users in Active Directory (AD).

- In an Azure VMware Solution deployment, the administrator doesn't have access to the administrator user account. They are, however, assign AD users and groups to the CloudAdmin role on vCenter.

- The private cloud user doesn't have access to and can't configure specific management components supported and managed by Microsoft. For example, clusters, hosts, datastores, and distributed virtual switches.

vSan storage datastore security is provided by data-at-rest encryption that is turned on by default. The encryption is KMS-based and supports vCenter operations for key management. Keys are stored encrypted, wrapped by an Azure Key Vault master key. When a host is removed from a cluster, data on SSDs is invalidated immediately.

## Get Started with AVS

The following outlines the steps needed for an organization to get started with using the Azure VMware Solution.

<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-0lax{text-align:left;vertical-align:top}
.tg .tg-0pky{border-color:inherit;text-align:left;vertical-align:top}
</style>
<table class="tg">
<thead>
  <tr>
    <th class="tg-0lax">Milestone</th>
    <th class="tg-0lax">Steps</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td class="tg-0pky">Plan </td>
    <td class="tg-0pky">Plan the deployment of AVS<br>- Assessment<br>- Request Quota<br>- Identify host<br>- Determine Sizing and Connectivity</td>
  </tr>
  <tr>
    <td class="tg-0pky">Deploy</td>
    <td class="tg-0pky">Deploy and configure AVS<br> - Register the Microsoft.AVS resource provider</td>
  </tr>
  <tr>
    <td class="tg-0pky">Connect to on-premises</td>
    <td class="tg-0pky">connectivity to on-prem</td>
  </tr>
  <tr>
    <td class="tg-0pky">Install HCX</td>
    <td class="tg-0pky">Deploy and configure HCX</td>
  </tr>
</tbody>
</table>

### More AVS