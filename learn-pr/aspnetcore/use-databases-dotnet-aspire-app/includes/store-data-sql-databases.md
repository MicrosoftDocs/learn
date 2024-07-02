The .NET Aspire stack is designed to make you more productive and to help you build robust, scalable, and secure web applications. You can store structured relational data quickly by adding one of the supported Aspire components.

The current SQL-compliant database components are:

- PostgreSQL Databases
- SQL Databases
- Oracle Databases
- MySQL Databases

> [!NOTE]
> Microsoft may add support for other database systems and third parties can also contribute, so this list may expand.

In this unit, learn about three of these components, which databases have Entity Framework Core support, and how to use them to store and retrieve data.

## How to add a database component to your project

Whichever database you choose, the approach to add a .NET Aspire database component to your project is the same.

In the app host project:

- Install the .NET Aspire hosting component to the app host project.
- Register a database and create a container for it in the solution's app host.
- Pass a reference to the projects that needs access to the created container hosting the database.

In the projects that use the database:

- Add the .NET Aspire component with a NuGet package to the projects that require data access. Optionally, if there's a .NET Core Entity Framework (EF) component, you can use that instead.
- Register the data source, or database context for EF, in the project's _Program.cs_ file.
- Use dependency injection to inject the data source into your services.

Let's look at the specifics of how to do these steps for each of the supported databases.

## Using the .NET Aspire PostgreSQL components

The .NET Aspire PostgreSQL components require changes in both the app host project and any microservices that use the databases.

### Configuring the app host

Start by installing the appropriate hosting component to the app host:

```dotnetcli
dotnet add package Aspire.Hosting.PostgreSQL --prerelease
```

Next, to register a database and create a container for it, add this code to the app host's _Program.cs_ file:

```csharp
var postgres = builder.AddPostgres("postgres");
var postgresdb = postgres.AddDatabase("postgresdb");
```

You must also pass a reference to the database service to any projects that consume it:

```csharp
var northernTradersCatalogAPI = builder.AddProject<Projects.NorthernTraders_CatalogAPI>()
                                       .WithReference(postgresdb);
```

### Configuring the consuming projects

To install the .NET Aspire PostgreSQL component, use a command like this one in your .NET Aspire projects:

```dotnetcli
dotnet add package Aspire.Npgsql --prerelease
```

Or to use the .NET Aspire PostgreSQL Entity Framework Core component, use this command instead:

```dotnetcli
dotnet add package Aspire.Npgsql.EntityFrameworkCore.PostgreSQL --prerelease
```

Alternatively, you can use the **Add > .NET Aspire Component** shortcut in Visual Studio to install the component from the NuGet package manager:

:::image type="content" source="../media/adding-postgres-nuget-package.png" lightbox="../media/adding-postgres-nuget-package.png" alt-text="Screenshot showing the NuGet package manager in Visual Studio displaying .NET Aspire PostgreSQL components.":::

Code in the _*.AppHost_ project's _Program.cs_ file creates the database and passes it to projects that want to use it:

```csharp
var postgres = builder.AddPostgres("pg")
                      .AddDatabase("postgresdb");

var exampleProject = builder.AddProject<Projects.SampleProject>()
                            .WithReference(postgres);
```

Some of the .NET Aspire database components also allow you to create a container for database management tools. To add **PgAdmin** to your solution to manage the PostgreSQL database, use this code:

```csharp
var postgresdb = builder.AddPostgres("pg")
                        .AddDatabase("postgresdb")
                        .WithPgAdmin();
```

The advantage of letting .NET Aspire create the container is that you don't need to do any configuration to connect PgAdmin to the PostgreSQL database, it's all automatic.

## Using a PostgreSQL database

In any project where you want to use the database, you add a data source to represent the connection to PostgreSQL. In the _Program.cs_ file, this code registers the database:

```csharp
builder.AddNpgsqlDataSource("postgresdb");
```

Or to use Entity Framework Core component, register the database context:

```csharp
builder.AddNpgsqlDbContext<YourDbContext>("postgresdb");
```

Once the database is registered in the consuming project, you can interact with the data source anytime you need it by using dependency injection:

