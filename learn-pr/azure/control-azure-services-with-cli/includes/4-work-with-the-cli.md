The Azure CLI lets you type commands and execute them immediately from the command line. Recall that the overall goal in the software development example is to deploy new builds of a web app for testing. Let's talk about the sorts of tasks you can do with the Azure CLI.

## What Azure resources can be managed using the Azure CLI?

The Azure CLI lets you control nearly every aspect of every Azure resource. You can work with resource groups, storage, virtual machines, Azure Active Directory (Azure AD), containers, machine learning, and so on.

Commands in the CLI are structured in _groups_ and _subgroups_. Each group represents a service provided by Azure, and the subgroups divide commands for these services into logical groupings. For example, the `storage` group contains subgroups including **account**, **blob**, **storage**, and **queue**.

So, how do you find the particular commands you need? One way is to use `az find`. For example, if you want to find commands that might help you manage a storage blob, you can use the following find command:

```azurecli
az find -q blob
```

If you already know the name of the command you want, the `--help` argument for that command will get you more detailed information on the command, and for a command group, a list of the available subcommands. So, with our storage example, here's how you can get a list of the subgroups and commands for managing blob storage:

```azurecli
az storage blob --help
```

## How to create an Azure resource

When creating a new Azure resource, there are typically three steps: connect to your Azure subscription, create the resource, and verify that creation was successful. The following illustration shows a high-level overview of the process.

![An illustration showing the steps to create an Azure resource using the command-line interface.](../media/4-create-resources-overview.png)

Each step corresponds to a different Azure CLI command.

### Connect

Since you're working with a local install of the Azure CLI, you'll need to authenticate before you can execute Azure commands, by using the Azure CLI **login** command.

```azurecli
az login
```

The Azure CLI will typically launch your default browser to open the Azure sign-in page. If this doesn't work, follow the command-line instructions and enter an authorization code at [https://aka.ms/devicelogin](https://aka.ms/devicelogin).

After a successful sign in, you'll be connected to your Azure subscription.

### Create

You'll often need to create a new resource group before you create a new Azure service, so we'll use resource groups as an example to show how to create Azure resources from the CLI.

The Azure CLI **group create** command creates a resource group. You must specify a name and location. The name must be unique within your subscription. The location determines where the metadata for your resource group will be stored. You use strings like "West US", "North Europe", or "West India" to specify the location; alternatively, you can use single word equivalents, such as westus, northeurope, or westindia. The core syntax is:

```azurecli
az group create --name <name> --location <location>
```

> [!IMPORTANT]
> You do not need to create a resource group when using the free Azure sandbox. Instead, you will use a pre-created resource group.

### Verify

For many Azure resources, the Azure CLI provides a **list** subcommand to view resource details. For example, the Azure CLI **group list** command lists your Azure resource groups. This is useful here to verify whether creation of the resource group was successful:

```azurecli
az group list
```

To get a more concise view, you can format the output as a simple table:

```azurecli
az group list --output table
```
