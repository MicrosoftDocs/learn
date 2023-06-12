

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