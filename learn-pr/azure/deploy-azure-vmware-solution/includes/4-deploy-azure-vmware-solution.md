The Azure VMware Solution (AVS) environment can be built after all planning steps are complete. AVS will give your company the ability to deploy a vSphere cluster in Azure. AVS also provides an easy migration path to bring workloads into Azure. You'll use all the information gathered from the planning units to successfully deploy AVS.

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
1. Select the subscription you want to register the provider for.
1. Select **Resource providers** and enter **Microsoft.AVS** in the search bar. If the resource provider isn't registered, select **Register**.

    :::image type="content" source="../media/4-register-resource-provider.png" alt-text="Screenshot that shows the Register button at the top of the Subscription > Resource providers page in the Azure portal.":::

## Deploy Azure VMware Solution

When you're ready to deploy AVS, make sure you at least have contributor rights to the subscription. Be ready to use some of the information you gathered during the planning phase of the AVS deployment to create the resource in Azure.

Follow these steps:

1. On the Azure portal menu, select **Create a resource**.
1. In the **Search the Marketplace** text box, enter **Azure VMware Solution**, select the resource, and then select **Create**.
1. On **Azure VMware Solution**, select **Create**.
1. On the **Basics** tab, enter values for the fields:

    :::image type="content" source="../media/4-create-private-cloud.png" alt-text="Screenshot of the Azure portal showing how to create an Azure VMware Solution private cloud with all required fields for deployment.":::

    Here's a description of the value expected in each field:

    | Field | Value |
    | :----- | :----- |
    | **Subscription** | The subscription for the deployment. |
    | **Resource group** | The resource group for private cloud resources. |
    | **Location** | A location where AVS can be deployed. |
    | **Resource name** | A name for the Azure VMware Solution private cloud. |
    | **SKU** | The SKU value: AV36 |
    | **Hosts** | The number of hosts to add to the private cloud cluster. |
    | **Address block** | An IP address block for the CIDR network for the private cloud. |
    | **Virtual Network** | The virtual network. Select an existing virtual network, create a new one, or leave the field blank. |

1. After all fields are filled in, select **Review + Create**. The AVS deployment might take up to two full hours to finish.

1. When deployment is complete, select the resource group, and then select the private cloud. The **Status** will show **Succeeded**:

    :::image type="content" source="../media/4-validate-deployment.png" alt-text="Screenshot validating deployment successfully completed.":::

 AVS connectivity will require further configuration to communicate with Azure resources and the on-premises VMware environment. In the next unit, we'll go through network-configuration steps. You'll take those steps to successfully connect to the AVS environment, both from within Azure and from your on-premises environment.
