
Administrators use internal load balancers to direct traffic to resources that reside in a virtual network, or to resources that use a VPN to access Azure infrastructure. In this configuration, front-end IP addresses and virtual networks are never directly exposed to an internet endpoint. Internal line-of-business applications run in Azure and are accessed from within Azure or from on-premises resources.

#### Business scenario

Suppose you have an Azure SQL Database tier subnet with several virtual machines, and you implement an internal load balancer. Database requests need to be distributed to the backend. The internal load balancer receives the database requests and uses the load-balancing rules to determine how to distribute the requests to the back-end SQL servers. The SQL servers respond on port 1433. The following illustration highlights this scenario:

:::image type="content" source="../media/internal-load-balancer-5ae85589.png" alt-text="Diagram showing how an internal load balancer works as described in the text." border="false":::

### Things to consider when using an internal load balancer

You can implement an internal load balancer to achieve several types of load balancing.

- **Within virtual network**: Establish load balancing from your virtual machines in the virtual network to a set of virtual machines that reside within the same virtual network.

- **For cross-premises virtual network**: Apply load balancing from your on-premises computers to a set of virtual machines that reside within the same virtual network.

- **For multi-tier applications**: Implement load balancing for your internet-facing multi-tier applications when the back-end tiers aren't internet-facing. The back-end tiers require traffic load-balancing from the internet-facing tier.

- **For line-of-business applications**: Add load balancing for your line-of-business applications hosted in Azure without having to add other load balancer hardware or software. This scenario includes on-premises servers that are in the set of computers whose traffic is load-balanced.

- **With public load balancer**: Configure a public load balancer in front of your internal load balancer to create a multi-tier application.