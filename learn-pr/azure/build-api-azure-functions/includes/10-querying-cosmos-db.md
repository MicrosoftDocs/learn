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

The SDK is written in TypeScript. Since you're building the server portion of the Product Manager in TypeScript, the SDK objects and methods will appear in VS Code's Intellisense. You'll spend less time reading the Cosmos DB SDK documentation and more time writing code.

The main object in the SDK is called the `CosmosClient`. The `CosmosClient` object takes in a connection string and returns a new instance of a CosmosClient object. All of the databases, collections, and documents are available off of the client object.

In this example, all of the items are read from the "products" container...

```typescript
import { CosmosClient } from "@azure/cosmos";

const client = new CosmosClient(<Connection String>);

const database = client.database("tailwind");
const container = database.container("products");

let iterator = container.items.readAll();
let items = await iterator.fetchAll();
```

The connection string can be retrieved from the CLI, the portal, or, as you'll see in the next exercise, directly from VS Code.

## Storing connection strings in Azure Functions

It's a good idea to avoid hard-coding connection strings. You'll likely use the connection string across different files, and there's a chance that it could change in the future.

You'll want to make the connection string an application setting. Application settings are specified in one place and referenced throughout the application. They can be easily changed at any point in the future without having to change the code.

An Azure Functions project will contain a `local.settings.json` file. This file contains a set of key/value pairs that are used in the application as configuration values. To access these configuration values from within JavaScript, refer to the `process.env` object. It will contain all of the key value pairs that are specified in the `local.settings.json` file.

For instance, if you add a "CONNECTION_STRING" key to the `local.settings.json` file, you can pass it to the `CosmosClient` object like this...

```typescript
let client = new CosmosClient(process.env.CONNECTION_STRING);
```

In the next exercise, you will connect the "GetProducts" function to your Cosmos DB database. Then you'll write the code that performs the Get, Create, Update, and Delete operations.
