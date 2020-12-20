<!- Estimated unit duration 6 minutes --> 

Azure Virtual WAN is a unified framework for networking, security, and routing. Migrate from a typical hub and spoke topology to an updated hub an spoke architecture using Virtual WAN and Virtual WAN Hubs in Azure regions. These hubs can be connected to your branches, virtual networks, and remote users with scale and enhanced performance.

## What is a hub and spoke topology?

This networking topology, often refereed to as a star topology or hub and spoke,often used as a classic site to site WAN service. Azure supports two types of Hub and spoke deployments. One is a VNet hub that functions as the focal point for connectivity to a on-premises network. The spokes are VNets that peer with the Hub. VNet peering is the interconnecting of VNets to each other. For connectivity purposes, the virtual networks appear as one. The Hub and spokes are connected using VPN gateways or ExpressRoute. 

The second design is the Azure Virtual WAN or Virtual WAN, the focus of this module.

## Overview of Azure Virtual WAN

Virtual WAN is a Microsoft managed Azure based networking service. Microsoft hosts and manages all of the components that make up this service. Given this, it is a unified framework that supports:

- **Connectivity** - enables any-to-any connectivity to workloads distributed globally in VNets. It connects working at home and mobile users typically using Point-to-Site VPN, branch offices using Site-to-Site VPN, and main campuses and data centers using ExpressRoute for private connections.
- **Global transit architecture** - Azure regions function as networking hubs connected in full mesh

- Azure Virtual WAN architecture as a hub and spoke architecture that is easy to deploy and use, while being highly scalable
- Software-defined WAN (SD-WAN)



## Overview of Azure Virtual WAN Hubs

An Azure Virtual WAN Hub can be deployed in any Azure region. Each hub can be connected to using standard Azure connection services. The hubs are connected in a full mesh network using the Azure backbone.
- Basic and standard virtual WANs
- Connectivity types in the Azure Virtual WAN Hubs
- 20 Gbps of S2S VPN + 20 Gbps ER + 20 Gbps user VPN in one Hub
