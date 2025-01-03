


An ExpressRoute circuit has two peering options associated with it: Azure private, and Microsoft. Each peering is configured identically on a pair of routers (in active-active or load sharing configuration) for high availability. Azure services are categorized as Azure public and Azure private to represent the IP addressing schemes.

:::image type="content" source="../media/expressroute-peerings-31290ff8.png" alt-text="Diagram of ExpressRoute peering use cases.":::


**Create Peering configuration**

 -  You can configure private peering and Microsoft peering for an ExpressRoute circuit. Peering can be configured in any order you choose. However, you must make sure that you complete the configuration of each peering one at a time.
 -  You must have an active ExpressRoute circuit. To configure peerings, the ExpressRoute circuit must be in a provisioned and enabled state.
 -  If you plan to use a shared key/MD5 hash, be sure to use the key on both sides of the tunnel. The limit is a maximum of 25 alphanumeric characters. Special characters aren't supported.

## Choose between private peering only, Microsoft peering only, or both

The following table compares the two peering. Public peering is deprecated for new peering.

| **Features**                               |                                    **Private Peering**                                     |                                  **Microsoft Peering**                                   |
|:------------------------------------------:|:------------------------------------------------------------------------------------------:|:----------------------------------------------------------------------------------------:|
|   Max. \# prefixes supported per peering   |                     4000 by default, 10,000 with ExpressRoute Premium                      |                                           200                                            |
|         IP address ranges supported        |                           Any valid IP address within your WAN.                            |             Public IP addresses owned by you or your connectivity provider.              |
|           AS Number requirements           | Private and public AS numbers. You must own the public AS number if you choose to use one. | Private and public AS numbers. However, you must prove ownership of public IP addresses. |
|       IP protocols supported               |                                    IPv4, IPv6 (preview)                                    |                                        IPv4, IPv6                                        |
|       Routing Interface IP addresses       |                              RFC1918 and public IP addresses                               |               Public IP addresses registered to you in routing registries.               |
|              MD5 Hash support              |                                            Yes                                             |                                           Yes                                            |

You may enable one or more of the routing domains as part of your ExpressRoute circuit. You can choose to have all the routing domains put on the same VPN if you want to combine them into a single routing domain. The recommended configuration is that private peering is connected directly to the core network, and the public and Microsoft peering links are connected to your DMZ.

Each peering requires separate BGP sessions (one pair for each peering type). The BGP session pairs provide a highly available link. If you're connecting through layer 2 connectivity providers, you're responsible for configuring and managing routing.

> [!Important]
>
> IPv6 support for private peering is currently in Public Preview. If you would like to connect your virtual network to an ExpressRoute circuit with IPv6-based private peering configured, please make sure that your virtual network is dual stack and follows the guidelines for [IPv6 for Azure VNet](/azure/virtual-network/ipv6-overview).

## Configure private peering

Azure compute services, namely virtual machines, and cloud services, that are deployed within a virtual network can be connected through the private peering domain. The private peering domain is a trusted extension of your core network into Microsoft Azure. You can set up bi-directional connectivity between your core network and Azure virtual networks (VNets). This peering lets you connect to virtual machines and cloud services directly on their private IP addresses.

You can connect more than one virtual network to the private peering domain. You can visit the [Azure Subscription and Service Limits, Quotas, and Constraints](/azure/azure-resource-manager/management/azure-subscription-service-limits) page for up-to-date information on limits.


## Configure Microsoft peering

Connectivity to Microsoft online services (Microsoft 365 and Azure PaaS services) occurs through Microsoft peering. You can enable bidirectional connectivity between your WAN and Microsoft cloud services through the Microsoft peering routing domain. You must connect to Microsoft cloud services only over public IP addresses owned by you or your connectivity provider and you must adhere to all the defined rules.


## Configure route filters for Microsoft Peering

Route filters are a way to consume a subset of supported services through Microsoft peering.

Microsoft 365 services such as Exchange Online, SharePoint Online, and Skype for Business, are accessible through the Microsoft peering. When Microsoft peering gets configured in an ExpressRoute circuit, all prefixes related to these services gets advertised through the BGP sessions that are established. A BGP community value is attached to every prefix to identify the service that is offered through the prefix.

Connectivity to all Azure and Microsoft 365 services causes many prefixes to gets advertised through BGP. The large number of prefixes significantly increases the size of the route tables maintained by routers within your network. If you plan to consume only a subset of services offered through Microsoft peering, you can reduce the size of your route tables in two ways. You can:

 -  Filter out unwanted prefixes by applying route filters on BGP communities. Route filtering is a standard networking practice and is used commonly within many networks.
 -  Define route filters and apply them to your ExpressRoute circuit. A route filter is a new resource that lets you select the list of services you plan to consume through Microsoft peering. ExpressRoute routers only send the list of prefixes that belong to the services identified in the route filter.

**About route filters**

When Microsoft peering gets configured on your ExpressRoute circuit, the Microsoft Edge routers establish a pair of BGP sessions with your edge routers through your connectivity provider. No routes are advertised to your network. To enable route advertisements to your network, you must associate a route filter.

A route filter lets you identify services you want to consume through your ExpressRoute circuit's Microsoft peering. It's essentially an allowed list of all the BGP community values. Once a route filter resource gets defined and attached to an ExpressRoute circuit, all prefixes that map to the BGP community values gets advertised to your network.

To attach route filters with Microsoft 365 services, you must have authorization to consume Microsoft 365 services through ExpressRoute. If you aren't authorized to consume Microsoft 365 services through ExpressRoute, the operation to attach route filters fails.