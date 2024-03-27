In this unit, you'll create the firewall in its own virtual network. Then, you'll peer that virtual network with the virtual network used by your Azure Virtual Desktop.

## Create a virtual network and subnet for Azure Firewall

Create a virtual network that acts as the central connectivity point or hub for Azure Firewall.  

1. In the [Azure portal](https://portal.azure.com?azure-portal=true), search for and select **Virtual networks**.
1. Select **+ Create**.
1. Enter the following information:

    |Field |Value  |
    |---------|---------|
    |Subscription     | Your subscription        |
    |Resource group    | learn-firewall-rg        |
    |Name    |   firewallVNet      |
    |Region     | Same region as your resource group      |

    :::image type="content" source="../media/5-create-virtual-network.png" alt-text="Screenshot showing the information to include when creating a virtual network.":::

1. Select the **IP Addresses** tab at the top of the screen.
1. Change the address from **10.0.0.0** to **10.1.0.0**.
1. Under **Subnets**, select the **Default** link.
1. Select **Azure Firewall** in the **Subnet purpose** drop-down.
1. Change the **Starting address** **to 10.1.0.0**.
1. Leave the rest of the values as the defaults.
1. Select **Save**.
1. Select **Review + create** and wait for validation to pass.
1. Select **Create**.
1. After the deployment is complete, select **Go to resource**.

## Peer virtual networks

Connect the hub virtual network with the virtual network used by the host pool by peering them.

1. In **firewallVNet**, under **Settings**, select **Peerings**.
1. Select **+ Add**.
1. Enter the following information:

    |Field |Value |
    |---------|---------|
    |This virtual network: Peering link name    |  firewallVNet-hostVNet   |
    |Remote virtual network: Peering link name     |   remote-firewallVNet-hostVNet      |
    |Subscription     | Your subscription        |
    |Virtual network    | hostVNet       |
1. Select **Allow 'hostVNet' to receive forwarded traffic from 'firewallVNet'**.

    :::image type="content" source="../media/5-add-peering.png" alt-text="Screenshot showing the information to include when adding a peering.":::

    Use the default values for the rest of the fields.
1. Select **Add**.

## Deploy Azure Firewall

Now that you have the virtual networks created and peered, deploy Azure Firewall.

1. In the Azure portal, search for and select **Firewalls**.
1. Select **+ Create** to create a firewall.

1. Enter the following information to configure the firewall:

   |Field |Value  |
   |---------|---------|
   |Subscription     |Select your subscription|
   |Resource group     |learn-firewall-rg |
   |Name     |learn-fw|
   |Region     |Select the same location that you used previously|
   | Firewall SKU | Standard |
   |Firewall management|Use Firewall rules (classic) to manage this firewall|
   |Choose a virtual network     |Use existing: firewallVNet|
   |Public IP address     |Add new<br>Name:  fw-pip|

    Use the default values for the rest of the fields.

    :::image type="content" source="../media/5-create-firewall.png" alt-text="Screenshot showing the information to include when creating a firewall.":::
1. Select **Review + create**.
1. Select **Create**.
1. Wait a few minutes for the firewall to deploy.

## Check your work

At this point, you have a firewall deployed within its own virtual network, and you've peered that virtual network with the host pool virtual network. Let's take a look at the firewall to copy the private and public IP addresses. You need those IP addresses in the next exercise unit.

1. After the deployment is complete, select **Go to resource**.
1. In the center pane, you see **Provisioning state: Succeeded**.
:::image type="content" source="../media/5-firewall-overview-page.png" alt-text="Screenshot that shows the status and IP addresses for the firewall." lightbox="../media/5-firewall-overview-page.png":::
1. Copy the **Firewall private IP** address.
1. Next to **Firewall public IP**, select **fw-pip**.
1. Copy the **IP address**.
