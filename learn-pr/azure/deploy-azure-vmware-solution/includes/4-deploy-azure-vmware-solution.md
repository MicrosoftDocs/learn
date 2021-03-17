The AVS environment can be built once all pre-planning steps are complete. AVS will provide your company an ability to deploy a vSphere cluster in Azure. AVS also allows for an easy migration path to bring workloads into Azure. You'll use all the information gathered from the planning units to successfully deploy AVS. 

## Register the resource provider

The resource provider must be registered within the subscription. Registering the resource provider can be done through the Azure portal, Azure CLI, or PowerShell.

Launch Azure Cloud Shell, sign in to your Azure subscription, and run the following command for Azure CLI:

```azurecli
az provider register -n Microsoft.AVS --subscription <your subscription ID>    
```

Launch Azure Cloud Shell, sign in to your Azure subscription, and run the following command for PowerShell:

```powershell
Register-AzResourceProvider -ProviderNamespace Microsoft.AVS
```

If you use the Azure portal, search for **Subscriptions** and select the subscription you need to register the provider for. Select **Resource providers** and enter Microsoft.AVS into the search bar. If the resource provider is not registered, select **Register**.

:::image type="content" source="../media/4-register-resource-provider.png" alt-text="Screenshot that shows the Register button at the top of the Subscription > Resource providers page.":::

## Deploy Azure VMware Solution

Once you're ready to deploy AVS, make sure you at least have contributor rights to the subscription. Use some of the information gathered during the planning phase of the AVS deployment to create the resource in Azure.

1. On the Azure portal menu, select **Create a resource**.
1. In the **Search the Marketplace** text box, type ```Azure VMware Solution```, select the resource, and select **Create**.
1. On **Azure VMware Solution**, select **Create**.
1. On the **Basics** tab, enter values for the fields.

    :::image type="content" source="../media/4-create-private-cloud.png" alt-text="Screenshot of how to create an Azure VMware Solution private cloud with all required fields for deployment.":::

    | Field | Value |
    | ----- | ----- |
    | Subscription | Subscription for the deployment. |
    | Resource group | The resource group for private cloud resources. |
    | Location | Select a location where AVS can be deployed. |
    | Resource name | Provide name of Azure VMware Solution private cloud. |
    | SKU | Select the SKU value: AV36 |
    | Hosts | The number of hosts to add to the private cloud cluster. |
    | Address block | Enter an IP address block for the CIDR network for the private cloud. |
    | Virtual Network | Select an existing virtual network, create a new one, or leave the field blank. |

1. Once each field is filled out, select **Review + Create**.
1. The AVS deployment may take up to two full hours for deployment.
1. After deployment, select the resource group and select the private cloud. The status will show **Succeeded** when the deployment is finished.

    :::image type="content" source="../media/4-validate-deployment.png" alt-text="Screenshot validating deployment successfully completed.":::

 AVS connectivity will require configurations to communicate with Azure resources and the on-premises VMware environment. In the next unit, we'll go through network configuration steps to take so you can successfully connect to the AVS environment, both from within Azure and from on-premises.