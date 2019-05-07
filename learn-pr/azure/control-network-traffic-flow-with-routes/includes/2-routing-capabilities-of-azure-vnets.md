As part of the project to control the flow of traffic within your virtual network, you need to understand the purpose and benefits of custom routes and how to configure them to direct the flow of traffic through an NVA.

## Azure Routing

By default, network traffic in Azure is automatically routed across Azure subnets, virtual networks, and on-premises networks. This routing is controlled by **system routes** which are assigned by default to each subnet in a virtual network. 

This means that, by default, any Azure virtual machine deployed to a virtual network can communicate with all other Azure virtual machines in the same or different subnets. These virtual machines are also potentially accessible from on-premises through a hybrid network or the Internet. 

You can't create or delete system routes, but you can over-ride the system routes by adding custom routes to control the flow of traffic to the next hop.

Every subnet has these default system routes:

|Source     |Address prefixes  |Next hop type |
|---------|---------|---------|
|Default |Unique to the virtual network    | Virtual network |
|Default |0.0.0.0/0     | Internet        |
|Default |10.0.0.0/8     | None        |
|Default |172.16.0.0/12 | None |
|Default |192.168.0.0/16 | None        |
|Default |100.64.0.0/10 | None        |

The **next hop type** shows the network path taken by traffic sent to each address prefix.

- **Virtual Network**. A route is created in the address prefix which represents each address range created at the virtual network level. If there are multiple address ranges specified, then multiple routes are created for each address range.
- **Internet**. The default system route of 0.0.0.0/0 routes any address range to the Internet unless you override Azure's default route with a custom route.
- **None**. Any traffic routed to the hop type of **None,** is dropped, and does not get routed outside the subnet. By default, the following IP v4 private address prefixes are created: 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16. The shared address space prefix, 100.64.0.0/10 is also added with a next hop of None. All these address ranges are considered to be not globally routable.

   You can replace these default address prefixes by assigning your own address range, and Azure will replace one of the default prefixes with the one you specify with a hop type of **Virtual network**.

The diagram below gives an overview of system routes and how traffic flows between subnets and the internet by default. You can see from the diagram that traffic flows freely between the 2 subnets and the Internet.

![Traffic between subnets and Internet](../media/2-system-routes-subnets-internet.png)

Within Azure there are additional system routes which Azure will create if you enable the following capabilities:

- Virtual network peering (virtual network Peering)
- Service chaining

Both of these services allow virtual networks within Azure to be peered together (connected) to allow virtual machines to communicate with each other, either within the same region or across regions.  This in turn creates additional routes within the default route table.  
You can override these routes by using a feature called service chaining where you can create UDR's between peered networks.

Below diagram shows 2 virtual networks with peering configured, but with UDRs configured to route traffic through an NVA or a VPN Gateway.

![virtual network peering with UDRs](../media/2-virtual network-peering-udrs.png)

- Virtual Network Gateway
  - Used to send encrypted traffic between Azure and on-premises over the internet, but you can use Virtual Network Gateway to send encrypted traffic between Azure networks too
  - Virtual Network Gateways contain routing tables and gateway services

![Virtual Network Gateway](../media/2-virtual network-gateway.png)
<!-- DONE -- cut down this section, make it a summary as we don't want overlap with your nsg module -->
- VirtualNetworkServiceEndpoint
  - Virtual Network endpoints are used to extend your private address space in Azure by providing a direct connection to your Azure resources. 
This process will restrict the flow of traffic and allow your Azure virtual machines to access the Storage account directly from the private address space and deny access from a public virtual machine.  

![cid:image002.jpg\@01D4EC0A.D7243750](media/image6.jpeg){width="6.5in" height="2.2604166666666665in"}

This is what you get after add a service endpoint to the virtual network

![cid:image003.jpg\@01D4EC0A.D7243750](media/image7.jpeg){width="6.5in" height="2.7604166666666665in"}

