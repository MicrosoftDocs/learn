Identity works out-of-the-box without any customization. The standard Identity UI components are packaged in a .NET Standard Razor Class Library (RCL). Because an RCL is used, scant few files are added to the project.

Identity relies on Entity Framework (EF) Core for membership data management by default. After applying the initial EF Core migration, the supporting database tables are created. The database tables used by Identity look like the following diagram:

![database diagram](../media/3-identity-tables.png)

In this unit, Identity will be added to the existing ASP.NET Core Razor Pages project.

## Add Identity to the project

1. Install the ASP.NET Core code scaffolder:

    ```bash
    dotnet tool install -g dotnet-aspnet-codegenerator
    ```

    The scaffolder is a .NET Core global tool that will be used to add the default Identity components to the project. The scaffolder also enables customization in the next unit.

1. Add the following NuGet package to the project:

    ```bash
    dotnet add package Microsoft.VisualStudio.Web.CodeGeneration.Design
    ```

    The package installs code generation templates that are used by the scaffolder.

    > [!TIP]
    > To view the available generators:
    >
    > * In the command shell, run `dotnet aspnet-codegenerator -h`.
    > * When in Visual Studio, right-click the project in **Solution Explorer** and select **Add** > **New Scaffolded Item**.

1. Use the scaffolder to add the default Identity components to the project. Run the following command from the project root:

    ```bash
    dotnet aspnet-codegenerator identity \
        --useDefaultUI \
        --dbContext ContosoPetsAuth
    ```

    In the preceding command:

    * The generator identified as `identity` is used to add Identity framework to the project.
    * The `--useDefaultUI` option indicates that an RCL containing the default UI elements will be used. Bootstrap will be used to style the components.
    * The `--dbContext` option to indicate the name of an EF Core database context class to generate.

1. [!INCLUDE[refresh file explorer](../../includes/refresh-file-explorer.md)]

    An *Areas* directory structure appears in the project root:

    * *Areas*
        * *Identity*
            * *Data*
                * *ContosoPetsAuth.cs*
            * *Pages*
                * *_ValidationScriptsPartial.cshtml*
                * *_ViewStart.cshtml*
            * *IdentityHostingStartup.cs*

::: zone pivot="pg"

## Add the PostgreSQL database provider

Run the following command from the project root to install the PostgreSQL database provider for EF Core:

```bash
dotnet add package Npgsql.EntityFrameworkCore.PostgreSQL
```

::: zone-end

## Configure the database connection

1. Replace the `Configure` method of *Areas/Identity/IdentityHostingStartup.cs* with the following:

    ::: zone pivot="pg"

    ```csharp
    public void Configure(IWebHostBuilder builder)
    {
        builder.ConfigureServices((context, services) => {
            var connBuilder = new NpgsqlConnectionStringBuilder(
                context.Configuration.GetConnectionString("ContosoPetsAuthConnection"));
            connBuilder.Username = context.Configuration["DbUsername"];
            connBuilder.Password = context.Configuration["DbPassword"];

            services.AddDbContext<ContosoPetsAuth>(options =>
                options.UseNpgsql(connBuilder.ConnectionString));

            services.AddDefaultIdentity<IdentityUser>()
                .AddDefaultUI(UIFramework.Bootstrap4)
                .AddEntityFrameworkStores<ContosoPetsAuth>();
        });
    }
    ```

    ::: zone-end

    ::: zone pivot="sql"

    ```csharp
    public void Configure(IWebHostBuilder builder)
    {
        builder.ConfigureServices((context, services) => {
            var connBuilder = new SqlConnectionStringBuilder(
                context.Configuration.GetConnectionString("ContosoPetsAuthConnection"));
            connBuilder.UserID = context.Configuration["DbUsername"];
            connBuilder.Password = context.Configuration["DbPassword"];

            services.AddDbContext<ContosoPetsAuth>(options =>
                options.UseSqlServer(connBuilder.ConnectionString));

            services.AddDefaultIdentity<IdentityUser>()
                .AddDefaultUI(UIFramework.Bootstrap4)
                .AddEntityFrameworkStores<ContosoPetsAuth>();
        });
    }
    ```

    ::: zone-end

    In the preceding code:

    * The Azure Key Vault configuration provider is implicitly used to retrieve the database username and password:

        ```csharp
        connBuilder.UserID = context.Configuration["DbUsername"];
        connBuilder.Password = context.Configuration["DbPassword"];
        ```

    * The database username and password are injected into the connection string stored in *appsettings.json*.
    * The EF Core database context class, named `ContosoPetsAuth`, is configured with the appropriate connection string.
    * The Identity services are registered, including the default UI (based on Bootstrap version 4), token providers, and cookie-based authentication.

