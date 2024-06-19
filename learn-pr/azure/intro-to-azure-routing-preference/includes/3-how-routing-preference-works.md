To determine if routing preference can realize cost savings for the factory network traffic project, you must first understand the routing preference alternatives in Azure.

When you create an internet-facing service in Azure, such as an Azure Load Balancer, you assign a public IP address to the resource. When the public IP address is created, you can keep the default setting of *Microsoft network* or change the setting to *Internet routing*. These options for the public IP address determine the behavior of how traffic is routed from external user connections to the service in Azure.

As we learned from previous units, you have the option of routing traffic across the Microsoft global network or by the public internet. The following information explains how the traffic routes for the different routing preference options.

## Microsoft network

The Microsoft network routing preference ensures all traffic whenever possible stays on the Microsoft network.

### Incoming (ingress) traffic

The incoming data path uses *cold potato routing*. Cold potato routing means that traffic enters the Microsoft network that is closest to the user initiating the connection.

For example, if a user in Singapore accesses Azure resources hosted in the Central US region, the traffic enters the edge POP closest to Singapore. The traffic then travels across the Microsoft backbone network to the service hosted in the Central US region.

### Outgoing (egress) traffic

The outgoing traffic follows the same principle as the incoming traffic. Traffic traverses the Microsoft network and exits closest to the user's location.

For example, if traffic from the Central US region is destined to user in Singapore, the traffic travels the Microsoft network and exits the edge POP closest to Singapore.

## Internet routing

The Internet routing preference minimizes data travel on the Microsoft global network.

### Incoming (ingress) traffic

The incoming data uses *hot potato routing*. Hot potato routing means that traffic enters the Microsoft network closest to the hosted service region.

For example, if a user in Singapore accesses Azure resources hosted in the Central US region, the traffic traverses the public internet and enters the edge POP closest to the Central US region.

### Outgoing (egress) traffic

The outgoing traffic follows the same principle as the incoming traffic. Traffic exits the Microsoft network in the same region where the service is hosted.

If a user in Singapore is the recipient of traffic from a service hosted in the Central US region, the traffic leaves the Microsoft network at the nearest edge POP to the Central US region. The traffic travels through the public internet to reach the user in Singapore.

> [!NOTE]
> Even when using a public IP address with a routing preference of *Internet routing*, all traffic that's bound for a destination within Azure continues to use the direct path within the Microsoft Wide Area Network.

## Routing preference unmetered

As we learned in the previous unit, the routing preference unmetered service is available for content delivery network (CDN) providers who have their customers' origin content hosted on Azure.

Your outbound traffic from an origin in Azure destined to a CDN provider benefits from the direct connectivity. The data transfer bill for traffic leaving your Azure resources routed through the direct links is free.

A direct connection between a CDN provider and an origin in Azure enables optimal performance by eliminating network *hops* between the connections. The CDN workload that frequently fetches data from the origin benefits from the *hop* elimination.

With the service, CDN providers have the opportunity to directly connect their network to Microsoft's global network edge routers at various locations. To take advantage of routing preference unmetered, your CDN providers must be part of the program. Contact your CDN provider to check if it's part of the program.
