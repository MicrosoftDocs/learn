You've learned about the purpose of the Azure ExpressRoute service, and the services for which you can use it. Now you're ready to start learning about how the service works. Let's examine how it interacts with Azure and on-premises networks to help create a secure and reliable connection between your on-premises datacenter and the Microsoft cloud.

In this unit, you learn how to create and use Azure circuits to connect your on-premises networks to the cloud. You see the steps that you need to take to create a circuit. You also learn about the other components of an ExpressRoute connection, which work together to form a connection from your on-premises datacenter to the Microsoft cloud.

## Architecture of ExpressRoute

ExpressRoute is supported across all regions and locations. To implement ExpressRoute, you need to work with an ExpressRoute partner. The partner provides the *edge service*: an authorized and authenticated connection that operates through a partner-controlled router. The edge service is responsible for extending your network to the Microsoft cloud.

The partner sets up connections to an endpoint in an ExpressRoute location (implemented by a Microsoft edge router). These connections allow you to peer your on-premises networks with the virtual networks available through the endpoint. These connections are called *circuits*.

![Diagram of a high-level overview of the Azure ExpressRoute service.](../media/3-azure-expressroute-overview.svg)

> [!NOTE]
> In the context of ExpressRoute, the Microsoft Edge describes the edge routers on the Microsoft side of the ExpressRoute circuit.

A circuit provides a physical connection for transmitting data through the ExpressRoute provider's edge routers to the Microsoft edge routers. A circuit is established across a private wire rather than the public internet. Your on-premises network is connected to the ExpressRoute provider's edge routers. The Microsoft edge routers provide the entry point to the Microsoft cloud.

## Prerequisites for ExpressRoute

Before you can connect to Microsoft cloud services by using ExpressRoute, you need to have:

- An ExpressRoute connectivity partner or cloud exchange provider that can set up a connection from your on-premises networks to the Microsoft cloud.
- An Azure subscription that is registered with your chosen ExpressRoute connectivity partner.
- An active Microsoft Azure account that can be used to request an ExpressRoute circuit.
- An active Office 365 subscription (if you want to connect to the Microsoft cloud and access Office 365 services).

ExpressRoute works by peering your on-premises networks with networks running in the Microsoft cloud. Resources on your networks can communicate directly with resources hosted by Microsoft. To support these peerings, ExpressRoute has several network and routing requirements:

- Ensure that BGP sessions for routing domains have been configured. Depending on your partner, this configuration might be their or your responsibility. Additionally, for each ExpressRoute circuit, Microsoft requires redundant BGP sessions between Microsoft’s routers and your peering routers.
- You or your providers need to translate the private IP addresses used on-premises to public IP addresses by using a NAT service. Microsoft rejects anything except public IP addresses through Microsoft peering.
- Reserve several blocks of IP addresses in your network for routing traffic to the Microsoft cloud. You configure these blocks as either a /29 subnet or two /30 subnets in your IP address space. One of these subnets is used to configure the primary link to the Microsoft cloud, and the other implements a secondary link. The first address in these subnets represents your end of the BGP peer, and the second address is Microsoft's BGP peer IP.

ExpressRoute supports two peering schemes:

- Use private peering to connect to Azure IaaS and PaaS services deployed inside Azure virtual networks. The resources that you access must all be located in one or more Azure virtual networks with private IP addresses. You can't access resources through their public IP address over a private peering.
- Use Microsoft peering to connect to Azure PaaS services, Office 365 services, and Dynamics 365.

![Diagram of Azure peering.](../media/3-azure-peering.svg)

> [!NOTE]
> You can also use the Azure portal to configure public peering. This form of peering enables you to connect to the public addresses exposed by Azure services. However, this peering is deprecated and is not available for new circuits. This module does not describe public peering.

## Create an ExpressRoute circuit and peering

Establishing a connection to Azure through ExpressRoute is a multistep process. You can perform many of these steps either by using the Azure portal, or from the command line by using PowerShell or the Azure CLI. This section describes the process of using the Azure portal. For PowerShell and CLI instructions, see the "Learn more" section at the end of this module.

