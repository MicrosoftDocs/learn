Identity works out-of-the-box without any customization. The standard Identity UI components are packaged in a .NET Standard Razor Class Library (RCL). Because an RCL is used, few files are added to the project.

In this unit, Identity will be added to an existing ASP.NET Core Razor Pages project.

## Obtain and open the starter project

1. In a terminal window, run the following command to obtain the starter project:

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-secure-aspnet-core-identity
    ```

2. Switch to the source code directory and launch Visual Studio Code:

    ```bash
    cd mslearn-secure-aspnet-core-identity
    code .
    ```

    Visual Studio Code opens. Accept any prompts to install recommended extensions, or select **Reopen in Container** if you wish to use the *.devcontainer*.

    > [!TIP]
    > If you miss the prompt to reopen in container, press <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd> to open the command palette, and then search for and select **Remote-Containers: Reopen in Container**.

3. After the project loads (either locally or in the container), press <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>`</kbd> to open a new terminal window.
4. Set your location to the *RazorPagesPizza* directory:

    ```bash
    cd RazorPagesPizza
    ```

5. Build the project:

    ```dotnetcli
    dotnet build
    ```

## Add ASP.NET Core Identity to the project

1. Install the ASP.NET Core code scaffolder:

    ```dotnetcli
    dotnet tool install dotnet-aspnet-codegenerator --version 6.0.2
    ```

    The following output appears:

    ```console
    You can invoke the tool from this directory using the following commands: 'dotnet tool run dotnet-aspnet-codegenerator' or 'dotnet dotnet-aspnet-codegenerator'.
    Tool 'dotnet-aspnet-codegenerator' (version '3.1.2') was successfully installed. Entry is added to the manifest file /home/<USER>/aspnet-learn/src/ContosoPets.Ui/.config/dotnet-tools.json.
    ```

    The scaffolder is a .NET Core tool that will:

    * Be used to add the default Identity components to the project.
    * Enable customization of Identity UI components in the next unit.
    * Be invoked via `dotnet aspnet-codegenerator` in this module.

1. Add the following NuGet packages to the project:

    ```dotnetcli
    dotnet add package Microsoft.VisualStudio.Web.CodeGeneration.Design --version 3.1.2
    dotnet add package Microsoft.AspNetCore.Identity.EntityFrameworkCore --version 3.1.3
    dotnet add package Microsoft.AspNetCore.Identity.UI --version 3.1.3
    dotnet add package Microsoft.EntityFrameworkCore.Design --version 3.1.3
    dotnet add package Microsoft.EntityFrameworkCore.SqlServer --version 3.1.3
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

## Configure the database connection

1. In the `Configure` method of *:::no-loc text="Startup.cs":::*, replace the `// Add the app.UseAuthentication code` comment with the following code. Save your changes.

    ```csharp
    app.UseAuthentication();
    ```

    The preceding code enables authentication capabilities. More specifically, an instance of the ASP.NET Core authentication middleware is added to the app's HTTP request-handling pipeline.

1. Run the following command to print the database connection string to the console. Copy the connection string to your clipboard.

    ```bash
    echo $dbConnectionString
    ```

1. In *:::no-loc text="appsettings.json":::*, replace the connection string for `ContosoPetsAuthConnection` with the connection string from the previous step. Save your changes.

    The `ConnectionStrings` section should look similar to the following JSON:

    ```json
    "ConnectionStrings": {
        "ContosoPetsAuthConnection": "Data Source={HOST NAME}.database.windows.net;Initial Catalog=ContosoPets;Connect Timeout=30;Encrypt=True;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False"
    }
    ```

1. [!INCLUDE[dotnet build command](../../includes/dotnet-build-command.md)]

## Update the database

1. Install the Entity Framework Core migration tool:

    ```dotnetcli
    dotnet tool install dotnet-ef --version 3.1.3
    ```

    The following output appears:

    ```console
    You can invoke the tool from this directory using the following commands: 'dotnet tool run dotnet-ef' or 'dotnet dotnet-ef'.
    Tool 'dotnet-ef' (version '3.1.3') was successfully installed. Entry is added to the manifest file /home/<USER>/aspnet-learn/src/ContosoPets.Ui/.config/dotnet-tools.json.
    ```

    The migration tool is a .NET Core tool that will:

    * Generate code called a migration to create and update the database that supports the Identity entity model.
    * Execute migrations against an existing database.
    * Be invoked via `dotnet ef` in this module.

1. Create and run an EF Core migration to update the database:

    ```dotnetcli
    dotnet ef migrations add CreateIdentitySchema && \
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
