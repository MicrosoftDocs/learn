Azure Virtual Network Manager is a highly scalable and available network management solution. It enables you to simplify and scale your virtual networks in Azure. Using Virtual Network Manager, you can easily create a hub-spoke network topology. By defining the hub and spoke virtual networks, Virtual Network Manager automatically creates the necessary connectivity settings for you. You don’t need to manually create peering connections for virtual networks.

There are various features in Virtual Network Manager that help you create a hub-spoke network topology more easily. Here are some of the benefits of using Virtual Network Manager:

- Virtual Network Manager can help you automatically create and maintain your hub-spoke network topology. You can assign a condition for your spoke virtual networks. Then, Virtual Network Manager can help you automatically add those spoke virtual networks into the hub-spoke network topology. For example, the names of your spoke virtual networks contain *spoke-vnet*. Virtual Network Manager automatically creates the hub-spoke network topology for the spoke virtual networks with this name. It's especially helpful in managing your network infrastructure when you have a large number of virtual networks.

- You can easily create a hub-spoke network topology where the spoke virtual networks can communicate to each other without going through the hub. You can make such a topology for use cases where the spokes only need to visit the hub for the services in the hub. With this topology, you can have better traffic performance than when the spokes always need to go through the hub.

Here are some resources to get you started:

- A step-by-step guide to navigate you through the process of create a hub and spoke topology: [Tutorial: Create a secured hub and spoke network](/azure/virtual-network-manager/tutorial-create-secured-hub-and-spoke?azure-portal=true).

- [Azure Virtual Network Manager documentation](/azure/virtual-network-manager/overview?azure-portal=true)