```csharp
public class YourService(NpgsqlDataSource dataSource)
{
    public async Task<IEnumerable<Catalog>> GetCatalog()
	{
        const string query = "SELECT * FROM catalog";
        using var dbConnection = dataSource.OpenConnection();
        var results = await dbConnection.QueryAsync<Catalog>(command);
        return queryResult.ToArray();
	}
}
```

Or you can then retrieve the database context `YourDbContext` to interact with the database:

```csharp
public class YourService(YourDbContext context)
{
    public async Task<IEnumerable<Catalog>> GetCatalog()
	{
        var items = await context.ObjectItems;
        if (item is null)
        {
            return Results.NotFound();
        }
		else
		{
		    return items;
		}
	}
}
```

## Configuring the PostgreSQL component

The .NET Aspire stack tries to reduce the amount of configuring you need to do. Using dependency injection and service discovery, you can access the database without needing to configure the connection strings in your projects.

Using the app host project to create the database container and passing it as a reference to the projects, allows the receiving projects to access the database location, connection strings, and ports. There's no need to manage environment variables or _appsettings.json_ files.

But, if you want, or you need more control over how the database is configured, there are more options.

### Using a connection string

In the project that requires the database, you use a connection string to connect to the database. This approach is useful when you need to connect to a database that isn't registered in the app host.

```csharp
builder.AddNpgsqlDataSource("NpgsqlConnectionString");
```

Then in the configuration file, you can add the connection string:

```json
{
  "ConnectionStrings": {
    "NpgsqlConnectionString": "Host=myserver;Database=postgresdb;User id=myuser;Password=mypassword"
  }
}
```

### Using configuration providers

.NET Aspire has a feature of components that allows them to support a `Microsoft.Extensions.Configuration`. The PostgreSQL component supports this feature, and by default it looks for settings using the `Aspire:Npgsql` key. In projects using *appsettings.json*, an example configuration might look like this:

```json
{
  "Aspire": {
    "Npgsql": {
      "ConnectionString": "Host=myserver;Database=postgresdb;User id=myuser;Password=mypassword",
      "HealthChecks": true,
      "Tracing": true,
      "Metrics": true
    }
  }
}
```

The previous configuration is setting the connection string, enabling health checks, tracing, and metrics for the PostgreSQL component. You code then no longer needs to specify the connection string, just use `builder.AddNpgsqlDataSource();`.

If you're using the PostgreSQL Entity Framework Core component, you can use the `Aspire:Npgsql:EntityFrameworkCore:PostgreSQL` key to configure the database context:

```json
{
  "Aspire": {
    "Npgsql": {
      "EntityFrameworkCore": {
        "PostgreSQL": {
          "ConnectionString": "Host=myserver;Database=postgresdb;User id=myuser;Password=mypassword",
          "MaxRetryCount": 0,
          "HealthChecks": false,
          "Tracing": false
        }
      }
    }
  }
}
```

