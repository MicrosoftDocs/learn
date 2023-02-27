# Azure CLI

The Azure Command-Line Interface (CLI) is a cross-platform command-line tool to connect to Azure and
execute administrative commands on Azure resources. It allows the execution of commands through a
terminal using interactive command-line prompts or a script.

For interactive use, you first launch a shell such as PowerShell on Windows, Linux, or macOS,
`cmd.exe` on Windows, or Bash on Linux or macOS, and then issue a command at the shell prompt. To
automate repetitive tasks, you assemble the CLI commands into a shell script using the script syntax
of your chosen shell, and then you execute the script.

You can install the Azure CLI locally on Windows, Linux, and macOS. It can also be used from a
browser through Azure Cloud Shell or run from inside a Docker container.

The Azure CLI is a **tool** that runs within a Bash, PowerShell or `cmd.exe` **shell**. Microsoft
documentation has standardized on Azure CLI scripts for Bash shells, and we'll do the same here.
Keep in mind that if you chose to use a PowerShell or `cmd.exe` shell, there are slight scripting
differences, like line breaks or quoting, when copying Bash scripts for use in other shells.

## Prerequisites

Since your company already uses Azure, you have an active Azure subscription. You're using Bash in
Azure Cloud Shell.

## Create a resource group

Before creating a storage account, you need to create a resource group for your Azure storage
account or use an existing resource group. A resource group is a logical container in which Azure
resources are deployed and managed as a group.

Create an Azure resource group named **storageaccountexamplerg** in the **eastus** region using the
`az group create` command.

```azurecli
az group create -name storageaccountexamplerg -location eastus
```

## Create a storage account

A storage account is an Azure resource and is part of a resource group. Storage account names must
be between 3 and 24 characters in length and may contain numbers and lowercase letters only. Your
storage account name must be unique within Azure. No two storage accounts can have the same name.

To create a storage account in Azure, you need to know the location, sku and the kind of storage you
want to create. Here is a simple script for creating a storage account.

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
created in the previous step.

```azurecli
# Get a list of all storage accounts in the active subscription
az storage account list

# Get a list of all storage accounts for a resource group
az storage account list --resource-group storageaccountexamplerg
```

## Clean up resources

The `az group delete` command is used to delete a resource group. **Name** is the only
mandatory parameter. Deleting a resource group deletes the resource group and all resources
contained within it. If resources outside the scope of the storage account created in this unit
exist in the **storageaccountexamplerg** resource group, they will also be deleted.

```azurecli
az group delete --name storageaccountexamplerg
```

When working in a resource group shared with other team members, delete the test storage account by
using the `az storage account delete` command.

```azurecli
az storage account delete --name <storage-account-name>
```