### Create a circuit

When you're using the Azure portal, select **+ Create a resource** and search for **ExpressRoute**. The **Create ExpressRoute circuit** page requires you to complete the following fields:

#### Basics tab

| Property  | Value  |
|---|---|
| **Subscription** | The subscription you've registered with your ExpressRoute provider. |
| **Resource group** | The Azure resource group in which to create the circuit. |
| **Region** | The Azure location in which to create the circuit. |
| **Name** | A meaningful name for your circuit, without any white space or special characters. |

:::image type="content" source="../media/3-create-circuit-basics.png" alt-text="Screenshot showing the Create ExpressRoute Basics tab by using the Azure portal.":::

#### Configuration tab

| Property  | Value  |
|---|---|
| **Port type** | Select **Provider** if you're connecting through a service provider or select **Direct** if you're connecting directly to Microsoft. |
| **Create new or import from classic** | Create a new circuit or select **Import** to move an existing circuit from classic model to Resource Manager. |
| **Provider** | The ExpressRoute provider with which you've registered your subscription.  |
| **Peering location** | A location enabled by the ExpressRoute provider in which to create your circuit. |
| **Bandwidth** | Select your bandwidth, from 50 Mbps up to 10 Gbps. Start with a low value. You can increase it later with no interruption to service. However, you can't reduce the bandwidth if you set it too high initially. |
| **SKU** | Select **Local** (if available) if you only need to connect to Azure resource in 1 or 2 Azure regions in the same metro. Select **Standard** if you have up to 10 virtual networks and only need to connect to resources in the same geographical region. Otherwise, select **Premium** which allows you to connect more than 10 virtual networks and global connectivity to Azure resources. |
| **Billing model** | Select **Unlimited** to pay a flat fee regardless of usage. Or select **Metered** to pay according to the volume of traffic that enters and exits the circuit. |
| **Allow classic operations** | Select **Yes** allows classic virtual networks to connect to the circuit. Otherwise, select **No**. |

:::image type="content" source="../media/3-create-circuit-configuration.png" alt-text="Screenshot showing the Create ExpressRoute Configuration tab by using the Azure portal.":::

Circuit creation can take several minutes. After the circuit has been provisioned, you can use the Azure portal to view the properties. You can see that **Circuit status** is enabled, meaning that the Microsoft side of the circuit is ready to accept connections. **Provider status** is set to **Not provisioned** initially because the provider hasn't configured their side of the circuit for connecting to your network.

You send the provider the value in the **Service key** field to allow them to configure the connection. This configuration can take several days. You can revisit this page to check the provider status.

:::image type="content" source="../media/3-provision-circuit.png" alt-text="Screenshot of provisioning a circuit by using the Azure portal.":::

### Create a peering configuration

After the provider status is reported as **Provisioned**, you can configure the routing for the peerings. These steps apply only to circuits that are created with service providers who offer Layer 2 connectivity. For any circuits that operate at Layer 3, the provider might be able to configure the routing for you.

The **ExpressRoute circuit** page shown earlier lists each peering and its properties. You can select a peering to configure these properties.

### Configure private peering

You can use private peering to connect your network to your virtual networks running in Azure. To configure private peering, you must provide the following information:

- **Peer ASN**: The autonomous system number for your side of the peering. This ASN can be public or private, and 16 bits or 32 bits.
- **Subnets**: Select if you want to use IPv4, IPv6 or both for the peering subnets.
- **Primary subnet**: The address range of the primary /30 subnet that you created in your network. You use the first IP address in this subnet for your router. Microsoft uses the second for its router.
- **Secondary subnet**: The address range of your secondary /30 subnet. This subnet provides a secondary link to Microsoft. The first two addresses are used to hold the IP address of your router and the Microsoft router.
- **Enable IPv4 Peering**: This option allows you to enable and disable the private peering BGP session.
- **VLAN ID**: The ID of the VLAN on which to establish the peering. The primary and secondary links both use this VLAN ID.
- **Shared key**: This key is an optional MD5 hash that's used to encode messages passing over the circuit.

