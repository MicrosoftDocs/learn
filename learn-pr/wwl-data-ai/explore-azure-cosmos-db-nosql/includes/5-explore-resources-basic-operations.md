You decided that Azure Cosmos DB for NoSQL fits the Contoso application. The next step is to see the resource model in action and learn the basic operations you perform on any new account. In this unit, you walk through those operations conceptually so that the hands-on exercise that follows feels familiar.

This unit demonstrates each operation in the Azure portal, using the Data Explorer. The portal isn't the only way to do any of it. You can also create an account, database, or container using Bicep, Azure Resource Manager templates, the Azure CLI, or Azure PowerShell. In production, teams usually provision resources this way, as infrastructure as code, instead of setting them up by hand. Creating and querying items is a different kind of operation, one you perform in the portal or from application code, usually through an SDK.

## Navigate the resource hierarchy

The **Data Explorer** is the portal tool for working with an account's data. It presents the same hierarchy you learned earlier (the account at the top, then databases, then containers, then items) as a navigable tree. You expand a database to see its containers, expand a container to see its items, and select an item to view or edit its JSON.

:::image type="content" source="../media/data-explorer-tree.png" alt-text="Screenshot of Data Explorer with the cosmicworks database, product container, items, and selected item JSON." lightbox="../media/data-explorer-tree.png":::

Data Explorer is where you create resources, browse data, and run queries without writing application code, which makes it well suited to early experimentation.

## Create an account

Creating an account is the first operation for any new workload. When you create an account in the portal, you select an **API** first. The API selection is fixed for the life of the account and can't be changed later, so choose the NoSQL API for the workloads in this course.

:::image type="content" source="../media/select-api.png" alt-text="Screenshot of the Azure portal listing Azure Cosmos DB APIs available during account creation." lightbox="../media/select-api.png":::

The portal then guides you through a wizard with tabs for configuration options. The essential choices are:

- The globally unique **name** of the account.
- The **region** where the account is created.
- The **capacity mode**, either provisioned throughput or serverless. With provisioned throughput, you set specific throughput values, including autoscale, later, when you create a database or container.

The tab carries other fields as well, such as **Workload Type** and an option to apply the free tier discount.

:::image type="content" source="../media/create-account-wizard.png" alt-text="Screenshot of the account creation wizard with account name, location, and capacity mode fields." lightbox="../media/create-account-wizard.png":::

## Create a database

A database groups one or more containers within an account, and it needs little configuration. A name that's unique in the account is enough to create one.

## Create a container

A container is where your data lives and is the unit of scalability. When you create a container, you specify:

- The **parent database**.
- A **name** for the container that's unique within the database.
- The **partition key path**, which names the property that groups related items, such as `/categoryId`.

The partition key path is the decision that most affects how the container scales, and you can't change it in place. Switching to a different partition key means to copy the data into a new container. For example, in a `product` container, a path such as `/categoryId` groups products by category in the same logical partition.

## Create and read items

With a database and container in place, you create your first **item**, a JSON document. In Data Explorer, you add an item by entering its JSON directly. If you leave out `id`, Data Explorer generates a value through its client SDK. The service adds system properties such as `_rid` and `_etag`. You can also supply your own string `id` in Data Explorer. In application code, provide a string `id` unless your client generates one. Applications often set `id` to a value they already know, such as an order number, so that later they can point-read the item directly instead of querying for it first. The service also indexes the document automatically and makes it available for queries immediately. A minimal item looks like this:

```json
{
  "categoryId": "4F34E180-384D-42FC-AC10-FEC30227577F",
  "categoryName": "Components, Pedals",
  "sku": "PD-R563",
  "name": "ML Road Pedal",
  "price": 62.09
}
```

To read data back, you select an item in the tree to view its full JSON, or you run a query. Azure Cosmos DB for NoSQL uses a SQL-like query language. A query that returns every item in a container looks like this:

```sql
SELECT * FROM product p
```

You can narrow the results with a filter. The following query returns only the products in one category:

```sql
SELECT * FROM product p WHERE p.categoryId = "4F34E180-384D-42FC-AC10-FEC30227577F"
```

If you come from relational databases, the `FROM` clause looks like a table name. It isn't. A query always runs against exactly one container, the one you select in Data Explorer or the one your application code opens, and it can't span containers the way SQL join spans tables. The identifier in the `FROM` clause is just a name for that container's items inside the query, and it doesn't have to match the container's real name. Here, `product` matches it for readability, and `p` shortens it so that `p.categoryId` refers to the `categoryId` property of each item.

Because the service indexes every property by default, both queries run without any extra index configuration. A filter that uses the partition key path, such as `p.categoryId`, targets a single logical partition, which makes it more efficient than a query that scans the whole container.

These read and write operations (creating items, viewing them, and querying them) are the same operations you perform from application code later, expressed through the portal here. Working in Data Explorer first lets you confirm the resource model and your partition key choice before you write a line of application code.

You now know the operations you perform on a new account. In the next unit, you apply them yourself: you provision an account and create a database, container, and items.
