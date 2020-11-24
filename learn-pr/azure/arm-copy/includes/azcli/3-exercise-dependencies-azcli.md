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

You can sign into your Azure account from either the terminal (running `az login`), or from Visual Studio Code, using the built-in terminal. Below instruction shows how to sign in using the Visual Studio Code.

1. In Visual Studio Code, open up the command palette, select **Terminal: Create New Integrated Terminal**.

1. From the terminal, run `az login`:

    ```azurecli
    az login
    ```

    A browser window appears.

1. Select an appropriate user in the browser and close browser window when prompted.

   Once you are logged in, you see a list, in JSON format. The list contains subscriptions associated with this account in the terminal, if you activated the sandbox.

## Set the active subscription

Run `az account set` to set a specific subscription as active:

```azurecli
az account set -s "Concierge Subscription"
```

This will set the active subscription to that of the *Concierge Subscription*.

> [!NOTE]
> If the command fails, run `az account list --refresh --all` and then rerun the command

## Set the default resource group

You now need to set the resource group created for you in the sandbox as the default resource group.

Run `az configure` to set the default name.

```azurecli
az configure --defaults group=<rgn>resource group name</rgn>
```

> [!NOTE]
> Normally, when you use an Azure CLI command, you need to specify a resource group. You are bypassing this requirement by setting the context of your deployment, using **az configure**.

## Deploy a VM with dependencies

When you deploy a virtual machine, you should be aware that is has quite a few resources that needs to be deployed with it for it to work, it's not just a virtual machine resource.

The following resource types needs to be deployed as you deploy a VM:

- **Microsoft.Storage/storageAccounts**. You will need a storage account.

- **Microsoft.Network/publicIPAddresses**. Your VM will need a public IP.

- **Microsoft.Network/networkSecurityGroups**. A network security group contains rules for handling inbound and outbound traffic to your virtual network.

- **Microsoft.Network/virtualNetworks**. Your VM needs to be placed in a virtual network. This resource has a dependency. It expects the network security group to be deployed before it.

- **Microsoft.Network/networkInterfaces**. This resource depends on two other resources public IP addresses and virtual networks.

- **Microsoft.Compute/virtualMachines**. This is the primary resource you are looking to deploy. It in turn is dependent on two different resources namely a storage account and network interfaces.

Fortunately there's a template you can grab off the Internet that contains all the above resources needed to deploy a VM.

1. Run `wget` to grab the Azure template file:

    ```bash
    wget https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-vm-simple-linux/azuredeploy.json
    ```

    and save it to a local file `azuredeploy.json`

1. Run the command `az deployment group create`:

    ```azurecli
    az deployment group create \
      --template-file './azuredeploy.json' \
      --parameters adminUsername='azureuser' vmName='vm1' adminPasswordOrKey='abc123!'
    ```

### Verify the deployment

```azurecli
az deployment group list --output table
```

```output
Name         ResourceGroup                               State      Timestamp                         Mode
-----------  ------------------------------------------  ---------  --------------------------------  -----------
azuredeploy  learn-1ef901aa-3f6a-46aa-8e93-a7f11e5192b8  Succeeded  2020-11-24T17:55:39.762517+00:00  Incremental
```

```azurecli
az deployment group show \
  --name azuredeploy \
  --query properties.outputs.sshCommand.value \
  --output tsv
```

```output
ssh azureuser@simplelinuxvm-a33zb3sc332ue.westus.cloudapp.azure.com
```

```azurecli
$(az deployment group show \
  --name azuredeploy \
  --query properties.outputs.sshCommand.value \
  --output tsv)
```

1. Go to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).
1. Select **Resource groups** > **<rgn>your resource group</rgn>** > **{what you named the VM}**.
1. Select **Connect** at the top.

1. Select **Download RDP File**, and then follow the instructions to sign in to the virtual machine by using the password that you've entered when deploying.

Congratulations, you've managed to deploy a VM containing dependencies.
