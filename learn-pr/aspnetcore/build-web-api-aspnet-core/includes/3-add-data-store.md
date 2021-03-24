A type of class called a *Model* is needed to represent a dog toy in inventory. The Model contains properties that represent characteristics of a product. The Model is used to pass data in the web API and to persist dog toys in a data store. In this unit, that data store will be created as an [in-memory EF Core database](/ef/core/providers/in-memory/).

An in-memory database is used in this unit for simplicity. Choose a different data store, such as SQL Server or Azure SQL Database, for production environments.

## Create a product Model

1. Run the following command:

    ```bash
    mkdir Models && touch $_/Product.cs
    ```

    > [!NOTE]
    > The `touch` command is specific to Linux, the Cloud Shell's underlying OS.

    The project root now contains a *:::no-loc text="Models":::* directory with an empty *:::no-loc text="Product.cs":::* file. The directory name *:::no-loc text="Models":::* is a convention. The directory name comes from the **Model**-View-Controller architecture used by the web API.

1. [!INCLUDE[refresh file explorer](../../includes/refresh-file-explorer.md)]

    The *:::no-loc text="Models":::* directory and its *:::no-loc text="Product.cs":::* file appear.

1. Add the following code to *:::no-loc text="Models/Product.cs":::* to define a product. Save your changes.

    ```csharp
    using System.ComponentModel.DataAnnotations;

    namespace ContosoPets.Api.Models
    {
        public class Product
        {
            public int Id { get; set; }

            [Required]
            public string Name { get; set; }

            [Range(0.01, 9999.99)]
            public decimal Price { get; set; }
        }
    }
    ```

    [!INCLUDE[OS-specific keyboard shortcuts](../../includes/keyboard-shortcuts-table.md)]

    The `Name` and `Price` properties are annotated with attributes to constrain the values used to create a `Product` object. Specifically, the `[Required]` attribute enforces that the provided name isn't empty. The `[Range]` attribute ensures that the provided price is at least 0.01, but not higher than 9,999.99.

## Add data management and seeding support

1. Run the following command:

    ```dotnetcli
    dotnet add package Microsoft.EntityFrameworkCore.InMemory --version 3.1.12
    ```

    The preceding command:

    * Downloads the specified NuGet package and its dependencies.
    * Adds the specified NuGet package reference to the project.

    The `Microsoft.EntityFrameworkCore.InMemory` package is required to use an EF Core in-memory database. Notice the following element was added to the *:::no-loc text="ContosoPets.Api.csproj":::* file:

    ```xml
    <PackageReference Include="Microsoft.EntityFrameworkCore.InMemory" Version="3.1.12" />
    ```

1. Run the following command:

    ```bash
    mkdir Data && touch $_/ContosoPetsContext.cs $_/SeedData.cs
    ```

    A *:::no-loc text="Data":::* directory is created in the project root with empty *:::no-loc text="ContosoPetsContext.cs":::* and *:::no-loc text="SeedData.cs":::* files.

1. Refresh file explorer, and add the following code to *:::no-loc text="Data/ContosoPetsContext.cs":::*. Save your changes.

    ```csharp
    using Microsoft.EntityFrameworkCore;
    using ContosoPets.Api.Models;

    namespace ContosoPets.Api.Data
    {
        public class ContosoPetsContext : DbContext
        {
            public ContosoPetsContext(DbContextOptions<ContosoPetsContext> options)
                : base(options)
            {
            }

            public DbSet<Product> Products { get; set; }
        }
    }
    ```

    The preceding code creates a Contoso Pets-specific implementation of an EF Core `DbContext` object. The `ContosoPetsContext` class provides access to an in-memory database, as configured in the next step.

1. Apply the following changes to the *:::no-loc text="Startup.cs":::* file:
    1. Add the following highlighted code to the `ConfigureServices` method:

        [!code-csharp[](../code/3-add-db-context.cs?highlight=3-4)]

        The preceding code:

        * Registers the custom `DbContext` class, named `ContosoPetsContext`, with ASP.NET Core's [dependency injection](/aspnet/core/fundamentals/dependency-injection) system.
        * Defines an in-memory database named *:::no-loc text="ContosoPets":::*.

    1. Add the following code to the top of the file. Save your changes.

        ```csharp
        using Microsoft.EntityFrameworkCore;
        using ContosoPets.Api.Data;
        ```

        The `Microsoft.EntityFrameworkCore` namespace resolves the `UseInMemoryDatabase` method call. The `ContosoPets.Api.Data` namespace resolves the `ContosoPetsContext` reference.

1. Add the following code to *:::no-loc text="Data/SeedData.cs":::*. Save your changes.

    ```csharp
    using ContosoPets.Api.Models;
    using System.Linq;

    namespace ContosoPets.Api.Data
    {
        public static class SeedData
        {
            public static void Initialize(ContosoPetsContext context)
            {
                if (!context.Products.Any())
                {
                    context.Products.AddRange(
                        new Product 
                        {
                            Id = 0,
                            Name = "Squeaky Bone",
                            Price = 20.99m
                        },
                        new Product
                        {
                            Id = 0,
                            Name = "Knotted Rope",
                            Price = 12.99m
                        }
                    );

                    context.SaveChanges();
                }
            }
        }
    }
    ```

    The preceding code defines a static `SeedData` class. The class's `Initialize` method seeds the in-memory database with two dog toys. The `Product` objects are added to `context.Products`, which is a collection of type `DbSet<Product>`.

1. Replace the code in *:::no-loc text="Program.cs":::* with the following code. Save your changes.

    ```csharp
    using ContosoPets.Api;
    using ContosoPets.Api.Data;
    using Microsoft.AspNetCore.Hosting;
    using Microsoft.Extensions.DependencyInjection;
    using Microsoft.Extensions.Hosting;
    
    namespace ContosoPets.Api
    {
        public class Program
        {
            public static void Main(string[] args) =>
                CreateHostBuilder(args).Build().SeedDatabase().Run();
    
            private static IHostBuilder CreateHostBuilder(string[] args) =>
                Host.CreateDefaultBuilder(args)
                    .ConfigureWebHostDefaults(webBuilder => webBuilder.UseStartup<Startup>());
        }
    
        public static class IHostExtensions
        {
            public static IHost SeedDatabase(this IHost host)
            {
                var scopeFactory = host.Services.GetRequiredService<IServiceScopeFactory>();
                using var scope = scopeFactory.CreateScope();
                var context = scope.ServiceProvider.GetRequiredService<ContosoPetsContext>();
    
                if (context.Database.EnsureCreated())
                    SeedData.Initialize(context);
    
                return host;
            }
        }    
    }
    ```

    The `Main` method is the first code to execute when the app starts. With the preceding changes, seeding of the in-memory database is triggered via a call to `SeedData.Initialize`. This database seeding strategy isn't recommended in a production environment. Consider seeding during database deployment instead.

## Build the web API project

[!INCLUDE[dotnet build command](../../includes/dotnet-build-command.md)]

The `Product` Model and `ContosoPetsContext` class will be used by the controller created in the next unit.
