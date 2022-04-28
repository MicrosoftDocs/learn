Now that you've created documents in your application, let's query them from your application. Azure Cosmos DB uses SQL queries and LINQ queries. This unit focuses on running SQL queries and LINQ queries from your application, as opposed to the portal.

We'll use the user documents you've created for your online retailer application to test these queries.

## LINQ query basics

LINQ is a .NET programming model that expresses computations as queries on streams of objects. You can create an **IQueryable** object that directly queries Azure Cosmos DB, which translates the LINQ query into an Azure Cosmos DB query. The query is then passed to the Azure Cosmos DB server to retrieve a set of results in JSON format. The returned results are deserialized into a stream of .NET objects on the client side. Many developers prefer LINQ queries, as they provide a single consistent programming model across how they work with objects in application code and how they express query logic running in the database.

The following table shows how LINQ queries are translated into SQL.

| LINQ expression | SQL translation |
|---|---|
| `input.Select(family => family.parents[0].familyName);`| `SELECT VALUE f.parents[0].familyName FROM Families f` |
|`input.Select(family => family.children[0].grade + c); // c is an int variable` | `SELECT VALUE f.children[0].grade + c FROM Families f` |
|`input.Select(family => new { name = family.children[0].familyName, grade = family.children[0].grade + 3});`| `SELECT VALUE {"name":f.children[0].familyName, "grade": f.children[0].grade + 3 } FROM Families f`|
|`input.Where(family=> family.parents[0].familyName == "Smith");`|`SELECT * FROM Families f WHERE f.parents[0].familyName = "Smith"`|

## Run SQL and LINQ queries

1. The following sample shows how a query could be performed in SQL, LINQ, or LINQ lambda from your .NET code. Copy the code and add it after the **DeleteUserDocument** method in the **Program.cs** file.

    ```csharp
    void ExecuteSimpleQuery(string databaseName, string collectionName)
    {
        // Set some common query options
        FeedOptions queryOptions = new FeedOptions { MaxItemCount = -1, EnableCrossPartitionQuery = true };

        // Here we find nelapin via their LastName
        IQueryable<User> userQuery = client.CreateDocumentQuery<User>(
                UriFactory.CreateDocumentCollectionUri(databaseName, collectionName), queryOptions)
                .Where(u => u.LastName == "Pindakova");

        // The query is executed synchronously here, but can also be executed asynchronously via the IDocumentQuery<T> interface
        Console.WriteLine("Running LINQ query...");
        foreach (User user in userQuery)
        {
            Console.WriteLine("\tRead {0}", user);
        }

        // Now execute the same query via direct SQL
        IQueryable<User> userQueryInSql = client.CreateDocumentQuery<User>(
                UriFactory.CreateDocumentCollectionUri(databaseName, collectionName),
                "SELECT * FROM User WHERE User.lastName = 'Pindakova'", queryOptions );

        Console.WriteLine("Running direct SQL query...");
        foreach (User user in userQueryInSql)
        {
                Console.WriteLine("\tRead {0}", user);
        }

        Console.WriteLine("Press any key to continue ...");
        Console.ReadKey();
    }
    ```

1. Copy and paste the following code to your **BasicOperations** method, before the `await DeleteUserDocument("Users", "WebCustomers", yanhe);` line.

    ```csharp
    ExecuteSimpleQuery("Users", "WebCustomers");
    ```

1. In the integrated terminal, run the following command.

    ```bash
    dotnet run
    ```

    The console displays the output of the LINQ and SQL queries.

In this unit you learned about LINQ queries, and then added a LINQ and SQL query to your application to retrieve user records.
