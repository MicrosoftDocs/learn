<!- Estimated unit duration 6 minutes -->

Azure Virtual WAN is a unified framework for networking, security, and routing. Migrate from a typical hub and spoke topology to an updated hub an spoke architecture using Virtual WAN and Virtual WAN Hubs in Azure regions. These hubs can be connected to your branches, virtual networks, and remote users with scale and enhanced performance.

## What is a hub and spoke topology?

This networking topology, refereed to as a star topology or hub and spoke, is often used as a classic site to site WAN service. A efficient and cost effect model to extend your WAN geographically would be through Azure. Azure's network expands the globe with many data centers interconnected using Azure global high speed backbone.

Initially as services are moved to Azure and connected to on-premises networks a virtual
network (VNet) is created to host the VMs and the Windows Azure gateway. This gateway  is also called VNet hub.

This VNet hub functions as the focal point for connectivity to a on-premises network, and other VNets. The spokes are VNets that peer with the Hub. VNet peering is the interconnecting of VNets to each other. For connectivity purposes, the virtual networks appear as one. The Hub and spokes are connected using VPN gateways or ExpressRoute.

 Regional and global VNet peering is supported which allows many locations to be connected. In many situations, the network topology can grow over time to be very complex as additional locations and WANs are added.

Keeping track of all network connections, **customer managed** VNet hubs, and peering processes can become difficult. Azure Virtual WAN addresses this issue by providing a single interface to manage all these points in addition to adding software defined Virtual WAN hubs.

## Overview of Azure Virtual WAN

Virtual WAN is a **Microsoft managed** Azure based networking service. Microsoft hosts and manages all of the components that make up this service. Azure Virtual WAN architecture is a hub and spoke architecture that is easy to deploy and use, while being highly scalable.

This unified framework enables any-to-any connectivity to workloads distributed globally in VNets. It connects working at home and mobile users typically using Point-to-Site VPN, branch offices using Site-to-Site VPN, and main campuses and data centers using ExpressRoute for private connections. Virtual WAN hubs enabled in a Azure regions function as networking hubs connected in full mesh integration for any-to-any connectivity access to workloads that are globally distributed.

## Virtual WAN options

Azure Virtual WAN supports two WAN types, Basic and Standard. A Basic WAN creates only Basic hubs, and Standard WAN creates only Standard hubs. The difference between Basic and Standard is detailed below.

| **Virtual WAN type** | **Hub type** | **Available configurations**                                 |
| :------------------- | :----------- | :----------------------------------------------------------- |
| Basic                | Basic        | Site-to-site VPN only                                        |
| Standard             | Standard     | ExpressRoute, User VPN (P2S), VPN (site-to-site), Inter-hub and VNet-to-VNet transiting through the virtual hub |

>[!NOTE]
> An Basic Virtual WAN can be upgraded to a Standard Virtual WAN. A Standard Virtual WAN cannot be downgraded to a Basic Virtual WAN

To get started with a virtual WAN, create a single Virtual WAN in a Azure region that current supports many spokes. Connect the regional spokes to the hub, then connect the other regions to the hub. The hubs become the connection points for regional connectivity.

## Overview of Azure Virtual WAN Hubs

The classic hardware hub allows all network devices plugged into it to communicate directly with each other. A Virtual WAN Hub is a sophisticated software defined hub.

An Azure Virtual WAN Hub can be deployed in any Azure region, but only one per region, per subscription. Each hub can be connected to using standard Azure connection services. The hubs are connected in a full mesh network using the Azure backbone. For example, traffic from a branch office in a Azure region in the UK, can reach another branch or VNet services in a region in the USA, using hub-to-hub connectivity through the Azure Global Network.

In a single virtual WAN that spans multiple regions, with multiple hubs deployed, the hubs are automatically interconnected by hub-to-hub links. These interconnections enable the global connectivity to branches and VNets.

## Secure Virtual Hub

To convert the virtual hub to a secure virtual hub use Azure Firewall Manager. This allows for the creation of security and routing policies to secure network traffic coming from the Internet, private IP addresses, or Azure platform services.

>[!NOTE]
> User defined routes are not needed to route traffic through the firewall.

The Secure Virtual hub supports the provisioning of two security providers. The aforementioned Azure Firewall for private traffic, and third-party security providers that are integrated with Firewall Manager.

Virtual Hubs or Secure Virtual hubs are the regional connection points for a Virtual WAN. They support multiple service endpoints
that provide for connectivity between networks and services. They're the core of networking for each region.
