Before we get started, lets remind ourselves about the syntax for the Azure CLI tool. If you've gone through the **Control Azure services with the Azure CLI** module, then you know that Azure CLI commands take the form of:

```azurecli
az [command] [subcommand] [--parameter --parameter]
```

The `[command]` identifies the specific area of Azure you want to control. For example, you can manage subscription information with the `account` command, or SQL databases with the `sql` command. The `[subcommand]` and `[--parameters]` are then dependent upon the command you're working with. 

You can always get a list of commands, subcommands, and parameters by typing in a partial command. For example typing `az` at the command line will give you the top-level help screen, and typing `az vm` will give you all the subcommands for virtual machines. This approach can be a great way to explore the tool on your own.

> [!NOTE]
> We will be using the browser-hosted Cloud Shell to work with the Azure CLI. If you prefer to work from your local machine, all of the commands we cover can also be executed from the command line by [installing the Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest).

## Log into Azure

The first thing you'll do when working with the Azure CLI is to login to your Azure account. This is done with the `login` command. If you are using the Cloud Shell, there will be a button to sign in to Azure.

```azurecli
az login
```

This command will launch a browser window and allow you to select the Microsoft account you want to use.

## Working with subscriptions

In this module, we will be working in a temporary subscription created as a playground, but you will normally execute commands in a subscription tied to your logged in account. If you have multiple subscriptions, you can get a nicely formatted list of them using the `az account list --output table` statement.

```
Name                                  CloudName    SubscriptionId                        State    IsDefault
------------------------------------  -----------  ------------------------------------  -------  -----------
Contoso Legacy Resources              AzureCloud   abc13b0c-d2c4-64b2-9ac5-2f4cb819b752  Enabled  True
Visual Studio Enterprise              AzureCloud   233aebce-23c2-4572-c056-c029449e93ed  Enabled  False
```

Notice that the command also identifies the _default_ subscription where all your commands will apply. If you would prefer to work in a different subscription, you can use the `az account set --subscription "[name]"` command. For example, we could set our current subscription to be `Visual Studio Enterprise` from the above list through the following command:

```azurecli
az account set --subscription "Visual Studio Enterprise"
```