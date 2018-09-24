Let's start with the most obvious task: creating an Azure Virtual Machine.

<!-- Activate the sandbox -->
[!include[](../../../includes/azure-sandbox-activate.md)]

## Logins, subscriptions, and resource groups

You'll be working in the Azure Cloud Shell on the right. Once you activate the sandbox, you'll be logged into Azure with a free subscription managed by Microsoft Learn. You don't have to log into Azure on your own, or select a subscription - this will be done for you. In addition, normally you would create a _resource group_ to hold new resources. In this module, the Azure sandbox will create a resource group for you which will be used to execute all the commands.

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
> For a complete list of commands, you can check the [Azure CLI reference documentation](https://docs.microsoft.com/cli/azure/reference-index?view=azure-cli-latest).

Let's start with the first one: `az vm create`. This command is used to create a virtual machine in a resource group. There are several parameters you can pass to configure all the aspects of the new VM. The three parameters that must be supplied are:

> [!div class="mx-tableFixed"]
> | Parameter | Description |
> |-----------|-------------|
> | `resource-group` | The resource group that will own the virtual machine, use **<rgn>[sandbox Resource Group]</rgn>**. |
> | `name` | The name of the virtual machine - must be unique within the resource group. |
> | `image` | The operating system image to use to create the VM. |
> | `location` | The region to place the VM in. Typically this would be close to the consumer of the VM. In this exercise, choose a location nearby from the following list. |

<!-- Resource selection -->
[!include[](../../../includes/azure-sandbox-regions-first-mention-note.md)]

In addition, it's helpful to add the `--verbose` flag to see progress while the VM is being created. 

## Create a Linux virtual machine

Let's create a new Linux virtual machine. Execute the following command in Azure Cloud Shell to create a Debian Linux machine in the "West US" location. Change the location if that one isn't nearby.

```azurecli
az vm create --resource-group <rgn>[sandbox resource group name]</rgn> --name SampleVM --image Debian --admin-username aldis --generate-ssh-keys --location westus --verbose 
```

[!include[](../../../includes/azure-cloudshell-copy-paste-tip.md)]


This command will create a new **Debian** Linux virtual machine with the name `SampleVM`. Notice that the Azure CLI tool waits while the VM is being created. You can add the `--no-wait` option to tell the Azure CLI tool to return immediately and have Azure continue creating the VM in the background. This is useful if you're executing the command in a script. Later in the script, use the `azure vm wait --name [vm-name]` command to wait for the VM to finish being created.

If you look at the verbose responses, you will also see that the `SampleVM` name is used to name various dependencies for the VM.

```output
Succeeded: SampleVMNSG (Microsoft.Network/networkSecurityGroups)
Accepted: SampleVMVNET (Microsoft.Network/virtualNetworks)
Succeeded: SampleVMPublicIP (Microsoft.Network/publicIPAddresses)
Accepted: SampleVMVNET (Microsoft.Network/virtualNetworks)
Succeeded: SampleVMVNET (Microsoft.Network/virtualNetworks)
Accepted: vm_deploy_vzKnQDyyq48yPUO4VrSDfFIi81vHKZ9g (Microsoft.Resources/deployments)
```

You can override these auto-generated resource names using optional parameters to `vm create`, such as `--vnet-name` and `--public-ip-address-dns-name`.

We are specifying the administrator account name through the `admin-username` flag to be **"aldis"**. If you omit this, the `vm create` command will use your _current user name_. Since the rules for account names are different for each OS, it's safer to specify a specific name. 

> [!NOTE]
> Common names such as "root" and "admin" are not allowed for most images.

We are also using the `generate-ssh-keys` flag. This parameter is used for Linux distributions and creates a pair of security keys so we can use the `ssh` tool to access the virtual machine remotely. The two files are placed into the `.ssh` folder on your machine and in the VM. If you already have an SSH key named `id_rsa` in the target folder, then it will be used rather than having a new key generated.

Once it finishes creating the VM, you will get a JSON response which includes the current state of the virtual machine and its public and private IP addresses assigned by Azure:

```json
{
  "fqdns": "",
  "id": "/subscriptions/20f4b944-fc7a-4d38-b02c-900c8223c3a0/resourceGroups/2568d0d0-efe3-4d04-a08f-df7f009f822a/providers/Microsoft.Compute/virtualMachines/SampleVM",
  "location": "westus",
  "macAddress": "00-0D-3A-58-F8-45",
  "powerState": "VM running",
  "privateIpAddress": "10.0.0.4",
  "publicIpAddress": "40.83.165.85",
  "resourceGroup": "2568d0d0-efe3-4d04-a08f-df7f009f822a",
  "zones": ""
}
```
