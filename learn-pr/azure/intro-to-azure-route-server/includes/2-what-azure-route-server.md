More complex network environments that consist of on-premises and virtual networks, subnets, NVAs, and gateways often result in routing solutions that might be difficult to configure and manage. Azure Route Server can help simplify and optimize this process by learning and exchanging routes between various networks and network appliances. Before you decide if Azure Route Server is the appropriate solution for your company, you need to understand the key components and technologies that comprise an Azure Route Server solution.

Azure Route Server is a fully managed service that runs in Azure and simplifies dynamic routing between various NVAs and your virtual or on-premises network. It allows you to exchange routing information directly through the Border Gateway Protocol (BGP) routing protocol between any NVA that supports BGP and the Azure Software Defined Network in the Azure virtual network. Azure Route Server provides this functionality without the need to manually configure or maintain route tables. It’s configured with high availability, so you don’t need to separately implement redundancy. Azure Route Server doesn’t route actual data traffic between networks; instead, the data goes directly between devices while Azure Route Server exchanges routes. By doing so, Azure Route Server helps improve the efficiency of traffic routing.

## Overview of routing protocols

Routers as network devices don’t just forward the traffic among various networks. To maximize efficiency, routers also exchange route information with other routers. For communication with other routing devices, routers use *routing protocols*, which are sets of rules that specify how routers communicate with each other. You can also think of routing protocols as a language that routers on the internet use to determine how they can exchange network traffic so it reaches its final destination in the most efficient way. Routing protocols include:

- Routing Information Protocol (RIP)
- Open shortest path first (OSPF)
- External Gateway Protocol (EGP)
- Border Gateway Protocol (BGP)

> [!NOTE]
> In local networks, you can use RIP or OSPF, but on the internet, most routers use BGP.

BGP is the most common routing protocol on the internet. In routing-protocol classification, BGP is classified as a *distance path vector protocol*. BGP was designed primarily to replace EGP and to provide a decentralized approach to routing. BGP uses the best-path-selection algorithm to select the best routes for data packet transfers. When a packet comes to the router, it uses BGP to review all the available paths along which the data could travel. It then picks the best route, which usually means that packet will be routed between several autonomous network systems. Azure Route Server uses BGP to exchange routes with other network devices, primarily network appliances.

## Overview of autonomous systems

An *autonomous system* (AS) is a large network or group of networks that uses a unique policy for routing. For example, an internet service provider’s network is an autonomous system. In general, every device that connects to the internet does so through the AS.

Each AS on the internet is registered and has its own pool of IP addresses. Some university networks are also registered as autonomous systems, as are some large companies. The Azure network is also registered as an AS.

Each AS is registered under a specific name, called the *autonomous system number* (ASN). Each ASN is a unique 16-bit number between 1 and 65534, or 32-bit number between 131072 and 4294967294. For example, Microsoft manages the following ASNs: AS8075, AS8068, AS8069 and AS12076. The Azure service has the AS number 65515.

When autonomous systems communicate with each other, they use AS numbers. Because each AS has its own pool of IP addresses, it uses BGP to announce these IP addresses to other autonomous systems that it connects to. This is a crucial role of an AS and BGP. BGP routers collect this information from AS organizations worldwide and put it into routing tables. BGP routers then use these routing tables to determine the fastest paths from one AS to another. When packets arrive to a router, BGP reviews a routing table to determine which AS the packet should go on to next. Azure Route Server uses ASN to identify the peers with which it exchanges routing information.

> [!NOTE]
> Azure Route Server service supports only 16-bit ASNs.

## Azure virtual networks

Most resources in Azure communicate over Azure virtual networks, which enable many types of Azure resources (such as Azure VMs) to communicate with each other, the internet, and on-premises networks more securely. An Azure virtual network is similar to a local network that you might find in traditional datacenters, but it brings some additional benefits of Azure's infrastructure such as scaling, availability, and isolation.

All resources in a virtual network can communicate outbound to the internet by default. Resources with an assigned public IP address or a public load balancer can receive inbound communications as well. Azure virtual networks can also communicate to your on-premises networks. The most common scenarios for Azure virtual network use include:

- Communication between Azure resources and the internet
- Communication between Azure resources
- Communication with on-premises resources
- Filtering network traffic
- Routing network traffic
- Integration with Azure services

> [!TIP]
> To create an Azure Route Server object, you first need to create a dedicated subnet in an Azure virtual network.

## NVA

An *NVA* is typically a VM, running locally or in Azure, that performs one or more network functionalities, including firewall and wide area network (WAN) optimization. Azure supports a number of NVAs that you can deploy in a virtual network. You can review the available NVAs in Azure Marketplace. Azure Route Server supports communication with various NVAs for exchanging routes.

## SD-WAN

Unlike a traditional WAN, where operators and companies rely on a single technology infrastructure for connecting remote locations, an SD-WAN presents a different approach. An *SD-WAN* is actually a virtual layer over a WAN architecture, which enables enterprises to use any combination of transport services. This includes Multiprotocol Label Switching (MPLS), Long-Term Evolution (LTE), and other various broadband internet services. An SD-WAN uses a centralized software control function to help securely and intelligently direct traffic across the different technology implementations of WAN.

SD-WANs also provide the ability to prioritize network traffic over different connections. An SD-WAN measures traffic in real time and then selects the best route for each data packet. Azure Route Server supports connecting to SD-WAN when performing route exchange.
