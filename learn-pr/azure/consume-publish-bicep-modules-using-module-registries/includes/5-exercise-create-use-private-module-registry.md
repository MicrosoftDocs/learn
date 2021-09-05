TODO scenario

In this exercise, you create a Bicep module and publish it to a module registry

> [!div class="checklist"]
> * Deploy a new private registry.
> * Create a module and publish it to your registry.
> * Create a new Bicep file that uses the module to test it.

## Create a registry

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

## Create a module

1. In Visual Studio Code, create a new file named *module.bicep*.

1. Paste the following Bicep code into *module.bicep*:

   ```bicep
   // TODO
   ```

## Publish the module to your registry

::: zone pivot="cli"

1. In the Visual Studio Code **Terminal**, run the following command. Make sure to replace `YOUR_CONTAINER_REGISTRY_NAME` with the name of your private registry.

   ```azurecli
   az bicep publish \
     --file module.bicep \
     --target 'br:YOUR_CONTAINER_REGISTRY_NAME.azurecr.io/test/test:v1'
   ```

1. Run the following command to list the artifacts in your registry:

   ```azurecli
   az acr repository list \
     --name YOUR_CONTAINER_REGISTRY_NAME
   ```

   Notice that the list contains TODO.

::: zone-end

::: zone pivot="powershell"

1. In the Visual Studio Code **Terminal**, run the following command. Make sure to replace `YOUR_CONTAINER_REGISTRY_NAME` with the name of your private registry.

   ```bash
   bicep publish module.bicep \
     --target 'br:YOUR_CONTAINER_REGISTRY_NAME.azurecr.io/test/test:v1'
   ```

1. Run the following command to list the artifacts in your registry:

   ```azurepowershell
   Get-AzContainerRegistryRepository -Name YOUR_CONTAINER_REGISTRY_NAME
   ```

   Notice that the list contains TODO.

::: zone-end

## Update your Bicep file to use the new module

1. In Visual Studio Code, open the *main.bicep* file.

1. At the bottom of the file, add the following module definition. Make sure to replace `YOUR_CONTAINER_REGISTRY_NAME` with the name of your private registry.

   ```bicep
   module todo 'br:YOUR_CONTAINER_REGISTRY_NAME.azurecr.io/test/test:v1' = {
     name: 'todo'
     params: {
     }
   }
   ```

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
