As your company deals with highly sensitive data and has large amounts of information it will store in Azure, there are some concerns about the security and reliability of connections over the public Internet. The company isn't willing to migrate wholesale to Azure unless it can demonstrate higher levels of connectivity, security, and reliability.

Here, we'll go beyond connections that run over the Internet to dedicated lines direct into the Azure datacenters.

## Azure ExpressRoute

Microsoft Azure ExpressRoute enables organizations to extend their on-premises networks into the Microsoft Cloud over a private connection implemented by a connectivity provider. This arrangement means that the connectivity to the Azure datacenters doesn't go over the Internet but across a dedicated link. ExpressRoute also facilitates efficient connections with other Microsoft cloud-based services, such as Microsoft 365 and Dynamics 365.

Advantages that ExpressRoute provides include:

- Faster speeds, from 50 Mbps to 10 Gbps, with dynamic bandwidth scaling

- Lower latency

- Greater reliability through built-in peering

- Highly secure

ExpressRoute brings a number of further benefits, such as:

- Connectivity to all supported Azure services

- Global connectivity to all regions (requires premium add-on)

- Dynamic routing over Border Gateway Protocol

- Service-level agreements (SLAs) for connection uptime

- Quality of Service (QoS) for Skype for Business

Additionally, there's the ExpressRoute premium add-on, which offers benefits such as increased route limits, global service connectivity, and increased virtual network links per circuit.

## ExpressRoute connectivity models

Connections into ExpressRoute can be through the following mechanisms:

- IP VPN network (any-to-any)

- Virtual cross-connection through an Ethernet exchange

- Point-to-point Ethernet connection

 ExpressRoute capabilities and features are all identical across all of the above connectivity models.

### What is layer 3 connectivity?

Microsoft uses an industry-standard dynamic routing protocol (BGP) to exchange routes between your on-premises network, your instances in Azure, and Microsoft public addresses. We establish multiple BGP sessions with your network for different traffic profiles.

### Any-to-any (IPVPN) networks

IPVPN providers typically provide connectivity between branch offices and your corporate datacenter over managed layer 3 connections. With ExpressRoute, the Azure datacenters appear as if they were another branch office.

### Virtual cross-connection through an Ethernet Exchange

If your organization is co-located with a cloud exchange facility, you request cross-connections to the Microsoft Cloud through your provider's Ethernet exchange. These cross-connections to the Microsoft Cloud can operate at either layer 2 or layer 3 managed connections, as in the networking OSI model.

### Point-to-point Ethernet connection

Point-to-point Ethernet links can provide layer 2 or managed layer 3 connections between your on-premises datacenters or offices to the Microsoft Cloud.

## How ExpressRoute works

Azure ExpressRoute uses a combination of ExpressRoute circuits and routing domains to provide high-bandwidth connectivity to the Microsoft Cloud.

### What are ExpressRoute circuits

An ExpressRoute circuit is the logical connection between your on-premises infrastructure and the Microsoft Cloud. A connectivity provider implements that connection, although some organizations use multiple connectivity providers for redundancy reasons. Each circuit has a fixed bandwidth of either 50, 100, 200 Mbps or 500 Mbps, or 1 Gbps or 10 Gbps, and each of those circuits map to a connectivity provider and a peering location. In addition, each ExpressRoute circuit has default quotas and limits.

An ExpressRoute circuit isn't equivalent to a network connection or a network device. Each circuit is defined by a GUID, called a _service_ or _s-key_. This s-key provides the connectivity link between Microsoft, your connectivity provider, and your organization - it isn't a cryptographic secret. Each s-key has a one-to-one mapping to an Azure ExpressRoute circuit.

Each circuit can have up to two peerings, which are a pair of BGP sessions that are configured for redundancy. They are:

- Azure private
- Microsoft

### Routing domains

ExpressRoute circuits then map to routing domains, with each ExpressRoute circuit having multiple routing domains. These domains are the same as the two peerings listed above. In an active-active configuration, each pair of routers would have each routing domain configured identically, thus providing high availability. The Azure private peering names represent the IP addressing schemes.

#### Azure private peering

Azure private peering connects to Azure compute services such as virtual machines and cloud services that are deployed with a virtual network. As far as security goes, the private peering domain is simply an extension of your on-premises network into Azure. You then enable bidirectional connectivity between that network and any Azure virtual networks, making the Azure VM IP addresses visible within your internal network.

You can connect only one virtual network to the private peering domain.

#### Microsoft peering

Microsoft peering supports connections to cloud-based SaaS offerings, such as Microsoft 365 and Dynamics 365. This peering option provides bi-directional connectivity between your company's WAN and Microsoft cloud services.

### ExpressRoute health

As with most features in Microsoft Azure, you can monitor ExpressRoute connections to ensure that they are performing satisfactorily. Monitoring includes coverage of the following areas:

- Availability
- Connectivity to virtual networks
- Bandwidth utilization

The key tool for this monitoring activity is Network Performance Monitor, particularly NPM for ExpressRoute.

Azure ExpressRoute is used to create private connections between Azure datacenters and infrastructure on your premises or in a colocation environment. ExpressRoute connections don't go over the public Internet, and they offer more reliability, faster speeds, and lower latencies than typical Internet connections.
