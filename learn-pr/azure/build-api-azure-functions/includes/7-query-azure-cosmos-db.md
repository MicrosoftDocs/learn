You can connect to Azure Cosmos DB from Azure Functions in one of two ways:

* Azure Cosmos DB binding for Azure Functions
* Azure Cosmos DB JavaScript SDK

The Azure Cosmos DB bindings are the _quickest_ way to connect to Azure Cosmos DB from Azure Functions. The SDK requires more code, but gives you more control over your database.

You're building an API so you're going to need flexibility in how you query the database. Besides, you _love_ code. A good `try/catch` is why you get up every morning. You'll be using the Azure Cosmos DB JavaScript SDK.

### Azure Cosmos DB SQL SDK

First, you'll need the SDK. Your code won't work as well without it as it will with it. The Azure Cosmos DB SQL JavaScript SDK is called `@azure/cosmos`. It's installed from npm.

```bash
npm install @azure/cosmos
```

Interacting with a Azure Cosmos DB database starts with a `CosmosClient` object.

```typescript
import { CosmosClient } from "@azure/cosmos";

const client = new CosmosClient(<Connection String>);
```

That object needs a connection string as you might have noticed from the previous snippet. Visual Studio Code can give you the connection string. You can get it by right-clicking the database in the Azure Cosmos DB Visual Studio Code extension, and selecting **Copy connection string**.

After you have that connection string on your clipboard, you can copy it right into your code, right? Well, you could, but you probably shouldn't.

## Store connection strings in Azure Functions

It's a good idea to avoid hard-coding connection strings. You'll likely use the connection string across different files, and there's a chance that it could change in the future.

You'll want to store the connection string as an app setting. App settings are specified in one place and referenced throughout the app. They can be easily changed at any point in the future without having to change the code.

An Azure Functions project has a `local.settings.json` file. This file contains a set of key/value pairs that are used in the app as configuration values. To access these configuration values from JavaScript, see the `process.env` object. It will contain all of the key value pairs that are specified in the `local.settings.json` file.

```typescript
let client = new CosmosClient(process.env.CONNECTION_STRING);
```

Now that you've got a new client object, you need to get a reference to the container where your data is to work with this data.

## Get a reference to the container

The term "container" is another word for "collection". First, get a reference to the database you want to work with. Next, get a reference to the specific container.

```typescript
import { CosmosClient } from "@azure/cosmos";

const client = new CosmosClient(<Connection String>);

const database = client.database("tailwind");
const container = database.container("products");
```

### Read data

Call the `readAll` method to read every item. This returns an "iterator," which can move through the objects, and return them by calling `fetchAll`.

```typescript
let iterator = container.items.readAll();
let items = await iterator.fetchAll();
```

### Create an item

To create an item in Azure Cosmos DB, call the `create` method on the `items` object, passing in the item to create.

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
> Note that if you don't pass in an "id" property with your data, Azure Cosmos DB will create one for you. Azure Cosmos DB generated IDs are GUIDs.

### Update an item

To update or delete an item, you need to get a reference to the item first. You do that by passing in the item ID, and the value of the partition key. In this module, the collection has a parameter key on the brand name; "/brand/name".

The `replace` method replaces an item completely with the item passed in. The "resource" object on the response from Azure Cosmos DB contains a reference to the new object value in the database.

```typescript
const product = {
  id: 1,
  name: "Updated Product Name",
  brand: {
    name: "Brand Name"
  }
};

const { resource } = await container
  .item(product.id, product.brand.name)
  .replace(product);
```

### Delete an item

The `delete` method deletes an item based on the ID and partition key value that is specified.

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

You now know how to do basically anything with data in Azure Cosmos DB. OK, maybe not everything, but definitely enough to complete this Products API. This is one productive day you're having. If only Tailwind Traders had 10 other developers just like you.
