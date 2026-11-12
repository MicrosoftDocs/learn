An ExpressRoute circuit is a logical connection between your on-premises infrastructure and Microsoft cloud services. It uses physical connectivity supplied through a provider or an ExpressRoute Direct port pair. A circuit can have Azure private peering, Microsoft peering, or both. Its configured bandwidth is shared across its peerings.

Each peering uses two BGP sessions for redundancy. The primary and secondary connections belong to the same circuit. They aren't separate circuits. Private connectivity doesn't by itself provide encryption or BGP session authentication.

## ExpressRoute prerequisites

You need:

- An active Azure subscription, permissions to create the required resources, and the Microsoft.Network resource provider registered in the subscription.
- A provider-based connectivity arrangement or ExpressRoute Direct physical connectivity at a supported peering location.
- A routing plan that includes address ranges, autonomous system numbers (ASNs), VLAN configuration, and responsibility for both BGP sessions.

For provider-based connectivity, create the ExpressRoute circuit in Azure and provide its service key to your provider so that the provider can provision the connection. Creating the Azure resource alone doesn't mean the provider connection is ready.

For ExpressRoute Direct, first enroll the subscription for AllowExpressRoutePorts, arrange the port pair and physical cross-connections, and create circuits on those ports. A carrier or colocation provider can still supply the physical access. Direct changes the connectivity and management model rather than eliminating all physical infrastructure requirements.

## Routing-interface addresses

For each IPv4 peering, reserve two /30 subnets, or a /29 that you divide into two /30 subnets. Use one /30 for the primary link and the other for the secondary link. In each /30, assign the first usable address to your router or the provider's peering router, and the second usable address to Microsoft's router. Keep these subnets separate from other connected address ranges.

This example shows the assignments for an illustrative private-peering range of 192.168.100.128/29. Use a range that doesn't overlap your actual networks.

| Link | Subnet | Customer or provider router | Microsoft router |
| --- | --- | --- | --- |
| Primary | 192.168.100.128/30 | 192.168.100.129 | 192.168.100.130 |
| Secondary | 192.168.100.132/30 | 192.168.100.133 | 192.168.100.134 |

Configure both BGP sessions. IPv6 uses different subnet sizes: two /126 subnets, or a /125 divided into two /126 subnets. The IPv4 example isn't an IPv6 addressing template.

## ExpressRoute peering types

- **Azure private peering**: Connects your on-premises network to routed addresses in Azure virtual networks. Address ranges must not overlap. These are usually private address ranges, although valid public address ranges can also be used within the private routing domain. This doesn't make a VM's separate public-IP endpoint accessible through private peering. Supported PaaS services can be reached through private endpoints in the connected VNet without the underlying service being deployed into that VNet.
- **Microsoft peering**: Connects to supported public endpoints of Microsoft services. For IPv4, use public peering-interface addresses and valid public source addresses. If clients use private source addresses, you or your provider must translate them to public addresses by using NAT. Microsoft must validate the right to use the advertised public address space. Use a separate public NAT address range rather than the BGP interface addresses, and plan route advertisements and return paths to avoid asymmetric routing.

For new Microsoft peerings, attach a route filter that selects the required service or regional BGP communities. Establishing BGP alone doesn't cause those routes to be advertised. Microsoft 365 access also requires the authorization and Premium prerequisites described in the previous unit.

:::image type="content" source="../images/expressroute-circuit-peerings.png" alt-text="Diagram that shows Microsoft peering to public service endpoints and Azure private peering to a virtual network.":::

## Connect a virtual network

In a conventional Azure virtual network deployment, private peering is only part of the connection. Deploy an ExpressRoute virtual network gateway and create a connection between that gateway and the circuit.

Reserve a dedicated subnet named GatewaySubnet for the gateway. New ExpressRoute gateway deployments require a /27 or larger subnet, such as /26. A /28 or smaller subnet isn't supported for new deployments. Some configurations require more address space. Don't deploy application resources into this subnet. An ExpressRoute gateway is a different gateway type from Azure VPN Gateway.

