After AVS is deployed, network connectivity becomes the next step for a successful deployment. The AVS solution deploys onto dedicated, bare metal servers. Those bare metal servers are given to a single customer. The bare metal servers need to connect to the Azure network backbone so customers can make use of Azure resources. The AVS provided ExpressRoute helps the environment talk to Azure services. To reach on-premises, a customer provided ExpressRoute circuit is needed, along with an ExpressRoute Global Reach configuration. 

## Create an ExpressRoute virtual network gateway for AVS

In the previous unit, you either created a virtual network or configured an existing network for AVS. An ExpressRoute virtual network gateway is created next. The AVS ExpressRoute uses this virtual network gateway to send network traffic to Azure services.

1. In an existing or new resource group, select **+ Add** to add a new resource.
1. In the **Search the Marketplace** text box, type in **Virtual network gateway** and select the resource.
1. On the **Virtual Network Gateway** page, select **Create**.
1. On the **Basics** tab, provide values for the fields and select **Review + create**.

:::image type="content" source="../media/5-create-virtual-network-gateway-expressroute.png" alt-text="Screenshot showing the required information to deploy an ExpressRoute virtual network gateway for AVS connectivity to Azure services.":::

| Field | Value |
| ----- | ----- |
| Subscription | Pre-populated with the subscription where the virtual network is deployed. |
| Resource group | Pre-populated with the resource group where the virtual network is deployed. |
| Name | Enter a name for the virtual network gateway. |
| Region | Select the region of the virtual network and AVS deployment. |
| Gateway type | Select **ExpressRoute**. |
| SKU | Use the default value at **Standard*. |
| Virtual network | Select the virtual network previously created. |
| Gateway subnet address range | Pre-populated when selecting the virtual network. Leave this setting at the default value. |
| Public IP address | Select **Create new**. |

## Peer the AVS ExpressRoute to the virtual network gateway

You'll need to connect the AVS ExpressRoute to Azure. This connection allows access Azure services like Azure Backup, Azure Monitor, Azure Security Center, and so on.

1. Select the AVS private cloud created during the previous unit.
1. Under **Manage**, select **Connectivity**.
1. Select the **ExpressRoute** tab.
1. Copy the authorization key.
1. If there isn't an authorization key, you'll need to create one by selecting **+ Request an authorization key**.

    :::image type="content" source="../media/5-request-auth-key.png" alt-text="Screenshot demonstrating how to request an authorization key for ExpressRoute peering.":::

1. Select the virtual network gateway created in the previous step and under **Settings**, select **Connections**.
1. On the **Connections** page, select **+ Add**.
1. On the **Add connection page**, provide values for the following fields, and select **OK**.

    | Field | Value |
    | ----- | ----- |
    | Name | Enter a name for the connection. |
    | Connection type | Select ExpressRoute. |
    | Redeem authorization | Make sure this box is selected. |
    | Virtual network gateway | Use the virtual network gateway created previously. |
    | Authorization key | Copy and paste the authorization key from the ExpressRoute tab inside the resource group. |
    | Peer circuit URI | Copy and paste the ExpressRoute ID from the ExpressRoute tab in the resource group. |

1. After all fields are filled, a connection between the ExpressRoute circuit and virtual network is created.

## Establish an ExpressRoute Global Reach connection to on-premises VMware environment

Global Reach will connect your on-premises VMware environment to the AVS private cloud. Connectivity is established between the AVS ExpressRoute and a new or existing ExpressRoute to an on-premises environment.

### Pre-requisites

There are a few pre-requisites that need to be met before configuring ExpressRouteGlobal Reach.

1. The AVS ExpressRoute needs established connectivity to and from Azure within the AVS private cloud.
2. A separate ExpressRoute circuit used to connect on-premises environments to Azure.
3. A /29 non-overlapping network address block for ExpressRoute Global Reach peering.
4. All gateways, including the ExpressRoute provider's service, need to support 4-byte Autonomous System Number (ASN). AVS uses 4-byte public ASNs for advertising network routes.

### Create an ExpressRoute Global Reach authorization key in the private cloud

1. From the AVS private cloud **Overview**, under **Manage**, select **Connectivity > ExpressRoute > Request an authorization key**.

    :::image type="content" source="../media/5-request-auth-key.png" alt-text="Screenshot showing how to request an auth key for an ExpressRoute circuit.":::

1. Enter a name for the authorization key. 
1. Select **Create**.

    :::image type="content" source="../media/5-provide-name-auth-key-create.png" alt-text="Screenshot of entering name of authorization key and selecting create.":::

1. The new key appears in the list of authorization keys for the private cloud after creation.

    :::image type="content" source="../media/5-new-auth-key-private-cloud.png" alt-text="Screenshot showing the ExpressRoute Global Reach authorization key.":::

1. Use the authorization key, ExpressRoute ID, and a /29 address block to complete the peering.

## Peer the AVS private cloud to on-premises using authorization key in the Azure portal

The AVS ExpressRoute circuit can be peered to the on-premises circuit after the authorization key is created. The peering can be configured using the Azure portal. This method will require the resource ID and authorization key of the AVS private cloud ExpressRoute circuit for peering.

1. Select the AVS private cloud.
1. From the private cloud **Overview**, under **Manage**, select **Connectivity > ExpressRoute Global Reach > Add**.

    :::image type="content" source="../media/5-expressroute-global-reach-tab.png" alt-text="Screenshot showing how to configure ExpressRoute and add the authorization key.":::

1. Create an on-premises cloud connection by using one of the following methods:
    - Select the ExpressRoute circuit from the list.
    - Copy and paste the circuit ID.

1. Select **Connect**.
1. The new connection will show in the on-premises cloud connections list.

## Peer the AVS private cloud to on-premises using authorization key in the Azure CLI

The AVS ExpressRoute circuit is peered to the on-premises circuit after an authorization key is created. The peering can be configured using the Azure CLI in Cloud Shell. This method will require the resource ID and authorization key of the AVS private cloud ExpressRoute.

1. Sign in to the Azure portal using the same subscription as the on-premises ExpressRoute circuit.
1. Open an Azure CLI Cloud Shell.
1. Leave the shell as Bash.
1. Use your specific information:
    1. Resource ID
    1. Authorization key
    1. /29 CIDR network block.
1. Enter the Azure CLI command below to create the authorization key.

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
1. Run the following command against the first circuit, passing in the second circuit's resource ID and authorization key.

    ```azurecli
    az network express-route peering connection create -g <ResourceGroupName> --circuit-name <Circuit1Name> --peering-name AzurePrivatePeering -n <ConnectionName> --peer-circuit <Circuit2ResourceID> --address-prefix <__.__.__.__/29> --authorization-key <authorizationKey>
    ```
When this operation is complete, you'll have connectivity between on-premises and AVS through the two ExpressRoute circuits.

## Verify on-premises network connectivity to the AVS private cloud

You should see where ExpressRoute connects to the NSX-T network segments and the AVS management segments in the edge router. Each environment is different. There may be a need to allow routes to propagate back to the on-premises network.

Some environments have firewalls protecting ExpressRoute circuits. If there are no firewalls, try to ping the AVS vCenter server or a VM on the NSX-T segment from on-premises. Additionally, from the VM on the NSX-T segment, resources should be to reach the on-premises environment.