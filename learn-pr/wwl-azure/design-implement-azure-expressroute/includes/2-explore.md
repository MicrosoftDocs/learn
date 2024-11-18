

ExpressRoute lets you extend your on-premises networks into the Microsoft cloud over a private connection with the help of a connectivity provider. With ExpressRoute, you can establish connections to various Microsoft cloud services, such as Microsoft Azure and Microsoft 365. Connectivity can be from an any-to-any (IP VPN) network, a point-to-point Ethernet network, or a virtual cross-connection through a connectivity provider at a colocation facility. Since ExpressRoute connections don't go over the public Internet, this approach allows ExpressRoute connections to offer more reliability, faster speeds, consistent latencies, and higher security.

## ExpressRoute capabilities

Some key benefits of ExpressRoute are:

 -  Layer 3 connectivity between your on-premises network and the Microsoft Cloud through a connectivity provider
 -  Connectivity can be from an any-to-any (IPVPN) network, a point-to-point Ethernet connection, or through a virtual cross-connection via an Ethernet exchange
 -  Connectivity to Microsoft cloud services across all regions in the geopolitical region
 -  Global connectivity to Microsoft services across all regions with the ExpressRoute premium add-on
 -  Built-in redundancy in every peering location for higher reliability

Azure ExpressRoute is used to create private connections between Azure datacenters and infrastructure on your premises or in a colocation environment. ExpressRoute connections don't go over the public Internet, and they offer more reliability, faster speeds, and lower latencies than typical Internet connections.

## Understand use cases for Azure ExpressRoute

**Faster and Reliable connection to Azure services** \- Organizations using Azure services look for reliable connections to Azure services and data centers. Public internet is dependent upon many factors and may not be suitable for a business. Azure ExpressRoute is used to create private connections between Azure data centers and infrastructure on your premises or in a colocation environment. Using ExpressRoute connections to transfer data between on-premises systems and Azure can also give significant cost benefits.

**Storage, backup, and Recovery** \- Backup and Recovery are important for an organization for business continuity and recovering from outages. ExpressRoute gives you a fast and reliable connection to Azure with bandwidths up to 100 Gbps. ExpressRoute is excellent for scenarios such as periodic data migration, replication for business continuity, disaster recovery, and other high-availability strategies.

**Extends Data center capabilities** \- ExpressRoute can be used to connect and add compute and storage capacity to your existing data centers. With high throughput and fast latencies, Azure feels like a natural extension to or between your data centers, so you enjoy the scale and economics of the public cloud without having to compromise on network performance.

**Predictable, reliable, and high-throughput connections -** With predictable, reliable, and high-throughput connections offered by ExpressRoute, enterprises can build applications that span on-premises infrastructure and Azure without compromising privacy or performance. For example, run a corporate intranet application in Azure that authenticates your customers with an on-premises Active Directory service, and serve all your corporate customers without traffic ever routing through the public Internet.

## ExpressRoute connectivity models

You can create a connection between your on-premises network and the Microsoft cloud in four different ways, CloudExchange Colocation, Point-to-point Ethernet Connection, Any-to-any (IPVPN) Connection, and ExpressRoute Direct. Connectivity providers may offer one or more connectivity models.

:::image type="content" source="../media/expressroute-connectivity-models-diagram-d3bd1d21.png" alt-text="ExpressRoute connectivity models":::


**Co-located at a cloud exchange**

If you're colocated in a facility with a cloud exchange, you can order virtual cross-connections to the Microsoft cloud through the colocation provider’s Ethernet exchange. Colocation providers can offer either Layer 2 cross-connections, or managed Layer 3 cross-connections between your infrastructure in the colocation facility and the Microsoft cloud.

**Point-to-point Ethernet connections**

You can connect your on-premises datacenters/offices to the Microsoft cloud through point-to-point Ethernet links. Point-to-point Ethernet providers can offer Layer 2 connections, or managed Layer 3 connections between your site and the Microsoft cloud.

**Any-to-any (IPVPN) networks**

You can integrate your WAN with the Microsoft cloud. IPVPN providers offer any-to-any connectivity between your branch offices and datacenters. The Microsoft cloud can be interconnected to your WAN to make it look just like any other branch office. WAN providers typically offer managed Layer 3 connectivity.

**Direct from ExpressRoute sites**

You can connect directly into the Microsoft's global network at a peering location strategically distributed across the world. ExpressRoute Direct provides dual 100 Gbps or 10-Gbps connectivity, which supports Active/Active connectivity at scale.

## Design considerations for ExpressRoute deployments

This section discusses a few key areas that you must consider as you design your ExpressRoute deployment.

### Choose between provider and direct model (ExpressRoute Direct)

**ExpressRoute Direct**

ExpressRoute Direct gives you the ability to connect directly into Microsoft’s global network at peering locations strategically distributed around the world. ExpressRoute Direct provides dual 100 Gbps or 10-Gbps connectivity, which supports Active/Active connectivity at scale. You can work with any service provider for ExpressRoute Direct.

Key features that ExpressRoute Direct provides includes:

 -  Massive Data Ingestion into services like Storage and Cosmos DB
 -  Physical isolation for industries that are regulated and require dedicated and isolated connectivity like: Banking, Government, and Retail
 -  Granular control of circuit distribution based on business unit

**Using ExpressRoute direct vs using a Service Provider**

