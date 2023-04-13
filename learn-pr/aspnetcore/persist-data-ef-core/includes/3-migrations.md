In this unit, you'll create C# entity classes that will map to tables in a local SQLite database. EF migrations will produce tables from those entities. Migrations provide a way to incrementally update the database schema.

> [!NOTE]
> This module uses the [.NET CLI (Command Line Interface)](/dotnet/core/tools/) and [Visual Studio Code](https://code.visualstudio.com) for local development. After completing this module, you can apply its concepts using a development environment like Visual Studio (Windows), Visual Studio for Mac (macOS), or continued development using Visual Studio Code (Windows, Linux, & macOS).

[!include[](../../../includes/dotnet6-sdk-version.md)]

## Get the starter code

1. From a terminal, run the following command to clone the starter code repository:

    ```cmd
    git clone https://github.com/MicrosoftDocs/mslearn-persist-data-ef-core
    ```

    The preceding command creates a local copy of the starter code repository. The app manages pizzas, their toppings, and their sauces.

1. Switch to the `ContosoPizza` directory in the repository you cloned and open it in Visual Studio Code.

    ```cmd
    cd mslearn-persist-data-ef-core\ContosoPizza
    code .
    ```

    > [!NOTE]
    > If you get a message to update dependencies, select **Yes**.

1. Review the code:

    - The project is an ASP.NET Core web API.
    - *Services/PizzaService.cs* is a service class that defines CRUD (**C**reate, **R**ead, **U**pdate, **D**elete) methods. All the methods currently throw `System.NotImplementedException`.
    - In *Program.cs*, `PizzaService` is registered with ASP.NET Core's dependency injection system.
    - *Controllers/PizzaController.cs* is an `ApiController` that exposes an endpoint for HTTP **POST**, **GET**, **PUT**, and **DELETE** verbs. These verbs call the corresponding CRUD methods on `PizzaService`. `PizzaService` is injected into `PizzaController`'s constructor.
    - The *Models* folder contains the models used by `PizzaService` and `PizzaController`.
    - The entity models, *Pizza.cs*, *Topping.cs*, and *Sauce.cs*, have the following relationships:
        - A pizza may have one or more toppings.
        - A topping may be used on one or many pizzas.
        - A pizza may have one sauce, but a sauce may be used on many pizzas.

1. Open a Visual Studio Code terminal (<kbd>Ctrl</kbd>+<kbd>`</kbd>). Build the app with the following command:

    ```dotnetcli
    dotnet build
    ```

    The code should build with no warnings or errors.

## Add NuGet packages and EF Core tools

Before you start, you need to add the required packages.

1. From the terminal, run the following command:

    ```dotnetcli
    dotnet add package Microsoft.EntityFrameworkCore.Sqlite
    ```

    This command adds the NuGet package that contains the EF Core SQLite database provider and all its dependencies, including the common EF Core services.

1. From the terminal, run the following command:

    ```dotnetcli
    dotnet add package Microsoft.EntityFrameworkCore.Design
    ```

    This command adds packages required for the EF Core tools.

1. From the terminal, run the following command:

    ```dotnetcli
    dotnet tool install --global dotnet-ef
    ```

    This command installs `dotnet ef`, the tool you'll use to create migrations and scaffolding.

    > [!TIP]
    > If `dotnet ef` is already installed, you can update it with `dotnet tool update --global dotnet-ef`.

## Wire up models and DbContext

Now, you'll add and configure a `DbContext` implementation, which will serve as the gateway through which you'll interact with the database.

1. In the project root directory, add a new folder called *Data*.
1. In *Data* directory, create a new file named *PizzaContext.cs*. Add the following code to the empty file:

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

    - The constructor accepts a parameter of type `DbContextOptions<PizzaContext>`. This allows external code to pass in the configuration, so the same `DbContext` can be shared between test and production code and even used with different providers.
    - The `DbSet<T>` properties correspond to tables to be created in the database.
    - The table names will match the `DbSet<T>` property names in the `PizzaContext` class. This behavior can be overridden if needed.
    - When instantiated, `PizzaContext` will expose `Pizzas`, `Toppings`, and `Sauces` properties. Changes you make to the collections exposed by those properties will be propagated to the database.

1. In *Program.cs*, replace `// Add the PizzaContext` with the following code:

    ```csharp
    builder.Services.AddSqlite<PizzaContext>("Data Source=ContosoPizza.db");
    ```

    The preceding code:

    - Registers `PizzaContext` with ASP.NET Core's dependency injection system.
    - Specifies that `PizzaContext` will use the SQLite database provider.
    - Defines a SQLite connection string that points to a local file, *ContosoPizza.db*.

    > [!NOTE]
    > For SQLite, which uses local database files, it's probably okay to hardcode the connection string like this. However, for network databases like PostgreSQL or SQL Server, you should always store your connection strings securely. For local development, use [Secret Manager](/aspnet/core/security/app-secrets). For production deployments, consider a service like [Azure Key Vault](/aspnet/core/security/key-vault-configuration).

1. Also in *Program.cs*, replace `// Additional using declarations` with the following code.

    ```csharp
    using ContosoPizza.Data;
    ```

    The preceding code resolves dependencies in the previous step.

1. Save all your changes and build the app.

## Create and run a migration

You've done all you need to create a migration for creating your initial database.

1. Run the following command to generate a migration for creating the database tables:

    ```dotnetcli
    dotnet ef migrations add InitialCreate --context PizzaContext
    ```

    In the preceding command:

    - The migration is given a name of *:::no-loc text="InitialCreate":::*.
    - The `--context` option specifies the name of the class in the *:::no-loc text="ContosoPizza":::* project, which derives from `DbContext`.

    A new *:::no-loc text="Migrations":::* directory appears in the *:::no-loc text="ContosoPizza":::* project root. The directory contains a *:::no-loc text="&lt;timestamp&gt;_InitialCreate.cs":::* file describing database changes to be translated to a Data Definition Language (DDL) change script.

1. Run the following command to apply the *:::no-loc text="InitialCreate":::* migration:

    ```dotnetcli
    dotnet ef database update --context PizzaContext
    ```

    Executing the preceding command applies the migration. Since *ContosoPizza.db* doesn't exist, it's created in the project directory.

    > [!TIP]
    > The `dotnet ef` tool is supported on all platforms. In Visual Studio on Windows, it's also possible to use the `Add-Migration` and `Update-Database` PowerShell cmdlets in the integrated **Package Manager Console** window.

## Inspect the database

EF Core created a database for your app. Let's take a look inside the database.

1. In Visual Studio Code, press <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>X</kbd> to open the **Extensions** tab.
1. In the search box, search for `vscode-sqlite`. A community-provided SQLite extension is displayed.
1. Install the extension, if needed.
1. Press <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>E</kbd> to return to the **Explorer** tab.
1. Right-click on the *ContosoPizza.db* file. Select **Open Database**.

    :::image type="content" source="../media/open-database.png" alt-text="The Open Database menu option":::

    A **SQLITE EXPLORER** pane opens on the **Explorer** tab.

    :::image type="content" source="../media/sqlite-pane.png" alt-text="The SQLite pane (collapsed)":::

1. Expand the **SQLITE EXPLORER** pane and all its child nodes. Right-click **ContosoPizza.db**. Select **Show Table 'sqlite_master'** to view the full database schema and constraints.

    :::image type="content" source="../media/sqlite-explorer.png" alt-text="The SQLite Explorer pane":::

    - Tables have been created corresponding to each entity.
    - Table names were taken from the names of the `DbSet` properties on the `PizzaContext`.
    - Properties named `Id` were inferred to be auto-incrementing primary key fields.
    - EF Core's primary key and foreign key constraint naming conventions are `PK_<Primary key property>` and `FK_<Dependent entity>_<Principal entity>_<Foreign key property>`, respectively. The `<Dependent entity>` and `<Principal entity>` placeholders correspond to the entity class names.

    > [!NOTE]
    > As is true with ASP.NET Core MVC, EF Core adopts a *convention over configuration* philosophy. EF Core conventions shorten development time by inferring the developer's intent. For example, a property named `Id` or `<entity name>Id` is inferred to be the generated table's primary key. If you choose not to adopt the naming convention, the property must be annotated with the `[Key]` attribute or configured as a key in the `OnModelCreating` method of the `DbContext`.

## Change the model and update the database schema

Your manager at Contoso Pizza has given you some new requirements that force you to change your entity models. In the following steps, you're going to modify the models using mapping attributes, sometimes also called "data annotations".

> [!TIP]
> Instead of mapping attributes, you can use [the `ModelBuilder` fluent API](/ef/core/modeling/#use-fluent-api-to-configure-a-model) to configure how your models are mapped to the database.

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

        > [!NOTE]
        > This is to prevent `Topping` entities from including the `Pizzas` property when the web API code serializes the response to JSON. Without this, a serialized collection of toppings would include a collection of every pizza that uses the topping. Each pizza in *that* collection would contain a collection of toppings, which each would again contain a collection of pizzas. This type of infinite loop is called a *circular reference* and can't be serialized.

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

1. Save all your changes and build.

1. Run the following command to generate a migration for creating the database tables:

    ```dotnetcli
    dotnet ef migrations add ModelRevisions --context PizzaContext
    ```

    A migration named *:::no-loc text="ModelRevisions":::* is created.

    > [!NOTE]
    > The message "An operation was scaffolded that may result in the loss of data. Please review the migration for accuracy." is displayed. This is because we have changed the relationship from `Pizza` to `Topping` from one-to-many to many-to-many, which requires that an existing foreign key column is dropped. This is OK because we don't yet have any data in our database. However, in general it's a good idea to check the generated migration when this warning is displayed to make sure no data is deleted or truncated by the migration.

1. Run the following command to apply the *:::no-loc text="ModelRevisions":::* migration:

    ```dotnetcli
    dotnet ef database update --context PizzaContext
    ```

1. In the title bar of the **SQLITE EXPLORER** pane, select the **Refresh Databases** button.

    :::image type="content" source="../media/refresh-database.png" alt-text="The Refresh Database button in the SQLite Explorer tab.":::

1. In the **SQLITE EXPLORER** pane, right-click **ContosoPizza.db**. Select **Show Table 'sqlite_master'** to view the full database schema and constraints.

    > [!IMPORTANT]
    > The SQLite extension will re-use open **SQLite** tabs.

    - A `PizzaTopping` join table was created to represent the many-to-many relationship between pizzas and toppings.
    - New fields have been added to the `Toppings` and `Sauces`.
        - `Calories` is defined as a `TEXT` column because SQLite doesn't have a matching `decimal` type.
        - Similarly, `IsVegan` is defined as an `INTEGER` column. SQLite doesn't define a `bool` type.
        - In both cases, EF Core manages the translation.
    - The `Name` column in each table has been marked `NOT NULL`, but SQLite doesn't have a `MaxLength` constraint.

    > [!TIP]
    > EF Core database providers handle mapping model schema to a particular database's features. While SQLite doesn't implement a corresponding constraint for `MaxLength`, other databases like SQL Server and PostgreSQL do.

1. In the **SQLITE EXPLORER** pane, right-click the `_EFMigrationsHistory` table and select **Show Table**. The table contains a list of all migrations applied to the database.

You've used migrations to define and update a database schema. In the next unit, you'll finish the methods in `PizzaService` that manipulate data.
