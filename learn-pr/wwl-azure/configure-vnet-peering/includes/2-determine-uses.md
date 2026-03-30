Perhaps the simplest and quickest way to connect your virtual networks is to use Azure Virtual Network peering. Virtual Network peering enables you to seamlessly connect two Azure virtual networks. After the networks are peered, the two virtual networks operate as a single network, for connectivity purposes.

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=dc8c31e3-7c1a-4377-a0c2-e415bfc1d638]

### Things to know about Azure Virtual Network peering

Let's examine some prominent characteristics of Azure Virtual Network peering.

- There are two types of Azure Virtual Network peering: _regional_ and _global_.

   :::image type="content" source="../media/network-peering-5beae28a.png" alt-text="Diagram that demonstrates the two types of Azure Virtual Network peering: global and regional." border="false":::

- **Regional virtual network peering** connects Azure virtual networks that exist in the same region.

- **Global virtual network peering** connects Azure virtual networks that exist in different regions.
   
- You can create a regional peering of virtual networks in the same Azure public cloud region, or in the same China cloud region, or in the same Microsoft Azure Government cloud region.

- You can create a global peering of virtual networks in any Azure public cloud region, or in any China cloud region.

- Global peering of virtual networks in different Azure Government cloud regions isn't permitted.

- After you create a peering between virtual networks, the individual virtual networks are still managed as separate resources.

- Virtual networks can be peered across subscriptions and tenants. 

### Things to consider when using Azure Virtual Network peering

Consider the benefits of using Azure Virtual Network peering.

| Benefit | Description |
| --- | --- |
| **Private network connections** | When you implement Azure Virtual Network peering, network traffic between peered virtual networks is private. Traffic between the virtual networks is kept on the Microsoft Azure backbone network. No public internet, gateways, or encryption is required in the communication between the virtual networks. |
| **Strong performance** | Because Azure Virtual Network peering utilizes the Azure infrastructure, you gain a low-latency, high-bandwidth connection between resources in different virtual networks. |
| **Simplified communication** | Azure Virtual Network peering lets resources in one virtual network communicate with resources in a different virtual network, after the virtual networks are peered. |
| **Seamless data transfer** | You can create an Azure Virtual Network peering configuration to transfer data across Azure subscriptions, deployment models, and across Azure regions. |
| **No resource disruptions** | Azure Virtual Network peering doesn't require downtime for resources in either virtual network when creating the peering, or after the peering is created. |

### Things to know about peering requirements and limitations

While VNet peering provides many benefits, there are important constraints to understand.

| Requirements/Limitations | Description |
| --- | --- |
| Nonoverlapping address spaces |	Peered virtual networks must have non-overlapping IP address spaces. Peering creation fails if address ranges overlap. |
| Address space modification restrictions	| If you want to change a VNet's address range, you need to delete the peering first, update the address space, and then set up the peering again. |
| Basic Load Balancer limitations| Resources in one VNet can’t communicate with Basic Internal Load Balancer IPs in VNets peered across regions. Use the Standard Load Balancer for cross-region connections. |
| DNS resolution boundaries |Azure's built-in name resolution does not work across peered VNets. Configure Azure Private DNS zones or custom DNS servers for cross-VNet name resolution. |






