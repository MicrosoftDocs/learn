Your company is planning a migration of on-premises resources to Azure. As part of this migration there's a central datacenter that will remain on-premises initially, but will need connectivity to Azure. You'll integrate multiple locations into this single datacenter, with central dependencies such as Active Directory. The ultimate goal for the migration is to implement a virtual data center inside Azure.

You've heard of the hub and spoke architectural pattern, but are unsure of how to implement this architecture in Azure. You'll explore the base components of this model to begin planning the migration.

In this unit, you'll explore the hub and spoke architecture, the topology, the components needed in Azure and how to plan implementing infrastructure using this model.

## Hub and Spoke Architecture Foundations

![A diagram of a hub and spoke with Azure in the center. Representing central resources like AD, surrounded by several VNets in a circle](../media/hub-and-spoke.png)

A hub and spoke consists of a centralized architecture (a hub) connecting to multiple points (spokes). It looks similar to a wheel when drawn, with a hub at the center and spokes connected to it. This model in Azure organizes your network infrastructure into multiple connected virtual networks (VNets). This architecture provides a more efficient method for managing common communication, security requirements, and deal with potential subscription limitations.

The foundations for this paradigm in a hybrid network scenario consist of:

- A centrally managed connection to your on-premises environment
- Integration of separate working environments into a central location for shared services
- Traffic routing through the central hub so workloads can be managed centrally
- Workloads don't need to connect to each other but need access to central shared services

## Introduction to the Hub-Spoke topology

The hub-spoke paradigm is commonly used for hybrid cloud architectures, it's simpler to implement and maintain over the longer term. The hub is a virtual network that acts as a central location for managing external connectivity, and hosting services used by multiple workloads. The hub coordinates all communications to and from the spokes. Traffic can be inspected, routed, and managed centrally by IT rules or processes like security. The spokes are virtual networks that host workloads and connect to the central hub through virtual network peering.

Hub and spoke topologies offer several business benefits:

- Increased business agility by standardizing on network connections. Organizations can adapt to changing markets, adding a new branch in a different geopolitical region or a new business channel as spokes
- Liability reduction by maintaining a consistent architecture. As the business grows, or traffic volumes grow, it's simple to add more systems. The implementation is that much easier as it's a repeat of previously completed work
- Greater visibility into the business, with data flowing through the same place. The hub is the core of the business and provides the foundations for deeper business insights, as it processes every single piece of information belonging to the organization
- Share centralized services by multiple workloads into a single location, gives the ability to minimize redundant resources or effort to managed them

## Walk through of architectural components

![Image showing hub-spoke shared services architecture](../media/2-hub-shared-services.png)

There's a reference architecture available for a hub-spoke topology explained in the Azure documentation. The image above shows the proposed architecture of a pattern to extend your on-premises environment to Azure. 

The hub is a VNet in Azure that is the center point for your businesses connectivity. Shared services are hosted in their own subnets for sharing with the spokes, and a DMZ subnet to act as a security appliance. 

The spokes are also VNets in Azure used to isolate individual workloads. The traffic flow between the on-premises headquarters and Azure is connected through an ExpressRoute that is in its own gateway subnet. The VNets from the spokes to the hub are peered together.

The hub, and each spoke, can be implemented in separate subscriptions, or resource groups, and peered together. These subscriptions, or resource groups, can then share the central services (AD DS Server) providing management for shared services in the hub but decentralizing each workload.

The components included in this architecture are:

- **Azure Virtual Networks**: Azure Virtual Networks (**VNets**) are a representation of your own IT network but contained within the cloud, logically isolating dedicated organizational resources in your subscriptions
- **Azure VPN Gateway**: Azure VPN Gateway is the bridge between your on-premises network and Azure.  VPN gateways are a special type of VNet gateway that can send encrypted traffic between the two networks over the internet
- **Azure ExpressRoute**: Azure ExpressRoute is a different service enabling you to extend your on-premises networks to Azure. ExpressRoute is a service in Azure that allows you to extend your on-premises networks over a private connection

## Considerations for identity and access management

Most organizations have an Active Directory Domain Service (ADDS) environment already in their on-premises datacenter. To help manage assets that have been moved to Azure, it's usual to host an ADDS domain controller in Azure. This controller is placed inside the hub VNet, so that dependant workloads can access it, this is important if you use Group Policy objects. It's also best practice to integrate your on-premises AD directory with Azure AD in tandem with Role-Based Access Controls (RBAC).

When workloads are moved from your on-premises environment to Azure, they will probably need to be hosted on VMs. The traffic hitting these VMs will need to be restricted, typically compliance requirement in companies. A method for managing this traffic in Azure is a network virtual appliance (NVA). NVAs in Azure allow you to use appliances from your on-premises environment in the cloud through firewalls, web application firewalls, or application delivery controllers.

## Peering and traffic management for hub-spoke on Azure
![Image showing hub-spoke-hub-spoke VNets](../media/2-hub-spokehub-spoke.png)

Hub and spoke relies upon virtual network chaining, that's because integration between them is via VNet peering. VNet peering is a non-transitive relationship between two Azure virtual networks essentially creating a chain.

Peered networks help enable the isolation between the workloads while maintaining access to shared resources, however growing networks can quickly reach VNet peering limits. The solution to this problem is to create a hub-spoke-hub-spoke topology, where the first level of spokes also acts as hubs for the next level of spokes.

Traffic management is controlled within the VNet itself and also through using Azure Firewall that you'll cover later in this module
