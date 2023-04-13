
A VPN gateway is a specific type of virtual network gateway that's used to send encrypted traffic between your Azure virtual network and an on-premises location over the public internet. A VPN gateway can also be used to send encrypted traffic between your Azure virtual networks over the Microsoft network. 

Azure VPN Gateway is a service that uses this specific type of virtual network gateway to support encrypted traffic.

The following illustration demonstrates several ways to implement Azure VPN Gateway. The configuration shows a virtual network connection with a VPN gateway. The virtual network has a site-to-site connection to an on-premises network that uses the IPsec IKEv2 protocol.

:::image type="content" source="../media/virtual-gateways-5cd58717.png" alt-text="Diagram of a virtual network connection with a VPN gateway. The virtual network has a site-to-site connection to an on-premises network that uses the IPsec IKEv2 protocol." border="false":::

### Things to know about VPN gateways

Let's examine the prominent characteristics of VPN gateways.

- When you implement a VPN gateway, the VPN service intercepts your data and applies encryption before it reaches the internet.

- The VPN service uses a secure pathway (called a _VPN tunnel_) for movement of your data between your device and the internet. The VPN tunnel is what enables your secure connection to the internet.

- A virtual network can have only one VPN gateway.

- Multiple connections can be created to the same VPN gateway.

- When you create multiple connections to the same VPN gateway, all VPN tunnels share the available gateway bandwidth.

- A VPN gateway can be deployed in Azure availability zones to gain resiliency, scalability, and higher availability to virtual network gateways. Availability zones physically and logically separate gateways within a region, while protecting your on-premises network connectivity to Azure from zone-level failures.

#### Virtual network gateway

A virtual network gateway is composed of two or more virtual machines that are deployed to a specific subnet that you create called the _gateway subnet_. 

- The virtual machines are created when you create the virtual network gateway. 

- The virtual machines contain routing tables and run specific gateway services.

- You can't directly configure the virtual machines that are part of a virtual network gateway.

### Things to consider when using VPN gateways

VPN gateway connections are available in different configurations. In this module, we explore how to configure a site-to-site connection. As you develop your VPN gateway strategy, review your options and choose the configuration that best supports your business needs. Microsoft provides a [planning table](/azure/vpn-gateway/vpn-gateway-about-vpngateways#planningtable) to help your planning.

| Configuration | Scenarios | 
| --- | --- |
| **Site-to-site** <br> (S2S) | - Connect your on-premises datacenters to your Azure virtual networks through an IPsec/IKE (IKEv1 or IKEv2) VPN tunnel <br> - Support cross-premises and hybrid configurations <br> - Configure S2S VPN and Azure ExpressRoute for the same virtual network <br> - Configure S2S VPN as a secure failover path for ExpressRoute <br> - Use S2S VPNs to connect to sites outside your network that are connected through ExpressRoute |
| **Point-to-site** <br> (P2S or User VPN) | - Connect individual devices to your Azure virtual networks <br> - Create a secure connection to your virtual network from an individual client computer <br> - Useful for remote or traveling workers who want to connect to Azure virtual networks from their current location <br> - Support a few clients that need to connect to a virtual network |
| **Virtual network to virtual network** <br> (VNet-to-VNet) | - Connect one virtual network to another virtual network through an IPsec/IKE VPN tunnel <br> - Build a network that integrates cross-premises connectivity with inter-virtual network connectivity by combining VNet-to-VNet communication with multi-site connection configurations <br> - Connect virtual networks in the same or different regions <br> - Connect virtual networks in the same or different subscriptions <br> - Connect virtual networks that have the same or different deployment models |
| **Highly available** | - Support high availability for cross-premises and VNet-to-VNet connections <br> - Implement high availability for multiple on-premises VPN devices <br> - Implement high availability for an active-active Azure VPN gateway <br> - Implement high availability for a combination of multiple on-premises VPN devices and an active-active Azure VPN gateway |