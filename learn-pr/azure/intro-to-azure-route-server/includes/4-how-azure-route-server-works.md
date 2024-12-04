As you start getting ready to deploy Azure Route Server within your organization, you need to learn more about how it works. Although Azure Route Server is a fully managed service, it’s important that you understand how it works in various scenarios.

Most commonly, you'd use Azure Route Server with one or more network appliances. For example, you can connect Azure Route Server with a firewall NVA and an SD-WAN appliance, as in the following diagram:

:::image type="content" source="../media/4-route-server-overview.png" alt-text="Diagram showing Azure Route Server in a virtual network that has an app subnet as well as SD-WAN and firewall appliances." border="false":::

This example has one virtual network with the 10.1.0.0/16 address space. Within that network, one application subnet (App subnet) hosts VMs and other resources. The same network also has an Azure Route Server subnet that manages the routing table for the 10.1.0.0/16 address space. Two virtual appliances deployed in the same network are a firewall and an SD-WAN appliance. All internet traffic is routed through the firewall appliance because it manages the default route 0.0.0.0/0.

Another appliance, SD-WAN, manages the connection to the on-premises network with the 10.250.0.0/16 address space. Two appliances, SD-WAN and firewall, are configured as BGP peers for Azure Route Server. Because of that, their routing tables are propagated to Azure Route Server. Also, the routing table for the 10.1.0.0/16 network is propagated to network appliances. Because Azure Route Server is configured in the same virtual network as VMs, these routes are then automatically configured on the VMs in the virtual network.

As a result, when a VM from the App subnet needs to communicate to a resource located in an on-premises network, it’ll know that traffic should be sent to the SD-WAN appliance. If it wants to, it’ll access the internet through the default route managed by the firewall appliance. As the SD-WAN appliance has information about routes for the 10.1.0.0./16 address space, any resource located on-premises will be able to communicate to resources in the App subnet. Whenever a change happens to routes or address spaces in any component connected to Azure Route Server, it will propagate to all the appliances and routing tables automatically.

Let’s review how traffic through SD-WAN NVA is controlled when Azure Route Server is deployed. In the following scenario, Azure Route Server enables path selection, which allows you to configure your SD-WAN NVA to have a routing preference when communicating with your on-premises network. When SD-WAN NVA is used with Azure Route Server to establish a connection to an on-premises network, the path can be established in two ways, like the following diagram depicts:

:::image type="content" source="../media/4-routing-preference.png" alt-text="Diagram showing two paths for connecting Azure resources to a local network. One path is over the Microsoft backbone, while another path uses ISP infrastructure." border="false":::

Routing preference lets you choose how your traffic routes between Azure and the internet. You can choose to route traffic either through the Microsoft network backbone or the ISP network (public internet). These options are also referred to as *cold potato routing* and *hot potato routing*, respectively.

When you deploy an SD-WAN NVA in the same virtual network as the Azure Route Server, it’s configured with a *Microsoft network* IP address. The traffic path to your on-premises network will use the Microsoft global network and as a result exit the Microsoft network that’s closest to the destination. The routing from your on-premises network will enter the Microsoft network that’s closest to the user on the return path. This method of routing is performance-optimized and provides the best possible experience at a cost.

As a way to optimize for cost, a second method of routing is performed by assigning your SD WAN NVA with an *internet* IP address. When traffic is routed to your on-premises network, it will exit the Microsoft network in the same region the service is hosted. It’ll then route through the internet by using the ISP's network. The routing from on-premises will enter the Microsoft network closest to the hosted service region. This method of routing will provide the best overall price when completing a task such as transferring large amount of data.

## Azure Route Server integration with ExpressRoute and Azure VPN

In some scenarios, you'd implement Azure Route Server in virtual networks with an ExpressRoute gateway or Azure VPN Gateway, as demonstrated in the following diagram:

:::image type="content" source="../media/4-expressroute-vpn-route-server.png" alt-text="Diagram showing implementation of Azure Route Server in virtual networks with Express Route gateway or Azure VPN gateway." border="false":::

In this case, Azure VPN Gateway and ExpressRoute gateway are used to connect to on-premises networks. However, unlike NVA objects — which you configure as BGP peers to Azure Route Server — you don’t need to configure or manage the BGP peering between the gateway and Azure Route Server. Instead, you should enable route exchange between the gateway and Azure Route Server. To do this, configure the following setting in the **Configuration** page of Azure Route Server in the Azure portal:

:::image type="content" source="../media/4-branch.png" alt-text="Screenshot of the branch-to-branch setting enabled.":::

Alternatively, you can enable route exchange between Azure Route Server and the gateway (or gateways) by using the **Update-AzRouteServer** cmdlet with the *-AllowBranchToBranchTraffic* flag.

After you do this, routing information exchanges between ExpressRoute gateway and Azure VPN Gateway through Azure Route Server. This means that Azure VPN Gateway will receive routes for the On-premises 2 network, and ExpressRoute gateway will receive routes for the On-premises 1 network. However, both gateways will also receive routes for the virtual network where Azure Route Server is located.

## Azure Route Server pricing

Azure Route Server is a typical pay-per-use service. It has no upfront cost of any kind, nor does it have any termination fees. You pay for this service only while it’s active.
