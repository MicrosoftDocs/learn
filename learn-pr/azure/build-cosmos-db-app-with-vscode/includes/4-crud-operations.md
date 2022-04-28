Once the connection to Azure Cosmos DB has been made, the next step is to create, read, replace, and delete the documents that are stored in the database. In this unit, you'll create User documents in your `WebCustomer` collection. Then, you'll retrieve them by ID, replace them, and delete them.

## Working with documents programmatically

Data is stored in JSON documents in Azure Cosmos DB. [Documents](/azure/cosmos-db/databases-containers-items#azure-cosmos-items) can be created, retrieved, replaced, or deleted in the portal, as shown in the previous module, or programmatically, as described in this module. Azure Cosmos DB provides client-side SDKs for .NET, .NET Core, Java, Node.js, and Python, each of which supports these operations. In this module, we'll be using the .NET SDK to perform CRUD (create, retrieve, update, and delete) operations on the NoSQL data stored in Azure Cosmos DB.

The main operations for Azure Cosmos DB documents are part of the [DocumentClient](/dotnet/api/microsoft.azure.documents.client.documentclient?view=azure-dotnet&preserve-view=true) class:

* [CreateDocumentAsync](/dotnet/api/microsoft.azure.documents.client.documentclient.createdocumentasync?view=azure-dotnet&preserve-view=true)
* [ReadDocumentAsync](/dotnet/api/microsoft.azure.documents.client.documentclient.readdocumentasync?view=azure-dotnet&preserve-view=true)
* [ReplaceDocumentAsync](/dotnet/api/microsoft.azure.documents.client.documentclient.replacedocumentasync?view=azure-dotnet&preserve-view=true)
* [UpsertDocumentAsync](/dotnet/api/microsoft.azure.documents.client.documentclient.upsertdocumentasync?view=azure-dotnet&preserve-view=true)
* [DeleteDocumentAsync](/dotnet/api/microsoft.azure.documents.client.documentclient.deletedocumentasync?view=azure-dotnet&preserve-view=true)

Upsert performs a create or replace operation depending on whether the document already exists.

To perform any of these operations, you need to create a class that represents the object stored in the database. Because we're working with a database of users, you'll want to create a **User** class to store primary data such as their first name, last name, and user id (which is required, as that's the partition key to enable horizontal scaling) and classes for shipping preferences and order history.

Once you have those classes created to represent your users, you'll create new user documents for each instance, and then we'll perform some basic CRUD operations on the documents.

## Create documents

1. First, create a **User** class that represents the objects to store in Azure Cosmos DB. We'll also create **OrderHistory** and **ShippingPreference** classes that are used within **User**. Documents must have an **Id** property serialized as **id** in JSON.

    To create these classes, copy and paste the following **User**, **OrderHistory**, and **ShippingPreference** classes underneath the **BasicOperations** method.

    ```csharp
    public class User
    {
        [JsonProperty("id")]
        public string Id { get; set; }
        [JsonProperty("userId")]
        public string UserId { get; set; }
        [JsonProperty("lastName")]
        public string LastName { get; set; }
        [JsonProperty("firstName")]
        public string FirstName { get; set; }
        [JsonProperty("email")]
        public string Email { get; set; }
        [JsonProperty("dividend")]
        public string Dividend { get; set; }
        [JsonProperty("OrderHistory")]
        public OrderHistory[] OrderHistory { get; set; }
        [JsonProperty("ShippingPreference")]
        public ShippingPreference[] ShippingPreference { get; set; }
        [JsonProperty("CouponsUsed")]
        public CouponsUsed[] Coupons { get; set; }
        public override string ToString()
        {
            return JsonConvert.SerializeObject(this);
        }
    }

    public class OrderHistory
    {
        public string OrderId { get; set; }
        public string DateShipped { get; set; }
        public string Total { get; set; }
    }

    public class ShippingPreference
    {
        public int Priority { get; set; }
        public string AddressLine1 { get; set; }
        public string AddressLine2 { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string ZipCode { get; set; }
        public string Country { get; set; }
    }

    public class CouponsUsed
    {
        public string CouponCode { get; set; }

    }
    ```

1. Copy and paste the **WriteToConsoleAndPromptToContinue** method under the **BasicOperations** task near the top of the **Program.cs** file.

    ```csharp
    private void WriteToConsoleAndPromptToContinue(string format, params object[] args)
    {
        Console.WriteLine(format, args);
        Console.WriteLine("Press any key to continue ...");
        Console.ReadKey();
    }
    ```

1. In the integrated terminal, run the following command to run the program to ensure it runs. For now, disregard the build warning that "The local function 'WriteToConsoleAndPromptToContinue' is declared but never used".

    ```bash
    dotnet run
    ```

1. Copy and paste the **CreateUserDocumentIfNotExists** task under the **WriteToConsoleAndPromptToContinue** method near the top of the **Program.cs** file.

    ```csharp
    async Task CreateUserDocumentIfNotExists(string databaseName, string collectionName, User user)
    {
        try
        {
            await client.ReadDocumentAsync(UriFactory.CreateDocumentUri(databaseName, collectionName, user.Id), new RequestOptions { PartitionKey = new PartitionKey(user.UserId) });
            WriteToConsoleAndPromptToContinue("User {0} already exists in the database", user.Id);
        }
        catch (DocumentClientException de)
        {
            if (de.StatusCode == HttpStatusCode.NotFound)
            {
                await client.CreateDocumentAsync(UriFactory.CreateDocumentCollectionUri(databaseName, collectionName), user);
                WriteToConsoleAndPromptToContinue("Created User {0}", user.Id);
            }
            else
            {
                throw;
            }
        }
    }
    ```

1. Return to the **BasicOperations** Task, and add the following to the end of that task.

    ```csharp
    User yanhe = new User
    {
        Id = "1",
        UserId = "yanhe",
        LastName = "He",
        FirstName = "Yan",
        Email = "yanhe@contoso.com",
        OrderHistory = new OrderHistory[]
            {
                new OrderHistory {
                    OrderId = "1000",
                    DateShipped = "08/17/2018",
                    Total = "52.49"
                }
            },
            ShippingPreference = new ShippingPreference[]
            {
                    new ShippingPreference {
                            Priority = 1,
                            AddressLine1 = "90 W 8th St",
                            City = "New York",
                            State = "NY",
                            ZipCode = "10001",
                            Country = "USA"
                    }
            },
    };

    await CreateUserDocumentIfNotExists("Users", "WebCustomers", yanhe);

    User nelapin = new User
    {
        Id = "2",
        UserId = "nelapin",
        LastName = "Pindakova",
        FirstName = "Nela",
        Email = "nelapin@contoso.com",
        Dividend = "8.50",
        OrderHistory = new OrderHistory[]
        {
            new OrderHistory {
                OrderId = "1001",
                DateShipped = "08/17/2018",
                Total = "105.89"
            }
        },
        ShippingPreference = new ShippingPreference[]
        {
            new ShippingPreference {
                    Priority = 1,
                    AddressLine1 = "505 NW 5th St",
                    City = "New York",
                    State = "NY",
                    ZipCode = "10001",
                    Country = "USA"
            },
            new ShippingPreference {
                    Priority = 2,
                    AddressLine1 = "505 NW 5th St",
                    City = "New York",
                    State = "NY",
                    ZipCode = "10001",
                    Country = "USA"
            }
        },
        Coupons = new CouponsUsed[]
        {
            new CouponsUsed{
                CouponCode = "Fall2018"
            }
        }
    };

    await CreateUserDocumentIfNotExists("Users", "WebCustomers", nelapin);
    ```

1. In the integrated terminal, again, run the following command to run the program.

    ```bash
    dotnet run
    ```

    The terminal will display output as the application creates each new user document. Press any key to complete the program.

    ```output
    Database and collection validation complete
    Created User 1
    Press any key to continue ...
    Created User 2
    Press any key to continue ...
    End of demo, press any key to exit.
    ```

## Read documents

1. To read documents from the database, copy the following code, and place it after the **WriteToConsoleAndPromptToContinue** method in the **Program.cs** file.

    ```csharp
    async Task ReadUserDocument(string databaseName, string collectionName, User user)
    {
        try
        {
            await client.ReadDocumentAsync(UriFactory.CreateDocumentUri(databaseName, collectionName, user.Id), new RequestOptions { PartitionKey = new PartitionKey(user.UserId) });
            WriteToConsoleAndPromptToContinue("Read user {0}", user.Id);
        }
        catch (DocumentClientException de)
        {
            if (de.StatusCode == HttpStatusCode.NotFound)
            {
                WriteToConsoleAndPromptToContinue("User {0} not read", user.Id);
            }
            else
            {
                throw;
            }
        }
    }
    ```

1. Copy and paste the following code to the end of the **BasicOperations** method, after the `await CreateUserDocumentIfNotExists("Users", "WebCustomers", nelapin);` line.

    ```csharp
    await ReadUserDocument("Users", "WebCustomers", yanhe);
    ```

1. In the integrated terminal, run the following command to run the program.

    ```bash
    dotnet run
    ```

    The terminal displays the following output, where the output "Read user 1" indicates the document was retrieved.

    ```output
    Database and collection validation complete
    User 1 already exists in the database
    Press any key to continue ...
    User 2 already exists in the database
    Press any key to continue ...
    Read user 1
    Press any key to continue ...
    End of demo, press any key to exit.
    ```

## Replace documents

Azure Cosmos DB supports replacing JSON documents. In this case, we'll update a user record to account for a change to their last name.

1. Copy and paste the **ReplaceUserDocument** method after the **ReadUserDocument** method in the **Program.cs** file.

    ```csharp
    async Task ReplaceUserDocument(string databaseName, string collectionName, User updatedUser)
    {
        try
        {
            await client.ReplaceDocumentAsync(UriFactory.CreateDocumentUri(databaseName, collectionName, updatedUser.Id), updatedUser, new RequestOptions { PartitionKey = new PartitionKey(updatedUser.UserId) });
            WriteToConsoleAndPromptToContinue("Replaced last name for {0}", updatedUser.LastName);
        }
        catch (DocumentClientException de)
        {
            if (de.StatusCode == HttpStatusCode.NotFound)
            {
                WriteToConsoleAndPromptToContinue("User {0} not found for replacement", updatedUser.Id);
            }
            else
            {
                throw;
            }
        }
    }
    ```

1. Copy and paste the following code to the end of the **BasicOperations** method, after the `await CreateUserDocumentIfNotExists("Users", "WebCustomers", nelapin);` line.

    ```csharp
    yanhe.LastName = "Suh";
    await ReplaceUserDocument("Users", "WebCustomers", yanhe);
    ```

1. In the integrated terminal, run the following command.

    ```bash
    dotnet run
    ```

    The terminal displays the following output, where the output "Replaced last name for Suh" indicates the document was replaced.

    ```output
    Database and collection validation complete
    User 1 already exists in the database
    Press any key to continue ...
    User 2 already exists in the database
    Press any key to continue ...
    Replaced last name for Suh
    Press any key to continue ...
    Read user 1
    Press any key to continue ...
    End of demo, press any key to exit.
    ```

## Delete documents

1. Copy and paste the **DeleteUserDocument** method underneath your **ReplaceUserDocument** method.

    ```csharp
    async Task DeleteUserDocument(string databaseName, string collectionName, User deletedUser)
    {
        try
        {
            await client.DeleteDocumentAsync(UriFactory.CreateDocumentUri(databaseName, collectionName, deletedUser.Id), new RequestOptions { PartitionKey = new PartitionKey(deletedUser.UserId) });
            Console.WriteLine("Deleted user {0}", deletedUser.Id);
        }
        catch (DocumentClientException de)
        {
            if (de.StatusCode == HttpStatusCode.NotFound)
            {
                WriteToConsoleAndPromptToContinue("User {0} not found for deletion", deletedUser.Id);
            }
            else
            {
                throw;
            }
        }
    }
    ```

1. Copy and paste the following code in the end of the **BasicOperations** method.

    ```csharp
    await DeleteUserDocument("Users", "WebCustomers", yanhe);
    ```

1. In the integrated terminal, run the following command.

    ```bash
    dotnet run
    ```

    The terminal displays the following output, where the output "Deleted user 1" indicates the document was deleted.

    ```output
    Database and collection validation complete
    User 1 already exists in the database
    Press any key to continue ...
    User 2 already exists in the database
    Press any key to continue ...
    Replaced last name for Suh
    Press any key to continue ...
    Read user 1
    Press any key to continue ...
    Deleted user 1
    End of demo, press any key to exit.
    ```

In this unit you created, replaced, and deleted documents in your Azure Cosmos DB database.