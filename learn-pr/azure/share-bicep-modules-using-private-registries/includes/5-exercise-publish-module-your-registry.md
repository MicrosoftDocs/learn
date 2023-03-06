You've created a private registry for your toy company to use. In this exercise, you will:

> [!div class="checklist"]
>
> - Create a module for the website resources.
> - Create another module for the resources in the CDN.
> - Publish the modules to your registry.
> - List the modules in the registry.

[!INCLUDE [Install the Bicep extension for Visual Studio Code](../../includes/azure-template-bicep-exercise-vscode-extension.md)]

## Create a module for a website

You previously created a module that deploys a website. Here, you save the module file so you can publish it.

1. Open Visual Studio Code.

1. Create a new file named _website.bicep_.

1. Paste the following code into the _website.bicep_ file:

   ::: code language="bicep" source="code/5-website.bicep" :::

1. Save the file.

   You can either select **File** > **Save As** or select <kbd>Ctrl+S</kbd> on Windows (<kbd>⌘+S</kbd> on macOS). Be sure to remember where you save the file. For example, you might want to create a _templates_ folder to save it in.

## Create a module for a CDN

Similar to the previous steps, you save a precreated module file so that you can publish it soon.

1. Create a new file named _cdn.bicep_.

1. Paste the following code into the _cdn.bicep_ file:

   ::: code language="bicep" source="code/5-cdn.bicep" :::

1. Save the file.

## Publish the modules to your registry

::: zone pivot="cli"

1. In the Visual Studio Code terminal, run the following commands. Replace `YOUR_CONTAINER_REGISTRY_NAME` with the name of your private registry.

   ```azurecli
   az bicep publish \
     --file website.bicep \
     --target 'br:YOUR_CONTAINER_REGISTRY_NAME.azurecr.io/website:v1'

   az bicep publish \
     --file cdn.bicep \
     --target 'br:YOUR_CONTAINER_REGISTRY_NAME.azurecr.io/cdn:v1'
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
     "cdn",
     "website"
   ]
   ```

::: zone-end

::: zone pivot="powershell"

1. In the Visual Studio Code terminal, run the following commands. Replace `YOUR_CONTAINER_REGISTRY_NAME` with the name of your private registry.

   ```bash
   bicep publish website.bicep \
     --target 'br:YOUR_CONTAINER_REGISTRY_NAME.azurecr.io/website:v1'

   bicep publish cdn.bicep \
     --target 'br:YOUR_CONTAINER_REGISTRY_NAME.azurecr.io/cdn:v1'
   ```

   Notice that you didn't need to sign in. Bicep uses the sign-in information from Azure PowerShell to authenticate you to the registry.

1. Run the following command to list the artifacts in your registry:

   ```azurepowershell
   Get-AzContainerRegistryRepository -RegistryName YOUR_CONTAINER_REGISTRY_NAME
   ```

   The output shows the names of your modules:

   ```output
   cdn
   website
   ```

::: zone-end

   You can also use the Azure portal to list the modules in your registry.
