Until this point, you have been saving your data in an in-memory database. This is very easy to set up and use while developing your application, but the data is not persistent, meaning it will be lost when the application is restarted. Prior to deploying your application, you need to persist the data to a database.

In this exercise, you will upgrade your application to use a relational database to store your data. You will use SQLite to store your data.

## Set up the SQLite database

Complete the following sections to set up the SQLite database.

### Install the following tools and packages

1. Using .NET CLI / Visual Studio package manager UI, install the following packages:

   [SQLite EF Core Database Provider](https://www.nuget.org/packages/Microsoft.EntityFrameworkCore.Sqlite/6.0.0-rc.2.21480.5?azure-portal=true): Can access many different databases through plug-in libraries called [database providers](/ef/core/providers/?tabs=dotnet-core-cli?azure-portal=true). The package below is the SQLite database provider for EF Core.

   ```console
   dotnet add package Microsoft.EntityFrameworkCore.Sqlite --version 6.0.0-rc.*
   ```

   [Entity Framework Core tools](/ef/core/cli/dotnet?azure-portal=true): Tools for Entity Framework Core perform design-time development tasks. For example, they create migrations, apply migrations, and generate code for a model based on an existing database.

   ```console
   dotnet tool install --global dotnet-ef
   ```

   [Microsoft.EntityFrameworkCore.Design](https://www.nuget.org/packages/Microsoft.EntityFrameworkCore.Design/6.0.0-rc.2.21480.5?azure-portal=true): Contains all the design-time logic for EF core to create your database.

   ```console
   dotnet add package Microsoft.EntityFrameworkCore.Design --version 6.0.0-rc.*
   ```

## Enable database creation

To enable database creation you need to complete a couple steps:

1. Set the database connection string.
1. Migrate your data model *(see below)* to a SQLite database.

## Set database connection string

1. In `Program.cs`, below your app builder `var builder = WebApplication.CreateBuilder(args);`, add a connection string.

    ```csharp
    var connectionString = builder.Configuration.GetConnectionString("Pizzas") ?? "Data Source=Pizzas.db";
    ```

## Add your context to your services

In the CRUD portion of this tutorial, you used an in-memory database. Now you are going to replace the in-memory database with a persistent database.

- Replace your current in-memory database implementation `builder.Services.AddDbContext<PizzaDb>(options => options.UseInMemoryDatabase("items"));` in your build services with the SQLite one below:

   ```csharp
   builder.Services.AddSqlite<PizzaDb>(connectionString);
   ```

## Migrate data model

With EF Core migration tool, you can now start your first migration `InitialCreate`.  In a terminal window, run the `migrations` command below:

```console
   dotnet ef migrations add InitialCreate
```

EF Core will create a folder named *Migrations* in your project directory containing two files with the code that represents the database migrations.

## Create your database and schema

Now that you have completed the migration, you can use it to create your database and schema.

- In a terminal window, run the `database update` command below to apply migrations to a database:

   ```console
    dotnet ef database update
   ```

You should see a newly created `Pizzas.db` file in your project directory.

## Run and test the application

Now that you have a backing database, your changes will be persisted. 

To test your application, run the `dotnet run` command in your terminal window and interact with the API in the Swagger UI. You can stop the application using the `ctrl-c` command (`cmd-c` on macOS), then run it again and verify that your changes are still persisted.
