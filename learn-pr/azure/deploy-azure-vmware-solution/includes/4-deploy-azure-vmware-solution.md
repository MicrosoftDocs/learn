You can build the Azure VMware Solution environment after all planning steps are complete. Azure VMware Solution gives your company the ability to deploy a vSphere cluster in Azure. Azure VMware Solution also provides an easy migration path to bring workloads into Azure. You'll use all the information gathered from the planning units to successfully deploy Azure VMware Solution.

## Register the resource provider

The resource provider must be registered within the subscription. You can register the resource provider by using the Azure CLI, PowerShell, or the Azure portal.

### Azure CLI

To register the resource provider by using the Azure CLI:

1. Start Azure Cloud Shell.
1. Sign in to your Azure subscription.
1. Run this command for the Azure CLI:

    ```azurecli
    az provider register -n Microsoft.AVS --subscription <your subscription ID> 
    ```

### PowerShell

To register the resource provider by using PowerShell:

1. Start Azure Cloud Shell.
1. Sign in to your Azure subscription.
1. Run this command for PowerShell:

    ```powershell
    Register-AzResourceProvider -ProviderNamespace Microsoft.AVS
    ```

### Azure portal

To register the resource provider by using the Azure portal:

1. Search for **Subscriptions**.
1. Select the subscription for which you want to register the provider.
1. Select **Resource providers** and enter **Microsoft.AVS** in the search bar. If the resource provider isn't registered, select **Register**.

    :::image type="content" source="../media/4-register-resource-provider.png" alt-text="Screenshot that shows the Register button at the top of the Subscription > Resource providers page in the Azure portal.":::

## Deploy Azure VMware Solution

When you're ready to deploy Azure VMware Solution, make sure you at least have contributor rights to the subscription. Be ready to use some of the information you gathered during the planning phase of the Azure VMware Solution deployment to create the resource in Azure.

Follow these steps:

1. On the Azure portal menu, select **Create a resource**.
1. In the **Search the Marketplace** text box, enter **Azure VMware Solution**, select the resource, and then select **Create**.
1. On **Azure VMware Solution**, select **Create**.
1. The prerequisites we covered earlier in the module are highlighted in the first screen for the deployment.
1. If you missed any of these steps, now is a good time to review before building the Azure VMware Solution environment.
1. After reviewing all pre-requisites one last time, select **Next: Basics >**.

    :::image type="content" source="../media/4-pre-requisites-create-private-cloud.png" alt-text="Screenshot that shows the prerequisites pane before building the Azure VMware Solution environment in Azure.":::

1. On the **Basics** tab, enter values for the fields:

    :::image type="content" source="../media/4-create-private-cloud.png" alt-text="Screenshot of the Azure portal showing how to create an Azure VMware Solution private cloud with all required fields for deployment.":::

    Here's a description of the value expected in each field:

    | Field | Value |
    | :----- | :----- |
    | **Subscription** | The subscription for the deployment. |
    | **Resource group** | The resource group for private cloud resources. Select an existing resource group or create a new one. |
    | **Resource name** | A name for the Azure VMware Solution private cloud. |
    | **Location** | The location where Azure VMware Solution can be deployed. |
    | **Size of host** | The SKU value for the bare metal nodes: AV36 |
    | **Number of hosts** | The number of hosts to add to the private cloud cluster. |
    | **Address block for private cloud** | An IP address block for the CIDR network used by the private cloud. |

1. After all fields are filled in, select **Review + Create**. The Azure VMware Solution deployment might take in between three to four hours before complete.

1. When the deployment finishes, select the resource group, and then select the private cloud. The **Status** will show as **Succeeded**:

    :::image type="content" source="../media/4-validate-deployment.png" alt-text="Screenshot validating deployment successfully completed.":::

1. Next, you'll need to connect the Azure VMware Solution ExpressRoute circuit to an Azure virtual network.
1. Under **Manage**, select **Connectivity**.
1. For **Azure vNet connect**, you'll need to create a brand new virtual network or select an existing virtual network. The virtual network needs a **GatewaySubnet** configured for ExpressRoute peering.
1. After the virtual network is configured, select **Save**.

    :::image type="content" source="../media/4-azure-vnet-connect.png" alt-text="Screenshot displaying where to select the virtual network from within Azure vNet connect and how to save the configuration.":::

1. Saving the configuration triggers a build of a few different Azure resources:

    | Azure resource  | Description  |
    |---------|---------|
    | Virtual network | If you're building a brand new virtual network with a GatewaySubnet, the virtual network will deploy first. If you're using an existing virtual network, the build process will move to the next resource that doesn't yet exist. |
    | Virtual network gateway | This resource provides a way for the Azure VMware Solution ExpressRoute circuit to connect to an Azure virtual network. |
    | Virtual network gateway public IP | This resource provides a public IP used to establish a peering between the Azure virtual network and the Azure VMware Solution ExpressRoute circuit. |
    | ExpressRoute authorizations | There are two authorizations that get created: one for inbound and one for outbound connectivity, both to and from the Azure VMware Solution private cloud. |

1. After the build finishes, connectivity between the Azure VMware Solution private cloud and Azure have been established. You should see a deployment complete screen like what is shown below:

    :::image type="content" source="../media/4-deployment-complete.png" alt-text="Screenshot displaying the additional resources created after saving the Azure vNet connect configuration.":::

 Azure VMware Solution connectivity will require further configuration to communicate with the on-premises VMware environment. In the next unit, we'll go through network-configuration steps. You'll take those steps to successfully connect to the Azure VMware Solution environment, both from within Azure and from your on-premises environment.
