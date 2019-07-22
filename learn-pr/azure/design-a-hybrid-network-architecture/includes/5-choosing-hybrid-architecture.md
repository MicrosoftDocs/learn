Your organization is almost ready to migrate resources to Azure. This migration will use a hub-spoke architecture, but there remains an open question about the best connection method from the Azure network to the on-premises datacenter.

You've already provided a high-level design for this migration, but your project manager has also requested you provide extra information about the choice between a VPN gateway or ExpressRoute. You also need to put together a capability matrix, so that non-technical staff can understand the features of each service.

In this unit, you'll assess the two principle hybrid networking scenarios for Azure VPN Gateways and Azure ExpressRoute.

## Azure ExpressRoute

As the solution architect for the migration of your organizations on-premises network to Azure.  You understand the need to provide a solid and reliable network connection between your on-premises data centers and Azure.   The requirements demand low latency and a high level of availability.  From your investigations you know there are two possibilities: VPN or ExpressRoute.
Both solutions provide a secure connection between the on-site premises and Azure.

The VPN solution is built on known and established technologies. Yet isn’t designed to handle high data volumes, and finally the core infrastructure backbone makes use of the internet.  Using a VPN might be a cost-effective solution in the short term. You know that longer term, it's unlikely to provide the performance, scalability, and resilience required by your organization.

The ExpressRoute option uses a dedicated private connectivity partner to provide a direct connection between your on-premises data centers and Azure. Microsoft requires the connectivity provider to maintain two discreet connections to the Azure network for each ExpressRoute circuit.  This ensures a high level of resilience.  ExpressRoute also provides a faster connection bandwidth that is almost 10 times faster than VPN.  It does require a close working partnership with the connectivity provider and it is a more complex configuration and can be more expensive than a regular VPN network.

Based on what you've learnt so far, and the above factors and considerations, you have decided that ExpressRoute is better suited to meet your organizations needs.

## Azure VPN Gateway

Your organization is spread over a wide geographical location, and while the data center and HQ are all in the same building, you have a number of satellite branches that also need to be connected to the Azure network.

Having established ExpressRoute as your preferred connection between the HQ on-premises data centers and Azure, you now need to consider your second requirement.  Connecting your regionalized satellite offices to the Azure network.

Unlike your HQs, which have thousands of employees and an on-premises data center, the satellite offices have between 20 and 50 employees and there is no requirement for a fast, low latency connection.

You know there are two principle methods of connectivity: VPN and ExpressRoute.

However, this requirement has different needs.  ExpressRoute, while ideally suited to your HQs and on-premises data center needs for high-speed and resilience, does not suit the smaller satellite offices since their connectivity usage is lower.  In addition, each office requires a dedicated private connection to be maintained and run by the connectivity provider.

In this instance, you see that a VPN solution would provide a better overall solution.  It is based on existing and understood technology, which means it can be managed in-house.  The lower speed bandwidth is within an acceptable tolerance for day-to-day usage.

## Hybrid Networking Capability Matrix

Summarizing what you have learned in this unit and to aid decision making for choosing between the connectivity types we have built a capability matrix. The below table outlines the key features for each model, what bandwidths are supported, the resiliency model, typical use cases, Microsoft's SLA, and importantly cost.

| Capability | VPN | ExpressRoute |
| ---- |---|---|---|
| Azure services support | Cloud Services and Virtual Machines | Microsoft Cloud Platform |
| Bandwidths | < 1.25 Gbps | < 10 Gbps or 100 Gbps (direct) |
| Protocols | SSTP or IPsec | Direct over VLAN or MPLS |
| Routing | Static or Dynamic | BGP |
| Connection Resiliency | active-passive | active-active |
| Use cases | prototyping, dev, test, labs, RDC, and small prod workloads | Access to all azure services, enterprise grade, supporting critical large-scale workloads |
| SLA | 99.95-99.99% | 99.95% |
| Pricing | from $26.28 per month | from $55 per month |