> [!IMPORTANT]
> Don't associate a network security group with GatewaySubnet or add a user-defined route for 0.0.0.0/0 to it. If you associate a route table with GatewaySubnet, keep BGP route propagation enabled. These restrictions are necessary for the gateway to operate correctly. Also check the subnet-size requirements for the gateway SKU and topology you select. For example, ErGwScale requires a /26 or larger gateway subnet.

The high-level provider workflow is to create the circuit, have the provider provision it, configure private peering, deploy the ExpressRoute gateway, and connect the gateway to the circuit. Design the routes and security rules so that the required VNet resources are reachable. Microsoft peering to public service endpoints doesn't require this VNet gateway connection.

As Adatum adds workload VNets, it can share an ExpressRoute gateway in a hub VNet instead of deploying a gateway in every VNet. Peer each spoke VNet with the hub. Enable gateway transit on the hub-to-spoke peering and use of the remote gateway on the spoke-to-hub peering. Ordinary VNet peering alone doesn't enable this on-premises connectivity.

A spoke using a remote gateway can't also have its own virtual network gateway, and it can use a remote gateway through only one peering. Use nonoverlapping address spaces, and confirm the routes and DNS resolution needed by the spoke workloads. Peering two spokes with the same hub doesn't, by itself, create transitive spoke-to-spoke connectivity. For direct communication between VNets, prefer VNet peering rather than sending that traffic through the ExpressRoute circuit.

ExpressRoute FastPath can bypass the gateway for eligible data traffic, but it still requires a supported ExpressRoute gateway for route exchange. FastPath isn't required for the basic Adatum scenario.

## ExpressRoute high availability and failover

A standard single-site circuit has two connections at one peering location. It provides connection redundancy but doesn't protect against loss of that location. ExpressRoute Metro splits one circuit's connections across two sites in the same metropolitan area. For greater geographic resilience, use circuits at different peering locations and consider diverse providers and physical paths.

> [!IMPORTANT]
> Microsoft recommends at least High resiliency for production workloads and Maximum resiliency for critical production workloads. High resiliency uses ExpressRoute Metro to place one circuit's connections at two sites in the same metropolitan area. Maximum resiliency uses circuits at different peering locations.
>
> Creation of new Standard-resiliency circuits is disabled for some location/provider combinations where High resiliency is available. Confirm the options with Microsoft and your provider before ordering connectivity. This selective creation restriction doesn't mean that existing single-site circuits have all become unsupported.
>
> These resiliency choices aren't the Local, Standard, and Premium circuit SKUs. Choose geographic reach, capacity, and resiliency separately.

Where supported, use a zone-redundant ExpressRoute gateway to protect against a gateway availability-zone failure. Peering-location diversity doesn't replicate applications or make a failed Azure workload region available. Plan regional application recovery separately.

Availability SLA terms depend on the qualifying site configuration and current Microsoft agreement. They don't guarantee uninterrupted application access. Maintain redundancy in the customer and provider networks as well as in Azure.

Microsoft operates the two connections of an ExpressRoute circuit in active-active mode and recommends using both paths during normal operation. Load-balance traffic by flow, not by repeatedly moving individual packets from the same flow between next hops. This is especially important for stateful private-endpoint connectivity.

Keep both paths' route advertisements and failover behavior working. During maintenance, Microsoft can use AS-path prepending to move traffic to the healthy connection, so your routing policy must allow that change. Size the normal workload to fit within one connection when the other is unavailable. Active-active operation doesn't make the combined capacity guaranteed sustained bandwidth or eliminate application reconnection.

Redundant connections don't make failover instantaneous. When BGP timers are the only way to detect a failed path, detection can take up to three minutes with the typical hold timer. Bidirectional Forwarding Detection (BFD) can detect link failures faster. For new peerings, Microsoft configures BFD on its edge routers. You or your provider must also configure BFD on both primary and secondary peering devices to use it.

Faster detection doesn't guarantee subsecond application recovery. Routes still need to converge, and applications might need to reconnect or retry. Include those delays when assessing whether failover meets Adatum's requirements.

Confirm provider provisioning, both BGP sessions, learned routes, DNS resolution, and application connectivity. Use Azure Monitor and ExpressRoute Network Insights to monitor availability, throughput, packet drops, and gateway health. A working BGP session alone doesn't prove that an application can connect.
