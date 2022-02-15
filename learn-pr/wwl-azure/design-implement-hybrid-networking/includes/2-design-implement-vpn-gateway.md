Networks that connect on-premises resources and virtual resources are known as hybrid networks. One option for connecting an on-premises network to an Azure VNET is a VPN connection. A virtual private network (VPN) is a type of private interconnected network. VPNs use an encrypted tunnel within another network. They are typically deployed to connect two or more trusted private networks to one another over an untrusted network, usually the public Internet. Traffic is encrypted while traveling over the untrusted network to prevent eavesdropping or other attacks.

To integrate your on-premises environment with Azure, you need the ability to create an encrypted connection. You can connect over the internet, or over a dedicated link. Here, we'll look at Azure VPN Gateway, which provides an endpoint for incoming connections from on-premises environments.

When you're working toward integrating your on-premises network with Azure, there needs to be a bridge between them. VPN Gateway is an Azure service that provides this functionality. A VPN gateway can send encrypted traffic between the two networks. VPN gateways support multiple connections, which enable them to route VPN tunnels that use any available bandwidth. Each virtual network can have only one VPN gateway. All connections to that VPN gateway share the available network bandwidth. VPN gateways can also be used for connections between virtual networks in Azure.

## Azure VPN Gateways

Within each virtual network gateway there are two or more virtual machines (VMs). These VMs have been deployed to a special subnet that you specify, called the gateway subnet. They contain routing tables for connections to other networks, along with specific gateway services. These VMs and the gateway subnet are similar to a hardened network device. You don't need to configure these VMs directly and should not deploy any additional resources into the gateway subnet.

Creating a virtual network gateway can take some time to complete, so it's vital that you plan appropriately. When you create a virtual network gateway, the provisioning process generates the gateway VMs and deploys them to the gateway subnet. These VMs will have the settings that you configure on the gateway.

Now, let's look at the factors you need to consider for planning your VPN gateway.

## Plan a VPN gateway

When you're planning a VPN gateway, there are three architectures to consider:

 -  Point to site over the internet
 -  Site to site over the internet
 -  Site to site over a dedicated network, such as Azure ExpressRoute

### Planning factors

Factors that you need to cover during your planning process include:

 -  Throughput - Mbps or Gbps
 -  Backbone - Internet or private?
 -  Availability of a public (static) IP address
 -  VPN device compatibility
 -  Multiple client connections or a site-to-site link?
 -  VPN gateway type
 -  Azure VPN Gateway SKU

### Choose the appropriate Gateway SKU and Generation

When you create a virtual network gateway, you need to specify the gateway SKU that you want to use. Select the SKU that satisfies your requirements based on the types of workloads, throughputs, features, and SLAs. The table below shows the available SKUs and what S2S and P2S configurations they support.