1. Also in *IdentityHostingStartup.cs*, add the following code to the block of `using` statements at the top. Save your changes.

    ::: zone pivot="pg"

    ```csharp
    using Npgsql;
    ```

    The preceding code resolves the reference to the `NpgsqlConnectionStringBuilder` class in the `Configure` method.

    ::: zone-end

    ::: zone pivot="sql"

    ```csharp
    using System.Data.SqlClient;
    ```

    The preceding code resolves the reference to the `SqlConnectionStringBuilder` class in the `Configure` method.

    ::: zone-end

1. In the `Configure` method of *Startup.cs*, replace the `// Add the app.UseAuthentication code` comment with the following code. Save your changes.

    ```csharp
    app.UseAuthentication();
    ```

1. Run the following command to print the database connection string to the console:

    ```bash
    echo $dbConnectionString
    ```

1. In *:::no-loc text="appsettings.json":::*, replace the connection string for `ContosoPetsAuthConnection` with the connection string from the previous step. Save your changes. 

    The `ConnectionStrings` section should look similar to the following JSON:

    ::: zone pivot="pg"

    ```json
    "ConnectionStrings": {
        "ContosoPetsAuthConnection": "Server={HOST NAME}.postgres.database.azure.com;Database=contosopets;Port=5432;Ssl Mode=Require;"
    }
    ```

    ::: zone-end

    ::: zone pivot="sql"

    ```json
    "ConnectionStrings": {
        "ContosoPetsAuthConnection": "Data Source={HOST NAME}.database.windows.net;Initial Catalog=ContosoPets;Connect Timeout=30;Encrypt=True;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False"
    }
    ```

    ::: zone-end

1. [!INCLUDE[dotnet build command](../../includes/dotnet-build-command.md)]

## Update the database

1. Create and run an EF Core migration to update the database:

    ```bash
    dotnet ef migrations add CreateIdentitySchema && \
        dotnet ef database update
    ```

1. Run the following command to list the tables in the database:

    ::: zone pivot="pg"

    ```bash
    db -c "SELECT tablename FROM pg_catalog.pg_tables WHERE schemaname != 'pg_catalog' AND schemaname != 'information_schema' ORDER BY tablename"
    ```

    The following output appears, which confirms the creation of the tables.

    ```console
           tablename
    -----------------------
     AspNetRoleClaims
     AspNetRoles
     AspNetUserClaims
     AspNetUserLogins
     AspNetUserRoles
     AspNetUserTokens
     AspNetUsers
     __EFMigrationsHistory
    (8 rows)
    ```

    ::: zone-end

    ::: zone pivot="sql"

    ```bash
    db -Q "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='dbo' ORDER BY TABLE_NAME" -Y 25
    ```

    The following output appears, which confirms the creation of the tables.

    ```console
    TABLE_NAME
    -------------------------
    __EFMigrationsHistory
    AspNetRoleClaims
    AspNetRoles
    AspNetUserClaims
    AspNetUserLogins
    AspNetUserRoles
    AspNetUsers
    AspNetUserTokens

    (8 rows affected)
    ```

    ::: zone-end

## Add the login and registration link

1. In *Pages/Shared/_Layout.cshtml*, replace the `@* Add the _LoginPartial partial view *@` comment with the following. Save your changes.

    ```cshtml
    <partial name="_LoginPartial" />
    ```

1. [!INCLUDE[dotnet build command](../../includes/dotnet-build-command.md)]

1. Deploy the app to Azure App Service by running the following command:

    ```bash
    az webapp up
    ```

    > [!NOTE]
    > The *.azure/config* file in the project root contains the configuration values used by `az webapp up`.

1. Run the following command to view the app's URL. Navigate to that URL in your browser.

    ```bash
    echo $webAppUrl
    ```

1. Click the **Register** link in the app's header. Complete the form to create a new account.

    After successful registration, notice that you're redirected back to the homepage. The app's header displays your email address and a **Logout** link.
