After AVS is deployed, network connectivity becomes the next step for a successful deployment. The AVS solution deploys onto dedicated, bare metal servers. Those bare metal servers are given to a single customer. The bare metal servers need to connect to the Azure network backbone so customers can make use of Azure resources. The AVS provided ExpressRoute helps the environment talk to Azure services. To reach on-premises, a customer provided ExpressRoute circuit needs to be used, along with an ExpressRoute Global Reach configuration. 

## Create Azure Bastion

After AVS is deployed, you'll create an Azure Bastion resource. The Azure Bastion resource provides secure RDP connectivity to your Azure IaaS environment. Azure Bastion will initially be used to connect to the jump host that will allow you to log into the AVS vCenter and NSX environments. Once the ExpressRoute circuits and ExpressRoute Global Reach are configured for hybrid connectivity, the Azure Bastion resource isn't needed. Your company may want to keep the resource as a back-up in case you have connectivity issues with ExpressRoute in the future.

1. In the Azure portal, search for and create a **Bastion** resource.
1. On the **Create a Bastion** page, configure a new Bastion resource with the following details:

    :::image type="content" source="../media/5-create-azure-bastion-host.png" alt-text="Screenshot of creating an Azure Bastion host.":::

    | Field | Value |
    | ----------- | -------- |
    | Subscription | Select the same subscription where AVS is deployed. |
    | Resource group | Select existing or create a new resource group. |
    | Name | The name of the new Bastion resource. |
    | Region | Select the same region where AVS is deployed. |
    | Virtual network | Select the virtual network created when you deployed AVS. |
    | Subnet | Azure Bastion requires a dedicated subnet. For the virtual network created during the AVS deployment, select **Manage subnet configuration** to create the dedicated subnet. Select **+Subnet** and create a subnet with the following configurations: the subnet name needs to be **AzureBastionSubnet** and the subnet must be at least /27 or higher. |
    | Public IP address | The public IP will allow RDP and SSH over port 443 to Azure Bastion. Create a new public IP and place the resource in the same region as both AVS and Azure Bastion. This new public IP is separate from the AVS deployment. |
    | Public IP address name | Provide a name of the public IP address resource. |
    | Public IP address SKU | This setting is pre-populated by default to **Standard** because Bastion only supports the Standard Public IP SKU. |
    | Assignment | This setting is pre-populated by default to **Static**. Best practice is to leave assignment at static. |

## Create Azure Virtual Machine to use as jump host

After AVS and the Azure Bastion resource are deployed, create a jump host to access to the private cloud. The jump host must be located in the same virtual network and subscription as AVS and the Azure Bastion resource. The jump host can either be a desktop or server version of Windows. The jump host will be deployed behind the Azure Bastion resource. You'll use Azure Bastion to access to the jump host via RDP in the Azure portal over TLS.

## Use Azure Bastion and sign into vCenter and NSX-T Manager

Use Azure Bastion to log into the jump host VM. Once logged in, open a web browser. Navigate and log into both vCenter and NSX-T Manager. The Azure portal will provide the vCenter IP address, the NSX-T Manager console's IP addresses, and credentials used for deployment. Accessing the jump host through Azure Bastion will allow you to configure NSX-T and vCenter.

:::image type="content" source="../media/5-login-credentials-vcenter-nsxt.png" alt-text="Screenshot showcasing where login credentials display after AVS is deployed within the Azure portal.":::

## Establish an ExpressRoute Global Reach connection to on-premises VMware environment

Global Reach will connect your on-premises VMware environment to the AVS private cloud. Connectivity is established between the AVS ExpressRoute and a new or existing ExpressRoute to an on-premises environment.

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
    - Resource ID
    - Authorization key
    - /29 CIDR network block.
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

In the next unit, we'll walk through how to configure NSX-T networking components in the Azure portal. NSX-T Manager provides the software defined networking layer for AVS.