<!-- markdownlint-disable MD041 -->

In interactive mode, Azure CLI allows you to enter and run commands immediately.

In the Customer Relationship Management (CRM) example, the goal is to create three test
environments, each containing virtual machines (VMs). Use resource groups to ensure the VMs are
organized into separate environments:

- Unit testing
- Integration testing
- Acceptance testing

Since you only need to create the resource groups once, using Azure CLI interactively for this task
is a reasonable choice.

## Example: How to create a resource group with Azure CLI

Let's perform a common task: creating a resource group. Resource groups help you manage related
resources collectively, and creating a new resource group is often one of the first tasks you
perform when starting a new Azure solution.

Here are the three steps you need to follow:

1. Connect to Azure using `az login`.

1. Work with Azure subscriptions using `az account`.

1. Work with resource groups using `az group`.

### Connect to Azure

When using a local installation of Azure CLI, you must authenticate before executing any
Azure CLI commands. The `az login` command prompts you for your Azure credentials and
then connects to your Azure subscription.

To connect interactively, you don't need to specify parameters:

```azurecli
az login
```

This command opens a prompt for your Azure credentials and establishes a connection to your Azure
subscription.

Here are some handy tips when authenticating to Azure with Azure CLI:

- If running the Azure CLI in Azure Cloud Shell ...
  - You're authenticated automatically.
  - You might need to change your default subscription.

- When running the Azure CLI through a local installation ...
  - You're prompted for your Azure credentials.
  - There's a subscription selector at time of login.

### Work with subscriptions

If you're new to Azure, you only have a single subscription. However, if you've been using Azure for
a while, you might have multiple subscriptions. Azure CLI allows you to configure which
subscription your commands are executed against.

You can only be active in one subscription at a time. Use the `az account show` reference command to determine
which subscription is currently active. If it's not the correct one, you can switch subscriptions
using the `az account set` reference command.

1. Get a list of all your subscriptions returning the results in a table:

   ```azurecli
   az account list --output table
   ```

1. Get just the current active subscription:

   ```azurecli
   az account show
   ```

1. Change your active subscription:

   ```azurecli
   az account set --subscription "00000000-0000-0000-0000-000000000000"
   ```

### Work with resource groups

When creating resources in Azure, you place them into a resource group for management purposes.

To create a resource group, use the `az group create` reference command. You must specify a name and a
location, and the name must be unique within your subscription. The location determines where the
metadata for your resource group is stored, which can be important for compliance reasons. Use the
`az account list-locations` command to determine available locations.

> [!NOTE]
> If you're working in an Azure sandbox, it creates the resource group for you. If you prefer to
> work in your own subscription, use the following commands.

The syntax for creating a resource group is:

```azurecli
az group create --name MyResourceGroup --location eastus
```

To retrieve a list of all resource groups in the active subscription, use the `az group list` command.

```azurecli
az group list
```

For a more concise view, you can return the list in a table:

```azurecli
az group list --output table
```

When you're developing and testing an Azure CLI script, it's best to create a resource group that contains a random ID in the name. Adding a random ID to your resource group name allows you to retest your code without having to wait for a prior resource group of the same name to be removed from Azure.

```azurecli
#!/bin/bash
let "randomIdentifier=$RANDOM*$RANDOM"
location="eastus"
resourceGroup="msdocs-rg-$randomIdentifier"
az group create --name $resourceGroup --location $location --output json
```

## Example: Create an Azure Virtual Machine

Creating virtual machines (VMs) is a common task you can perform with Azure CLI.

The `az vm create` command is used to create a VM. This command has several parameters to handle the extensive configuration settings for a VM. Most parameters have reasonable default values, so you typically need to specify only five key items:

- **resource-group**: The resource group where the new VM is placed.
- **name**: The name of the VM in Azure.
- **location**: The geographic region where the VM is provisioned.
- **image**: The operating system image to use for the VM, typically a Linux distribution, or Windows Server.
- **admin-username**: Administrator username for the VM. You're prompted to enter a password at the command line.

# [Bash](#tab/Bash)

Here's a Bash script example:

```azurecli
#!/bin/bash

# Create variables
rgName="myResourceGroupName"
vmName="myVMname"
vmImage="Win2022AzureEditionCore"
vmAdminUserName="myAzureUserName"

# Create the VM
az vm create \
    --resource-group $rgName \
    --name $vmName \
    --image $vmImage \
    --public-ip-sku Standard \
    --admin-username $vmAdminUserName
```

# [PowerShell](#tab/powershell)

Here's the equivalent example to create a VM in a PowerShell environment:

```azurecli
# Create variables
$rgName = "myResourceGroupName"
$vmName = "myVMname"
$vmImage = "Win2022AzureEditionCore"
$vmAdminUserName = "myAzureUserName"

# Create the VM
az vm create `
    --resource-group $rgName `
    --name $vmName `
    --image $vmImage `
    --public-ip-sku Standard `
    --admin-username $vmAdminUserName
```

---

## Example: Get information for a VM

You can list the VMs in your subscription using the `az vm list` command. This command also supports retrieving a specific VM by specifying the `--name` parameter.

Here's how to store the ID of a VM in a variable:

```azurecli
#!/bin/bash
rgName="myResourceGroupName"
vmID=$(az vm list --resource-group $rgName \
    --query "[?name=='myVMname'].id" --output tsv)
echo $vmID
```

Using the `az vm update` command, change the size of your VM:

```azurecli
#!/bin/bash
rgName="myResourceGroupName"
vmName="msdocs-vm-01"
newVMsize="Standard_DS3_v2"

# Get the VM ID
vmID=$(az vm list --resource-group $rgName \
    --query "[?name=='$vmName'].id" --output tsv)

# Update the VM size
az vm update --ids $vmID --size $newVMsize

# Show the new properties of the VM
az vm show --resource-group $rgName --name $vmName
```

This exercise demonstrated a typical pattern for an interactive Azure CLI session. You first used a standard command to create a new resource group. You then used a set of commands to deploy a resource (in this example, a VM) into this resource group. You could easily combine this set of commands into a shell script and execute it every time you need to create the same resource.
