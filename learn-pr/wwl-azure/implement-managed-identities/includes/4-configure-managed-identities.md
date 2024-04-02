You can configure an Azure virtual machine with a managed identity during, or after, the creation of the virtual machine. CLI examples showing the commands for both system- and user-assigned identities are used in this unit.

## System-assigned managed identity

To create, or enable, an Azure virtual machine with the system-assigned managed identity your account needs the **Virtual Machine Contributor** role assignment. No other Microsoft Entra directory role assignments are required.

### Enable system-assigned managed identity during creation of an Azure virtual machine

The following example creates a virtual machine named *myVM* with a system-assigned managed identity, as requested by the `--assign-identity` parameter, with the specified `--role` and `--scope`. The `--admin-username` and `--admin-password` parameters specify the administrative user name and password account for virtual machine sign-in. Update these values as appropriate for your environment:

```bash
az vm create --resource-group myResourceGroup \ 
    --name myVM --image win2016datacenter \ 
    --generate-ssh-keys \ 
    --assign-identity \ 
    --role contributor \
    --scope mySubscription \
    --admin-username azureuser \ 
    --admin-password myPassword12
```

### Enable system-assigned managed identity on an existing Azure virtual machine

Use the `az vm identity assign` command to assign the system-assigned identity to an existing virtual machine:

```bash
az vm identity assign -g myResourceGroup -n myVm
```

## User-assigned managed identity

To assign a user-assigned identity to a virtual machine during its creation, your account needs the **Virtual Machine Contributor** and **Managed Identity Operator** role assignments. No other Microsoft Entra directory role assignments are required.

Enabling user-assigned managed identities is a two-step process:

1. Create the user-assigned identity
2. Assign the identity to a virtual machine 

### Create a user-assigned identity

Create a user-assigned managed identity using `az identity create`.  The `-g` parameter specifies the resource group where the user-assigned managed identity is created, and the `-n` parameter specifies its name.

```bash
az identity create -g myResourceGroup -n myUserAssignedIdentity
```

### Assign a user-assigned managed identity during the creation of an Azure virtual machine

The following example creates a virtual machine associated with the new user-assigned identity, as specified by the `--assign-identity` parameter, with the given `--role` and `--scope`. 

```bash
az vm create \
--resource-group <RESOURCE GROUP> \
--name <VM NAME> \
--image Ubuntu2204 \
--admin-username <USER NAME> \
--admin-password <PASSWORD> \
--assign-identity <USER ASSIGNED IDENTITY NAME> \
--role <ROLE> \
--scope <SUBSCRIPTION>
```

### Assign a user-assigned managed identity to an existing Azure virtual machine

Assign the user-assigned identity to your virtual machine using `az vm identity assign`. 

```bash
az vm identity assign \
    -g <RESOURCE GROUP> \
    -n <VM NAME> \
    --identities <USER ASSIGNED IDENTITY>
```

## Azure SDKs with managed identities for Azure resources support

Azure supports multiple programming platforms through a series of [Azure SDKs](https://azure.microsoft.com/downloads). Several of them have been updated to support managed identities for Azure resources, and provide corresponding samples to demonstrate usage. 

| SDK | Sample |
|--|--|
| .NET | [Manage resource from a virtual machine enabled with managed identities for Azure resources enabled](https://github.com/Azure-Samples/aad-dotnet-manage-resources-from-vm-with-msi) |
| Java | [Manage storage from a virtual machine enabled with managed identities for Azure resources](https://github.com/Azure-Samples/compute-java-manage-resources-from-vm-with-msi-in-aad-group) |
| Node.js | [Create a virtual machine with system-assigned managed identity enabled](https://azure.microsoft.com/resources/samples/compute-node-msi-vm/) |
| Python | [Create a virtual machine with system-assigned managed identity enabled](https://azure.microsoft.com/resources/samples/compute-python-msi-vm/) |
| Ruby | [Create Azure virtual machine with an system-assigned identity enabled](https://github.com/Azure-Samples/compute-ruby-msi-vm/) |