| **VPN Gateway Generation** | **SKU**  | **S2S/VNet-to-Vnet Tunnels** | **P2S SSTP Connections** | **P2S IKEv2/OpenVPN Connections** | **Aggregate Throughput Benchmark** |    **BGP**    | **Zone-redundant** |
|:--------------------------:|:--------:|:----------------------------:|:------------------------:|:---------------------------------:|:----------------------------------:|:-------------:|:------------------:|
|        Generation1         |  Basic   |           Max. 10            |         Max. 128         |           Not Supported           |              100 Mbps              | Not Supported |         No         |
|        Generation1         |  VpnGw1  |          Max. 30\*           |         Max. 128         |             Max. 250              |              650 Mbps              |   Supported   |         No         |
|        Generation1         |  VpnGw2  |          Max. 30\*           |         Max. 128         |             Max. 500              |               1 Gbps               |   Supported   |         No         |
|        Generation1         |  VpnGw3  |          Max. 30\*           |         Max. 128         |             Max. 1000             |             1.25 Gbps              |   Supported   |         No         |
|        Generation1         | VpnGw1AZ |          Max. 30\*           |         Max. 128         |             Max. 250              |              650 Mbps              |   Supported   |        Yes         |
|        Generation1         | VpnGw2AZ |          Max. 30\*           |         Max. 128         |             Max. 500              |               1 Gbps               |   Supported   |        Yes         |
|        Generation1         | VpnGw3AZ |          Max. 30\*           |         Max. 128         |             Max. 1000             |             1.25 Gbps              |   Supported   |        Yes         |
|        Generation2         |  VpnGw2  |          Max. 30\*           |         Max. 128         |             Max. 500              |             1.25 Gbps              |   Supported   |         No         |
|        Generation2         |  VpnGw3  |          Max. 30\*           |         Max. 128         |             Max. 1000             |              2.5 Gbps              |   Supported   |         No         |
|        Generation2         |  VpnGw4  |          Max. 30\*           |         Max. 128         |             Max. 5000             |               5 Gbps               |   Supported   |         No         |
|        Generation2         |  VpnGw5  |          Max. 30\*           |         Max. 128         |            Max. 10000             |              10 Gbps               |   Supported   |         No         |
|        Generation2         | VpnGw2AZ |          Max. 30\*           |         Max. 128         |             Max. 500              |             1.25 Gbps              |   Supported   |        Yes         |
|        Generation2         | VpnGw3AZ |          Max. 30\*           |         Max. 128         |             Max. 1000             |              2.5 Gbps              |   Supported   |        Yes         |
|        Generation2         | VpnGw4AZ |          Max. 30\*           |         Max. 128         |             Max. 5000             |               5 Gbps               |   Supported   |        Yes         |
|        Generation2         | VpnGw5AZ |          Max. 30\*           |         Max. 128         |            Max. 10000             |              10 Gbps               |   Supported   |        Yes         |

(\*) Use Virtual WAN if you need more than 30 S2S VPN tunnels.

 -  The resizing of VpnGw SKUs is allowed within the same generation, except resizing of the Basic SKU. The Basic SKU is a legacy SKU and has feature limitations. To move from Basic to another VpnGw SKU, you must delete the Basic SKU VPN gateway and create a new gateway with the desired Generation and SKU size combination.
 -  These connection limits are separate. For example, you can have 128 SSTP connections and 250 IKEv2 connections on a VpnGw1 SKU.
 -  On a single tunnel a maximum of 1 Gbps throughput can be achieved. Aggregate Throughput Benchmark in the above table is based on measurements of multiple tunnels aggregated through a single gateway. The Aggregate Throughput Benchmark for a VPN Gateway is S2S + P2S combined. If you have a lot of P2S connections, it can negatively impact a S2S connection due to throughput limitations. The Aggregate Throughput Benchmark is not a guaranteed throughput due to Internet traffic conditions and your application behaviors.

## VPN types

When you create the virtual network gateway for a VPN gateway configuration, you must specify a VPN type. The VPN type that you choose depends on the connection topology that you want to create. For example, a P2S connection requires a RouteBased VPN type. A VPN type can also depend on the hardware that you are using. S2S configurations require a VPN device. Some VPN devices only support a certain VPN type.

The VPN type you select must satisfy all the connection requirements for the solution you want to create. For example, if you want to create a S2S VPN gateway connection and a P2S VPN gateway connection for the same virtual network, use VPN type RouteBased because P2S requires a RouteBased VPN type. You would also need to verify that your VPN device supported a RouteBased VPN connection.

Once a virtual network gateway has been created, you can't change the VPN type. You must delete the virtual network gateway and create a new one. There are two VPN types:

### PolicyBased

PolicyBased VPNs were previously called static routing gateways in the classic deployment model. Policy-based VPNs encrypt and direct packets through IPsec tunnels based on the IPsec policies configured with the combinations of address prefixes between your on-premises network and the Azure VNet. The policy (or traffic selector) is usually defined as an access list in the VPN device configuration. The value for a PolicyBased VPN type is PolicyBased. When using a PolicyBased VPN, keep in mind the following limitations:

PolicyBased VPNs can only be used on the Basic gateway SKU. This VPN type is not compatible with other gateway SKUs.

