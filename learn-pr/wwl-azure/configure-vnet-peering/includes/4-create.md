Here are the steps to configure VNet peering. Notice you will need two virtual networks. To test the peering, you will need a virtual machine in each network. Initially, the VMs will not be able to communicate, but after configuration the communication will work. The step that is new is configuring the peering of the virtual networks.

1.  Create two virtual networks.
2.  **Peer the virtual networks**.
3.  Create virtual machines in each virtual network.
4.  Test the communication between the virtual machines.

To configure the peering use the **Add peering** page. There are only a few optional configuration parameters to consider.

:::image type="content" source="../media/configure-peering-6812f843.png" alt-text="Screenshot of the peering page.":::


> [!NOTE]
> When you add a peering on one virtual network, the second virtual network configuration is automatically added.
