Azure VMware Solution provides a private cloud environment you can access from both on-premises and Azure-based environments or resources. The next step in Azure VMware Solution deployment involves a plan for network topology.

This walkthrough uses a standard, single-zone Generation 1 private cloud and its Microsoft-managed ExpressRoute circuit. Generation 2 connects AV64 hosts directly to a hosting Azure virtual network and uses different deployment and connectivity steps. Both generations require a management /22, but their management subnet layouts differ. Don't apply this unit's Generation 1 subnet table, circuit connection, or Global Reach procedure to a Generation 2 private cloud.

The Generation 1 environment needs to exchange traffic with Azure services and on-premises VMware environments. You connect the service-provided ExpressRoute circuit to your Azure virtual network through an ExpressRoute gateway. This walkthrough uses a separate, customer-provided ExpressRoute circuit and Global Reach for on-premises connectivity. Plan the required IP address ranges, routes, and firewall rules before deployment. Azure creates private networks for the following vSphere components:

- Management
- Provisioning
- VMware vMotion

You use these private networks to access vCenter Server, NSX Manager, and vMotion.

## IP segments

Plan IP addressing before deploying the private cloud. Reserve a non-overlapping /22 CIDR block from RFC1918 private space (`10.0.0.0/8`, `172.16.0.0/12`, or `192.168.0.0/16`), excluding `172.17.0.0/16`. The private cloud's management CIDR can't be changed after deployment.

Azure automatically divides the management block into smaller networks for components such as vCenter Server, VMware HCX, NSX, and VMware vMotion. Check the entire address plan against connected Azure virtual networks, on-premises networks, other private clouds, and planned expansion before submitting the deployment. These environments need to exchange routes, so their address ranges can't overlap.

Reserve separate address space outside the management /22 for workload segments, where you'll deploy virtual machines (VMs). Don't use the NSX-reserved ranges `169.254.0.0/24`, `169.254.2.0/23`, or `100.64.0.0/16` as workload pools. If you plan to enable Azure Arc, also check the Arc resource bridge's reserved-address constraints before committing to the permanent address plan.

Check route-advertisement eligibility as well as address overlap. For this ExpressRoute-connected design, don't advertise the RFC6598 range `100.64.0.0/10` or any of its subnets to Azure VMware Solution. This restriction is broader than the NSX-internal `100.64.0.0/16` reservation. Use supported RFC1918 or customer-owned public prefixes for route advertisements; the management /22 must still use RFC1918 space. Avoid unsupported bogon aggregates, such as `0.0.0.0/1` and `128.0.0.0/1`. Advertising a supported default route doesn't replace the specific return routes required for private management access.

For Generation 1 AV64 expansion, reserve an additional /23 or three /25 management blocks according to the expansion requirements. This space doesn't replace the initial management /22. Generation 2 uses its own hosting-VNet layout, including additional HCX management and uplink networks if HCX is deployed.

Create an NSX workload segment to host the first VMs. Optionally, you can extend an on-premises network with VMware HCX Layer 2 Network Extension. A vSphere Distributed Switch (vDS) is a supported source; a vSphere Standard Switch can't be extended. Confirm compatibility for the selected source platform.

Network connectivity alone doesn't complete HCX setup. Before migrating with HCX, install the Azure VMware Solution HCX add-on, deploy the supported on-premises Connector, and confirm source-platform compatibility. Configure site pairing, network and compute profiles, and a service mesh. Validate appliance and tunnel health, required ports, and end-to-end MTU for the selected connection. Full HCX configuration and migration are outside this walkthrough.

## Example subnet breakdown

The following table shows how Azure divides the example Generation 1 management block `10.5.0.0/22`. Azure provisions these ranges; don't create workload segments inside them.

| Network usage | Subnet | Example |
| --- | --- | --- |
| Private cloud management | /26 | 10.5.0.0/26 |
| HCX migrations | /26 | 10.5.0.64/26 |
| Global Reach reserved | /26 | 10.5.0.128/26 |
| NSX DNS service | /32 | 10.5.0.192/32 |
| Reserved | /32 | 10.5.0.193/32 |
| Reserved | /32 | 10.5.0.194/32 |
| Reserved | /32 | 10.5.0.195/32 |
| Reserved | /30 | 10.5.0.196/30 |
| Reserved | /29 | 10.5.0.200/29 |
| Reserved | /28 | 10.5.0.208/28 |
| ExpressRoute peering | /27 | 10.5.0.224/27 |
| ESXi management | /25 | 10.5.1.0/25 |
| vMotion network | /25 | 10.5.1.128/25 |
| Replication network (not applicable to AV64 nodes) | /25 | 10.5.2.0/25 |
| vSAN | /25 | 10.5.2.128/25 |
| HCX uplink | /26 | 10.5.3.0/26 |
| Reserved | Three /26 blocks | 10.5.3.64/26, 10.5.3.128/26, 10.5.3.192/26 |

