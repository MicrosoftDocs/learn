## Add Identity to the project

1. Install the ASP.NET Core code scaffolder:

    ```bash
    dotnet tool install -g dotnet-aspnet-codegenerator
    ```

    The scaffolder will be used to add the Identity components to the project.

1. Add the following NuGet package to the project:

    ```bash
    dotnet add package Microsoft.VisualStudio.Web.CodeGeneration.Design
    ```

1. Add the Identity Razor Class Library to the project. Run the following command from the project root:

    ```bash
    dotnet aspnet-codegenerator identity \
        --useDefaultUI \
        --dbContext ContosoPetsAuth
    ```

1. [!INCLUDE[refresh file explorer](../../includes/refresh-file-explorer.md)]

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
    * The Entity Framework Core database context class, named `ContosoPetsAuth`, is configured with the appropriate connection string.
    * The ASP.NET Core Identity services are registered, including the default UI (based on Bootstrap version 4), token providers, and cookie-based authentication.

1. In *IdentityHostingStartup.cs*, add the following code to the block of `using` statements at the top:

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

1. [!INCLUDE[dotnet build command](../../includes/dotnet-build-command.md)]

## Update the database

1. Create and run an EF Migration to update the database:

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

## Customize the user account data

By default, Identity represents a user with an `IdentityUser` class. One way to extend the data being captured at registration time is to create a class deriving from `IdentityUser`. UI changes are also required to collect the additional user profile information. The following steps explain the process of collecting a first and last name for the registered user.

1. Add the user registration files to the project:

    ```bash
    dotnet aspnet-codegenerator identity \
        --dbContext ContosoPetsAuth \
        --files "Account.Manage.Index;Account.Register" \
        --userClass ContosoPetsUser \
        --force
    ```

    The preceding command adds the following files to the *Areas/Identity* directory:

    * *Data/ContosoPetsUser.cs*
    * *Pages/Account/Manage/_ManageNav.cshtml*
    * *Pages/Account/Manage/_ViewImports_.cshtml*
    * *Pages/Account/Manage/Index.cshtml*
    * *Pages/Account/Manage/Index.cshtml.cs*
    * *Pages/Account/Manage/ManageNavPages.cs*
    * *Pages/Account/Register.cshtml*
    * *Pages/Account/Register.cshtml.cs*

    Additionally, the *Data/ContosoPetsAuth.cs* file, which existed prior to running the preceding command, was overwritten. *ContosoPetsAuth.cs* now references the newly created `ContosoPetsUser` class.

1. Make the following changes to *Pages/Shared/_LoginPartial.cshtml*:

    * Add `@using ContosoPets.Ui.Areas.Identity.Data` to the top.
    * Change `@inject SignInManager<IdentityUser> SignInManager` to `@inject SignInManager<ContosoPetsUser> SignInManager`.
    * Change `@inject UserManager<IdentityUser> UserManager` to `@inject UserManager<ContosoPetsUser> UserManager`.

    The preceding step created the `ContosoPetsUser` class, which is to be used instead of the default `IdentityUser`. *Pages/Shared/_LoginPartial.cshtml* wasn't updated automatically, so the appropriate changes must be made by hand.

    > [!TIP]
    > As an alternative to manually editing the *_LoginPartial.cshtml* file, it can be deleted prior to running the scaffold tool. The *_LoginPartial.cshtml* file will be recreated with references to the new `ContosoPetsUser` class.

1. Update *ContosoPetsUser.cs* so that it supports storage and retrieval of the additional user profile data. Add the following properties:

    ```csharp
    [Required]
    [MaxLength(100)]
    public string FirstName { get; set; }

    [Required]
    [MaxLength(100)]
    public string LastName { get; set; }
    ```

    The properties in the preceding snippet represent additional columns to be created in the underlying `AspNetUsers` table.

1. Add the following `using` statement to the top of *ContosoPetsUser.cs*:

    ```csharp
    using System.ComponentModel.DataAnnotations;
    ```

    The preceding resolves the data annotation attributes in the previous step.

1. In *Register.cshtml*, add the following markup to the line after `<div asp-validation-summary="All" class="text-danger"></div>`:

    ```cshtml
    <div class="form-group">
        <label asp-for="Input.FirstName"></label>
        <input asp-for="Input.FirstName" class="form-control" />
        <span asp-validation-for="Input.FirstName" class="text-danger"></span>
    </div>
    <div class="form-group">
        <label asp-for="Input.LastName"></label>
        <input asp-for="Input.LastName" class="form-control" />
        <span asp-validation-for="Input.LastName" class="text-danger"></span>
    </div>
    ```

    With the preceding markup, a **First Name** and a **Last Name** text box are added to the user registration form.

1. In *Register.cshtml.cs*, add the following code to support the name text boxes.
    1. Add the following properties to the `InputModel` class:

    ```csharp
    [Required]
    [StringLength(100, ErrorMessage = "The {0} must be at least {2} and at max {1} characters long.", MinimumLength = 1)]
    [Display(Name = "First Name")]
    public string FirstName { get; set; }

    [Required]
    [StringLength(100, ErrorMessage = "The {0} must be at least {2} and at max {1} characters long.", MinimumLength = 1)]
    [Display(Name = "Last Name")]
    public string LastName { get; set; }
    ```

    1. Modify the `OnPostAsync` method such that the `user` variable is assigned to the following:

    ```csharp
    var user = new ContosoPetsUser
    {
        FirstName = Input.FirstName,
        LastName = Input.LastName,
        UserName = Input.Email,
        Email = Input.Email,
    };
    ```

1. <!--TODO: Explain changes to Manage Index page -->

1. <!--TODO: Run migration before deploy -->