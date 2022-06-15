Once you've created an Azure Cosmos DB API for MongoDB account, connecting to that account will be easy. Regardless if you're connecting from .NET, Node.js, MongoDB Shell, Java, Python or other sources, you can find easy to follow connection instructions or scripts on the Azure portal itself. This reduces the guesswork of how to create your own connection strings or use the MongoDB Shell to connect to your account. Let's take a quick look on where we can find this information.

1. In the Azure portal, navigate to your Azure Cosmos DB API for MongoDB account.

1. On the left-hand Azure Cosmos DB API for MongoDB account menu, select **Quick start**.

[![Diagram showing the Azure Cosmos DB API for MongoDB .NET connection string](../media/5-azure-cosmos-db-connectionstring-net-mongodb.png)](../media/5-azure-cosmos-db-connectionstring-net-mongodb.png#lightbox)

There are tabs for different programming languages. Each of these tabs will already have prepared the code snippet you'll need to connect to the Azure Cosmos DB API for MongoDB account. All you need to do is copy and paste the code  with no changes into your application code or tool.  If your programming language or tool isn't listed, the last tab list most common parameters like host, port, username and password so you can create your own connection string on that language or tool.

Let's review the .NET code snippet.

```C#
string connectionString = 
  @"mongodb://mongodb00420mongodb01:P8XEmc2Z6gozP8XEmc2Z6gozP8XEmc2Z6gozP8XEmc2Z6gozP8XEmc2Z6gozP8XEmc2Z6gozP8XEmc2Z6goz==@mongodb00420mongodb01.mongo.cosmos.azure.com:10255/?ssl=true&retrywrites=false&replicaSet=globaldb&maxIdleTimeMS=120000&appName=@mongodb00420mongodb01@";
MongoClientSettings settings = MongoClientSettings.FromUrl(
  new MongoUrl(connectionString)
);
settings.SslSettings = 
  new SslSettings() { EnabledSslProtocols = SslProtocols.Tls12 };
var mongoClient = new MongoClient(settings);
```

This code snippet tells us that the Azure Cosmos DB API for MongoDB account name is *mongodb00420mongodb01* and its password is *P8XEmc2Z6gozP8XEmc2Z6gozP8XEmc2Z6gozP8XEmc2Z6gozP8XEmc2Z6gozP8XEmc2Z6gozP8XEmc2Z6goz==*.  The port used will be 10255, which is the standard Azure Cosmos DB API for MongoDB account port. Finally note that our host address will be *mongodb00420mongodb01.mongo.cosmos.azure.com*.

While it's that simple to connect to an Azure Cosmos DB API for MongoDB account, we should still take care of choosing the right partitioning and indexing strategy when designing our Azure Cosmos DB API for MongoDB databases.  It should be more than just connecting and loading/reading data. In the next module, we'll discuss these topics in more detail. 