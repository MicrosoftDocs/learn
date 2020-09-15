Enterprise-scale recommends two approaches for network topologies in Azure. A network topology based on Azure Virtual WAN or the traditional hub and spoke model. 

## Azure Virtual WAN

### Considerations

Azure Virtual WAN is a Microsoft-managed solution where global transit connectivity is provided by default. Virtual WAN hubs eliminate the need to manually configure network connectivity. Virtual WAN also offers communications between on premises locations using the Microsoft Network and ExpressRoute and VPN. Virtual WAN greatly simplifies end-to-end network connectivity in Azure and cross-premises by creating a hub-and-spoke network architecture. The architecture spans multiple Azure regions and on-premises locations (any-to-any connectivity) out of the box. A design consideration for any networking in Azure keeps in mind the principle that Azure to Azure traffic should always stay in Azure.

![Diagram that illustrates a Virtual WAN network topology.](../media/virtual-wan-top.png)

The diagram above shows fully deployed Enterprise Scale landing zone. The connectivity subscription contains Virtual WAN and the Landing Zone subscription has specific applications and their components.

### Recommendations

Virtual WAN is recommended for new large or global network deployments in Azure where you need global transit connectivity across Azure regions and on-premises locations. That way, you don't have to manually set up transitive routing for Azure networking. 

Deploy a VWAN hub per Azure region and connect them to large offices or data centers with ExpressRoute. Use VPN for smaller locations and point-to-site VPN for remote users. Azure Firewalls can be deployed into the VWAN hub, but third party firewalls have to be deployed into a spoke VNet. There's no need to build a transit network on top of VWAN. VWAN is the transit network. Azure Virtual WAN is limited to two thousand virtual machines vwan hub.

## Hub and spoke

### Considerations

Use the hub and spoke model if there are no requirements for branch to branch communications, there is no need for SD-WAN integrated solutions, when highly granular routing control is required or when over 2000 virtual machines will be deployed per hub.

When multiple ExpressRoute circuits are connected to the same VNet, connection weights or BGP techniques must be used to ensure an optimal path for traffic between on-premises and Azure. If connection weights are used, BGP AS prepending is ignored. 

The diagram below shows a basic hub and spoke topology, where ExpressRoute is deployed and connected to the hub. Application landing zones are deployed in vnets and connected to the hub with vnet peering.

![Diagram that illustrates a hub-and-spoke network topology.](../media/hub-and-spoke-topology.png)

## Recommendations

Each Azure region should have a hub, firewalls and ExpressRoute/VPN gateways should be deployed in that hub so that all spoke virtual networks can route through the hub or use shared services like DNS deployed there.  Use multiple Expressroute circuits for a few reasons. First for resiliency, in different peering locations and different providers if possible. Next, for dedicated bandwidth to projects or to production to avoid 'noisy neighbor problems'.
