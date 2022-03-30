> [!IMPORTANT]
> You need your own [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true) to complete the exercises in this module. If you don't have an Azure subscription, you can still read along.

You have configured your network as shown in the diagram below. You want VM1 and VM2 to communicate via the VnetHub. Users are complaining that VM1 cannot communicate with VM2. You need to investigate to diagnose the problem, and then fix it.

There are three Azure virtual networks (VNets) in a hub and spoke topology.

:::image type="content" source="../media/4-spoke-hub-topology.png" alt-text="Screenshot of spoke and hub topology":::

:::image type="content" source="../media/4-vn1-topology.png" alt-text="Diagram of the 1st virtual network topology.":::

:::image type="content" source="../media/4-vn2-topology.png" alt-text="iagram of the 2nd virtual network topology.":::

:::image type="content" source="../media/4-vn3-topology.png" alt-text="Diagram of the 3rd virtual network topology.":::

## Diagnosis

## Verify the network topology

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com)  using the same account you used to activate the sandbox.

1. Familiarise yourself with the network topology and check it matches the diagram above.

1. Check the private IP addresses of the firewall (FW1) and virtual machines (VM1 and VM2). These are allocated automatically. Make a note of the correct IP addresses if they are different from the diagram.

### Check OSI level 3 connectivity

1. Connect to each virtual machine (VM1 and VM2) using Remote Desktop. Windows credentials are:

1. User name: AdminXyz

1. Password: sfr9jttzrjjeoem7hrf#

1. On VM1, open a command prompt window and ping the private IP address of VM2.

1. Ping the private IP address of the Azure firewall (FW1).

1. On VM2, open a command prompt window and ping the private IP address of VM1.

1. Ping the private IP address of the Azure firewall (FW1).

:::image type="content" source="../media/4-private-address-ping.png" alt-text="Screen shot showing the command prompt with the ping request results.":::

:::image type="content" source="../media/4-private-address-ping-working.png" alt-text="SScreen shot showing the command prompt with the ping request results.":::

### Troubleshoot the problem

- To understand what is causing the problem, try the following troubleshooting steps:

- Examine ipconfig /all on both VM1 and VM2.

- Examine the Network Security Groups, and routing tables.

- Examine the firewall and the firewall rules.

- Examine the peering connection properties.

The diagram shows the effective routes on VM1-nic.

:::image type="content" source="../media/4-effective-routes.png" alt-text="Screen shot showing the effective routes.":::

## Resolution

When you examined the peering connections, you would have found that the peering settings are different.

| **VNet**| **Peering name**| **Traffic forwarded from remote virtual network**|
| :--- | :--- | :--- |
| VnetHub| Hub-Spoke1| Allow (default)|
| VnetHub| Hub-Spoke2| Block traffic that originates from outside this virtual network|
| VnetSpoke1| Spoke1-Hub| Allow (default)|
| VnetSpoke2| Spoke2-Hub| Block traffic that originates from outside this virtual network|

:::image type="content" source="../media/4-peerings.png" alt-text="Screen shot showing peerings.":::

:::image type="content" source="../media/4-incorrect-traffic-forwarding.png" alt-text="Screen shot showing the incorrect spoke traffic forwarding setting.":::

To fix the problem, you must change the setting in both sides of the peering between VnetHub and VnetSpoke2.

- Hub-Spoke2

- Spoke2-Hub

The **Traffic forwarded from remote virtual network** must be set to **Allow**.

It should now be possible on VM1 to ping VM2.

NOTE: There will be a short delay before the new settings take effect. If the ping fails at first, try again.