You can have only 1 tunnel when using a PolicyBased VPN.

You can only use PolicyBased VPNs for S2S connections, and only for certain configurations. Most VPN Gateway configurations require a RouteBased VPN.

### RouteBased

RouteBased VPNs were previously called dynamic routing gateways in the classic deployment model. RouteBased VPNs use "routes" in the IP forwarding or routing table to direct packets into their corresponding tunnel interfaces. The tunnel interfaces then encrypt or decrypt the packets in and out of the tunnels. The policy (or traffic selector) for RouteBased VPNs are configured as any-to-any (or wild cards). The value for a RouteBased VPN type is RouteBased.

## VPN Gateway configuration requirements

The following table lists the requirements for PolicyBased and RouteBased VPN gateways. This table applies to both the Resource Manager and classic deployment models. For the classic model, PolicyBased VPN gateways are the same as Static gateways, and Route-based gateways are the same as Dynamic gateways.

|           **Features**            | **PolicyBased Basic VPN Gateway** |                    **RouteBased Basic VPN Gateway**                    |                  **RouteBased Standard VPN Gateway**                   |              **RouteBased High Performance VPN Gateway**               |
|:---------------------------------:|:---------------------------------:|:----------------------------------------------------------------------:|:----------------------------------------------------------------------:|:----------------------------------------------------------------------:|
|  Site-to-Site connectivity (S2S)  |   PolicyBased VPN configuration   |                      RouteBased VPN configuration                      |                      RouteBased VPN configuration                      |                      RouteBased VPN configuration                      |
| Point-to-Site connectivity (P2S)  |           Not supported           |                    Supported (Can coexist with S2S)                    |                    Supported (Can coexist with S2S)                    |                    Supported (Can coexist with S2S)                    |
|       Authentication method       |          Pre-shared key           | Pre-shared key for S2S connectivity, Certificates for P2S connectivity | Pre-shared key for S2S connectivity, Certificates for P2S connectivity | Pre-shared key for S2S connectivity, Certificates for P2S connectivity |
| Maximum number of S2S connections |                 1                 |                                   10                                   |                                   10                                   |                                   30                                   |
| Maximum number of P2S connections |           Not supported           |                                  128                                   |                                  128                                   |                                  128                                   |
| Active routing support (BGP) (\*) |           Not supported           |                             Not supported                              |                               Supported                                |                               Supported                                |

(\*) BGP is not supported for the classic deployment model.

### Create the VPN Gateway

The VPN gateway settings that you chose are critical to creating a successful connection. 
:::image type="content" source="../media/vpn-gateway-config-79862df4.png" alt-text="Create a virtual network gateway page in the Azure portal":::


 -  Gateway type. VPN or ExpressRoute.
 -  VPN Type. Route based or Policy based. Most VPN types are Route-based. The type of VPN you choose depends on the make and model of your VPN device, and the kind of VPN connection you intend to create. Typical route-based gateway scenarios include point-to-site, inter-virtual network, or multiple site-to-site connections. Route-based is also selected when you coexist with an ExpressRoute gateway or if you need to use IKEv2. Policy-based gateways support only IKEv1.
 -  SKU. Use the drop-down to select a gateway SKU. Your choice will affect the number of tunnels you can have and the aggregate throughput benchmark. The benchmark is based on measurements of multiple tunnels aggregated through a single gateway. It is not a guaranteed throughput due to Internet traffic conditions and your application behaviors.
 -  Generation. Generation1 or Generation2. You cannot change generations or SKUs across generations. Basic and VpnGw1 SKUs are only supported in Generation1. VpnGw4 and VpnGw5 SKUs are only supported in Generation2.
 -  Virtual Networks. The virtual network that will be able to send and receive traffic through the virtual network gateway. A virtual network cannot be associated with more than one gateway.

> [!NOTE]
> You can view the IP address assigned to the gateway. The gateway should appear as a connected device.

### Gateway subnet

