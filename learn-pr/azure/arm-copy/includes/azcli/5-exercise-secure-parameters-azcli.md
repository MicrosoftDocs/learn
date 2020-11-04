Here you will deploy a KeyVault, add a secret and then deploy a VM that reads a secret from said KeyVault.

## Prerequisites

- **Install Visual Studio Code extension**. This exercise uses the [Azure Resource Manager Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools?azure-portal=true). Be sure to install this extension in Visual Studio Code.

- **Install latest Azure CLI**. To use what-if in Azure CLI, you must have Azure CLI 2.5.0 or later. If needed, [install the latest version of Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest&azure-portal=true).

## Exercise overview

Here's an overview of the steps you are about to carry out:

- **Sign in to Azure**. You will be able to sign in using Visual Studio Code and using the integrated terminal.
- **Set the active subscription**. This can be accomplished by invoking a Azure CLI command.
- **Set default resource group**. This can be accomplished by invoking a Azure CLI command. The reason for setting these default values on subscription and resource group is to ensure the resources are created in the correct place.
- **Carry out the deployment**. This step involves using the command **az deployment group create** with a URL to a template as an argument.

## Sign in to Azure

1. Open the integrated terminal in Visual Studio Code. Be sure you are signing in to the same account that activated the sandbox.

1. Run `az login` to login from the Visual Studio Code terminal.

    ```azurecli
    az login
    ```

1. Select an appropriate user in the browser and close browser window when prompted.

   Once you are logged in, you see a list, in JSON format. The list contains subscriptions associated with this account in the terminal, if you activated the sandbox.

## Set the active subscription

Run `az account set` to set a specific subscription as active:

```azurecli
   az account set -s "Concierge Subscription"
```

This will set the active subscription to that of the *Concierge Subscription*.

> [!NOTE]
> if it fails, run `az account list --refresh --all` and then rerun the command

## Set the default resource group

You now need to set the resource group created for you in the sandbox as the default resource group.

1. Run `az group list` to get the resource group name.

   ```azurecli
   az group list -o table
   ```

1. Run `az configure` to set the default name.

   ```azurecli
   az configure --defaults group=<rgn>resource group name</rgn>
   ```

  Use the name of the resource name provided by the last command in this command. (It will look like something like **learn-a73131a1-b618-48b8-af70-21af7ca420c4**). Using the name, will allow you to omit that parameter from the rest of the Azure PowerShell commands in this exercise.

  > [!NOTE]
  > Normally, when you use an Azure CLI command to deploy a template you need to specify the target **resource group** name.  In the exercise in this module we are bypassing this requirement by setting the context of our deployment by specifying our sandbox resource group name in the step below by using the **az configure** Azure CLI command.

## Deploy a KeyVault

You need to both deploy the KeyVault and once created you will need to add a secret.

1. Run the command `az keyvault create`:

    ```azurecli
    read -p "Enter a vault name" vaultName
    read -p "Enter a location" location

    az keyvault create \
    --name $vaultName \
    --resource-group <rgn>name of resource group</rgn> \
    --location $location \
    --enabled-for-template-deployment true
    ```

    The above command will create a KeyVault. The usage of the flag `-EnabledForTemplateDeployment` ensures it the KeyVault can be read from, from an ARM template.

1. Run the command `az keyvault secret set`:

   ```azurecli
   export secretPlainText=abc123!
   export secretName=vmPassword

   az keyvault secret set --vault-name $vaultName --name $secretName --value $secretPlainText
   ```

   The above command ensures the plain text password is converted to a so called secure string. Thereafter the name of the secret and the now encoded secret value  is being added to the KeyVault you've just created.

   Everything should be set up at this point so you can deploy the VM next.  

## Deploy a VM and set password based on a KeyVault secret

1. Fetch the following ARM template from the URL `https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-vm-simple-windows/azuredeploy.json` and store it locally as a file `vmdeploy.json`.

1. Run the command `az keyvault show`:

   ```azurecli
   az keyvault show --name $vaultName
   ```

   Make a note of the value from the field `Resource ID`. You will need this value to modify the file `vmdeploy.json`.

1. Save down the following file `https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-vm-simple-windows/azuredeploy.parameters.json` and name it `vmdeploy.parameters.json`

1. Locate the parameters section in `vmdeploy.parameters.json` and the `adminPassword` parameter. Replace it's content with the following text:

   ```json
   "adminPassword": {
     "reference": {
        "keyVault": {
        "id": "/subscriptions/<SubscriptionID>/resourceGroups/mykeyvaultdeploymentrg/providers/Microsoft.KeyVault/vaults/<KeyVaultName>"
        },
        "secretName": "vmPassword"
     }
   }
   ```

   The `id` parameter's value needs to be replaced with the `Resource ID` of the KeyVault you were asked to note down.

1. Run the command `az deployment group create`:

   ```azurecli
   az deployment group create \
      --resource-group <rgn>resource group name</rgn> \
      --template-file "./vmdeploy.json" \
      --parameters "./vmdeploy.parameters.json"
   ```

### Verify deployment

1. Navigate to portal.azure.com
1. Select Resource groups > **\<rgn>your resource group\</rgn>** > simple-vm.
1. Select connect at the top.

1. Select Download RDP File, and then follow the instructions to sign in to the virtual machine by using the password that's stored in the key vault.

Congrats, you've managed to deploy an Azure KeyVault. Additionally you've managed to create a VM while reading from the Azure KeyVault.
