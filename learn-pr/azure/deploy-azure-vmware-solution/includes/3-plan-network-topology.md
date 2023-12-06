Azure VMware Solution provides a private-cloud environment you can access from both on-premises and Azure-based environments or resources. The next step in Azure VMware Solution deployment involves a plan for network topology.

The Azure VMware Solution environment in Azure needs to pass network traffic to Azure services and on-premises VMware environments. A dedicated Azure ExpressRoute circuit provides connectivity to Azure resources and services from Azure VMware Solution. A separate, customer-provided Azure ExpressRoute circuit provides connectivity to on-premises VMware environments. To accomplish network connectivity, specific IP address ranges and firewall ports must be enabled. When Azure VMware Solution is deployed, private networks are created for the following vSphere components:

- Management
- Provisioning
- vMotion

You'll use these private networks to access vCenter, NSX-T Manager, and vMotion, or for VM deployment.

## IP segments

IP addressing must be planned out before Azure VMware Solution deployment. The service ingests a /22 CIDR network address block that you provide. You can carve up the address space into smaller network segments within NSX-T Manager. Those IP segments are used for vCenter, VMware HCX, NSX-T, and vMotion. Azure VMware Solution, your existing Azure environment, and your on-premises environment will all need to exchange routes to migrate VMs into Azure. The /22 CIDR network address block you define shouldn't overlap with network address blocks already configured on-premises or in Azure.

A VM IP segment must be built to create the first NSX segment in the Azure VMware Solution private cloud. The VM IP segment allows for deployment of VMs onto Azure VMware Solution. Optionally, network segments can be extended from an on-premises VMware environment to Azure VMware Solution. On-premises networks must connect to a vSphere Distributed Switch (vDS), because vSphere Standard Switches can't be extended.

## Example subnet breakdown

The following table shows an example of how to carve up the /22 CIDR network address block into different IP segments:

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

## ExpressRoute virtual network gateway and peering for Azure VMware Solution

During Azure VMware Solution deployment, you can select an existing virtual network, create a new one, or leave the field blank.

If you select an existing virtual network, you must designate a GatewaySubnet for the Azure VMware Solution ExpressRoute circuit. If you create a brand-new virtual network, you must create a GatewaySubnet for the Azure VMware Solution ExpressRoute circuit. When you either select a virtual network or create a new one, all the ExpressRoute configurations to peer the circuit into Azure are done for you while the environment is provisioned in Azure.

If you leave the virtual network blank, you'll have to create a virtual network gateway and peer the ExpressRoute circuit to Azure after Azure VMware Solution finishes deployment.

:::image type="content" source="../media/5-create-private-cloud.png" alt-text="Screenshot of the Azure portal showing the virtual network field left blank during a private-cloud deployment.":::

## ExpressRoute and routing requirements

There are two types of interconnectivity for Azure VMware Solution:

- **Basic interconnectivity**: Azure VMware Solution connects to an Azure virtual network by using an ExpressRoute connection that deploys with the resource. The Azure VMware Solution-provided ExpressRoute circuit establishes connectivity to and from the Azure VMware Solution private cloud for other Azure services, like Azure Monitor and Microsoft Defender for Cloud.
- **Full interconnectivity**: This connectivity model extends the basic interconnectivity implementation to include interconnectivity between on-premises and Azure VMware Solution private clouds. You can configure this connection via a customer-provided ExpressRoute circuit, among other methods. You can use an existing circuit or purchase a new one.

ExpressRoute Global Reach must be enabled to route traffic to and from the on-premises environment to the Azure VMware Solution private cloud. The customer-provided ExpressRoute circuit is not a part of the Azure VMware Solution private-cloud deployment.

## Prerequisites for ExpressRoute Global Reach

There are a few prerequisites before you configure ExpressRoute Global Reach.

- A separate, customer-provided ExpressRoute circuit is required. This circuit is used to connect on-premises environments to Azure.
- If you are an AVS customer and need Global Reach, a /29 non-overlapping network-address block is required for ExpressRoute Global Reach peering.
- All gateways, including the ExpressRoute provider's service, must support 4-byte ASN. Azure VMware Solution uses 4-byte public ASNs for advertising network routes.

## Required network ports

If on-premises network infrastructure is restrictive, the following ports must be allowed:

| Source | Destination | Protocol | Port |
| :------------ | :------| :------ | :------ |
| Azure VMware Solution private-cloud DNS server | On-premises DNS server | UDP | 53 |
| On-premises DNS server | Azure VMware Solution DNS server | UDP | 53 |
| On-premises network | Azure VMware Solution vCenter | TCP (HTTP/HTTPS) | 80, 443 |
| Azure VMware Solution private-cloud management network | On-premises Active Directory | TCP | 389 |
| On-premises vCenter | Azure VMware Solution management network | TCP | 8000 |
| Web browser | Hybrid Cloud Manager (HCM) | TCP (HTTPS) | 9443 |
| Admin network | HCM | SSH | 22 |
| HCM | Cloud gateway | TCP (HTTPS) | 8123, 9443 |
| Cloud gateway | Layer 2 connectivity | TCP (HTTPS) | 443
| Cloud gateway | ESXi hosts | TCP | 80, 902 |
| Cloud gateway (local) | Cloud gateway (remote) | UDP | 4500, 500 |

## DHCP and DNS resolution considerations

VMs running in Azure VMware Solution require name resolution. VMs might also need DHCP services for lookup and IP-address assignments. You can configure an on-premises VM or an Azure VM to facilitate name resolution. You can use the DHCP service built in to NSX or you can choose to use a local DHCP server in the Azure VMware Solution private cloud. Configuring DHCP in Azure VMware Solution won't require routing broadcasts of DHCP traffic over the WAN back to the on-premises environment.

In the next unit, we'll go through the deployment of Azure VMware Solution. We'll outline all the steps so you can deploy the service in your environment.
