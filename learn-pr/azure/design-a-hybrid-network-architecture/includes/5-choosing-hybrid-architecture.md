Your organization is almost ready to migrate resources to Azure. This migration uses a hub-spoke architecture, but there remains an open question about the best connection method from the Azure network to the on-premises datacenter.

You've already provided a high-level design for this migration. However, your project manager has requested extra information about the choice between a VPN gateway or ExpressRoute. You also need to put together a capability matrix, so that non-technical staff understand the features of each service.

In this unit, you'll assess two hybrid networking scenarios: Azure ExpressRoute and Azure VPN Gateway.

## Azure ExpressRoute

As the solution architect, you understand the need to provide a robust and reliable network connection between your on-premises datacenters and Azure. The requirements demand low latency and a high level of availability. From your investigations, you know there are two possibilities: VPN or ExpressRoute.
Both solutions provide a secure connection between the onsite premises and the Azure virtual network.

The VPN solution uses known and established technologies. However, a VPN isn't designed to handle high data volumes, and the core infrastructure backbone still uses the internet. Using a VPN might be a cost-effective solution in the short term. You know that in the long term a VPN is unlikely to provide the performance, scalability, and resilience your organization requires.

The ExpressRoute option uses a dedicated private connectivity partner to provide a direct connection between your on-premises datacenters and Azure. Microsoft requires the connectivity provider to maintain two discreet connections to the Azure network for each ExpressRoute circuit, which ensures a high level of resilience. ExpressRoute also provides a connection bandwidth that's almost 10 times faster than a VPN. It requires a close working partnership with the connectivity provider, it's a more complex configuration, and can be more expensive than a regular VPN network.

However, based on what you've learned so far, you decide that ExpressRoute is better suited to meet your organization's primary needs.

## Azure VPN Gateway

Your organization's presence covers a wide geographical location. While your datacenter and HQ are all in the same building, many satellite branches also need a connection to the Azure network.

You've established ExpressRoute as your preferred connection to Azure. Now you'll consider your second requirement: connecting regional satellite offices to the Azure network.

Unlike your HQs, which have thousands of employees and an on-premises datacenter, the satellite offices have between 20 and 50 employees. There's no requirement for a fast, low latency connection.

This secondary requirement has different needs. ExpressRoute, while ideal for high speeds and resilience, doesn't suit smaller satellite offices that have a lower connectivity requirement. Also, each office would need a dedicated private connection to be maintained and run by the connectivity provider.

In this instance, using a VPN would provide a better overall solution. A VPN is based on existing and understood technology, which means it can be managed in-house. The lower speed bandwidth is within an acceptable tolerance for day-to-day usage.

## Hybrid networking capability matrix

To show what you've learned in this unit and to help you choose between the connectivity types, we've built a capability matrix. The table below outlines the key features for each method, what bandwidths are supported, the resiliency model, typical use cases, Microsoft's SLA, and the cost.

| Capability | VPN | ExpressRoute |
| ---- |---|---|---|
| Azure services support | Cloud Services and Virtual Machines | Microsoft Cloud Platform |
| Bandwidths | < 1.25 Gbps | < 10 Gbps or 100 Gbps (direct) |
| Protocols | SSTP or IPsec | Direct over VLAN or MPLS |
| Routing | Static or dynamic | BGP |
| Connection resiliency | active-passive | active-active |
| Use cases | prototyping, dev, test, labs, RDC, and small production workloads | Access to all Azure services, enterprise-grade, supporting critical large-scale workloads |
| SLA | 99.95-99.99% | 99.95% |
| Pricing | from $26.28 per month | from $55 per month, plus circuit provider costs |
