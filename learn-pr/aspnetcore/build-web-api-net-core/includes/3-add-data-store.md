A type of class called a *Model* is needed to represent a dog toy in inventory. The Model must include the properties of a product and is used to pass data in the web API. The Model is also used to persist dog toys in a data store. In this unit, that data store will be created as an [in-memory EF Core database](https://docs.microsoft.com/ef/core/providers/in-memory/).

An in-memory database is used in this unit for simplicity. Choose a different data store for production environments, such as SQL Server or Azure SQL Database.

> [!IMPORTANT]
> If the Cloud Shell session ever times out or disconnects, reconnect and run the following command after reconnecting to set the working directory to *:::no-loc text="~/contoso-pets/src/ContosoPets.Api":::* and launch the editor:
>
> ```bash
> cd ~/contoso-pets/src/ContosoPets.Api && code .
> ```

1. Run the following command:

    ```bash
    mkdir Models && touch $_/Product.cs
    ```

    > [!NOTE]
    > The `touch` command is specific to Linux, the Cloud Shell's underlying OS.

    A *:::no-loc text="Models":::* directory is created in the project root with an empty *:::no-loc text="Product.cs":::* file. The directory name *:::no-loc text="Models":::* is a convention. The directory name comes from the **Model**-View-Controller architecture used by the web API.

1. [!INCLUDE[refresh file explorer](../../includes/refresh-file-explorer.md)]

    The *:::no-loc text="Models":::* directory and its *:::no-loc text="Product.cs":::* file appear.

1. Add the following code to *:::no-loc text="Models/Product.cs":::* to define a product. Save your changes.

    ```csharp
    using System.ComponentModel.DataAnnotations;

    namespace ContosoPets.Api.Models
    {
        public class Product
        {
            public long Id { get; set; }

            [Required]
            public string Name { get; set; }

            [Required]
            [Range(minimum: 0.01, maximum: (double) decimal.MaxValue)]
            public decimal Price { get; set; }
        }
    }
    ```

    [!INCLUDE[OS-specific keyboard shortcuts](../../includes/keyboard-shortcuts-table.md)]

    The `Name` and `Price` properties are marked as required to ensure values are provided when creating a `Product` object. Additionally, the `Price` property enforces minimum and maximum values.

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

1. Add the following highlighted code to the *:::no-loc text="Startup.cs":::* file's `ConfigureServices` method. Save your changes.

    [!code-csharp[](../code/3-add-db-context.cs?highlight=3-4)]

    The preceding code:

    * Registers the custom `DbContext` class, named `ContosoPetsContext`, with ASP.NET Core's [dependency injection](https://docs.microsoft.com/aspnet/core/fundamentals/dependency-injection) system.
    * Defines an in-memory database named *:::no-loc text="ContosoPets":::*.

1. Add the following code to the top of *:::no-loc text="Startup.cs":::*. Save your changes.

    ```csharp
    using Microsoft.EntityFrameworkCore;
    using ContosoPets.Api.Data;
    ```

    The `Microsoft.EntityFrameworkCore` namespace resolves the `UseInMemoryDatabase` method call. The `ContosoPets.Api.Data` namespace resolves the `ContosoPetsContext` reference.

1. Add the following code to *:::no-loc text="Data/SeedData.cs":::*. Save your changes.

    ```csharp
    using System;
    using System.Linq;
    using Microsoft.EntityFrameworkCore;
    using Microsoft.Extensions.DependencyInjection;
    using ContosoPets.Api.Models;

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
                            Name = "Squeaky Bone",
                            Price = 20.99m
                        },
                        new Product
                        {
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

    The preceding code defines a static `SeedData` class. The class's `Initialize` method seeds the in-memory database with two dog toys.

1. Replace the code in *:::no-loc text="Program.cs":::* with the following code. Save your changes.

    ```csharp
    using System;
    using Microsoft.AspNetCore;
    using Microsoft.AspNetCore.Hosting;
    using Microsoft.Extensions.DependencyInjection;
    using Microsoft.Extensions.Logging;
    using ContosoPets.Api.Data;

    namespace ContosoPets.Api
    {
        public class Program
        {
            public static void Main(string[] args)
            {
                var host = CreateWebHostBuilder(args).Build();
                SeedDatabase(host);
                host.Run();
            }

            public static IWebHostBuilder CreateWebHostBuilder(string[] args) =>
                WebHost.CreateDefaultBuilder(args)
                    .UseStartup<Startup>();

            private static void SeedDatabase(IWebHost host)
            {
                var scopeFactory = host.Services.GetRequiredService<IServiceScopeFactory>();

                using (var scope = scopeFactory.CreateScope())
                {
                    var context = scope.ServiceProvider.GetRequiredService<ContosoPetsContext>();

                    if (context.Database.EnsureCreated())
                    {
                        try
                        {
                            SeedData.Initialize(context);
                        }
                        catch (Exception ex)
                        {
                            var logger = scope.ServiceProvider.GetRequiredService<ILogger<Program>>();
                            logger.LogError(ex, "A database seeding error occurred.");
                        }
                    }
                }
            }
        }
    }
    ```

    The `Program.Main` method is the first code to execute when the app starts. With the preceding changes, seeding of the in-memory database is triggered via a call to `SeedData.Initialize`.

    > [!IMPORTANT]
    > This database seeding strategy isn't recommended in a production environment. Consider seeding during database deployment instead.

1. [!INCLUDE[dotnet build command](../../includes/dotnet-build-command.md)]

The `Product` Model and `ContosoPetsContext` class will be used by the controller created in the next unit.
