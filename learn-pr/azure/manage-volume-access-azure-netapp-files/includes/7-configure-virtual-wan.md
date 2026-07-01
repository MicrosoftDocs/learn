You can configure Azure NetApp Files volumes with Standard network features in one or more Virtual WAN spoke virtual networks (VNets).

Your Virtual WAN global deployments could include any combinations of different branches, Point-of-Presence (PoP), private users, offices, Azure virtual networks, and other multicloud deployments. You can use SD-WAN, site-to-site VPN, point-to-site VPN, and ExpressRoute to connect your different sites to a virtual hub.

Refer to [What is Azure Virtual WAN?](https://learn.microsoft.com/azure/virtual-wan/virtual-wan-about) to learn more about Virtual WAN.

Azure NetApp Files connectivity over Virtual WAN is supported only when using Standard networking features.

- You've configured at least one virtual hub within your Virtual WAN environment.
- You've connected at least one spoke VNet to the virtual hub for deploying Azure NetApp Files volumes.
- Once you've selected a spoke VNet, you can create the delegated Azure NetApp Files subnet within the VNet as part of the Azure NetApp Files deployment process.
- Deploying Azure NetApp Files volume with Standard network features in a Virtual WAN spoke VNet is the same process as deploying it in any VNet.
