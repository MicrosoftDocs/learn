In this unit, you create C# entity classes that will map to tables in a local SQLite database. The EF Core migrations feature produces tables from those entities.

A migration provides a way to incrementally update the database schema.

## Get the project files

To get started, get the project files. You have some options for how you get the project files:

- Use GitHub Codespaces
- Clone the GitHub repository

If you have a compatible container runtime installed, you also can use the [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension to open the repository in a container with the tools preinstalled.

### Use GitHub Codespaces

A codespace is an IDE that's hosted in the cloud. If you're using GitHub Codespaces, [go to the repository in your browser](https://github.com/MicrosoftDocs/mslearn-persist-data-ef-core). Select **Code**, and then create a new codespace in the `main` branch.

### Clone the GitHub repository

If you aren't using GitHub Codespaces, you can clone the project GitHub repo, and then open the files as a folder in Visual Studio Code.

1. Open a command terminal, and then clone the project from GitHub by using the command prompt:

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-persist-data-ef-core
    ```

1. Go to the *mslearn-persist-data-ef-core* folder, and then open the project in Visual Studio Code:

    ```bash
    cd mslearn-persist-data-ef-core
    code .
    ```

## Review the code

Now you have the project files to work with. See what's in the project, and review the code.

- The project, an ASP.NET Core web API, is located in the *ContosoPizza* directory. The file paths that are referred to in this module are relative to the *ContosoPizza* directory.
- *Services/PizzaService.cs* is a service class that defines create, read, update, and delete (CRUD) methods. All the methods currently throw `System.NotImplementedException`.
- In *Program.cs*, `PizzaService` is registered with the ASP.NET Core dependency injection system.
- *Controllers/PizzaController.cs* is a value for `ApiController` that exposes an endpoint for HTTP POST, GET, PUT, and DELETE verbs. These verbs call the corresponding CRUD methods on `PizzaService`. `PizzaService` is injected into the `PizzaController` constructor.
- The *Models* folder contains the models that are used by `PizzaService` and `PizzaController`.
- The entity models, *Pizza.cs*, *Topping.cs*, and *Sauce.cs*, have the following relationships:
  - A pizza can have one or more toppings.
  - A topping can be used on one or on many pizzas.
  - A pizza can have one sauce, but a sauce can be used on many pizzas.

## Build the app

To build the app in Visual Studio Code:

1. On the **Explorer** pane, right-click the *ContosoPizza* directory and select **Open in Integrated Terminal**.

    A terminal pane that is scoped to the *ContosoPizza* directory opens.

1. Build the app by using the following command:

    ```dotnetcli
    dotnet build
    ```

    The code should build with no warnings or errors.

## Add NuGet packages and EF Core tools

The database engine that you work with in this module is SQLite. SQLite is a lightweight, file-based database engine. It's a good choice for development and testing, and it's also a good choice for small-scale production deployments.

> [!NOTE]
> As mentioned earlier, database providers in EF Core are pluggable. SQLite is a good choice for this module because it's lightweight and cross-platform. You can use the same code to work with different database engines, such as SQL Server and PostgreSQL. You can even use multiple database engines in the same app.

Before you start, add the required packages:

1. On the terminal pane, run the following command:

    ```dotnetcli
    dotnet add package Microsoft.EntityFrameworkCore.Sqlite
    ```

    This command adds the NuGet package that contains the EF Core SQLite database provider and all its dependencies, including the common EF Core services.

1. Run this command:

    ```dotnetcli
    dotnet add package Microsoft.EntityFrameworkCore.Design
    ```

    This command adds packages that are required for the EF Core tools.

1. To finish, run this command:

    ```dotnetcli
    dotnet tool install --global dotnet-ef
    ```

    This command installs `dotnet ef`, the tool you'll use to create migrations and scaffolding.

   > [!TIP]
   > If `dotnet ef` is already installed, you can update it by running `dotnet tool update --global dotnet-ef`.

## Scaffold models and DbContext

Now you add and configure a `DbContext` implementation. `DbContext` is a gateway through which you can interact with the database.

1. Right-click the *ContosoPizza* directory and add a new folder called *Data*.
1. In the *Data* folder, create a new file named *PizzaContext.cs*. Add the following code to the empty file:

    ```csharp
    using Microsoft.EntityFrameworkCore;
    using ContosoPizza.Models;
    
    namespace ContosoPizza.Data;
    
    public class PizzaContext : DbContext
    {
        public PizzaContext (DbContextOptions<PizzaContext> options)
            : base(options)
        {
        }
    
        public DbSet<Pizza> Pizzas => Set<Pizza>();
        public DbSet<Topping> Toppings => Set<Topping>();
        public DbSet<Sauce> Sauces => Set<Sauce>();
    }
    ```

    In the preceding code:

    - The constructor accepts a parameter of type `DbContextOptions<PizzaContext>`. The constructor allows external code to pass in the configuration so that the same `DbContext` can be shared between test and production code, and even be used with different providers.
    - The `DbSet<T>` properties correspond to tables to create in the database.
    - The table names will match the `DbSet<T>` property names in the `PizzaContext` class. You can override this behavior if needed.
    - When instantiated, `PizzaContext` will expose `Pizzas`, `Toppings`, and `Sauces` properties. Changes you make to the collections that are exposed by those properties will be propagated to the database.

1. In *Program.cs*, replace `// Add the PizzaContext` with the following code:

    ```csharp
    builder.Services.AddSqlite<PizzaContext>("Data Source=ContosoPizza.db");
    ```

    The preceding code:

    - Registers `PizzaContext` with the ASP.NET Core dependency injection system.
    - Specifies that `PizzaContext` will use the SQLite database provider.
    - Defines a SQLite connection string that points to a local file, *ContosoPizza.db*.

   > [!NOTE]
   > SQLite uses local database files, so it's probably okay to hard-code the connection string. For network databases like PostgreSQL and SQL Server, you should always store your connection strings securely. For local development, use [Secret Manager](/aspnet/core/security/app-secrets). For production deployments, consider using a service like [Azure Key Vault](/aspnet/core/security/key-vault-configuration).

1. Also in *Program.cs*, replace `// Additional using declarations` with the following code.

    ```csharp
    using ContosoPizza.Data;
    ```

    This code resolves dependencies in the previous step.

1. Save all your changes. GitHub Codespaces saves your changes automatically.
1. Build the app in the terminal by running `dotnet build`. The build should succeed with no warnings or errors.

## Create and run a migration

Next, create a migration that you can use to create your initial database.

1. Run the following command to generate a migration for creating the database tables:

    ```dotnetcli
    dotnet ef migrations add InitialCreate --context PizzaContext
    ```

    In the preceding command:

    - The migration is given a name of *:::no-loc text="InitialCreate":::*.
    - The `--context` option specifies the name of the class in the *:::no-loc text="ContosoPizza":::* project, which derives from `DbContext`.

    A new *:::no-loc text="Migrations":::* directory appears in the *:::no-loc text="ContosoPizza":::* project root. The directory contains a *:::no-loc text="&lt;timestamp&gt;_InitialCreate.cs":::* file that describes the database changes to be translated to a Data Definition Language (DDL) change script.

1. Run the following command to apply the *:::no-loc text="InitialCreate":::* migration:

    ```dotnetcli
    dotnet ef database update --context PizzaContext
    ```

    This command applies the migration. *ContosoPizza.db* doesn't exist, so the migration is created in the project directory.

   > [!TIP]
   > The `dotnet ef` tool is supported on all platforms. In Visual Studio on Windows, you can use the `Add-Migration` and `Update-Database` PowerShell cmdlets in the integrated **Package Manager Console** window.

## Inspect the database

EF Core created a database for your app. Next, take a look inside the database by using the [SQLite extension](https://marketplace.visualstudio.com/items?itemName=alexcvzz.vscode-sqlite&azure-portal=true).

1. On the **Explorer** pane, right-click the *ContosoPizza.db* file and select **Open Database**.

    :::image type="content" source="../media/open-database.png" alt-text="Screenshot that shows the Open Database menu option in the Visual Studio Code Explorer pane.":::

    A **SQLite Explorer** folder appears on the **Explorer** pane.

    :::image type="content" source="../media/sqlite-pane.png" alt-text="Screenshot that shows the SQLite Explorer folder on the Explorer pane.":::

1. Select the **SQLite Explorer** folder to expand the node and all its child nodes. Right-click **ContosoPizza.db** and select **Show Table 'sqlite_master'** to view the full database schema and constraints that the migration created.

    :::image type="content" source="../media/sqlite-explorer.png" alt-text="Screenshot that shows the expanded SQLite Explorer folder on the Explorer pane.":::

    - Tables that correspond to each entity were created.
    - Table names were taken from the names of the `DbSet` properties on the `PizzaContext`.
    - Properties named `Id` were inferred to be autoincrementing primary key fields.
    - The EF Core primary key and foreign key constraint naming conventions are `PK_<primary key property>` and `FK_<dependent entity>_<principal entity>_<foreign key property>`, respectively. The `<dependent entity>` and `<principal entity>` placeholders correspond to the entity class names.

   > [!NOTE]
   > Like ASP.NET Core MVC, EF Core uses a *convention over configuration* approach. EF Core conventions shorten development time by inferring the developer's intent. For example, a property named `Id` or `<entity name>Id` is inferred to be the generated table's primary key. If you choose not to adopt the naming convention, the property must be annotated with the `[Key]` attribute or configured as a key in the `OnModelCreating` method of the `DbContext`.

## Change the model and update the database schema

Your manager at Contoso Pizza gives you some new requirements, so you have to change your entity models. In the following steps, you modify the models by using mapping attributes (sometimes called *data annotations*).

1. In *Models\Pizza.cs*, make the following changes:

    1. Add a `using` directive for `System.ComponentModel.DataAnnotations`.
    1. Add a `[Required]` attribute before the `Name` property to mark the property as required.
    1. Add a `[MaxLength(100)]` attribute before the `Name` property to specify a maximum string length of 100.

    ```csharp
    using System.ComponentModel.DataAnnotations;

    namespace ContosoPizza.Models;
    
    public class Pizza
    {
        public int Id { get; set; }
    
        [Required]
        [MaxLength(100)]
        public string? Name { get; set; }

        public Sauce? Sauce { get; set; }

        public ICollection<Topping>? Toppings { get; set; }
    }
    ```

1. In *Models\Sauce.cs*, make the following changes:

    1. Add a `using` directive for `System.ComponentModel.DataAnnotations`.
    1. Add a `[Required]` attribute before the `Name` property to mark the property as required.
    1. Add a `[MaxLength(100)]` attribute before the `Name` property to specify a maximum string length of 100.
    1. Add a `bool` property named `IsVegan`.

    ```csharp
    using System.ComponentModel.DataAnnotations;
    
    namespace ContosoPizza.Models;
    
    public class Sauce
    {
        public int Id { get; set; }
    
        [Required]
        [MaxLength(100)]
        public string? Name { get; set; }

        public bool IsVegan { get; set; }
    }
    ```

1. In *Models\Topping.cs*, make the following changes:

    1. Add `using` directives for `System.ComponentModel.DataAnnotations` and `System.Text.Json.Serialization`.
    1. Add a `[Required]` attribute before the `Name` property to mark the property as required.
    1. Add a `[MaxLength(100)]` attribute before the `Name` property to specify a maximum string length of 100.
    1. Add a `decimal` property named `Calories` immediately after the `Name` property.
    1. Add a `Pizzas` property of type  `ICollection<Pizza>?` to make `Pizza`-`Topping` a many-to-many relationship.
    1. Add a `[JsonIgnore]` attribute to the `Pizzas` property.

   > [!IMPORTANT]
   > These steps prevent `Topping` entities from including the `Pizzas` property when the web API code serializes the response to JSON. Without this change, a serialized collection of toppings would include a collection of every pizza that uses the topping. Each pizza in *that* collection would contain a collection of toppings, which each would again contain a collection of pizzas. This type of infinite loop is called a *circular reference* and can't be serialized.

    ```csharp
    using System.ComponentModel.DataAnnotations;
    using System.Text.Json.Serialization;
    
    namespace ContosoPizza.Models;
    
    public class Topping
    {
        public int Id { get; set; }
    
        [Required]
        [MaxLength(100)]
        public string? Name { get; set; }

        public decimal Calories { get; set; }

        [JsonIgnore]
        public ICollection<Pizza>? Pizzas { get; set; }
    }
    ```

1. Save all your changes and run `dotnet build`.

1. Run the following command to generate a migration for creating the database tables:

    ```dotnetcli
    dotnet ef migrations add ModelRevisions --context PizzaContext
    ```

    A migration named *:::no-loc text="ModelRevisions":::* is created.

   > [!NOTE]
   > This message appears: *An operation was scaffolded that may result in the loss of data. Please review the migration for accuracy*. The message appears because you changed the relationship from `Pizza` to `Topping` from one-to-many to many-to-many, which requires that an existing foreign key column is dropped. Because you don't yet have any data in your database, this change isn't problematic. However, in general, it's a good idea to check the generated migration when this warning appears to make sure that no data is deleted or truncated by the migration.

1. Run the following command to apply the *:::no-loc text="ModelRevisions":::* migration:

    ```dotnetcli
    dotnet ef database update --context PizzaContext
    ```

1. On the title bar of the **SQLite Explorer** folder, select the **Refresh Databases** button.

    :::image type="content" source="../media/refresh-database.png" alt-text="Screenshot that shows the Refresh Databases button on the title bar of SQLite Explorer.":::

1. In the **SQLite Explorer** folder, right-click **ContosoPizza.db**. Select **Show Table 'sqlite_master'** to view the full database schema and constraints.

   > [!IMPORTANT]
   > The SQLite extension reuses open **SQLite** tabs.

    - A `PizzaTopping` join table was created to represent the many-to-many relationship between pizzas and toppings.
    - New fields have been added to `Toppings` and `Sauces`.
        - `Calories` is defined as a `text` column because SQLite doesn't have a matching `decimal` type.
        - Similarly, `IsVegan` is defined as an `integer` column. SQLite doesn't define a `bool` type.
        - In both cases, EF Core manages the translation.
    - The `Name` column in each table has been marked `not null`, but SQLite doesn't have a `MaxLength` constraint.

   > [!TIP]
   > EF Core database providers map a model schema to the features of a specific database. Although SQLite doesn't implement a corresponding constraint for `MaxLength`, other databases like SQL Server and PostgreSQL do.

1. In the **SQLite Explorer** folder, right-click the `_EFMigrationsHistory` table and select **Show Table**. The table contains a list of all migrations that are applied to the database. Because you've run two migrations, there are two entries: one for the *InitialCreate* migration, and another for *ModelRevisions*.

> [!NOTE]
> This exercise used mapping attributes (data annotations) to map models to the database. As an alternative to mapping attributes, you can use the [ModelBuilder fluent API](/ef/core/modeling/#use-fluent-api-to-configure-a-model) to configure models. Both approaches are valid, but some developers prefer one approach over the other.

You've used migrations to define and update a database schema. In the next unit, you'll finish the methods in `PizzaService` that manipulate data.