### Configure Microsoft peering

You use Microsoft peering to connect to Office 365 and its associated services. To configure Microsoft peering, you provide much of the information described for a private peering: A peer ASN, a primary subnet address range, a secondary subnet address range, subnet IP version, a VLAN ID, and an optional shared key. You must also provide the following information:

- **Advertised public prefixes**: A list of the address prefixes that you use over the BGP session. These prefixes must be registered to you, and must be prefixes for public address ranges.
- **Customer ASN**: An optional client-side autonomous system number to use if you're advertising prefixes that aren't registered to the peer ASN.
- **Routing registry name**: This name identifies the registry in which the customer ASN and public prefixes are registered.

## Connect a virtual network to an ExpressRoute circuit

After the ExpressRoute circuit has been established, Azure private peering is configured for your circuit. The BGP session between your network and Microsoft is active, so you can enable connectivity from your on-premises network to Azure.

Before you can connect to a private circuit, you must create an Azure virtual network gateway by using a subnet on one of your Azure virtual networks. The virtual network gateway provides the entry point to network traffic that enters from your on-premises network. It directs incoming traffic through the virtual network to your Azure resources.

You can configure network security groups and firewall rules to control the traffic that's routed from your on-premises network. You can also block requests from unauthorized addresses in your on-premises network.

> [!NOTE]
> You must create the virtual network gateway by using the type **ExpressRoute** and not **VPN**.
>
> :::image type="content" source="../media/3-create-virtual-network-gateway.png" alt-text="Screenshot of creating a virtual network gateway with the gateway type set to ExpressRoute.":::

Up to 10 virtual networks can be linked to an ExpressRoute circuit, but these virtual networks must be in the same geographical region as the ExpressRoute circuit. You can link a single virtual network to four ExpressRoute circuits if necessary. The ExpressRoute circuit can be in the same subscription to the virtual network, or in a different one.

If you're using the Azure portal, you connect a peering to a virtual network gateway as follows:

1. On the **ExpressRoute circuit** page for your circuit, select **Connections**.
1. On the **Connections** page, select **Add**.
1. On the **Add connection** page, give your connection a name, and then select your virtual network gateway. When the operation has finished, your on-premises network is connected through the virtual network gateway to your virtual network in Azure. The connection is made across the ExpressRoute connection.

## High availability and failover with ExpressRoute

In each ExpressRoute circuit, there are two connections from the connectivity provider to two different Microsoft edge routers. This configuration occurs automatically. It provides a degree of availability within a single location.

Consider setting up ExpressRoute circuits in different peering locations to provide high availability and help protect against a regional outage. For example, you might create circuits in the US East and US Central regions and connect these circuits to your virtual network. This way, if one ExpressRoute circuit goes down, you don't lose connectivity to your resource, and you can fail over the connection to another ExpressRoute circuit.

You can also have multiple circuits across different providers to ensure that your network stays available even if an outage affects all circuits from a single approved provider. You can set the **Connection Weight** property to prefer one circuit to another.

## ExpressRoute Direct and FastPath

Microsoft also provides an ultra-high-speed option called ExpressRoute Direct. This service enables dual 100-Gbps connectivity. It's suitable for scenarios that involve massive and frequent data ingestion. It's also suitable for solutions that require extreme scalability, such as banking, government, and retail.

You can enroll your subscription with Microsoft to activate ExpressRoute Direct. For more information, visit the ExpressRoute article in the "Learn more" section at the end of this module.

ExpressRoute Direct supports FastPath. When FastPath is enabled, it sends network traffic directly to a virtual machine that's the intended destination. The traffic bypasses the virtual network gateway, improving the performance between Azure virtual networks and on-premises networks.

FastPath doesn't support virtual network peering (where you have virtual networks connected together). It also doesn't support user-defined routes on the gateway subnet.
