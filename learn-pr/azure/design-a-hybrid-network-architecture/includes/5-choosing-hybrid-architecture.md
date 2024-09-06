Your organization is almost ready to migrate resources to Azure. This migration uses a hub-spoke architecture, but there remains an open question about the best method to use to connect the on-premises datacenter with the Azure network.

You already provided a high-level design for this migration. However, your project manager requests extra information about the choice between Azure ExpressRoute and Azure VPN Gateway. You also need to put together a capability matrix, so that nontechnical staff members understand the features of each service.

In this unit, you assess two hybrid networking scenarios: Azure ExpressRoute and Azure VPN Gateway.

## Azure ExpressRoute

As the solution architect, you understand the need to provide a robust and reliable network connection between your on-premises datacenters and Azure. The requirements demand low latency and a high level of availability. From your investigations, you know there are two possibilities: VPN or ExpressRoute.

Both solutions provide a secure connection between the on-premises network and the Azure virtual network.

The VPN solution uses known and established technologies. However, a VPN isn't designed to handle high data volumes, and the core infrastructure backbone still uses the internet. Using a VPN might be a cost-effective solution in the short term. But, you know that in the long term a VPN is unlikely to provide the performance, scalability, and resilience your organization requires.

The ExpressRoute option uses a dedicated private connectivity partner to provide a direct connection between your on-premises datacenters and Azure. Microsoft requires the connectivity provider to maintain two discrete connections to the Azure network for each ExpressRoute circuit, which helps ensure a high level of resilience. ExpressRoute also provides a connection bandwidth that's almost 10 times faster than a VPN. 

ExpressRoute requires a close working partnership with the connectivity provider, it's a more complex configuration, and it can be more expensive than a regular VPN network.

However, based on what you learned so far, you decide that ExpressRoute is better suited to meet your organization's primary needs.

## Azure VPN Gateway

Your organization's presence covers a wide geographical location. Although your datacenter and HQ are all in the same building, many satellite branches also need a connection to the Azure network.

You established ExpressRoute as your preferred connection to Azure. Now you consider your second requirement: connecting regional satellite offices to the Azure network.

Unlike your HQ, which has thousands of employees and an on-premises datacenter, each satellite office has between 20 and 50 employees. There's no requirement for a fast, low-latency connection.

This secondary requirement has different needs. ExpressRoute, although ideal for high speeds and resilience, doesn't suit smaller satellite offices that have a lower connectivity requirement. Also, each office would need a dedicated private connection maintained and run by the connectivity provider.

In this instance, using a VPN would provide a better overall solution. A VPN is based on existing and understood technology, which means it can be managed in-house. The lower-speed bandwidth is within an acceptable tolerance for day-to-day usage.

## Hybrid networking capability matrix

To help you choose between the two connectivity types, we built a capability matrix to show what you learned in this unit. The following table lists the key features for each method, the supported bandwidths, the resiliency model, typical use cases, and associated Service License Agreements (SLAs).

| Capability | VPN Gateway | ExpressRoute |
| ---- |---|---|---|
| **Azure services support** | Azure Cloud Services and Azure Virtual Machines | Microsoft Cloud Platform |
| **Bandwidth** | Up to 10 Gbps | Up to 10 Gbps or 100 Gbps (direct) |
| **Protocol** | Secure Socket Tunneling Protocol (SSTP) or IPsec | Direct over VLAN or Multiprotocol Label Switching (MPLS) |
| **Routing** | Static or dynamic | Border Gateway Protocol (BGP) |
| **Connection resiliency** | Active-passive or active-active | Active-passive or active-active |
| **Use case** | Prototyping, dev, test, labs, RDC, and small production workloads | Access to all Azure services, enterprise-grade, supporting critical large-scale workloads |
| **SLA** | 99.95-99.99% | 99.95% |
