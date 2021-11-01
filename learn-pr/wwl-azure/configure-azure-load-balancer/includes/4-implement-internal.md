An internal load balancer directs traffic to resources that are inside a virtual network or that use a VPN to access Azure infrastructure. Frontend IP addresses and virtual networks are never directly exposed to an internet endpoint. Internal line-of-business applications run in Azure and are accessed from within Azure or from on-premises resources. For example, an internal load balancer could receive database requests that need to be distributed to backend SQL servers.

:::image type="content" source="../media/internal-load-balancer-5ae85589.png" alt-text="Diagram showing how an internal load balancer works. Three VMs are shown going through a load balancer to access SQL servers in the database tier subnet. The SQL servers are responding on port 1443.":::


An internal load balancer enables the following types of load balancing:

 -  **Within a virtual network**. Load balancing from VMs in the virtual network to a set of VMs that reside within the same virtual network.
 -  **For a cross-premises virtual network**. Load balancing from on-premises computers to a set of VMs that reside within the same virtual network.
 -  **For multi-tier applications**. Load balancing for internet-facing multi-tier applications where the backend tiers are not internet-facing. The backend tiers require traffic load-balancing from the internet-facing tier.
 -  **For line-of-business applications**. Load balancing for line-of-business applications that are hosted in Azure without additional load balancer hardware or software. This scenario includes on-premises servers that are in the set of computers whose traffic is load-balanced.

> [!NOTE]
> A public load balancer could be placed in front of the internal load balancer to create a multi-tier application.
