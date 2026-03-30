Azure ExpressRoute lets you extend your on-premises networks into the Microsoft cloud over a private connection, with the help of a connectivity provider. This connection is called an ExpressRoute Circuit. With ExpressRoute, you can establish connections to Microsoft cloud services, such as Microsoft Azure and Microsoft 365. ExpressRoute lets you connect offices, datacenters, or other facilities to the Microsoft cloud. Each location would have its own ExpressRoute circuit.

:::image type="content" source="../media/expressroute-connection-path.png" alt-text="Diagram showing ExpressRoute providing a private connection from on-premises through a connectivity provider to Microsoft cloud.":::

Connectivity can be from an any-to-any (IP VPN) network, a point-to-point Ethernet network, or a virtual cross-connection through a connectivity provider at a colocation facility. ExpressRoute connections don't go over the public internet. Because they bypass the public internet, ExpressRoute connections offer more reliability, faster speeds, consistent latencies, and higher security than typical internet connections.

## Features and benefits of ExpressRoute

There are several benefits to using ExpressRoute as the connection service between Azure and on-premises networks.

 -  Connectivity to Microsoft cloud services across all regions in the geopolitical region.
 -  Global connectivity to Microsoft services across all regions with the ExpressRoute Global Reach.
 -  Dynamic routing between your network and Microsoft via Border Gateway Protocol (BGP).
 -  Built-in redundancy in every peering location for higher reliability.

### Connectivity to Microsoft cloud services

ExpressRoute enables direct access to the following services in all regions:

 -  Microsoft Office 365
 -  Microsoft Dynamics 365
 -  Azure compute services, such as Azure Virtual Machines
 -  Azure cloud services, such as Azure Cosmos DB and Azure Storage

### Global connectivity

You can enable ExpressRoute Global Reach to exchange data across your on-premises sites by connecting your ExpressRoute circuits. For example, suppose you have an office in Asia and a datacenter in Europe, both with ExpressRoute circuits connecting them to the Microsoft network. You can use ExpressRoute Global Reach to connect those two facilities, allowing them to communicate without transferring data over the public internet.

:::image type="content" source="../media/expressroute-global-reach.png" alt-text="Diagram showing two on-premises sites connected through the Microsoft backbone using ExpressRoute Global Reach, without public internet transit.":::

### Dynamic routing

ExpressRoute uses BGP to exchange routes between on-premises networks and resources running in Azure. This protocol enables dynamic routing between your on-premises network and services running in the Microsoft cloud.

### Built-in redundancy

Each connectivity provider uses redundant devices to ensure that connections established with Microsoft are highly available. You can configure multiple circuits to complement this feature.

## Connectivity model options

ExpressRoute supports several connectivity options depending on your provider and network design, including provider-based connectivity, point-to-point Ethernet, and direct connectivity at ExpressRoute locations. At this level, focus on when to use ExpressRoute rather than detailed implementation models.

At a high level, choose ExpressRoute when:

 -  You need private, consistent connectivity between on-premises networks and Azure.
 -  Your team has strict compliance or data-transfer requirements.
 -  You need predictable latency and high-throughput network performance.
 -  You want to avoid sending critical traffic over the public internet.

## Security considerations

With ExpressRoute, your data doesn't travel over the public internet, reducing the risks associated with internet communications. ExpressRoute is a private connection from your on-premises infrastructure to your Azure infrastructure. Even if you have an ExpressRoute connection, DNS queries, certificate revocation list checking, and Azure Content Delivery Network requests are still sent over the public internet.

