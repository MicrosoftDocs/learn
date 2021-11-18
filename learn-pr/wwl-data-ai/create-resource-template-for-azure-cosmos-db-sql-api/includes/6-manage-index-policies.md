It is common to define an indexing policy as part of deploying an Azure Cosmos DB account and its resources in an automated manner. Both the JSON and Bicep syntax for Azure Resource Manager templates supports defining indexing policies natively. However, the syntax can be tricky if you haven't tried it before.

For the examples in this unit, let's assume that we want to deploy the following indexing policy to our **pro

## Defining an indexing policy in JSON templates

Let's assume that we want to deploy the following indexing policy to our **products** container in our account.

:::code language="json" source="../media/6-indexing-policy-products.json" highlight="6,11":::

The **indexingPolicy** object can be lifted with no changes and set to the **properties.resource.indexingPolicy** property of the **Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers**.

:::code language="json" source="../media/6-template.json" range="34-70" highlight="21-34":::

## Defining an indexing policy in Bicep templates

Let's assume that we want to deploy the following indexing policy to our **customers** container in our account.

:::code language="json" source="../media/6-indexing-policy-customers.json" highlight="6,11":::

A few small changes are required to use this indexing policy in Bicep. These changes include:

- Removing the double quotation from property names
- Changing property values from single quotes to double quotes
- Removing commas typically required in JSON

:::code language="bicep" source="../media/6-template.bicep" range="27-54" highlight="12-25":::

## Updating an indexing policy on an existing container

If a resource of type **Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers** already exists, and all other properties match, you can update the indexing policy by solely changing the values within the **properties.resource.indexingPolicy** property. Azure Resource Manager will only change the indexing policy while keeping the rest of the container intact.

The command for deployment is the same as the initial deployment.

:::code language="azurecli" source="../media/6-script.sh" range="1-3" highlight="3":::

:::code language="azurecli" source="../media/6-script.sh" range="5-7" highlight="3":::
