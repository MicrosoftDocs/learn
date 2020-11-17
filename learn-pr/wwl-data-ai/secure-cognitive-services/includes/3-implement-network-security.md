Network security is an important measure to ensure outside users cannot reach the services that you are protecting. If you secure the network, then bad actors will not even be able to access sensitive resources. Limiting what public users can see is always a great idea, since they can’t compromise what they can’t see. By default, Cognitive Services will be available from all networks, which you should obviously reconfigure.

:::image type="content" source="../media/02-network-default-access.png" alt-text="Screenshot of default network rule allowing access from all networks.":::

Instead of leaving the service open for all networks, you should restrict it to only allow access from networks you own. Once network restrictions are enabled, a client trying to connect from an IP address that is not allowed will receive error similar to the error listed here:

```bash
Encountered exception. (AccessDenied) Access denied due to Virtual Network/Firewall rules. Your IP address is 162.0.0.1.
```

You configure network security from the Azure portal. You can set access to only allow certain network locations. Your options are from an existing virtual network, from a new virtual network, or from a specific range of IP addresses. The following steps will configure access from your current machine’s network location.

1. Navigate to your Cognitive Services instance.
1. In the left pane, select **Networking**.

   :::image type="content" source="../media/02-network-selection.png" alt-text="Screenshot showing Networking option in a Cognitive Services settings pane.":::

1. Choose **Selected Networks** and **Private Endpoints**.
1. Select **Add your client IP address**.

   :::image type="content" source="../media/02-network-add-client-ip.png" alt-text="Screenshot showing Firewall selection of Add your client IP address.":::

1. Select **Save**.

When you are ready to deploy an application that uses Cognitive Services, you will need an Azure virtual network with access. This virtual network can be created from the same Networking settings of your Cognitive Services instance with the following steps.

1. Select **+ Add new virtual network**.
1. Provide **name**, **address space**, **resource group**, **subnet address range**. For a real-world deployment, you have the option to add additional DDoS protection and a firewall if desired.

   :::image type="content" source="../media/02-network-create-virtual-network.png" alt-text="Screenshot showing creation of virtual network with fields populated.":::

1. Select **Save**.

   Any services that require access to this Cognitive Services instance can be set to use the new subnet. Connections will only be allowed from your selected virtual network location or the client IP address you selected. Doing so will allow only trusted resources have access to your Cognitive Services.
