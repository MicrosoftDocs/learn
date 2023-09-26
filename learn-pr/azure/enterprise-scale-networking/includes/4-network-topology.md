For enterprise-scale, we recommend two approaches for network topologies in Azure: a network topology based on Azure Virtual WAN, or the traditional hub-and-spoke model. 

## Azure Virtual WAN

### Considerations

Azure Virtual WAN is a Microsoft-managed solution that provides global transit connectivity by default. Virtual WAN hubs eliminate the need to manually configure network connectivity. Virtual WAN also offers communication between on-premises locations by using the Microsoft network, Azure ExpressRoute, and VPN.

Virtual WAN simplifies end-to-end network connectivity in Azure and cross-premises by creating a hub-and-spoke network architecture. The architecture spans multiple Azure regions and on-premises locations (any-to-any connectivity) out of the box. As design consideration for any networking in Azure, keep in mind the principle that Azure-to-Azure traffic should always stay in Azure.

:::image type="content" source="../media/4-virtual-wan-topology.png" alt-text="Diagram that illustrates a Virtual WAN network topology." lightbox="../media/4-virtual-wan-topology-large.png":::

The preceding diagram shows a fully deployed Azure landing zone. The connectivity subscription contains Virtual WAN, and the landing zone subscription has specific applications and their components.

### Recommendations

We recommend Virtual WAN for new large or global network deployments in Azure where you need global transit connectivity across Azure regions and on-premises locations. That way, you don't have to manually set up transitive routing for Azure networking.

Deploy a Virtual WAN hub per Azure region and connect the hubs to large offices or datacenters by using ExpressRoute. Use VPN for smaller locations and point-to-site VPN for remote users. You can deploy Azure Firewall in a Virtual WAN hub, but partner firewalls have to be deployed in a spoke virtual network.

There's no need to build a transit network on top of Virtual WAN. Virtual WAN is the transit network. Virtual WAN is limited to 2,000 virtual machines per hub.

## Hub and spoke

### Considerations

Use the hub-and-spoke model if:

- You have no requirements for branch-to-branch communications.
- You don't need SD-WAN integrated solutions.
- You need highly granular routing control.
- You need to deploy more than 2,000 virtual machines per hub.

When multiple ExpressRoute circuits are connected to the same virtual network, you must use connection weights or Border Gateway Protocol (BGP) techniques to ensure an optimal path for traffic between on-premises and Azure. If you use connection weights, BGP AS prepending is ignored.

The following diagram shows a basic hub-and-spoke topology, where ExpressRoute is deployed and connected to the hub. Application landing zones are deployed in virtual networks and connected to the hub with virtual network peering.

:::image type="content" source="../media/4-hub-and-spoke-topology.png" alt-text="Diagram that illustrates a hub-and-spoke network topology." lightbox="../media/4-hub-and-spoke-topology-large.png":::

### Recommendations

Each Azure region should have a hub and firewalls. ExpressRoute or VPN gateways should be deployed in that hub so that all spoke virtual networks can route through the hub or use shared services like DNS deployed there.  

Use multiple ExpressRoute circuits for these reasons:

- For resiliency. If possible, use them in different peering locations and different providers.
- For dedicated bandwidth to projects or to production, to avoid "noisy neighbor" problems.