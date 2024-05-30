Part of the planning for your Azure network solution includes exploring how to support outbound network connectivity and traffic communication routing.

Around the globe, IPv4 address ranges are in short supply. Trying to purchase an IP address in the v4 range can be an expensive way to grant access to your internet resources. To address this issue, architects use Network Address Translation (NAT) to enable internal resources on a private network to share routable IPv4 addresses. The internal resources use the routable IPv4 addresses to access external resources on a public network. Instead of buying an IPv4 address for each resource that needs internet access, you can use a NAT service to map outgoing requests from your internal resources to external IP addresses. Azure provides this technology via the Azure Virtual Network NAT service.

Azure [routes communication traffic](/azure/virtual-network/virtual-networks-udr-overview) between your on-premises internal resources and external internet resources by using _route tables_. When you create a virtual network, Azure automatically creates a routing table for each subnet in the network. A routing table contains many different types of routes, including system, service endpoints, and subnet defaults. The table also has route entries for the Border Gateway Protocol (BGP), user-defined routes (UDRs), and routes from other virtual networks.

### Azure Virtual Network NAT

[Azure Virtual Network NAT](/azure/virtual-network/nat-gateway/nat-overview) simplifies outbound-only internet connectivity for virtual networks. When you configure this service on a subnet, all outbound connectivity uses your specified static public IP addresses. Outbound connectivity is possible without load balancer or public IP addresses directly attached to virtual machines. Virtual Network NAT is fully managed and highly resilient. 

#### Business scenarios

- Support on-demand outbound-to-internet connectivity without pre-allocation
- Configure one or more static public IP addresses for scale
- Enable configurable idle timeout
- Allow TCP reset for unrecognized connections

### Things to know about routing tables and routes

Let's take a closer look at the characteristics of routing tables and the route types.

- **System routes**: When you create a virtual network for the first time without defining any subnets, Azure creates system route entries in the routing table. System routes are defined for a specific location when they're created. System routes can't be modified after they're created, but you can override these routes by configuring UDRs.

- **User-defined routes (custom)**: When you create one or multiple subnets inside a virtual network, Azure creates default entries in the routing table to enable communication between these subnets within a virtual network. These routes can be modified by using static routes, which are stored as UDRs in Azure. UDRs are also called _custom routes_. You create UDRs in Azure to override Azure's default system routes, or to add more routes to a subnet's route table. 

- **Routes from other virtual networks**: When you create a virtual network peering between two virtual networks, a route is added for each address range within the address space of each peered virtual network.

- **Border Gateway Protocol routes**: If your on-premises network gateway exchanges BGP routes with an Azure Virtual Network gateway, a route is added for each route propagated from the on-premises network gateway. These routes appear in the routing table as BGP routes.

- **Service endpoint routes**: The public IP addresses for certain services are added to the route table by Azure when you enable a service endpoint to the service. Service endpoints are enabled for individual subnets within a virtual network. When you enable a service endpoint, a route is only added to the route table for the subnet that belongs to this service. Azure manages the addresses in the route table automatically when the addresses change.

- **Routing order**: When you have competing entries in a routing table, Azure selects the next hop based on the longest prefix match similar to traditional routers. If there are multiple next hop entries with the same address prefix, Azure selects routes in a specific order: UDRs, then BGP routes, and then system routes.

### Things to consider when using routing tables and routes

There are many networking scenarios where defining and overriding routes can be an advantage. Review the following suggestions and consider the routes required to support the Tailwind Traders solution.

- **Consider system routes**. Define system routes for specific locations and scenarios that you don't expect to modify.
   - Route traffic between virtual machines in the same virtual network or between peered virtual networks
   - Support communication between virtual machines by using a virtual network-to-network VPN
   - Enable site-to-site communication through Azure ExpressRoute or an Azure VPN gateway

- **Consider user defined routes**. Create custom UDRs to override Azure's default system routes, or to add more routes to a subnet's route table.
   - Enable filtering of internet traffic by using Azure Firewall or forced tunneling
   - Flow traffic between subnets through an NVA
   - Define routes to specify how packets should be routed in a virtual network
   - Define routes that control network traffic and specify the next hop in the traffic flow

- **Consider overriding routes**. Plan for route overrides to control traffic flow.
   - Flow through NVA: [Configure route tables to force traffic between subnets to flow through an NVA](/azure/virtual-network/tutorial-create-route-table-portal)
   - Forced tunneling: [Force all internet-bound traffic through an NVA, or on-premises, through an Azure VPN gateway](/azure/vpn-gateway/vpn-gateway-forced-tunneling-rm)