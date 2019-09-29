In this unit, you'll configure a database connection to an existing, empty *ContosoPets* Azure SQL database. The Code-First workflow will be used to create tables in the database from C# code. The [.NET Core Secret Manager](https://docs.microsoft.com/aspnet/core/security/app-secrets#secret-manager) will be used as a development-grade mechanism for securely storing secrets, such as database credentials.

> [!IMPORTANT]
> Secret Manager isn't intended for production deployments. Consider using [Azure Key Vault](https://docs.microsoft.com/azure/key-vault/key-vault-overview).

1. In the *:::no-loc text="ContosoPets.Api/ContosoPets.Api.csproj":::* file, replace the `<!-- Replace this comment with the UserSecretsId element -->` comment with the following XML. Save your changes.

    ```xml
    <UserSecretsId>$(AssemblyName)</UserSecretsId>
    ```

    Secret Manager uses the `UserSecretsId` element's inner text to associate secrets with the project. The inner text must be a string that uniquely identifies the app on the development machine or server. In the preceding example, the MSBuild `AssemblyName` project property resolves to the assembly name *:::no-loc text="ContosoPets.Api":::*.

    [!INCLUDE[OS-specific keyboard shortcuts](../../includes/keyboard-shortcuts-table.md)]

1. Run the following command to store the Azure SQL database credentials using Secret Manager:

    ```bash
    dotnet user-secrets set "ContosoPetsCredentials:UserId" $sqlUsername && \
        dotnet user-secrets set "ContosoPetsCredentials:Password" $sqlPassword
    ```

1. In *:::no-loc text="appsettings.Development.json":::*, replace the `// Add the ConnectionStrings:ContosoPets JSON` comment with the following. Save your changes.

    ```json
    "ConnectionStrings": {
        "ContosoPets": ""
    },
    ```

    The *:::no-loc text="appsettings.Development.json":::* file will be used whenever the app is run in a development environment. The following are two options for setting the environment:

    * The `ASPNETCORE_ENVIRONMENT` environment variable
    * The `--environment` command-line parameter

1. Run the following command to print the database connection string. Copy the resulting connection string to your clipboard.

    ```bash
    echo $sqlConnectionString
    ```

1. In *:::no-loc text="appsettings.Development.json":::*, replace the `ContosoPets` key's value of `""` with the connection string stored in your clipboard. Save your changes.

    The file now resembles the following JSON:

    ```json
    {
      "ConnectionStrings": {
        "ContosoPets": "Data Source=<SQL-server-name>.database.windows.net;Initial Catalog=ContosoPets;Connect Timeout=30;Encrypt=True;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False"
      },
      "Logging": {
        "LogLevel": {
          "Default": "Debug",
          "System": "Information",
          "Microsoft": "Information"
        }
      }
    }
    ```

1. In the *:::no-loc text="Startup.cs":::* file's `ConfigureServices` method, replace the `// Add the SqlConnectionStringBuilder code` comment with the following code. Save your changes.

    ```csharp
    var builder = new SqlConnectionStringBuilder(
        Configuration.GetConnectionString("ContosoPets"));
    IConfigurationSection contosoPetsCredentials =
        Configuration.GetSection("ContosoPetsCredentials");

    builder.UserID = contosoPetsCredentials["UserId"];
    builder.Password = contosoPetsCredentials["Password"];
    ```

    The preceding code:

    * Instantiates a `SqlConnectionStringBuilder` object, which is used for concatenating strings to produce a valid database connection string.
    * Retrieves the database connection string from the `ConnectionStrings:ContosoPets` property of the *:::no-loc text="appsettings.Development.json":::* file.
    * Retrieves the `UserId` and `Password` property values from the `ContosoPets` section of the local secret store.
    * Injects the `UserId` and `Password` property values into the database connection string.

1. In the same `ConfigureServices` method, replace the `// Add the UseSqlServer code` comment with the following code. Save your changes.

    ```csharp
    services.AddDbContext<ContosoPetsContext>(options =>
        options.UseSqlServer(builder.ConnectionString));
    ```

    The preceding code:

    * Registers `ContosoPetsContext` as a scoped service in the dependency injection (DI) system. With the scoped lifetime, the `ContosoPetsContext` object is created once per request.
    * Defines the Database Provider as SQL Server.
    * Provides a connection string to the Database Provider for the Azure SQL database.

1. In *:::no-loc text="Startup.cs":::*, replace the `// Add the System.Data.SqlClient using statement` comment with the following code. Save your changes.

    ```csharp
    using System.Data.SqlClient;
    ```

    Inclusion of the preceding namespace resolves the reference to `SqlConnectionStringBuilder` in the previous step.

1. [!INCLUDE[dotnet build command](../../includes/dotnet-build-command.md)]