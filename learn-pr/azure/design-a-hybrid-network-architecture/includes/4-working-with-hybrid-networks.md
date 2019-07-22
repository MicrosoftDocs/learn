Your organization has settled on using the Azure hybrid architectural model.  Now you need to weigh up the merits of each service type.

You already have a good idea of the services required in Azure for your organization. Before you can make an informed decision, you need to understand the benefits and limitations of each service.

In this unit, you'll explore some of the hybrid networking patterns in Azure.

## Summary of hybrid network patterns

The hybrid network patterns, like all design patterns, provide details of the Azure services and features necessary to deliver predictable availability and performance across multiple geographical regions.  

All hybrid network patterns will focus on:

- The connection between Azure and the on-premises network.
- Whether the VNet needs to extend across regions.
- Whether the VNet needs to extend between subscriptions.
- Provision of remote network access.

The hybrid network patterns we'll focus on in this unit are:

- VPN connections
- ExpressRoute Connections
- ExpressRoute with VPN Failover
- Hub and Spoke

## VPN connections

A Virtual Private Network provides a connection between your on-premises network and Azure.  Which includes site-to-site (S2S) and point-to-site (P2S) usage.

Benefits:

- It's a well know technology, which is easy to configure, and maintain.
- All data traffic is encrypted.
- Better suited to lighter data traffic loads.

Challenges:

- A VPN connection uses the internet.
- Potential latency issues depending on bandwidth size and usage. Currently Azure supports a maximum bandwidth of 1.25 Gps.
- A local VPN device is needed.

## ExpressRoute Connections

Using a private connection, provided through a connectivity provider, to connect your on-premises to Azure.

Benefits:

- Better suited to high-speed and critical business operations.
- Bandwidth limitations are improved, up to a maximum of 10 Gps.
- Provides dynamic scalability to meet organizational needs.
- Uses level 3 connectivity standards.

Challenges:

- Setup and configuration are more complex and will require collaboration with the connectivity provider.
- Installation of high-bandwidth routers needed on-premises.
- The network connection is handled and managed by the connectivity provider.

## ExpressRoute with VPN Failover

Combining a VPN connection, with ExpressRoute.  This setup uses ExpressRoute as the primary connection between your on-premises network and Azure. It will failover to the VPN connection only when the ExpressRoute connection is lost.

![Image showing hub-spoke architecture](../media/3-expressroute-vpn-failover-architecture.png)

Benefits:

- Creates a resilient high availability network.

Challenges:

- When failover occurs, bandwidth will reduce to VPN connection speeds.
- Highly complex configuration.
- Needs both an ExpressRoute connection and a VPN Connection.
- Requires a redundant Azure VPN gateway and local VPN hardware.   Note, the redundant VPN Gateway will incur payment charges even when it is not being used.

## Hub and Spoke

Hub and spoke is a distributed network architecture using VNets to balance workloads.  The hub-spoke architecture has a single hub at the center, that is responsible for enabling all communications to and from the other resources.  It uses a single VNet as the hub, which is also connected to your on-premises network using either VPN or ExpressRoute.  The spokes are other VNets that are peered with the hub.  Each spoke can be assigned specific workloads, while the hub is used for shared services.

![Image showing hub-spoke architecture](../media/4-hub-spoke-architecture.png)

The hub, and each spoke, can be implemented in separate subscriptions or resource groups and peered together. These subscriptions or resource groups, can then share the Azure AD tenant providing maintenance for shared services in the hub, but decentralizing each workload.

With the hub becoming the core of the business, it provides the foundations for deeper business insight.

Since this model utilizes one of the three previous approaches: VPN, ExpressRoute, and ExpressRoute with VPN failover. The respective benefits and challenges associated should be combined with the following.

Benefits:

- Using sharing and centralized services on the hub can reduce the need duplication on the spokes, which can reduce costs.
- Subscription limits can be overcome by peering VNets.
- Allows for the separation of organizational work areas into dedicated spokes, such as SecOps, InfraOps, and DevOps.

Challenges:

- Consider what services are shared on the hub and what remain on with the spokes.
