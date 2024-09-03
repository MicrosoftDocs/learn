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

**Azure PowerShell**

```powershell
$param = @{ Name = 'StorageRoute' AddressPrefix = 'Storage' NextHopType = 'VirtualAppliance' NextHopIpAddress = '10.0.100.4' } New-AzRouteConfig @param







```

The same command for CLI is as follows:

**Azure CLI**

```azurecli
az network route-table route create \ --resource-group MyResourceGroup \ --route-table-name MyRouteTable \ --name StorageRoute \ --address-prefix Storage \ --next-hop-type VirtualAppliance \ --next-hop-ip-address 10.0.100.4







```
