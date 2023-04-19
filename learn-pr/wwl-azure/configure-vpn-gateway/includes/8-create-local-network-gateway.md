
The local network gateway typically refers to the on-premises location. To create a local gateway, you provide a name for the site, along with the IP address or FQDN of the on-premises VPN device for the connection. You also specify the IP address prefixes to route through the VPN gateway to the VPN device. The address prefixes you specify are the prefixes located in the on-premises network.

### Things to know about creating a local network gateway

Let's examine the details about the configuration parameters for a local network gateway.

:::image type="content" source="../media/create-local-network-gateway-1f51c650.png" alt-text="Screenshot that shows how to create a local network gateway in the Azure portal.":::

- **Name**: Provide a name for your site. Azure uses this name to refer to your local network gateway.

- **Endpoint**: Specify the IP address or FQDN of the on-premises VPN device for the connection.

- **IP address**. Identify the public IP address of your local network gateway.

- **Address space**. Provide one or more IP address ranges (in CIDR notation) to define your local network's address space.

   > [!Note]
   > If you plan to use this local network gateway in a connection enabled with the Border Gateway Protocol (BGP), then the minimum prefix you need to declare is the host address of your BGP Peer IP address on your VPN device.

- **Configure BGP settings**: As needed, select this box to configure BGP settings for the local network gateway.