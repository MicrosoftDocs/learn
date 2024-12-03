ExpressRoute lets you extend your on-premises networks into the Microsoft cloud over a private connection with the help of a connectivity provider. With ExpressRoute, you can establish connections to Microsoft cloud services, such as Microsoft Azure and Microsoft 365.

Connectivity can be from an any-to-any (IP VPN) network, a point-to-point Ethernet network, or a virtual cross-connection through a connectivity provider at a colocation facility. ExpressRoute connections offer more reliability, faster speeds, consistent latencies, and higher security than typical connections over the Internet, because they don’t go over the public Internet.

:::image type="content" source="../media/expressroute-connection-overview-0d35ad26.png" alt-text="Diagram showing an example of Azure ExpressRoute.":::
<br>

## Key benefits

 -  Layer 3 connectivity between your on-premises network and the Microsoft Cloud through a connectivity provider. Connectivity can be from an any-to-any (IPVPN) network, a point-to-point Ethernet connection, or through a virtual cross-connection via an Ethernet exchange.
 -  Connectivity to Microsoft cloud services across all regions in the geopolitical region.
 -  Global connectivity to Microsoft services across all regions with the ExpressRoute premium add-on.
 -  Dynamic routing between your network and Microsoft via border gateway protocol (BGP).
 -  Built-in redundancy in every peering location for higher reliability.
 -  Connection uptime service level agreement (SLA).
 -  Quality of Service (QoS) support for Skype for Business.

## Features

**Layer 3 connectivity**

Microsoft uses BGP, an industry standard dynamic routing protocol, to exchange routes between your on-premises network, your instances in Azure, and Microsoft public addresses. We establish multiple BGP sessions with your network for different traffic profiles.

## Redundancy

Each ExpressRoute circuit consists of two connections to two Microsoft Enterprise edge routers (MSEEs) at an ExpressRoute Location from the connectivity provider or your network edge. Microsoft requires dual BGP connections from the connectivity provider or your network edge – one to each MSEE. You might choose not to deploy redundant devices/Ethernet circuits at your end. However, connectivity providers use redundant devices to ensure that your connections are handed off to Microsoft in a redundant manner.

## Connectivity to Microsoft cloud services

ExpressRoute connections enable access to the following services:

 -  Microsoft Azure services<br>
 -  Microsoft 365 services

## Connectivity to all regions within a geopolitical region

You can connect to Microsoft from one of our peering locations and access regions within the same geopolitical region.

For example, if you connect to Microsoft in Amsterdam through ExpressRoute. You have access to all of Microsoft cloud services hosted in North and West Europe.

## Global connectivity with ExpressRoute Premium

You can enable ExpressRoute Premium to extend connectivity across geopolitical boundaries. If you connect to Microsoft in Amsterdam through ExpressRoute, you have access to all of Microsoft cloud services hosted in every region across the globe. For example, you have access to services deployed in West US or Australian East the same way you access North and West Europe regions. National clouds are excluded.

## Local connectivity with ExpressRoute Local

You can transfer data cost-effectively by enabling the local stock keeping units (SKU). With Local SKU, you can bring your data to an ExpressRoute location near the Azure region you want. With Local, Data transfer is included in the ExpressRoute port charge.

## Across on-premises connectivity with ExpressRoute Global Reach

By enabling ExpressRoute Global Reach, you can exchange data across your on-premises sites through your ExpressRoute circuits. For instance, suppose you have two private data centers, one in California and one in Texas, each connected to an ExpressRoute circuit in their respective regions. You can use ExpressRoute Global Reach to link your data centers with these circuits, and your cross data-center traffic uses the Microsoft network.

## Rich connectivity partner ecosystem

ExpressRoute has a constantly growing ecosystem of connectivity providers and systems integrator partners.

## Connectivity to national clouds

Microsoft operates isolated cloud environments for special geopolitical regions and customer segments.

## ExpressRoute Direct

ExpressRoute Direct provides customers the opportunity to connect directly into Microsoft’s global network at peering locations strategically distributed across the world. ExpressRoute Direct provides dual 100-Gbps connectivity, which supports Active/Active connectivity at scale.

Key features that ExpressRoute Direct provides include, but aren't limited to:

 -  Massive data ingestion into services like Azure Storage and Azure Cosmos DB.<br>
 -  Physical isolation for industries that are regulated and require dedicated and isolated connectivity. For example: banks, governments, and retails.
 -  Granular control of circuit distribution based on business unit.

## Bandwidth options

You can purchase ExpressRoute circuits for a wide range of bandwidths. The supported bandwidths are listed as follows. Be sure to check with your connectivity provider to determine the bandwidths they support.

 -  50 megabits per second (Mbps)<br>
 -  100 Mbps
 -  200 Mbps
 -  500 Mbps
 -  1 gigabit per second (Gbps)
 -  2 Gbps
 -  5 Gbps
 -  10 Gbps

The built-in redundancy of your circuit is configured using primary and secondary connections, each of the procured bandwidth, to two Microsoft Enterprise Edge routers (MSEEs). The bandwidth available through your secondary connection can be used for more traffic if necessary. Since the secondary connection is meant for redundancy, it isn't guaranteed and shouldn't be used for extra traffic for a sustained period of time. If you plan to use only your primary connection to transmit traffic, the bandwidth for the connection is fixed, and attempting to oversubscribe it results in increased packet drops.

## Dynamic scaling of bandwidth

You can increase the ExpressRoute circuit bandwidth without having to tear down your connections.

## Flexible billing models

 -  You can select a billing model that works best for you:
 -  Unlimited data. Billing is based on a monthly fee; all inbound and outbound data transfer is included free of charge.<br>
 -  Metered data. Billing is based on a monthly fee; all inbound data transfer is free of charge. Outbound data transfer is charged per GB of data transfer. Data transfer rates vary by region.
 -  ExpressRoute premium add-on. ExpressRoute premium is an add-on to the ExpressRoute circuit. The ExpressRoute premium add-on provides the following capabilities:
    
    
     -  Increased route limits for Azure public and Azure private peering from 4,000 routes to 10,000 routes.
     -  Global connectivity for services. An ExpressRoute circuit created in any region (excluding national clouds) has access to resources across every other region in the world. For example, a virtual network created in West Europe can be accessed through an ExpressRoute circuit provisioned in Silicon Valley.
     -  Increased number of virtual network links per ExpressRoute circuit from 10 to a larger limit, depending on the bandwidth of the circuit.
