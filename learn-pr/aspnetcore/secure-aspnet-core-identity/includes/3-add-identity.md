## Add Identity to the project

1. Install the ASP.NET Core code scaffolder:

    ```bash
    dotnet tool install -g dotnet-aspnet-codegenerator
    ```

    The scaffolder is a .NET Core global tool which will be used to add the Identity components to the project.

1. Add the following NuGet package to the project:

    ```bash
    dotnet add package Microsoft.VisualStudio.Web.CodeGeneration.Design
    ```

    The package installs code generation templates which are used by the `dotnet-aspnet-codegenerator` tool.

    > [!TIP]
    > To view the available generators:
    > 
    > * In the command shell, run `dotnet aspnet-codegenerator -h`.
    > * In Visual Studio, right-click the project in **Solution Explorer** and select **Add** > **New Scaffolded Item**.

1. Add the Identity components to the project. Run the following command from the project root:

    ```bash
    dotnet aspnet-codegenerator identity \
        --useDefaultUI \
        --dbContext ContosoPetsAuth
    ```

    In the preceding command:

    * The generator identified as `identity` is used to add Identity framework to the project.
    * The `--useDefaultUI` option indicates that a Razor Class Library containing the default UI elements will be used. Bootstrap version 3 will be used to style the components.
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

    ::: zone-end

    ::: zone pivot="sql"

    ```csharp
    public void Configure(IWebHostBuilder builder)
    {
        builder.ConfigureServices((context, services) => {
            var sqlConnBuilder = new SqlConnectionStringBuilder(
                context.Configuration.GetConnectionString("ContosoPetsAuthConnection"));
            sqlConnBuilder.UserID = context.Configuration["DbUsername"];
            sqlConnBuilder.Password = context.Configuration["DbPassword"];

            services.AddDbContext<ContosoPetsAuth>(options =>
                options.UseSqlServer(sqlConnBuilder.ConnectionString));

            services.AddDefaultIdentity<IdentityUser>()
                .AddDefaultUI(UIFramework.Bootstrap4)
                .AddEntityFrameworkStores<ContosoPetsAuth>();
        });
    }
    ```

    ::: zone-end

    In the preceding code:

    * The Azure Key Vault Configuration provider is used to retrieve the database username and password.
    * The database username and password are injected into the connection string stored in *appsettings.json*.
    * The EF Core database context class, named `ContosoPetsAuth`, is configured with the appropriate connection string.
    * The ASP.NET Core Identity services are registered, including the default UI (based on Bootstrap version 4), token providers, and cookie-based authentication.

1. In *IdentityHostingStartup.cs*, add the following code to the block of `using` statements at the top. Save your changes.

    ::: zone pivot="pg"

    ::: zone-end

    ::: zone pivot="sql"

    ```csharp
    using System.Data.SqlClient;
    ```

    The preceding code resolves the reference to the `SqlConnectionStringBuilder` class referenced in the `Configure` method.

    ::: zone-end

1. In the `Configure` method of *Startup.cs*, replace the `// Add the app.UseAuthentication code` comment with the following:

    ```csharp
    app.UseAuthentication();
    ```

    Save your changes.

1. Run the following command to print the database connection string to the console:

    ::: zone pivot="pg"

    ::: zone-end

    ::: zone pivot="sql"

    ```bash
    echo $sqlConnectionString
    ```

    ::: zone-end

1. In *:::no-loc text="appsettings.json":::*, replace the connection string for `ContosoPetsAuthConnection` with the connection string from the previous step. The `ConnectionStrings` section should look similar to the following:

    ::: zone pivot="pg"

    ::: zone-end

    ::: zone pivot="sql"

    ```json
    "ConnectionStrings": {
        "ContosoPetsAuthConnection": "Data Source={HOST NAME}.database.windows.net;Initial Catalog=ContosoPets;Connect Timeout=30;Encrypt=True;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False"
    }
    ```

    ::: zone-end

    Save your changes.

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
    db -c "SELECT tablename FROM pg_catalog.pg_tables WHERE schemaname != 'pg_catalog' AND schemaname != 'information_schema'"
    ```

    The following output appears, which confirms the creation of the tables.

    ```console
     tablename 
    -----------
    ToDo
    ToDo
    ToDo
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

1. Deploy the site by running the following command:

    ```bash
    az webapp up
    ```

    The preceding command deploys the app to Azure App Service. The *.azure/config* file contains the configuration values used by `az webapp up`.

1. Run the following command to see the app's URL. Navigate to that URL in your browser.

    ```bash
    echo $webAppUrl
    ```

1. Click the **Register** link in the app's header. Complete the form to create a new account.

    After successful registration, notice that you're redirected back to the homepage. The app's header displays your email address and a **Logout** link.