VPN Gateways require a gateway subnet. You can create a Gateway subnet before you create a VPN gateway, or you can create it during the creation of the VPN Gateway. The gateway subnet contains the IP addresses that the virtual network gateway VMs and services use. When you create your virtual network gateway, gateway VMs are deployed to the gateway subnet and configured with the required VPN gateway settings. Never deploy anything else (for example, additional VMs) to the gateway subnet. The gateway subnet must be named GatewaySubnet to work properly. Naming the gateway subnet GatewaySubnet tells Azure know that this is the subnet to deploy the virtual network gateway VMs and services to.

When you create the gateway subnet, you specify the number of IP addresses that the subnet contains. The IP addresses in the gateway subnet are allocated to the gateway VMs and gateway services. Some configurations require more IP addresses than others.

When you are planning your gateway subnet size, refer to the documentation for the configuration that you are planning to create. For example, the ExpressRoute/VPN Gateway coexist configuration requires a larger gateway subnet than most other configurations. Additionally, you may want to make sure your gateway subnet contains enough IP addresses to accommodate possible future additional configurations. While you can create a gateway subnet as small as /29, we recommend that you create a gateway subnet of /27 or larger (/27, /26 etc.) if you have the available address space to do so. This will accommodate most configurations.

### Create the Local Network Gateway

The local network gateway typically refers to the on-premises location. You give the site a name by which Azure can refer to it, then specify the IP address or FQDN of the on-premises VPN device for the connection. You also specify the IP address prefixes that will be routed through the VPN gateway to the VPN device. The address prefixes you specify are the prefixes located in the on-premises network.

:::image type="content" source="../media/local-network-gateway-9d46963c.png" alt-text="Screenshot of the Create local network gateway page. The Name is VNet1LocalNet. The IP address is 128.8.8.8. The Address space is 10.101.0.0 24.":::


**IP Address.** The public IP address of the local gateway.

**Address Space.** One or more IP address ranges (in CIDR notation) that define your local network's address space. If you plan to use this local network gateway in a BGP-enabled connection, then the minimum prefix you need to declare is the host address of your BGP Peer IP address on your VPN device.

### Configure the on-premises VPN device

There is a validated list of standard VPN devices that work well with the VPN gateway. This list was created in partnership with device manufacturers like Cisco, Juniper, Ubiquiti, and Barracuda Networks.

When your device is not listed in the validated VPN devices table, the device may still work. Contact your device manufacturer for support and configuration instructions.

To configure your VPN device, you will need:

**A shared key**. The same shared key that you specify when creating the VPN connection.

**The public IP address of your VPN gateway**. The IP address can be new or existing.

> [!NOTE]
> Depending on the VPN device that you have, you may be able to [download a VPN device configuration script](/azure/vpn-gateway/vpn-gateway-download-vpndevicescript) .

### Create the VPN Connection

Once your VPN gateways are created, you can create the connection between them. If your VNets are in the same subscription, you can use the portal.

:::image type="content" source="../media/gateway-conections-993fd031.png" alt-text="Screenshot of the Add Connection page in the Azure portal. TestVNet4GW is selected as the second virtual network gateway. The Shared key is abc123.":::


**Name**. Enter a name for your connection.

**Connection type**. Select Site-to-Site (IPSec) from the drop-down.

**Shared key (PSK)**. In this field, enter a shared key for your connection. You can generate or create this key yourself. In a site-to-site connection, the key you use is the same for your on-premises device and your virtual network gateway connection.

### Verify the VPN Connection

After you have configured all the Site-to-Site components, it is time to verify that everything is working. You can verify the connections either in the portal, or by using PowerShell.

## High availability options for VPN connections

To provide better availability for your VPN connections, there are a few options available:

 -  VPN Gateway redundancy (Active-standby)
 -  Multiple on-premises VPN devices
 -  Active-active Azure VPN gateway
 -  Combination of both

### VPN Gateway redundancy

