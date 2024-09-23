Another service included in Azure Storage accounts is Azure Table storage. In these tables, you can store large lists of entities with flexible schemas. Table storage is designed to be adaptable, scalable, and cost effective.

In the outdoor equipment retailer you work for, you're already using Azure Storage accounts in several microservices to store blobs and message queues. One microservice uses an SQL database for product information but you want to assess whether Azure Table storage is a better place to keep this data.

In this unit, you'll learn about the .NET Aspire Azure Data Tables component and how you can implement it in a cloud-native app.

## Why use Azure Storage Tables?

Cloud-native web apps serve information to users and frequently need to store, update, and retrieve large quantities of data about your organization's products and services. Also you must often store data about users, stock levels, employees, knowledge, users relationships, and many other subjects. Traditionally, such information is stored with a strict schema and enforced relationships between tables in relational databases with Structured Query Language (SQL) interfaces. Recently, however, some data services take a NoSQL approach, which doesn't impose a strict schema or key relationships on tables. Such data services enable your data models to evolve easily as business requirements change. Access to data is often faster and cheaper for a given quantity of data.

Azure Storage accounts include a NoSQL structured data storage solution called Azure Tables storage. You can create tables in the same Storage account as your blob stores and queues or use a dedicated account. There's no limit on the number of entities you can store in a table or the number of tables you can store in a storage account up to the capacity limit of the storage account.

> [!NOTE]
> There are many other services that you can use for NoSQL data storage in a cloud-native application. MongoDB, for example, is a flexible and scalable NoSQL database that will run both inside and outside Azure. Cosmos DB supports a wide range of NoSQL APIs, but must run within Azure.

> [!TIP]
> It's easy to upgrade a NoSQL data store from Azure Storage Tables to Cosmos DB because Cosmos DB includes the Azure Cosmos DB for Table API. This support enables you to move your data into Cosmos DB without rewriting your data access code.

## Using Azure Table Storage with .NET Aspire

The choice of data store is usually made by each microservice development team. Each team may choose a different storage technology according to their requirements and preferences so your complete cloud-native app may use many different database technologies. If you build your cloud-native app by using .NET Aspire, then it's easy for each microservice to use Azure Storage Tables because they can use the .NET Aspire Azure Data Tables component.

### Modifying the app host project

In the app host project for your solution, you must install the `Aspire.Hosting.Azure.Storage` package:

```dotnetcli
dotnet add package Aspire.Hosting.Azure.Storage
```

Next, register the Azure Table Storage component:

```csharp
var tables = builder.AddAzureStorage("storage")
    .AddTables("tables");
```

Now, you can pass the service to each microservice that consumes it:

```csharp
var catalogMicroservice = builder.AddProject<Projects.CatalogMicroservice>()
    .WithReference(tables);
```

### Modifying the consuming projects

In the microservice where you want to store and retrieve data, install the NuGet package:

```dotnetcli
dotnet add package Aspire.Azure.Data.Tables
```

Next, in the _Program.cs_ file, register the `TableServiceClient` object in the dependency injection container:

```csharp
builder.AddAzureTableClient("tables");
```

> [!NOTE]
> In the above code, the string "tables" is the name of a connection string that specifies the location of the Azure Storage account.

Whenever you want to store or retrieve data in tables, you can use dependency injection to retrieve the `TableServiceClient`:

```csharp
public class CatalogService(TableServiceClient client)
{
    // Use the client object to store or retrieve entities in tables
}
```

### Storing data

From .NET Aspire, you can obtain a `TableServiceClient` from dependency injection. With this client, you can create and obtain tables:

```csharp
private static async Task<TableClient> CreateProductsTableAsync(TableServiceClient tableServiceClient)
{
    string tableName = "products-table";

    try 
    {
        TableClient table = await tableServiceClient.CreateTableIfNotExistsAsync(tablename);

        if (await table.ExistsAsync())
        {
            return table;
        }
    }
    catch (RequestFailedException e)
    {
        Console.WriteLine("HTTP error code {0}: {1}",
            e.Status, e.ErrorCode);
        Console.WriteLine(e.Message);
    }

    return null;
}
```

Having obtained a table, you can store entities in it:

```csharp
private static async Task StoreProductAsync(TableClient table)
{
    // Create a new entity to save
    var newProduct = new Product("PartitionKey", "RowKey")
    {
        Name = "Beany Hat",
        Price = 15.00,
        Description = "Warm and functional on cold days."
    };

    try
    {
        await table.AddEntityAsync(newProduct);
    }
    catch (RequestFailedException e)
    {
        Console.WriteLine("HTTP error code {0}: {1}",
                            e.Status, e.ErrorCode);
        Console.WriteLine(e.Message);
    }
}

public class Product : ITableEntity
{
    public Product(string partitionKey, string rowKey)
    {
        PartitionKey = partitionKey;
        RowKey = rowKey;
    }

    public Product() { }

    public string PartitionKey { get; set; }
    public string RowKey { get; set; }
    public string Name { get; set; }
    public double Price { get; set; }
    public string Description { get; set; }
}
```

### Configuring the connection to the Storage account

In the previous example code, you register the Azure Table Service client in the consuming microservice by using this code:

```csharp
builder.AddAzureTableClient("tables");
```

The string you pass to this method is the name of a connection string. You should store this connection string in one of the project's app settings files:

```json
{
  "ConnectionStrings": {
    "tables": "https://{account_name}.table.core.windows.net/"
  }
}
```

## Learn more

- [.NET Aspire Azure Data Tables component](/dotnet/aspire/storage/azure-storage-tables-component)
- [What is Azure Table storage?](/azure/storage/tables/table-storage-overview)
- [Azure Tables client library for .NET](/dotnet/api/overview/azure/data.tables-readme)
