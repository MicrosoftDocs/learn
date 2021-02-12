
Azure Virtual WAN is a unified framework for networking, security, and routing.

You’re investigating how Contoso could migrate from a typical hub and spoke network. Azure Virtual WAN and Virtual WAN hubs, used across Azure regions, seems to be a promising solution.

The Virtual WAN hubs can be connected to your branches, virtual networks, and remote users. They provide scale and enhanced performance over the current Contoso network.

## What is a hub and spoke topology?

This networking topology, referred to as a star topology or hub and spoke, is often used as a classic site-to-site WAN service.

Contoso is considering using Azure to extend their WAN geographically. Azure's network spans the globe with many data centers interconnected using the Azure global high-speed backbone.

Initially, as services are moved to Azure, a virtual network is created to connect with the virtual machines (VMs). An Azure VPN gateway is connected to the on-premises networks.

When a virtual WAN is created using the Azure portal, a virtual hub, virtual network, and gateways (optional) are created as its components.

This virtual hub functions as the focal point for connectivity to an on-premises network and other virtual networks. The spokes are virtual networks that peer with the hub.

Regional and global virtual network peering is supported. Virtual network peering is the interconnecting of virtual networks to each other. For connectivity purposes, the virtual networks appear as one. The hub and spokes are connected using VPN gateways or ExpressRoute.

This peering allows many locations to be connected. As more locations and WANs are added, the complexity of the network grows. Keeping track of all network connections, customer-managed virtual hubs, and peering processes can become difficult.

Azure Virtual WAN addresses this issue by providing a single interface to manage all these points. High-performance, software-defined Virtual WAN hubs are also added.

## Azure Virtual WAN

Azure Virtual WAN is a hub and spoke architecture. The Virtual WAN is a Microsoft-managed, Azure-based networking service.

Microsoft hosts and manages all the components that make up this service. It is easy to deploy and use, while offering the following services:

- Enables any-to-any connectivity to workloads distributed globally in virtual networks.
- Connects:
  - Working at home and mobile users using point-to-site VPN
  - Branch offices using site-to-site VPN
  - Main campuses and data centers using ExpressRoute for private connections

Virtual WAN hubs enabled in Azure regions function as networking hubs. These hubs are connected in full mesh integration. This integration supports any-to-any connectivity access to workloads that are globally distributed.

To get started with a virtual WAN:

- Create a single virtual WAN in an Azure region that currently supports many spokes.
- Connect the regional spokes to the hub, then connect the other regions to the hub. The hubs become the connection points for regional connectivity.

## Azure Virtual WAN hubs

The classic hardware hub allows all network devices plugged into it to communicate directly with each other. A Virtual WAN hub is a sophisticated software-defined hub.

An Azure Virtual WAN hub can be deployed in any Azure region, but only one per region, per subscription. Each hub can be connected to use standard Azure connection services.

For example, a branch office in an Azure region in the UK can connect to a region in the USA. They connect using hub-to-hub connectivity through the Azure global network.

In a single virtual WAN that spans multiple regions, with multiple hubs deployed, the hubs are automatically interconnected by hub-to-hub links. These interconnections enable the global connectivity to branches and virtual networks.

The following image depicts an Azure Virtual WAN deployment with two Virtual hubs in different Azure regions and the network traffic flow.

:::image type="content" source="../media/6-united-framework-for-networking.png" alt-text="Azure Virtual WAN provides any-to-any connectivity, custom routing, and security." border="false":::

## Secure virtual hub

To convert the virtual hub to a secure virtual hub, use Azure Firewall Manager.

Firewall rules, created by the Firewall Manager, allow for the creation of security and routing policies for network traffic. Data flowing from the internet, private IP addresses, or Azure platform services can be filtered.

>[!NOTE]
> User-defined routes are not needed to route traffic through the firewall.

The secure virtual hub supports the provisioning of two security providers:

- Azure Firewall for private traffic
- Third-party security providers that are integrated with Firewall Manager

Virtual hubs or secure virtual hubs are the regional connection points for a virtual WAN. These hubs support multiple service endpoints. The endpoints provide connectivity between networks and services. They're the core of networking for each region.
