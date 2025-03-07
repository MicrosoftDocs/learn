ExpressRoute extends on-premises networks into the Microsoft cloud over a private connection with the help of a connectivity provider. ExpressRoute establishes connections to various Microsoft cloud services, such as Microsoft Azure and Microsoft 365. Connectivity can be from an any-to-any (IP VPN) network, a point-to-point Ethernet network, or a virtual cross-connection through a connectivity provider at a colocation facility. Since ExpressRoute connections don't go over the public Internet, this approach allows ExpressRoute connections to offer more reliability, faster speeds, consistent latencies, and higher security.

## ExpressRoute capabilities

Some key benefits of ExpressRoute are:

 -  Layer 3 connectivity between an on-premises network and the Microsoft Cloud through a connectivity provider
 -  Connectivity can be from an any-to-any (IPVPN) network, a point-to-point Ethernet connection, or through a virtual cross-connection via an Ethernet exchange
 -  Connectivity to Microsoft cloud services across all regions in the geopolitical region
 -  Global connectivity to Microsoft services across all regions with the ExpressRoute premium add-on
 -  Built-in redundancy in every peering location for higher reliability

Azure ExpressRoute is used to create private connections between Azure datacenters and infrastructure on-premises or in a colocation environment. ExpressRoute connections don't go over the public Internet, and they offer more reliability, faster speeds, and lower latencies than typical Internet connections.

## Understand use cases for Azure ExpressRoute

**Faster and Reliable connection to Azure services** \- Organizations using Azure services look for reliable connections to Azure services and data centers. Public internet is dependent upon many factors and may not be suitable for a business. Azure ExpressRoute is used to create private connections between Azure data centers and infrastructure on your premises or in a colocation environment. Using ExpressRoute connections to transfer data between on-premises systems and Azure can also give significant cost benefits.

**Storage, backup, and Recovery** \- Backup and Recovery are important for an organization for business continuity and recovering from outages. ExpressRoute gives you a fast and reliable connection to Azure with bandwidths up to 100 Gbps. ExpressRoute is excellent for scenarios such as periodic data migration, replication for business continuity, disaster recovery, and other high-availability strategies.

**Extends Data center capabilities** \- ExpressRoute can be used to connect and add compute and storage capacity to your existing data centers. With high throughput and fast latencies, Azure feels like a natural extension to or between your data centers, so you enjoy the scale and economics of the public cloud without having to compromise on network performance.

**Predictable, reliable, and high-throughput connections -** With predictable, reliable, and high-throughput connections offered by ExpressRoute, enterprises can build applications that span on-premises infrastructure and Azure without compromising privacy or performance. For example, run a corporate intranet application in Azure that authenticates your customers with an on-premises Active Directory service, and serve all your corporate customers without traffic ever routing through the public Internet.

## ExpressRoute connectivity models

There are several ways to connect an on-premises network and the Microsoft cloud: CloudExchange Colocation, Point-to-point Ethernet Connection, Any-to-any (IPVPN) Connection, and ExpressRoute Direct. Connectivity providers may offer one or more connectivity models.

:::image type="content" source="../media/expressroute-connectivity-models-diagram-d3bd1d21.png" alt-text="Diagram of the ExpressRoute connectivity models.":::


**Co-located at a cloud exchange**

In a facility with a cloud exchange, virtual cross-connections to the Microsoft cloud are provided through the colocation provider’s Ethernet exchange. Colocation providers can offer either Layer 2 cross-connections, or managed Layer 3 cross-connections between your infrastructure in the colocation facility and the Microsoft cloud.

**Point-to-point Ethernet connections**

Point-to-point Ethernet providers can offer Layer 2 connections, or managed Layer 3 connections between your site and the Microsoft cloud.

**Any-to-any (IPVPN) networks**

IPVPN providers offer any-to-any connectivity between your branch offices and datacenters. The Microsoft cloud can be interconnected to your WAN to make it look just like any other branch office. WAN providers typically offer managed Layer 3 connectivity.

**Direct from ExpressRoute sites**

ExpressRoute Direct provides dual 100 Gbps or 10-Gbps connectivity, which supports Active/Active connectivity at scale.

## Design considerations for ExpressRoute deployments

This section discusses a few key areas to consider when deploying ExpressRoute.

### Choose between provider and direct model (ExpressRoute Direct)

**ExpressRoute Direct**

ExpressRoute Direct connects directly into Microsoft’s global network at peering locations strategically distributed around the world. ExpressRoute Direct provides dual 100 Gbps or 10-Gbps connectivity, which supports Active/Active connectivity at scale. You can work with any service provider for ExpressRoute Direct.

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

Configuring Site-to-Site VPN and ExpressRoute coexisting connections has several advantages:

 - A Site-to-Site VPN is a secure failover path for ExpressRoute.
 - Site-to-Site VPNs to connect to sites that aren't connected through ExpressRoute.
 - No downtime occurs when adding a new gateway or gateway connection.

Network Limits and limitations

 -  Only route-based VPN gateways are supported. 
 -  The ASN of Azure VPN Gateway must be set to 65515. 
 -  The gateway subnet must be /27 or a shorter prefix. 
 -  Coexistence in a dual stack VNet isn't supported. 

### Create a zone redundant virtual network gateway in Azure availability zones

You can deploy VPN and ExpressRoute gateways in [Azure Availability Zones](/azure/availability-zones/az-overview). Deploying gateways in Azure Availability Zones physically and logically separates gateways within a region, while protecting your on-premises network connectivity to Azure from zone-level failures.

**Zone-redundant gateways**

To automatically deploy your virtual network gateways across availability zones, you can use zone-redundant virtual network gateways. With zone-redundant gateways, you can benefit from zone-resiliency to access your mission-critical, scalable services on Azure.

:::image type="content" source="../media/zone-redundant-07ede6af.png" alt-text="Diagram of the zone redundant gateways layout.":::


**Zonal gateways**

To deploy gateways in a specific zone, you can use zonal gateways. When you deploy a zonal gateway, all instances of the gateway are deployed in the same Availability Zone.

:::image type="content" source="../media/zonal-d0bfecdb.png" alt-text="Diagram of the zonal only gateway layout.":::


**Gateway SKUs**

Zone-redundant and zonal gateways are available as gateway SKUs. These SKUs are like the corresponding existing SKUs for ExpressRoute and VPN Gateway, except that they're specific to zone-redundant and zonal gateways. You can identify these SKUs by the "AZ" in the SKU name.

**Public IP SKUs**

Zone-redundant gateways and zonal gateways both rely on the Azure public IP resource Standard SKU. The configuration of the Azure public IP resource determines whether the gateway that you deploy is zone-redundant, or zonal. 


## Configure a Site-to-Site VPN as a failover path for ExpressRoute

You can configure a Site-to-Site VPN connection as a backup for ExpressRoute. This connection applies only to virtual networks linked to the Azure private peering path. There's no VPN-based failover solution for services accessible through Azure Microsoft peering. The ExpressRoute circuit is always the primary link. Data flows through the Site-to-Site VPN path only if the ExpressRoute circuit fails. To avoid asymmetrical routing, your local network configuration should also prefer the ExpressRoute circuit over the Site-to-Site VPN. You can prefer the ExpressRoute path by setting higher local preference for the routes received the ExpressRoute.

