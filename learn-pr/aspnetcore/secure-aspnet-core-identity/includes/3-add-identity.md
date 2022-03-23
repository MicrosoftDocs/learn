Identity works out-of-the-box without any customization. The standard Identity UI components are packaged in a .NET Standard Razor Class Library (RCL). Because an RCL is used, few files are added to the project.

In this unit, Identity will be added to an existing ASP.NET Core Razor Pages project.

## Obtain and open the starter project

1. In a terminal window, run the following command to obtain the starter project:

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-secure-aspnet-core-identity
    ```

1. Switch to the source code directory and launch Visual Studio Code:

    ```bash
    cd mslearn-secure-aspnet-core-identity
    code .
    ```

    Visual Studio Code opens. Accept any prompts to install recommended extensions, or select **Reopen in Container** if you wish to use the *.devcontainer*.

    > [!TIP]
    > If you miss the prompt to reopen in container, press <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd> to open the command palette, and then search for and select **Remote-Containers: Reopen in Container**.

1. After the project loads (either locally or in the container), press <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>`</kbd> to open a new terminal window.
1. Set your location to the *RazorPagesPizza* directory:

    ```bash
    cd RazorPagesPizza
    ```

## Explore the app

1. Build the project and run the app:

    ```dotnetcli
    dotnet build
    ```

The app is an ASP.NET Core Razor Pages web app. There is cu



## Add ASP.NET Core Identity to the project

1. Install the ASP.NET Core code scaffolder:

    ```dotnetcli
    dotnet tool install dotnet-aspnet-codegenerator --version 6.0.2
    ```

    The scaffolder is a .NET Core tool that will:

    * Be used to add the default Identity components to the project.
    * Enable customization of Identity UI components in the next unit.
    * Be invoked via `dotnet aspnet-codegenerator` in this module.

1. Add the following NuGet packages to the project:

    ```dotnetcli
    dotnet add package Microsoft.VisualStudio.Web.CodeGeneration.Design --version 6.0.2
    dotnet add package Microsoft.AspNetCore.Identity.EntityFrameworkCore --version 6.0.3
    dotnet add package Microsoft.AspNetCore.Identity.UI --version 6.0.3
    dotnet add package Microsoft.EntityFrameworkCore.Design --version 6.0.3
    dotnet add package Microsoft.EntityFrameworkCore.SqlServer --version 6.0.3
    ```

    These packages install code generation templates and dependencies that are used by the scaffolder.

    > [!TIP]
    > To view the available generators:
    >
    > * In the command shell, run `dotnet aspnet-codegenerator -h`.
    > * When in Visual Studio, right-click the project in **Solution Explorer** and select **Add** > **New Scaffolded Item**.

1. Use the scaffolder to add the default Identity components to the project. Run the following command from the project root:

    ```dotnetcli
    dotnet aspnet-codegenerator identity --useDefaultUI --dbContext RazorPagesPizzaAuth
    ```

    In the preceding command:

    * The generator identified as `identity` is used to add the Identity framework to the project.
    * The `--useDefaultUI` option indicates that an RCL containing the default UI elements will be used. Bootstrap will be used to style the components.
    * The `--dbContext` option to indicate the name of an EF Core database context class to generate.

    An *:::no-loc text="Areas":::* directory structure appears in the project root:

    * *:::no-loc text="Areas":::*
        * *:::no-loc text="Identity":::*
            * *:::no-loc text="Data":::*
                * *:::no-loc text="RazorPagesPizzaAuth.cs":::*
            * *:::no-loc text="Pages":::*
                * *:::no-loc text="_ValidationScriptsPartial.cshtml":::*
                * *:::no-loc text="_ViewStart.cshtml":::*

    > [!NOTE]
    > If the *:::no-loc text="Areas":::* directory doesn't appear in the Explorer pane automatically, select the **Refresh Explorer** button.

    Areas provide a way to partition an ASP.NET Core web app into smaller functional groups.

    The scaffolder also made changes to *Program.cs*, as highlighted below (reformatted for readability):

    [!code-cshtml[](../code/program.cs?highlight=1-3,5-7,25)]

    In the preceding code:

    * The `RazorPagesPizzaAuthConnection` connection string is read from *appsettings.json*.
    * The EF Core database context class, named `RazorPagesPizzaAuth`, is configured with the connection string.
    * The Identity services are registered, including the default UI, token providers, and cookie-based authentication.
        * `.AddDefaultIdentity<IdentityUser>` tells the Identity services to use the default user model.
        * The lambda expression `options => options.SignIn.RequireConfirmedAccount = true` specifies that users must confirm their email accounts.
        * `.AddEntityFrameworkStores<RazorPagesPizzaAuth>()` specifies that Identity uses the default Entity Framework Core store for its database. The `RazorPagesPizzaAuth` `DbContext` class is used.
    * `app.UseAuthentication();` enables authentication capabilities. More specifically, an instance of the ASP.NET Core authentication middleware is added to the app's HTTP request-handling pipeline.

