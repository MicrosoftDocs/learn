Until this point, you've been saving your data in an in-memory database. This database is easy to set up and use while you develop your application, but the data isn't persistent. As a result, the data will be lost when the application is restarted. Before you deploy your application, you need to persist the data to a database.

In this exercise, you'll upgrade your application to use a relational database to store your data. You'll use SQLite to store your data.

## Set up the SQLite database

Complete the following sections to set up the SQLite database.

### Install the following tools and packages

In the terminal, install the following packages:

1. [SQLite EF Core Database Provider](https://www.nuget.org/packages/Microsoft.EntityFrameworkCore.Sqlite/6.0.0?azure-portal=true): Can access many different databases through plug-in libraries called [database providers](/ef/core/providers/?tabs=dotnet-core-cli?azure-portal=true). The following package is the SQLite database provider for Entity Framework (EF) Core.

    ```dotnetcli
    dotnet add package Microsoft.EntityFrameworkCore.Sqlite --version 8.0
    ```

1. [EF Core tools](/ef/core/cli/dotnet?azure-portal=true): Tools for EF Core perform design-time development tasks. For example, they create migrations, apply migrations, and generate code for a model based on an existing database.

    ```dotnetcli
    dotnet tool install --global dotnet-ef
    ```

1. [Microsoft.EntityFrameworkCore.Design](https://www.nuget.org/packages/Microsoft.EntityFrameworkCore.Design/6.0.0?azure-portal=true): Contains all the design-time logic for EF Core to create your database.

    ```dotnetcli
    dotnet add package Microsoft.EntityFrameworkCore.Design --version 8.0
    ```

## Enable database creation

To enable database creation, you need to set the database connection string. Then you'll migrate your data model to a SQLite database.

1. In *Program.cs*, under `var builder = WebApplication.CreateBuilder(args);`, add a connection string.

    ```csharp
    var connectionString = builder.Configuration.GetConnectionString("Pizzas") ?? "Data Source=Pizzas.db";
    ```

    This code checks the configuration provider for a connection string named *Pizzas*. If it doesn't find one, it will use `Data Source=Pizzas.db` as the connection string. SQLite will map this string to a file.

1. In the CRUD portion of this tutorial, you used an in-memory database. Now you're going to replace the in-memory database with a persistent database.

    Replace your current in-memory database implementation `builder.Services.AddDbContext<PizzaDb>(options => options.UseInMemoryDatabase("items"));` in your build services with the SQLite one here:

    ```csharp
    builder.Services.AddSqlite<PizzaDb>(connectionString);
    ```

1. With the EF Core migration tool, you can now generate your first migration, `InitialCreate`. Save all your changes, and then run the following command:

    ```console
    dotnet ef migrations add InitialCreate
    ```

    EF Core creates a *Migrations* folder in your project directory that contains two files with the code that represents the database migrations.

1. Now that you've completed the migration, you can use it to create your database and schema.

    In a terminal window, run the following `database update` command to apply migrations to a database:

    ```console
    dotnet ef database update
    ```

    You should see a newly created *Pizzas.db* file in your project directory.

## Run and test the application

Now that you have a backing database, your changes will be persisted.

Test your application as before using `dotnet run` and the Swagger UI. Stop the application by using the **Ctrl+C** command. Then run it again and verify that your changes are still persisted in *Pizzas.db*.

Congratulations! You wired a database to your minimal API!
