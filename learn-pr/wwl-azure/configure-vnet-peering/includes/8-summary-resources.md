In this module, you learned Azure Virtual Network peering lets you connect virtual networks in a hub and spoke topology. You learned how to configure your virtual networks with Azure VPN Gateway for transit connectivity. You explored how to extend peering with user-defined routes and service chaining.

The main takeaways from this module are:
- Azure Virtual Network peering allows for the connection of virtual networks in a hub and spoke topology.

- There are two types of peering: regional and global. Regional peering connects virtual networks in the same region. Global peering connects virtual networks in different regions. 

- Network traffic between peered virtual networks is private and kept on the Azure backbone network.

- You can configure Azure VPN Gateway in the peered virtual network as a transit point to access resources in another network.

- Network security groups can be applied to block or allow access between virtual networks when configuring virtual network peering.

## Learn more

- [Azure Virtual Network peering](/azure/virtual-network/virtual-network-peering-overview). This article is your starting point for learning about virtual network peering. 

- [Create, change, or delete a virtual network peering](/azure/virtual-network/virtual-network-manage-peering?tabs=peering-portal). This article reviews how to create a virtual network peering and what each setting means. 

## Learn more with self-paced training

- [Introduction to Azure Virtual Networks](/training/modules/introduction-to-azure-virtual-networks/). Learn how to design and implement core Azure networking infrastructure such as virtual networks, and virtual network peering.

- [Distribute your services across Azure Virtual Networks and integrate them by using Azure Virtual Network peering (sandbox)](/training/modules/integrate-vnets-with-vnet-peering/). Learn how to use virtual network peering to enable communication across virtual networks.