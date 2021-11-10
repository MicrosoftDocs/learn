TODO The R&D team working on the toy car have started their trial. Now, as you expected, the R&D team developing the toy dog has come to you to ask for the same set of Azure resources, as well as another storage account for them to use to store photos of traffic lights. You decide to take the components that are common to both teams and create your own Bicep module from them, then publish it to a private registry so that anyone in your toy company can use the modules.

In this exercise, you create two Bicep modules and publish them to your private registry.

> [!div class="checklist"]
> * Update your Bicep file to include two new modules.
> * Deploy a new private registry.
> * Publish the modules to your registry.
> * Create a new Bicep file that uses the modules together.

## Create a module for your storage account

TODO instead of defining your storage account in your main file you'll define in a module. You make it more extensible in the process, and enforce some rules (no keys, no HTTPS)

1. In Visual Studio Code, create a new file named *storage.bicep*.

1. Paste the following code into the *storage.bicep* file:

   ::: code language="bicep" source="code/5-storage.bicep" :::

1. Save the file.

## Create a module for an App Service application

TODO explain

1. Create a new file named *app.bicep*.

1. Paste the following code into the *app.bicep* file:

   ::: code language="bicep" source="code/5-app.bicep" :::

1. Save the file.

## Create an Azure container registry

Here, you create a new registry to store and share your Bicep modules. You'll use Azure Container Registry.

::: zone pivot="cli"

1. Decide on a unique name for your container registry. The name can't be used by any other Azure customers. Choose a name that is between 5 and 50 characters in length and contains letters and numbers. You'll use this in subsequent steps.

1. Create a container registry by running this command in the Visual Studio Code **Terminal**. Make sure to replace the name placeholder with the name you selected in the preceding step.

   ```azurecli
   az acr create \
     --name YOUR_CONTAINER_REGISTRY_NAME \
     --sku Basic \
     --location westus
   ```

::: zone-end

::: zone pivot="powershell"

1. Decide on a unique name for your container registry. The name can't be used by any other Azure customers. Choose a name that is between 5 and 50 characters in length and contains letters and numbers. You'll use this in subsequent steps.

1. Create a container registry by running this command in the Visual Studio Code **Terminal**. Make sure to replace the name placeholder with the name you selected in the preceding step.

   ```azurepowershell
   New-AzContainerRegistry `
     -Name YOUR_CONTAINER_REGISTRY_NAME `
     -Sku Basic `
     -Location westus
   ```

::: zone-end

## Publish the modules to your registry

::: zone pivot="cli"

1. In the Visual Studio Code **Terminal**, run the following commands. Make sure to replace `YOUR_CONTAINER_REGISTRY_NAME` with the name of your private registry.

   ```azurecli
   az bicep publish \
     --file storage.bicep \
     --target 'br:YOUR_CONTAINER_REGISTRY_NAME.azurecr.io/storage:v1'

   az bicep publish \
     --file app.bicep \
     --target 'br:YOUR_CONTAINER_REGISTRY_NAME.azurecr.io/app:v1'
   ```

   Notice that you didn't need to sign in. Bicep uses the sign-in information from the Azure CLI to authenticate you to the registry.

1. Run the following command to list the artifacts in your registry:

   ```azurecli
   az acr repository list \
     --name YOUR_CONTAINER_REGISTRY_NAME
   ```

   The output shows the names of your modules:

   ```output
   [
     "app",
     "storage"
   ]
   ```

::: zone-end

::: zone pivot="powershell"

1. In the Visual Studio Code **Terminal**, run the following commands. Make sure to replace `YOUR_CONTAINER_REGISTRY_NAME` with the name of your private registry.

   ```bash
   bicep publish storage.bicep \
     --target 'br:YOUR_CONTAINER_REGISTRY_NAME.azurecr.io/storage:v1'

   bicep publish app.bicep \
     --target 'br:YOUR_CONTAINER_REGISTRY_NAME.azurecr.io/app:v1'
   ```

   Notice that you didn't need to sign in. Bicep uses the sign-in information from Azure PowerShell to authenticate you to the registry.

1. Run the following command to list the artifacts in your registry:

   ```azurepowershell
   Get-AzContainerRegistryRepository -RegistryName YOUR_CONTAINER_REGISTRY_NAME
   ```

   The output shows the names of your modules:

   ```output
   app
   storage
   ```

::: zone-end

   You can also use the Azure portal to list the modules in your registry.

## Create a bicepconfig.json file

1. In Visual Studio Code, create a new file named *bicepconfig.json*. Ensure you create it in the same folder as the *main.bicep* file.

1. Paste the following into the *bicepconfig.json* file. Make sure to replace `YOUR_CONTAINER_REGISTRY_NAME` with the name of your private registry.

   ::: code language="bicep" source="code/5-bicepconfig.json" :::

1. Save the file.

## Update your Bicep file to use the new module

1. In Visual Studio Code, open the *main.bicep* file.

1. Delete all of the file's contents.

1. At the top of the file, add the following parameters and variables:

   ::: code language="bicep" source="code/5-main.bicep" range="1-17" :::

1. Below the variable declarations, define the storage account's module:

   ::: code language="bicep" source="code/5-main.bicep" range="19-29" :::

   Notice that you use the `ToyCompanyRegistry` alias that you defined in the *bicepconfig.json* file.

1. Below the `storageAccount` module definition, define the managed identity module:

   ::: code language="bicep" source="code/5-main.bicep" range="31-39" :::

1. Below the `managedIdentity` module definition, define the app module:

   ::: code language="bicep" source="code/5-main.bicep" range="41-64" :::

1. Save the file.

## Deploy to Azure

In the Visual Studio Code **Terminal**, deploy the template to Azure by running the following command. This process can take a couple of minutes to complete, and then you'll have a successful deployment.

::: zone pivot="cli"

```azurecli
az deployment group create \
   --template-file main.bicep
```

::: zone-end

::: zone pivot="powershell"

```azurepowershell
New-AzResourceGroupDeployment -TemplateFile main.bicep
```

::: zone-end

### Verify the deployment

1. In the Azure portal, navigate to the **<rgn>[sandbox resource group name]</rgn>** resource group.

1. TODO navigate to deployments

1. Notice that four deployments are listed: *main*, which represents the deployment of your parent Bicep file, and *managedIdentity*, *storageAccount*, and *app*, which represent the modules that you included in your *main.bicep* file.
