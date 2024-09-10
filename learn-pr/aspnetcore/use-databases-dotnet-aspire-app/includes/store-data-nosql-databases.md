Data doesn't just take the form of well structured relational data. Sometimes, you need to store data that doesn't fit neatly into a table. For example, you might want to store a document that contains a list of items, each with a different schema. In this case, a NoSQL database is a better choice than a relational database. One of the most popular NoSQL databases is MongoDB.

## Using the .NET Aspire MongoDB component

The same pattern as before applies to MongoDB. You must configure both the app host and each consuming project.

### Configuring the app host

Install the MongoDB hosting component:

```dotnetcli
dotnet add package Aspire.Hosting.MongoDB --prerelease
```

Then, in the app host's _Program.cs_ file, add this code to register the container and create a database:

```csharp
var mongo = builder.AddMongoDB("mongo");
var mongodb = mongo.AddDatabase("mongodb");
```

Pass the database service to any projects that consume it:

```csharp
var northernTradersCatalogAPI = builder.AddProject<Projects.NorthernTraders_CatalogAPI>()
                                       .WithReference(mongodb);
```

### Configuring the consuming projects

You need to add the .NET Aspire MongoDB component to any microservice project that uses the database. You add the `Aspire.MongoDB.Driver` NuGet package to the project that needs data access, using either .NET CLI or the Visual Studio NuGet package manager.

```dotnetcli
dotnet add package Aspire.MongoDB.Driver --prerelease
```

In the **AppHost** _Program.cs_ file, register the MongoDB driver. For example your code might look like this:

```csharp
var mongoDB = builder.AddMongoDB("mongo")
                     .WithMongoExpress()
                     .AddDatabase("BasketDB");

var myService = builder.AddProject<Projects.MyService>()
                       .WithReference(mongoDB);
```

The MongoDB component, like PostgeSQL and MySQL, provides a database management tool called Mongo Express. The above code adds a container for it.

## Using a MongoDB database

All the projects in your solution that need access to the MongoDB database must add a MongoDB client. You then use the MongoDB client to read and write data to the database.

```csharp
builder.AddMongoDBClient("BasketDB");
```

The `AddMongoDBClient` method adds a client to the project. See this example code that uses it:

```csharp
using MongoDB.Driver;
using MongoDB.Driver.Linq;

public class MongoBasketStore
{
  public async Task<CustomerBasket?> GetBasketAsync(IMongoClient mongoClient, string customerId)
  {
    var basketCollection = mongoClient.GetDatabase("BasketDB").GetCollection<CustomerBasket>("basketitems");
    var filter = Builders<CustomerBasket>.Filter.Eq(r => r.BuyerId, customerId);
  
    return await basketCollection.Find(filter).FirstOrDefaultAsync();
  }
}
```

The above code creates a MongoDB collection that enables the method to query over all the `CustomerBasket` objects to find the one with the matching `BuyerId`.

## Configuring the MongoDB component

Just as the previous database components, the MongoDB component supports .NET Aspire's service discovery and dependency injection. So if you use the same database name defined in the `AppHost` and projects, there's no need to manage connection strings. But if you're already using an existing MongoDB database not managed by .NET Aspire, you have other ways to configure it.

### Using a connection string

In your projects _appsettings.json_ file, add a connection string to the MongoDB database. For example:

```json
{
  ...
  "ConnectionStrings": {
    "MongoConnectionString": "mongodb://localhost:27017/test",
  }
}
```

The previous connection string adds support for a database named **test** on a local MongoDB database server listening on port 27017. You use this connection string in your _Program.cs_ file when you create the MongoDB client:

```csharp
builder.AddMongoDBClient("MongoConnectionString");
```

### Other options

The tag for the `Microsoft.Extensions.Configuration` version of MongoDB is `Aspire:MongoDB:Driver`. So you can connect to a MongoDB database using the following JSON configuration:

```json
{
  "Aspire": {
    "MongoDB": {
      "Driver": {
        "ConnectionString": "mongodb://localhost:27017/test",
        "HealthChecks": true,
        "HealthCheckTimeout": 10000,
        "Tracing": true
      },
    }
  }
}
```

With the previous configuration, you no longer need to add the connection string, just use `builder.AddMongoDBClient();`.

The final option is to configure the connection in code, with inline configurations. For example:

```csharp
builder.AddMongoDBClient("mongodb", static settings => 
  { 
    settings.ConnectionString = "mongodb://localhost:27017/test"; 
    settings.HealthChecks = true; 
  });
```
