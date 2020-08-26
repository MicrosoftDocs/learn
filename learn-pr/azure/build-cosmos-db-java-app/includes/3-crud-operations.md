Once the connection to Azure Cosmos DB has been made, the next step is to create, read, replace, and delete the documents that are stored in the database. In this unit, you will create User documents in your `WebCustomer` collection. Then, you'll retrieve them by ID, replace them, and delete them.

## Working with documents programmatically

Data is stored in JSON documents in Azure Cosmos DB. [Documents](https://docs.microsoft.com/azure/cosmos-db/databases-containers-items#azure-cosmos-items) can be created, retrieved, replaced, or deleted in the portal, as shown in the previous module, or programmatically, as described in this module. Azure Cosmos DB provides client-side SDKs for .NET, .NET Core, Java, Node.js, and Python, each of which supports these operations. In this module, we'll be using the Java SDK to perform CRUD (create, retrieve, update, and delete) operations on the NoSQL data stored in Azure Cosmos DB.

The main operations for Azure Cosmos DB documents are part of the [CosmosAsyncContainer](https://docs.microsoft.com/dotnet/api/microsoft.azure.documents.client.documentclient?view=azure-dotnet) class:
* [createItem](https://docs.microsoft.com/java/api/com.azure.cosmos.cosmosasynccontainer.createitem?view=azure-java-stable#com_azure_cosmos_CosmosAsyncContainer__T_createItem_T_com_azure_cosmos_models_PartitionKey_com_azure_cosmos_models_CosmosItemRequestOptions_)
* [readItem](https://docs.microsoft.com/java/api/com.azure.cosmos.cosmosasynccontainer.readitem?view=azure-java-stable#com_azure_cosmos_CosmosAsyncContainer__T_readItem_java_lang_String_com_azure_cosmos_models_PartitionKey_com_azure_cosmos_models_CosmosItemRequestOptions_java_lang_Class_T__)
* [replaceItem](https://docs.microsoft.com/java/api/com.azure.cosmos.cosmosasynccontainer.replaceitem?view=azure-java-stable#com_azure_cosmos_CosmosAsyncContainer__T_replaceItem_T_java_lang_String_com_azure_cosmos_models_PartitionKey_com_azure_cosmos_models_CosmosItemRequestOptions_)
* [upsertItem](https://docs.microsoft.com/java/api/com.azure.cosmos.cosmosasynccontainer.upsertitem?view=azure-java-stable#com_azure_cosmos_CosmosAsyncContainer__T_upsertItem_T_com_azure_cosmos_models_CosmosItemRequestOptions_)
* [deleteItem](https://docs.microsoft.com/java/api/com.azure.cosmos.cosmosasynccontainer.deleteitem?view=azure-java-stable#com_azure_cosmos_CosmosAsyncContainer_deleteItem_java_lang_String_com_azure_cosmos_models_PartitionKey_com_azure_cosmos_models_CosmosItemRequestOptions_)

Upsert performs a create or replace operation depending on whether the document already exists.

To perform any of these operations, you need to create a class that represents the object stored in the database. Because we're working with a database of users, you'll want to create a **User** class to store primary data such as their first name, last name, and user id (which is required, as that's the partition key to enable horizontal scaling) and classes for shipping preferences and order history.

Once you have those classes created to represent your users, you'll create new user documents for each instance, and then we'll perform some basic CRUD operations on the documents.

## Create documents

1. First, create a **User** class that represents the objects to store in Azure Cosmos DB. We will also create **OrderHistory** and **ShippingPreference** classes that are used within **User**. Note that documents must have an **id** property, which will be serialized as **id** in JSON.

    To create these classes, copy and paste the following **User**, **OrderHistory**, and **ShippingPreference** classes underneath the **CosmosApp** class.

    ```java
    public class User
    {
        private String id;
        private String userId;
        private String lastName;
        private String firstName;
        private String email;
        private String dividend;
        private ShippingPreference shippingPreference;
        private List<OrderHistory> orderHistory;
        private List<CouponsUsed> coupons;

        public User() {
            this.orderHistory = new ArrayList<OrderHistory>();
            this.coupons = new ArrayList<CouponsUsed>();
            this.id="";
            this.userId="";
            this.lastName="";
            this.firstName="";
            this.email="";
            this.dividend="";
        }

        public String getId() { return this.id; }
        public void setId(String id) {this.id = id;}
        public String getUserId() { return this.userId; }
        public void setUserId(String userId) { this.userId = userId; }
        public String getLastName() { return this.lastName; }
        public void setLastName(String lastName) { this.lastName = lastName; }
        public String getFirstName() { return this.firstName; }
        public void setFirstName(String firstName) { this.firstName = firstName; }
        public String getEmail() { return this.email; }
        public void setEmail(String email) { this.email = email; } 
        public String getDividend() { return this.dividend; }
        public void setDividend(String dividend) { this.dividend = dividend; }
        public List<OrderHistory> getOrderHistory() { return this.orderHistory; }
        public void setOrderHistory(List<OrderHistory> orderHistory) { this.orderHistory = orderHistory; }
        public List<ShippingPreference> getShippingPreference() { return this.shippingPreference; }
        public void setShippingPreference(ShippingPreference shippingPreference) { this.shippingPreference = shippingPreference; }
        public List<CouponsUsed> getCoupons { return this.coupons; }
        public void setCoupons(List<Couponsused> coupons) { this.coupons = coupons; }
    }

    public class OrderHistory
    {
        private string id;
        private string orderId;
        private string dateShipped;
        private string total;

        public String getId(){ return this.id; }
        public String setId(String id){ this.id = id; }
        public String getOrderId(){ return this.orderId; }
        public void setOrderId(String orderId){ this.orderId=orderId; }
        public String getDateShipped(){ return this.dateShipped; }
        public void setDateShipped(String dateShipped){ this.dateShipped=dateShipped; }
        public String getTotal(){ return this.total; }
        public void setTotal(String total){ this.total = total; }
    }

    public class ShippingPreference
    {
        private int priority;
        private String addressLine1;
        private String addressLine2;
        private String city;
        private String state;
        private String zipCode;
        private String country;

        public int getPriority(){ return this.priority; }
        public void setPriority(String priority){this.priority = priority;}
        public String getAddressLine1(){ return this.addressLine1; }
        public void setAddressLine1(String addressLine1){ this.addressLine1 = addressLine1; }
        public String getAddressLine2(){ return this.addressLine2; }
        public void setAddressLine2(String addressLine2){ this.addressLine1 = addressLine2; }
        public String getCity(){ return this.city; }
        public void setCity(String city){ this.city = city; }
        public String getState(){ return this.state }
        public void setState(String state){ this.state = state; }
        public String getZipCode(){ return this.zipCode; }
        public void setZipCode(String zipCode){ this.zipCode = zipCode; }
    }

    public class CouponsUsed
    {
        private string couponCode;

        public String getCouponCode(){ return this.couponCode; }
        public void setCouponCode(String couponCode){ this.couponCode = couponCode; }

    }
    ```

1. Build and run **CosmosApp.java** in the IDE or execute the program in the terminal using 

    ```bash
    mvn clean package
    mvn exec:java -Dexec.mainClass="com.azure.azure-cosmos-java-sql-app-mslearn.CosmosApp"
    ```

    and confirm that it executes without issue.

1. a

    private void WriteToConsoleAndPromptToContinue(string format, params object[] args)
    {
        System.out.println("Press any key to continue.");
        Console.ReadKey();
    }


1. Now copy and paste the **CreateUserDocumentIfNotExists** task under the **WriteToConsoleAndPromptToContinue** method at the end of the Program.cs file.

    ```java
    private async Task CreateUserDocumentIfNotExists(string databaseName, string containerName, User user)
    {
        try
        {
            await this.client.ReadDocumentAsync(UriFactory.CreateDocumentUri(databaseName, containerName, user.Id), new RequestOptions { PartitionKey = new PartitionKey(user.UserId) });
            this.WriteToConsoleAndPromptToContinue("User {0} already exists in the database", user.Id);
        }
        catch (DocumentClientException de)
        {
            if (de.StatusCode == HttpStatusCode.NotFound)
            {
                await this.client.CreateDocumentAsync(UriFactory.CreateDocumentContainerUri(databaseName, containerName), user);
                this.WriteToConsoleAndPromptToContinue("Created User {0}", user.Id);
            }
            else
            {
                throw;
            }
        }
    }
    ```

1. Then, return to the **BasicOperations** method and add the following to the end of that method.

    ```java
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

    await this.CreateUserDocumentIfNotExists("Users", "WebCustomers", yanhe);

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

    await this.CreateUserDocumentIfNotExists("Users", "WebCustomers", nelapin);
    ```

1. In the integrated terminal, again, type the following command to run the program.

    ```bash
    dotnet run
    ```

    The terminal will display output as the application creates each new user document. Press any key to complete the program.

    ```output
    Database and container validation complete
    Created User 1
    Press any key to continue ...
    Created User 2
    Press any key to continue ...
    End of demo, press any key to exit.
    ```

## Read documents

1. To read documents from the database, copy in the following code and place after the **WriteToConsoleAndPromptToContinue** method in the Program.cs file.

    ```java
    private async Task ReadUserDocument(string databaseName, string containerName, User user)
    {
        try
        {
            await this.client.ReadDocumentAsync(UriFactory.CreateDocumentUri(databaseName, containerName, user.Id), new RequestOptions { PartitionKey = new PartitionKey(user.UserId) });
            this.WriteToConsoleAndPromptToContinue("Read user {0}", user.Id);
        }
        catch (DocumentClientException de)
        {
            if (de.StatusCode == HttpStatusCode.NotFound)
            {
                this.WriteToConsoleAndPromptToContinue("User {0} not read", user.Id);
            }
            else
            {
                throw;
            }
        }
    }
    ```

1. Copy and paste the following code to the end of the **BasicOperations** method, after the `await this.CreateUserDocumentIfNotExists("Users", "WebCustomers", nelapin);` line.

    ```java
    await this.ReadUserDocument("Users", "WebCustomers", yanhe);
    ```

1. In the integrated terminal, type the following command to run the program.

    ```bash
    dotnet run
    ```

    The terminal displays the following output, where the output "Read user 1" indicates the document was retrieved.

    ```output
    Database and container validation complete
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

1. Copy and paste the **ReplaceUserDocument** method after the **ReadUserDocument** method in the Program.cs file.

    ```java
    private async Task ReplaceUserDocument(string databaseName, string containerName, User updatedUser)
    {
        try
        {
            await this.client.ReplaceDocumentAsync(UriFactory.CreateDocumentUri(databaseName, containerName, updatedUser.Id), updatedUser, new RequestOptions { PartitionKey = new PartitionKey(updatedUser.UserId) });
            this.WriteToConsoleAndPromptToContinue("Replaced last name for {0}", updatedUser.LastName);
        }
        catch (DocumentClientException de)
        {
            if (de.StatusCode == HttpStatusCode.NotFound)
            {
                this.WriteToConsoleAndPromptToContinue("User {0} not found for replacement", updatedUser.Id);
            }
            else
            {
                throw;
            }
        }
    }
    ```

1. Copy and paste the following code to the end of the **BasicOperations** method, after the `await this.CreateUserDocumentIfNotExists("Users", "WebCustomers", nelapin);` line.

    ```java
    yanhe.LastName = "Suh";
    await this.ReplaceUserDocument("Users", "WebCustomers", yanhe);
    ```

1. In the integrated terminal, run the following command.

    ```bash
    dotnet run
    ```

    The terminal displays the following output, where the output "Replaced last name for Suh" indicates the document was replaced.

    ```output
    Database and container validation complete
    User 1 already exists in the database
    Press any key to continue ...
    Replaced last name for Suh
    Press any key to continue ...
    User 2 already exists in the database
    Press any key to continue ...
    Read user 1
    Press any key to continue ...
    End of demo, press any key to exit.
    ```

## Delete documents

1. Copy and paste the **DeleteUserDocument** method underneath your **ReplaceUserDocument** method.

    ```java
    private async Task DeleteUserDocument(string databaseName, string containerName, User deletedUser)
    {
        try
        {
            await this.client.DeleteDocumentAsync(UriFactory.CreateDocumentUri(databaseName, containerName, deletedUser.Id), new RequestOptions { PartitionKey = new PartitionKey(deletedUser.UserId) });
            Console.WriteLine("Deleted user {0}", deletedUser.Id);
        }
        catch (DocumentClientException de)
        {
            if (de.StatusCode == HttpStatusCode.NotFound)
            {
                this.WriteToConsoleAndPromptToContinue("User {0} not found for deletion", deletedUser.Id);
            }
            else
            {
                throw;
            }
        }
    }
    ```

1. Copy and paste the following code in the end of the **BasicOperations** method.

    ```java
    await this.DeleteUserDocument("Users", "WebCustomers", yanhe);
    ```

1. In the integrated terminal, run the following command.

    ```bash
    dotnet run
    ```

    The terminal displays the following output, where the output "Deleted user 1" indicates the document was deleted.

    ```output
    Database and container validation complete
    User 1 already exists in the database
    Press any key to continue ...
    Replaced last name for Suh
    Press any key to continue ...
    User 2 already exists in the database
    Press any key to continue ...
    Read user 1
    Press any key to continue ...
    Deleted user 1
    End of demo, press any key to exit.
    ```

In this unit you created, replaced, and deleted documents in your Azure Cosmos DB database.