For more information on the Entity Framework configuration options, see the [.NET Aspire documentation](/dotnet/aspire/database/postgresql-entity-framework-component?tabs=dotnet-cli#configuration).

### Using inline delegates

The last option is to pass a `configureSettings` inline delegate to the `AddNpgsqlDataSource` method. This delegate allows you to configure the settings for the database component directly with code:

```csharp
builder.AddNpgsqlDataSource(
    "postgresdb", static settings => settings.HealthChecks = false);
```

## Using the .NET Aspire SQL Database components

The previous pattern is the same for the SQL Database component. You make changes in both the app host project and the microservices that consume the database service.

### Configuring the app host

To install the SQL database hosting component, use this command:

```dotnet
dotnet add package Aspire.Hosting.SqlServer --prerelease
```

To register the container and database, add this code to the app host's _Program.cs_ file:

```csharp
var sql = builder.AddSqlServer("sql");
var sqldb = sql.AddDatabase("sqldb");
```

Then, pass a reference to database service to any projects that consume it:

```csharp
var northernTradersCatalogAPI = builder.AddProject<Projects.NorthernTraders_CatalogAPI>()
                                       .WithReference(sqldb);
```

### Configuring the consuming projects

To install the .NET Aspire SQL Database component, use a command like this one in your .NET Aspire projects:

```dotnetcli
dotnet add package Aspire.Microsoft.Data.SqlClient --prerelease
```

Or to use the .NET Aspire SqlServer Entity Framework Core component, use this command instead:

```dotnetcli
dotnet add package Aspire.Microsoft.EntityFrameworkCore.SqlServer --prerelease
```

These NuGet packages can also be added using the **Add > .NET Aspire Component** shortcut in Visual Studio.

The _*.AppHost_ project's _Program.cs_ file code to access the database is similar to the PostgreSQL example:

```csharp
var sqlServer = builder.AddSqlServer("sql")
                       .AddDatabase("sqldata");

var myService = builder.AddProject<Projects.MyService>()
                       .WithReference(sqlServer);
```

## Using a SQL Server database

In the projects that need SQL access, in the _Program.cs_ file, this code registers the Entity Framework database context:

```csharp
builder.AddSqlServerDbContext<YourDbContext>("sqldata");
```

Once the database is registered in the consuming project, you can interact with the database context `YourDbContext` using dependency injection. This example code retrieves weather forecasts from a database and selects one at random to return:

```csharp
app.MapGet("/weatherforecast", async (YourDbContext context) =>
{
  var rng = new Random();
  var forecasts = await context.Forecasts.ToListAsync();
  var forecast = forecasts[rng.Next(forecasts.Count)];
  return forecast;
});
```

## Configuring the SQL Server component

As before, if you use the same database name in app host and the consuming project, you don't need to configure the connection between your SQL Server database and the projects. The .NET Aspire SQL Server component also supports other ways to configure the component.

### Using configuration providers

The SQL Server component also supports `Microsoft.Extensions.Configuration`. By default, it looks for settings using the `Aspire:SqlServer:SqlClient` key. In projects using *appsettings.json*, an example configuration might look like this:

```json
{
  "Aspire": {
    "SqlServer": {
      "SqlClient": {
        "ConnectionString": "YOUR_CONNECTIONSTRING",
        "HealthChecks": true,
        "Tracing": false,
        "Metrics": false
      }
    }
  }
}
```

### Using inline configurations

When you add the SQL Server component, you can pass a `configureSettings` inline delegate to the `AddSqlServerClient` method. This delegate allows you to configure the settings for the database component directly with code:

```csharp
builder.AddSqlServerClient("sqldata", static settings => settings.HealthChecks = false);
```

You can pass any of the supported options:

* `ConnectionString`: The connection string of the SQL Server database
* `HealthChecks`: A boolean value that indicates whether the database health check is enabled
* `Tracing`: A boolean value that indicates whether the OpenTelemetry tracing is enabled
* `Metrics`: A boolean value that indicates whether the OpenTelemetry metrics are enabled

### Connect to multiple databases

The SQL Server component supports multiple connections through named instances. For example, you can connect to two different SQL Server databases in the same project:

```json
{
  "Aspire": {
    "SqlServer": {
      "SqlClient": {
        "INSTANCE_1": {
          "ServiceUri": "YOUR_URI",
          "HealthChecks": false
        },
        "INSTANCE_2": {
          "ServiceUri": "YOUR_URI",
          "HealthChecks": false
        }
      }
    }
  }
}
```  

Using this configuration, you can connect to the two different databases in the same project:

```csharp
builder.AddSqlServerClient("INSTANCE_1");
builder.AddSqlServerClient("INSTANCE_2");
```

## Using the MySQL component

To install the .NET Aspire MySQL component, use a command like this one in your .NET Aspire projects that require data access:

```dotnetcli
dotnet add package Aspire.MySqlConnector --prerelease
```

Or use the **Add > .NET Aspire Component** shortcut in Visual Studio to install the component from the NuGet package manager.

The _*.AppHost_ project's _Program.cs_ file code to access the database is similar to the PostgreSQL example:

```csharp
var mysqldb = builder.AddMySql("mysql")
                     .AddDatabase("mysqldb")
                     .WithPhpMyAdmin();

var myService = builder.AddProject<Projects.MyService>()
                       .WithReference(mysqldb);
```

Like the PostgreSQL component, the MySQL component also allows you to create a container for database management tools. The previous example adds **PhpMyAdmin** to the solution.
 
## Using a MySQL database

The pattern is the same in the projects that need MySQL access. In the _Program.cs_ file, this code registers the database:

```csharp
builder.AddMySqlDataSource("mysqldb");
```

Once the database is registered in the consuming project, you can interact with the data source anytime you need it by using dependency injection:

```csharp
app.MapGet("/catalog", async (MySqlConnection db) =>
{
    const string sql = """
        SELECT Id, Name, Description, Price
        FROM catalog
        """;

    // the db object is a connection to the MySQL database registered with AddMySqlDataSource
    return await db.QueryAsync<CatalogItem>(sql);
});
```

## Configuring the MySQL component

The MySQL component supports the same three options to manage the configuration.

### Connection strings

The _appsettings.json_ file can contain the connection string for the MySQL database:

```json
{
  "ConnectionStrings": {
    "MySqConnection": "Server=myserver;Database=mysqldb;Uid=myuser;Pwd=mypassword"
  }
}
```

Then, in your project, you can connect to the database with the connection string using code like this:

```csharp
builder.AddMySqlDataSource("MySqConnection");
```

### Configuration providers

The `Aspire:MySqlConnector` key is used to configure the MySQL component.
 
```json
{
  "Aspire": {
    "MySqlConnector": {
      "ConnectionString": "Server=myserver;Database=mysqldb;Uid=myuser;Pwd=mypassword",
      "HealthChecks": true,
      "Tracing": false,
      "Metrics": false
    }
  }
}
```

### Inline configurations

```csharp
builder.AddMySqlDataSource("mysqldb", static settings => settings.HealthChecks = false);
```

## Learn how to seed your database

The .NET Aspire stack uses containers, getting the advantages of consistent environments and easy deployments. A downside is that the containers are stateless. Any data or schemas added to a database are lost when the container is destroyed. .NET Aspire provides ways to seed your databases with data when it creates their containers.

### Using volumes and scripts

The simplest way to seed your database is to use volumes and SQL scripts. Volumes can store data for multiple containers at a time, offer high performance, and are easy to back up or migrate. The scripts stored in these volumes run when a container is created, populating the database with data. The script can be a SQL file that contains the data and schema you want for your database.

For example if you had this SQL script, stored in a file named _postgres-backup.sql_, in the **Service.API/Seed** folder:
  
```sql
CREATE TABLE catalog (
  Id INT PRIMARY KEY,
  Name VARCHAR(50),
  Description VARCHAR(255),
  Price DECIMAL(18, 2)
);

INSERT INTO catalog (Id, Name, Description, Price)
VALUES (1, 'Item 1', 'Description of item 1', 10.99),
      (2, 'Item 2', 'Description of item 2', 20.99),
      (3, 'Item 3', 'Description of item 3', 30.99);
```

In your solution's app host, you can bind the **Service.API/Seed** folder to the container's _/docker-entrypoint-initdb.d_ folder. This folder is a special folder in the PostgreSQL container that runs any SQL scripts it finds when the container is created:

```csharp
    var catalogDB = builder.AddPostgres("postgres")
      .WithPgAdmin()
      .WithEnvironment("POSTGRES_DB", "backendDB")
      .WithBindMount("../Service.API/Seed", "/docker-entrypoint-initdb.d")
      .AddDatabase("backendDB");
```

You can even split the SQL scripts into schema creation and data seeding scripts. If they're all contained in the **Service.API/Seed** folder, they're executed when .NET Aspire creates the database.

### Seeding data using Entity Framework Core

For the components that support Entity Framework Core, you can seed your database using the `DbContext` class and Entity Framework core migrations. This method uses C# code to seed the database. However, this seeding should only happen during development or testing, not in production.

```csharp
// Register DbContext class
builder.AddNpgsqlDbContext<CatalogContext>("sqldata");

var app = builder.Build();

app.MapDefaultEndpoints();

if (app.Environment.IsDevelopment())
{
    // Retrieve an instance of the DbContext class and manually run migrations during development
    using (var scope = app.Services.CreateScope())
    {
        var context = scope.ServiceProvider.GetRequiredService<CatalogContext>();
        context.Database.EnsureCreated();
    }
}
```

The above code checks the state of the app environment. If it's in development, the code retrieves the `CatalogContext` class and runs the `EnsureCreated` method. This method creates the database and runs any migrations that are pending.

For more information on how to seed the different database components, see the [.NET Aspire documentation](/dotnet/aspire/database/seed-database-data).
