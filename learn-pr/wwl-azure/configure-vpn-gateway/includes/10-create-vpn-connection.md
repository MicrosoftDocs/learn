
The last step in the site-to-site connection process is to establish the connection between your VPN gateways. If your virtual networks are in the same subscription, you can use the Azure portal to create the connection. Several parameters need to be configured to create the connection. 

### Things to know about creating your VPN connection

Let's review how to configure the connection for your VPN gateways in the Azure portal.

:::image type="content" source="../media/add-connections-db2266af.png" alt-text="Screenshot that shows how to create a VPN connection in the Azure portal.":::

- **Name**: Enter a name for your VPN connection.

- **Connection type**: Use the drop-down menu to select a site-to-site (IPSec) connection.

- **Virtual network gateway**: The value for this parameter is provided by Azure. The value is set to the virtual network gateway for which you're establishing the VPN connection.

- **Local network gateway**: Set this value to the local network gateway that you created in Step 5 of the site-to-site connection process.

- **Shared key (PSK)**. Provide a shared key to use for your connection. You can generate or create the shared key yourself. To establish a site-to-site connection, you need a shared key, which is the same key you use for your on-premises VPN device and your virtual network gateway connection.

## Verify your VPN connection

After you configure all the site-to-site components, it's time to confirm your configuration is working as expected. You can verify the VPN connections in the Azure portal or by using PowerShell.