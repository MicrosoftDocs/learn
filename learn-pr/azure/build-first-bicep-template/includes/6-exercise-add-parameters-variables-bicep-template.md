In this exercise, you'll update the Bicep template you previously created so it:
- Accepts parameters for the resource locations and names
- Uses your business rules to select the right SKUs for the resources being deployed

During the process, you'll:

> [!div class="checklist"]
> * Update the template to include a `location` parameter
> * Update the template to include parameters and variables for the resource names
> * Use expressions to set default values for the parameters
> * Update the template to include variables for the SKU of each resource
> * Test the deployment to ensure that the template is valid

## Add the location and resource name parameters

1. In the *main.bicep* file in Visual Studio Code, add the following code to the top of the file:

   :::code language="bicep" source="code/6-template-1.bicep" range="1-5":::

   As you type, the Bicep linter adds yellow squiggly lines underneath each of the parameter and variable names to indicate they're not currently used. You'll fix this soon.

   Notice that you're using expressions that include string interpolation and the `uniqueString()` function to define default parameter values. Someone deploying this template can override the default parameter values by specifying the values at deployment time, but they can't override the variable values.

   Also notice that you're using a variable for the name of the Azure App Service plan, but you're using parameters for the other names. Storage accounts and App Service apps need globally unique names, but App Service plan names need to be unique only within their resource group. This difference means it's not a concern to use the same App Service plan name across different deployments, as long as the deployments are all going into different resource groups.

   [!INCLUDE [Sandbox location note](../../includes/azure-template-bicep-exercise-sandbox-location.md)]

1. Find the places within the resource definitions where the `location` and `name` properties are set, and update them to use the parameter values. After you're finished, the resource definitions within your Bicep file should look like this:

   :::code language="bicep" source="code/6-template-1.bicep" range="7-34" highlight="2-3, 14-15, 22-23":::

1. Save the changes to the file.

## Automatically set the SKUs for each environment type

1. In the *main.bicep* file in Visual Studio Code, add the following Bicep parameter below the parameters that you created in the previous task:

   :::code language="bicep" source="code/6-template-2.bicep" range="5-9":::

   Notice that you're defining a parameter with a set of allowed values, but you're not specifying a default value for this parameter.

1. Below the line that declares the `appServicePlanName` variable, add the following variable definitions:

   :::code language="bicep" source="code/6-template-2.bicep" range="12-13" :::

   Notice that you're setting these variables' values by using the ternary operator to express some if/then/else logic.

1. Find the places within the resource definitions where the `sku` properties are set and update them to use the parameter values. After you're finished, the resource definitions in your Bicep file should look like this:

   :::code language="bicep" source="code/6-template-2.bicep" range="15-42" highlight="5, 17":::

   Notice that you haven't parameterized everything. You've set some properties right in the resource definitions, where you know these aren't going to change between deployments.

1. Save the changes to the file.

### Deploy the updated Bicep template

::: zone pivot="cli"

Run the following Azure CLI command in the terminal. This is similar to the command you ran before.

```azurecli
az deployment group create \
  --template-file main.bicep \
  --parameters environmentType=nonprod
```

::: zone-end

::: zone pivot="powershell"

Run the following Azure PowerShell command in the terminal. This is similar to the command you ran before.

```azurepowershell
New-AzResourceGroupDeployment `
  -TemplateFile main.bicep `
  -environmentType nonprod
```

::: zone-end

Notice that you're explicitly specifying the value for the `environmentType` parameter when you execute the deployment. You don't need to specify all of the other parameter values, because they have defaults that make sense.

### Check your deployment

1. In your browser, go back to the [Azure portal](https://portal.azure.com?azure-portal=true). Go to your resource group. You'll still see one successful deployment, because the deployment used the same name as the first deployment.

1. Select the **1 Succeeded** link.

1. Select the deployment called **main**, and then select **Deployment details** to expand the list of deployed resources.

    :::image type="content" source="../media/6-addparams-details.png" alt-text="Screenshot of the Azure portal interface for the specific deployment, with storage account and App Service resources listed with generated names." border="true":::

1. Notice that a new App Service app and storage account have been deployed with randomly generated names.
