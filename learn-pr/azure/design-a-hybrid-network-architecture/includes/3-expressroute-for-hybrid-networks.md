Your company is migrating some of its on-premises resources to Azure. As part of this migration, the central datacenter must remain on-premises with a connection to Azure. The architectural model also needs to consider Azure network connectivity for several satellite offices.

So far, you've identified a need for a resilient high-bandwidth connection from the on-premises network to Azure. In your initial investigations, you found that Azure ExpressRoute could suit your organization's hybrid network needs.

In this unit, you'll explore on-premises hybrid connectivity by using ExpressRoute, get an overview of the components that are available in ExpressRoute, and walk through a reference architecture that supports this topology.

## What is ExpressRoute?

Azure ExpressRoute is an Azure service that allows you to extend on-premises networks over a private connection. A connectivity provider helps make this connection. ExpressRoute extends beyond Azure and lets you establish connections to other Microsoft cloud services, such as Office 365.

 ![Diagram of an ExpressRoute connection.](../media/3-expressroute.svg)

ExpressRoute connections don't use the public internet. By using a dedicated connection between your on-premises network and Azure, you achieve greater resilience, faster speeds, higher security, and lower latency.

### ExpressRoute connectivity types

There are three ExpressRoute connectivity types, each serving a different need, as shown in the following diagram:

![Diagram of ExpressRoute connectivity models.](../media/3-expressroute-connectivity-models.svg)

- **CloudExchange**: With the CloudExchange method, you cross-connect to Azure by using the Ethernet exchange provided by your colocation facility.
- **Point-to-point**: With the point-to-point Ethernet network method, you connect on-premises datacenters and offices to Azure through a point-to-point Ethernet link.
- **Any-to-any**: With the any-to-any network method, you integrate your WAN with Azure by using an IP virtual private network (VPN) provider. This connection type offers links between branch offices and datacenters. When enabled, the connection to Azure is similar to any other branch office connected via the WAN.

## ExpressRoute circuits

A *circuit* is a logical connection between your on-premises network and your Azure network in ExpressRoute. You configure traffic management and routing in ExpressRoute by using circuits. You can have multiple circuits, which exist across various regions. ExpressRoute circuits also support connections through many connectivity providers.

Each circuit has multiple routing domains and peerings associated with it. Examples include Azure public peering, Azure private peering, and Microsoft peering. Each type has identical properties. Each circuit uses a pair of routers in either an active-active or load-sharing configuration, which creates a high availability environment. An ExpressRoute circuit doesn't map to anything physical.

### Azure private peering

Private peering is a trusted extension of your core network in Azure with bidirectional connectivity. By using this peering model, you can connect to virtual machines and cloud services directly on their private IP addresses.

### Microsoft peering

Microsoft peering provides connectivity to all Microsoft online services: Office 365, Dynamics 365, and Azure platform as a service (PaaS). This model requires a public IP address, owned by you or your connectivity provider, which adheres to a set of predefined rules.

Microsoft peering assigns each circuit a globally unique identifier (GUID), or service key. This key is the only information exchanged between the three parties and is a one-to-one mapping for each circuit.

### Circuit bandwidth

You can have as many circuits as you need, each matching the bandwidth you require. For example, you might want a higher bandwidth between your datacenter and the cloud, but a lower bandwidth for your satellite offices. Bandwidth speeds come in fixed tiers:

- 50 Mbps
- 100 Mbps
- 200 Mbps
- 500 Mbps
- 1 Gbps
- 10 Gbps
- 100 Gbps

The bandwidth is shared across any peering in the circuit and is mapped to the connectivity provider and peering location.

### Coexisting connections and ExpressRoute

To use ExpressRoute, you must have a private connection, which is provided by a connectivity partner. However, ExpressRoute can exist alongside any of your current site-to-site, point-to-site, or VPN-to-VPN connections.

## ExpressRoute reference architecture

The reference architecture illustrated in the following diagram shows how to connect your on-premises network to your Azure virtual networks.

![Diagram of ExpressRoute reference architecture.](../media/3-expressroute-architecture.svg)

The architecture model includes several components:

- The **on-premises network** is your local Active Directory-managed network.
- **Local edge routers** connect your on-premises network to the connectivity provider's circuit.
- An **ExpressRoute circuit**, supplied by your connectivity provider, operates as a layer 3 circuit. It provides the link between the Azure edge routers and your on-premises edge router.
- The **Microsoft edge routers** are the cloud-side connection between your on-premises network and the cloud. There are always two edge routers, providing a highly available active-active connection.
- The **Azure virtual network** is where you'll segment your network and assets into tiers. Each application tier, or subnet, can manage specific business operations (for example, web, business, and data).

## Is ExpressRoute right for you?

When you're evaluating whether to switch to ExpressRoute, consider the following benefits and considerations.

### Benefits

Implementing ExpressRoute in your organization helps produce the following benefits:

- ExpressRoute is better suited to high-speed and critical business operations.
- ExpressRoute circuits support a maximum bandwidth of 100 Gbps.
- ExpressRoute provides dynamic scalability to help meet your organizational needs.
- ExpressRoute uses layer 3 connectivity and security standards.

### Considerations

The following list identifies a few key considerations:

- The setup and configuration for ExpressRoute is more complex, and requires collaboration with the connectivity provider.
- ExpressRoute requires the on-premises installation of high-bandwidth routers.
- The connectivity provider handles and manages the ExpressRoute circuit.
- ExpressRoute doesn't support the Hot Standby Router Protocol (HSRP). Enable a Border Gateway Protocol (BGP) configuration.
- ExpressRoute operates on a layer 3 circuit and requires a network security appliance to manage threats.
- Monitoring the connectivity between your on-premises network and Azure must use the Azure Connectivity Toolkit.
- To improve network security, ExpressRoute requires network security appliances between the provider's edge routers and your on-premises network.
