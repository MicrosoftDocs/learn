There are a few basic operations that you will need to perform anytime you create any Azure Cosmos DB SQL API account resource in Azure.

## Creating a new account

The first step to getting started with Azure Cosmos DB is to create a new account.

When creating a new account in the portal, you must first select an API for your workload. The API selection cannot be changed after the account is created. For the remainder of this section, we will assume that the SQL API has been selected.

:::image type="content" source="../media/3-select-api.png" alt-text="Select API option in the portal with a list of all current APIs including SQL, MongoDB, Graph, Table, and Cassandra.":::

Next, the Azure portal will use a step-by-step wizard with tabs for various configuration options. Here you can configure options such as:

- The globally unique name of your account
- The location (Azure region) for the account
- Capacity mode (provisioned throughput or serverless)

:::image type="content" source="../media/3-account-wizard.png" alt-text="Wizard with various tabs and options for creating a new Azure Cosmos DB SQL API account.":::

> &#128221; Only the options in the **Basics** tab are required to create an Azure Cosmos DB account.

## Creating a new database

Databases are logical units of management in Azure Cosmos DB SQL API, and don't require much to create. You only need a unique database name within the account to create a new database.

> &#128221; However, if you choose to provision throughput at the database level, configuring the database may require additional steps. This is explored deeper in other Azure Cosmos DB SQL API topics.

## Creating a new container

Containers are the primary unit of scalability in Azure Cosmos DB SQL API. When creating a container, you should specify:

- The parent database
- A unique name for the container with the database
- The path for the partition key value
- *Optional*: provisioned throughput if not inferred from database provisioning.

The Azure Cosmos DB service will automatically and transparently partition your data based on the value of the partition key for each individual item.

## Creating simple items

Once the database and container resources exist, you are ready to create your first item. In Azure Cosmos DB SQL API, and item is a JSON document.

> &#128221; JavaScript Object Notation (JSON) is an open standard file format, and data interchange format, that uses human-readable text to store and transmit data objects consisting of attribute–value pairs and array data types (or any other serializable value)

JSON is a language-independent data format with well-defined data types and near universal support across a diverse range of services and programing languages. Here is an example of a JSON document that could be an item in an Azure Cosmso DB account:

:::code language="json" source="../media/3-document.json" highlight="2":::
