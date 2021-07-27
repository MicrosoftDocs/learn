The local network gateway typically refers to the on-premises location. You give the site a name by which Azure can refer to it, then specify the IP address or FQDN of the on-premises VPN device for the connection. You also specify the IP address prefixes that will be routed through the VPN gateway to the VPN device. The address prefixes you specify are the prefixes located in the on-premises network.

:::image type="content" source="../media/create-local-network-gateway-1f51c650.png" alt-text="Screenshot of the Create local network gateway page. The Name is VNet1LocalNet. The IP address is 128.8.8.8. The Address space is 10.101.0.0 24.":::


**IP Address**. The public IP address of the local gateway.

**Address Space**. One or more IP address ranges (in CIDR notation) that define your local network's address space. If you plan to use this local network gateway in a BGP-enabled connection, then the minimum prefix you need to declare is the host address of your BGP Peer IP address on your VPN device.
