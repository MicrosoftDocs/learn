Your company is planning a migration of on-premises resources to Azure, as part of this migration there is a central datacenter that will remain on-premises initially but will need connectivity to Azure. You need to integrate multiple locations into this datacenter with central dependencies such as Active Directory. The ultimate goal for the migration is to implement a virtual data center in Azure.

You have heard about the hub and spoke architectural pattern but are unsure of how to implement this in Azure. You need to understand the base components of this model to begin planning the migration.

In this unit, you'll explore the hub and spoke architecture, the topology, the components needed in Azure and how to plan implementing infrastructure using this model.

## Hub and Spoke Architecture Foundations

A hub and spoke consists of a centralized architecture (a hub) connecting to multiple points (spokes). In diagrammatical form it looks similar to a wheel, with a hub at the center and spokes connected to it. This model in Azure organizes your network infrastructure into multiple connected virtual networks (vnets). It provides a more efficient method for managing common communication or security requirements or deal with potential subscription limitations.

The foundations for this paradigm in a hybrid network scenario consist of:

- A centrally managed connection to your on-premises environment
- Integration of separate working environments into a central location for shared services
- Traffic routing through the central hub so workloads can be managed centrally.
- Workloads do not need to connect to each other but need access to central shared services.

## Introduction to the Hub-Spoke topology

The hub-spoke paradigm is commonly used for hybrid cloud architectures, it is simpler to implement and maintain over the longer term. In the hub and spoke model, the hub is a virtual network that acts as a central location for managing external connectivity and hosting services used by multiple workloads. The spokes are virtual networks that host workloads and connect to the central hub through virtual network peering.

The hub is responsible for facilitating all communications to and from the spokes with all traffic passing in or out of the workload spoke networks being routed through the hub. Then it can be inspected, routed and managed by managed centrally by IT rules or processes such as security.

Hub and spoke topologies offer several business benefits:

- Increased business agility by standardizing the integration paradigm it increases the organizations ability to adapt to changing markets, such as adding a new branch in a different geopolitical region or a new business channel as spokes.
- Liability reduction by maintaining a consistent architecture. As the business grows or traffic volumes grow it's simple to add more systems. The ease of this implementation is that much greater as it's a repeat of previous work.
- Greater visibility into the business with data flowing through the same place. The hub becomes the core of the business and provides the foundations for deeper business insight, it processes every single piece of information belonging to the organization.
- Centralizing services to be shared by multiple workloads into a single location give the ability to minimize redundant resources or effort to managed them thereby producing greater cost savings and management efficiency.

## Walk through of architectural components

![Image showing hub-spoke shared services architecture](../media/2-hub-shared-services.png)

There is a reference architecture available for a hub-spoke topology in Azure. The image above shows how this could be implemented.

In essence, this above architecture shows a pattern to extend your on-premises environment to Azure. The hub becomes a vnet in Azure that comes the center point of connectivity. Shared services are hosted in their own subnet for sharing amongst the spokes and a DMZ subnet to act as a security appliance. The spokes are also vnets in Azure used to isolate individual workloads. The traffic flow between the on-premises data center and Azure is connected through a VPN connection or ExpressRoute which is in it's own subnet. The vnets from the spokes to the hub are peered together.

The hub and each spoke can be implemented in separate subscriptions or resource groups and peered together. These subscriptions or resource groups can then share the central services (AD DS Server) providing management for shared services in the hub but decentralizing each workload.

The components included in this architecture are:

- **Azure Virtual Networks**: Azure Virtual Networks (vnets) are a representation of your own IT network but contained within the cloud, logically isolating dedicated organizational resources in your subscription(s).
- **Azure VPN Gateway**: Azure VPN Gateway is the bridge between your on-premises network and Azure.  VPN gateways are a special type of vnet gateway that can send encrypted traffic between the two networks over the internet.
- **Azure ExpressRoute**: Azure ExpressRoute is a different service enabling you to extend your on-premises networks to Azure. ExpressRoute is a service in Azure that allows you to extend your on-premises networks over a private connection.

## Considerations for identity and access management

Identity and Access management is a critical function for any organization whether that be on-premises or in the cloud. Most organizations have a Active Directory Directory Service (ADDS) environment already in their on-premises datacenter. To help manage assets that have been moved to Azure it's usual to host an ADDS domain controller in Azure. This controller is normally placed inside the hub vnet so that dependant workloads can access it, this is particularly important if you use Group Policy objects. It is also best practice to integrate your on-premises AD directory with Azure AD in tandem with Role Based Access Control (RBAC).

When workloads are moved from your on-premises environment to Azure they will need, in the most part, to be hosted on VMs. The traffic hitting these VMs will need to be strictly enforced, this is a typical compliance requirement. One method for managing this in Azure is a network virtual appliance (NVA). Network virtual appliances in Azure allow you to use appliances from your on-premises environment in the cloud such as firewalls, web application firewalls or application delivery controllers.

## Peering and traffic management for hub-spoke on Azure

When implementing the hub and spoke topology peering and traffic management is a critical concept. Hub and spoke relies upon virtual network chaining, thus, integration between them is achieved using vnet peering. Vnet peering is a non-transitive relationship between two Azure virtual networks essentially creating a chain. 

![Image showing hub-spoke-hub-spoke vnets](../media/2-hub-spokehub-spoke.png)

Peered networks help enable the isolation between the workloads whilst maintaining access to shared resources, however, growing networks can quickly reach vnet peering limits. The solution to this is to create a hub-spoke-hub-spoke topology where the first level of spokes also act as a hub.

Traffic management is completed directly within the vnet itself and also through using Azure Firewall which you'll cover later in this module.

In this unit you have learned about the hub spoke architecture in Azure, the components it requires and the key points you need to consider to implement it. In the next unit you will learn about how to plan the design of your Azure Virtual Networks.
