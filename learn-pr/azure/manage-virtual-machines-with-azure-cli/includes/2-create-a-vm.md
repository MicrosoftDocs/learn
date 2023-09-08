Let's start with the most obvious task: creating an Azure Virtual Machine.

## Logins, subscriptions, and resource groups

You'll be working in the Azure Cloud Shell on the right. Once you activate the sandbox, you'll be logged into Azure with a free subscription that Microsoft Learn manages. You don't have to log in to Azure on your own or select a subscription; this is done for you. You'd also normally create a *resource group* to hold new resources. In this module, the Azure sandbox creates a resource group for you, which you'll use to execute all the commands.

## Create a Linux VM with the Azure CLI

The Azure CLI includes the `vm` command to work with virtual machines in Azure. We can supply several subcommands to do specific tasks. The most common include:

| Sub-command | Description |
|-------------|-------------|
| `create`    | Create a new virtual machine |
| `deallocate` | Deallocate a virtual machine |
| `delete` | Delete a virtual machine |
| `list` | List the created virtual machines in your subscription |
| `open-port` | Open a specific network port for inbound traffic |
| `restart` | Restart a virtual machine |
| `show` | Get the details for a virtual machine |
| `start` | Start a stopped virtual machine |
| `stop` | Stop a running virtual machine |
| `update` | Update a property of a virtual machine |

> [!NOTE]
> For a complete list of commands, you can check the [Azure CLI reference documentation](/cli/azure/reference-index).

Let's start with the first one: `az vm create`. You can use this command to create a virtual machine in a resource group. There are several parameters you can pass to configure all the aspects of the new VM. The four parameters that must be supplied are:

> [!div class="mx-tableFixed"]
> | Parameter | Description |
> |-----------|-------------|
> | `--resource-group` | The resource group that will own the virtual machine; use **<rgn>[sandbox Resource Group]</rgn>**. |
> | `--name` | The name of the virtual machine; must be unique within the resource group. |
> | `--image` | The operating system image to use to create the VM. |
> | `--location` | The region in which to place the VM. Typically, this would be close to the VM's consumer. |

In addition, it's helpful to add the `--verbose` flag to see progress while the VM is being created.

## Create a Linux virtual machine

Let's create a new Linux virtual machine. Execute the following command in Azure Cloud Shell to create an Ubuntu VM in the "West US" location.

```azurecli
az vm create \
  --resource-group <rgn>[sandbox resource group name]</rgn> \
  --location westus \
  --name SampleVM \
  --image UbuntuLTS \
  --admin-username azureuser \
  --generate-ssh-keys \
  --verbose 
```

[!include[](../../../includes/azure-cloudshell-copy-paste-tip.md)]

This command creates a new **Ubuntu** Linux virtual machine with the name `SampleVM`. Notice that the Azure CLI tool waits while the VM is being created. You can add the `--no-wait` option to tell the Azure CLI tool to return immediately and have Azure continue creating the VM in the background. This is useful if you're executing the command in a script.

We're specifying the administrator account name through the `--admin-username` flag to be `azureuser`. If you omit this, the `az vm create` command will use your *current user name*. Because the rules for account names are different for each OS, it's safer to specify a specific name.

> [!NOTE]
> Common names such as "root" and "admin" aren't allowed for most images.

We're also using the `generate-ssh-keys` flag. Linux distributions use this parameter, and it creates a pair of security keys so we can use the `ssh` tool to access the virtual machine remotely. The two files are placed into the `.ssh` folder on your machine and in the VM. If you already have an SSH key named `id_rsa` in the target folder, then that SSH key will be used rather than generating a new key.

Once Azure CLI finishes creating the VM, you'll get a JSON response which includes the current state of the virtual machine and its public and private IP addresses assigned by Azure:

```json
{
  "fqdns": "",
  "id": "/subscriptions/20f4b944-fc7a-4d38-b02c-900c8223c3a0/resourceGroups/Learn-2568d0d0-efe3-4d04-a08f-df7f009f822a/providers/Microsoft.Compute/virtualMachines/SampleVM",
  "location": "westus",
  "macAddress": "00-0D-3A-58-F8-45",
  "powerState": "VM running",
  "privateIpAddress": "10.0.0.4",
  "publicIpAddress": "40.83.165.85",
  "resourceGroup": "2568d0d0-efe3-4d04-a08f-df7f009f822a",
  "zones": ""
}
```