Every Azure VPN gateway consists of two instances in an active-standby configuration. For any planned maintenance or unplanned disruption that happens to the active instance, the standby instance would take over (failover) automatically and resume the S2S VPN or VNet-to-VNet connections. The switch over will cause a brief interruption. For planned maintenance, the connectivity should be restored within 10 to 15 seconds. For unplanned issues, the connection recovery will be longer, about 1 to 3 minutes in the worst case. For P2S VPN client connections to the gateway, the P2S connections will be disconnected, and the users will need to reconnect from the client machines.

:::image type="content" source="../media/vpn-active-standby-587ca913.png" alt-text="Single Azure VPN Gateway in active standby VPN configuration.":::


### Multiple on-premises VPN devices

You can use multiple VPN devices from your on-premises network to connect to your Azure VPN gateway, as shown in the following diagram:

:::image type="content" source="../media/vpn-multiple-onprem-vpns-61d52189.png" alt-text="Multiple Azure VPN Gateways in active standby VPN configuration.":::


This configuration provides multiple active tunnels from the same Azure VPN gateway to your on-premises devices in the same location. There are some requirements and constraints:

1.  You need to create multiple S2S VPN connections from your VPN devices to Azure. When you connect multiple VPN devices from the same on-premises network to Azure, you need to create one local network gateway for each VPN device, and one connection from your Azure VPN gateway to each local network gateway.
2.  The local network gateways corresponding to your VPN devices must have unique public IP addresses in the GatewayIpAddress property.
3.  BGP is required for this configuration. Each local network gateway representing a VPN device must have a unique BGP peer IP address specified in the BgpPeerIpAddress property.
4.  You should use BGP to advertise the same prefixes of the same on-premises network prefixes to your Azure VPN gateway, and the traffic will be forwarded through these tunnels simultaneously.
5.  You must use Equal-cost multi-path routing (ECMP).
6.  Each connection is counted against the maximum number of tunnels for your Azure VPN gateway, 10 for Basic and Standard SKUs, and 30 for HighPerformance SKU.

In this configuration, the Azure VPN gateway is still in active-standby mode, so the same failover behavior and brief interruption will still happen as described above. But this setup guards against failures or interruptions on your on-premises network and VPN devices.

### Active-active VPN gateways

You can create an Azure VPN gateway in an active-active configuration, where both instances of the gateway VMs will establish S2S VPN tunnels to your on-premises VPN device, as shown the following diagram:

:::image type="content" source="../media/vpn-active-active-89241ba7.png" alt-text="Single Azure VPN Gateway in active active configuration.":::


In this configuration, each Azure gateway instance will have a unique public IP address, and each will establish an IPsec/IKE S2S VPN tunnel to your on-premises VPN device specified in your local network gateway and connection. Note that both VPN tunnels are part of the same connection. You will still need to configure your on-premises VPN device to accept or establish two S2S VPN tunnels to those two Azure VPN gateway public IP addresses.

Because the Azure gateway instances are in active-active configuration, the traffic from your Azure virtual network to your on-premises network will be routed through both tunnels simultaneously, even if your on-premises VPN device may favor one tunnel over the other. For a single TCP or UDP flow, Azure attempts to use the same tunnel when sending packets to your on-premises network. However, your on-premises network could use a different tunnel to send packets to Azure.

When a planned maintenance or unplanned event happens to one gateway instance, the IPsec tunnel from that instance to your on-premises VPN device will be disconnected. The corresponding routes on your VPN devices should be removed or withdrawn automatically so that the traffic will be switched over to the other active IPsec tunnel. On the Azure side, the switch over will happen automatically from the affected instance to the active instance.

### Dual-redundancy: active-active VPN gateways for both Azure and on-premises networks

The most reliable option is to combine the active-active gateways on both your network and Azure, as shown in the diagram below.

:::image type="content" source="../media/vpn-dual-redundancy-567620af.png" alt-text="active-active VPN gateway configuration diagram":::


Here you create and set up the Azure VPN gateway in an active-active configuration and create two local network gateways and two connections for your two on-premises VPN devices as described above. The result is a full mesh connectivity of 4 IPsec tunnels between your Azure virtual network and your on-premises network.

