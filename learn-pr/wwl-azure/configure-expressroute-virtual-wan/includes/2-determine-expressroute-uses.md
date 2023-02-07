---
uid: learn.wwl.configure-expressroute-virtual-wan.determine-expressroute-uses
title: Determine Azure ExpressRoute uses
description: Explore the features and usage cases for Azure ExpressRoute.
durationInMinutes: 3
---
Azure ExpressRoute lets you extend your on-premises networks into the Microsoft cloud. The connection is facilitated by a connectivity provider. With ExpressRoute, you can establish connections to Microsoft cloud services, such as Microsoft Azure, Microsoft 365, and Microsoft Dynamics CRM applications.

Microsoft network operates the primary and secondary connections of Azure ExpressRoute circuits in active-active mode. Administrators can force their redundant connections of an ExpressRoute circuit to operate in active-passive mode. 

The following illustration shows two Azure ExpressRoute circuits. Traffic flows from a customer network through the partner side into the two ExpressRoute circuits and onto the Microsoft side. The traffic continues to web applications, public IP addresses in Azure, Microsoft 365 and Dynamics CRM services, and virtual networks.

:::image type="content" source="../media/expressroute-b72c1320.png" alt-text="Illustration of two Azure ExpressRoute circuits as described in the text." border="false":::

### Things to consider when using Azure ExpressRoute

The following table summarizes the many benefits of using Azure ExpressRoute to extend your on-premises networks into the Microsoft cloud.

| Benefit | Description | Scenarios |
| --- | --- | --- |
| **Gain fast, reliable, private connections** | Azure ExpressRoute connections don't go over the public internet, and they offer more reliability, faster speeds, and lower latencies than typical internet connections. In some cases, ExpressRoute connections that transfer data between on-premises systems and Azure can yield significant cost benefits. | _Create private connections between Azure datacenters and infrastructure for your on-premises resources or in a colocation environment_ <br><br> _Establish connections to Azure at an ExpressRoute location, such as an exchange provider facility_ <br><br> _Directly connect to Azure from your existing WAN network, such as a multiprotocol label switching (MPLS) VPN provided by a network service provider_ |
| **Access a virtual private cloud for storage, backup, and recovery** | Azure ExpressRoute gives you a fast and reliable connection to Azure with bandwidths up to 100 Gbps. The high connection speeds make it excellent for scenarios that require data integrity and availability. ExpressRoute is a cost-effective option for transferring large amounts of data. | _Support periodic data migration, disaster recovery, and replication for business continuity_ <br><br> _Transfer large amounts of data like datasets for high-performance computing applications_ <br><br> _Move large virtual machines between your development and test environments_ |
| **Extend and connect your datacenters** | Azure ExpressRoute offers high throughput and low latencies. An ExpressRoute implementation operates as a natural extension to or between your datacenters. | _Connect and add compute and storage capacity to your existing datacenters_ <br><br> _Enjoy the scale and economics of the public cloud without having to compromise on network performance_ |
| **Build hybrid applications** | Azure ExpressRoute provides the functionality to help you build applications that span on-premises infrastructure and Azure without compromising privacy or performance. | _Run a corporate intranet application in Azure that authenticates your customers with an on-premises Azure Active Directory service_ <br><br> _Serve all of your corporate customers without traffic ever routing through the public internet_ |