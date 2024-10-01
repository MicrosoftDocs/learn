Azure Automanage can be enabled on existing or new virtual machines using the Azure portal, Azure Resource Manager (ARM), or Azure Policy.

## Enable Azure Automanage using the Azure portal

If you don't have an Azure subscription, [create an account](https://azure.microsoft.com/pricing/purchase-options/pay-as-you-go/) before you begin.

> [!NOTE]
> Free trial accounts do not have access to the virtual machines used in this tutorial. Please upgrade to a Pay-As-You-Go subscription.

> [!IMPORTANT]
> You need to have the **Contributor** role on the resource group containing your VMs to enable Automanage. If you are enabling Automanage for the first time on a subscription, you need the following permissions: **Owner** role or **Contributor** along with **User Access Administrator** roles on your subscription.

1. Sign in to the [Azure portal](https://portal.azure.com/).
1. In the search bar, search for and select **Automanage**.
1. In the menu, select **Automanage machines**.
1. Select **Enable on existing machine**.
    :::image type="content" source="../media/zero-vm-list-view.png" alt-text="Screenshot of enablement on existing VM.":::
1. On the **Basics** tab, select your profile type: **Azure best practices: Production** or **Azure best practices: Dev/Test**:
    :::image type="content" source="../media/existing-vm-quick-create.png" alt-text="Screenshot of choices for configuration profiles.":::
    The profile type you select determines the services and settings applied to your machine(s). To view the details for the different profiles, select **View Azure best practices profiles**:
    :::image type="content" source="../media/browse-production-profile.png" alt-text="Screenshot of services and settings for each profile.":::
1. Select the **Machines** tab, then check the box for the machine(s) you want to enable for Automanage:
    :::image type="content" source="../media/existing-vm-select-machine.png" alt-text="Screenshot showing how to select from a list of available virtual machines.":::
1. Select the Review + Create tab to review the machine(s) that you chose, then select the **Create** button.

## Enable Azure Automanage using Azure Resource Manager (ARM) templates

You can onboard a VM to Automanage using an ARM template using the following template. This ARM template creates a configuration profile assignment for your specified Azure Arc-enabled machine:

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "machineName": {
            "type": "String"
        },
        "configurationProfile": {
            "type": "String"
        }
    },
    "resources": [
        {
            "type": "Microsoft.HybridCompute/machines/providers/configurationProfileAssignments",
            "apiVersion": "2022-05-04",
            "name": "[concat(parameters('machineName'), '/Microsoft.Automanage/default')]",
            "properties": {
                "configurationProfile": "[parameters('configurationProfile')]"
            }
        }
    ]
}
```

The `configurationProfile` value can be one of the following values:

- `"/providers/Microsoft.Automanage/bestPractices/AzureBestPracticesProduction"`
- `"/providers/Microsoft.Automanage/bestPractices/AzureBestPracticesDevTest"`
- `"/subscriptions/[sub ID]/resourceGroups/resourceGroupName/providers/Microsoft.Automanage/configurationProfiles/customProfileName (for custom profiles)"`

To deploy the templates, follow these steps:

1. Save this ARM template as `azuredeploy.json`.
1. Run this ARM template deployment with `az deployment group create --resource-group myResourceGroup --template-file azuredeploy.json`.
1. Provide the values for `machineName` and `configurationProfileAssignment` when prompted.
1. You're ready to deploy.

As with any ARM template, it's possible to factor out the parameters into a separate azuredeploy.parameters.json file and use that as an argument when deploying.

## Enable Azure Automanage using Azure Policy

You can enable Automanage for multiple VMs using a built-in Azure policy.

1. Sign in to the [Azure portal](https://portal.azure.com/).
1. In the search bar, search for and select **Policy**.
1. In the menu, select **Definitions**.
1. In the **Categories** drop-down, select **Automanage**.
    The list updates to include the following policies:
    - Configure virtual machines to be onboarded to Azure Automanage 
    - Configure virtual machines to be onboarded to Azure Automanage with Custom Configuration Profile
1. Select the applicable policy. After selection, you're able to view its **Definition** tab.
    > [!NOTE]
    > The Azure Policy definition is used to set Automanage parameters like the configuration profile. It also sets filters that ensure the policy applies only to the correct VMs.
1. Select the **Assign** button to create an assignment.
1. Under the **Basics** tab, fill out **Scope** by setting the *Subscription* and *Resource Group*.
    > [!NOTE]
    > The Scope lets you define which VMs this policy applies to. Policies can be applied at the subscription level or the resource group level. If you set a resource group, all VMs that are currently in that resource group or any future VMs added to it will have Automanage automatically enabled.
1. Select the **Parameters** tab, uncheck the box for *Only show parameters that need input or review* (if necessary), and then set the **Configuration Profile** and desired **Effect**.
1. Under the **Review + create** tab, review the settings.
1. Apply the assignment by selecting **Create**.
1. View your assignments in the **Assignments** tab next to **Definition**.
