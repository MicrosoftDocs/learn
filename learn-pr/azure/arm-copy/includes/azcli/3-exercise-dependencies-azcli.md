Here you will deploy a VM containing dependencies using Azure CLI.

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

## Deploy a VM with dependencies

When you deploy a virtual machine, you should be aware that is has quite a few resources that needs to be deployed with it for it to work, it's not just a virtual machine resource.

The following resource types needs to be deployed as you deploy a VM:

- **Microsoft.Storage/storageAccounts**. You will need a storage account.

- **Microsoft.Network/publicIPAddresses**. Your VM will need a public IP.

- **Microsoft.Network/networkSecurityGroups**. A network security group contains rules for handling inbound and outbound traffic to your virtual network.

- **Microsoft.Network/virtualNetworks**. Your VM needs to be placed in a virtual network. This resource has a dependency. It expects the network security group to be deployed before it.

- **Microsoft.Network/networkInterfaces**. This resource depends on two other resources public IP addresses and virtual networks.

- **Microsoft.Compute/virtualMachines**. This is the primary resource you are looking to deploy. It in turn is dependent on two different resources namely a storage account and network interfaces.

Fortunately there's a template you can grab that contains all the above resources.

1. Grab the Azure template file from `https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-vm-simple-windows/azuredeploy.json` and save it to a local file `azuredeploy.json`

1. Run the command `az deployment group create`:

    ```azurecli
    read -p "Enter a location (i.e. centralus)" location
    export rg=<rgn>resource group name</rgn>
    read -p "Enter a name for your VM" vmName
    read -p "Enter an admin user name" adminUserName
    export adminPassword="abc123"

    az deployment group create \
      --resource-group $rg \
      --template-file './azuredeploy.json' \
      --parameters adminUserName=$adminUserName vmName=$vmName adminPassword=$adminPassword
    ```

### Verify deployment

1. Navigate to portal.azure.com
1. Select Resource groups > **\<rgn>your resource group\</rgn>** > {what you named the VM}.
1. Select connect at the top.

1. Select Download RDP File, and then follow the instructions to sign in to the virtual machine by using the password that's stored in the key vault.

Congrats, you've managed to deploy a VM containing dependencies.
