## Virtual network

Azure Virtual Network (VNet) is the fundamental building block for your private network in Azure. You can use a VNets to:

- **Communicate between Azure resources**: You can deploy VMs, and several other types of Azure resources to a virtual network, such as Azure App Service Environments, the Azure Kubernetes Service (AKS), and Azure Virtual Machine Scale Sets. 

- **Communicate between each other**: You can connect virtual networks to each other, enabling resources in either virtual network to communicate with each other, using virtual network peering. The virtual networks you connect can be in the same, or different, Azure regions. 

- **Communicate to the internet**: All resources in a VNet can communicate outbound to the internet, by default. You can communicate inbound to a resource by assigning a public IP address or a public Load Balancer. You can also use [Public IP addresses](/azure/virtual-network/virtual-network-public-ip-address) or public [Load Balancer](/azure/load-balancer/load-balancer-overview) to manage your outbound connections.

- **Communicate with on-premises networks**: You can connect your on-premises computers and networks to a virtual network using [VPN Gateway](/azure/vpn-gateway/vpn-gateway-about-vpngateways) or [ExpressRoute](/azure/expressroute/expressroute-introduction).

When you design a network from bottom up, you gather some basic information. This information could be number of hosts, network devices, number of subnets, routing between subnets, isolation domains such as VLANs. This information helps in sizing the network and security devices as well creating the architecture to support applications and services.

When you plan to deploy your applications and services in Azure, you will start by creating a logical boundary in Azure, which is called a virtual network. This virtual network is akin to a physical network boundary. As it is a virtual network, you don't need physical gear but still have to plan for the logical entities such as IP addresses, IP subnets, routing, and policies.

When you create a virtual network in Azure, it's pre-configured with an IP range (10.0.0.0/16). This range isn't fixed, you can define your own IP range. You can define both IPv4 and IPv6 address ranges. IP ranges defined for the virtual network are not advertised to Internet. You can create multiple subnets from your IP range. These subnets will be used to assign IP addresses to virtual network interfaces (vNICs). First four IP addresses from each subnet are reserved and can't be used for IP allocation. There is no concept of VLANs in a public cloud. However, you can create isolation within a virtual network based on your defined subnets.

You can create one large subnet encompassing all the virtual network address space or choose to create multiple subnets. However, if you are using a virtual network gateway, Azure requires you to create a subnet with the name "gateway subnet". Azure will use this subnet to assign IP addresses to virtual network gateways.

A virtual network is a virtual, isolated portion of the Azure public network. Each virtual network is dedicated to your subscription. Things to consider when deciding whether to create one virtual network, or multiple virtual networks in a subscription:

- Do any organizational security requirements exist for isolating traffic into separate virtual networks? You can choose to connect virtual networks or not. If you connect virtual networks, you can implement a network virtual appliance, such as a firewall, to control the flow of traffic between the virtual networks. For more information, see [security](/azure/virtual-network/virtual-network-vnet-plan-design-arm?toc=/azure/networking/fundamentals/toc.json) and [connectivity](/azure/virtual-network/virtual-network-vnet-plan-design-arm?toc=/azure/networking/fundamentals/toc.json).

- Do any organizational requirements exist for isolating virtual networks into separate [subscriptions](/azure/virtual-network/virtual-network-vnet-plan-design-arm?toc=/azure/networking/fundamentals/toc.json) or [regions](/azure/virtual-network/virtual-network-vnet-plan-design-arm?toc=/azure/networking/fundamentals/toc.json)?

- A [network interface](/azure/virtual-network/virtual-network-network-interface) enables a VM to communicate with other resources. Each network interface has one or more private IP addresses assigned to it. How many network interfaces and [private IP addresses](/azure/virtual-network/private-ip-addresses) do you require in a virtual network? There are [limits](/azure/azure-resource-manager/management/azure-subscription-service-limits?toc=/azure/virtual-network/toc.json) to the number of network interfaces and private IP addresses that you can have within a virtual network.

[Here are more questions to consider](/azure/virtual-network/virtual-network-vnet-plan-design-arm?toc=/azure/networking/fundamentals/toc.json) when designing an Azure virtual network. 

## Design network segmentation 

Segmentation is a model in which you take your networking footprint and create software defined perimeters using tools available in Microsoft Azure. You then set rules that govern the traffic from/to these perimeters so that you can have different security postures for various parts of your network. When you place different applications (or parts of a given application) into these perimeters, you can govern the communication between these segmented entities. If a part of your application stack is compromised, you'll be better able to contain the impact of this security breach and prevent it from laterally spreading through the rest of your network. This ability is a key principle associated with the [Zero Trust model published by Microsoft](https://www.microsoft.com/security/blog/2019/10/23/perimeter-based-network-defense-transform-zero-trust-model/) that aims to bring world-class security thinking to your organization.

When you operate on Azure, you have a wide and diverse set of segmentation options available to help you be protected.

