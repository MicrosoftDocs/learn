Perhaps the simplest and quickest way to connect your VNets is to use VNet peering. Virtual network peering enables you to seamlessly connect two Azure virtual networks. Once peered, the virtual networks appear as one, for connectivity purposes. There are two types of VNet peering.

 -  **Regional VNet peering** connects Azure virtual networks in the same region.
 -  **Global VNet peering** connects Azure virtual networks in different regions. When creating a global peering, the peered virtual networks can exist in any Azure public cloud region or China cloud regions, but not in Government cloud regions. You can only peer virtual networks in the same region in Azure Government cloud regions.

:::image type="content" source="../media/network-peering-5beae28a.png" alt-text="Two VNets in one region and two vnets in different regions.":::


## Benefits of virtual network peering

The benefits of using local or global virtual network peering, include:

 -  **Private**. Network traffic between peered virtual networks is private. Traffic between the virtual networks is kept on the Microsoft backbone network. No public Internet, gateways, or encryption is required in the communication between the virtual networks.
 -  **Performance**. A low-latency, high-bandwidth connection between resources in different virtual networks.
 -  **Communication**. The ability for resources in one virtual network to communicate with resources in a different virtual network, once the virtual networks are peered.
 -  **Seamless**. The ability to transfer data across Azure subscriptions, deployment models, and across Azure regions.
 -  **No disruption**. No downtime to resources in either virtual network when creating the peering, or after the peering is created.
