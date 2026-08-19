In this unit, you'll create the firewall in its own virtual network. Then, you'll peer that virtual network with the virtual network used by your Azure Virtual Desktop.

## Create the hub virtual network

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

1. Select the **IP Addresses** tab.

## Configure the firewall subnet

1. Change the address from **10.0.0.0** to **10.1.0.0**.
1. Under **Subnets**, select the **Default** link.
1. Select **Azure Firewall** in the **Subnet purpose** drop-down.
1. Change the **Starting address** **to 10.1.0.0**.
1. Leave the other values at their defaults, and then select **Save**.
1. Select **Review + create**, wait for validation to pass, and then select **Create**.
1. After the deployment finishes, select **Go to resource**.

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
    |Firewall SKU | Standard |
    |Firewall management | Use a Firewall Policy to manage this firewall |
    |Firewall policy | Add a new policy named **learn-fw-policy** with the **Standard** policy tier |
   |Choose a virtual network     |Use existing: firewallVNet|
   |Public IP address     |Add new<br>Name:  fw-pip|

    Use the default values for the rest of the fields.

    :::image type="content" source="../media/5-create-firewall.png" alt-text="Screenshot showing the information to include when creating a firewall.":::
1. Select **Review + create**.
1. Select **Create**.
1. Wait a few minutes for the firewall to deploy.

The Firewall Policy provides the supported rule-management model for Azure Firewall. In the next exercise, you'll add application and network rule collections to **learn-fw-policy**.

## Check the firewall deployment

At this point, you have a firewall deployed within its own virtual network, and you've peered that virtual network with the host pool virtual network. Copy the firewall private IP address. You'll use it for the default route and the `hostVNet` DNS server.

1. After the deployment is complete, select **Go to resource**.
1. In the center pane, you see **Provisioning state: Succeeded**.
:::image type="content" source="../media/5-firewall-overview-page.png" alt-text="Screenshot that shows the status and IP addresses for the firewall." lightbox="../media/5-firewall-overview-page.png":::
1. Copy the **Firewall private IP** address.
1. In **learn-fw**, under **Settings**, select **Firewall policy**, and confirm that **learn-fw-policy** is assigned.

## Enable DNS proxy

The Windows activation rule in the next exercise uses a fully qualified domain name (FQDN). FQDN filtering in network rules requires DNS proxy. Configure the session host and Azure Firewall to use the same DNS path so they receive consistent responses.

1. In the Azure portal, open **learn-fw-policy**.
1. Under **Settings**, select **DNS settings**, and then enable **DNS proxy**.
1. Keep **Azure DNS** as the DNS server, and then select **Apply**.

## Configure session-host DNS

1. Search for and select **Virtual networks**, and then select **hostVNet**.
1. Under **Settings**, select **DNS servers**.
1. Select **Custom**, enter the **Firewall private IP** address that you copied, and then select **Save**.
1. Search for and select **Virtual machines**, select the session host whose name starts with **learnhost**, and then select **Restart**.

After the VM restarts, DNS requests from the session host go to Azure Firewall. The firewall forwards them to Azure DNS and uses the same responses to evaluate FQDN network rules.

## Validate DNS resolution

1. On the session-host VM, select **Run command** > **RunPowerShellScript**.
1. Enter and run the following script:

     ```powershell
     Get-DnsClientServerAddress -AddressFamily IPv4 |
         Where-Object ServerAddresses |
         Select-Object InterfaceAlias, ServerAddresses

     Resolve-DnsName azkms.core.windows.net
     ```

1. Confirm that the active network interface lists the firewall private IP address as its DNS server and that `azkms.core.windows.net` returns an answer.
