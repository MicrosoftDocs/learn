A VPN gateway is a specific type of virtual network gateway that is used to send encrypted traffic between an Azure virtual network and an on-premises location over the public Internet. You also use a VPN gateway to send encrypted traffic between Azure virtual networks over the Microsoft network.

Each virtual network can have only one VPN gateway. However, you can create multiple connections to the same VPN gateway. When you create multiple connections to the same VPN gateway, all VPN tunnels share the available gateway bandwidth.

:::image type="content" source="../media/virtual-gateways-5cd58717.png" alt-text="VNet1 and VNet2 have a network to network connection using VPN Gateways. VNet1 also has a site-to-site connection to an on-premises network. The connections use IPsec IKEv2 tunnels.":::


 -  **Site-to-site** connections connect on-premises datacenters to Azure virtual networks
 -  **VNet-to-VNet** connections connect Azure virtual networks (custom)
 -  **Point-to-site (User VPN)** connections connect individual devices to Azure virtual networks

A virtual network gateway is composed of two or more VMs that are deployed to a specific subnet you create called the gateway subnet. Virtual network gateway VMs contain routing tables and run specific gateway services. These VMs are created when you create the virtual network gateway. You can't directly configure the VMs that are part of the virtual network gateway.

VPN gateways can be deployed in Azure Availability Zones. Availability zones bring resiliency, scalability, and higher availability to virtual network gateways. Availability Zones physically and logically separates gateways within a region, while protecting your on-premises network connectivity to Azure from zone-level failures.

> [!NOTE]
> Creating a virtual network gateway can take up to 45 minutes to complete.
