<!- Estimated unit duration 6 minutes -->

Azure Virtual WAN is a unified framework for networking, security, and routing. You’re investigating how Contoso could migrate from a typical hub and spoke topology to an updated hub and spoke architecture using Virtual WAN and Virtual WAN hubs in Azure regions. These hubs can be connected to your branches, virtual networks, and remote users with scale and enhanced performance.

## What is a hub and spoke topology?

This networking topology, referred to as a star topology or hub and spoke, is often used as a classic site-to-site WAN service. Consider using Azure as an efficient and cost effect model to extend your WAN geographically. Azure's network spans the globe with many data centers interconnected using the Azure global high-speed backbone.

Initially as services are moved to Azure and connected to on-premises networks, a virtual network (VNet) is created to connect with the virtual machines (VMs) and the Azure VPN gateway. When a virtual WAN is created using the Azure portal a virtual hub VNet and gateways (optional) are created as its components.
This virtual hub functions as the focal point for connectivity to an on-premises network, and other VNets. The spokes are VNets that peer with the hub. VNet peering is the interconnecting of VNets to each other. For connectivity purposes, the virtual networks appear as one. The hub and spokes are connected using VPN gateways or ExpressRoute.

Regional and global VNet peering is supported which allows many locations to be connected. In many situations, the network topology can grow over time to be very complex as additional locations and WANs are added.

Keeping track of all network connections, **customer managed** virtual hubs, and peering processes can become difficult. Azure Virtual WAN addresses this issue by providing a single interface to manage all these points in addition to adding software defined Virtual WAN hubs.

## Azure Virtual WAN

Virtual WAN is a **Microsoft managed** Azure-based networking service. Microsoft hosts and manages all the components that make up this service. Azure Virtual WAN architecture is a hub and spoke architecture that is easy to deploy and use, while offering high scalability.

This unified framework:
- Enables any-to-any connectivity to workloads distributed globally in VNets. 
- Connects working at home and mobile users typically using Point-to-Site VPN, branch offices using Site-to-Site VPN, and main campuses and data centers using ExpressRoute for private connections. 

Virtual WAN hubs enabled in Azure regions function as networking hubs connected in full mesh integration for any-to-any connectivity access to workloads that are globally distributed.

To get started with a virtual WAN:
- Create a single virtual WAN in an Azure region that currently supports many spokes. 
- Connect the regional spokes to the hub, then connect the other regions to the hub. The hubs become the connection points for regional connectivity.

## Azure Virtual WAN hubs

The classic hardware hub allows all network devices plugged into it to communicate directly with each other. A Virtual WAN hub is a sophisticated software defined hub.

An Azure Virtual WAN hub can be deployed in any Azure region, but only one per region, per subscription. Each hub can be connected to use standard Azure connection services. The hubs are connected in a full mesh network using the Azure backbone. For example, traffic from a branch office in an Azure region in the UK can reach another branch or VNet services in a region in the USA using hub-to-hub connectivity through the Azure global network.

In a single virtual WAN that spans multiple regions, with multiple hubs deployed, the hubs are automatically interconnected by hub-to-hub links. These interconnections enable the global connectivity to branches and VNets.

## Secure virtual hub

To convert the virtual hub to a secure virtual hub use Azure Firewall Manager. This allows for the creation of security and routing policies to secure network traffic coming from the internet, private IP addresses, or Azure platform services.

>[!NOTE]
> User defined routes are not needed to route traffic through the firewall.

The secure virtual hub supports the provisioning of two security providers: Azure Firewall for private traffic, and third-party security providers that are integrated with Firewall Manager.

Virtual hubs or secure virtual hubs are the regional connection points for a virtual WAN. They support multiple service endpoints that provide for connectivity between networks and services. They're the core of networking for each region.