1. [**Subscription**](/azure/cost-management-billing/manage/create-subscription)**:** Subscriptions are a high-level construct, which provides platform powered separation between entities. It's intended to carve out boundaries between large organizations within a company. Communication between resources in different subscriptions needs to be explicitly provisioned.

2. [**Virtual Network**](/azure/virtual-network/virtual-networks-overview)**:** Virtual networks are created within a subscription in private address spaces. The networks provide network-level containment of resources, with no traffic allowed by default between any two virtual networks. Like subscriptions, any communication between virtual networks needs to be explicitly provisioned.

3. [**Network Security Groups (NSG)**](/azure/virtual-network/security-overview)**:** NSGs are access control mechanisms for controlling traffic between resources within a virtual network. An NSG also controls traffic with external networks, such as the internet, other virtual networks, and so on. NSGs can take your segmentation strategy to a granular level by creating perimeters for a subnet, group of VMs, or even a single virtual machine.

4. [**Application Security Groups (ASGs)**](/azure/virtual-network/application-security-groups)**:** An ASG allows you to group a set of VMs under an application tag. Once an ASG is created and VMs are assigned to it, the ASG can be used as a source or target in the NSG to simplify management.

5. [**Azure Firewall**](/azure/firewall/)**:** Azure Firewall is a cloud native stateful Firewall as a service. This firewall can be deployed in your virtual networks or in [Azure Virtual WAN](/azure/virtual-wan/virtual-wan-about) hub deployments for filtering traffic that flows between cloud resources, the Internet, and on-premise. You create rules or policies (using Azure Firewall or [Azure Firewall Manager](/azure/firewall-manager/overview)) specifying allow/deny traffic using layer 3 to layer 7 controls. You can also filter traffic that goes to the internet using both Azure Firewall and third parties. Direct some or all traffic through third-party security providers for advanced filtering and user protection.

The following three patterns are common when it comes to organizing your workload in Azure from a networking perspective. Each of these patterns provides a different type of isolation and connectivity. Choosing which model works best for your organization is a decision you should make based on your organization's needs. With each of these models, we describe how segmentation can be done using the above Azure Networking services.

### Pattern 1: Single virtual network

In this pattern, all the components of your workload or, in some cases, your entire IT footprint is put inside a single virtual network. This pattern is possible if you're operating solely in a single region since a virtual network can't span multiple regions.

The entities you would most likely use for creating segments inside this virtual network are NSGs,potentially using ASGs to simplify administration. The image below is an example of how such a segmented virtual network would look.

:::image type="content" source="../media/single-azure-region.png" alt-text="Virtual network in a single region.":::



In this setup, you have Subnet1, where you placed your database workloads, and Subnet2, where you've placed your web workloads. You can put NSGs that specify that Subnet1 can talk only with Subnet2, and that Subnet2 can talk to the Internet. You can also take this concept further in the presence of many workloads. Carve out subnets that, for example, won't allow one workload to communicate to the backend of another workload.

Although we used NSGs to illustrate how subnet traffic can be governed, you can also enforce this segmentation by using a Network Virtualized Appliance from Azure Marketplace or Azure Firewall.

### Pattern 2: Multiple virtual networks with peering in between them

