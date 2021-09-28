The R&D team working on the toy car have started their trial. Now, as you expected, the R&D team developing the toy dog has come to you to ask for the same set of Azure resources, as well as another storage account for them to use to store photos of traffic lights. You decide to take the components that are common to both teams and create your own Bicep module from them, then publish it to a private registry so that anyone in your toy company can use the modules.

In this exercise, you create a Bicep module and publish it to a registry.

> [!div class="checklist"]
> * Create a module.
> * Deploy a new private registry.
> * Publish the module to your registry.
> * Create a new Bicep file that uses the module to test it.

## Create a module

1. In Visual Studio Code, rename the *main.bicep* file to *modules/autonomous-toy.bicep*.

1. Create a new file named *main.bicep*. You'll add some resources to it soon.

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

## Publish the module to your registry

::: zone pivot="cli"

1. In the Visual Studio Code **Terminal**, run the following command. Make sure to replace `YOUR_CONTAINER_REGISTRY_NAME` with the name of your private registry.

   ```azurecli
   az bicep publish \
     --file module.bicep \
     --target 'br:YOUR_CONTAINER_REGISTRY_NAME.azurecr.io/solutions/autonomous-toy:v1'
   ```

   Notice that you didn't need to sign in. Bicep uses the sign-in information from the Azure CLI to authenticate you to the registry.

1. Run the following command to list the artifacts in your registry:

   ```azurecli
   az acr repository list \
     --name YOUR_CONTAINER_REGISTRY_NAME
   ```

   The output shows a single entry with the name of your module:

   ```output
   [
     "todo/todo"
   ]
   ```

::: zone-end

::: zone pivot="powershell"

1. In the Visual Studio Code **Terminal**, run the following command. Make sure to replace `YOUR_CONTAINER_REGISTRY_NAME` with the name of your private registry.

   ```bash
   bicep publish module.bicep \
     --target 'br:YOUR_CONTAINER_REGISTRY_NAME.azurecr.io/solutions/autonomous-toy:v1'
   ```

   Notice that you didn't need to sign in. Bicep uses the sign-in information from Azure PowerShell to authenticate you to the registry.

1. Run the following command to list the artifacts in your registry:

   ```azurepowershell
   Get-AzContainerRegistryRepository -RegistryName YOUR_CONTAINER_REGISTRY_NAME
   ```

   The output shows a single entry with the name of your module:

   ```output
   todo/todo
   ```

::: zone-end

## Update your Bicep file to use the new module

1. In Visual Studio Code, open the *main.bicep* file.

1. At the bottom of the file, add the following module definition. Make sure to replace `YOUR_CONTAINER_REGISTRY_NAME` with the name of your private registry.

   ```bicep
   module autonomousToyComponents 'br:YOUR_CONTAINER_REGISTRY_NAME.azurecr.io/solutions/autonomous-toy:v1' = {
     name: 'autonomousToyComponents'
     params: {
     }
   }
   ```

1. Save the file.

## Add a storage account to your template

1. At the bottom of the *main.bicep* file, add the following storage account definition:

   TODO

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

1. TODO verify deployment
