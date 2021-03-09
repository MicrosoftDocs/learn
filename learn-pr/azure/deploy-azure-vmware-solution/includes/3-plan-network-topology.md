AVS provides a private cloud environment which can be accessed from both on-premises and Azure-based environments or resources. The next step within AVS deployment involves a plan for network topology. The AVS environment in Azure needs to pass network traffic to Azure services and on-premises VMware environments. A dedicated Azure ExpressRoute circuit provides connectivity to Azure resources and services. A separate customer provided Azure ExpressRoute circuit provides connectivity to on-premises VMware environments. Specific IP address ranges and firewall ports need to be allowed to enable network connectivity. When AVS is deployed, private networks are created for the following vSphere components:
- Management
- Provisioning
- vMotion

You'll use these private networks to access vCenter, NSX-T Manager, vMotion, or for VM deployment.

## IP segments

IP addressing must be planned out before AVS deployment. At a minimum, the service ingests a /22 CIDR network address block you provide. The address space can be carved up into smaller network segments within NSX-T Manager. Those IP segments are used for vCenter, VMware HCX, NSX-T, and vMotion. AVS, your existing Azure environment, and your on-premises environment will all need to exchange routes to migrate VMs into Azure. The /22 CIDR network address block defined shouldn't overlap with network address blocks already configured on-premises or in Azure.

A VM IP segment will need to be built to create the first NSX segment in the AVS private cloud. The VM IP segment allows for deployment of VMs onto AVS. Optionally, network segments can be extended from an on-premises VMware environment to AVS. Networks on-premises need to connect to a vSphere Distributed Switch (vDS), as vSphere Standard Switches can't be extended.

## Example subnet breakdown

The following chart is an example of how to carve up the /22 CIDR network address block into different IP segments:

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

## ExpressRoute and routing requirements

There are two types of interconnectivity with AVS:
- **Basic interconnectivity** - AVS connects to an Azure virtual network using an ExpressRoute connection that deploys with the resource. The AVS provided ExpressRoute provides connectivity to and from the AVS private cloud to other Azure services like Azure Monitor, Azure Security Center, and so on.
- **Full interconnectivity** - this connectivity model extends the basic interconnectivity implementation to include interconnectivity between on-premises and Azure VMware Solution private clouds. This connection is configured through a customer provided ExpressRoute circuit. You can use an existing circuit or purchase a new one.

ExpressRoute Global Reach must be enabled to route traffic to and from on-premises to the AVS private cloud. The customer provided ExpressRoute circuit is not a part of the AVS private cloud deployment. All gateways involved with the deployment need to support 4-byte Autonomous System Number (ASN). An ASN is a unique identifier that is globally available and allows its autonomous system to exchange routing information with other systems. All routes between on-premises and Azure are advertised via the industry standard Border Gateway Protocol (BGP).

## ExpressRoute pre-requisites

There are a few pre-requisites that need to be met before configuring ExpressRouteGlobal Reach.

1. The AVS ExpressRoute needs established connectivity to and from Azure within the AVS private cloud.
2. A separate customer provided ExpressRoute circuit used to connect on-premises environments to Azure.
3. A /29 non-overlapping network address block for ExpressRoute Global Reach peering.
4. All gateways, including the ExpressRoute provider's service, need to support 4-byte Autonomous System Number (ASN). AVS uses 4-byte public ASNs for advertising network routes.

## Required network ports

If network infrastructure on-premises is restrictive, the following ports will need to be allowed:

| Source | Destination | Protocol | Port |
| :------------ | :------| :------ | :------ |
| AVS private cloud DNS server | On-premises DNS server | UDP | 53 |
| On-premises DNS server | AVS DNS server | UDP | 53 |
| On-premises network | AVS vCenter | TCP (HTTP/HTTPS) | 80, 443 |
| AVS private cloud management network | On-premises Active Directory | TCP | 389 |
| On-premises vCenter | AVS management network | TCP | 8000 |
| Web browser | Hybrid Cloud Manager (HCM) | TCP (HTTPS) | 9443 |
| Admin network | HCM | SSH | 22 |
| HCM | Cloud Gateway | TCP (HTTPS) | 8123, 9443 |
| Cloud Gateway | Layer 2 connectivity | TCP (HTTPS) | 443
| Cloud Gateway | ESXi Hosts | TCP | 80, 902 |
| Cloud Gateway (local) | Cloud Gateway (remote) | UDP | 4500, 500 |

## DHCP and DNS resolution considerations

VMs running in AVS require name resolution. Additionally, VMs may need DHCP services for lookup and IP address assignments. A VM on-premises can be configured or a VM in Azure to facilitate name resolution. The DHCP service built-in to NSX can be used or you can choose to use a local DHCP server in the AVS private cloud. Configuring DHCP in AVS won't require routing broadcasts of DHCP traffic over the WAN back to on-premises.

In the next unit, we'll go through the deployment of AVS. All steps will be outlined so you can deploy the service in your environment.