For every default route that is created there is an address space and next hop type associated with that route, which Azure will use to route the traffic

System routes may make it easy for you to quickly get your environment up and running, but there will be many scenarios in which you will want to control the flow of traffic within your network, for example routing traffic through a network virtual appliance or 3^rd^ party firewall or router. This is possible by UDR's (user defined routes)

## Custom Routes
You have two options for custom routes. You can create a user-defined route, or use Border Gateway Protocol (BGP) to exchange routes between Azure and on-premises networks.

### User-defined routes
You use a user-defined route to over-ride the default system routes so that traffic can be routed through firewalls or network virtual appliances. For example, you have a network with two subnets and you want to add a virtual machine in the perimeter network to be used as a firewall. You create a user-defined route so that traffic passes through the firewall and does not go directly between the subnets.

When creating user-defined routes, you can specify these next hop types:

- **Virtual appliance**. A virtual appliance is typically a firewall device, used to analyze or filter traffic entering or leaving your network. You must specify the private IP address of a NIC attached to a virtual machine so that IP forwarding can be enabled, or the private IP address of an internal load balancer.
- **Virtual network gateway**. You can specify when you want routes for a specific address routed to a virtual network gateway. The virtual network gateway is specified as a VPN for next hop type
- **None**. When you want to drop traffic to a specific address prefix
- **Virtual Network**. When you want to override the default system route within a virtual network
- **Internet**. When you want to route traffic to a certain address prefix to be routed out to the internet

With user-defined routes, you are not able to specify virtual network Peering, VirtualNetworkServiceEndpoint as the next hop types. 

## Border gateway protocol

A network gateway in your on-premises network can exchange routes with a virtual network gateway in Azure by using border gateway protocol (BGP).

BGP can be used to advertise on-premises routes to Azure whether you connect using Express Route or by using a VPN. These routes are added to the routing table in Azure with **Virtual network gateway** as the next hop type.

BGP is a routing protocol used to exchange routing information between two or more networks. With BGP there is no need for routers or to manually configure routes because BGP can identify the routes which are connected via Site-to-Site VPN connections.

The below diagram shows a topology with paths that can transit between Azure VPN Gateway and on-premises networks

![Border Gateway Protocol](../media/2-bgp.png)
<!-- TODO can you rewrite these paragraphs, to be a bit clearer; e.g. what do we mean by "propagating prefixes"? -->
BGP (Border Gateway Protocol) is the standard routing protocol that is normally used to exchange routing and information between 2 or more networks.  BGP is used to transfer data and information between different host gateways such as the Internet or autonomous systems. BGP discovers prefixes (prefixes are subnets for example, 10.0.0.0/16) from various networks by enabling connections from multiple gateways, which allows BGP gateways to learn of routes from other BGP peers.  These routes are then used to transfer data between gateways or routers.

BGP offers network stability because routers can quickly change connections to send packets if a connection path goes down. BGP makes routing decisions based on paths, rules or network policies. Each BGP router/gateway manages a local routing table to direct packets in transit, but this is used in conjunction with a routing table called routing information base (RIB). The Routing information base (RIB) contains route information from externally connected BGP peers and internal peers.
BGP works with Azure Virtual Networks and communicates with Azure VPN Gateways and your on-premise VPNs.  This allows both Azure VPNs and on-premise VPNs to exchange routes between each other so that they inform the gateways on the availability and reachability of these routes.  
However, before enabling the BGP feature, you should make sure the VPN devices support BGP.

> [!IMPORTANT]
> BGP is not supported on Basic SKU Azure VPN Gateways.

BGP supports the below topologies:

- RAS VPN Site to Site Gateway with BGP
- Third party Gateway with BGP
- Multiple Enterprise Sites with third party gateways
- Separate termination points for BGP and VPN

## Knowledge test objectives

- Custom routes -- What is the purpose of a custom route?
- virtual network Peering -- Describe the purpose of virtual network Peering?
- What is the role of a Virtual Network Gateway?