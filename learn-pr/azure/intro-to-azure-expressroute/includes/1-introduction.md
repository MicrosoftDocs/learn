Organizations use Azure ExpressRoute to connect their on-premises networks to Microsoft cloud services over private connectivity that doesn't traverse the public internet. Compared with typical internet connections, ExpressRoute can provide more predictable latency and throughput. Actual performance and availability still depend on the complete network path and the applications that use it. Supported Microsoft 365 endpoints can also use ExpressRoute in specific, Microsoft-authorized scenarios, but internet connectivity is the recommended approach for most Microsoft 365 customers.

Adatum is a new and expanding company that provides drone video services. You're in charge of networking at Adatum. At the moment, your organization uses a site-to-site VPN connection to connect hosts on the on-premises network to services hosted in Azure. Adatum’s workers use Azure infrastructure as a service (IaaS) virtual machines for video post-processing tasks and Azure File Shares to store high-resolution video data.

Recently, you found that the quality of the site-to-site VPN connection fluctuates during the day, which directly affects the workflow at Adatum. Sometimes, this means that connectivity to the IaaS virtual machines running video-processing software lags. At other times, transfers of video files from Adatum’s offices to Azure File Shares can slow or even stall. Some file transfers take minutes and others take hours.

You're responsible for networking, and you want to improve the bandwidth and reliability of the connection between Adatum’s main site and the Azure datacenters where Adatum workloads reside. Because some of the clients you work with hire Adatum to produce sensitive drone imagery related to mineral-exploration claims, you also want to minimize the amount of network traffic between your organization’s on-premises network and Microsoft cloud services that passes across the public internet.  

This module explains what Azure ExpressRoute does, how it works, and when you should choose to use Azure ExpressRoute as a solution to meet Adatum’s needs.

## Learning objectives

In this module, you'll:

- Learn what Azure ExpressRoute is and the functionality it provides.
- Determine whether Azure ExpressRoute meets the needs of your organization.
- Understand the difference between Azure ExpressRoute and Azure VPNs.

## Prerequisites

Understanding of basic networking concepts
