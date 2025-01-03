After the Azure VMware Solution is deployed, network connectivity is the next step for a successful deployment. The Azure VMware Solution private cloud deploys onto dedicated, bare-metal servers. These servers are assigned to a single customer. The bare-metal servers need to connect to the Azure network backbone so customers can use Azure resources. The Azure VMware Solution-provided Azure ExpressRoute circuit helps the environment talk to Azure services. To reach the on-premises environment, a customer-provided ExpressRoute circuit is used, along with an ExpressRoute Global Reach configuration.

## Establish an ExpressRoute Global Reach connection to the on-premises VMware vSphere environment

Global Reach will connect your on-premises VMware vSphere environment to the Azure VMware Solution private cloud. Connectivity is established between the Azure VMware Solution ExpressRoute circuit and a new or existing ExpressRoute circuit to an on-premises vSphere environment.

To create an ExpressRoute Global Reach authorization key in the private cloud:

1. From the Azure VMware Solution private cloud **Overview**, under **Manage**, select **Connectivity** > **ExpressRoute** > **Request an authorization key**.

    :::image type="content" source="../media/5-request-expressroute-connectivity-auth-key.png" alt-text="Screenshot of the Azure portal showing how to request an authorization key for an ExpressRoute circuit."lightbox="../media/5-request-expressroute-connectivity-auth-key.png":::

1. Enter a name for the authorization key.
1. Select **Create**.

    :::image type="content" source="../media/5-create-name-expressroute-connectivity-auth-key.png" alt-text="Screenshot of the Azure portal UI for entering the name of the authorization key and selecting Create."lightbox="../media/5-create-name-expressroute-connectivity-auth-key.png":::

1. The new key appears in the list of authorization keys for the private cloud:

    :::image type="content" source="../media/5-new-expressroute-connectivity-auth-key-created.png" alt-text="Screenshot of the Azure portal showing the new ExpressRoute Global Reach authorization key in the key list for the private cloud."lightbox="../media/5-new-expressroute-connectivity-auth-key-created.png":::

1. Use the authorization key and ExpressRoute ID to complete the peering.

## Peer the Azure VMware Solution private cloud to the on-premises environment by using the authorization key

After the authorization key is created, you can peer the Azure VMware Solution ExpressRoute circuit to the on-premises circuit. You can configure the peering by using either the Azure portal or the Azure CLI in Cloud Shell.

For either method, you'll need the resource ID and authorization key of the Azure VMware Solution private cloud ExpressRoute circuit for peering.

### Use the Azure portal to configure peering

To use the Azure portal for peering:

1. In the Azure portal, select the Azure VMware Solution private cloud.
1. From the private cloud **Overview**, under **Manage**, select **Connectivity** > **ExpressRoute Global Reach** > **Add**:
1. Create an on-premises cloud connection by using one of the following methods:
    - Select the ExpressRoute circuit from the list.
    - Copy and paste the circuit ID.

1. Select **Create**.

    :::image type="content" source="../media/5-expressroute-global-reach-configuration.png" alt-text="Screenshot of the Azure portal fields for configuring ExpressRoute and adding the authorization key."lightbox="../media/5-expressroute-global-reach-configuration.png":::

1. The new connection will appear in the list of on-premises cloud connections.

### Use the Azure CLI to configure peering

To use the Azure CLI for peering:

1. Sign in to the Azure portal by using the same subscription as the on-premises ExpressRoute circuit uses.
1. Open an Azure CLI in Cloud Shell. Leave the shell as Bash.
1. Gather your specific information:
    - Resource ID
    - Authorization key
1. Enter the following Azure CLI command to create the authorization key:

    ```azurecli
    az network express-route auth create --circuit-name <Circuit2Name> -g <Circuit2ResourceGroupName> -n <AuthorizationName>
    ```

1. The Azure CLI output will look like this:

    ```azurecli
    {
      "authorizationKey": "<authorizationKey>",
      "authorizationUseStatus": "Available",
      "etag": "W/\"cfd15a2f-43a1-4361-9403-6a0be00746ed\"",
      "id": "/subscriptions/<SubscriptionID>/resourceGroups/<Circuit2ResourceGroupName>/providers/Microsoft.Network/expressRouteCircuits/<Circuit2Name>/authorizations/<AuthorizationName>",
      "name": "<AuthorizationName>",
      "provisioningState": "Succeeded",
      "resourceGroup": "<Circuit2ResourceGroupName>",
      "type": "Microsoft.Network/expressRouteCircuits/authorizations"
    }
    ```

1. Make note of the resource ID and authorization key to peer the circuit.
1. Run the following command against the first circuit, passing in the second circuit's resource ID and authorization key:

    ```azurecli
    az network express-route peering connection create -g <ResourceGroupName> --circuit-name <Circuit1Name> --peering-name AzurePrivatePeering -n <ConnectionName> --peer-circuit <Circuit2ResourceID> --authorization-key <authorizationKey>
    ```

When this operation is complete, you'll have connectivity between your on-premises environment and Azure VMware Solution through the two ExpressRoute circuits.

In the next unit, we'll walk through how to configure NSX networking components in the Azure portal. NSX Manager provides the software-defined networking layer for Azure VMware Solution.
