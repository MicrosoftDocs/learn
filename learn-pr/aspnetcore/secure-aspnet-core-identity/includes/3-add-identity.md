Identity works out-of-the-box without any customization. In this unit, Identity will be added to an existing ASP.NET Core Razor Pages project.

## Obtain and open the starter project

> [!NOTE]
> If you wish to use the `.devcontainer` in GitHub Codespaces, navigate to the [source repository codespaces](https://github.com/MicrosoftDocs/mslearn-secure-aspnet-core-identity/codespaces). Create a new codespace using the `main` branch, and then skip to step 3.

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

1. After the project loads (either locally or in the container), press <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>`</kbd> to open a new terminal pane.
1. In the new terminal pane, set your location to the *RazorPagesPizza* directory:

    ```bash
    cd RazorPagesPizza
    ```

## Explore the app

1. In the terminal pane, build the project and run the app:

    ```dotnetcli
    dotnet run
    ```

1. Note the HTTPS URL displayed in the terminal output, e.g. `https://localhost:7192`.
1. Open the app in your browser by selecting the URL with <kbd>Ctrl</kbd>+*click*.

    > [!IMPORTANT]
    > If you're using the *.devcontainer* in Docker, the SSL certificate from inside the container won't be trusted by your browser. To view the web app, you must do **one** of the following:
    >
    > * Ignore the certificate error. If using Microsoft Edge, select **Advanced** and **Continue to localhost (not recommended)**. Details vary by browser.
    > * Save the certificate and add it to your trusted certificate authorities.
    > * Import an existing development certificate inside the container. For more details, see the generated comments in *./devcontainer/devcontainter.json*.
    >
    > If you choose to import an existing development certificate inside the container, the container path */root/.aspnet/* is exposed as *.devcontainer\persisted-data\.aspnet* outside the container. This is for your convenience.
    >
    > If you're using the *.devcontainer* in GitHub Codespaces, no action is required. Codespaces handles the proxy SSL connection automatically.

1. Explore the web app in the browser. Using the links on the header:
    1. Navigate to **Pizza List**
    1. Navigate back **Home**

    Notice that you are not required to authenticate.

1. Press <kbd>Ctrl</kbd>+<kbd>C</kbd> in the terminal pane to stop the app.

## Add ASP.NET Core Identity to the project

1. Install the ASP.NET Core code scaffolder:

    ```dotnetcli
    dotnet tool install dotnet-aspnet-codegenerator --version 6.0.2 --global
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

1. Use the scaffolder to add the default Identity components to the project. Run the following command in the terminal:

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

    > [!TIP]
    > If the *:::no-loc text="Areas":::* directory doesn't appear in the Explorer pane automatically, select the **Refresh Explorer** button at the top of the **Explorer** pane.

    Areas provide a way to partition an ASP.NET Core web app into smaller functional groups.

    The scaffolder also made changes to *Program.cs* as highlighted below (reformatted for readability):

    [!code-csharp[](../code/program.cs?highlight=1-3,5-8,27)]

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

    This connection string points to an instance of SQL Server Express LocalDB by default. **If you are using the *.devcontainer***, change the connection string as follows:

    ```json
    "ConnectionStrings": {
        "RazorPagesPizzaIdentityDbContextConnection": "Data Source=localhost;Initial Catalog=RazorPagesPizza;Integrated Security=False;User Id=sa;Password=P@ssw0rd;MultipleActiveResultSets=True"
    }
    ```

    This updates the connection string to connect to the instance of SQL Server inside the container.

## Update the database

1. [!INCLUDE[dotnet build command](../../includes/dotnet-build-command.md)]
1. Install the Entity Framework Core migration tool:

    ```dotnetcli
    dotnet tool install dotnet-ef --version 6.0.2 --global
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

    The `CreateIdentitySchema` EF Core migration applied a Data Definition Language (DDL) change script to create the tables supporting Identity. For example, the following output depicts a `CREATE TABLE` statement generated by the migration:

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

1. The SQL Server extension was added to Visual Studio Code (if needed) when you accepted the recommended extensions. Press <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>D</kbd> to switch to the SQL Server pane.
1. Expand the nodes under the existing database connection. Expand the **Databases** node, the **RazorPagesPizza** node, and finally the **Tables** node. Note the list of tables. This confirms the migration succeeded.

    :::image type="content" source="../media/sql-server-successful-migration.png" alt-text="The RazorPagesPizza database with the newly created tables." lightbox="../media/sql-server-successful-migration.png":::

    > [!NOTE]
    > The image above shows an example using SQL Server Express LocalDB. When using the *.devcontainer*, the top node will display **mssql-container**.

## Add the login and registration links

1. In *:::no-loc text="Pages/Shared/_Layout.cshtml":::*, replace the `@* Add the _LoginPartial partial view *@` comment with the following.

    ```cshtml
    <partial name="_LoginPartial" />
    ```

    The preceding markup renders the `_LoginPartial` partial view within the header of any page that uses the default layout. `_LoginPartial` was added by the Identity scaffold. This partial view presents the user with **Login** and **Register** links if the user isn't signed in.

## Test changes

1. Make sure you've saved all your changes.
1. In the terminal pane, build the project and run the app:

    ```dotnetcli
    dotnet run
    ```

1. Navigate to the app in your browser as before.
1. Click the **Register** link in the app's header. Complete the form to create a new account.

    The **Register confirmation** page is displayed. Since the app hasn't yet been configured to send confirmation emails, the confirmation link is provided on this page.

1. Click the confirmation link. A confirmation message is displayed.
1. Click the **Login** link in the app's header and log in.

    After a successful login:

    * You're redirected to the homepage.
    * The app's header displays **Hello [Email address]!** and a **Logout** link.
    * A cookie named *:::no-loc text=".AspNetCore.Identity.Application":::* is created. Identity preserves user sessions with cookie-based authentication.

1. Click the **Logout** link in the app's header.

    After successfully logging out, the *:::no-loc text=".AspNetCore.Identity.Application":::* cookie is deleted to terminate the user session.

1. Press <kbd>Ctrl</kbd>+<kbd>C</kbd> in the terminal pane to stop the app.

## Summary

In this unit, you added the default Identity implementation to an existing web app. In the next unit, you'll learn about extending and customizing Identity.
