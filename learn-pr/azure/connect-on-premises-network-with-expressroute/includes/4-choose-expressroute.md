You've learned how the Azure ExpressRoute service works, and how to connect your on-premises networks to the Microsoft cloud by using an ExpressRoute circuit. You've also learned about the different peering options available, and how to use a virtual network gateway to route requests between your on-premises network and the Microsoft cloud. 

In this unit, we show you the most common use cases for deploying ExpressRoute. We also compare ExpressRoute to other connection options available for Azure, like site-to-site and point-to-site through a virtual network gateway. Together, this information helps you determine whether ExpressRoute is the most appropriate solution for your organization.

## When to use Azure ExpressRoute

Consider using the Azure ExpressRoute service in the following scenarios:

- Low-latency connectivity to services in the cloud. In these situations, eliminating or reducing the network overhead has a significant effect on the performance of your applications.
- Accessing high-volume systems in the cloud that consume or produce massive volumes of data quickly. ExpressRoute can move data around rapidly, with high reliability.
- Consuming Microsoft Cloud Services, such as Office 365 and Dynamics 365. ExpressRoute is especially useful if your organization has a large number of users who need to access these services concurrently.
- Organizations that have migrated large-scale on-premises systems to Azure. Using ExpressRoute helps ensure that the results of the migrations are seamless for on-premises clients. Organizations should notice no drop in performance. They might even experience some improvement if network bandwidth restricted their previous on-premises systems.
- Situations where data shouldn't traverse the public internet for security reasons.
- Large datacenters, with a high number of users and systems accessing SaaS offerings.

## Benefits of using ExpressRoute

ExpressRoute offers several advantages for building highly scalable, cloud-based solutions.

### Predictable performance

Having a dedicated connection to the Microsoft cloud guarantees performance. There are no concerns over internet provider outages or spikes in internet traffic. With ExpressRoute, your providers are accountable to provide the necessary throughput and latency SLA.

### Data privacy for your traffic

Traffic that's sent over ExpressRoute connection is as secure as using MPLS WAN links. There's no risk of internet monitoring or packet capture by malicious users.

### High-throughput, low-latency connections

With ExpressRoute, you can obtain speeds of up to 10 Gbps when connecting to the Microsoft cloud. If you're using ExpressRoute Direct, you can achieve up to 100 Gbps. Latency is minimal, so your systems are highly responsive.

### Availability and connectivity

Microsoft guarantees a minimum of 99.95 percent availability for an ExpressRoute dedicated circuit.

With ExpressRoute enabled, you can connect to Microsoft through one of several peering connections and have access to regions within the same geopolitical region. For example, if you connect to Microsoft through ExpressRoute in France, you have access to all Microsoft services hosted in Western Europe.

You can also enable ExpressRoute Premium, which provides cross-region accessibility. For example, if you access Microsoft through ExpressRoute in Germany, you have access to all Microsoft cloud services in all regions globally.

You can also take advantage of a feature called ExpressRoute Global Reach. It allows you to exchange data across all of your on-premises datacenters by connecting all of your ExpressRoute circuits.

## Alternatives to ExpressRoute

ExpressRoute is one of three solutions that you can use to connect your on-premises network to Azure. The others are a virtual network site-to-site connection and a virtual network point-to-site connection.

### Site-to-site VPN

An Azure site-to-site VPN connection allows you to connect your on-premises network to Azure over an IPsec tunnel to build a hybrid network solution. You configure an on-premises VPN device with a public IP address. Then, you connect this device to an Azure virtual network through an Azure virtual network gateway.

### Point-to-site VPN

With point-to-site VPN, you can establish a secure connection to a network from individual computers located on-premises. This solution is useful for someone who wants to connect to Azure from remote locations such as a home or customer site. Point-to-site is useful if you have only a few clients that need to connect to a virtual network.

### Azure ExpressRoute vs. site-to-site and point-to-site VPN connections

The following table shows a comparison between ExpressRoute, point-to-site, and site-to-site networks with Azure.

| Connection | Azure services supported | Bandwidth | Protocols | Typical use case |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| Virtual network, point-to-site | Azure IaaS and PaaS services (through private endpoints) | Based on the gateway SKU |  Active/passive | Dev, test, and lab environments for cloud services and virtual machines. |
| Virtual network, site-to-site | Azure IaaS and PaaS services (through private endpoints) | 	Typically < 1 Gbps aggregate|  Active/passive | Dev, test, and lab environments. Small-scale production workloads and virtual machines.| 
| ExpressRoute | Azure IaaS and PaaS services, Microsoft Office 365 services | 50 Mbps up to 10 Gbps (100 Gbps for ExpressRoute Direct)| Active/active | Enterprise-class and mission-critical workloads. Big data solutions. |
