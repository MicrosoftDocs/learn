Azure VMware Solution provides a private cloud environment you can access from both on-premises and Azure-based environments or resources. The next step in Azure VMware Solution deployment involves a plan for network topology.

The Azure VMware Solution environment in Azure needs to pass network traffic to Azure services and on-premises VMware environments. A dedicated Azure ExpressRoute circuit provides connectivity to Azure resources and services from Azure VMware Solution. A separate, customer-provided Azure ExpressRoute circuit provides connectivity to on-premises VMware environments. To accomplish network connectivity, specific IP address ranges and firewall ports must be enabled. When Azure VMware Solution is deployed, private networks are created for the following vSphere components:

- Management
- Provisioning
- VMware vMotion

You use these private networks to access vCenter Server, NSX Manager, and vMotion.

## IP segments

IP addressing must be planned out before the Azure VMware Solution private cloud deployment. The service requires a /22 CIDR network address block that you provide. The /22 CIDR is required for the management components of Azure VMware Solution. Workload segments, on which virtual machines (VMs) are deployed, will have a different IP address range. You can do that by creating network segments within NSX Manager. 

The management CIDR is automatically carved up in smaller segments. Those IP segments are used for vCenter Server, VMware HCX, NSX, and VMware vMotion. Azure VMware Solution, your existing Azure environment, and your on-premises environment will need to exchange routes to migrate VMs into Azure. The /22 CIDR network address block you define must not overlap with network address blocks already configured on-premises or in Azure.

A VM IP segment must be built to create the first NSX segment in the Azure VMware Solution private cloud. The VM IP segment allows for deployment of VMs onto Azure VMware Solution. Optionally, network segments can be extended from an on-premises VMware environment to Azure VMware Solution using VMware HCX Layer 2 Network Extension. On-premises networks must connect to a vSphere Distributed Switch (vDS) because vSphere Standard Switches can't be extended using VMware HCX.

## Example subnet breakdown

The following table shows an example of how the /22 CIDR network address block (10.5.0.0/22 in this example) is carved into different IP segments:

| Network usage | Subnet | Example |
| :------------ | :------| :------ |
| Private cloud management |/26 | 10.5.0.0/26 |
| HCX migrations | /26 | 10.5.0.64/26 |
| Global Reach reserved | /26 |	10.5.0.128/26 |
| ExpressRoute reserved | /27 |	10.5.0.192/27 |
| ExpressRoute peering | /27 | 10.5.0.224/27 |
| ESXi management | /25 | 10.5.1.0/25 |
| vMotion network | /25 | 10.5.1.128/25 |
| Replication network | /25 | 10.5.2.0/25 |
| vSAN | /25 | 10.5.2.128/25 |
| HCX uplink | /26 | 10.5.3.0/26 |
| Reserved | 3 /26 blocks| 10.5.3.64/26, 10.5.3.128/26, 10.5.3.192/26 |

## Azure VMware Solution network connectivity

After deploying Azure VMware Solution, establishing network connectivity becomes the next step for a successful deployment.

The Azure VMware Solution private cloud is deployed on dedicated bare-metal servers that are exclusively assigned to a single customer. To use Azure resources, these servers need to connect to the Azure network backbone. The Azure VMware Solution provides an Azure ExpressRoute circuit that allows communication between the Azure VMware Solution private cloud and Azure services. To connect with on-premises environment via ExpressRoute, you can configure ExpressRoute Global Reach to your existing ExpressRoute circuit.

## ExpressRoute and routing requirements

There are two types of interconnectivity for Azure VMware Solution:

- **Basic Azure-only interconnectivity**: Azure VMware Solution connects to an Azure virtual network by using an ExpressRoute connection that deploys with the resource. The Azure VMware Solution-provided ExpressRoute circuit establishes connectivity to and from the Azure VMware Solution private cloud for other Azure services, like Azure Monitor and Microsoft Defender for Cloud.
- **Full on-premises to private cloud interconnectivity**: This connectivity model extends the basic interconnectivity implementation to include interconnectivity between on-premises and Azure VMware Solution private clouds. You can configure this connection via a customer-provided ExpressRoute circuit, among other methods. You can use an existing circuit or purchase a new one.

ExpressRoute Global Reach serves as the default choice for hybrid connectivity in Azure VMware Solution. However, there are scenarios where Global Reach might not be applicable – either due to its unavailability in your region or specific network or security requirements that cannot be met by Global Reach. In such cases, you can consider transiting data over ExpressRoute Private Peering, or using IPSec VPN.

The customer-provided ExpressRoute circuit isn't a part of the Azure VMware Solution private cloud deployment.

## Prerequisites for ExpressRoute Global Reach

There are a few prerequisites before you configure ExpressRoute Global Reach.

- A separate, customer-provided ExpressRoute circuit is required. This circuit is used to connect on-premises environments to Azure.
- All gateways, including the ExpressRoute provider's service, must support 4-byte Autonomous System Numbers (ASNs). Azure VMware Solution uses 4-byte public ASNs for advertising network routes.

## Required network ports

If on-premises network infrastructure is restrictive, the following ports must be allowed:

| Source | Destination | Protocol | Port |
| :------------ | :------| :------ | :------ |
| Azure VMware Solution private cloud DNS server | On-premises DNS server | UDP | 53 |
| On-premises DNS server | Azure VMware Solution DNS server | UDP | 53 |
| On-premises network | Azure VMware Solution vCenter Server | TCP (HTTP/HTTPS) | 80, 443 |
| Azure VMware Solution private cloud management network | On-premises Active Directory | TCP | 389/636 |
| Azure VMware Solution private cloud management network | On-premises Active Directory Global Catalog | TCP | 3268/3269 |
| On-premises network | HCX Cloud Manager | TCP (HTTPS) | 9443 |
| On-premises Admin Network | HCX Cloud Manager | SSH | 22 |
| HCX Manager | Interconnect (HCX-IX) | TCP (HTTPS) | 8123 |
| HCX Manager | Interconnect (HCX-IX), Network Extension (HCX-NE) | TCP (HTTPS) | 9443 |
| Interconnect (HCX-IX) | Layer 2 connectivity | TCP (HTTPS) | 443 |
| HCX Manager, Interconnect (HCX-IX) | ESXi Hosts | TCP | 80, 443, 902 | 
| Interconnect (HCX-IX), Network Extension (HCX-NE) at Source | Interconnect (HCX-IX), Network Extension (HCX-NE) at Destination | UDP | 4500 |
| On-premises Interconnect (HCX-IX) | Cloud Interconnect (HCX-IX) | UDP | 500 |
| On-premises vCenter Server network | Azure VMware Solution management network | TCP | 8000 |
| HCX Connector | connector.hcx.vmware.com hybridity.depot.vmware.com | TCP | 443 |


## DHCP and DNS resolution considerations

Virtual machines (VMs) running in Azure VMware Solution require name resolution. VMs might also need DHCP services for lookup and IP-address assignments. You can configure an on-premises VM or an Azure VM to facilitate name resolution. You can use the DHCP service built into NSX or you can choose to use a local DHCP server in the Azure VMware Solution private cloud. Configuring DHCP in Azure VMware Solution won't require routing broadcasts of DHCP traffic over the WAN back to the on-premises environment.

In the next unit, we'll go through the deployment of Azure VMware Solution. We outline all the steps so you can deploy the service in your environment.
