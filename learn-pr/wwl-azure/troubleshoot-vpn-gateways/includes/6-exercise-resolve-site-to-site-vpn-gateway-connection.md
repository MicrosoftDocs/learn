
> [!IMPORTANT]
> You need your own [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true) to complete the exercises in this module. If you don't have an Azure subscription, you can still view the demonstration video in the preceding unit.

You've explored the possible reasons why your two machines can't connect to each other. You found that the shared key for the two connections is different.

In this exercise, you'll see how to change the shared key on a VPN gateway connection, and then test that this has resolved the issue. If you have not already run the script in unit 2, please do so now so you can follow the exercise below.

## Change a gateway connection's shared key

Follow these steps to check the shared key for both the VPN gateways connections:

1. In the Azure portal, search for **virtual network gateways**, then under **Services**, select **Virtual network gateways**.

   :::image type="content" source="../media/6-search-gateways.png" alt-text="Screenshot showing virtual gateway search.":::

1. Select the first VPN gateway, **Vnet1GW**.

1. Under Settings, select **Connections**.

   :::image type="content" source="../media/6-gateway-connections.png" alt-text="Screenshot showing all v net to v net connections.":::

1. Select the first connection, **VNet1-VNet2**.

1. Under Settings, select **Shared key**.

   :::image type="content" source="../media/6-copy-shared-key.png" alt-text="Screenshot showing the first shared key.":::

1. Copy the text in the **Shared key (PSK)**.

1. In the breadcrumb, select **VNet1GW** to return the VPN gateway pane.

1. Select the second connection, **VNet2-VNet1**.

   :::image type="content" source="../media/6-gateway-second-connection.png" alt-text="Screenshot showing the second vnet to vnet connection.":::

1. Under Settings, select **Shared key**.

1. Paste the value you copied into the **Shared key (PSK)**. This is to make sure that the values match.

## Test the issue is resolved

Repeat the steps you did in the previous exercise to see if the two VMs can connect to each other. Using the Cloud Shell on the right and the Azure portal, follow these steps:

1. Open the Azure portal in a new tab.

1. Search for **virtual machines** then, under Services, select **Virtual machines**.

   :::image type="content" source="../media/6-search-virtual-machines.png" alt-text="Screenshot showing search screen for virtual machines.":::

1. From the list of VMs, select **VM1**.

   :::image type="content" source="../media/6-virtual-machine-1-ip-addresses.png" alt-text="Screenshot showing the I P address of the first virtual machine.":::

1. Make a note of the Public IP address and Private IP address.

1. Repeat the last two steps for VM2 and note the Public IP address and Private IP address.

1. On the right, in the Cloud Shell, connect to VM1 with SSH to the public IP address:

   ```azurecli

   ssh azureuser@<VM1 public IP address>

   ```

   > [!NOTE]
   > Replace &lt;VM1 public IP address&gt; with the public IP address you noted for VM1.

1. At the prompt, ` Are you sure you want to continue connecting (yes/no)? ` type yes.

1. At the prompt for a password, type azur3Pa55w.rd.

1. Your prompt should now be `azureuser@VM1:~$`.

1. This means you have successfully connected to VM1.

1. Ping the private IP address of VM2.

   ```

   ping <private IP address VM2>

   ```

   > [!NOTE]
   > Replace &lt;private IP address VM2&gt; with the private IP address you noted for VM2. 

   :::image type="content" source="../media/6-ping-virtual-machine-2.png" alt-text="Screenshot showing the ping command working.":::

1. If you have resolved the connection issue, you should see a response from VM2.
