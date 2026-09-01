The first step in building an application on Azure DocumentDB is establishing a connection from your code. Because Azure DocumentDB implements the MongoDB wire protocol, you use the same official MongoDB drivers that work with any MongoDB deployment. Using this approach means your team doesn't need to learn a new SDK or change their development workflow.

In this unit, you install the MongoDB driver for your language, build a connection string, create a client instance, and verify that your application can communicate with the cluster.

## Why standard MongoDB drivers work with Azure DocumentDB

Azure DocumentDB implements the MongoDB wire protocol at over 99% compatibility. This level of compatibility means the official MongoDB drivers for Python, .NET, and JavaScript connect to Azure DocumentDB the same way they connect to any MongoDB instance. You don't need a specialized Azure SDK, the standard MongoDB driver for your language handles authentication, Transport Layer Security (TLS) encryption, and connection pooling automatically.

The three official drivers covered in this module are:

- **Python**: PyMongo (`pymongo` package)
- **.NET**: MongoDB.Driver (`MongoDB.Driver` NuGet package)
- **JavaScript/Node.js**: MongoDB Node.js Driver (`mongodb` npm package)

## Install the driver

::: zone pivot="python"

Install PyMongo using pip:

```bash
pip install pymongo
```

Import the client class in your application code:

```python
from pymongo import MongoClient
```

::: zone-end

::: zone pivot="csharp"

Install the MongoDB .NET driver using the NuGet package manager:

```dotnetcli
dotnet add package MongoDB.Driver
```

Import the required namespaces:

```csharp
using MongoDB.Driver;
using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;
```

::: zone-end

::: zone pivot="node"

Install the MongoDB Node.js driver using npm:

```bash
npm install mongodb
```

Import the client class:

```javascript
const { MongoClient } = require('mongodb');
```

::: zone-end

## Build the connection string

The connection string for Azure DocumentDB follows the standard MongoDB `SRV` format. You can find it in the Azure portal under your cluster's **Connection strings** setting.

The format looks like this:

```text
mongodb+srv://<username>:<password>@<cluster-name>.global.mongocluster.cosmos.azure.com/?tls=true&authMechanism=SCRAM-SHA-256&retrywrites=false&maxIdleTimeMS=120000
```

The key parameters in this connection string are:

| Parameter | Purpose |
|---|---|
| `tls=true` | Encrypts all traffic between your application and the cluster. Required for Azure DocumentDB. |
| `authMechanism=SCRAM-SHA-256` | Specifies the authentication method. Azure DocumentDB uses SCRAM-SHA-256 by default. |
| `retrywrites=false` | Disables automatic write retries. Recommended setting for Azure DocumentDB clusters. |
| `maxIdleTimeMS=120000` | Closes idle connections after two minutes to prevent stale connection issues. |

> [!IMPORTANT]
> The connection string from the Azure portal contains a `<username>:<password>` placeholder. Create a dedicated database user with least-privilege permissions and use that user's credentials in your connection string. During development, you can use the admin credentials from cluster provisioning, but using the dedicated user is still the recommended approach. Never use admin credentials in production. Store all credentials in environment variables or a secret manager rather than hardcoding them in your source code.

## Create a client and connect

::: zone pivot="python"

Create a `MongoClient` instance with your connection string. PyMongo connects lazily, so the actual connection happens when you perform your first operation.

```python
import os
from pymongo import MongoClient

connection_string = os.environ["AZURE_DOCUMENTDB_CONNECTION_STRING"]
client = MongoClient(connection_string)

# Verify the connection
client.admin.command("ping")
print("Connected to Azure DocumentDB")
```

::: zone-end

::: zone pivot="csharp"

Create a `MongoClient` from connection settings. The .NET driver manages a connection pool automatically.

```csharp
var connectionString = Environment.GetEnvironmentVariable("AZURE_DOCUMENTDB_CONNECTION_STRING");
var settings = MongoClientSettings.FromConnectionString(connectionString);
var client = new MongoClient(settings);

// Verify the connection
var adminDb = client.GetDatabase("admin");
await adminDb.RunCommandAsync<BsonDocument>(new BsonDocument("ping", 1));
Console.WriteLine("Connected to Azure DocumentDB");
```

::: zone-end

::: zone pivot="node"

Create a `MongoClient` instance and call `connect()`. The Node.js driver requires an explicit connection call.

```javascript
const connectionString = process.env.AZURE_DOCUMENTDB_CONNECTION_STRING;
const client = new MongoClient(connectionString);

await client.connect();

// Verify the connection
await client.db('admin').command({ ping: 1 });
console.log('Connected to Azure DocumentDB');
```

::: zone-end

## Access a database and collection

After you connect, get a reference to your database and collection. If the database or collection doesn't exist yet, Azure DocumentDB creates it automatically when you insert your first document.

::: zone pivot="python"

```python
db = client["cosmicworks"]
products = db["products"]
```

::: zone-end

::: zone pivot="csharp"

```csharp
var db = client.GetDatabase("cosmicworks");
var products = db.GetCollection<BsonDocument>("products");
```

::: zone-end

::: zone pivot="node"

```javascript
const db = client.db('cosmicworks');
const products = db.collection('products');
```

::: zone-end

Each driver uses a similar hierarchy: **client → database → collection**. The database and collection references are lightweight objects that don't trigger network calls until you execute an operation.

## Put it all together

The following code combines every step from this unit into a single script: install the driver, connect to your Azure DocumentDB cluster, verify the connection, and access a database and collection.

::: zone pivot="python"

In Python, use PyMongo to create a client, ping the server, and get references to your database and collection.

```python
import os
from pymongo import MongoClient

connection_string = os.environ["AZURE_DOCUMENTDB_CONNECTION_STRING"]
client = MongoClient(connection_string)

# Verify the connection
client.admin.command("ping")
print("Connected to Azure DocumentDB")

# Access a database and collection
db = client["cosmicworks"]
products = db["products"]
```

::: zone-end

::: zone pivot="csharp"

In C#, use the `MongoDB.Driver` package to connect, verify the connection, and access your database and collection.

```csharp
using MongoDB.Driver;
using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

var connectionString = Environment.GetEnvironmentVariable("AZURE_DOCUMENTDB_CONNECTION_STRING");
var settings = MongoClientSettings.FromConnectionString(connectionString);
var client = new MongoClient(settings);

// Verify the connection
var adminDb = client.GetDatabase("admin");
await adminDb.RunCommandAsync<BsonDocument>(new BsonDocument("ping", 1));
Console.WriteLine("Connected to Azure DocumentDB");

// Access a database and collection
var db = client.GetDatabase("cosmicworks");
var products = db.GetCollection<BsonDocument>("products");
```

::: zone-end

::: zone pivot="node"

In Node.js, use the mongodb package to create a client, explicitly connect, and access your database and collection.

```javascript
const { MongoClient } = require('mongodb');

const connectionString = process.env.AZURE_DOCUMENTDB_CONNECTION_STRING;
const client = new MongoClient(connectionString);

await client.connect();

// Verify the connection
await client.db('admin').command({ ping: 1 });
console.log('Connected to Azure DocumentDB');

// Access a database and collection
const db = client.db('cosmicworks');
const products = db.collection('products');
```

::: zone-end

You now have everything you need to connect your application to Azure DocumentDB and access a collection. In the next unit, you learn how to insert, read, update, and delete documents using the same driver.
