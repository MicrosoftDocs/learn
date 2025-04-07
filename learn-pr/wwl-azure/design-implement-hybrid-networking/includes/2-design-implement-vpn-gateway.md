

Azure [VPN Gateway](/azure/vpn-gateway/vpn-gateway-about-vpngateways) is a service that can be used to send encrypted traffic between an Azure virtual network and on-premises locations over the public Internet. You can also use VPN Gateway to send encrypted traffic between Azure virtual networks over the Microsoft network. VPN Gateway uses a specific type of Azure virtual network gateway called a VPN gateway. Multiple connections can be created to the same VPN gateway. When you create multiple connections, all VPN tunnels share the available gateway bandwidth.

> [!NOTE] 
> A virtual network gateway is composed of two or more special virtual machines that are deployed to a specific subnet called the gateway subnet. Azure manages the virtual machines so they don't require administrative attention.

## Plan a VPN gateway

Creating a virtual network gateway can take some time to complete, so it's vital that you plan appropriately. Factors that you need to consider during your planning process include:

 -  Throughput - Mbps or Gbps
 -  Backbone - Internet or private?
 -  Availability of a public (static) IP address
 -  VPN device compatibility
 -  Multiple client connections or a site-to-site link?
 -  VPN gateway type
 -  VPN Gateway SKU

### VPN Gateway planning (video)

This video summarizes scenarios for VPN gateways. These scenarios include on-premises and point-to-site connections. 

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=f67524cf-ba8b-4e81-8fe3-29f75213d740]

### VPN Gateway SKUs

When you create a VPN Gateway, you must select the [gateway SKU](/azure/vpn-gateway/about-gateway-skus). You can select a SKU that satisfies your requirements based on the workload, throughput, feature, and SLAs. 

> [!TIP]
> The Basic SKU has feature and performance limitations and shouldn't be used in  production environments. 


## VPN Gateway types

When you create the virtual network gateway, you must specify a VPN type. There are two VPN gateway types: policy-based and route-based. Each VPN type has specific connection requirements. Once a virtual network gateway is created, you can't change the VPN type. 

:::image type="content" source="../media/vpn-gateway-config-79862df4.png" alt-text="Screenshot of the gateway configuration for policy and route based types.":::

**Policy-based gateways**

Policy-based VPNs were previously called static routing gateways. Policy-based VPNs encrypt and direct packets through IPsec tunnels based on the IPsec policies. The policy (or traffic selector) is defined as an access list in the VPN device configuration. When using a Policy-based VPN, keep in mind the following limitations:

- Policy-based VPNs which support IKEv1 protocols can only be used with Basic Gateway SKUs.
- You can have only one tunnel when using a policy-based VPN.
- You can only use policy-based VPNs for site-to-site connections. 

**Route-based gateways**

Route-based VPNs were previously called dynamic routing gateways. Route-based VPNs use "routes" in the IP forwarding or routing table to direct packets into their corresponding tunnel interfaces. The tunnel interfaces then encrypt or decrypt the packets in and out of the tunnels. Most VPN gateways are route-based. 


## High availability options for VPN connections

To provide better availability for your VPN connections, consider one of these options. 

 -  VPN Gateway redundancy (active-standby)
 -  Active-active Azure VPN gateway

### Active-standby Azure VPN gateways

You can create an Azure VPN gateway in an active-standby configuration. Active-active is the default configuration. In this configuration there are two instances, active and standby. The standby connection takes over when the active connection is disrupted. Switching to the standby connection causes a service disruption. 

- For planned maintenance, connectivity is restored in seconds.
- For unplanned interruptions, connectivity is restored in minutes.
- For P2S client connections, they need to reconnect. 

:::image type="content" source="../media/vpn-active-standby-587ca913.png" alt-text="Diagram of an Azure VPN Gateway in active standby configuration.":::


### Active-active Azure VPN gateways

You can create an Azure VPN gateway in an active-active configuration. In the active-active configuration, both instances of the gateway establish VPN tunnels to your on-premises VPN device. The traffic from your Azure virtual network to your on-premises network is routed through both tunnels simultaneously. If an outage occurs, Azure automatically switches to the other tunnel. 

:::image type="content" source="../media/vpn-active-active-89241ba7.png" alt-text="Diagram of an Azure VPN Gateway in active-active configuration.":::

### Gateway redundancy comparison (video)

This video reviews VPN gateway redundancy options. 

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=bc399061-c874-4da9-8cb7-282d6d01f816]