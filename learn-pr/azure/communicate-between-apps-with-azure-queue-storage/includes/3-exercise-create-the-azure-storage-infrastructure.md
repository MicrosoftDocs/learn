You discovered that spikes in traffic can overwhelm your middle-tier. To deal with this issue, you decided to add a queue between the front end and the middle tier in your article-upload application.

The first step in creating a queue is to create the Azure Storage account to store your data.

## Create a storage account with the Azure CLI

> [!TIP] 
> Normally, you'd start a new project by creating a *resource group* to hold all the associated resources. In this case, we're using the Azure sandbox which provides a resource group named <rgn>[sandbox resource group name]</rgn>.

Use the `az storage account create` command to create the storage account. You can enter the command into the Cloud Shell window on the right.

The command needs several parameters:

| Parameter | Value |
|-----------|-------|
| `--name`  | Sets the name. Remember that storage accounts use the name to generate a public URL - so it has to be unique. In addition, the account name must be between 3 and 24 characters, and be composed of numbers and lowercase letters only. We recommend you use the prefix **articles** with a random number suffix but you can use whatever you like. |
| `-g`        | Supplies the **Resource Group**. Use *<rgn>[sandbox resource group name]</rgn>* as the value. |
| `--kind`    | Sets the **Storage Account type**: *StorageV2* to create a general-purpose V2 account. |
| `--sku`     | Sets the **Replication and Storage type**. It defaults to *Standard_RAGRS*. Let's use *Standard_LRS*, which means it's only locally redundant within the datacenter. |
| `-l`        | Sets the **Location** independent of the resource group owner. It's optional, but you can use it to place the queue in a different region than the resource group. Place it close to you, choosing from the following list of available regions in the sandbox. |

<!-- Resource selection -->
[!include[](../../../includes/azure-sandbox-regions-first-mention-note.md)]

Here's an example command line that uses these parameters. Make sure to change the `--name` parameter.

```azurecli
az storage account create -g <rgn>[sandbox resource group name]</rgn> --kind StorageV2 --sku Standard_LRS --name [unique-name]
```

<!-- Paste tip-->
[!include[](../../../includes/azure-cloudshell-copy-paste-tip.md)]
