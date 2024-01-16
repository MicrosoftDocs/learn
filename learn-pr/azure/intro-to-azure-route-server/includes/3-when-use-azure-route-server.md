To be sure whether Azure Route Server is the correct solution for your current scenario and infrastructure, you first need to identify the issue you want to resolve in the context of your network infrastructure and routing within that infrastructure. You also need to identify the scenarios in which Azure Route Server is an appropriate solution.

## Appropriate scenarios for Azure Route Server

Azure Route Server isn’t a router service. It doesn’t route traffic or provide gateway functionalities to Azure virtual networks. However, it helps you simplify the routing in your infrastructure and make it more efficient by automatically learning about available routes and subnets from its peers, and by distributing routes between various appliances and network services. This reduces the need for manual routing updates, which can be quite complex in some scenarios. For example, if you have several subnets in your virtual networks and one or more NVAs that manage separate address spaces, you need to manually provide routes to your virtual subnet so that the resources deployed there can access resources behind NVAs.

In another example, you might have an Azure site-to-site virtual private network (VPN) deployed for your virtual network so it can access your on-premises network resources, and Azure Express Route to enable direct and more secure connections between another local network and Azure. These two services can exchange their routes by using BGP peering with Azure Route Server. It’s similar to a scenario where you have an SD-WAN appliance that connects to another network outside of the Azure environment. You can connect that appliance to Azure Route Server and provide routes to the rest of your virtual network in Azure and to other networks that are peering with Azure Route Server.

The following diagram depicts a network infrastructure layout that’s a good example for deploying Azure Route Server:

:::image type="content" source="../media/3-network-infrastructure.png" alt-text="Diagram of a network infrastructure layout with Azure Route Server deployed in RouteServerSubnet /27." border="false":::

One more scenario when Azure Route Server usage is appropriate is when you have your NVAs and Azure Route Server in a hub-and-spoke topology. This means that Azure Route Server is deployed in a spoke virtual network that peers with virtual networks where NVAs are deployed as depicted in the following diagram:

:::image type="content" source="../media/3-dual-homed-topology.png" alt-text="Diagram of Azure Route Server in a dual-homed topology." border="false":::

In this scenario, when virtual networks with NVAs are peering with a virtual network that has Azure Route Server deployed, you can establish BGP peering between NVAs and Azure Route Server. If the NVA and Azure Route Server are deployed in the same virtual network, they will exchange routes. The NVA will learn about spoke virtual network addresses from Azure Route Server, which will learn routes from each of the NVAs. Azure Route Server will then program all the VMs in the spoke virtual network with the routes it learned. In the data plane, VMs in the spoke virtual network will notice the security NVA or the VPN NVA in the hub as the next hop. Traffic destined for the internet-bound traffic, or the hybrid cross-premises traffic will now route through the NVAs in the hub virtual network.

## Scenarios that aren’t appropriate for Azure Route Server

In general, you wouldn’t want to use Azure Route Server in simple network environments where no NVAs, ExpressRoute gateway, or site-to-site VPN components are deployed. If you just have multiple virtual networks deployed, you can easily establish peering between these networks, and there is no need to deploy Azure Route Server.

Also, you shouldn’t confuse Azure Route Server with a router, because it doesn’t have router functionalities. Therefore, you shouldn’t deploy Azure Route Server to route or forward data between networks. Azure Route Server never manages data traffic, it just provides route exchange.
