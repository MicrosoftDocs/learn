
Azure Virtual WAN (wide-area network) is a networking service that provides optimized and automated branch connectivity to, and through, Azure. Azure regions serve as hubs that you can choose to connect your branches to. You use the Azure backbone to connect branches and enjoy branch-to-virtual network connectivity. 

The following illustration shows inter-site connections through Azure Virtual WAN to access Azure virtual networks. A connection is made from the on-premises location by using Azure ExpressRoute. Several branches connect through a site-to-site configuration, and remote users connect through a point-to-site (User VPN) connection.

:::image type="content" source="../media/virtual-wide-area-networks-2e1efc3e.png" alt-text="Illustration of connections with Azure Virtual WAN as described in the text." border="false":::

### Things to know about Azure Virtual WAN

Let's take a closer look at the characteristics of Azure Virtual WAN.

- Azure Virtual WAN brings together many Azure cloud connectivity services, such as S2S VPN, User VPN (P2S), and Azure ExpressRoute into a single operational interface.

- Connectivity to Azure virtual networks is established by using virtual network connections.

- The global transit network architecture is based on a hub-and-spoke connectivity model. The cloud hosted network _hub_ enables transitive connectivity between endpoints that can be distributed across different types of _spokes_.

- There are two types of virtual WANs:

   - **Basic**: A Basic Virtual WAN can be implemented only in an S2S VPN connection.

   - **Standard**: A Standard Virtual WAN can be implemented with Azure ExpressRoute and a User VPN (P2S). You can also use a Standard WAN with an S2S VPN, Inter-hub, and VNet-to-VNet connection transiting through the virtual hub.

- You can find partners that support connectivity automation with Azure Virtual WAN VPN. For more information, see [Virtual WAN partners, regions, and virtual hub locations](/azure/virtual-wan/virtual-wan-locations-partners).

### Things to consider when using Azure Virtual WAN

As you plan your Azure ExpressRoute configuration, consider the following benefits of using Azure Virtual WAN in your solution.

- **Consider integrated connectivity for hub and spoke solutions**. Gain integrated connectivity for your hub and spoke network topology by using Azure Virtual WAN. Automate the site-to-site configuration and connectivity between your on-premises sites (spokes) and an Azure hub.

- **Consider automated spoke setup and configuration**. Implement Azure Virtual WAN to connect your virtual networks and workloads to the Azure hub seamlessly.

- **Consider intuitive troubleshooting**. Azure Virtual WAN combines networking, security, and routing functionalities into a single operational interface. Monitor and troubleshoot the end-to-end flow within Azure, and then use this information to take required actions.