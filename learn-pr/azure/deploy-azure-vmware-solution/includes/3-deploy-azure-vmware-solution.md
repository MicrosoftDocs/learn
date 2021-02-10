The AVS environment can be built once all pre-planning steps are complete. AVS will provide your company an ability to deploy a vSphere cluster in Azure. AVS also allows for an easy migration path to bring workloads into Azure. You'll use all the information gathered from the planning module to successfully deploy AVS. 

## Register the resource provider

The resource provider must first be registered within the subscription. We discussed this task in the last unit. Registering the resource provider can be done through the Azure portal, Azure CLI, or PowerShell.

Launch Azure Cloud Shell, sign in to your Azure subscription, and run the following command for Azure CLI:

```azurecli
az provider register -n Microsoft.AVS --subscription <your subscription ID>    
```

Launch Azure Cloud Shell, sign in to your Azure subscription, and run the following command for PowerShell:

```powershell
Register-AzResourceProvider -ProviderNamespace Microsoft.AVS
```

If you use the Azure portal, search for **Subscriptions** and select the subscription you need to register the provider for. Select **Resource providers** and enter Microsoft.AVS into the search.If the resource provider is not registered, select **Register**.

:::image type="content" source="../media/3-register-resource-provider.png" alt-text="Screenshot that shows the Register button at the top of the Subscription > Resource providers page.":::

## Deploy Azure VMware Solution

Once you're ready to deploy AVS, make sure you at least have contributor rights to the subscription. Use some of the information gathered during the planning phase of the AVS deployment to create the resource in Azure.

1. On the Azure portal menu, select **Create a resource**.
1. In the **Search the Marketplace** text box, type ```Azure VMware Solution```, select the resource, and select **Create**.
1. On the **Azure VMware Solution** blade, select **Create**.
1. On the **Basics** tab, enter values for the fields.

    :::image type="content" source="../media/3-create-private-cloud.png" alt-text="Screenshot of how to create an Azure VMware Solution private cloud with all required fields for deployment.":::

    | Field | Value |
    | ----- | ----- |
    | Subscription | Subscription for the deployment. |
    | Resource group | The resource group for private cloud resources. |
    | Location | Select a location where AVS can be deployed. |
    | Resource name | Provide name of Azure VMware Solution private cloud. |
    | SKU | Select the SKU value: AV36 |
    | Hosts | The number of hosts to add to the private cloud cluster. |
    | vCenter admin password | Enter cloud administrator password. |
    | NSX-T manager password | Enter NSX-T administrator password. |
    | Address block | Enter an IP address block for the CIDR network for the private cloud. |
    | Virtual Network | Select a Virtual Network or create a new one. |

1. Once each field is filled out, select **Review + Create**.
1. The AVS deployment may take up to two full hours for deployment.
1. After deployment, select the resource group and select the private cloud. The status will show **Succeeded** when the deployment is finished.

    :::image type="content" source="../media/3-validate-deployment.png" alt-text="Screenshot validating deployment successfully completed.":::

## Create Azure Bastion host

After AVS is deployed, you'll create an Azure Bastion host. The Azure Bastion host provides secure RDP connectivity to your Azure IaaS environment. Azure Bastion will initially be used to connect to the AVS vCenter and NSX environments. Once the ExpressRoute circuits and ExpressRoute Global Reach are configured for hybrid connectivity, the Azure Bastion host isn't needed. Your comapany may want to keep the resource as a back up in case you have connectivity issues with ExpressRoute in the future.

1. In the Azure portal, search for and create a **Bastion** host.
1. On the **Create a Bastion** page, configure a new Bastion resource with the following details:

    :::image type="content" source="../media/3-create-azure-bastion-host.png" alt-text="Screenshot of creating an Azure Bastion host.":::

    | Field | Value |
    | ----------- | -------- |
    | Subscription | Select the same subscription where AVS is deployed. |
    | Resource group | Select existing or create a new resource group. |
    | Name | The name of the new Bastion resource. |
    | Region | Select the same region where AVS is deployed. |
    | Virtual network | Select the virtual network created when you deployed AVS. |
    | Subnet | Azure Bastion requires a dedicated subnet. For the virtual network created during the AVS deployment, select **Manage subnet configuration** to create the dedicated subnet. Select **+Subnet** and create a subnet with the following configurations: the subnet needs to be named **AzureBastionSubnet** and the subnet must be at least /27 or larger. |
    | Public IP address | The public IP will allow RDP and SSH over port 443 to the Bastion host. Create a new public IP and place the resource in the same region as both AVS and the Bastion host. This new public IP is separate from the AVS deployment. |
    | Public IP address name | Provide a name of the public IP address resource. |
    | Public IP address SKU | This setting is pre-populated by default to **Standard** because Bastion only supports the Standard Public IP SKU. |
    | Assignment | This setting is pre-populated by default to **Static**. Best practice is to leave assignment at static. |

After AVS and the Azure Bastion host are deployed, you'll be able to configure network connectivity. AVS connectivity will require configurations to both communicate with Azure resources and the on-premises VMware environment. In the next unit, we'll go through the configuration steps to take so you can successfully connect to the AVS environment, both from within Azure and from on-premises.