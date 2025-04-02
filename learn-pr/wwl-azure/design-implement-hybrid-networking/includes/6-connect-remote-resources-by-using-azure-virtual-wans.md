

Today’s workforce is more distributed than ever before. Organizations are exploring options that enable their employees, partners, and customers to connect to the resources they need from wherever they are. It’s not unusual for organizations to operate across national/regional boundaries, and across time zones.

## What is Azure Virtual WAN?

[Azure Virtual WAN](/azure/virtual-wan/virtual-wan-about) is a networking service that brings many networking, security, and routing functionalities together to provide a single operational interface. Some of the main features include:

- Branch connectivity (via connectivity automation from Virtual WAN Partner devices such as SD-WAN or VPN CPE).
- Site-to-site VPN connectivity.
- Remote user VPN connectivity (point-to-site).
- Private connectivity (ExpressRoute).
- Intra-cloud connectivity (transitive connectivity for virtual networks).
- VPN ExpressRoute inter-connectivity.
- Routing, Azure Firewall, and encryption for private connectivity.

This diagram shows an organization with two Virtual WAN hubs connecting the spokes. VNets, Site-to-site and point-to-site VPNs, SD WANs, and ExpressRoute connectivity are all supported.

:::image type="content" source="../media/azure-wan-regions-a420bb18.png" alt-text="Diagram of two Virtual WAN hubs.":::

To configure an end-to-end virtual WAN, you create:

- **Virtual WAN**. This resource represents a virtual overlay of your Azure network and is a collection of multiple resources. It contains links to all your virtual hubs that you would like to have within the virtual WAN. Virtual WANs are isolated from each other and can't contain a common hub.
- **Hub**. A virtual hub is a Microsoft-managed virtual network. The hub contains various service endpoints to enable connectivity.
- **Hub virtual network connection**. The hub virtual network connection resource is used to connect the hub seamlessly to your virtual network. One virtual network can be connected to only one virtual hub.
- **Hub-to-hub connection**. Hubs are all connected to each other in a virtual WAN.
- **Hub route table**. You can create a virtual hub route and apply the route to the virtual hub route table. You can apply multiple routes to the virtual hub route table.
- **Site (optional)**. This resource is used for site-to-site connections only. 

### Virtual WAN usage cases

This video reviews the basics of how Virtual WANs work. 

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=70d2fdaa-8b19-4e08-9845-71426ce0504e]

### Choose a Virtual WAN SKU

The Virtual WAN SKUs are: Basic and Standard. This table shows the available configurations for each type.

| **Virtual WAN type** | **Hub type** |                                             **Available configurations**                                              |
|:--------------------:|:------------:|:---------------------------------------------------------------------------------------------------------------------:|
|        Basic         |    Basic     |                                                 Site-to-site VPN only                                                 |
|       Standard       |   Standard   | ExpressRoute<br>User VPN (P2S)<br>VPN (site-to-site)<br>Inter-hub and VNet-to-VNet transiting through the virtual hub<br>Azure Firewall<br>NVA in a virtual WAN|