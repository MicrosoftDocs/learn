Azure ExpressRoute meets Adatum’s needs for the following reasons. ExpressRoute: 

- Provides a low-latency connection to resources in the Azure cloud. On-premises clients at Adatum can use IaaS VMs that perform video-processing tasks without concerns around variable latency.  
- Provides a high-bandwidth connection to resources in the Azure cloud. The high bandwidth Azure ExpressRoute provides will assist Adatum with workloads such as transferring video files to Azure File Shares. These transfers might take significantly longer if Adatum continued to use its existing site-to-site VPN connections.
- Provides guaranteed availability to resources in the Azure cloud. Microsoft guarantees a minimum of 99.95% availability for ExpressRoute dedicated connections, which means that if Adatum adopts ExpressRoute, connectivity disruptions that occur when sending traffic over the public internet won't affect day-to-day operations.
- Provides secure connection to Azure resources. Adatum clients, such as those that use drone imagery when establishing minerals claims, prefer their data be transferred using private connections rather than VPN connections over the internet.

## When to use Azure VPN Gateway

Not all customer locations require a dedicated connection to Azure datacenters. For example, smaller branch offices can often use site-to-site VPN connections to route traffic between on-premises hosts and Azure, because small sites are less likely to require persistent high bandwidth connections.  

An organization with remote individual users, such as those working from home or those who regularly travel with a laptop computer, can use Azure point-to-site VPNs to connect to Azure resources. A point-to-site VPN is a VPN connection that's established from an individual computer to Azure.  
