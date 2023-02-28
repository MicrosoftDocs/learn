Now you can create the various resources; such as databases, containers, and items; that you use in your Azure Cosmos DB account. For this exercise, you create a database named `cosmicworks` with a single container named `products`. You need to make sure that the code doesn't crash trying to re-create a container if you run this console application multiple times.

Right now, you have a few key requirements:

01. Create a database if it doesn't already exist
01. Create a container if it doesn't already exist

:::image type="content" source="../media/project-visual-resources.svg" alt-text="Illustration of icons indicating Azure Cosmos DB resources are created in the cloud." lightbox="../media/project-visual-resources.svg" border="false":::

After you complete this exercise, your project will create any databases, or containers it requires to execute.

## Reinitialize your environment (optional)

It's possible, if you closed your Azure Cloud Shell terminal pane, for the terminal instance to no longer have access to the environment variable and code editor. Here, if needed, you set your environment variable again and open the code editor.

> [!NOTE]
> You can safely skip this section if your terminal is already open, your environment variable is still set, and you are already editing your project in the code editor.

01. Set the environment variable named `COSMOS_CONNECTION_STRING` to the value of this command, which gets a connection string to the first Azure Cosmos DB for NoSQL account in your sandbox subscription.

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
    cd ~/clouddrive/inventory && code .
    ```

## Create a database

The SDK contains useful methods that creates a new resource if it doesn't already exist. By using these methods, you can run the application multiple times without worrying about exceptions raised by conflicts. Here, you create a database.

01. Open the *Program.cs* file again.

01. Create a new asynchronous local function named `CreateResourcesAsync` that returns an item of type <xref:Microsoft.Azure.Cosmos.Container>.

    ```csharp
    async Task<Container> CreateResourcesAsync()
    {
    }
    ```

01. Add the following lines of code within the **CreateResourcesAsync** local function.

    01. Create, or get, a new database by calling <xref:Microsoft.Azure.Cosmos.CosmosClient.CreateDatabaseIfNotExistsAsync(System.String,Microsoft.Azure.Cosmos.ThroughputProperties,Microsoft.Azure.Cosmos.RequestOptions,System.Threading.CancellationToken)>. Store the result in a variable named `database`. Be sure to set these parameters:

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

01. **Save** the *Program.cs* file.

## Create a container

Here, you create a container with a specific "slice" of the shared throughput from the database.

01. Add the following lines of code within the **CreateResourcesAsync** local function.

    01. Create, or get, a new container by calling <xref:Microsoft.Azure.Cosmos.Database.CreateContainerIfNotExistsAsync(System.String,System.String,System.Nullable{System.Int32},Microsoft.Azure.Cosmos.RequestOptions,System.Threading.CancellationToken)>. Store the result in a variable named **output**. Be sure to set these parameters:

        | Parameter | Value |
        | --- | --- |
        | **id** | `products` |
        | **partitionKeyPath** | `/categoryId` |
        | **throughput** | `400` |

        ```csharp
        Container output = await database.CreateContainerIfNotExistsAsync(
            id: "products",
            partitionKeyPath: "/categoryId",
            throughput: 400
        );
        ```

    01. Now, output the unique identifier for the container.

        ```csharp
        Console.WriteLine($"[Container created]:\t{output.Id}");
        ```

    01. Return the **output** variable.

        ```csharp
        return output;
        ```

01. Back within the main program flow, asynchronously call the **CreateResourcesAsync** method and store the result in a variable named **container**.

    ```csharp
    Container container = await CreateResourcesAsync();
    ```

01. **Save** the *Program.cs* file.

## Create record types for items

C# data can be represented using various types including classes, structs, and records. For this SDK, records are useful because they're immutable by default. You still can add code to create a modified copy of a record if you need to. Records also have an easy to read syntax and are quick to create with only a few lines of code. In this section, you create a base type for all items and individual types for each "kind" of item.

01. Using the terminal, create a new file named *Item.cs*.

    ```bash
    touch Item.cs
    ```

01. Refresh the code editor by invoking the `code` command again.

    ```bash
    code .
    ```

01. Open the *Item.cs* file.

01. Create a base type named `Item` that carries the three properties you want to use in all items for this container: `id`, `categoryId`, and `type`.

    ```csharp
    public record Item(
        string Id,
        string CategoryId,
        string Type
    );
    ```

01. **Save** the *Item.cs* file.

01. Create a new file named *Category.cs* and refresh the code editor.

    ```bash
    touch Category.cs && code .
    ```

01. Open the *Category.cs* file.

01. Create a new type named **Category** that inherits from the **Item** type. Ensure the type passes its values to the base implementation, and set the **type** variable to output the name of the **Category** type.

    ```csharp
    public record Category(
        string Id,
        string CategoryId
    ) : Item(
        Id,
        CategoryId,
        nameof(Category)
    );
    ```

01. **Save** the *Category.cs* file.

01. Create a new file named *Product.cs* and refresh the code editor.

    ```bash
    touch Product.cs && code .
    ```

01. Open the *Product.cs* file.

01. Create a new type named **Product** that inherits from **Item** and adds a few new properties: `name`, `price`, `archived`, and `quantity`.

    ```csharp
    public record Product(
        string Id,
        string CategoryId
    ) : Item(
        Id,
        CategoryId,
        nameof(Product)
    )
    {
        public string Name { get; init; } = default!;
        public decimal Price { get; init; }
        public bool Archived { get; init; }
        public int Quantity { get; init; }
    };
    ```

01. **Save** the *Product.cs* file.

## Check your work

Your app now creates a database and container. The methods you used to create these resources are be resilient enough to be ran multiple times without causing an exception. Here, you run the application and check the output for the unique identifiers of both of the resources.

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

01. Review the *Item.cs* code file to make sure that your code matches this sample.

    ```csharp
    public record Item(
        string Id,
        string CategoryId,
        string Type
    );
    ```

01. Review the *Category.cs* code file to make sure that your code matches this sample.

    ```csharp
    public record Category(
        string Id,
        string CategoryId
    ) : Item(
        Id,
        CategoryId,
        nameof(Category)
    );
    ```

01. Review the *Product.cs* code file to make sure that your code matches this sample.

    ```csharp
    public record Product(
        string Id,
        string CategoryId
    ) : Item(
        Id,
        CategoryId,
        nameof(Product)
    )
    {
        public string Name { get; init; } = default!;
        public decimal Price { get; init; }
        public bool Archived { get; init; }
        public int Quantity { get; init; }
    };
    ```

01. Review the *Program.cs* code file to make sure that your code matches this sample.

    ```csharp
    using Microsoft.Azure.Cosmos;
    using Microsoft.Azure.Cosmos.Fluent;
    
    using CosmosClient client = GetClient();
    
    Container container = await CreateResourcesAsync();
    
    static CosmosClient GetClient()
    {
        // Implementation removed for brevity
    }
    
    async Task<Container> CreateResourcesAsync()
    {
        // Implementation removed for brevity
    }
    ```

01. Within the **Program.cs** code file, review the **CreateResourcesAsync** local function to make sure that your code matches this sample.

    ```csharp
    Database database = await client.CreateDatabaseIfNotExistsAsync(
        id: "cosmicworks"
    );

    Console.WriteLine($"[Database created]:\t{database.Id}");

    Container output = await database.CreateContainerIfNotExistsAsync(
        id: "products",
        partitionKeyPath: "/categoryId",
        throughput: 400
    );

    Console.WriteLine($"[Container created]:\t{output.Id}");

    return output;
    ```

---