All gateways and tunnels are active from the Azure side, so the traffic will be spread among all 4 tunnels simultaneously, although each TCP or UDP flow will again follow the same tunnel or path from the Azure side. Even though by spreading the traffic, you may see slightly better throughput over the IPsec tunnels, the primary goal of this configuration is for high availability. And due to the statistical nature of the spreading, it is difficult to provide the measurement on how different application traffic conditions will affect the aggregate throughput.

This topology will require two local network gateways and two connections to support the pair of on-premises VPN devices, and BGP is required to allow the two connections to the same on-premises network. These requirements are the same as the above.

### Highly Available VNet-to-VNet

The same active-active configuration can also apply to Azure VNet-to-VNet connections. You can create active-active VPN gateways for both virtual networks, and connect them together to form the same full mesh connectivity of 4 tunnels between the two VNets, as shown in the diagram below:

:::image type="content" source="../media/vpn-vnet-vnet-92bddb64.png" alt-text="Highly available VNet-to-VNet VPN Gateway configuration.":::


This ensures there are always a pair of tunnels between the two virtual networks for any planned maintenance events, providing even better availability. Even though the same topology for cross-premises connectivity requires two connections, the VNet-to-VNet topology shown above will need only one connection for each gateway. Additionally, BGP is optional unless transit routing over the VNet-to-VNet connection is required.

## Troubleshoot Azure VPN Gateway

VPN Gateway connections can fail for a variety of reasons. Although a network engineer will be able to troubleshoot many connectivity issues from experience, the following Microsoft documentation provides help and guidance for resolving many common problems.

**Validate VPN throughput to a VNet**

A VPN gateway connection enables you to establish secure, cross-premises connectivity between your Virtual Network within Azure and your on-premises IT infrastructure. This article shows how to validate network throughput from the on-premises resources to an Azure virtual machine (VM). It also provides troubleshooting guidance. See [Validate VPN throughput to a virtual network - Azure VPN Gateway](/azure/vpn-gateway/vpn-gateway-validate-throughput-to-vnet).

**Point-to-Site connections**

This article lists common point-to-site connection problems that you might experience. It also discusses possible causes and solutions for these problems. See [Troubleshoot Azure point-to-site connection problems - Azure VPN Gateway](/azure/vpn-gateway/vpn-gateway-troubleshoot-vpn-point-to-site-connection-problems).

**Site-to-Site connections**

After you configure a site-to-site VPN connection between an on-premises network and an Azure virtual network, the VPN connection suddenly stops working and cannot be reconnected. This article provides troubleshooting steps to help you resolve this problem. See [Troubleshoot an Azure site-to-site VPN connection that cannot connect - Azure VPN Gateway](/azure/vpn-gateway/vpn-gateway-troubleshoot-site-to-site-cannot-connect).

**VPN and Firewall device settings**

This article provides several suggested solutions for third-party VPN or firewall devices that are used with VPN Gateway. Technical support for third-party VPN or firewall devices is provided by the device vendor. See [Community-suggested third-party VPN or firewall device settings for Azure VPN Gateway](/azure/vpn-gateway/vpn-gateway-third-party-settings).

### Troubleshoot Azure VPN Gateway using diagnostic logs

Using diagnostic logs, you can troubleshoot multiple VPN gateway related events including configuration activity, VPN Tunnel connectivity, IPsec logging, BGP route exchanges, Point to Site advanced logging.

There are several diagnostic logs you can use to help troubleshoot a problem with your VPN Gateway.

 -  **GatewayDiagnosticLog** \- Contains diagnostic logs for gateway configuration events, primary changes, and maintenance events.
 -  **TunnelDiagnosticLog** \- Contains tunnel state change events. Tunnel connect/disconnect events have a summarized reason for the state change if applicable.
 -  **RouteDiagnosticLog** \- Logs changes to static routes and BGP events that occur on the gateway.
 -  **IKEDiagnosticLog** \- Logs IKE control messages and events on the gateway.
 -  **P2SDiagnosticLog** \- Logs point-to-site control messages and events on the gateway.

Use Azure Monitor to analyze the data collected in the diagnostic logs.