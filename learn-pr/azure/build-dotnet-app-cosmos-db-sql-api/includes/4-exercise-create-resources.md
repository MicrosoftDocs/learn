Now you can create the various resources; such as databases, containers, and items; that you'll use in your Azure Cosmos DB account. For this exercise, you'll create a database named `cosmicworks` with a single container named `products`. You need to make sure that the code won't crash trying to re-create a container if you run this console application multiple times.

Right now, you have a few key requirements:

01. Create a database if it doesn't already exist
01. Create a container if it doesn't already exist

:::image type="content" source="../media/project-visual-resources.png" alt-text="Illustration of icons indicating Azure Cosmos DB resources are created in the cloud." lightbox="../media/project-visual-resources.png" border="false":::

After you complete this exercise, your project will create any databases, or containers it requires to execute.

## Reinitialize your environment (optional)

It's possible, if you closed your Azure Cloud Shell terminal pane, for the terminal instance to no longer have access to the environment variable and code editor. Here, if needed, you'll set your environment variable again and open the code editor.

> [!NOTE]
> You can safely skip this section if your terminal is already open, your environment variable is still set, and you are already editing your project in the code editor.

01. Set the environment variable named `COSMOS_CONNECTION_STRING` to the value of this command, which gets a connection string to the first Azure Cosmos DB SQL API account in your sandbox subscription.

    ```azurecli
    export COSMOS_CONNECTION_STRING=$(az cosmosdb keys list \
        --name $(az cosmosdb list \
            --resource-group <rgn>[sandbox resource group name]</rgn> \
            --query [0].name \
            --output tsv) \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --type connection-strings \
        --query "connectionStrings[?description=='Primary SQL Connection String'].connectionString" \
        --output tsv)
    ```

01. Change to the *clouddrive/inventory* directory and open a code editor.

    ```bash
    cd ~/clouddrive/inventorytool && code .
    ```

## Create a database

The SDK contains useful methods that will only create a new resource if it doesn't already exist. By using these methods, you can run the application multiple times without worrying about exceptions raised by conflicts. Here, you'll create a database.

01. Open the *Program.cs* file.

01. Create, or get, a new database by calling `CosmosClient.CreateDatabaseIfNotExistsAsync`. Store the result in a variable named **database**. Be sure to set these parameters:

    | Parameter | Value |
    | --- | --- |
    | **id** | `cosmicworks` |

    ```csharp
    Database database = await client.CreateDatabaseIfNotExistsAsync(
        id: "cosmicworks"
    );
    ```

01. Output the unique identifier for the database.

    ```csharp
    Console.WriteLine($"[Database created]:\t{database.Id}");
    ```

## Create a container

Here, you'll create a container with a specific "slice" of the shared throughput from the database.

01. Create, or get, a new container by calling `Database.CreateContainerIfNotExistsAsync`. Store the result in a variable named **container**. Be sure to set these parameters:

    | Parameter | Value |
    | --- | --- |
    | **id** | `products` |
    | **partitionKeyPath** | `/categoryId` |
    | **throughput** | `400` |

    ```csharp
    Container container = await database.CreateContainerIfNotExistsAsync(
        id: "products",
        partitionKeyPath: "/categoryId",
        throughput: 400
    );
    ```

01. Now, output the unique identifier for the container.

    ```csharp
    Console.WriteLine($"[Container created]:\t{container.Id}");
    ```

01. **Save** the *Program.cs* file.

## Create record types for items

C# data can be represented using various types including classes, structs, and records. For this SDK, records are useful because they're immutable. Records also have an easy to read syntax and are quick to create with only a few lines of code. In this section, you'll create a base type for all items and individual types for each "kind" of item.

01. Using the terminal, create a new file named **Item.cs**.

    ```bash
    touch Item.cs
    ```

01. Refresh the code editor by invoking the `code` command again.

    ```bash
    code .
    ```

01. Open the *Item.cs* file.

01. Create a base type named **Item** that carries the three properties you want to use in all items for this container: `id`, `categoryId`, and `type`.

    ```csharp
    public record Item(
        string id,
        string categoryId,
        string type
    );
    ```

01. **Save** the *Item.cs* file.

01. Create a new file named **Category.cs** and refresh the code editor.

    ```bash
    touch Category.cs && code .
    ```

01. Open the *Category.cs* file.

01. Create a new type named **Category** that inherits from the **Item** type. Ensure the type passes its values to the base implementation, and set the **type** variable to output the name of the **Category** type.

    ```csharp
    public record Category(
        string id,
        string categoryId,
        string type = nameof(Category)
    ) : Item(
        id,
        categoryId,
        type
    );
    ```

01. **Save** the *Category.cs* file.

01. Create a new file named **Product.cs** and refresh the code editor.

    ```bash
    touch Product.cs && code .
    ```

01. Open the *Product.cs* file.

01. Create a new type named **Product** that inherits from **Item** and adds a few new properties: `name`, `price`, `archived`, and `quantity`.

    ```csharp
    public record Product(
        string id, 
        string categoryId, 
        string name, 
        decimal price, 
        bool archived, 
        int quantity,
        string type = nameof(Product)
    ) : Item(
        id,
        categoryId,
        type
    );
    ```

01. **Save** the *Product.cs* file.

## Check your work

Your app now creates a database and container. The methods you used to create these resources are be resilient enough to be ran multiple times without causing an exception. Here, you'll run the application and check the output for the unique identifiers of both of the resources.

### [Run application](#tab/run-app)

01. Run the .NET application in the terminal

    ```dotnetcli
    dotnet run
    ```  

01. Observe the output of running the application. The output should match the example here.

    ```output
    ...
    [Database created]:     cosmicworks
    [Container created]:    products
    ```

### [Review code](#tab/review-code)

01. Review the **Item.cs** code file to make sure that your code matches this sample.

    ```csharp
    public record Item(
        string id,
        string categoryId,
        string type
    );
    ```

01. Review the **Category.cs** code file to make sure that your code matches this sample.

    ```csharp
    public record Category(
        string id,
        string categoryId,
        string type = nameof(Category)
    ) : Item(
        id,
        categoryId,
        type
    );
    ```

01. Review the **Product.cs** code file to make sure that your code matches this sample.

    ```csharp
    public record Product(
        string id, 
        string categoryId, 
        string name, 
        decimal price, 
        bool archived, 
        int quantity,
        string type = nameof(Product)
    ) : Item(
        id,
        categoryId,
        type
    );
    ```

01. Review the **Program.cs** code file to make sure that your code matches this sample.

    ```csharp
    using Microsoft.Azure.Cosmos;
    
    string cosmosConnectionString = Environment.GetEnvironmentVariable("COSMOS_CONNECTION_STRING")!;
    
    Console.WriteLine($"[Connection string]:\t{cosmosConnectionString}");
    
    using CosmosClient client = new(
        connectionString: cosmosConnectionString
    );
    
    Console.WriteLine("[Client connected]");

    Database database = await client.CreateDatabaseIfNotExistsAsync(
        id: "cosmicworks"
    );
    
    Console.WriteLine($"[Database created]:\t{database.Id}");
    
    Container container = await database.CreateContainerIfNotExistsAsync(
        id: "products",
        partitionKeyPath: "/categoryId",
        throughput: 400
    );
    
    Console.WriteLine($"[Container created]:\t{container.Id}");
    ```

---
