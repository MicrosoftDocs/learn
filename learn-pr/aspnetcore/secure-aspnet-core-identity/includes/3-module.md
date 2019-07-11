## Add user registration support

1. Install the ASP.NET Core scaffolder:

    ```bash
    dotnet tool install -g dotnet-aspnet-codegenerator
    ```

1. Add the following NuGet package to the project:

    ```bash
    dotnet add package Microsoft.VisualStudio.Web.CodeGeneration.Design
    ```

1. Add the Identity Razor Class Library to the project. Run the following command from the project root:

    ```bash
    dotnet aspnet-codegenerator identity --useDefaultUI --dbContext ContosoPetsAuth
    ```

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
                .AddEntityFrameworkStores<ContosoPetsAuth>();
        });
    }
    ```

    ::: zone-end

    In the preceding code:

    * The Azure Key Vault Configuration provider is used to retrieve the database username and password.
    * The database username and password are injected into the connection string stored in *appsettings.json*.
    * The Entity Framework Core database context class, named `ContosoPetsAuth`, is configured with the appropriate connection string.
    * The ASP.NET Core Identity services are registered, including the default UI, token providers, and cookie-based authentication.

1. In *IdentityHostingStartup.cs*, add the following code to the block of `using` statements at the top:

    ::: zone pivot="pg"

    ::: zone-end

    ::: zone pivot="sql"

    ```csharp
    using System.Data.SqlClient;
    ```

    The preceding code resolves the reference to the `SqlConnectionStringBuilder` class referenced in the `Configure` method.

    ::: zone-end

1. In the `Configure` method of *Startup.cs* in *ContosoPets.Ui*, replace the `// Add the app.UseAuthentication statement` comment with the following:

    ```csharp
    app.UseAuthentication();
    ```

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
        "ContosoPetsAuthConnection": "Data Source=azsql684457488.database.windows.net;Initial Catalog=ContosoPets;Connect Timeout=30;Encrypt=True;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False"
    }
    ```

    ::: zone-end
    
    Save your changes.

1. Create and run an EF Migration to update the database:

    ```bash
    dotnet ef migrations add CreateIdentitySchema && \
        dotnet ef database update
    ```

    ::: zone pivot="pg"
    
    ```bash
    dotnet add package Npgsql.EntityFrameworkCore.PostgreSQL
    ```
    
    ::: zone-end
    
    ::: zone pivot="sql"
    
    
    
    ::: zone-end
    
    ::: zone pivot="pg"

    ```bash
    db -c "SELECT tablename FROM pg_catalog.pg_tables WHERE schemaname != 'pg_catalog' AND schemaname != 'information_schema'"
    ```
    
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
    