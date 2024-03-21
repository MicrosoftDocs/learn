In this exercise you create a console app to perform the following operations in Azure Cosmos DB:

* Connect to an Azure Cosmos DB account
* Create a database
* Create a container

## Prerequisites

* An Azure account with an active subscription. If you don't already have one, you can sign up for a free trial at [https://azure.com/free](https://azure.com/free).

* [Visual Studio Code](https://code.visualstudio.com/) on one of the [supported platforms](https://code.visualstudio.com/docs/supporting/requirements#_platforms).

* [.NET 6](https://dotnet.microsoft.com/download/dotnet/6.0) is the target framework for the exercise.

* The [C# extension](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csharp) for Visual Studio Code.
  
*  The latest [Azure CLI](/cli/azure/install-azure-cli) tools, installed locally.

## Setting up

Perform the following actions to prepare Azure, and your local environment, for the exercise.

### Connecting to Azure

1. Start Visual Studio Code and open a terminal window by selecting **Terminal** from the top application bar, then choosing **New Terminal**.

1. Sign in to Azure by using the following command. A browser window should open letting you choose which account to sign in with.

    ```
    az login
    ```

### Create resources in Azure

1. Create a resource group for the resources needed for this exercise. Replace `<myLocation>` with a region near you.

    ```
    az group create --location <myLocation> --name az204-cosmos-rg
    ```

1. Create the Azure Cosmos DB account. Replace `<myCosmosDBacct>` with a *unique* name to identify your Azure Cosmos DB account. The name can only contain lowercase letters, numbers, and the hyphen (-) character. It must be between 3-31 characters in length. *This command takes a few minutes to complete.*

    ```
    az cosmosdb create --name <myCosmosDBacct> --resource-group az204-cosmos-rg
    ```

    Record the `documentEndpoint` shown in the JSON response, it's used later in the exercise.

1. Retrieve the primary key for the account by  using the following command. Record the `primaryMasterKey` from the command results it will be used in the code.

     ```
    # Retrieve the primary key
    az cosmosdb keys list --name <myCosmosDBacct> --resource-group az204-cosmos-rg
    ```

### Set up the console application

Now that the needed resources are deployed to Azure the next step is to set up the console application using the same terminal window in Visual Studio Code.

1. Create a folder for the project and change in to the folder.

    ```
    md az204-cosmos
    cd az204-cosmos
    ```

1. Create the .NET console app.

    ```
    dotnet new console
    ```

1. Open the current folder in Visual Studio Code using the following command. The `-r` option opens the folder without launching a new Visual Studio Code window.

    ```
    code . -r
    ```

1. Select the *Program.cs* file in the **Explorer** pane to open the file in the editor.

## Build the console app

It's time to start adding the packages and code to the project.

### Add packages and using statements

1. Open the terminal in Visual Studio Code and use the following command to add the `Microsoft.Azure.Cosmos` package to the project.

    ```
    dotnet add package Microsoft.Azure.Cosmos
    ```

1. Delete any existing code in the `Program.cs` file and add the `using Microsoft.Azure.Cosmos` statement.

    ```csharp
    using Microsoft.Azure.Cosmos;
    ```

### Add code to connect to an Azure Cosmos DB account

1. Add the following code snippet after the `using` statement. The code snippet adds constants and variables into the class and adds some error checking. Be sure to replace the placeholder values for `EndpointUri` and `PrimaryKey` following the directions in the code comments.

    ```csharp
    public class Program
    {
        // Replace <documentEndpoint> with the information created earlier
        private static readonly string EndpointUri = "<documentEndpoint>";

        // Set variable to the Primary Key from earlier.
        private static readonly string PrimaryKey = "<your primary key>";

        // The Cosmos client instance
        private CosmosClient cosmosClient;

        // The database we will create
        private Database database;

        // The container we will create.
        private Container container;

        // The names of the database and container we will create
        private string databaseId = "az204Database";
        private string containerId = "az204Container";

        public static async Task Main(string[] args)
        {
            try
            {
                Console.WriteLine("Beginning operations...\n");
                Program p = new Program();
                await p.CosmosAsync();
    
            }
            catch (CosmosException de)
            {
                Exception baseException = de.GetBaseException();
                Console.WriteLine("{0} error occurred: {1}", de.StatusCode, de);
            }
            catch (Exception e)
            {
                Console.WriteLine("Error: {0}", e);
            }
            finally
            {
                Console.WriteLine("End of program, press any key to exit.");
                Console.ReadKey();
            }
        }
        //The sample code below gets added below this line
    }
    ```

1. Below the `Main` method, add a new asynchronous task called `CosmosAsync`, which instantiates our new `CosmosClient` and adds code to call the methods you add later to create a database and a container.

    ```csharp
    public async Task CosmosAsync()
    {
        // Create a new instance of the Cosmos Client
        this.cosmosClient = new CosmosClient(EndpointUri, PrimaryKey);

        // Runs the CreateDatabaseAsync method
        await this.CreateDatabaseAsync();

        // Run the CreateContainerAsync method
        await this.CreateContainerAsync();
    }
    ```

## Create a database

Copy and paste the `CreateDatabaseAsync` method after the  `CosmosAsync` method. `CreateDatabaseAsync` creates a new database with ID `az204Database` if it doesn't already exist.

```csharp
private async Task CreateDatabaseAsync()
{
    // Create a new database using the cosmosClient
    this.database = await this.cosmosClient.CreateDatabaseIfNotExistsAsync(databaseId);
    Console.WriteLine("Created Database: {0}\n", this.database.Id);
}
 ```

## Create a container

Copy and paste the `CreateContainerAsync` method below the `CreateDatabaseAsync` method.

```csharp
private async Task CreateContainerAsync()
{
    // Create a new container
    this.container = await this.database.CreateContainerIfNotExistsAsync(containerId, "/LastName");
    Console.WriteLine("Created Container: {0}\n", this.container.Id);
}
```

## Run the application

1. Save your work and, in a terminal in Visual Studio Code, run the `dotnet build` command to check for any errors. If the build is successful run the `dotnet run` command. The console displays the following messages.

    ```
    Beginning operations...
    
    Created Database: az204Database
    
    Created Container: az204Container
    
    End of program, press any key to exit.
    ```

1. Verify the results by opening the Azure portal, navigating to your Azure Cosmos DB resource, and use the **Data Explorer** to view the database and container.

## Clean up Azure resources

You can now safely delete the *az204-cosmos-rg* resource group from your account by running the following command.

```
az group delete --name az204-cosmos-rg --no-wait
```