## Configure the database connection

1. Review *:::no-loc text="appsettings.json":::*.

    The `ConnectionStrings` section should look similar to the following JSON:

    ```json
    "ConnectionStrings": {
        "RazorPagesPizzaAuthConnection": "Server=(localdb)\\mssqllocaldb;Database=RazorPagesPizza;Trusted_Connection=True;MultipleActiveResultSets=true"
    }
    ```

1. **If you are using the *.devcontainer***, change the connection string as appears below:

    ```json
    "ConnectionStrings": {
        "RazorPagesPizzaIdentityDbContextConnection": "Data Source=localhost;Initial Catalog=RazorPagesPizza;Integrated Security=False;User Id=sa;Password=P@ssw0rd;MultipleActiveResultSets=True"
    }
    ```

    This updates the connection string to connect to the instance of SQL Server in the container.

## Update the database

1. [!INCLUDE[dotnet build command](../../includes/dotnet-build-command.md)]
1. Install the Entity Framework Core migration tool:

    ```dotnetcli
    dotnet tool install dotnet-ef --version 6.0.2 -g
    ```

    The migration tool is a .NET Core tool that will:

    * Generate code called a migration to create and update the database that supports the Identity entity model.
    * Execute migrations against an existing database.
    * Be invoked via `dotnet ef` in this module.

1. Create and run an EF Core migration to update the database:

    ```dotnetcli
    dotnet ef migrations add CreateIdentitySchema
    dotnet ef database update
    ```

    The `CreateIdentitySchema` EF Core migration applied a Data Definition Language (DDL) change script to create the tables supporting Identity. For example, the following excerpt depicts a `CREATE TABLE` statement generated by the migration:

    ```console
    info: Microsoft.EntityFrameworkCore.Database.Command[20101]
          Executed DbCommand (98ms) [Parameters=[], CommandType='Text', CommandTimeout='30']
          CREATE TABLE [AspNetUsers] (
              [Id] nvarchar(450) NOT NULL,
              [UserName] nvarchar(256) NULL,
              [NormalizedUserName] nvarchar(256) NULL,
              [Email] nvarchar(256) NULL,
              [NormalizedEmail] nvarchar(256) NULL,
              [EmailConfirmed] bit NOT NULL,
              [PasswordHash] nvarchar(max) NULL,
              [SecurityStamp] nvarchar(max) NULL,
              [ConcurrencyStamp] nvarchar(max) NULL,
              [PhoneNumber] nvarchar(max) NULL,
              [PhoneNumberConfirmed] bit NOT NULL,
              [TwoFactorEnabled] bit NOT NULL,
              [LockoutEnd] datetimeoffset NULL,
              [LockoutEnabled] bit NOT NULL,
              [AccessFailedCount] int NOT NULL,
              CONSTRAINT [PK_AspNetUsers] PRIMARY KEY ([Id])
          );
    ```

1. Run the following command to list the tables in the database:

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

## Add the login and registration links

1. In *:::no-loc text="Pages/Shared/_Layout.cshtml":::*, replace the `@* Add the _LoginPartial partial view *@` comment with the following. Save your changes.

    ```cshtml
    <partial name="_LoginPartial" />
    ```

    The preceding markup renders the `_LoginPartial` partial view within the header of any page that uses the default layout. `_LoginPartial` was added by the Identity scaffold. This partial view presents the user with **Login** and **Register** links if the user isn't signed in.

1. [!INCLUDE[dotnet build command](../../includes/dotnet-build-no-restore-command.md)]

1. [!INCLUDE[az webapp up command](../../includes/az-webapp-up-command.md)]

    > [!NOTE]
    > The *:::no-loc text=".azure/config":::* file in the project root contains the configuration values used by `az webapp up`.

1. Run the following command to view the app's URL. Navigate to that URL in your browser.

    ```bash
    echo $webAppUrl
    ```

1. Click the **Register** link in the app's header. Complete the form to create a new account.

    After successful registration:

    * You're redirected to the homepage.
    * The app's header displays **Hello [Email address]!** and a **Logout** link.
    * A cookie named *:::no-loc text=".AspNetCore.Identity.Application":::* is created. Identity preserves user sessions with cookie-based authentication.

1. Click the **Logout** link in the app's header.

    After successfully logging out, the *:::no-loc text=".AspNetCore.Identity.Application":::* cookie is deleted to terminate the user session.
