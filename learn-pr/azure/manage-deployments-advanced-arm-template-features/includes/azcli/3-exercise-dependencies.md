## Setup

Here, you open Visual Studio Code, create a terminal session, and connect to the Azure subscription that's provided by the free Azure sandbox environment.

You need to perform these setup tasks one time during this module. You can refer back to these steps if you sign out or become disconnected in a later exercise.

### Open a shell in Visual Studio Code

1. Open Visual Studio Code.
1. Open a terminal window by using the **Terminal** menu.

1. If the drop-down menu shows your preferred shell (**bash** or **zsh**, for example), you can skip to the next section.

1. If not, select the drop-down and choose **Select Default Shell**.

1. Select the type of shell you want.

    :::image type="content" source="../../media/vscode-select-shell.png" alt-text="Screenshot that shows selecting a shell from the drop-down menu.":::

1. Select the **+** in the terminal to create a new terminal with your selected shell type.

### Sign in to Azure

1. From the terminal, run `az login`:

    ```azurecli
    az login
    ```

    A browser window appears.

1. Select the account that you used to activate the sandbox and close the browser window when prompted.

### Set the active subscription

Run the following `az account set` command to set the Azure sandbox environment as your active subscription:

```azurecli
az account set -s "Concierge Subscription"
```

> [!NOTE]
> If the command fails, run `az account list --refresh --all`, and then rerun the `az account set` command.

### Set the default resource group

Normally, when you run an Azure CLI command, you need to specify a resource group.

The sandbox provides a default resource group for you. To make the Azure CLI commands that follow easier to run, here you set the default resource group.

Run the following `az configure` command to set the default resource group:

```azurecli
az configure --defaults group=<rgn>resource group name</rgn>
```

## What's in a typical VM deployment

When you deploy a VM, keep in mind that there are several resources that need to be deployed along with it in order for the VM to work.

Here's a brief summary of the types of resources that typically need to be deployed along with a VM:

- **Microsoft.Storage/storageAccounts**. A storage account provides disk space for the operating system and files.
- **Microsoft.Network/publicIPAddresses**. A public IP address enables you to connect to the VM from the internet.
- **Microsoft.Network/networkSecurityGroups**. A network security group contains rules for handling inbound and outbound traffic to your virtual network.
- **Microsoft.Network/virtualNetworks**. Your VM needs to be placed in a virtual network. This resource requires the network security group to be deployed before it.
- **Microsoft.Network/networkInterfaces**. This resource depends on two other resources: the public IP address and the virtual network.
- **Microsoft.Compute/virtualMachines**. The virtual machine is the primary resource you want to deploy. It's dependent on two different resources: the storage account and the network interfaces.

## Deploy a Linux VM

Here, you download an Azure Resource Manager (ARM) template from a GitHub repository that we provide for you. The template provisions a Linux VM and all of the resources necessary to run it.

1. Run the following `wget` command to download the ARM template:

    ```bash
    wget https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-vm-simple-linux/azuredeploy.json
    ```

    If you don't have `wget` installed, you can run this `curl` command:

    ```bash
    curl https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-vm-simple-linux/azuredeploy.json > azuredeploy.json
    ```

1. Run the `az deployment group create` command to deploy the template:

    ```azurecli
    az deployment group create \
      --template-file azuredeploy.json \
      --parameters adminUsername=azureuser vmName=vm1 adminPasswordOrKey='insecurepassword123!'
    ```

    The command can take a few minutes to run. While the command runs, you can [examine the ARM template](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-vm-simple-linux/azuredeploy.json?azure-portal=true) from a separate browser tab if you'd like.

    Note the resource dependencies by searching for the `dependsOn` key. For example, the virtual machine resource depends on the network interface:

    ```json
    "type": "Microsoft.Compute/virtualMachines",
    "apiVersion": "2020-06-01",
    "name": "[parameters('vmName')]",
    "location": "[parameters('location')]",
    "dependsOn": [
      "[resourceId('Microsoft.Network/networkInterfaces/', variables('networkInterfaceName'))]"
    ],
    ```

## Verify the deployment

Verify that the VM is provisioned and is connectable over SSH. To do so:

1. Run the following `az deployment group list` command to list the deployment groups in your subscription:

    ```azurecli
    az deployment group list --output table
    ```

    You see one deployment group, named *azuredeploy*:

    ```output
    Name         ResourceGroup                               State      Timestamp                         Mode
    -----------  ------------------------------------------  ---------  --------------------------------  -----------
    azuredeploy  learn-1ef901aa-3f6a-46aa-8e93-a7f11e5192b8  Succeeded  2020-11-24T17:55:39.762517+00:00  Incremental
    ```

1. Run the following `az deployment group show` command to show the SSH command you can use to connect to the VM:

    ```azurecli
    az deployment group show \
      --name azuredeploy \
      --query properties.outputs.sshCommand.value \
      --output tsv
    ```

    The ARM template defines this property in the `output` section. Here's an example:

    ```output
    ssh azureuser@simplelinuxvm-a33zb3sc332ue.westus.cloudapp.azure.com
    ```

1. Run the command again, this time using the `$()` syntax to execute the SSH command:

    ```azurecli
    $(az deployment group show \
      --name azuredeploy \
      --query properties.outputs.sshCommand.value \
      --output tsv)
    ```

    When prompted, enter `yes` to continue connecting. Then enter the administrator password, `insecurepassword123!`.

    > [!IMPORTANT]
    > In practice, keep passwords safe. You can also use public key authentication, which is typically more secure than using passwords.

1. From your SSH connection to the VM, run `hostname` to print the VM's hostname:

    ```bash
    hostname
    ```

    You see the VM's internal hostname, `vm1`:

    ```output
    vm1
    ```

1. Run `exit` to leave your SSH session.

    ```bash
    exit
    ```

Congratulations, you've successfully deployed a Linux VM by using an ARM template. A VM is a common resource type that includes dependent resources.
