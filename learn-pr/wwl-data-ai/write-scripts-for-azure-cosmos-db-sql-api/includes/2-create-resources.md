When managing Azure Cosmos DB SQL API accounts using the Azure CLI, most commands will be broken down into two core CLI command groups:

1. **az cosmosdb**: This group contains the commands required to create and manage a new Azure Cosmos DB account.
1. **az cosmosdb sql**: This subgroup of the **az cosmosdb** group contains the commands to manage SQL API-specific resources such as databases and containers.

## Azure Cosmos DB account group commands

To create a new account, you will need to use the **az cosmosdb create** command. This command only requires, at a minimum, the name of the new account to create and the target resource group for the account resource. When creating the new account, you must ensure that the name you use is globally unique to avoid the command failing due to a name conflict with another service instance.

> &#128161; By default, this command will create a new account using the SQL API.

:::code language="azurecli" source="../media/2-script.sh" range="1-3" highlight="1":::

When creating a new account, you can also optionally specify extra parameters to control the characteristics of the newly created account. For example, this command enables the free tier and sets the default consistency level to **Strong**.

:::code language="azurecli" source="../media/2-script.sh" range="5-9" highlight="4-5":::

In most cases, you will want to specify the region where you wish to deploy your Azure Cosmos DB account. You can use the **--locations** argument to specify one or more target locations for your account.

:::code language="azurecli" source="../media/2-script.sh" range="11-14" highlight="4":::

Later, you will learn how to specify multiple target locations while setting the appropriate failover priorities for each location.

> &#128221; When in doubt, you can always look up the help documentation for commands by using the **--help** argument in these examples: ``az cosmosdb --help`` &amp; ``az cosmosdb create --help``.

## Azure Cosmos DB SQL API subgroup commands

The **az cosmosdb sql** command group contains multiple commands and subgroups to manage individual resources within the SQL API. For example, you can use the **az cosmosdb sql database create** command to create a new database within an existing account. In this example, the **--name** argument refers to the name of the new database, and the **--account-name** argument refers to the name of the account created previously.

:::code language="azurecli" source="../media/2-script.sh" range="16-19" highlight="1":::

The **az cosmosdb sql container create** command creates a new container within an existing database. The **--name** argument in this context refers to the name of the new container, while the **--database-name** argument refers to the name of the previously created database.

This creation command also requires, at a minimum, a value for the **--partition-key-path** argument as this argument is required for all containers in Azure Cosmos DB SQL API.

:::code language="azurecli" source="../media/2-script.sh" range="21-27" highlight="1,6":::

> &#128221; When in doubt, you can always look up the help documentation for commands by using the **--help** argument in these examples: ``az cosmosdb sql --help``, ``az cosmosdb sql database --help``, &amp; ``az cosmosdb sql container --help``.
