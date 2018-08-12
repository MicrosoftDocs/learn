To work with virtual machines, we will use the `vm` command - this has several sub-commands available, the most common include:

| Sub-Command | Description |
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
> For a complete list of commands, you can check the [Azure CLI reference documentation](https://docs.microsoft.com/en-us/cli/azure/reference-index?view=azure-cli-latest)

Let's start with the first one: `az vm create`. This is used to create a new virtual machine and it has a bunch of parameters you can pass to configure all the aspects of the VM. The two parameters that must be supplied are:

| Parameter | Description |
|-----------|-------------|
| `name` | The name of the virtual machine - must be unique within the resource group |
| `image` | The operating system image to use to create the VM |

In addition, it is helpful to add the `--verbose` flag to see the creation progress as it happens, this is helpful for the creation of VMs since it typically takes several minutes to finish.

## Create a Linux virtual machine

Let's start by creating a new Linux virtual machine. Execute the following command in the Cloud Shell.

```azurecli
az vm create --resource-group ExerciseResources --name SampleVM --image Debian --admin-username aldis --generate-ssh-keys --verbose 
```

This will create a new **Debian** Linux virtual machine with the name `SampleVM`. The supplied name will also be used to create various dependencies which are needed for the VM to run such as the virtual network, public IP name, and other elements which you will see in the verbose responses.

```
Succeeded: SampleVMNSG (Microsoft.Network/networkSecurityGroups)
Accepted: SampleVMVNET (Microsoft.Network/virtualNetworks)
Succeeded: SampleVMPublicIP (Microsoft.Network/publicIPAddresses)
Accepted: SampleVMVNET (Microsoft.Network/virtualNetworks)
Succeeded: SampleVMVNET (Microsoft.Network/virtualNetworks)
Accepted: vm_deploy_vzKnQDyyq48yPUO4VrSDfFIi81vHKZ9g (Microsoft.Resources/deployments)
```

You can override these auto-generated resource names through various parameters such as `--vnet-name` and `--public-ip-address-dns-name`.

Notice that we are specifying the admin account name through the `admin-username` flag to be "aldis". If you omit this, the `vm create` command will use your _current login name_. Since the rules for account names are different for each OS, it's safer to specify a specific name. Be aware that common names such as "root" and "admin" are not allowed for most images.

We are also using the `generate-ssh-keys` flag. This is specifically for Linux distributions and tells Azure to create an SSH public/private keypair so we can use the `ssh` tool to easily access the virtual machine remotely. These two files are placed into the `.ssh` folder on your machine and in the VM. If you already have an SSH key named `id_rsa` in the target folder, then it will be used rather than having a new key generated.

Once it finishes creating the VM, you will get a JSON response which includes the current state of the virtual machine and it's public and private IP addresses assigned by Azure:

```json
{
  "fqdns": "",
  "id": "/subscriptions/abc13b0c-d2c4-64b2-9ac5-2f4cb819b752/resourceGroups/ExerciseResources/providers/Microsoft.Compute/virtualMachines/SampleVM",
  "location": "eastus",
  "macAddress": "00-0D-3A-1A-D9-74",
  "powerState": "VM running",
  "privateIpAddress": "10.0.0.4",
  "publicIpAddress": "168.61.54.62",
  "resourceGroup": "ExerciseResources",
  "zones": ""
}
```

