The Azure CLI is a cross-platform command-line tool for connecting to Azure and
running administrative commands on Azure resources. You can use it to run commands through a terminal by using interactive command-line prompts or a script.

For interactive use, you first open a shell such as:

- PowerShell on Windows, Linux, or macOS.
- `Cmd.exe` on Windows.
- Bash on Linux or macOS.

You then issue a command at the shell prompt. To
automate repetitive tasks, you assemble the Azure CLI commands into a shell script by using the syntax
of your chosen shell, and then you run the script.

You can install the Azure CLI locally on Windows, Linux, and macOS. You can also use it from a
browser through Azure Cloud Shell or run it from inside a Docker container.

Microsoft
documentation has standardized on Azure CLI scripts for Bash shells, and we'll do the same here.
Keep in mind that if you choose to use a PowerShell or `cmd.exe` shell, there are slight scripting
differences (like line breaks or quoting) when you copy Bash scripts for use in other shells.

## Prerequisites

Because your company already uses Azure, you have an active Azure subscription. You're using Bash in
Azure Cloud Shell.

## Create a resource group

Before you create a storage account, you need to create a resource group or use an existing one. A resource group is a logical container in which Azure
resources are deployed and managed as a group.

Create an Azure resource group named `storageaccountexamplerg` in the `eastus` region by using the
`az group create` command:

```azurecli
az group create -name storageaccountexamplerg -location eastus
```

## Create a storage account

A storage account is an Azure resource and is part of a resource group. Storage account names must
be 3 to 24 characters in length and can contain numbers and lowercase letters only. Your
storage account name must be unique within Azure. No two storage accounts can have the same name.

To create a storage account in Azure, you need to know the location, the SKU, and the kind of storage that you
want to create. Here's a simple script for creating a storage account:

```azurecli
# check if the storage account name is available
az storage account check-name --name <storage-account-name>

# create the storage account
az storage account create \
  --name <storage-account-name> \
  --resource-group storageaccountexamplerg \
  --location eastus \
  --sku Standard_RAGRS \
  --kind StorageV2
```

## Verify the storage account

For many Azure resources, the Azure CLI provides a `list` subcommand to view resource details. Use
the Azure CLI `az storage account list` command to return information about the storage account
that you created in the previous step:

```azurecli
# Get a list of all storage accounts in the active subscription
az storage account list

# Get a list of all storage accounts for a resource group
az storage account list --resource-group storageaccountexamplerg
```

## Clean up resources

You use the `az group delete` command to delete a resource group. The only mandatory parameter is **name**. Deleting a resource group deletes the group and all resources
that it contains. If resources outside the scope of the storage account that you created in this unit
exist in the `storageaccountexamplerg` resource group, they're also deleted.

```azurecli
az group delete --name storageaccountexamplerg
```

When you're working in a resource group that's shared with other team members, delete the test storage account by
using the `az storage account delete` command:

```azurecli
az storage account delete --name <storage-account-name>
```
