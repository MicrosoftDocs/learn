You can connect to Azure Cosmos DB from Azure Functions in one of two ways...

1. The Cosmos DB binding for Azure Functions
2. The Cosmos DB JavaScript SDK

The Cosmos DB bindings are the _quickest_ way to connect to Cosmos DB from Azure Functions. The SDK requires more code, but gives you more control over your database.

You're building an API so you're going to need flexibility in how you query the database. Besides, you _love_ code. A good `try/catch` is why you get up every morning. You'll be using the Cosmos DB JavaScript SDK.

### Cosmos DB SQL SDK

First, you'll need the SDK. Your code won't work as well without it as it will with it. The Cosmos DB SQL JavaScript SDK is called `@azure/cosmos`. It is installed from npm.

```bash
npm install @azure/cosmos
```

Interacting with a Cosmos DB database starts with a `CosmosClient` object.

```typescript
import { CosmosClient } from "@azure/cosmos";

const client = new CosmosClient(<Connection String>);
```

That object needs a connection string as you might have noticed from the snippet above. VS Code can give you the connection string. You can get it by right-clicking the database in the Azure Cosmos DB VS Code extension and choosing "Copy connection string".

Once you have that connection string on your clipboard, you can copy it right into your code, right? Well, you could, but you probably shouldn't.

## Storing connection strings in Azure Functions

It's a good idea to avoid hard-coding connection strings. You'll likely use the connection string across different files, and there's a chance that it could change in the future.

You'll want to store the connection string an application setting. Application settings are specified in one place and referenced throughout the application. They can be easily changed at any point in the future without having to change the code.

An Azure Functions project has a `local.settings.json` file. This file contains a set of key/value pairs that are used in the application as configuration values. To access these configuration values from JavaScript, refer to the `process.env` object. It will contain all of the key value pairs that are specified in the `local.settings.json` file.

```typescript
let client = new CosmosClient(process.env.CONNECTION_STRING);
```

Now that you've got a new client object, you need to get a reference to the container where your data is to work with said data.

## Getting a reference to the container

The term "container" is another word for "collection". First, get a reference to the database you want to work with. Then get a reference to the specific container.

```typescript
import { CosmosClient } from "@azure/cosmos";

const client = new CosmosClient(<Connection String>);

const database = client.database("tailwind");
const container = database.container("products");
```

### Reading data

Call the `readAll` method to read every item. This returns an "iterator", which can move move through the objects and return them by calling `fetchAll`.

```typescript
let iterator = container.items.readAll();
let items = await iterator.fetchAll();
```

### Creating an item

To create an item in Cosmos DB, call the `create` method on the `items` object, passing in the item to create.

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
> Note that if you don't pass in an "id" property with your data, Cosmos DB will create one for you. Cosmos DB generated id's are guids.

### Update an item

In order to update or delete an item, you need to get a reference to the item first. You do that by passing in the item id, and the value of the partition key of the item. In this Learn Module, our collection has a parameter key on the brand name (/brand/name).

The `replace` method replaces an item completely with the item passed in. The "resource" object on the response from Cosmos DB contains a reference to the new object value in the database.

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

You now know how to do pretty much anything with data in Cosmos DB. OK, maybe not everything, but defintely enough to finish out this Products API. This is one productive day you're having. If only Tailwind Traders had 10 other developers just like you.
