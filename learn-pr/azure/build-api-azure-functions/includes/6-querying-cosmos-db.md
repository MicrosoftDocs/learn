You can connect to Azure Cosmos DB from Azure Functions in one of two ways...

1. The Cosmos DB binding for Azure Functions
2. The Cosmos DB SDK

The Cosmos DB bindings are the quickest way to connect to Cosmos DB from Azure Functions. The SDK requires more code, but gives you more control over your database.

You're building an API, so you're going to need flexibility in how you query the database. You'll be using the Cosmos DB SDK in the next exercise.

### Cosmos DB SQL SDK

The Cosmos DB SQL JavaScript SDK is called `@azure/cosmos`. You install it like any npm package.

```bash
npm install @azure/cosmos
```

## Storing connection strings in Azure Functions

It's a good idea to avoid hard-coding connection strings. You'll likely use the connection string across different files, and there's a chance that it could change in the future.

You'll want to make the connection string an application setting. Application settings are specified in one place and referenced throughout the application. They can be easily changed at any point in the future without having to change the code.

An Azure Functions project will contain a `local.settings.json` file. This file contains a set of key/value pairs that are used in the application as configuration values. To access these configuration values from within JavaScript, refer to the `process.env` object. It will contain all of the key value pairs that are specified in the `local.settings.json` file.

For instance, if you add a "CONNECTION_STRING" key to the `local.settings.json` file, you can pass it to the `CosmosClient` object like this...

```typescript
let client = new CosmosClient(process.env.CONNECTION_STRING);
```

The connection string can be retrieved from the CLI, the portal, or, as you'll see in the next exercise, directly from VS Code.

## Getting a reference to the container

To work with data in CosmosDB, you need to get a reference to the "container" where the data is stored. The term "container" is another word for "collection". First, get a reference to the database you want to work with. Then get a reference to the specific container.

```typescript
import { CosmosClient } from "@azure/cosmos";

const client = new CosmosClient(<Connection String>);

const database = client.database("tailwind");
const container = database.container("products");
```

## Reading data

Call the `readAll` method to read every item. This returns an "iterator", which can move move through the objects and return them by calling `fetchAll`.

```typescript
let iterator = container.items.readAll();
let items = await iterator.fetchAll();
```

## Modifying data

### Create an item

To create an item in CosmosDB, call the `create` method on the `items` object, passing in the item to create.

```typescript
const product = {
  id: 1,
  name: "Product Name",
  brand: {
    name: "Brand Name"
  }
};

const { resource } = container.items.create(product);
```

> [!TIP]
> Note that if you don't pass in an "id" property with your data, CosmosDB will create one for you. CosmosDB generated id's are guids.

### Update an item

In order to update or delete an item, you need to get a reference to the item first. You do that by passing in the item id, and the value of the partition key of the item. In this Learn Module, our collection has a parameter key on the brand name.

The `replace` method replaces an item completely with the item passed in. The "resource" object on the response from CosmosDB contains a reference to the new object value in the database.

```typescript
const product = {
  id: 1,
  name: "Updated Product Name",
  brand: {
    name: "Brand Name"
  }
};

const { resource } = container
  .item(product.id, product.brand.name)
  .replace(product);
```

### Delete an item

The `delete` method deletes an item based off of the "id" that is passed in.

```typescript
const product = {
  id: 1,
  name: "Updated Product Name",
  brand: {
    name: "Brand Name"
  }
};

await container.items.delete(product.id, product.brand.name);
```

In the next exercise, you will connect the "GetProducts" function to your Cosmos DB database. Then you'll write the code that performs the Get, Create, Update, and Delete operations.
