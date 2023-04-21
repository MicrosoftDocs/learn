
> [!IMPORTANT]
> You need your own [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true) to complete the exercises in this module. If you don't have an Azure subscription, you can still view the demonstration video at the bottom of this page.

As your organization's support engineer, you've been asked to help fix an issue between your resources in the US and northern Europe. you've existing infrastructure of virtual networks in two different regions. The VMs in the US virtual network (VNet1) are unable to get a ping response from the VMs in northern Europe (VNet2).

Checking the topology, you can see that there are VPN gateways and connections.

:::image type="content" source="../media/5-network-diagram.png" alt-text="Diagram of the topology of the network that needs troubleshooting." border="false" lightbox="../media/5-network-diagram.png":::

In this exercise, you'll troubleshoot and resolve the connectivity issue.

> [!IMPORTANT]
> You need your own [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true) to complete the exercises in this module. If you don't have an Azure subscription, you can still read along.
## Test the connection

1. We're going to test the connection between the two VMs, by sending a ping request between them.

1. Open the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) in a new tab.


1. In the search bar, type **virtual machines** then, under Services, select **Virtual machines**.

   :::image type="content" source="../media/5-virtual-machines.png" alt-text="Screenshot showing the search bar and the results of searching for virtual machines.":::

1. From the list of VMs, select **virtualMachine1**.

   :::image type="content" source="../media/5-two-virtual-machines.png" alt-text="Screenshot showing the two virtual machines.":::

1. Make a note of the **Public IP address** and **Private IP address**.

   :::image type="content" source="../media/5-network-ip-address.png" alt-text="Screenshot of V M 1 showing networking the private and public IP addresses." lightbox="../media/5-network-ip-address-lightbox.png":::

1. Repeat the last two steps for **virtualMachine2** and note the Public IP address and Private IP address.

1. On the right, in the Cloud Shell, connect to virtualMachine1 with SSH to the public IP address:

   ```azurecli

   ssh azureuser@<virtualMachine1 public IP address>;

   ```
   > [!NOTE]
   > Replace \<virtualMachine1 public IP address\> with the public IP address you noted for virtualMachine1.

1. At the prompt, ` Are you sure you want to continue connecting (yes/no)? ` type yes.

1. Your prompt should change to `azureuser@virtualMachine1:~$`.

1. This means you've successfully connected to virtualMachine1.

1. Ping the private IP address of virtualMachine2.

   ```bash
   ping <private IP address virtualMachine2>

   ```

   > [!NOTE]
   > Replace \<private IP address\> virtualMachine2 with the private IP address you noted for virtualMachine2. 

   :::image type="content" source="../media/5-ping-request.png" alt-text="Screenshot showing the ping command to check whether machines can connect.":::

1. We can confirm that the two machines can't connect, as there is no response from virtualMachine2.

1. Press **CTRL** + **C** keys to quit the ping command.

## Troubleshoot the gateways

You'll check the types are correct for both gateways.

1. Go to the Azure portal.

1. In the search bar, type **virtual network gateways**, and then select the service to continue.

   :::image type="content" source="../media/5-virtual-network-gateways.png" alt-text="Screenshot showing the virtual gateway service.":::

1. Select **VNet1GW**.

   :::image type="content" source="../media/5-virtual-network-gateways-result.png" alt-text="Screenshot of the virtual gateways.":::

1. Confirm that the VPN type is route-based, and the gateway type is VPN.

   :::image type="content" source="../media/5-vpn-route-based.png" alt-text="Screenshot showing the Gateway and V P N Type." lightbox="../media/5-vpn-route-based-lightbox.png":::

1. Scroll down the page to check the tunnel Ingress and Egress. Can you see a time when something might have happened to cause a problem?

   :::image type="content" source="../media/5-tunnel-ingress.png" alt-text="Screenshot of the Tunnel ingress and Egress stats." :::

1. Repeat for VNet2GW.

## Troubleshoot the virtual networks

You'll now check the address spaces don't overlap for the two virtual networks.

1. In the search bar, type **virtual networks**, and then select the **Virtual network** service.

1. Select **VNet1**.

   :::image type="content" source="../media/5-virtual-networks.png" alt-text="Screenshot showing the virtual networks.":::

1. Make a note of the **Address space**.

   :::image type="content" source="../media/5-address-space.png" alt-text="Screenshot showing the address spacer.":::

1. Select **VNet2**, and check that the address spaces do not overlap.

   :::image type="content" source="../media/5-dns-server.png" alt-text="Screenshot showing the address space of V Net 2":::

1. The two address spaces are different, so we can rule out any problems with them.

1. You'll now check the subnets are correctly set up.

1. Select **VNet1**, then select **Subnets**.

   :::image type="content" source="../media/5-subnets.png" alt-text="Screenshot showing the subnet menu.":::

1. Check the **subnet address** is a subset of the **address space**.

1. Repeat for **VNet2**.

   :::image type="content" source="../media/5-gateway-subnet.png" alt-text="Screenshot showing the Gateway subnet address.":::

1. The **GatewaySubnet** addresses have been correctly created and correspond with the default range.

## Check the gateway connections

1. In the search bar, type virtual network gateway and then select **virtual network gateways**.

1. The two gateways will be displayed.

1. Select **VNet1GW**.

   :::image type="content" source="../media/5-gateway-connections.png" alt-text="Screenshot of the V Net 1 gateway.":::

1. Select **Connections**.

   :::image type="content" source="../media/5-virtual-network-gateway-connection.png" alt-text="Screenshot of the Connections option.":::

1. The issue seems to be with the connections between the gateways.

   :::image type="content" source="../media/5-virtual-network-to-virtual-network.png" alt-text="Screenshot showing the two virtual networks not connected.":::

1. Select **Refresh** to check that there is still an issue with connection.

   :::image type="content" source="../media/5-virtual-network-to-virtual-network-connection.png" alt-text="Screenshot of the refresh button.":::

1. A connection still can't be made, so you'll check the shared keys.

1. Select **VNet1-VNet2**.

1. Select **Shared key**.

   :::row:::
       :::column:::
       :::column-end:::
       :::column:::
           :::image type="content" source="../media/5-shared-key.png" alt-text="Screenshot showing the Shared Key option.":::
       :::column-end:::
       :::column:::
       :::column-end:::
   :::row-end:::

1. Make a note of the **Shared key**.

   :::image type="content" source="../media/5-correct-shared-key.png" alt-text="Screenshot of the shared key.":::

1. On the breadcrumb trail, select **VNet1GW**, then select **VNet2-VNet1**.

1. Select **Shared key**.

   :::image type="content" source="../media/5-incorrect-key.png" alt-text="Screenshot of the second shared key showing it's different to the first shared key.":::

1. The shared keys are not the same. For the connections to work, the shared key must be identical.

1. Now that you've found the issue, you'll resolve it in the next exercise.

In this demonstration you will see how to proactively troubleshoot Conditional Access policies using the What if tool in the Azure portal:

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4Ubff]
