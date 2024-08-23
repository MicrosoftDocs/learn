By using virtual networks, network security groups, virtual network peering, and Azure ExpressRoute, you can create different network topologies hosted in the cloud.

Your company is planning a migration of all your on-premises resources to Azure. Your central datacenter is currently located at your headquarters. Prior to full migration, you've been asked to move some of your satellite offices into the cloud, while also maintaining the connectivity to your headquarters. This results in a hybrid network scenario. The ultimate goal for the migration is to host all your computing resources on Azure.

In this unit, you explore the following parts of this model:

- The hub-spoke architecture
- The network topology
- The components needed in Azure
- How to plan the implementing infrastructure

## Hub-spoke architecture foundations

![Diagram of a hub-spoke architecture.](../media/2-hub-and-spoke.png)

A hub and spoke topology consists of a centralized architecture (a hub) connecting to multiple points (spokes). When drawn, it looks similar to a wheel, with a hub at the center and spokes connected to it. This model in Azure organizes your network infrastructure into multiple connected virtual networks. This architecture provides an efficient way to manage common communication, security requirements, and potential subscription limitations.

Implementing a hub and spoke architecture can have the following benefits:

- A centrally managed connection to your on-premises environment.
- Integration of separate working environments into a central location for shared services.
- Traffic routing through the central hub, so workloads can be managed centrally.

## Introduction to hub-spoke topology

Hub-spoke networks are commonly used for hybrid cloud architectures, and can be simpler to implement and maintain in the long term. The hub is a virtual network that acts as a central location for managing external connectivity. It also hosts services used by multiple workloads. The hub coordinates all communications to and from the spokes. IT rules or processes, such as security, can inspect, route, and centrally manage traffic. The spokes are virtual networks that host workloads, and connect to the central hub through virtual network peering.

Hub-spoke topologies offer several business benefits:

- Increased business agility by standardizing on network connections. Organizations can adapt to changing markets, adding a new branch in a different geopolitical region, or a new business channel, as spokes.
- Liability reduction by maintaining a consistent architecture. As the business grows, or traffic volumes increase, it's simple to add more systems.
- Greater visibility into the business, with data flowing through the same place. The hub is the core of the business and provides the foundations for deeper business insights, as it processes every piece of information belonging to the organization.
- A single location for sharing centralized services by multiple workloads. This location enables you to minimize redundant resources and the effort required to manage them.

## Architectural components

Let's take a look at a reference architecture for a hub-spoke topology. The following image shows the proposed architecture of a pattern to extend your on-premises environment to Azure.

![Diagram of hub-spoke shared services architecture.](../media/2-hub-shared-services.svg)

The hub is a virtual network in Azure that's the center point for your business connectivity. Shared services are hosted in their own subnets for sharing with the spokes. A perimeter subnet then acts as a security appliance.

The spokes are also virtual networks in Azure, used to isolate individual workloads. The traffic flow between the on-premises headquarters and Azure is connected through ExpressRoute, connected to the hub virtual network. The virtual networks from the spokes to the hub are peered, and enable communication to on-premises resources. You can implement the hub and each spoke in separate subscriptions or resource groups.

The components included in this architecture are:

- **Azure Virtual Network**: Azure virtual networks are a representation of your own IT network. They're contained within the cloud, logically isolating dedicated organizational resources in your subscriptions.
- **Azure VPN Gateway**: VPN Gateway is the bridge between your on-premises network and Azure. VPN gateways are a special type of Virtual Network gateway that sends encrypted traffic between the two networks over the internet.
- **Azure ExpressRoute**: ExpressRoute is a service in Azure that allows you to extend on-premises networks over a private connection.
