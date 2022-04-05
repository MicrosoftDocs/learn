If you have not already run the script in unit 2, please do so now so you can follow the exercise below.

You have configured your network as shown in the diagram below. You want VM1 and VM2 to communicate via the VnetHub. Users are complaining that VM1 cannot communicate with VM2. You need to investigate to diagnose the problem, and then fix it.

There are three Azure virtual networks (VNets) in a hub and spoke topology.

:::image type="content" source="../media/6-spoke-hub-topology.png" alt-text="Screenshot of spoke and hub topology." border="false":::

## Diagnosis

## Verify the network topology

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com)  using the same account you used to activate the sandbox.

1. Familiarize yourself with the network topology and check it matches the diagram above.

1. Check the private IP addresses of the firewall (FW1) and virtual machines (VM1 and VM2). These are allocated automatically. Make a note of the correct IP addresses if they are different from the diagram.

### Check OSI level 3 connectivity

1. Connect to each virtual machine (VM1 and VM2) using Remote Desktop. Windows credentials are:

1. User name: AdminXyz

1. Password: sfr9jttzrjjeoem7hrf#

1. On VM1, open a command prompt window and ping the private IP address of VM2.

1. Ping the private IP address of the Azure firewall (FW1).

1. On VM2, open a command prompt window and ping the private IP address of VM1.

1. Ping the private IP address of the Azure firewall (FW1).

    :::image type="content" source="../media/6-private-address-ping.png" alt-text="Screenshot showing the command prompt with the ping request results.":::

### Troubleshoot the problem

1. To understand what is causing the problem, try the following troubleshooting steps:

1. Examine ipconfig /all on both VM1 and VM2.

1. Examine the Network Security Groups, and routing tables.

1. Examine the firewall and the firewall rules.

1. Examine the peering connection properties.

    The diagram shows the effective routes on VM1-nic.

    :::image type="content" source="../media/6-effective-routes.png" alt-text="Screenshot showing the effective routes.":::

## Resolution

When you examined the peering connections, you would have found that the peering settings are different.

| **VNet**| **Peering name**| **Traffic forwarded from remote virtual network**|
| :--- | :--- | :--- |
| VnetHub| Hub-Spoke1| Allow (default)|
| VnetHub| Hub-Spoke2| Block traffic that originates from outside this virtual network|
| VnetSpoke1| Spoke1-Hub| Allow (default)|
| VnetSpoke2| Spoke2-Hub| Block traffic that originates from outside this virtual network|

:::image type="content" source="../media/6-peerings.png" alt-text="Screenshot showing peerings.":::

The settings on **Hub-Spoke2** are incorrect.

:::image type="content" source="../media/6-incorrect-traffic-forwarding.png" alt-text="Screenshot showing the incorrect spoke traffic forwarding setting.":::

To fix the problem, you must change the setting in both sides of the peering between VnetHub and VnetSpoke2.

- Hub-Spoke2

- Spoke2-Hub

The **Traffic forwarded from remote virtual network** must be set to **Allow**.

It should now be possible on VM1 to ping VM2.

:::image type="content" source="../media/6-private-address-ping-working.png" alt-text="Screenshot showing the command prompt with the ping request working.":::

There will be a short delay before the new settings take effect. If the ping fails at first, try again.