This pattern is the extension of the previous pattern where you have multiple virtual networks with potential peering connections. You might opt for this pattern to group applications into separate virtual networks, or you might need presence in multiple Azure regions. You get built-in segmentation through virtual networks because you must explicitly peer a virtual network to another one for them to communicate. (Keep in mind that [virtual network peering](/azure/virtual-network/virtual-network-peering-overview) connectivity isn't transitive.) To further segment within a virtual network in a manner similar to pattern 1, use NSGs in the virtual networks.

:::image type="content" source="../media/multiple-regions.png" alt-text="Azure networks in multiple regions.":::


### Pattern 3: Multiple virtual networks in a hub &amp; spoke model

This pattern is a more advanced virtual network organization where you choose a virtual network in a given region as the hub for all the other virtual networks in that region. The connectivity between the hub virtual network and its spoke virtual networks is achieved by using [Azure virtual network peering](/azure/virtual-network/virtual-network-peering-overview). All traffic passes through the hub virtual network, and it can act as a gateway to other hubs in different regions. You set up your security posture at the hubs, so they get to segment and govern the traffic between the virtual networks in a scalable way. One benefit of this pattern is that. as your network topology grows, the security posture overhead doesn't grow (except when you expand to new regions).

:::image type="content" source="../media/hub-spoke.png" alt-text="Hub and spoke in two Azure regions.":::



The recommended Azure cloud native segmentation control is Azure Firewall. Azure Firewall works across both Virtual Networks and subscriptions to govern traffic flows using layer 3 to layer 7 controls. You can define how your communication rules look (for example, virtual network X can't talk with virtual network Y but can talk with virtual network Z, no Internet for Virtual network X except for access to *.github.com, and so on) and apply it consistently. With Azure Firewall Manager, you can centrally manage policies across multiple Azure Firewalls and enable DevOps teams to further customize local policies.

| Network capabilities| Pattern 1| Pattern 2| Pattern 3 |
| - | - | - | - |
| Connectivity/Routing: how each segment communicates to each other| System routing provides default connectivity to any workload in any subnet| Same as a pattern 1| No default connectivity between spoke virtual networks. A layer 3 router, such as the Azure Firewall, in the hub virtual network is required to enable connectivity. |
| Network level traffic filtering| Traffic is allowed by default. NSG can be used for filtering this pattern.| Same as a pattern 1| Traffic between spoke virtual networks is denied by default. Azure Firewall configuration can enable selected traffic, such as windowsupdate.com. |
| Centralized logging| NSG logs for the virtual network| Aggregate NSG logs across all virtual networks| Azure Firewall logs to Azure Monitor all accepted/denied traffic that is sent via a hub |
| Unintended open public endpoints| DevOps can accidentally open a public endpoint via incorrect NSG rules.| Same as a pattern 1| Accidentally opened public endpoint in a spoke virtual network won't enable access. The return packet will be dropped via stateful firewall (asymmetric routing). |
| Application level protection| NSG provides network layer support only.| Same as a pattern 1| Azure Firewall supports FQDN filtering for HTTP/S and MSSQL for outbound traffic and across virtual networks. |
| Connectivity/Routing: how each segment communicates to each other| System routing provides default connectivity to any workload in any subnet| Same as a pattern 1| No default connectivity between spoke virtual networks. A layer 3 router such as the Azure Firewall in the hub virtual network is required to enable connectivity. |
| | | |  |


 

## Virtual network NAT gateway 

Virtual Network NAT (network address translation) simplifies outbound-only Internet connectivity for virtual networks. When configured on a subnet, all outbound connectivity uses your specified static public IP addresses. Outbound connectivity is possible without load balancer or public IP addresses directly attached to virtual machines. NAT is fully managed and highly resilient. 

:::image type="content" source="../media/flow-map.png" alt-text=" Virtual Network NAT (network address translation) flow diagram.":::

Choose Virtual Network NAT gateway when:
- You need on-demand outbound to internet connectivity without pre-allocation 
- You need one or more static public IP addresses for scale 
- You need configurable idle timeout 
- You need TCP reset for unrecognized connections 

 
## Routing 

When you create a virtual network, Azure creates a routing table for your network. This routing table contains following types of routes.

- System routes

- Subnet default routes

- Routes from other virtual networks

- BGP routes

- Service endpoint routes

- User Defined Routes (UDR)

When you create a virtual network for the first time without defining any subnets, Azure creates routing entries in the routing table. These routes are called system routes. System routes are defined at this location. You cannot modify these routes. However, you can override systems routes by configuring UDRs.

When you create one or multiple subnets inside a virtual network, Azure creates default entries in the routing table to enable communication between these subnets within a virtual network. These routes can be modified by using static routes, which are User Defined Routes (UDR) in Azure.

When you create a virtual network peering between two virtual networks, a route is added for each address range within the address space of each virtual network a peering is created for.

If your on-premises network gateway exchanges border gateway protocol (BGP) routes with an Azure virtual network gateway, a route is added for each route propagated from the on-premises network gateway. These routes appear in the routing table as BGP routes.

The public IP addresses for certain services are added to the route table by Azure when you enable a service endpoint to the service. Service endpoints are enabled for individual subnets within a virtual network. When you enable a service endpoint, route is only added to the route table of for the subnet that belongs to this service. Azure manages the addresses in the route table automatically when the addresses change.

User-defined routes are also called Custom routes. You create UDR in Azure to override Azure's default system routes, or to add additional routes to a subnet's route table. 

When you have competing entries in a routing table, Azure selects the next hop based on the longest prefix match similar to traditional routers. However, if there are multiple next hop entries with the same address prefix then Azure selects the routes in following order.

1. User-defined routes (UDR)

2. BGP routes

3. System routes

Common reasons for overriding Azure's default routing are:

- Because you want traffic between subnets to flow through an NVA. To learn more about how to [configure route tables to force traffic through an NVA](/azure/virtual-network/tutorial-create-route-table-portal).

- Because you want to force all internet-bound traffic through an NVA, or on-premises, through an Azure VPN gateway. Forcing internet traffic on-premises for inspection and logging is often referred to as forced tunneling. Learn more about how to configure [forced tunneling](/azure/vpn-gateway/vpn-gateway-forced-tunneling-rm?toc=/azure/virtual-network/toc.json).

 

### System routes

- When you need traffic routed between VMs in the same virtual network or peered virtual networks

- You need communication between VMs using a VNet-to-VNet VPN

- You need site-to-site communication through ExpressRoute or a VPN gateway


 

### User defined routes (UDRs) 

- You want to enable filtering of Internet traffic via Azure Firewall or forced tunneling.

- You want traffic between subnets to flow though an NVA.

- You need to create routes to specify how packets should be routed in a virtual network.

- You need to create routes that control network traffic and specify the next hop in the traffic flow. 


