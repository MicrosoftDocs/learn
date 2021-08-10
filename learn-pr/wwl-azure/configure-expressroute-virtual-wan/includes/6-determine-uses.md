Azure Virtual WAN is a networking service that provides optimized and automated branch connectivity to, and through, Azure. Azure regions serve as hubs that you can choose to connect your branches to. You use the Azure backbone to connect branches and enjoy branch-to-VNet connectivity. There is a list of partners that support connectivity automation with Azure Virtual WAN VPN.

Azure Virtual WAN brings together many Azure cloud connectivity services such as site-to-site VPN, User VPN (point-to-site), and ExpressRoute into a single operational interface. Connectivity to Azure VNets is established by using virtual network connections. The global transit network architecture based on a hub-and-spoke connectivity model. The cloud hosted network 'hub' enables transitive connectivity between endpoints that may be distributed across different types of 'spokes'.

:::image type="content" source="../media/virtual-wide-area-networks-2e1efc3e.png" alt-text="ExpressRoute, S2S, and P2S connections are using a Virtual WAN to access Azure virtual networks.":::


## Virtual WAN advantages

 -  **Integrated connectivity solutions in hub and spoke**. Automate site-to-site configuration and connectivity between on-premises sites and an Azure hub.
 -  **Automated spoke setup and configuration**. Connect your virtual networks and workloads to the Azure hub seamlessly.
 -  **Intuitive troubleshooting**. You can see the end-to-end flow within Azure, and then use this information to take required actions.

## Virtual WAN types

There are two types of virtual WANs: Basic and Standard.

:::row:::
  :::column:::
    **Virtual WAN type**
  :::column-end:::
  :::column:::
    **Hub type**
  :::column-end:::
  :::column:::
    **Available configurations**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Basic**
  :::column-end:::
  :::column:::
    Basic
  :::column-end:::
  :::column:::
    Site-to-site VPN only
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Standard**
  :::column-end:::
  :::column:::
    Standard
  :::column-end:::
  :::column:::
    ExpressRoute, User VPN (P2S). VPN (site-to-site), Inter-hub, and VNet-to-VNet transiting through the virtual hub.
  :::column-end:::
:::row-end:::
