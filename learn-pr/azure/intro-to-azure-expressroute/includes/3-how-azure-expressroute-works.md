Azure ExpressRoute allows you to extend your on-premises networks into Microsoft’s cloud through a private connection. To implement ExpressRoute, you need to work with an ExpressRoute partner who provides an edge service. This edge service is an authorized and authenticated connection to Microsoft’s clouds that functions through a partner-controlled router.

The partner configures connections to an endpoint in an ExpressRoute location. These connections let you peer on-premises networks with the Azure virtual networks available through the endpoint. The term for these ExpressRoute connections is *circuits*.

Circuits provide a physical connection for the transmission of data through your provider’s edge routers to the Microsoft cloud edge routers. Circuits are provided across private and dedicated cable connections and never traverse the public internet.  

## ExpressRoute prerequisites

ExpressRoute has the following prerequisites:

- An ExpressRoute connectivity partner or a cloud exchange provider that can provision a connection from your on-premises networks to Microsoft’s cloud.
- An Azure subscription registered with your selected ExpressRoute connectivity partner.
- An active Microsoft Azure account within the subscription that can be used to request an ExpressRoute circuit.

ExpressRoute has the following networking and routing requirements:

- You need to ensure that Border Gateway Protocol (BGP) sessions for routing domains are configured. Some partners do this configuration for you, and some partners require you to perform this task yourself. For each ExpressRoute circuit, it's necessary to configure redundant BGP sessions between Microsoft’s routers and your peering routers.
- Reserve several blocks of IP addresses in your internal network for routing traffic to Microsoft’s cloud. These address blocks can either be configured as a /29 subnet or two /30 subnets in your organization’s IP address space. The first of these subnets is used with the primary circuit to Microsoft’s clouds. The second is used for the secondary circuit. Both IPs in these special subnets are used to establish a BGP session. When the session is established, the first IP represents the Microsoft Cloud endpoint and the second IP represent the customer's endpoint.  

## ExpressRoute peering schemes

You can use two different peering schemes with ExpressRoute:

- **Private peering**: Private peering allows you to connect on premises hosts with Azure IaaS and PaaS services configured to work with Azure virtual networks. All resources must be located in Azure virtual networks and allocated IP addresses in a private address space that doesn't overlap with your on-premises address space. You can’t connect to an Azure resource’s public IP address, such as an IaaS VM’s public IP address through private peering.
- **Microsoft peering**: Microsoft peering allows you to connect over ExpressRoute with Azure PaaS services, Microsoft 365 services, and Dynamics 365. If you're using Microsoft peering and you want to have resources in Azure connect to hosts on-premises, you need to reserve an extra IP address block.

:::image type="content" source="../images/expressroute-circuit-peerings.png" alt-text="Diagram that shows the circuit peerings in Azure ExpressRoute.":::

## ExpressRoute high availability and failover

Each ExpressRoute circuit has two connections from the connectivity provider to two separate edge routers at Microsoft. These connections provide ExpressRoute availability for a single location. If you want a higher degree of availability, you can configure ExpressRoute circuits in different peering locations. Adding different locations protects your ExpressRoute connection from regional outages. Another option is to have multiple ExpressRoute circuits configured through different providers, so that should one provider suffer an outage, you can fail over to a second provider.
