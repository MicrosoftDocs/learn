


It is possible to establish direct connectivity to an Azure virtual network from a physical computer or virtual machine not hosted in Azure by using one of the following methods:

- **A point-to-site VPN**, which connects individual computers to an Azure virtual network via a Secure Socket Tunneling Protocol (SSTP) tunnel or OpenVPN over the internet.
- **A site-to-site VPN**, which connects an on-premises network to an Azure virtual network via an IPsec tunnel over the internet.
- **Azure ExpressRoute**, which connects an on-premises network via a private connection. ExpressRoute provides more predictable performance, with higher bandwidth and lower latency than VPN connections. ExpressRoute offers per-circuit throughput of up to 10 gigabits per second (Gbps), with the per-gateway throughput of up to 9000 megabits per second (Mbps). These capabilities make ExpressRoute the preferred choice for enterprise and mission-critical workloads. ExpressRoute also might be worth considering when implementing an Azure region as a disaster recovery site or as the backup destination for on-premises systems.
- **Azure Virtual WAN**, which provides optimized and automated branch-to-branch connectivity through Azure. Virtual WAN lets you connect and configure branch devices to communicate with Azure. Connectivity and configuration can be performed manually by customers or streamlined by using preferred provider devices through a Virtual WAN partner. Using preferred provider devices allows ease of use, simplification of connectivity, and configuration management.

## About ExpressRoute Direct

ExpressRoute Direct gives you the ability to connect directly into Microsoft’s global network at peering locations strategically distributed around the world. ExpressRoute Direct provides dual 100 Gbps or 10 Gbps connectivity, which supports Active/Active connectivity at scale. You can work with any service provider for ER Direct.

Key features of ExpressRoute Direct include:

- Massive Data Ingestion into services like Storage and Cosmos DB.
- Physical isolation for industries that are regulated and require dedicated and isolated connectivity like: Banking, Government, and Retail.
- Granular control of circuit distribution based on business unit.

To establish direct connectivity from another Azure virtual network, you can use one of the following methods:

- **VNet Peering** connects Azure virtual networks within the same Azure region or between Azure regions. The traffic between virtual networks flows directly over the Azure backbone network, without IPSec encryption.
- **VNet-to-VNet** connects Azure virtual networks in the same Azure region or in different Azure regions via a pair of virtual gateways that encrypt network traffic. Using VNet-to-VNet is like a site-to-site VPN. However, in this case, cross-region traffic doesn’t traverse the internet but is routed over the Azure backbone network.

## About ExpressRoute FastPath

ExpressRoute virtual network gateway is designed to exchange network routes and route network traffic. FastPath is designed to improve the data path performance between your on-premises network and your virtual network. When enabled, FastPath sends network traffic directly to virtual machines in the virtual network, bypassing the gateway.

### Requirements

**Circuits**

FastPath is available on all ExpressRoute circuits. Public preview support for Private Link connectivity over FastPath is available for connections associated to ExpressRoute Direct circuits. Connections associated to ExpressRoute partner circuits aren't eligible for the preview.

**Gateways**

FastPath still requires a virtual network gateway to be created to exchange routes between virtual network and on-premises network. For more information about virtual network gateways and ExpressRoute, including performance information and gateway SKUs, see [ExpressRoute virtual network gateways](/azure/expressroute/expressroute-about-virtual-network-gateways).

To configure FastPath, the virtual network gateway must be either:

* Ultra Performance
* ErGw3AZ

### Limitations

While FastPath supports most configurations, it doesn't support the following features:

* Basic Load Balancer: If you deploy a Basic internal load balancer in your virtual network or the Azure PaaS service you deploy in your virtual network uses a Basic internal load balancer, the network traffic from your on-premises network to the virtual IPs hosted on the Basic load balancer will be sent to the virtual network gateway. The solution is to upgrade the Basic load balancer to a [Standard load balancer](/azure/load-balancer/load-balancer-overview).

* Private Link: If you connect to a [private endpoint](/azure/private-link/private-link-overview) in your virtual network from your on-premises network, over a non-100Gbps ExpressRoute Direct circuit, the connection will go through the virtual network gateway. FastPath Connectivity to a private endpoint over a 100Gb ExpressRoute Direct circuit is supported.

**IP address limits**

:::row:::
  :::column:::
    **ExpressRoute SKU**
  :::column-end:::
  :::column:::
    **Bandwidth**
  :::column-end:::
  :::column:::
    **FastPath IP limit**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ExpressRoute Direct Port
  :::column-end:::
  :::column:::
    100Gbps
  :::column-end:::
  :::column:::
    200,000
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ExpressRoute Direct Port
  :::column-end:::
  :::column:::
    10Gbps
  :::column-end:::
  :::column:::
    100,000
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ExpressRoute provider circuit
  :::column-end:::
  :::column:::
    10Gbps and lower
  :::column-end:::
  :::column:::
    25,000
  :::column-end:::
:::row-end:::

> [!NOTE]
> * ExpressRoute Direct has a cumulative limit at the port level.
> * Traffic will flow through the ExpressRoute gateway when these limits are reached.

## Optional demo

- [Demonstration: Explore VNet to VNet connections](https://github.com/MicrosoftLearning/AZ-120-Planning-and-Administering-Microsoft-Azure-for-SAP-Workloads/blob/master/Demos/demo-explore-vnet-vnet-connections.md)
