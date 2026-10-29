::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=3fbb6130-8a6c-4e42-8e3d-fd0478a95c0c]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

By default, storage accounts accept connections from clients on any network. To limit access to selected networks, you must first change the default action. You can restrict access to specific IP addresses, ranges, or virtual networks.

## Private endpoints

For maximum network isolation, use a *private endpoint* for your storage account. A private endpoint assigns a private IP address from your virtual network to the storage account. Network traffic between clients in the virtual network and the storage account travels over the virtual network and a private link on the Microsoft backbone network—it never reaches the public internet.

With a private endpoint, you can also block all access over the public endpoint, so that data is reachable only through the private endpoint from your virtual network or connected on-premises networks (via VPN or ExpressRoute).

> [!IMPORTANT]
> Creating a private endpoint doesn't automatically block the public endpoint. You must explicitly set public network access to **Disable** if you want all traffic to flow only through the private endpoint.
>
> Changing network rules can affect your application's ability to connect to Azure Storage. If you set the default network rule to *deny*, you block all access to the data unless specific network rules *grant* access. Before you change the default rule to deny access, be sure to use network rules to grant access to any allowed networks.

## Manage default network access rules

You can manage default network access rules for storage accounts through the Azure portal, PowerShell, or the Azure CLI.

Follow these steps to change default network access in the Azure portal.

1. Go to the storage account you want to secure.

1. Select **Networking** under **Security + networking** in the left-hand pane.

1. Under **Public network access**, select **Manage**, and then choose the network access for the storage account's public endpoint:

    - To restrict access to only selected networks and IPs, select **Enable**, and then select **Enabled from selected networks**.
    - To allow access from all networks, including the internet, select **Enable**, and then select **Enabled from all networks**.
    - To block access from all networks, select **Disable**. Traffic is then allowed only through a private endpoint.

1. To apply your changes, select **Save**.

:::image type="content" source="../media/5-firewall.png" alt-text="Screenshot that shows the firewall options for storage accounts.":::

::: zone-end