Use the actual service addresses shown for your private cloud when configuring DNS or firewalls, not the illustrative addresses in this table.

## Azure VMware Solution network connectivity

After deploying Azure VMware Solution, establishing network connectivity becomes the next step for a successful deployment.

The Azure VMware Solution private cloud runs on dedicated bare-metal servers assigned to a single customer. In Generation 1, the service-provided ExpressRoute circuit connects the private cloud to your Azure virtual network through an ExpressRoute gateway. For on-premises connectivity, you can connect that circuit to your customer-provided circuit with ExpressRoute Global Reach.

## ExpressRoute and routing requirements

This Generation 1 walkthrough covers two connectivity scopes:

- **Basic Azure-only interconnectivity**: Connect the service-provided ExpressRoute circuit to an ExpressRoute gateway in your Azure virtual network. The circuit is provided with the private cloud, but you still need to configure the gateway connection and access to the Azure resources you plan to use.
- **Full on-premises to private cloud interconnectivity**: This connectivity model extends the basic interconnectivity implementation to include interconnectivity between on-premises and Azure VMware Solution private clouds. You can configure this connection via a customer-provided ExpressRoute circuit, among other methods. You can use an existing circuit or purchase a new one.

ExpressRoute Global Reach is the hybrid connection used in this walkthrough. If it's unavailable in your region or doesn't meet your network or security requirements, evaluate a supported transit or IPsec VPN design separately. Connecting two circuits to the same virtual network gateway doesn't provide circuit-to-circuit transit.

The customer-provided ExpressRoute circuit isn't a part of the Azure VMware Solution private cloud deployment.

Size the ExpressRoute gateway for expected traffic, learned routes, and required features. Circuit bandwidth alone doesn't determine end-to-end throughput. Consider a FastPath-capable gateway when the workload and supported topology require it.

Size the direct Global Reach migration path separately from the Azure VNet connection. Global Reach throughput is capped by the lower-bandwidth connected ExpressRoute circuit, and existing premises-to-Azure traffic shares the customer circuit's bandwidth. Plan capacity for migration and ongoing application traffic. Increasing the Azure VNet gateway SKU doesn't increase bandwidth on the direct circuit-to-circuit Global Reach path. These bandwidth limits aren't a guarantee of application throughput.

Before enabling Global Reach, check route-prefix counts in both directions. Azure private peering accepts up to 4,000 IPv4 prefixes advertised by the customer to Microsoft on a Standard circuit, or 10,000 on a Premium circuit. Exceeding that limit drops the BGP session. Separately, Global Reach adds routes received by your on-premises network. Confirm that customer and provider receive-side maximum-prefix settings accommodate the combined Azure VNet, AVS, and other connected-site routes, with capacity for planned growth. Coordinate any required changes with the responsible network owner rather than disabling prefix-limit safeguards. Also check the selected Azure VNet gateway's learned-route capacity and VNet-prefix advertisement limit. These are separate prefix-count limits, not bandwidth limits or CIDR block sizes.

> [!IMPORTANT]
> A private ExpressRoute connection isn't an encryption guarantee. ExpressRoute traffic isn't encrypted by default, and creating the Global Reach connection in this walkthrough doesn't add an IPsec tunnel for all routed workload traffic. Identify which management, application, and migration flows must be encrypted, and use approved application encryption or a separately designed, supported encrypted network path. Continue to use HTTPS for management access. Protection provided by HCX service-mesh tunnels doesn't extend to unrelated workload traffic using the same circuits.

If a separate encrypted network path is required, validate its routing, capacity, and operational requirements before migration. Don't treat MACsec as an option on an ordinary provider circuit or as a setting you can change on the Microsoft-managed AVS circuit. ExpressRoute Direct MACsec protects its physical link, not every end-to-end application path.

For a normal new gateway deployment, reserve a dedicated `GatewaySubnet` of /27 or larger. Larger configurations can require more space. Don't deploy workload VMs or attach a network security group (NSG) to this subnet. Keep BGP route propagation enabled, and don't apply a `0.0.0.0/0` user-defined route to `GatewaySubnet`.

Azure VMware Solution management appliances don't use a customer-advertised default route as their return path to private on-premises management networks. Advertise the actual on-premises prefixes or appropriate RFC1918 summaries. Confirm both outward and return routes before troubleshooting management HTTPS access.

## Prerequisites for ExpressRoute Global Reach

There are a few prerequisites before you configure ExpressRoute Global Reach.

- A separate, provisioned customer ExpressRoute circuit with working Azure private peering is required. Its tier must support Global Reach. ExpressRoute Local doesn't support Global Reach.
- Confirm Global Reach availability for the selected peering locations and topology. Connections across geopolitical regions require Premium circuits at both endpoints. Validate the customer circuit's tier and confirm AVS-side eligibility with Microsoft before proceeding with such a connection. Don't attempt to modify the Microsoft-managed AVS circuit.
- All gateways, including the ExpressRoute provider's service, must support 4-byte Autonomous System Numbers (ASNs). Azure VMware Solution uses 4-byte public ASNs for advertising network routes.
- Circuit route-advertisement limits and customer/provider receive-side maximum-prefix settings have been checked for the routes expected after Global Reach is enabled, with capacity for planned growth.

