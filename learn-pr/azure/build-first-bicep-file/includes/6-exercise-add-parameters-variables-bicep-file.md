> [!NOTE]
> This exercise is optional. If you want to complete it, you'll need an Azure subscription before you begin. If you don't have an Azure account or don't want to create one now, you can read through the instructions to understand the concepts.

In this exercise, you'll update the Bicep file you previously created so it:

- Accepts parameters for the resource locations and names.
- Uses your business rules to select the right SKUs for the resources being deployed.

During the process, you'll:

> [!div class="checklist"]
>
> - Update the Bicep file to include a `location` parameter.
> - Update the Bicep file to include parameters and variables for the resource names.
> - Use expressions to set default values for the parameters.
> - Update the Bicep file to include variables for the SKU of each resource.
> - Test the deployment to ensure that the Bicep file is valid.

## Add the location and resource name parameters

Make resource locations and names configurable by adding parameters to your file:

1. In the _main.bicep_ file in Visual Studio Code, add the following code to the top of the Bicep file:

   :::code language="bicep" source="code/6-template-1.bicep" range="1-5":::

   The Bicep linter adds yellow squiggly lines underneath each parameter and variable name to indicate they're not used in the Bicep file. You'll fix this issue soon.

   Notice that you're using expressions that include string interpolation and the `uniqueString()` function to define default parameter values. Someone deploying this Bicep file can override the default parameter values by specifying the values at deployment time, but they can't override the variable values.

   Also notice that you're using a variable for the Azure App Service plan name, but you're using parameters for the other names. Storage accounts and App Service apps need globally unique names, but App Service plan names need to be unique only within their resource group. This difference means it's not a concern to use the same App Service plan name across different deployments, as long as the deployments are all going into different resource groups.

   > [!NOTE]
   > Complete this exercise in your own Azure subscription. These examples use `eastus` as the default resource location. Your resource group's location stores its metadata; it doesn't require every resource in the group to use that region. Choose a region where your subscription can create the required storage account and Windows App Service Free (F1) plan. If you need another region, use it consistently for the app, its plan, and the storage account, and keep that choice in subsequent deployments. A reusable template can instead default to `resourceGroup().location` when that region is appropriate for all of its resources.
   >
   > Changing a resource's `location` property doesn't move an existing resource. If you restart these exercises in another region, use a new dedicated resource group and available resource names.

1. Find the places within the resource definitions where the `location` and `name` properties are set, and update them to use the parameter values. After you're finished, the resource definitions within your Bicep file should look like this:

   :::code language="bicep" source="code/6-template-1.bicep" range="7-34" highlight="2-3, 14-15, 22-23":::

1. Save the changes to the file.

## Automatically set the SKUs for each environment type

Use an environment parameter and variables to select the appropriate resource SKUs:

1. In the _main.bicep_ file in Visual Studio Code, add the following Bicep parameter below the parameters that you created in the previous task:

   :::code language="bicep" source="code/6-template-2.bicep" range="5-9":::

   Notice that you're defining a parameter with a set of allowed values, but you're not specifying a default value for this parameter.

1. Below the line that declares the `appServicePlanName` variable, add the following variable definitions:

   :::code language="bicep" source="code/6-template-2.bicep" range="12-13" :::

   Notice that you're setting these variables' values by using the ternary operator to express some `if/then/else` logic.

1. Find the storage account and App Service plan `sku.name` properties. Set them to the `storageAccountSkuName` and `appServicePlanSkuName` variables, respectively. These variables compute their values from the `environmentType` parameter. After you finish, the resource definitions should look like the following example.

   :::code language="bicep" source="code/6-template-2.bicep" range="15-42" highlight="5, 17":::

   Notice that you haven't parameterized everything. You've set some properties right in the resource definitions, where you know these values aren't going to change between deployments.

   > [!NOTE]
   > Continue setting `environmentType` to `nonprod` and using the same exercise resource group for this walkthrough. The `prod` value illustrates a paid production configuration, not a step to run in these exercises. Before using it for a separate environment, review the production deployment prerequisites in Selecting SKUs for resources in the Add flexibility by using parameters and variables unit.

1. Save the changes to the file.

## Verify your Bicep file

After you've completed all of the preceding changes, your _main.bicep_ file should look like this example:

:::code language="bicep" source="code/6-template-2.bicep" :::

If your file doesn't match, copy the example or adjust your file to match the example.

### Deploy the updated Bicep file

> [!NOTE]
> Use the same subscription and resource group throughout these exercises. Reapply any resource-name or location parameter overrides from the preceding deployment; otherwise, the defaults in the template are used again.

::: zone pivot="cli"

Run the following Azure CLI command in the terminal.

```azurecli
az deployment group create \
  --resource-group "$resourceGroupName" \
  --name main \
  --template-file main.bicep \
  --parameters environmentType=nonprod
```

::: zone-end

::: zone pivot="powershell"

Run the following Azure PowerShell command in the terminal.

```azurepowershell
New-AzResourceGroupDeployment `
  -ResourceGroupName $resourceGroupName `
  -Name main `
  -TemplateFile main.bicep `
  -environmentType nonprod
```

::: zone-end

Notice that you're explicitly specifying the value for the `environmentType` parameter when you execute the deployment. You don't need to specify the other parameter values, because they have valid default values.

### Check your deployment

Confirm that your deployment uses the expected resource names:

1. In your browser, return to the Azure portal and go to your resource group. Reusing the name `main` updates that deployment's history entry rather than adding a separately named deployment.

1. Open the resource group's **Deployments** history.

1. Select the deployment called **main**. Confirm that its latest operation succeeded and corresponds to the command you just ran, then select **Deployment details** to expand the list of deployed resources.

    :::image type="content" source="../media/6-addparams-details.png" alt-text="Screenshot of Azure portal deployment details showing generated names for storage account and App Service resources." border="true":::

1. Notice that the app and storage account names are generated deterministically from the resource group ID. With the same inputs, `uniqueString()` returns the same value on each deployment. If you supplied explicit resource-name parameter values, those values are used instead of the generated defaults.

   > [!NOTE]
   > The sample now also uses the App Service plan name `toy-product-launch-plan`, rather than `toy-product-launch-plan-starter`. When the new names differ from the earlier exercise's names, this deployment creates a new app, storage account, and plan. The default incremental deployment mode leaves the earlier resources in the resource group; it doesn't rename or delete them. Reusing the deployment name `main` replaces that deployment's history entry, not the earlier resources.
