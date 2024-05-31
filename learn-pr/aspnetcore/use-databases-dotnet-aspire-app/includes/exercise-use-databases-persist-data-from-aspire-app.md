In this exercise, you replace the current data stores for your company's in-development cloud-native app. At the moment, the app uses a locally stored SQLite database for catalog data and an in-memory Redis cache for customer's shopping baskets. You replace the existing data stores with PostgreSQL and MongoDB.

## Install prerequisites

The prerequisites for .NET Aspire are:

- .NET 8
- Visual Studio 2022 Preview
- Docker Desktop or Podman
- .NET Aspire workload in Visual Studio

If you already have the prerequisites installed, you can skip ahead to cloning the existing app.

### Install .NET 8

Follow this [.NET 8](https://dotnet.microsoft.com/download/dotnet/8.0) link, and select the correct installer for your operating system. For example, if you're using Windows 11, and a modern processor, select the x64 .NET 8 SDK for Windows.

After the download is complete, run the installer and follow the instructions. In a terminal window, run the following command to verify that the installation was successful:

```powershell
dotnet --version
```

You should see the version number of the .NET SDK you installed. For example:

```console
8.0.300-preview.24203.14
```

### Install Visual Studio 2022 Preview

Follow this [Visual Studio 2022 Preview](https://visualstudio.microsoft.com/vs/preview/) link, and select **Download Preview**. After the download is complete, run the installer and follow the instructions.

### Install Docker Desktop

Follow this [Docker Desktop](https://www.docker.com/products/docker-desktop/) link, and select the correct installer for your operating system. After the download is complete, run the installer and follow the instructions.

Open the Docker Desktop application and accept the service agreement.

### Install the .NET Aspire workload in Visual Studio

Install the .NET Aspire workload using the .NET CLI:

1. Open a terminal.
1. Install the .NET Aspire workloads with these commands:

    ```dotnetcli
    dotnet workload update
    dotnet workload install aspire
    dotnet workload list
    ```

    You should see the details of the .NET Aspire workload.

    ```console
	Installed Workload Id      Manifest Version      Installation Source
    ---------------------------------------------------------------------------------------------
    aspire                     8.0.0/8.0.100         SDK 8.0.300-preview.24203, VS 17.10.34902.84

    Use `dotnet workload search` to find additional workloads to install.
    ```

## Clone and modify the Northern Mountains app

Let's use `git` to obtain the current Northern Mountains app:

1. In the command line, browse to a folder of your choice where you can work with code.
1. Execute the following command to clone the **Northern Mountains eShop** sample application:

    ```console
    git clone -b aspire-databases https://github.com/MicrosoftDocs/mslearn-aspire-starter
    ```

1. Start Visual Studio and then select **Open a project or solution**.
1. Browse to the folder where you cloned the eShop, open the _start_ folder and select the _eShop.databases.sln_ file, and then select **Open**.
1. In **Solution Explorer**, expand the **eShop.AppHost** project,  then open _Program.cs_.

    ```csharp
    // Databases
    
    var basketStore = builder.AddRedis("BasketStore").WithRedisCommander();
    
    // Identity Providers
    
    var idp = builder.AddKeycloakContainer("idp", tag: "23.0")
        .ImportRealms("../Keycloak/data/import");
    
    // DB Manager Apps
    
    builder.AddProject<Projects.Catalog_Data_Manager>("catalog-db-mgr");
    
    // API Apps
    
    var catalogApi = builder.AddProject<Projects.Catalog_API>("catalog-api");
    
    var basketApi = builder.AddProject<Projects.Basket_API>("basket-api")
            .WithReference(basketStore)
            .WithReference(idp);
    
    // Apps
    
    // Force HTTPS profile for web app (required for OIDC operations)
    var webApp = builder.AddProject<Projects.WebApp>("webapp")
        .WithReference(catalogApi)
        .WithReference(basketApi)
        .WithReference(idp, env: "Identity__ClientSecret");
    ```
  
    The previous code shows the current configuration for the app. The app uses a Redis cache for the basket store.

1. Explore the rest of the app, focus on the **Catalog.Data.Manager** and **Catalog.API** projects, and see how they use a locally stored SQLite database.
1. To start the app, press <kbd>F5</kbd> or select **Debug > Start Debugging**.
1. If the **Start Docker Desktop** dialog appears, select **Yes**.
1. When the eShop .NET Aspire dashboard appears, for the **webapp** resource, select the secure endpoint:

    :::image type="content" source="../media/eshop-dashboard.png" alt-text="A screenshot of the eShop .NET Aspire dashboard. The webapp endpoint is highlighted." lightbox="../media/eshop-dashboard.png":::
  
1. The app opens in a browser. You can explore the app and see how it works.

    :::image type="content" source="../media/eshop-home-page.png" alt-text="A screenshot of the eShop home page.":::

    The test user credentials are **test@example.com** and **P@$$w0rd1**.

1. To stop debugging, press <kbd>Shift</kbd>+<kbd>F5</kbd>, or select **Debug > Stop Debugging**.

## Add a .NET Aspire PostgreSQL component

The team responsible for the catalog microservices built the app to use a locally stored SQLite database. This approach is fine for development, but the team wants to use a more robust database for production.

Two projects connect to the SQLite database, the **Catalog.Data.Manager** and **Catalog.API** projects. The data manager is only used to seed the database with data, so you should focus on the **Catalog.API** project.

1. In **Solution Explorer**, right-click the **Catalog.API** project, select **Add** > **.NET Aspire package**.
1. In the **Search** box, add **Npgsql.EntityFramework** to the end, and press <kbd>Enter</kbd>.
1. On the left, in the results, select **Aspire.Npgsql.EntityFrameworkCore.PostgreSQL**.
1. On the right, select the version dropdown and then select the latest **8.0.0** release.
1. Select **Install**.
1. If the **Preview Changes** dialog appears, select **Apply**.
1. In the **License Acceptance** dialog, select **I Accept**.
1. In **Solution Explorer**, select the **Catalog.API** project to view the content of the *Catalog.API.csproj* file.
1. Delete the `PackageReference` for **Microsoft.EntityFrameworkCore.Sqlite**:

    ```xml
    <PackageReference Include="Microsoft.EntityFrameworkCore.Sqlite" Version="8.0.3" />
    ```

## Register the new PostgreSQL DbContext

1. In **Solution Explorer**, expand the **Catalog.API** project, and then open the _Program.cs_ file.
1. Replace the SQLite DbContext:

    ```csharp
    builder.Services.AddDbContext<CatalogDbContext>(
	    options => options.UseSqlite(builder.Configuration.GetConnectionString("sqlconnection")
		    ?? throw new InvalidOperationException(
			    "Connection string 'sqlconnection' not found.")));
    ```

    With the new PostgreSQL DbContext:

    ```csharp
    builder.AddNpgsqlDbContext<CatalogDbContext>("CatalogDB");
    ```

    The app no longer needs to read the _Database.db_ file, so remove the associated strings in _appsettings.json_.

1. In **Solution Explorer**, under **Catalog.API**, select _appsettings.json_.
1. Delete the `ConnectionStrings` entries, the file now looks like this:

    ```json
    {
      "Logging": {
        "LogLevel": {
          "Default": "Information",
          "Microsoft.AspNetCore": "Warning"
        }
      },
      "OpenApi": {
        "Endpoint": {
          "Name": "Catalog.API v1"
        },
        "Document": {
          "Description": "The Catalog Microservice HTTP API. This is a Data-Driven/CRUD microservice sample",
          "Title": "eShop - Catalog HTTP API",
          "Version": "v1"
        }
      },
      "CatalogOptions": {
        "PicBasePathFormat": "items/{0}/pic/"
      }
    }

    ```

1. Right-click the **Catalog.Data.Manager** project, and then select **Remove**.
1. In the dialog, select **OK**.

The database team creates a PostgreSQL database backup for you to use to create and seed the catalog database. You can view the backup in the *Catalog.API/Seed* folder.

### Seed the PostgreSQL database using a bound volume

The **AppHost** project can create a PostgreSQL database container, seed it with data from a bound volume, and then through dependency injection pass references to the **Catalog.API**.

1. In **Solution Explorer**, right-click the **eShop.AppHost** project, select **Add** > **.NET Aspire package**.
1. In the **Search** box, add **PostgreSQL** to the end, and press <kbd>Enter</kbd>.
1. On the left, in the results, select **Aspire.Hosting.PostgreSQL**.
1. On the right, select the version dropdown and then select the latest **8.0.0** release.
1. Select **Install**.
1. If the **Preview Changes** dialog appears, select **Apply**.
1. In the **License Acceptance** dialog, select **I Accept**.
1. In **Solution Explorer**, expand the **eShop.AppHost** project, and then open the _Program.cs_ file.
1. Under the `//Databases` comment, add the following code:

    ```csharp
    // Databases

    var basketStore = builder.AddRedis("BasketStore").WithRedisCommander();
    var postgres = builder.AddPostgres("postgres")
        .WithEnvironment("POSTGRES_DB", "CatalogDB")
        .WithBindMount("../Catalog.API/Seed", "/docker-entrypoint-initdb.d").WithPgAdmin();
    var catalogDB = postgres.AddDatabase("CatalogDB");
    ```

    The previous code creates a PostgreSQL database container, adds a database named **CatalogDB**, and binds the **/docker-entrypoint-initdb.d** directory to the **../Catalog.API/Seed** directory. The code also creates a container for the pgAdmin tool that lets you manage the PostgreSQL database.

1. Pass the `catalogDB` reference to the **Catalog.API** project by adding `.WithReference(catalogDB)`, the code is now:

    ```csharp
    // API Apps
    
    var catalogApi = builder.AddProject<Projects.Catalog_API>("catalog-api")
      .WithReference(catalogDB); 
    ```

1. The **Catalog.Data.Manager** project is no longer needed, so remove the project from the **AppHost**. Delete this code:

    ```csharp
    // DB Manager Apps

    builder.AddProject<Projects.Catalog_Data_Manager>("catalog-db-mgr");
    ```

### Test the app

Using .NET Aspire allowed your team to remove a whole project. Also, the catalog API only needs a single line of code to add the PostgresSQL database context. Dependency injection and service discovery from the AppHost mean no other code changes are needed to allow the API to connect to the new database.

1. Compile and start the app, press <kbd>F5</kbd>, or select **Debug > Start Debugging**.

    :::image type="content" source="../media/postgres-dashboard.png" alt-text="A screenshot showing the updated .NET Aspire dashboard, with the two new PostgreSQL containers highlighted." lightbox="../media/postgres-dashboard.png":::

    There are two new containers in the dashboard that host the PostgreSQL database server and pgAdmin tool. There's also a PostgreSQL database resource that hosts the CatalogDB database.

1. Use **pgAdmin** to connect to the PostgreSQL database and explore the data. Select the **postgres pgadmin** endpoint.

    :::image type="content" source="../media/postgres-navigation.png" alt-text="A screenshot of the pgAdmin interface, highlighting the navigation to the Catalog table."  lightbox="../media/postgres-navigation.png":::

1. Expand **Aspire instances** > **postgres** > **Databases** > **CatalogDB** > **Schemas** > **catalog** > **Tables**. Then right-click the **Catalog** table, and select **View/Edit Data** > **First 100 Rows**.
1. You can see the data loaded by the **AppHost**.

    :::image type="content" source="../media/catalog-table.png" alt-text="A screenshot of the pgAdmin interface, showing the returned rows from the Catalog table."  lightbox="../media/catalog-table.png":::

1. Select the **eShop resources** dashboard tab in your browser, then select the **webapp** endpoint.
1. The app opens and works as before.
1. To stop debugging, press <kbd>Shift</kbd>+<kbd>F5</kbd>, or select **Debug > Stop Debugging**.

## Add the .NET Aspire MongoDB component to the app

The current app uses Redis as an in-memory data store for a customer's shopping basket. The team wants to use a more robust and durable data store for the basket. Replace the Redis cache with a MongoDB database.

### Change the Basket.API to use MongoDB

1. In **Solution Explorer**, right-click the **Basket.API** project, select **Add**, and then select **Add**>**.NET Aspire package**.
1. In the **Search** box, enter **MongoDB** at the end, and press <kbd>Enter</kbd>.
1. Select the **Aspire.MongoDB.Driver**, and then select the latest **8.0.0** version.
1. Select **Install**.
1. If the **Preview Changes** dialog appears, select **Apply**.
1. In the **License Acceptance** dialog, select **I Accept**.@

### Create a MongoDB basket store

The basket microservice uses `HostingExtensions` to manage the Redis data store. Replace the Redis data store with a MongoDB data store.

1. In **Solution Explorer**, expand the **Basket.API** project, then the **Storage** folder, and then select the *RedisBasketStore.cs* file.

    There are two asynchronous methods, `GetBasketAsync` and `UpdateBasketAsync`, that use the Redis cache. Lets create MongoDB versions of these methods.

1. In **Solution Explorer**, right-click the **Storage** folder, and then select **Add** > **Class**.
1. In the **Add New Item** dialog, name the file _MongoBasketStore.cs_, and then select **Add**.
1. Replace the code in the _MongoBasketStore.cs_ file with the following code:

    ```csharp
    using eShop.Basket.API.Models;
    using MongoDB.Driver;
    using MongoDB.Driver.Linq;
    
    namespace eShop.Basket.API.Storage;
    
    public class MongoBasketStore
    {
      private readonly IMongoCollection<CustomerBasket> _basketCollection;
    
      public MongoBasketStore(IMongoClient mongoClient)
      {
        // The database name needs to match the created database in the AppHost
        _basketCollection = mongoClient.GetDatabase("BasketDB").GetCollection<CustomerBasket>("basketitems");
      }
    
      public async Task<CustomerBasket?> GetBasketAsync(string customerId)
      {
        var filter = Builders<CustomerBasket>.Filter.Eq(r => r.BuyerId, customerId);
    
        return await _basketCollection.Find(filter).FirstOrDefaultAsync();
      }
    
      public async Task<CustomerBasket?> UpdateBasketAsync(CustomerBasket basket)
      {
        var filter = Builders<CustomerBasket>.Filter.Eq(r => r.BuyerId, basket.BuyerId);
    
        var result = await _basketCollection.ReplaceOneAsync(filter, basket, new ReplaceOptions { IsUpsert = true });
    
        return result.IsModifiedCountAvailable ? basket : null;
      }
    }
    ```

    The previous code creates a `MongoBasketStore` class that works with the `CustomerBasket` model. The collection handles the CRUD operations for the customers shopping baskets in a MongoDB database.

1. In **Solution Explorer**, expand the **Basket.API** > **Extensions** , and then select the _HostingExtensions.cs_ file.
1. Replace the Redis code:

    ```csharp
    builder.AddRedis("BasketStore");

    builder.Services.AddSingleton<RedisBasketStore>();
    ```

    With the MongoDB code:

    ```csharp
    builder.AddMongoDBClient("BasketDB");

    builder.Services.AddSingleton<MongoBasketStore>();
    ```

1. In **Solution Explorer**, expand the **Grpc** folder, and then open the _BasketService.cs_ file.
1. Change the class to accept a `MongoBasketStore`, replace:

    ```csharp
    public class BasketService(RedisBasketStore basketStore) : Basket.BasketBase
    ```

    With:

    ```csharp
    public class BasketService(MongoBasketStore basketStore) : Basket.BasketBase
    ```

### Add a MongoDB database to the AppHost

1. In **Solution Explorer**, right-click the **eShop.AppHost** project, and select **Add** > **.NET Aspire package**.
1. In the **Search** box, enter **MongoDB** at the end, and press <kbd>Enter</kbd>.
1. Select the **Aspire.Hosting.MongoDB** package, and then select the latest **8.0.0** version.
1. Select **Install**.
1. If the **Preview Changes** dialog appears, select **Apply**.
1. In the **License Acceptance** dialog, select **I Accept**.@
1. In **Solution Explorer**, expand the **eShop.AppHost** project, and then open the _Program.cs_ file.
1. In the Databases section, add a MongoDB component:

    ```csharp
    var mongo = builder.AddMongoDB("mongo")
      .WithMongoExpress()
      .AddDatabase("BasketDB");
    ```

    The previous code creates a MongoDB database container, adds a database named **BasketDB**. The code also creates a container for the Mongo Express tool that lets you manage the MongoDB database.

1. Delete the Redis container:

    ```csharp
    var basketStore = builder.AddRedis("BasketStore").WithRedisCommander();
    ```

    The code should now look like this:

    ```csharp
    // Databases

    var postgres = builder.AddPostgres("postgres")
        .WithEnvironment("POSTGRES_DB", "CatalogDB")
        .WithBindMount("../Catalog.API/Seed", "/docker-entrypoint-initdb.d")
        .WithPgAdmin();
    var catalogDB = postgres.AddDatabase("CatalogDB");

    var mongo = builder.AddMongoDB("mongo")
        .WithMongoExpress()
        .AddDatabase("BasketDB");
    ```

1. The Basket.API project needs a reference to the new MongoDB database, and you should remove the Redis reference:

    ```csharp
    var basketApi = builder.AddProject<Projects.Basket_API>("basket-api")
            .WithReference(mongo)
            .WithReference(idp);
    ```

The **Basket.API** project is now ready to use the MongoDB database. Let's test the app to see if it works.

## Test the app

1. Compile and start the app, press <kbd>F5</kbd>, or select **Debug > Start Debugging**.

    :::image type="content" source="../media/mongodb-dashboard.png" alt-text="A screenshot of the .NET Aspire dashboard, with the MongoDB containers highlighted.":::

    You can see the new MongoDB containers, one for the database server the other for Mongo Express, in the dashboard. There's also a new **MongoDBDatabase** resource that hosts the **BasketDB** database.

1. Select the **webapp** endpoint.
1. To sign in with the test user credentials, select the user icon in the top right. The email is **test@example.com** and the password is **P@$$w0rd1**.
1. Select the **Adventurer GPS Watch** from the home page.
1. Select **Add to shopping bag**, you should see an exception:

    :::image type="content" source="../media/r-p-c-exception.png" alt-text="A screenshot showing the RpcException.":::

### Debug the app

The app is throwing an exception when you try to add an item to the shopping basket. You can use the dashboard to help debug the issue.

1. Select the **eShop resources** dashboard tab in your browser.

    :::image type="content" source="../media/basket-api-errors.png" alt-text="A screenshot of the dashboard, errors in the Basket.API and webapp are highlighted."  lightbox="../media/basket-api-errors.png":::

    The dashboard shows errors in the **basket-api** and **webapp**. Review the logs for the **basket-api**.

1. For the **basket-api** resource, in the **Logs** column, select **View**.

    :::image type="content" source="../media/basket-api-logs.png" alt-text="A screenshot of the logs for the basket-api service."  lightbox="../media/basket-api-logs.png":::

    There's an exception:

    ```console
    System.FormatException: Element '_id' does not match any field or property of class eShop.Basket.API.Models.CustomerBasket.
    ```

1. Select the **Resources** menu item, then select the **mongo-mongoexpress** endpoint.
1. In the **Databases** section, next to **BasketDB**, select **View**.
1. In **Collections**, next to **basketitems**, select **View**.

    :::image type="content" source="../media/mongo-express-basketitems.png" alt-text="A screenshot of Mongo Express, showing the data stored in the basketitems collection."  lightbox="../media/mongo-express-basketitems.png":::

    Documents stored in a MongoDB have an **_id** field. Every document stored in a MongoDB collection must have a unique **_id** field.

1. To stop debugging, press <kbd>Shift</kbd>+<kbd>F5</kbd>, or select **Debug > Stop Debugging**.

### Review the code and fix the issue

Let's look at the **CustomerBasket**, and see if we can find the issue.

1. In **Solution Explorer**, expand the **Basket.API** > **Models** folder, and then open the _CustomerBasket.cs_ file.

    ```csharp
    public class CustomerBasket
    {
        public required string BuyerId { get; set; }
    
        public List<BasketItem> Items { get; set; } = [];
    }
    ```

    The **CustomerBasket** model doesn't have a field or property that matches the **_id** field. Entity framework is trying to map the **_id** field to the **CustomerBasket** model, and it can't find a match.

1. Update the `CustomerBasket` model to include an **_id** field:

    ```csharp
    public class CustomerBasket
    {
        /// <summary>
        /// MongoDB document identifier
        /// </summary>
        public string _id { get; set; } = "";

        public required string BuyerId { get; set; }
    
        public List<BasketItem> Items { get; set; } = [];
    }
    ```

## Test the fixed app

1. To compile and start the app, press <kbd>F5</kbd>, or select **Debug > Start Debugging**.

1. For the **webapp**, in the **Endpoints** column, right-click the URL, then select **Open link in InPrivate Window**.

    Using an InPrivate window ensures that the browser doesn't use the previous session cookie for authentication.

1. To sign in with the test user credentials, select the user icon in the top right. The email is **test@example.com** and the password is **P@$$w0rd1**.
1. Select the **Adventurer GPS Watch** from the home page.
1. Select **Add to shopping bag**.

    :::image type="content" source="../media/shopping-basket-success.png" alt-text="A screenshot of the eShop shopping basket working."  lightbox="../media/shopping-basket-success.png":::

    The Northern Mountains app basket functionality is now working.

You successfully replaced the SQLite database with a PostgreSQL database and the Redis cache with a MongoDB database. You used .NET Aspire to manage the databases and explore the data in them, and you used the dashboard to help debug an issue with the app.
