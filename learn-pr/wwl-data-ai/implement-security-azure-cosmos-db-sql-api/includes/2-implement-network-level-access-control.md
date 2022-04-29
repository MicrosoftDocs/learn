Azure Cosmos DB supports IP-based access controls for inbound firewall support. Configuring a firewall for your Azure Cosmos account makes the account accessible only from an approved set of machines and/or cloud services. The firewall will only help secure the network layer. Connections will still require the caller to present a valid authorization token.

## IP access control

By default Azure Cosmos DB accounts allow all networks and IPs from the internet to access the account. The connection request is only required to present a valid authorization token. To configure network security for your Azure Cosmos DB account, you'll need to provide a single IPv4 or CIDR range to limit the access from only the provided IP or IP range. Connections from any IP that is not part of the provided allowed IP list, will receive a **403** (Forbidden) response. Since you might be using the Azure portal to run scripts in the Azure Cosmos DB account Data Explorer, or might be reviewing metrics of the account, you should also enable the **Allow access from Azure Portal** option in the firewall setup. To use these Azure Cosmos DB features in the Azure portal, you'll also need to select **+ Add my current IP (#.#.#.#)** to add your current IP.

Access to an Azure Cosmos DB account can also be done with subnet and VNET access control. You can combine both access for a specific subnet within a VNET and the IP-based firewall to limit access from public IPs. Regardless of the network security used, you still need to present a valid authorization token.

You can set up your Azure Cosmos DB account firewall rules:

- From the Azure portal.
- Using an Azure Resource Manager template.
- Through Azure CLI or Azure PowerShell by updating the ipRangeFilter property

## Configure an IP firewall by using the Azure portal

Configure an IP firewall by using the Azure portal: 

1. On the Azure Cosmos DB account page Select **Firewall and virtual networks**.

1. Select the **Selected networks** option.

    :::image type="content" source="../media/2-firewall-setting.png" alt-text="Diagram that shows the firewall setting options.":::

1. (optional) To add a virtual network:

    1. Select **+ Add existing virtual** to pick from a list of already existing virtual networks. In this example only one existing virtual network exists, *virtualnetwork1*.

        :::image type="content" source="../media/2-firewall-add-existing-virtual-network.png" alt-text="Diagram that shows a list of existing virtual networks.":::

    1. Select **+ Add new virtual network**.

        :::image type="content" source="../media/2-firewall-add-new-virtual-network.png" alt-text="Diagram that shows the options to create a new virtual network.":::

1. (optional) Select **+ Add my current IP (#.#.#.#)** to be able to connect from your current client. Review your client IP displayed in this option and validate if it's the correct Public IP address. This option helps simplify development, since apps running on your client IP would be allowed to connect to the Azure Cosmos DB account.

1. Under Firewall, add a *single IPv4 or CIDR range*. It's this option, that will limit the access from only the provided IP or IP ranges. Add as many IPs or IP ranges as needed. You'll need to get the Public IP addresses from cloud services, virtual machines, or any computer that needs to connect to the Azure Cosmos DB. If those services, physical or virtual machines have an IP that is inside an allowed Virtual Network, there might be no need to add their public IP.

1. You can enable requests to access the Azure portal by selecting the **Allow access from Azure portal** option.

1. (optional) You can enable access from other sources within Azure by selecting the **Accept connections from within Azure datacenters** option. This option provides access to the Azure Cosmos DB account from services that don't provide a static IP like Azure Stream Analytics and Azure Functions. This option allows *all* request from Azure, including request that could originate from other customer subscriptions. The list of IPs allowed by this option is wide, so it limits the effectiveness of a firewall policy. Use this option only if your requests don’t originate from static IPs or subnets in virtual networks. 

## Troubleshoot issues with an IP access control policy

Let's review some scenarios of issues with when an IP access control policy is enabled:

### Azure portal blocked

When the IP access control policy is enabled, to enable portal data-plane operations like browsing containers and querying documents, you need to select **Allow access from Azure portal** option in the Azure Cosmos DB account *Firewall and virtual networks* settings.

### SDK blocked

If your applications are getting a generic 403 Forbidden response, verify the allowed IP list for your account, and make sure that the correct policy configuration is applied to your Azure Cosmos DB account.

### Source IPs in blocked in requests

To troubleshoot, enable diagnostic logging on your Azure Cosmos DB account. The 403 return codes will be logged for firewall-related messages. You can filter these messages to return the source IPs for the blocked requests.

### Requests from a subnet with a service endpoint for Azure Cosmos DB enabled

Requests from a subnet in a virtual network that has a service endpoint for Azure Cosmos DB enabled sends the virtual network and subnet identity to Azure Cosmos DB accounts. These requests don't have the public IP of the source, so IP filters reject them. To allow access from specific subnets in virtual networks, add an access control list.

### Private IP addresses in list of allowed addresses

Make sure that no private IP address is specified in the allowed addresses list.