|                           **ExpressRoute using a Service Provider**                            |                                                                                                                    **ExpressRoute Direct**                                                                                                                    |
|:----------------------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|
| Uses service providers to enable fast onboarding and connectivity into existing infrastructure |                                                                                          Requires 100 Gbps/10 Gbps infrastructure and full management of all layers                                                                                           |
|               Integrates with hundreds of providers including Ethernet and MPLS                |                                                                                         Direct/Dedicated capacity for regulated industries and massive data ingestion                                                                                         |
|                             Circuits SKUs from 50 Mbps to 10 Gbps                              | Customer may select a combination of the following circuit SKUs on 100-Gbps ExpressRoute Direct: 5 Gbps 10 Gbps 40 Gbps 100 Gbps Customer may select a combination of the following circuit SKUs on 10-Gbps ExpressRoute Direct: 1 Gbps 2 Gbps 5 Gbps 10 Gbps |
|                                  Optimized for single tenant                                   |                                                                                    Optimized for single tenant with multiple business units and multiple work environments                                                                                    |


## Design redundancy for an ExpressRoute deployment

There are two ways in which redundancy can be planned for an ExpressRoute deployment.

 -  Configure ExpressRoute and site to site coexisting connections
 -  Create a zone redundant virtual network gateway in Azure Availability zones

### Configure ExpressRoute and site to site coexisting connections

This section helps you configure ExpressRoute and Site-to-Site VPN connections that coexist. Having the ability to configure Site-to-Site VPN and ExpressRoute has several advantages. You can configure Site-to-Site VPN as a secure failover path for ExpressRoute or use Site-to-Site VPNs to connect to sites that aren't connected through ExpressRoute.

Configuring Site-to-Site VPN and ExpressRoute coexisting connections has several advantages:

 -  You can configure a Site-to-Site VPN as a secure failover path for ExpressRoute.
 -  Alternatively, you can use Site-to-Site VPNs to connect to sites that aren't connected through ExpressRoute.

You can configure either gateway first. Typically, you incur no downtime when adding a new gateway or gateway connection.

Network Limits and limitations

 -  **Only route-based VPN gateway is supported.** You must use a route-based VPN gateway. You also can use a route-based VPN gateway with a VPN connection configured for 'policy-based traffic selectors'.
 -  **The ASN of Azure VPN Gateway must be set to 65515.** Azure VPN Gateway supports the BGP routing protocol. For ExpressRoute and Azure VPN to work together, you must keep the Autonomous System Number of your Azure VPN gateway at its default value, 65515. If you previously selected an ASN other than 65515 and you change the setting to 65515, you must reset the VPN gateway for the setting to take effect.
 -  **The gateway subnet must be /27 or a shorter prefix**, (such as /26, /25), or you receive an error message when you add the ExpressRoute virtual network gateway.
 -  **Coexistence in a dual stack VNet is not supported.** If you're using ExpressRoute IPv6 support and a dual-stack ExpressRoute gateway, coexistence with VPN Gateway isn't possible.

### Create a zone redundant virtual network gateway in Azure availability zones

You can deploy VPN and ExpressRoute gateways in [Azure Availability Zones](/azure/availability-zones/az-overview). This brings resiliency, scalability, and higher availability to virtual network gateways. Deploying gateways in Azure Availability Zones physically and logically separates gateways within a region, while protecting your on-premises network connectivity to Azure from zone-level failures.

**Zone-redundant gateways**

To automatically deploy your virtual network gateways across availability zones, you can use zone-redundant virtual network gateways. With zone-redundant gateways, you can benefit from zone-resiliency to access your mission-critical, scalable services on Azure.

:::image type="content" source="../media/zone-redundant-07ede6af.png" alt-text="Zone redundant gateways layout":::


**Zonal gateways**

To deploy gateways in a specific zone, you can use zonal gateways. When you deploy a zonal gateway, all instances of the gateway are deployed in the same Availability Zone.

:::image type="content" source="../media/zonal-d0bfecdb.png" alt-text="Zonal gateways layout":::


**Gateway SKUs**

Zone-redundant and zonal gateways are available as gateway SKUs. There's a new virtual network gateway SKUs in Azure AZ regions. These SKUs are like the corresponding existing SKUs for ExpressRoute and VPN Gateway, except that they are specific to zone-redundant and zonal gateways. You can identify these SKUs by the "AZ" in the SKU name.

**Public IP SKUs**

Zone-redundant gateways and zonal gateways both rely on the Azure public IP resource Standard SKU. The configuration of the Azure public IP resource determines whether the gateway that you deploy is zone-redundant, or zonal. If you create a public IP resource with a Basic SKU, the gateway won't have any zone redundancy, and the gateway resources will be regional.


## Configure a Site-to-Site VPN as a failover path for ExpressRoute

You can configure a Site-to-Site VPN connection as a backup for ExpressRoute. This connection applies only to virtual networks linked to the Azure private peering path. There's no VPN-based failover solution for services accessible through Azure Microsoft peering. The ExpressRoute circuit is always the primary link. Data flows through the Site-to-Site VPN path only if the ExpressRoute circuit fails. To avoid asymmetrical routing, your local network configuration should also prefer the ExpressRoute circuit over the Site-to-Site VPN. You can prefer the ExpressRoute path by setting higher local preference for the routes received the ExpressRoute.

> [!Note]
>
> If you have ExpressRoute Microsoft Peering enabled, you can receive the public IP address of your Azure VPN gateway on the ExpressRoute connection. To set up your site-to-site VPN connection as a backup, you must configure your on-premises network so that the VPN connection is routed to the Internet.

> [!Note]
>
> While ExpressRoute circuit is preferred over Site-to-Site VPN when both routes are the same, Azure will use the longest prefix match to choose the route towards the packet's destination.