Check ASN assignments as well as four-byte ASN capability. Azure VMware Solution reserves `64513`, `64600-64940`, `65000-65412`, `398656-398670`, and `400572-400581` for its infrastructure. The Tier-1 and Tier-2 reservations are included within these ranges. Avoid assigning these values to customer networks. Coordinate any conflict with the responsible network owner, provider, and Microsoft Support before connecting. Don't change AVS-managed or provider-managed ASNs as part of this walkthrough.

## Required network ports

Allow only the flows required for the features you're deploying. Basic management access, optional directory integration, and HCX have different requirements. Apply least-privilege rules between the actual source and destination networks, and check the port matrix for the installed HCX version.

The following table summarizes common flows. It isn't an exhaustive allow-list for every HCX feature.

| Source | Destination | Protocol/port | Purpose and scope |
| --- | --- | --- | --- |
| Private cloud DNS forwarder | On-premises DNS servers | UDP and TCP 53 | Forward private DNS queries; permit TCP fallback where required. |
| On-premises DNS servers | Private cloud DNS service | UDP and TCP 53 | Only when on-premises resolvers forward queries to this service. |
| Authorized management network | Private cloud vCenter Server and NSX Manager | TCP 443 | HTTPS management access, including from the Azure jumpbox. |
| Authorized management network | Private cloud vCenter Server | TCP 80 | Optional HTTP-to-HTTPS redirection; use HTTPS directly where possible. |
| Private cloud management network | On-premises Active Directory | TCP 389 or 636 | Optional directory integration; prefer encrypted LDAP on 636. |
| Private cloud management network | On-premises Active Directory Global Catalog | TCP 3268 or 3269 | Optional directory integration; prefer encrypted access on 3269. |
| Authorized HCX administration network | HCX Cloud Manager | TCP 9443 | HCX appliance management when HCX is deployed. |
| Authorized HCX administration network | HCX Cloud Manager | TCP 22 | Only when authorized HCX troubleshooting requires SSH. |
| On-premises HCX Connector | Azure VMware Solution HCX Cloud Manager | TCP 443 | HCX site pairing. |
| HCX Manager | Interconnect (HCX-IX) | TCP 8123 | HCX bulk migration control when that migration method is used. |
| HCX Manager | Local HCX-IX and Network Extension (HCX-NE) appliances | TCP 9443 | HCX appliance management instructions. |
| HCX-IX | L2C | TCP 443 | Management instructions if the selected HCX topology uses L2C on the same path as HCX-IX; confirm the installed version's matrix. |
| HCX Manager and HCX-IX | ESXi hosts | TCP 80, 443, 902 | HCX management and OVF deployment. |
| Source HCX-IX/HCX-NE uplink appliances | Peer HCX-IX/HCX-NE uplink appliances | UDP 4500 | Bidirectional HCX service-mesh tunnel traffic between sites. |
| HCX-IX/HCX-NE appliances | Remote HCX-IX/HCX-NE appliances | TCP and UDP 5201 | Service-mesh uplink performance diagnostics. |
| Source ESXi vMotion VMkernel interfaces | Destination ESXi vMotion VMkernel interfaces | TCP 8000 | Only for a supported direct cross-vCenter vMotion path. These aren't the vCenter Server application endpoints. Validate source and destination compatibility and the selected migration method before permitting the flow. |

Direct cross-vCenter vMotion and tunneled HCX migration don't use the same network path. For HCX, configure the local appliance-to-ESXi flows, network profiles, and intersite tunnel flows required by the selected supported migration method. The direct-vMotion row isn't a universal cross-site HCX firewall rule. Use the actual vMotion VMkernel addresses where that direct path is required, not the vCenter Server addresses or an assumed management subnet.

For the current HCX Connector workflow, obtain the appropriate OVA from the Azure VMware Solution vSAN datastore's `AVS_Official_HCX_Connector_Binaries` folder. If the folder or required binary is missing, open a support request. Follow the supported installation and activation procedure for that version. Removal of older activation and update endpoint dependencies doesn't mean that all HCX operations need no outbound access.

## DHCP and DNS resolution considerations

VMs running in Azure VMware Solution need name resolution and either DHCP or static IP configuration. You can use reachable on-premises or Azure-hosted DNS servers, with conditional forwarding for private domains where required. DNS forwarders must be able to reach their configured upstream resolvers, including when a default route or restricted egress is used.

For new routed segments, you can use the DHCP service built into NSX or a local DHCP server in the private cloud without forwarding DHCP requests over the WAN. An HCX L2-extended network that keeps its on-premises DHCP server has different segment-security requirements; the NSX configuration unit explains that exception.

In the next unit, we'll go through the deployment of Azure VMware Solution. We outline all the steps so you can deploy the service in your environment.
