You can create custom, or user-defined (static), routes in Azure to override Azure's default system routes, or to add more routes to a subnet's route table. In Azure, you create a route table, then associate the route table to zero or more virtual network subnets. Each subnet can have zero or one route table associated to it. To learn about the maximum number of routes you can add to a route table and the maximum number of user-defined route tables you can create per Azure subscription, see [Azure limits](/azure/azure-resource-manager/management/azure-subscription-service-limits?toc=/azure/virtual-network/toc.json#networking-limits). When you create a route table and associate it to a subnet, the table's routes are combined with the subnet's default routes. If there are conflicting route assignments, user-defined routes override the default routes.

You can specify the following next hop types when creating a user-defined route:

 -  Virtual appliance: A virtual appliance is a virtual machine that typically runs a network application, such as a firewall. To learn about various preconfigured network virtual appliances you can deploy in a virtual network, see the [Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace/apps/category/networking?page=1&subcategories=appliances). When you create a route with the virtual appliance hop type, you also specify a next hop IP address. The IP address can be:
    
    
     -  The private IP address of a network interface attached to a virtual machine. Any network interface attached to a virtual machine that forwards network traffic to an address other than its own must have the Azure Enable IP forwarding option enabled for it. The setting disables Azure's check of the source and destination for a network interface. Learn more about how to [enable IP forwarding for a network interface](/azure/virtual-network/virtual-network-network-interface#enable-or-disable-ip-forwarding). Though Enable IP forwarding is an Azure setting, you may also need to enable IP forwarding within the virtual machine's operating system for the appliance to forward traffic between private IP addresses assigned to Azure network interfaces. If the appliance needs to route traffic to a public IP address, it must either proxy the traffic or perform network address translation (NAT) from the source's private IP address to its own private IP address. Azure then performs NAT to a public IP address before sending the traffic to the Internet. To determine required settings within the virtual machine, see the documentation for your operating system or network application. To understand outbound connections in Azure, see [Understanding outbound connections](/azure/load-balancer/load-balancer-outbound-connections?toc=/azure/virtual-network/toc.json).<br>
     -  The private IP address of an Azure internal load balancer. A load balancer is often used as part of a high availability strategy for network virtual appliances.

You can define a route with 0.0.0.0/0 as the address prefix and a next hop type of virtual appliance. This configuration allows the appliance to inspect the traffic and determine whether to forward or drop the traffic. If you intend to create a user-defined route that contains the 0.0.0.0/0 address prefix, read 0.0.0.0/0 address prefix first.

 -  Virtual network gateway: Specify when you want traffic destined for specific address prefixes routed to a virtual network gateway. The virtual network gateway must be created with type VPN. You can't specify a virtual network gateway created as type ExpressRoute in a user-defined route because with ExpressRoute, you must use BGP for custom routes. You can't specify Virtual Network Gateways if you have VPN and ExpressRoute coexisting connections either. You can define a route that directs traffic destined for the 0.0.0.0/0 address prefix to a route-based virtual network gateway. On your premises, you might have a device that inspects the traffic and determines whether to forward or drop the traffic. If you intend to create a user-defined route for the 0.0.0.0/0 address prefix, read 0.0.0.0/0 address prefix first. Instead of configuring a user-defined route for the 0.0.0.0/0 address prefix, you can advertise a route with the 0.0.0.0/0 prefix via BGP, if you've enabled BGP for a VPN virtual network gateway.
 -  None: Specify when you want to drop traffic to an address prefix, rather than forwarding the traffic to a destination. If you haven't fully configured a capability, Azure may list None for some of the optional system routes. For example, if you see None listed as the Next hop IP address with a Next hop type of Virtual network gateway or Virtual appliance, it may be because the device isn't running, or isn't fully configured. Azure creates system default routes for reserved address prefixes with None as the next hop type.<br>
 -  Virtual network: Specify the Virtual network option when you want to override the default routing within a virtual network.<br>
 -  Internet: Specify the Internet option when you want to explicitly route traffic destined to an address prefix to the Internet, or if you want traffic destined for Azure services with public IP addresses kept within the Azure backbone network. See [Routing example](/azure/virtual-network/virtual-networks-udr-overview#routing-example), for an example of why you might create a route with the Virtual network hop type.<br>

You can't specify Virtual network peering or VirtualNetworkServiceEndpoint as the next hop type in user-defined routes. Routes with the Virtual network peering or VirtualNetworkServiceEndpoint next hop types are only created by Azure, when you configure a virtual network peering, or a service endpoint.

## Service Tags for user-defined routes

You can now specify a service tag as the address prefix for a user-defined route instead of an explicit IP range. A service tag represents a group of IP address prefixes from a given Azure service. Microsoft manages the address prefixes encompassed by the service tag and automatically updates the service tag as addresses change. Thus minimizing the complexity of frequent updates to user-defined routes and reducing the number of routes you need to create. You can currently create 25 or less routes with service tags in each route table. With this release, using service tags in routing scenarios for containers is also supported.

## Exact Match

The system gives preference to the route with the explicit prefix when there's an exact prefix match between a route with an explicit IP prefix and a route with a Service Tag. When multiple routes with Service Tags have matching IP prefixes, routes are evaluated in the following order:

1.  Regional tags (for example, Storage.EastUS, AppService.AustraliaCentral)<br>
2.  Top level tags (for example, Storage, AppService)<br>
3.  AzureCloud regional tags (for example, AzureCloud.canadacentral, AzureCloud.eastasia)<br>
4.  The AzureCloud tag<br>

To use this feature, specify a Service Tag name for the address prefix parameter in route table commands. For example, in PowerShell you can create a new route to direct traffic sent to an Azure Storage IP prefix to a virtual appliance by using:

```powershell
$param = @{ Name = 'StorageRoute' AddressPrefix = 'Storage' NextHopType = 'VirtualAppliance' NextHopIpAddress = '10.0.100.4' } New-AzRouteConfig @param
```

The same command for the Azure CLI is:

```azurecli
az network route-table route create \ --resource-group MyResourceGroup \ --route-table-name MyRouteTable \ --name StorageRoute \ --address-prefix Storage \ --next-hop-type VirtualAppliance \ --next-hop-ip-address 10.0.100.4
```

## Next hop types across Azure tools

The name displayed and referenced for next hop types is different between the Azure portal and command-line tools, and the Resource Manager and classic deployment models. The following table lists the names used to refer to each next hop type with the different tools and [deployment models](/azure/azure-resource-manager/management/deployment-models?toc=/azure/virtual-network/toc.json).

Expand table

| **Next hop type**                | **Azure CLI and PowerShell (Resource Manager)** | **Azure classic CLI and PowerShell (classic)**                                |
| -------------------------------- | ----------------------------------------------- | ----------------------------------------------------------------------------- |
| Virtual network gateway          | VirtualNetworkGateway                           | VPNGateway                                                                    |
| Virtual network                  | VNetLocal                                       | VNETLocal (not available in the classic CLI in classic deployment model mode) |
| Internet                         | Internet                                        | Internet (not available in the classic CLI in classic deployment model mode)  |
| Virtual appliance                | VirtualAppliance                                | VirtualAppliance                                                              |
| None                             | None                                            | Null (not available in the classic CLI in classic deployment model mode)      |
| Virtual network peering          | Virtual network peering                         | Not applicable                                                                |
| Virtual network service endpoint | VirtualNetworkServiceEndpoint                   | Not applicable                                                                |

### Border gateway protocol

An on-premises network gateway can exchange routes with an Azure virtual network gateway by using the BGP. Using BGP with an Azure virtual network gateway is dependent on the type you selected when you created the gateway:

 -  ExpressRoute: You must use BGP to advertise on-premises routes to the Microsoft edge router. You can't create UDRs to force traffic to the ExpressRoute virtual network gateway if you deploy a virtual network gateway deployed as the type ExpressRoute. You can use UDRs for forcing traffic from the express route to, for example, a network virtual appliance.
 -  VPN: Optionally, you can use BGP. For more information, see [BGP with site-to-site VPN connections](/azure/vpn-gateway/vpn-gateway-bgp-overview?toc=/azure/virtual-network/toc.json).

When you exchange routes with Azure by using BGP, a separate route is added to the route table of all subnets in a virtual network for each advertised prefix. The route is added with Virtual network gateway listed as the source and next hop type.

You can disable ExpressRoute and Azure VPN Gateway route propagation on a subnet by using a property on a route table. When you disable route propagation, the system doesn't add routes to the route table of all subnets with virtual network gateway route propagation disabled. This process applies to both static routes and BGP routes. Connectivity with VPN connections is achieved by using [custom routes](/azure/virtual-network/virtual-networks-udr-overview#custom-routes) with a next hop type of Virtual network gateway. For more information, see [Disable virtual network gateway route propagation](/azure/virtual-network/manage-route-table#create-a-route-table).

> [!NOTE]
> Route propagation shouldn't be disabled on GatewaySubnet. The gateway won't function if this setting is disabled.

## How Azure selects a route

When outbound traffic is sent from a subnet, Azure selects a route based on the destination IP address by using the longest prefix match algorithm. For example, a route table has two routes. One route specifies the 10.0.0.0/24 address prefix, and the other route specifies the 10.0.0.0/16 address prefix.

Azure directs traffic destined for 10.0.0.5 to the next hop type specified in the route with the 10.0.0.0/24 address prefix. This process occurs because 10.0.0.0/24 is a longer prefix than 10.0.0.0/16, even though 10.0.0.5 falls within both address prefixes.

Azure directs traffic destined for 10.0.1.5 to the next hop type specified in the route with the 10.0.0.0/16 address prefix. This process occurs because 10.0.1.5 isn't included in the 10.0.0.0/24 address prefix, which makes the route with the 10.0.0.0/16 address prefix the longest matching prefix.

If multiple routes contain the same address prefix, Azure selects the route type based on the following priority:

1.  User-defined route
2.  BGP route
3.  System route

> [!NOTE]
> System routes for traffic related to virtual network, virtual network peerings, or virtual network service endpoints are preferred routes. They're preferred, even if BGP routes are more specific. Routes with a virtual network service endpoint as the next hop type can't be overridden, even when you use a route table.

For example, a route table contains the following routes:

Expand table

| **Source** | **Address prefixes** | **Next hop type**       |
| ---------- | -------------------- | ----------------------- |
| Default    | 0.0.0.0/0            | Internet                |
| User       | 0.0.0.0/0            | Virtual network gateway |

When traffic is destined for an IP address outside the address prefixes of any other routes in the route table, Azure selects the route with the User source. Azure makes this choice because UDRs are a higher priority than system default routes.

For a comprehensive routing table with explanations of the routes in the table, see [Routing example](/azure/virtual-network/virtual-networks-udr-overview#routing-example).

## 0.0.0.0/0 address prefix

A route with the 0.0.0.0/0 address prefix gives instructions to Azure. Azure uses these instructions to route traffic destined for an IP address that doesn't fall within the address prefix of any other route in a subnet's route table. When a subnet is created, Azure creates a [default](/azure/virtual-network/virtual-networks-udr-overview#default) route to the 0.0.0.0/0 address prefix, with the Internet next hop type. If you don't override this route, Azure routes all traffic destined to IP addresses not included in the address prefix of any other route to the internet.

The exception is that traffic to the public IP addresses of Azure services remains on the Azure backbone network and isn't routed to the internet. When you override this route with a [custom](/azure/virtual-network/virtual-networks-udr-overview#custom-routes) route, traffic destined for addresses not within the address prefixes of any other route in the route table is directed. The destination depends on whether you specify a network virtual appliance or virtual network gateway in the custom route.

When you override the 0.0.0.0/0 address prefix, outbound traffic from the subnet flows through the virtual network gateway or virtual appliance. The following changes also occur with Azure default routing:

 -  Azure sends all traffic to the next hop type specified in the route, including traffic destined for public IP addresses of Azure services.
    
    When the next hop type for the route with the 0.0.0.0/0 address prefix is Internet, traffic from the subnet destined to the public IP addresses of Azure services never leaves the Azure backbone network, regardless of the Azure region in which the virtual network or Azure service resource exist.
    
    When you create a UDR or a BGP route with a Virtual network gateway or Virtual appliance next hop type, all traffic is sent to the next hop type specified in the route. This includes traffic sent to public IP addresses of Azure services for which you haven't enabled [service endpoints](/azure/virtual-network/virtual-network-service-endpoints-overview).
    
    When you enable a service endpoint for a service, Azure creates a route with address prefixes for the service. Traffic to the service doesn't route to the next hop type in a route with the 0.0.0.0/0 address prefix. The address prefixes for the service are longer than 0.0.0.0/0.
 -  You can no longer directly access resources in the subnet from the internet. You can access resources in the subnet from the internet indirectly. The device specified by the next hop type for a route with the 0.0.0.0/0 address prefix must process inbound traffic. After the traffic traverses the device, the traffic reaches the resource in the virtual network. If the route contains the following values for the next hop type:
    
    
     -  Virtual appliance: The appliance must:
        
        
         -  Be accessible from the internet.
         -  Have a public IP address assigned to it.
         -  Not have a network security group rule associated to it that prevents communication to the device.
         -  Not deny the communication.
         -  Be able to network address translate and forward, or proxy the traffic to the destination resource in the subnet and return the traffic back to the internet.
     -  Virtual network gateway: If the gateway is an ExpressRoute virtual network gateway, an internet-connected device on-premises can network address translate and forward, or proxy the traffic to the destination resource in the subnet, via ExpressRoute [private peering](/azure/expressroute/expressroute-circuit-peerings?toc=/azure/virtual-network/toc.json#privatepeering).

If your virtual network is connected to an Azure VPN gateway, don't associate a route table to the [gateway subnet](/azure/vpn-gateway/vpn-gateway-about-vpn-gateway-settings?toc=/azure/virtual-network/toc.json#gwsub) that includes a route with a destination of 0.0.0.0/0. Doing so can prevent the gateway from functioning properly. For more information, see [Why are certain ports opened on my VPN gateway?](/azure/vpn-gateway/vpn-gateway-vpn-faq?toc=/azure/virtual-network/toc.json#gatewayports).

For implementation details when you use virtual network gateways between the internet and Azure, see [DMZ between Azure and your on-premises datacenter](/azure/architecture/reference-architectures/dmz/secure-vnet-hybrid?toc=%2fazure%2fvirtual-network%2ftoc.json).

## Routing example

To illustrate the concepts in this article, the following sections describe:

 -  A scenario, with requirements.
 -  The custom routes that are necessary to meet the requirements.
 -  The route table that exists for one subnet that includes the default and custom routes that are necessary to meet the requirements.

> [!NOTE]
> This example isn't intended to be a recommended or best practices implementation. It's provided only to illustrate concepts in this article.

### Requirements

1.  Implement two virtual networks in the same Azure region and enable resources to communicate between the virtual networks.
2.  Enable an on-premises network to communicate securely with both virtual networks through a VPN tunnel over the internet. *Alternatively, you can use an ExpressRoute connection, but this example uses a VPN connection.*
3.  For one subnet in one virtual network:
    
    
     -  Route all outbound traffic from the subnet through a network virtual appliance for inspection and logging. Exclude traffic to Azure Storage and within the subnet from this routing.
     -  Don't inspect traffic between private IP addresses within the subnet. Allow traffic to flow directly between all resources.
     -  Drop any outbound traffic destined for the other virtual network.
     -  Enable outbound traffic to Azure Storage to flow directly to storage, without forcing it through a network virtual appliance.
4.  Allow all traffic between all other subnets and virtual networks.

### Implementation

The following diagram shows an implementation through the Resource Manager deployment model that meets the previous requirements.

> [!NOTE]
> Arrows show the flow of traffic.

### Route tables

Here are the route tables for the preceding routing example.

#### Subnet1

The route table for *Subnet1* in the preceding diagram contains the following routes:

Expand table

| **ID** | **Source** | **State** | **Address prefixes** | **Next hop type**             | **Next hop IP address** | **UDR name**   |
| ------ | ---------- | --------- | -------------------- | ----------------------------- | ----------------------- | -------------- |
| 1      | Default    | Invalid   | 10.0.0.0/16          | Virtual network               |                         |                |
| 2      | User       | Active    | 10.0.0.0/16          | Virtual appliance             | 10.0.100.4              | Within-VNet1   |
| 3      | User       | Active    | 10.0.0.0/24          | Virtual network               |                         | Within-Subnet1 |
| 4      | Default    | Invalid   | 10.1.0.0/16          | Virtual network peering       |                         |                |
| 5      | Default    | Invalid   | 10.2.0.0/16          | Virtual network peering       |                         |                |
| 6      | User       | Active    | 10.1.0.0/16          | None                          |                         | ToVNet2-1-Drop |
| 7      | User       | Active    | 10.2.0.0/16          | None                          |                         | ToVNet2-2-Drop |
| 8      | Default    | Invalid   | 10.10.0.0/16         | Virtual network gateway       | \[X.X.X.X\]             |                |
| 9      | User       | Active    | 10.10.0.0/16         | Virtual appliance             | 10.0.100.4              | To-On-Prem     |
| 10     | Default    | Active    | \[X.X.X.X\]          | VirtualNetworkServiceEndpoint |                         |                |
| 11     | Default    | Invalid   | 0.0.0.0/0            | Internet                      |                         |                |
| 12     | User       | Active    | 0.0.0.0/0            | Virtual appliance             | 10.0.100.4              | Default-NVA    |

Here's an explanation of each route ID:

 -  ID1: Azure automatically added this route for all subnets within *Virtual-network-1* because 10.0.0.0/16 is the only address range defined in the address space for the virtual network. If you don't create the UDR in route ID2, traffic sent to any address between 10.0.0.1 and 10.0.255.254 is routed within the virtual network. This process occurs because the prefix is longer than 0.0.0.0/0 and doesn't fall within the address prefixes of any other routes.
    
    Azure automatically changed the state from Active to Invalid, when ID2, a UDR, was added. It has the same prefix as the default route, and UDRs override default routes. The state of this route is still Active for *Subnet2* because the route table that the UDR, ID2, is in isn't associated to *Subnet2*.
 -  ID2: Azure added this route when a UDR for the 10.0.0.0/16 address prefix was associated to the *Subnet1* subnet in the *Virtual-network-1* virtual network. The UDR specifies 10.0.100.4 as the IP address of the virtual appliance because the address is the private IP address assigned to the virtual appliance virtual machine. The route table in which this route exists isn't associated to *Subnet2*, so the route doesn't appear in the route table for *Subnet2*.
    
    This route overrides the default route for the 10.0.0.0/16 prefix (ID1), which automatically routed traffic addressed to 10.0.0.1 and 10.0.255.254 within the virtual network through the virtual network next hop type. This route exists to meet [requirement](/azure/virtual-network/virtual-networks-udr-overview#requirements) 3, which is to force all outbound traffic through a virtual appliance.
 -  ID3: Azure added this route when a UDR for the 10.0.0.0/24 address prefix was associated to the *Subnet1* subnet. Traffic destined for addresses between 10.0.0.1 and 10.0.0.254 remains within the subnet. The traffic isn't routed to the virtual appliance specified in the previous rule (ID2) because it has a longer prefix than the ID2 route.
    
    This route wasn't associated to *Subnet2*, so the route doesn't appear in the route table for *Subnet2*. This route effectively overrides the ID2 route for traffic within *Subnet1*. This route exists to meet [requirement](/azure/virtual-network/virtual-networks-udr-overview#requirements) 3.
 -  ID4: Azure automatically added the routes in IDs 4 and 5 for all subnets within *Virtual-network-1* when the virtual network was peered with *Virtual-network-2.* *Virtual-network-2* has two address ranges in its address space, 10.1.0.0/16 and 10.2.0.0/16, so Azure added a route for each range. If you don't create the UDRs in route IDs 6 and 7, traffic sent to any address between 10.1.0.1-10.1.255.254 and 10.2.0.1-10.2.255.254 is routed to the peered virtual network. This process occurs because the prefix is longer than 0.0.0.0/0 and doesn't fall within the address prefixes of any other routes.
    
    When you added the routes in IDs 6 and 7, Azure automatically changed the state from Active to Invalid. This process occurs because they have the same prefixes as the routes in IDs 4 and 5, and UDRs override default routes. The state of the routes in IDs 4 and 5 are still Active for *Subnet2* because the route table in which the UDRs in IDs 6 and 7 isn't associated to *Subnet2*. A virtual network peering was created to meet [requirement](/azure/virtual-network/virtual-networks-udr-overview#requirements) 1.
 -  ID5: Same explanation as ID4.
 -  ID6: Azure added this route and the route in ID7 when UDRs for the 10.1.0.0/16 and 10.2.0.0/16 address prefixes were associated to the *Subnet1* subnet. Azure drops traffic destined for addresses between 10.1.0.1-10.1.255.254 and 10.2.0.1-10.2.255.254, rather than being routed to the peered virtual network, because UDRs override default routes. The routes aren't associated to *Subnet2*, so the routes don't appear in the route table for *Subnet2*. The routes override the ID4 and ID5 routes for traffic leaving *Subnet1*. The ID6 and ID7 routes exist to meet [requirement](/azure/virtual-network/virtual-networks-udr-overview#requirements) 3 to drop traffic destined to the other virtual network.
 -  ID7: Same explanation as ID6.
 -  ID8: Azure automatically added this route for all subnets within *Virtual-network-1* when a VPN type virtual network gateway was created within the virtual network. Azure added the public IP address of the virtual network gateway to the route table. Traffic sent to any address between 10.10.0.1 and 10.10.255.254 is routed to the virtual network gateway. The prefix is longer than 0.0.0.0/0 and not within the address prefixes of any of the other routes. A virtual network gateway was created to meet [requirement](/azure/virtual-network/virtual-networks-udr-overview#requirements) 2.
 -  ID9: Azure added this route when a UDR for the 10.10.0.0/16 address prefix was added to the route table associated to *Subnet1*. This route overrides ID8. The route sends all traffic destined for the on-premises network to a network virtual appliance for inspection, rather than routing traffic directly on-premises. This route was created to meet [requirement](/azure/virtual-network/virtual-networks-udr-overview#requirements) 3.
 -  ID10: Azure automatically added this route to the subnet when a service endpoint to an Azure service was enabled for the subnet. Azure routes traffic from the subnet to a public IP address of the service, over the Azure infrastructure network. The prefix is longer than 0.0.0.0/0 and not within the address prefixes of any of the other routes. A service endpoint was created to meet [requirement](/azure/virtual-network/virtual-networks-udr-overview#requirements) 3 to enable traffic destined for Azure Storage to flow directly to Azure Storage.
 -  ID11: Azure automatically added this route to the route table of all subnets within *Virtual-network-1* and *Virtual-network-2.* The 0.0.0.0/0 address prefix is the shortest prefix. Any traffic sent to addresses within a longer address prefix are routed based on other routes.
    
    By default, Azure routes all traffic destined for addresses other than the addresses specified in one of the other routes to the internet. Azure automatically changed the state from Active to Invalid for the *Subnet1* subnet when a UDR for the 0.0.0.0/0 address prefix (ID12) was associated to the subnet. The state of this route is still Active for all other subnets within both virtual networks because the route isn't associated to any other subnets within any other virtual networks.
 -  ID12: Azure added this route when a UDR for the 0.0.0.0/0 address prefix was associated to the *Subnet1* subnet. The UDR specifies 10.0.100.4 as the IP address of the virtual appliance. This route isn't associated to *Subnet2*, so the route doesn't appear in the route table for *Subnet2*. All traffic for any address not included in the address prefixes of any of the other routes is sent to the virtual appliance.
    
    The addition of this route changed the state of the default route for the 0.0.0.0/0 address prefix (ID11) from Active to Invalid for *Subnet1* because a UDR overrides a default route. This route exists to meet [requirement](/azure/virtual-network/virtual-networks-udr-overview#requirements) 3.

#### Subnet2

The route table for *Subnet2* in the preceding diagram contains the following routes:

Expand table

| **Source** | **State** | **Address prefixes** | **Next hop type**       | **Next hop IP address** |
| ---------- | --------- | -------------------- | ----------------------- | ----------------------- |
| Default    | Active    | 10.0.0.0/16          | Virtual network         |                         |
| Default    | Active    | 10.1.0.0/16          | Virtual network peering |                         |
| Default    | Active    | 10.2.0.0/16          | Virtual network peering |                         |
| Default    | Active    | 10.10.0.0/16         | Virtual network gateway | \[X.X.X.X\]             |
| Default    | Active    | 0.0.0.0/0            | Internet                |                         |
| Default    | Active    | 10.0.0.0/8           | None                    |                         |
| Default    | Active    | 100.64.0.0/10        | None                    |                         |
| Default    | Active    | 192.168.0.0/16       | None                    |                         |

The route table for *Subnet2* contains all Azure-created default routes and the optional virtual network peering and virtual network gateway optional routes. Azure added the optional routes to all subnets in the virtual network when the gateway and peering were added to the virtual network.

Azure removed the routes for the 10.0.0.0/8, 192.168.0.0/16, and 100.64.0.0/10 address prefixes from the *Subnet1* route table when the UDR for the 0.0.0.0/0 address prefix was added to *Subnet1*.
