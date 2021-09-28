[!INCLUDE [Sandbox explanation](../../includes/azure-template-exercise-sandbox-subscription.md)]

You've already helped team building the toy car to build the first part of their template, which includes an Azure Cosmos DB database. Now, you need to add an Azure Machine Learning workspace to the template. Azure Machine Learning workspaces require multiple components to be deployed, so you decide to use a module from public Bicep registry to simplify your template.

In this exercise, you create a Bicep file that includes a module from the public registry. During the process, you'll:

> [!div class="checklist"]
> * Create a Bicep file that refers to the module from the registry.
> * Build and inspect the Bicep file to understand how the module restore process works.
> * Deploy your file to Azure.

[!INCLUDE [Install the Bicep extension for Visual Studio Code](../../includes/azure-template-bicep-exercise-vscode-extension.md)]

## Create a Bicep file

1. Open Visual Studio Code.

1. Create a new file called *main.bicep*.

1. Save the empty file so that Visual Studio Code loads the Bicep tooling. 
 
   You can either select **File** > **Save As** or select <kbd>Ctrl+S</kbd> in Windows (<kbd>⌘+S</kbd> on macOS). Be sure to remember where you've saved the file. For example, you might want to create a *scripts* folder to save it in.

1. Copy the following Bicep code into the file:

   TODO

   This creates an Azure Cosmos DB account, a database, and a container for the trial data.

1. Save the changes to the file.

## Add a module

1. Add the following module definition to the *main.bicep* file:

   TODO

   Notice that this imports a module from the public Bicep module registry.

1. Save the changes to the file.

## Build and inspect your Bicep file

::: zone pivot="cli"

1. In the Visual Studio Code **Terminal**, run the following command to build the Bicep file to a JSON file.

   ```azurecli
   az bicep build --file main.bicep
   ```

   Bicep creates a file named *main.json* in the same folder as the *main.bicep* file.

1. Open the *main.json* file.

::: zone-end

::: zone pivot="powershell"

1. In the Visual Studio Code **Terminal**, run the following command to build the Bicep file to a JSON file.

   ```powershell
   bicep build main.bicep
   ```

   Bicep creates a file named *main.json* in the same folder as the *main.bicep* file.

1. Open the *main.json* file.

::: zone-end

   Scroll to the TODO part of the file. Notice that there are multiple resources defined, including a key vault, a storage account, an Application Insights instance, and an Azure Machine Learning workspace. These are all defined in the module you added.

## Deploy the Bicep template to Azure

::: zone pivot="cli"

[!INCLUDE [Bootstrapping instructions for first Bicep exercise - CLI](../../includes/azure-template-bicep-exercise-sandbox-deploy-cli.md)]

### Deploy the template to Azure by using the Azure CLI

In the Visual Studio Code **Terminal**, deploy the Bicep template to Azure by running the following code.

```azurecli
az deployment group create --template-file main.bicep
```

::: zone-end

::: zone pivot="powershell"

[!INCLUDE [Bootstrapping instructions for first Bicep exercise - PowerShell](../../includes/azure-template-bicep-exercise-sandbox-deploy-powershell.md)]

### Deploy the template to Azure by using Azure PowerShell

In the Visual Studio Code **Terminal**, deploy the template to Azure by running the following Azure PowerShell command. This process can take a couple of minutes to complete, and then you'll have a successful deployment.

```azurepowershell
New-AzResourceGroupDeployment -TemplateFile main.bicep
```

::: zone-end

You'll see `Running...` in the terminal.

Wait for deployment to finish.

## Verify the deployment

Use the Azure portal to inspect the resources that you deploy and to inspect the results of each deployment.

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true), and make sure you're in the sandbox subscription by doing the following:

   a. Select your avatar at the upper right.  
   b. Select **Switch directory**. In the list, select the **Microsoft Learn Sandbox** directory.

1. On the left pane, select **Resource groups**.

1. Select **<rgn>[sandbox resource group name]</rgn>**.

1. In the **Overview** section, you can see that two deployments have succeeded.

   Notice that the name of one of the deployments is *main*. This represents the deployment you initiated for your template. The other deployment is named *machine-learning-workspace*, and it represents the deployment of the resources defined in the module you included in the template.
