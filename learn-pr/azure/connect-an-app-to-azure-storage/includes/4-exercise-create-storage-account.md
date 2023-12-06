Now that we have an app, we need an Azure storage account to work with.

## Use the Azure CLI to create an Azure storage account

We'll use the `az storage account create` command to create a new storage account. There are several parameters to control the storage account's configuration.

 | Option | Description |
 |--------|-------------|
 | `--name` | A **storage account name**. The name is used to generate the public URL used to access the data in the account. It must be unique across all existing storage account names in Azure. It must be 3 to 24 characters long, and can contain only lowercase letters and numbers. |
 | `--resource-group` | Use **<rgn>[sandbox resource group name]</rgn>** to place the storage account into the free sandbox. |
 | `--location` | Select a location near you (see *Select a location*, following). |
 | `--sku` | The storage account performance and replication model. Options include `Premium_LRS`, `Standard_GRS`, `Standard_LRS`, `Standard_RAGRS`, and `Standard_ZRS`. |

Use this table to craft a command line in Cloud Shell on the right to create the account.

- Use a unique name. We recommend something like "photostore" with your initials and a random number. You'll get an error if it's not unique.

- Normally, you'd create a new resource group to hold your app resources, but in this case, use the provided sandbox resource group "**<rgn>[sandbox resource group name]</rgn>**".

- Use "Standard_LRS" for the **sku**. This will use standard storage with local replication, which is fine for this example.

### Select a location

<!-- Resource selection -->
[!include[](../../../includes/azure-sandbox-regions-first-mention-note.md)]

> [!TIP]
> You can select a location with the `--location` parameter. If you don't supply one, the storage account will be created in the same location as your resource group. Because this is a more basic exercise, you can omit the parameter from the following command, if you prefer.

### Create a storage account

1. Use the following example command to create a storage account. Remember to replace `<name>` with your unique storage account name.

    ```azurecli
    az storage account create \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --location westus \
      --sku Standard_LRS \
      --name <name>
    ```

    > [!TIP]
    > If you're interested in exploring the storage account options, review the [Create an Azure storage account](/training/modules/create-azure-storage-account?azure-portal=true) module, where we go through all the options in depth.

It takes a few minutes to deploy the account. While Azure is working on that, let's look at how we interact with the Azure Storage APIs.
