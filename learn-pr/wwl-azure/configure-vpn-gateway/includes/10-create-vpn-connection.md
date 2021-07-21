Once your VPN gateways are created, you can create the connection between them. If your VNets are in the same subscription, you can use the portal.

:::image type="content" source="../media/add-connections-db2266af.png" alt-text="Screenshot of the Add Connection page in the Azure portal. TestVNet4GW is selected as the second virtual network gateway. The Shared key is abc123.":::


 -  **Name**. Enter a name for your connection.
 -  **Connection type**. Select Site-to-Site (IPSec) from the drop-down.
 -  **Shared key (PSK)**. In this field, enter a shared key for your connection. You can generate or create this key yourself. In a site-to-site connection, the key you use is the same for your on-premises device and your virtual network gateway connection.

## Verify the VPN connection

After you have configured all the Site-to-Site components, it is time to verify that everything is working. You can verify the connections either in the portal, or by using PowerShell.
