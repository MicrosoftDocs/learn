
As the lead Network Engineer for the traffic cost savings project for the Singapore factory, your first step is to understand what routing preference is and it's core features. This overview should help you decide if routing preference in Azure is a good fit for the factory cost savings project.

Routing preference in Azure gives you the ability to determine the path of your traffic between Azure and the Internet. You have the option to route your traffic through either the Microsoft network or the public internet (ISP network). These options are known as "cold potato routing" and "hot potato routing" respectively. The cost of egress data transfer will vary based on your routing choice. You can select your routing preference (Microsoft network or Internet) when creating a public IP address. Public IP addresses are associated with resources such as virtual machines, virtual machine scale sets, and internet-facing load balancers. You can also set the routing preference for Azure storage resources such as blobs, files, web, and Azure DataLake. By default, all Azure services will have their traffic routed through the Microsoft global network.

## Routing preference - Microsoft network

By default, all traffic Azure service traffic is routed through the Microsoft global network. By routing your traffic through the Microsoft global network, you are utilizing one of the largest networks in the world, which spans over 160,000 miles of fiber and has over 165 edge Point of Presence (POP) locations. The network is equipped with multiple redundant fiber paths to guarantee exceptional reliability and availability. The traffic engineering is managed by a software-defined WAN controller, which ensures that your traffic takes the lowest latency path and provides premium network performance. Ingress and egress traffic stays on the Microsoft global network whenever possible.

## Routing preference - Internet (ISP network)

The Internet routing preference minimizes travel on the Microsoft network. Traffic is routed by the transit ISP network. The Internet routing preference is a cost-optimized option that offers network performance comparable to other cloud providers.

## What is routing preference unmetered?

The routing preference unmetered service is available for Content Delivery Network (CDN) providers who have their customers' origin content hosted on Azure. This service enables CDN providers to establish a direct peering connection with Microsoft's global network edge routers at various locations.
