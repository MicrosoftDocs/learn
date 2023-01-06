A virtual private network (VPN) provides a secure encrypted connection across another network. VPNs typically are deployed to connect two or more trusted private networks to one another over an untrusted network such as the internet. Traffic is encrypted while traveling over the untrusted network to prevent a third party from eavesdropping on the network communication.

You're responsible for networking at Adatum, a home maintenance, security, and automation company. Adatum has several multi-tier applications that run on Windows and Linux virtual machines. These virtual machines are in the process of being migrated from an on-premises datacenter to the Microsoft Azure cloud. These applications store sensitive customer information, and the virtual machines that host them should never be exposed directly to the internet.

Adatum has a large number of remote workers who use laptop computers to interact with these applications. Because the VMs that host the applications are connected to the Adatum on-premises internal network, these remote workers use a third-party VPN to connect to that internal network to access these applications. Users at Adatum's main office make direct connections to the applications. The applications don't require significant amounts of bandwidth to operate successfully and are resilient to fluctuations in latency.

You want to ensure that remote workers are able to securely connect to these applications when the migration to Azure is complete. You also want to ensure that workers connected to Adatum's internal network are able to connect to the applications without concern about their network traffic being intercepted. In future, Adatum is also likely to deploy more subnets on its virtual networks, and to also deploy more IaaS workloads on virtual networks around the world. The possibility of an expansion of virtual networks and subnets should be incorporated into any solution that you decide upon.

This module explains what Azure VPN Gateway does, how it works, and when you should choose to use Azure VPN Gateway as a solution to meet your organization's needs.

## Learning objectives

In this module, you'll:

- Learn what Azure VPN Gateway is and the functionality it provides.
- Determine whether Azure VPN Gateway meets the needs of your organization.

## Prerequisites

Understanding of basic networking concepts
