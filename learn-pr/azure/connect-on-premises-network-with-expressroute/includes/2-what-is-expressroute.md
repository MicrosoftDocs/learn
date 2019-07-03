As part of the project for the finance company, you need to understand how Azure ExpressRoute integrates with on-premises and Azure networks. You need to understand what Azure ExpressRoute is, the benefits it provides compared to other site to site connectivity options and whether Azure ExpressRoute service is the best service to use which will provide the finance company with the best possible network performance.

## Azure ExpressRoute Service

Azure ExpressRoute lets you seamlessly extend your on-premises networks into the Microsoft cloud. This connection between your organization and Azure is dedicated and private; you have a direct link to an Azure Datacenter. Establishing an ExpressRoute connection, enables you to connect to services like Azure, Office 365, and Dynamics 365, all of which are Microsoft cloud services. ExpressRoute provides much faster connectivity speeds than using the Internet. Security is enhanced, connections are more reliable, latency is minimal, and throughput is greatly increased.

## Features and benefits of ExpressRoute

There are several benefits to using ExpressRoute as the preferred connection service between Azure and on-premises networks. The following sections describe these benefits.

**Layer 3 connectivity**

Layer 3 (address-level) connectivity is provided between your on-premise network and Microsoft cloud through connectivity partners.  These connections can be from a point-to-point, any-to-any network, or a virtual cross-connection through an exchange. 

**Built-in redundancy**

Each connectivity provider uses redundant devices to ensure connections established with Microsoft are highly available. You can configure multiple circuits to complement this feature. All redundant connections are configured with Layer 3 connectivity to ensure SLAs are met.

**Connectivity to Microsoft Cloud services**

ExpressRoute enables direct access to the following services in all regions:

- Microsoft Office 365
  - Exchange Online
  - Skype for Business
  - SharePoint Online
  - Portal and Azure AF
- Microsoft Dynamics 365
- Microsoft Azure IaaS resources (such as Azure virtual machines) and PaaS resources (such as Azure Storage, Azure SQL Database, and Azure Cosmos DB) deployed within a virtual network.

> [!NOTE]
> Azure SaaS solutions, such as Azure Active Directory, which are designed for use across the public Internet, are not available through ExpressRoute.

Office 365 is designed to be accessed securely over the internet, but you can enable a direct network connection to a subset of Office 365 components using ExpressRoute. This approach provides an uptime SLA of 99.95% for the Microsoft network components. If you have a Multiprotocol Label Switching (MPLS) WAN, ExpressRoute can still be incorporated into the network architecture either through a cloud exchange provider, a point-point connection provider, or MPLS connection provider.

**Quality of Service support for Skype**

If you're using Skype across an ExpressRoute connection, ExpressRoute automatically adds the appropriate Quality of Service (QoS) indicators in the DCSP headers to the network packets transmitted back and forth. You should implement corresponding queues in your network to handle and prioritize the different types of traffic that can appear. For more information, see [Configuring port ranges and a Quality of Service policy for your Edge Servers in Skype for Business Serve](https://docs.microsoft.com/SkypeForBusiness/manage/network-management/qos/configuring-port-ranges-for-your-edge-servers) and  [Configuring port ranges and a Quality of Service policy for your clients in Skype for Business Server](https://docs.microsoft.com/SkypeForBusiness/manage/network-management/qos/configuring-port-ranges-for-your-skype-clients)

**Dynamic Routing**

ExpressRoute uses the Border Gateway Protocol (BGP) routing protocol. BGP is used to exchange routes between on-premise networks and resources running in Azure. This protocol enables dynamic routing between your on-premises network and services running in the Microsoft cloud.

## ExpressRoute connectivity models

ExpressRoute supports three connection models that you can use to connect between your on-premises network and the Microsoft cloud:

- CloudExchange Colocation
- Point-to-point Ethernet connection
- Any-to-any connection

![Azure Connectivity models  ](../media/2-azure-connectivity-models.png)

**Colocated at cloud exchange**

Colocated providers can normally offer both Layer 2 and Layer 3 connections between your infrastructure, which may be located in the colocation facility, and the Microsoft cloud. For example, if your datacenter is colocated at a cloud exchange such as an ISP, you can request a virtual cross-connection to the Microsoft cloud.

**Point-point Ethernet connections**

Point-to-point connections provide Layer 2 and Layer 3 connectivity between your on-premises site and Microsoft Azure.  You can connect your offices or datacenters to Azure using the point-to-point links. For example, if you have an on-premises datacenter, you can use a point-to-point Ethernet link to connect to Microsoft.

**Any-to-any networks**

With point-to-point connectivity, you can integrate your WAN with Microsoft Azure by providing connections to your offices and datacenters. Azure will integrate with your WAN connection to provide a seamless connection, just like you would have between your datacenter and any branch offices. With point-to-point connections, all WAN providers offer Layer 3 connectivity. For example, if you already use MPLS to connect to your branch offices or other sites in your organization, an ExpressRoute connection to Microsoft will behave just like another location on your private WAN.

## Security considerations

With ExpressRoute, your data doesn’t travel over the public Internet, so it's not exposed to the potential risks associated with Internet communications. ExpressRoute is a private connection from your on-premises infrastructure to your Azure infrastructure. Even if you have an ExpressRoute connection, DNS queries, certificate revocation list checking, and content delivery network (CDN) requests are still sent over the public Internet.

You can encrypt your data on-premise as normal, so that when data traverses your ExpressRoute connection, you know that the data is still secure and the risk of your data being analyzed by a malicious third party is minimal.