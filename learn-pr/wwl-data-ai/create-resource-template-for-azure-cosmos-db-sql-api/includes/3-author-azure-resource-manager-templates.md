Authoring a template for an Azure Cosmos DB SQL API account is much like building one from scratch using the portal or from the CLI. There are three primary resources to define in a specific relationship order.

## Empty template

An Azure Resource Manager template is, at its core, a JSON file with a specific syntax you must follow. The default minimal empty template is a JSON document with a **schema** property set to ``https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#``, a **contentVersion** property set to ``1.0.0.0``, and an empty **resources** array. This example illustrates a minimal empty template.

:::code language="json" source="../media/3-template.json" range="1-4,71-72":::

> &#128221; All resources we place in this template will be JSON objects within the **resources** array.

## Account resource

The first resource type to define is **Microsoft.DocumentDB/databaseAccounts**. This represents an account that is not specific to any API. If the API is not specified, it is inferred to be a SQL API account.

An object for this resource must contain, at a minimum, the following properties:

- name
- location
- properties.databaseAccountOfferType
- properties.locations[].locationName

Here is an example of an account that has a unique name with a prefix of **csmsarm** and is deployed to **West US**.

:::code language="json" source="../media/3-template.json" range="5-18":::

> &#128221; You can define more than one location using the locations array.

## Database resource

The next resource is of type **Microsoft.DocumentDB/databaseAccounts/sqlDatabases** and is a child resource of the account. This relationship is defined using the **dependsOn** property.

An object for this resource must contain, at a minimum, the following properties:

- name
- properties.resources.id

A database can also optionally contain the following properties:

- properties.options.throughput
- properties.options.autoscaleSettings.maxThroughput

Here is an example of a database that is named **cosmicworks**.

:::code language="json" source="../media/3-template.json" range="20-32":::

## Container resource

Within a database, you can define multiple child **Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers** resources. Here, you can allocate throughput, configure indexing policy, and set a partition key path.

A container object must contain, at a minimum, the following properties:

- name
- properties.resource.id
- properties.resource.partitionkey.paths[]

A database can also optionally contain the following properties:

- properties.options.throughput
- properties.options.autoscaleSettings.maxThroughput
- properties.resource.indexingPolicy

Here is an example of a container that is named **products**, has **400 RU/s** throughput, and a partition key path of **/categoryId**.

:::code language="json" source="../media/3-template.json" range="34-52,68-70":::

## Final template

Now that all resources are in place, the template file should now contain the following code.

:::code language="json" source="../media/3-template.json" range="1-52,68-72":::
